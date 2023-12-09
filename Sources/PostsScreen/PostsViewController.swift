import UIKit

final class PostsViewController: UITableViewController, PostsViewModelDeledate {

    let viewModel = PostsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostCell")

        viewModel.delegate = self
        viewModel.loadPosts()
    }

    func reloadUI() {
        tableView.reloadData()
    }
}

extension PostsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell ?? PostCell()
        let post = viewModel.posts[indexPath.row]

        cell.configure(with: post)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = viewModel.posts[indexPath.row]

        let storyboard = UIStoryboard(name: "PostStoryboard", bundle: nil)
        let postVC = storyboard.instantiateViewController(withIdentifier: "Post") as! DetailPostViewController

        postVC.viewModel.changeUIForState = { [weak postVC] state in
            postVC?.changeUI(for: state)
        }
        postVC.viewModel.loadPost(id: selectedPost.id)
        postVC.viewModel.postTitle = selectedPost.title

        navigationController?.pushViewController(postVC, animated: true)
    }

}


import UIKit

final class PostsViewController: UITableViewController, PostsViewModelDeledate {

    @IBOutlet weak var menuButtonItem: UIBarButtonItem!
    
    let viewModel = PostsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

        let nib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostCell")

        configureButtonMenu()
        viewModel.delegate = self
        viewModel.viewDidLoad()

    }

    func reloadUI() {
        tableView.reloadData()
    }

    func configureButtonMenu() {
        let firstAction = UIAction(title: "date") { [weak self] _ in
            self?.viewModel.sortByDateTapped()
        }

        let secondAction = UIAction(title: "likes") { [weak self] _ in
            self?.viewModel.sortByLikesTapped()
        }

        let menu = UIMenu(title: "Sort by:", children: [firstAction, secondAction])

        menuButtonItem.menu = menu
    }
}

extension PostsViewController: PostCellDelegate {

    func postCellDidChangeHeight(_ cell: PostCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
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
        cell.delegate = self

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
        postVC.viewModel.postLikes = String(selectedPost.likes)
        postVC.viewModel.timestamp = selectedPost.timestamp

        navigationController?.pushViewController(postVC, animated: true)
    }
}

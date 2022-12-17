import UIKit

final class GiphyViewController: UIViewController {
    @IBOutlet weak var giphyImageView: UIImageView!
    @IBOutlet weak var giphyActivityIndicatorView: UIActivityIndicatorView!

    @IBAction func onYesButtonTapped() {
        presenter.saveGif(giphyImageView.image)
        presenter.fetchNextGiphy()

    }

    @IBAction func onNoButtonTapped() {
        presenter.fetchNextGiphy()
    }

    private lazy var presenter: GiphyPresenterProtocol = {
        let presenter = GiphyPresenter()
        presenter.viewController = self
        return presenter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.fetchNextGiphy()
    }
}

// MARK: - GiphyViewControllerProtocol

extension GiphyViewController: GiphyViewControllerProtocol {
    func showError(_ error: GiphyError) {
        let alertController = UIAlertController(
            title: "Ошибка",
            message: "Не удалось загрузить GIF",
            preferredStyle: .alert
        )
        let okAlertAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAlertAction)
        present(alertController, animated: true)
    }

    func showGiphy(_ image: UIImage?) {
        giphyImageView.image = image
    }

    func showLoader() {
        giphyImageView.image = nil
        giphyActivityIndicatorView.startAnimating()
    }

    func hideHoaler() {
        giphyActivityIndicatorView.stopAnimating()
    }
}

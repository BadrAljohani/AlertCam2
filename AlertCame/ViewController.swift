import UIKit

class ViewController: UIViewController ,UIImagePickerControllerDelegate & UINavigationControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource{
    
    var num = 0
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int ) -> Int {
        return arryImage.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath )-> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CustomeCell
        cell.imageCell.image = arryImage[indexPath.row]
        num = indexPath.row
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let show = storyboard?.instantiateViewController(withIdentifier: "showId") as? imageCell
        navigationController?.show(show!, sender: self)
        show?.ShImg = arryImage[indexPath.item]
    }

    var arryImage = [UIImage]()
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraVC.delegate = self
        AlbomCV.dataSource = self
    }
    @IBOutlet weak var AlbomCV: UICollectionView!
    let cameraVC = UIImagePickerController()

    
    
    @IBAction func onTakePhoto(_ sender: UIButton) {

        cameraVC.sourceType = .camera
//        cameraVC.sourceType = .
        cameraVC.allowsEditing = true
        present(cameraVC, animated: true, completion: nil)
    }
    func photoAlert () {
        let alart = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alart.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action in self.getPhoto(type: .camera)}))
        alart.addAction(UIAlertAction(title: "Library", style: .default, handler: {action in self.getPhoto(type: .photoLibrary)}))
        alart.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
        present(alart, animated: true , completion: nil)
    }
    func getPhoto (type:UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    @IBAction func longPress(_ sender: Any) {

        let Alert2 = UIAlertController(title: "Areyou sure to Delete", message: nil, preferredStyle: .alert)
        Alert2.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {action in self.arryImage.remove(at: self.num)
            self.AlbomCV.reloadData()
        }))
        Alert2.addAction(UIAlertAction(title: "No", style: .default, handler: {action in }))
        present(Alert2, animated: true,completion: nil)
    }

    @IBAction func delButton(_ sendrer: Any){
        let Alert = UIAlertController(title: "Are you sure to delete", message: "delete all images", preferredStyle: .alert)
        Alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        Alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {action in
            self.arryImage.removeAll()
            self.AlbomCV.reloadData()
        }))
        present(Alert,animated: true,completion: nil)
    }

    func imagePickerController (_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        info[.originalImage]
        let pic = info[.originalImage] as! UIImage
        arryImage.append(pic)
        print(arryImage)
        AlbomCV.reloadData()
        dismiss(animated: true, completion:nil)
        
        picker.dismiss(animated: true, completion: nil)
    }

}




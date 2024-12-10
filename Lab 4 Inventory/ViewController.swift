//
//  ViewController.swift
//  Lab 4 Inventory
//
//  Created by Ryan Herries on 11/18/24.
//

import UIKit


enum Artists: String {
    case phoebe = "Phoebe Bridgers"
    case Ye = "Kanye West"
    case GOAT = "The Beatles"
    case KDot = "Kendrick Lamar"
    case wildChecy = "Tame Impala"
    case HEHE = "Micheal Jackson"
    case KGold = "Bruno Mars"
    case RHead = "Radiohead"
    case defaultValue = ""
}

let ArtistsList = [Artists.GOAT.rawValue, Artists.phoebe.rawValue, Artists.Ye.rawValue, Artists.KDot.rawValue, Artists.wildChecy.rawValue, Artists.HEHE.rawValue, Artists.KGold.rawValue, Artists.RHead.rawValue, Artists.defaultValue.rawValue]

enum Genre: String {
    case indie = "Indie"
    case rap = "Rap"
    case rock = "Rock"
    case pop = "Pop"
    case defaultValue = ""
}
let GenreList = [Genre.defaultValue.rawValue, Genre.indie.rawValue, Genre.rap.rawValue, Genre.rock.rawValue, Genre.pop.rawValue]

struct song: Hashable {
    let name: String
    let artist: String
    let album: String
    let genre: String
}

let song1 = song(name: "Motion Sickness", artist: Artists.phoebe.rawValue, album: "Stranger in the Alps", genre: Genre.indie.rawValue)
    let song2 = song(name: "Kyoto", artist: Artists.phoebe.rawValue, album: "Punisher", genre: Genre.indie.rawValue)
let song3 = song(name: "Through the Wire", artist: Artists.Ye.rawValue, album: "The College Dropout", genre: Genre.rap.rawValue)
let song4 = song(name: "Something", artist: Artists.GOAT.rawValue, album: "Abbey Road", genre: Genre.rock.rawValue)
let song5 = song(name: "Alright", artist: Artists.KDot.rawValue, album: "To Pimp a Butterfly", genre: Genre.rap.rawValue)
let song6 = song(name: "Apocalypse Dreams", artist: Artists.wildChecy.rawValue, album: "Lonerism", genre: Genre.indie.rawValue)
let song7 = song(name: "Jigsaw Falling Into Place", artist: "Radiohead", album: "In Rainbows", genre: Genre.rock.rawValue)
let song8 = song(name: "Let It Happen", artist: Artists.wildChecy.rawValue, album: "Currents", genre: Genre.indie.rawValue)
    let song9 = song(name: "Beat It", artist: Artists.HEHE.rawValue, album: "Thriller", genre: Genre.pop.rawValue)
let song10 = song(name: "Rock With You", artist: Artists.HEHE.rawValue, album: "Off the Wall", genre: Genre.pop.rawValue)
let song11 = song(name: "Let Down", artist: Artists.RHead.rawValue, album: "OK Computer", genre: Genre.rock.rawValue)
    let song12 = song(name: "All of the Lights", artist: Artists.Ye.rawValue, album: "My Beautiful Dark Twisted Fantasy", genre: Genre.rap.rawValue)
let song13 = song(name: "Eleanor Rigby", artist: Artists.GOAT.rawValue, album: "Revolver", genre: Genre.rock.rawValue)
let song14 = song(name: "Locked Out of Heaven", artist: Artists.KGold.rawValue, album: "Unorthodox Jukebox", genre: Genre.pop.rawValue)
    let song15 = song(name: "That's What I Like", artist: Artists.KGold.rawValue, album: "24K Magic", genre: Genre.pop.rawValue)
    let song16 = song(name: "Swimming Pools (Drank)", artist: Artists.KDot.rawValue, album: "good kid, m.A.A.d city", genre: Genre.rap.rawValue)
let song17 = song(name: "Failed to retrieve song", artist: Artists.defaultValue.rawValue, album: "", genre: Genre.defaultValue.rawValue)

var selectedArtist = ""
var selectedGenre = ""


var songNamesJoined = ""

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var matchingSongs: [song] = []
    var preMatchingSongs: [song] = []
    var songList = [song1, song2, song3, song4, song5, song6, song7, song8, song9, song10, song11, song12, song13, song14, song15, song16]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GenrePicker.delegate = self
        GenrePicker.dataSource = self
        
        ArtistPicker.delegate = self
        ArtistPicker.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    print("there is 1 row")
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == GenrePicker {
            return 5
        } else if pickerView == ArtistPicker {
            return 9
        }else{
            return 1
        }
            
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == GenrePicker {
            return GenreList[row]
        } else if pickerView == ArtistPicker {
            return ArtistsList[row]
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == GenrePicker {
            let selectedGenre = songList[row].genre
            let genreMatchingSongs = songList.filter { $0.genre == selectedGenre}
            preMatchingSongs += genreMatchingSongs
        } else if pickerView == ArtistPicker {
            let selectedArtist = songList[row].artist
            let artistMatchingSongs = songList.filter { $0.artist == selectedArtist}
            preMatchingSongs += artistMatchingSongs
            matchingSongs = Array(Set(preMatchingSongs))
        }
        
    }
   
    @IBAction func SearchOutlet(_ sender: UIButton) {
        let songNames = matchingSongs.map { $0.name }
         songNamesJoined = songNames.joined(separator: " | ")
    
    }
    
    
    
    @IBOutlet var GenrePicker: UIPickerView!
   
    
    @IBOutlet var ArtistPicker: UIPickerView!
    
    


}

class resultsController: UIViewController {
    
    var mainVC = ViewController()
@IBOutlet var SongNameOutlet: UILabel!
    
    func nameLabel(){
        SongNameOutlet.text = songNamesJoined
    }
    
    
    @IBAction func clearButton(_ sender: Any) {
        mainVC.matchingSongs = []
        mainVC.preMatchingSongs = []
        selectedArtist = ""
        selectedGenre = ""
        songNamesJoined = ""
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        nameLabel()
        
        // Do any additional setup after loading the view.
    }
}


class addController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var songListBridge = ViewController()
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return songListBridge.songList.count
    }
    
    func pickerOptions(_ pickerView: UIPickerView, titleForRow row: Int, numberOfRowsInComponent component: Int) -> String? {
        return songListBridge.songList[row].genre
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newSongGenre = songListBridge.songList[row].genre
    }
    
    var newSongGenre: String = ""
    
    @IBOutlet weak var AlbumInput: UITextField!
    
    @IBOutlet weak var ArtistInput: UITextField!
    
    @IBOutlet weak var SongNameInput: UITextField!
    
    @IBAction func AddNewSongs(_ sender: Any) {
        songListBridge.songList.append(song(name: SongNameInput.text!, artist: ArtistInput.text!, album: AlbumInput.text!, genre: newSongGenre))
    }
    
    @IBOutlet weak var GenreAddPicker: UIPickerView!
    
    
    
}

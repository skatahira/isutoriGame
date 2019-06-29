//
//  ViewController.swift
//  isutoriGame
//
//  Created by 片平駿介 on 2019/06/28.
//  Copyright © 2019 ShunsukeKatahira. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    // インスタンス作成
    var player: MPMusicPlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // プレイヤーモードを設定
        player = MPMusicPlayerController.applicationMusicPlayer
        
        // 再生中のItemが変わった時に通知を受け取る
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(
//            self,
//            selector: View.nowPlayingItemChanged(_:),
//            name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: player)
        // 通知の有効化
        player.beginGeneratingPlaybackNotifications()
        
    }
    
    // 再生ボタン押下
    @IBAction func didClickPlayBtn(_ sender: Any) {
        // 5秒から60秒の間のランダムな数字を作成
        let musicStopTime = Double.random(in: 5 ... 60)
        // 音楽を再生する
        player.play()
        // ランダムな秒数経過後に実行する処理
        DispatchQueue.main.asyncAfter(deadline: .now() + musicStopTime) {
            // 音楽を止める
            self.player.stop()
        }
    }
    
    // 選択ボタン押下
    @IBAction func didClickPickBtn(_ sender: Any) {
        
        let picker = MPMediaPickerController()
        
        picker.delegate = self
        
        // 複数選択可
        picker.allowsPickingMultipleItems = true
        
        present(picker, animated: true, completion: nil)
        
    }
    
    // 前へボタン押下
    @IBAction func didClickbackMusicBtn(_ sender: Any) {
        self.player .skipToPreviousItem()
    }
    
    // 次へボタン押下
    @IBAction func didClickNextMusicBtn(_ sender: Any) {
        self.player .skipToNextItem()
    }
}

// メディア関連処理
extension ViewController {
    
    // メディアアイテムピッかーで曲を選択した時に呼ばれるメソッド
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        // mediaItemCollectionに入っている曲情報をセット
        player.setQueue(with: mediaItemCollection)
        
        if let mediaItem = mediaItemCollection.items.first {
            updateSongInformationUI(mediaItem: mediaItem)
        }
        
        // ピッカーを閉じる
        dismiss(animated: true, completion: nil)
    }
    
    // 選択がキャンセルされた時に呼ばれるメソッド
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        // ピッカーを閉じる
        dismiss(animated: true, completion: nil)
    }
    
    // 曲情報を表示する
    func updateSongInformationUI(mediaItem: MPMediaItem) {
        
        // 曲情報表示
        musicTitleLabel.text = mediaItem.title ?? "不明な曲"
        artistLabel.text = mediaItem.artist ?? "不明なアーティスト"
        
        // アートワーク表示
        if let artwork = mediaItem.artwork {
            let image = artwork.image(at: musicImage.bounds.size)
            musicImage.image = image
        } else {
            // アートワークがないとき
            musicImage.image = nil
            musicImage.backgroundColor = UIColor.gray
        }
        
    }
    
    // 再生中の曲が変更になったときに呼ばれる
    func nowPlayingItemChanged(notification: NSNotification) {
        
        if let mediaItem = player.nowPlayingItem {
            updateSongInformationUI(mediaItem: mediaItem)
        }
        
    }
    
}

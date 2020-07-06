//
//  ViewController.swift
//  traning1
//
//  Created by fsi on 2020/07/02.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var equalButton: UIButton!

    var inValue = 0 //入力値
    var outValue = 0 //計算後の値
    var isDesiminal = false //小数フラグ
    var oPerator = 0 //0 なし 1 + 2 - 3 * 4 /

    private let button = ["7","8","9","minus","4","5","6","plus","1","2","3","multiply","0","dot","ac","devide"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultLabel.text = inValue.description
//        collectionView.isScrollEnabled = false
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }

    //cellの生成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:button[indexPath.row], for:indexPath)
        return cell
    }

    //サイズ変更
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.layer.bounds.width - 10.0*8) / 4
        let height = (collectionView.layer.bounds.height - 10.0*8) / 4

        return CGSize(width: width, height: height)
    }

    //上下左右の余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    //タップされた場合の処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if Int(button[indexPath.row]) != nil {
            //数字入力の場合
            inValue = Int(button[indexPath.row])! + inValue*10
            resultLabel.text = inValue.description

        } else {
            //数字以外の場合

            if button[indexPath.row] == "ac" {
                if inValue == 0 {
                    outValue = 0
                }
                inValue = 0
                oPerator = 0
                resultLabel.text = outValue.description
            }

            if button[indexPath.row] == "dot" {
                isDesiminal = true
            }

            //演算子群
            if button[indexPath.row] == "plus" {
                calc()
                oPerator = 1
            }
            if button[indexPath.row] == "minus" {
                calc()
                oPerator = 2
            }
            if button[indexPath.row] == "multiply" {
                calc()
                oPerator = 3
            }
            if button[indexPath.row] == "devide" {
                calc()
                oPerator = 4
            }
        }

    }

    func calc(){
        if oPerator == 0 {
            outValue = inValue
            inValue = 0
            return
        }
        if oPerator == 1 {
            outValue += inValue
        }
        if oPerator == 2 {
            outValue -= inValue
        }
        if oPerator == 3 {
            outValue *= inValue
        }
        if oPerator == 4 {
            if inValue != 0 {
                outValue /= inValue
            }else {
                resultLabel.text = "error"
                return
            }
        }
        inValue = 0
        resultLabel.text = outValue.description
    }

    @IBAction func tapEqualButton(_ sender: Any) {
        calc()
        oPerator = 0
    }

}


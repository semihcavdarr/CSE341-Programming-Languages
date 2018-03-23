(use 'clojure.java.io)


(comment "Lexer.clj 'nin doğru çalışması için her satır sonunda 1 adet white space olmalı ve
satır sonlarında ')' dan önce de 1 adet white space gereklidir. Kolay gelsin.

151044081
HÜDAİ SEMİH ÇAVDAR"

)




(comment Bu fonksiyon girilen sayının geçerli bir sayı olup olmadığını kontrol eder.)
(defn isNum
	[string]
	(def temp '())
	(def flag 1)
	(def number "-0123456789")

	(loop [i 0]

		(when (> (count string) i)

			(loop [j 0]

				(when (> (count number) j)

					(if (= (nth number j) (nth string i))
						(def temp (conj temp 1))
					)

					(recur(+ j 1))
				)


			)

			(recur(+ i 1))
		)

	)
	(if (not= (count temp) (count string))
		(def flag 0)
	)
	flag
)

(comment Bu fonksiyon girilen stringin geçerli bir keyword olup olmadığını kontrol eder.)
(defn isKey
	[character]
	(def temp '())
	(def keywords (list  "and" "or" "not" "equal" "append" "concat" "set" "deffun" "for" "while" "if" "then" "else" "true" "false"))

	(loop [i 0]

		(when(> (count keywords) i)

			(if (= (nth keywords i) character)
				
				(def temp (conj temp 1))
			)

			(recur(+ i 1))
		)

	

	)

	(def temp (conj temp 0))
	(last temp)
)


(comment Bu fonksiyon girilen stringin geçerli bir identifier olup olmadığını kontrol eder.)
(defn isiden
	[character]
	(def flag 1)
	(def iden "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

	(dotimes [i (count character)]

		(if (= (.indexOf iden (str (nth character i)) )-1)

			(def flag -1)
		))
				

	flag
)


(comment Bu fonksiyon gelen karakterin geçerli bir operator olup olmadığını kontrol eder ama "- " operatorunu içermez "-" operatoru kontrolü eksi sayıları konrol etmek için aşağıda yapılmıştır.)
(defn isOp
	[character]
	(def flag 0)
	(def op  "+*/()")
	(loop [j 0]
		(when (> (count op) j)

			(if(= (nth op j) character)

				(def flag 1)

			)

			(recur(+ j 1))
		)
	)

	flag
)

(comment Bu fonksiyon gelen stringin geçerli karakterler içerip içermediğini kontrol eder.)
(defn isalnum
	[character]

	(def letters "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
	(def buf '())
	(loop [i 0]

		(when (> (count letters) i)

			(if (= (str(.charAt letters i)) character)

				(def buf (conj buf 1))
			)

			(recur(+ i 1))

		)

	)
	(def buf (conj buf 0))
	(last buf)

)

(comment Bu fonksiyon istenilen ana fonksiyondur gelen line'ın size'ı kadar döner ve karakter karakter kontrol yapar)
(defn lexer
	[filename]
	(def liste '())
	(def line (slurp filename))
	(def buff "")
	(def operator "+*/()")


	(def x (atom 0))
	(while (< @x (count line))

		(loop [i 0]

			(when (> (count operator) i)

				(if (.equals (nth line @x) (nth operator i))
					(do
						(println (nth line @x) "is operator" )
						(def liste (conj liste (nth line @x)))
					)
				)

				(recur(+ i 1))

			)

		)
		(if (and (not= (nth line @x) \space) (not= (nth line @x) \newline) (not= (isOp (nth line @x))1) )
			(def buff (str buff (nth line @x)))
		)
		
		(if (and (or(= (nth line @x) \space) (=(nth line @x) \newline)) (not= (count buff) 0))
			(do(cond (= (isKey buff) 1)
				(do
				(def liste (conj liste buff))
				(println buff "is keyword")
				)
				(= (isiden buff) 1)
				(do
				(def liste (conj liste buff))
				(println buff "is identifier")
				)
				(= buff "-")
				(do
				(def liste (conj liste buff))
				(println buff "is operator")
				)
				(= (isNum buff) 1)
				(do
				(def liste (conj liste buff))
				(println buff "is number")
				)
				:else (println buff "is invalid")
				)
			(def buff ""))

		)

		(swap! x inc)


	)
	(println)
	(reverse liste)
	
)



(println (lexer "CoffeeSample.coffee"))


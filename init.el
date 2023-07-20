;; [[ Options ]]
(global-display-line-numbers-mode t) ;; 开启全局行号
(setq inhibit-startup-screen t) ;; 关闭欢迎界面
(setq tab-always-indent 'complete) ;; 当输入内置的变量时，tab会补全
;(icomplete-mode t) ;; minibuffer 会补全
(electric-pair-mode t) ;; 括号补全
;; (toggle-frame-maximized) ;; 启动最大化
(tool-bar-mode -1) ;; 关闭工具栏
(scroll-bar-mode -1) ;; 关闭滑动条
(setq-default cursor-type '(bar . 3)) ;; 设置光标样式
(show-paren-mode t) ;; 显示括号匹配
(setq make-backup-files nil) ;; 关闭备份文件
(global-auto-revert-mode 1) ;; 自动加载外部修改过的文件
(setq auto-save-default nil) ;; 关闭自动保存的文件
(setq ring-bell-function 'ignore) ;; 关闭Emacs的警告音
(fset 'yes-or-no-p 'y-or-n-p) ;; 将(yes-or-no-p)修改成(y-or-n-p)
;; recent file
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)
;; recent file end
(delete-selection-mode 1) ;; 优化删除，当选中一些内容时，输入会直接更新这些内容
;; 优化鼠标滚轮
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(global-hl-line-mode 1) ;; 高亮当前行
;; [[ appearence ]]
;; [ font ]
(add-to-list 'default-frame-alist '(font . "LXGW WenKai Mono-14" ))
(set-face-attribute 'default t :font "LXGW WenKai Mono-14") ;; font size
;; 设置文件的默认编码
(set-language-environment "UTF-8")
;(set-locale-environment "en_US.UTF-8")
					;(setq system-time-locale "C")  ;; 这个是为了在 org mode 中用英文显示日期，默认是中文
(setq scroll-conservatively 101 scroll-margin 8) ;; 设置 scrolloff 为 8
;; [[ END ]]

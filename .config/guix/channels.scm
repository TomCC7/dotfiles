(list   (channel
         (name 'guix)
         (url "https://git.savannah.gnu.org/git/guix.git")
        ;; (commit
        ;;   "579e9e9509f45fdc8543323b3c9f662b53dbfc6d")
         (introduction
          (make-channel-introduction
           "9edb3f66fd807b096b48283debdcddccfea34bad"
           (openpgp-fingerprint
            "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))

        (channel
         (name 'nonguix)
         (url "https://gitlab.com/nonguix/nonguix"))

        (channel
         (name 'guix-hpc)
         (url "https://gitlab.inria.fr/guix-hpc/guix-hpc"))

        (channel
         (name 'guix-bimsb-nonfree)
         (url "https://github.com/BIMSBbioinfo/guix-bimsb-nonfree"))

        (channel
         (name 'guix-past)
         (url "https://gitlab.inria.fr/guix-hpc/guix-past")
         (introduction
          (make-channel-introduction
           "0c119db2ea86a389769f4d2b9c6f5c41c027e336"
           (openpgp-fingerprint
            "3CE4 6455 8A84 FDC6 9DB4  0CFB 090B 1199 3D9A EBB5"))))

        (channel
         (name 'flat)
         (url "https://github.com/flatwhatson/guix-channel.git")
         (introduction
          (make-channel-introduction
           "33f86a4b48205c0dc19d7c036c85393f0766f806"
           (openpgp-fingerprint
            "736A C00E 1254 378B A982  7AF6 9DBE 8265 81B6 4490")))))

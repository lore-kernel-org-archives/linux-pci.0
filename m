Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 14 Oct 2015 15:04:53 +0800
From: kbuild test robot <lkp@intel.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com
Subject: Re: [PATCH v2 1/4] asm-generic: add pci required defines and
 functions
Message-ID: <201510141556.Tmu3Afpa%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
In-Reply-To: <1444804304-5213-2-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ley,

[auto build test WARNING on v4.3-rc5 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Ley-Foon-Tan/Add-PCI-support-on-nios2-architecture/20151014-143651
config: frv-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=frv 

All warnings (new ones prefixed by >>):

   In file included from arch/frv/include/asm/pci.h:19:0,
                    from include/linux/pci.h:1497,
                    from arch/frv/mm/dma-alloc.c:38:
   include/asm-generic/pci.h:39:25: error: redefinition of 'pci_proc_domain'
    #define pci_proc_domain pci_proc_domain
                            ^
   include/asm-generic/pci.h:40:19: note: in expansion of macro 'pci_proc_domain'
    static inline int pci_proc_domain(struct pci_bus *bus)
                      ^
   In file included from arch/frv/mm/dma-alloc.c:38:0:
   include/linux/pci.h:1360:19: note: previous definition of 'pci_proc_domain' was here
    static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
                      ^
   In file included from include/linux/pci.h:1497:0,
                    from arch/frv/mm/dma-alloc.c:38:
>> arch/frv/include/asm/pci.h:23:0: warning: "pcibios_assign_all_busses" redefined
    #define pcibios_assign_all_busses() 0
    ^
   In file included from arch/frv/include/asm/pci.h:19:0,
                    from include/linux/pci.h:1497,
                    from arch/frv/mm/dma-alloc.c:38:
   include/asm-generic/pci.h:35:0: note: this is the location of the previous definition
    #define pcibios_assign_all_busses() (pci_has_flag(PCI_REASSIGN_ALL_BUS))
    ^
   In file included from include/linux/pci.h:1497:0,
                    from arch/frv/mm/dma-alloc.c:38:
>> arch/frv/include/asm/pci.h:48:0: warning: "PCIBIOS_MIN_IO" redefined
    #define PCIBIOS_MIN_IO  0x100
    ^
   In file included from arch/frv/include/asm/pci.h:19:0,
                    from include/linux/pci.h:1497,
                    from arch/frv/mm/dma-alloc.c:38:
   include/asm-generic/pci.h:27:0: note: this is the location of the previous definition
    #define PCIBIOS_MIN_IO (0UL)
    ^
   In file included from include/linux/pci.h:1497:0,
                    from arch/frv/mm/dma-alloc.c:38:
>> arch/frv/include/asm/pci.h:49:0: warning: "PCIBIOS_MIN_MEM" redefined
    #define PCIBIOS_MIN_MEM  0x00010000
    ^
   In file included from arch/frv/include/asm/pci.h:19:0,
                    from include/linux/pci.h:1497,
                    from arch/frv/mm/dma-alloc.c:38:
   include/asm-generic/pci.h:31:0: note: this is the location of the previous definition
    #define PCIBIOS_MIN_MEM (0UL)
    ^

vim +/pcibios_assign_all_busses +23 arch/frv/include/asm/pci.h

d7c4f1b7 arch/frv/include/asm/pci.h Arnd Bergmann     2009-05-13  13  #ifndef _ASM_FRV_PCI_H
d7c4f1b7 arch/frv/include/asm/pci.h Arnd Bergmann     2009-05-13  14  #define _ASM_FRV_PCI_H
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  15  
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  16  #include <linux/mm.h>
84be456f arch/frv/include/asm/pci.h Christoph Hellwig 2015-05-01  17  #include <linux/scatterlist.h>
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  18  #include <asm-generic/pci-dma-compat.h>
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16 @19  #include <asm-generic/pci.h>
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  20  
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  21  struct pci_dev;
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  22  
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16 @23  #define pcibios_assign_all_busses()	0
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  24  
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  25  extern void pcibios_set_master(struct pci_dev *dev);
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  26  
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  27  #ifdef CONFIG_MMU
a5da7d3c include/asm-frv/pci.h      Al Viro           2005-10-21  28  extern void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *dma_handle);
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  29  extern void consistent_free(void *vaddr);
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  30  extern void consistent_sync(void *vaddr, size_t size, int direction);
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  31  extern void consistent_sync_page(struct page *page, unsigned long offset,
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  32  				 size_t size, int direction);
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  33  #endif
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  34  
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  35  extern void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  36  				  dma_addr_t *dma_handle);
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  37  
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  38  extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  39  				void *vaddr, dma_addr_t dma_handle);
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  40  
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  41  /* Return the index of the PCI controller for device PDEV. */
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  42  #define pci_controller_num(PDEV)	(0)
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  43  
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  44  /*
25985edc arch/frv/include/asm/pci.h Lucas De Marchi   2011-03-30  45   *	These are pretty much arbitrary with the CoMEM implementation.
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  46   *	We have the whole address space to ourselves.
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  47   */
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16 @48  #define PCIBIOS_MIN_IO		0x100
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16 @49  #define PCIBIOS_MIN_MEM		0x00010000
^1da177e include/asm-frv/pci.h      Linus Torvalds    2005-04-16  50  
d7c4f1b7 arch/frv/include/asm/pci.h Arnd Bergmann     2009-05-13  51  #endif /* _ASM_FRV_PCI_H */

:::::: The code at line 23 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mP3DRpeJDSE+ciuQ
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--mP3DRpeJDSE+ciuQ--

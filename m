Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 14 Oct 2015 15:41:24 +0800
From: kbuild test robot <lkp@intel.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com
Subject: Re: [PATCH v2 1/4] asm-generic: add pci required defines and
 functions
Message-ID: <201510141553.gM9H7Fxo%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444804304-5213-2-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ley,

[auto build test WARNING on v4.3-rc5 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Ley-Foon-Tan/Add-PCI-support-on-nios2-architecture/20151014-143651
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> arch/x86/pci/common.c:639:14: sparse: macro "pcibios_assign_all_busses" passed 1 arguments, but takes just 0
   arch/x86/pci/common.c:640:1: sparse: Expected ; at end of declaration
   arch/x86/pci/common.c:640:1: sparse: got {
   arch/x86/pci/common.c:642:1: sparse: Expected ; at the end of type declaration
   arch/x86/pci/common.c:642:1: sparse: got }
>> arch/x86/pci/common.c:651:9: sparse: Trying to use reserved word 'while' as identifier
>> arch/x86/pci/common.c:673:9: sparse: Trying to use reserved word 'return' as identifier
   arch/x86/pci/common.c:673:16: sparse: Expected ; at end of declaration
   arch/x86/pci/common.c:673:16: sparse: got 0
   arch/x86/pci/common.c:674:1: sparse: Expected ; at the end of type declaration
   arch/x86/pci/common.c:674:1: sparse: got }
   arch/x86/pci/common.c:679:1: sparse: Expected ; at the end of type declaration
   arch/x86/pci/common.c:679:1: sparse: got }
   arch/x86/pci/common.c:685:1: sparse: Expected ; at the end of type declaration
   arch/x86/pci/common.c:685:1: sparse: got }
   arch/x86/pci/common.c:690:1: sparse: Expected ; at the end of type declaration
   arch/x86/pci/common.c:690:1: sparse: got }
>> arch/x86/pci/common.c:696:9: sparse: Trying to use reserved word 'else' as identifier
   arch/x86/pci/common.c:697:17: sparse: Expected ; at end of declaration
   arch/x86/pci/common.c:697:17: sparse: got return
   arch/x86/pci/common.c:698:1: sparse: Expected ; at the end of type declaration
   arch/x86/pci/common.c:698:1: sparse: got }
   arch/x86/pci/common.c:639:14: sparse: symbol 'pcibios_assign_all_busses' redeclared with different type (originally declared at arch/x86/include/asm/pci.h:48) - different base types
   arch/x86/pci/common.c:650:9: sparse: symbol 'pa_data' redeclared with different type (originally declared at arch/x86/pci/common.c:648) - different base types
   arch/x86/pci/common.c:652:17: sparse: undefined identifier 'data'
   arch/x86/pci/common.c:653:22: sparse: undefined identifier 'data'
   arch/x86/pci/common.c:656:21: sparse: undefined identifier 'data'
   arch/x86/pci/common.c:657:55: sparse: undefined identifier 'data'
   arch/x86/pci/common.c:659:44: sparse: undefined identifier 'dev'
   arch/x86/pci/common.c:665:33: sparse: undefined identifier 'dev'
   arch/x86/pci/common.c:667:33: sparse: undefined identifier 'dev'
   arch/x86/pci/common.c:670:27: sparse: undefined identifier 'data'
   arch/x86/pci/common.c:671:25: sparse: undefined identifier 'data'
   In file included from arch/x86/include/asm/pci.h:112:0,
                    from include/linux/pci.h:1497,
                    from arch/x86/pci/common.c:8:
   include/asm-generic/pci.h:39:25: error: redefinition of 'pci_proc_domain'
    #define pci_proc_domain pci_proc_domain
                            ^
   include/asm-generic/pci.h:40:19: note: in expansion of macro 'pci_proc_domain'
    static inline int pci_proc_domain(struct pci_bus *bus)
                      ^
   In file included from include/linux/pci.h:1497:0,
                    from arch/x86/pci/common.c:8:
   arch/x86/include/asm/pci.h:38:19: note: previous definition of 'pci_proc_domain' was here
    static inline int pci_proc_domain(struct pci_bus *bus)
                      ^
   arch/x86/pci/common.c:639:44: error: macro "pcibios_assign_all_busses" passed 1 arguments, but takes just 0
    unsigned int pcibios_assign_all_busses(void)
                                               ^
   arch/x86/pci/common.c:640:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
--
   drivers/scsi/bfa/bfa_svc.c:751:71: sparse: incorrect type in argument 5 (different base types)
   drivers/scsi/bfa/bfa_svc.c:751:71:    expected unsigned int [unsigned] [usertype] rsp_len
   drivers/scsi/bfa/bfa_svc.c:751:71:    got restricted __be32 [usertype] rsp_len
   drivers/scsi/bfa/bfa_svc.c:752:49: sparse: incorrect type in argument 6 (different base types)
   drivers/scsi/bfa/bfa_svc.c:752:49:    expected unsigned int [unsigned] [usertype] resid_len
   drivers/scsi/bfa/bfa_svc.c:752:49:    got restricted __be32 [usertype] residue_len
   drivers/scsi/bfa/bfa_svc.c:759:39: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:759:39:    expected unsigned int [unsigned] [usertype] rsp_len
   drivers/scsi/bfa/bfa_svc.c:759:39:    got restricted __be32 [usertype] rsp_len
   drivers/scsi/bfa/bfa_svc.c:760:43: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:760:43:    expected unsigned int [unsigned] [usertype] residue_len
   drivers/scsi/bfa/bfa_svc.c:760:43:    got restricted __be32 [usertype] residue_len
   drivers/scsi/bfa/bfa_svc.c:3619:39: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:3619:39:    expected restricted __be16 [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:3619:39:    got unsigned short [unsigned] [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:3654:41: sparse: cast from restricted __be16
   drivers/scsi/bfa/bfa_svc.c:3654:41: sparse: incorrect type in argument 1 (different base types)
   drivers/scsi/bfa/bfa_svc.c:3654:41:    expected unsigned short [unsigned] [usertype] val
   drivers/scsi/bfa/bfa_svc.c:3654:41:    got restricted __be16 [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:3654:41: sparse: cast from restricted __be16
   drivers/scsi/bfa/bfa_svc.c:3654:41: sparse: cast from restricted __be16
   drivers/scsi/bfa/bfa_svc.c:3655:54: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:3655:54:    expected unsigned short [unsigned] [usertype] path_tov
   drivers/scsi/bfa/bfa_svc.c:3655:54:    got restricted __be16 [usertype] <noident>
   drivers/scsi/bfa/bfa_svc.c:3657:53: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:3657:53:    expected unsigned short [unsigned] [usertype] q_depth
   drivers/scsi/bfa/bfa_svc.c:3657:53:    got restricted __be16 [usertype] <noident>
   drivers/scsi/bfa/bfa_svc.c:3993:9: sparse: cast from restricted __be16
   drivers/scsi/bfa/bfa_svc.c:4003:31: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:4003:31:    expected restricted __be16 [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:4003:31:    got unsigned short [unsigned] [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:4012:27: sparse: incorrect type in return expression (different base types)
   drivers/scsi/bfa/bfa_svc.c:4012:27:    expected unsigned short
   drivers/scsi/bfa/bfa_svc.c:4012:27:    got restricted __be16 [usertype] maxfrsize
   drivers/scsi/bfa/bfa_svc.c:4378:1: sparse: symbol 'bfa_fcport_ddportenable' was not declared. Should it be static?
   drivers/scsi/bfa/bfa_svc.c:4387:1: sparse: symbol 'bfa_fcport_ddportdisable' was not declared. Should it be static?
   drivers/scsi/bfa/bfa_ioc.h:193:22: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_ioc.h:193:22:    expected unsigned int [unsigned] [usertype] al_len
   drivers/scsi/bfa/bfa_ioc.h:193:22:    got restricted __be32 [usertype] <noident>
   drivers/scsi/bfa/bfa_svc.c:5656:22: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:5656:22: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:5656:22: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:5656:22: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:5657:22: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:5657:22: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:5657:22: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:5657:22: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6675:21: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:6675:21:    expected int enum bfa_status [signed] status
   drivers/scsi/bfa/bfa_svc.c:6675:21:    got restricted __be32 [usertype] <noident>
   drivers/scsi/bfa/bfa_svc.c:6726:49: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:6726:49:    expected unsigned int [unsigned] [usertype] roundtrip_latency
   drivers/scsi/bfa/bfa_svc.c:6726:49:    got restricted __be32 [usertype] <noident>
   drivers/scsi/bfa/bfa_svc.c:6728:50: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:6728:50:    expected unsigned int [unsigned] [usertype] est_cable_distance
   drivers/scsi/bfa/bfa_svc.c:6728:50:    got restricted __be32 [usertype] <noident>
   drivers/scsi/bfa/bfa_svc.c:6731:25: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6731:25: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6731:25: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6731:25: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6733:39: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6733:39: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6733:39: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6733:39: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfa_svc.c:6760:30: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:6760:30:    expected unsigned int [unsigned] [usertype] lpcnt
   drivers/scsi/bfa/bfa_svc.c:6760:30:    got restricted __be32 [usertype] <noident>
   drivers/scsi/bfa/bfa_svc.c:6013:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6013:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6013:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6013:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6013:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6013:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6014:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6014:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6014:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6014:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6014:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6014:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6015:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6015:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6015:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6015:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6015:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6015:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6016:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6016:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6016:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6016:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6016:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6016:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6017:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6017:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6017:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6017:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6017:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6017:27: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfa_svc.c:6652:26: sparse: incorrect type in assignment (different base types)
   drivers/scsi/bfa/bfa_svc.c:6652:26:    expected unsigned int [unsigned] [usertype] lpcnt
   drivers/scsi/bfa/bfa_svc.c:6652:26:    got restricted __be32 [usertype] <noident>
>> drivers/scsi/bfa/bfa_svc.c:6653:28: sparse: too many warnings
   In file included from arch/x86/include/asm/pci.h:112:0,
                    from include/linux/pci.h:1497,
                    from drivers/scsi/bfa/bfad_drv.h:30,
                    from drivers/scsi/bfa/bfa_svc.c:18:
   include/asm-generic/pci.h:39:25: error: redefinition of 'pci_proc_domain'
    #define pci_proc_domain pci_proc_domain
                            ^
   include/asm-generic/pci.h:40:19: note: in expansion of macro 'pci_proc_domain'
    static inline int pci_proc_domain(struct pci_bus *bus)
                      ^
   In file included from include/linux/pci.h:1497:0,
                    from drivers/scsi/bfa/bfad_drv.h:30,
                    from drivers/scsi/bfa/bfa_svc.c:18:
   arch/x86/include/asm/pci.h:38:19: note: previous definition of 'pci_proc_domain' was here
    static inline int pci_proc_domain(struct pci_bus *bus)
                      ^

vim +/pcibios_assign_all_busses +639 arch/x86/pci/common.c

41b9eb26 arch/x86/pci/common.c  Stefan Assmann    2008-07-15  633  			noioapicreroute = 1;
41b9eb26 arch/x86/pci/common.c  Stefan Assmann    2008-07-15  634  		return NULL;
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  635  	}
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  636  	return str;
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  637  }
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  638  
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16 @639  unsigned int pcibios_assign_all_busses(void)
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  640  {
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  641  	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  642  }
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  643  
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  644  int pcibios_add_device(struct pci_dev *dev)
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  645  {
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  646  	struct setup_data *data;
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  647  	struct pci_setup_rom *rom;
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  648  	u64 pa_data;
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  649  
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  650  	pa_data = boot_params.hdr.setup_data;
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05 @651  	while (pa_data) {
65694c5a arch/x86/pci/common.c  Matt Fleming      2013-06-05  652  		data = ioremap(pa_data, sizeof(*rom));
65694c5a arch/x86/pci/common.c  Matt Fleming      2013-06-05  653  		if (!data)
65694c5a arch/x86/pci/common.c  Matt Fleming      2013-06-05  654  			return -ENOMEM;
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  655  
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  656  		if (data->type == SETUP_PCI) {
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  657  			rom = (struct pci_setup_rom *)data;
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  658  
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  659  			if ((pci_domain_nr(dev->bus) == rom->segment) &&
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  660  			    (dev->bus->number == rom->bus) &&
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  661  			    (PCI_SLOT(dev->devfn) == rom->device) &&
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  662  			    (PCI_FUNC(dev->devfn) == rom->function) &&
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  663  			    (dev->vendor == rom->vendor) &&
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  664  			    (dev->device == rom->devid)) {
dbd3fc33 arch/x86/pci/common.c  Bjorn Helgaas     2012-12-10  665  				dev->rom = pa_data +
dbd3fc33 arch/x86/pci/common.c  Bjorn Helgaas     2012-12-10  666  				      offsetof(struct pci_setup_rom, romdata);
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  667  				dev->romlen = rom->pcilen;
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  668  			}
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  669  		}
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  670  		pa_data = data->next;
65694c5a arch/x86/pci/common.c  Matt Fleming      2013-06-05  671  		iounmap(data);
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  672  	}
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05 @673  	return 0;
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  674  }
f9a37be0 arch/x86/pci/common.c  Matthew Garrett   2012-12-05  675  
991de2e5 arch/x86/pci/common.c  Jiang Liu         2015-06-10  676  int pcibios_alloc_irq(struct pci_dev *dev)
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  677  {
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  678  	return pcibios_enable_irq(dev);
^1da177e arch/i386/pci/common.c Linus Torvalds    2005-04-16  679  }
87bec66b arch/i386/pci/common.c David Shaohua Li  2005-07-27  680  
991de2e5 arch/x86/pci/common.c  Jiang Liu         2015-06-10  681  void pcibios_free_irq(struct pci_dev *dev)
9e8ce4b9 arch/x86/pci/common.c  Rafael J. Wysocki 2015-03-20  682  {
991de2e5 arch/x86/pci/common.c  Jiang Liu         2015-06-10  683  	if (pcibios_disable_irq)
9e8ce4b9 arch/x86/pci/common.c  Rafael J. Wysocki 2015-03-20  684  		pcibios_disable_irq(dev);
9e8ce4b9 arch/x86/pci/common.c  Rafael J. Wysocki 2015-03-20  685  }
9e8ce4b9 arch/x86/pci/common.c  Rafael J. Wysocki 2015-03-20  686  
991de2e5 arch/x86/pci/common.c  Jiang Liu         2015-06-10  687  int pcibios_enable_device(struct pci_dev *dev, int mask)
991de2e5 arch/x86/pci/common.c  Jiang Liu         2015-06-10  688  {
991de2e5 arch/x86/pci/common.c  Jiang Liu         2015-06-10  689  	return pci_enable_resources(dev, mask);
991de2e5 arch/x86/pci/common.c  Jiang Liu         2015-06-10  690  }
991de2e5 arch/x86/pci/common.c  Jiang Liu         2015-06-10  691  
642c92da arch/x86/pci/common.c  Taku Izumi        2012-10-30  692  int pci_ext_cfg_avail(void)
0ef5f8f6 arch/x86/pci/common.c  Andrew Patterson  2008-11-10  693  {
0ef5f8f6 arch/x86/pci/common.c  Andrew Patterson  2008-11-10  694  	if (raw_pci_ext_ops)
0ef5f8f6 arch/x86/pci/common.c  Andrew Patterson  2008-11-10  695  		return 1;
0ef5f8f6 arch/x86/pci/common.c  Andrew Patterson  2008-11-10 @696  	else
0ef5f8f6 arch/x86/pci/common.c  Andrew Patterson  2008-11-10  697  		return 0;
0ef5f8f6 arch/x86/pci/common.c  Andrew Patterson  2008-11-10  698  }

:::::: The code at line 639 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

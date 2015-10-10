Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28444 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbbJJOOH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 10 Oct 2015 10:14:07 -0400
Date: Sat, 10 Oct 2015 22:12:45 +0800
From: kbuild test robot <lkp@intel.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Li Yang <leoli@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: Re: [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and
 LS2080a
Message-ID: <201510102219.eCBMRYJD%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <1444458217-31004-1-git-send-email-Minghuan.Lian@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Minghuan,

[auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
   from drivers/net/fddi/skfp/drvfbi.c:23:
   drivers/net/fddi/skfp/h/targetos.h:63:0: warning: "FALSE" redefined
   #define FALSE 0
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/net/fddi/skfp/h/targetos.h:47,
   from drivers/net/fddi/skfp/h/smc.h:50,
   from drivers/net/fddi/skfp/drvfbi.c:23:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
   #define FALSE (1 == 0)
   ^
   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
   from drivers/net/fddi/skfp/hwt.c:32:
   drivers/net/fddi/skfp/h/targetos.h:62:0: warning: "TRUE" redefined
   #define TRUE 1
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/net/fddi/skfp/h/targetos.h:47,
   from drivers/net/fddi/skfp/h/smc.h:50,
   from drivers/net/fddi/skfp/hwt.c:32:
   include/acpi/actypes.h:438:0: note: this is the location of the previous definition
   #define TRUE (1 == 1)
   ^
   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
   from drivers/net/fddi/skfp/hwt.c:32:
   drivers/net/fddi/skfp/h/targetos.h:63:0: warning: "FALSE" redefined
   #define FALSE 0
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/net/fddi/skfp/h/targetos.h:47,
   from drivers/net/fddi/skfp/h/smc.h:50,
   from drivers/net/fddi/skfp/hwt.c:32:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
   #define FALSE (1 == 0)
   ^
   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
   from drivers/net/fddi/skfp/ess.c:38:
   drivers/net/fddi/skfp/h/targetos.h:62:0: warning: "TRUE" redefined
   #define TRUE 1
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/net/fddi/skfp/h/targetos.h:47,
   from drivers/net/fddi/skfp/h/smc.h:50,
   from drivers/net/fddi/skfp/ess.c:38:
   include/acpi/actypes.h:438:0: note: this is the location of the previous definition
   #define TRUE (1 == 1)
   ^
   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
   from drivers/net/fddi/skfp/ess.c:38:
   drivers/net/fddi/skfp/h/targetos.h:63:0: warning: "FALSE" redefined
   #define FALSE 0
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/net/fddi/skfp/h/targetos.h:47,
   from drivers/net/fddi/skfp/h/smc.h:50,
   from drivers/net/fddi/skfp/ess.c:38:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
   #define FALSE (1 == 0)
   ^
>> drivers/pci/host/pcie-designware.c:76:52: warning: 'struct pci_sys_data' declared inside parameter list
   static inline struct pcie_port pci_sys_data
   ^
>> drivers/pci/host/pcie-designware.c:76:52: warning: its scope is only this definition or declaration, which is probably not what you want
   In file included from include/uapi/linux/stddef.h:1:0,
   from include/linux/stddef.h:4,
   from include/uapi/linux/posix_types.h:4,
   from include/uapi/linux/types.h:13,
   from include/linux/types.h:5,
   from include/linux/smp.h:10,
   from include/linux/irq.h:12,
   from drivers/pci/host/pcie-designware.c:14:
   drivers/pci/host/pcie-designware.c: In function 'sys_to_pcie':
>> drivers/pci/host/pcie-designware.c:78:13: error: dereferencing pointer to incomplete type
   BUG_ON(!sys->private_data);
   ^
   include/linux/compiler.h:166:42: note: in definition of macro 'unlikely'
   # define unlikely(x) 0)
   ^
>> drivers/pci/host/pcie-designware.c:78:2: note: in expansion of macro 'BUG_ON'
   BUG_ON(!sys->private_data);
   ^
   drivers/pci/host/pcie-designware.c:80:12: error: dereferencing pointer to incomplete type
   return sys->private_data;
   ^
   drivers/pci/host/pcie-designware.c: In function 'dw_pcie_host_init':
>> drivers/pci/host/pcie-designware.c:530:2: error: invalid use of undefined type 'struct hw_pci'
   dw_pci.nr_controllers = 1;
   ^
   drivers/pci/host/pcie-designware.c:531:2: error: invalid use of undefined type 'struct hw_pci'
   dw_pci.private_data = (void
   ^
>> drivers/pci/host/pcie-designware.c:533:2: error: implicit declaration of function 'pci_common_init_dev'
   pci_common_init_dev(pp->dev, &dw_pci);
   ^
   drivers/pci/host/pcie-designware.c: At top level:
   drivers/pci/host/pcie-designware.c:682:41: warning: 'struct pci_sys_data' declared inside parameter list
   static int dw_pcie_setup(int nr, struct pci_sys_data
   ^
   drivers/pci/host/pcie-designware.c: In function 'dw_pcie_setup':
>> drivers/pci/host/pcie-designware.c:686:7: warning: passing argument 1 of 'sys_to_pcie' from incompatible pointer type
   pp = sys_to_pcie(sys);
   ^
   drivers/pci/host/pcie-designware.c:76:33: note: expected 'struct pci_sys_data but argument is of type 'struct pci_sys_data
   static inline struct pcie_port pci_sys_data
   ^
   drivers/pci/host/pcie-designware.c:689:6: error: dereferencing pointer to incomplete type
   sys->io_offset = global_io_offset - pp->io_bus_addr;
   ^
>> drivers/pci/host/pcie-designware.c:690:3: error: implicit declaration of function 'pci_ioremap_io'
   pci_ioremap_io(global_io_offset, pp->io_base);
   ^
   drivers/pci/host/pcie-designware.c:692:31: error: dereferencing pointer to incomplete type
   pci_add_resource_offset(&sys->resources, &pp->io,
   ^
   drivers/pci/host/pcie-designware.c:693:9: error: dereferencing pointer to incomplete type
   sys->io_offset);
   ^
   drivers/pci/host/pcie-designware.c:696:5: error: dereferencing pointer to incomplete type
   sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
   ^
   drivers/pci/host/pcie-designware.c:697:30: error: dereferencing pointer to incomplete type
   pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
   ^
   drivers/pci/host/pcie-designware.c:697:56: error: dereferencing pointer to incomplete type
   pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
   ^
   drivers/pci/host/pcie-designware.c:698:23: error: dereferencing pointer to incomplete type
   pci_add_resource(&sys->resources, &pp->busn);
   ^
   drivers/pci/host/pcie-designware.c: At top level:
   drivers/pci/host/pcie-designware.c:703:56: warning: 'struct pci_sys_data' declared inside parameter list
   static struct pci_bus nr, struct pci_sys_data
   ^
   drivers/pci/host/pcie-designware.c: In function 'dw_pcie_scan_bus':
   drivers/pci/host/pcie-designware.c:706:25: warning: passing argument 1 of 'sys_to_pcie' from incompatible pointer type
   struct pcie_port = sys_to_pcie(sys);
   ^
   drivers/pci/host/pcie-designware.c:76:33: note: expected 'struct pci_sys_data but argument is of type 'struct pci_sys_data
   static inline struct pcie_port pci_sys_data
   ^
   drivers/pci/host/pcie-designware.c:708:23: error: dereferencing pointer to incomplete type
   pp->root_bus_nr = sys->busnr;
   ^
   drivers/pci/host/pcie-designware.c:711:43: error: dereferencing pointer to incomplete type
   bus = pci_scan_root_bus_msi(pp->dev, sys->busnr, &dw_pcie_ops,
   ^
   drivers/pci/host/pcie-designware.c:712:19: error: dereferencing pointer to incomplete type
   sys, &sys->resources,
   ^
   drivers/pci/host/pcie-designware.c:715:39: error: dereferencing pointer to incomplete type
   bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
   ^
   drivers/pci/host/pcie-designware.c:716:15: error: dereferencing pointer to incomplete type
   sys, &sys->resources);
   ^
   drivers/pci/host/pcie-designware.c: At top level:
>> drivers/pci/host/pcie-designware.c:739:15: error: variable 'dw_pci' has initializer but incomplete type
   static struct hw_pci dw_pci = {
   ^
>> drivers/pci/host/pcie-designware.c:740:2: error: unknown field 'setup' specified in initializer
   .setup = dw_pcie_setup,
   ^
>> drivers/pci/host/pcie-designware.c:740:2: warning: excess elements in struct initializer
>> drivers/pci/host/pcie-designware.c:740:2: warning: (near initialization for 'dw_pci')
>> drivers/pci/host/pcie-designware.c:741:2: error: unknown field 'scan' specified in initializer
   .scan = dw_pcie_scan_bus,
   ^
   drivers/pci/host/pcie-designware.c:741:2: warning: excess elements in struct initializer
   drivers/pci/host/pcie-designware.c:741:2: warning: (near initialization for 'dw_pci')
>> drivers/pci/host/pcie-designware.c:742:2: error: unknown field 'map_irq' specified in initializer
   .map_irq = dw_pcie_map_irq,
   ^
   drivers/pci/host/pcie-designware.c:742:2: warning: excess elements in struct initializer
   drivers/pci/host/pcie-designware.c:742:2: warning: (near initialization for 'dw_pci')
   drivers/pci/host/pcie-designware.c: In function 'sys_to_pcie':
>> drivers/pci/host/pcie-designware.c:81:1: warning: control reaches end of non-void function
   }
   ^
   cc1: some warnings being treated as errors
   Documentation Makefile Module.symvers System.map arch block certs crypto drivers firmware fs include init ipc kernel lib mm modules.builtin modules.order net scripts security sound source usr virt vmlinux vmlinux.o Error 1
   Target '__build' not remade because of errors.
   Documentation Makefile Module.symvers System.map arch block certs crypto drivers firmware fs include init ipc kernel lib mm modules.builtin modules.order net scripts security sound source usr virt vmlinux vmlinux.o Error 2
   Target '__build' not remade because of errors.
   Documentation Makefile Module.symvers System.map arch block certs crypto drivers firmware fs include init ipc kernel lib mm modules.builtin modules.order net scripts security sound source usr virt vmlinux vmlinux.o Error 2
   drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c: In function 'pm8xxx_gpio_probe':
   drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c:675:17: warning: cast from pointer to integer of different size
   pctrl->npins = (unsigned)of_device_get_match_data(&pdev->dev);
   ^
   drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c: In function 'pm8xxx_mpp_probe':
   drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c:766:17: warning: cast from pointer to integer of different size
   pctrl->npins = (unsigned)of_device_get_match_data(&pdev->dev);
   ^
   drivers/net/ethernet/dec/tulip/winbond-840.c: In function 'init_registers':
   drivers/net/ethernet/dec/tulip/winbond-840.c:910:2: warning: #warning Processor architecture undefined
   #warning Processor architecture undefined
   ^
   drivers/net/ethernet/dec/tulip/tulip_core.c:101:2: warning: #warning Processor architecture undefined!
   #warning Processor architecture undefined!
   ^
   In file included from include/linux/kernel.h:10:0,
   from include/linux/list.h:8,
   from include/linux/kobject.h:20,
   from include/linux/device.h:17,
   from drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c:19:
   drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c: In function 'ipq806x_gmac_probe':
   include/linux/bitops.h:6:19: warning: large integer implicitly truncated to unsigned type
   #define BIT(nr) (1UL << (nr))
   ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c:80:29: note: in expansion of macro 'BIT'
   #define QSGMII_PHY_CDR_EN BIT(0)
   ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c:335:9: note: in expansion of macro 'QSGMII_PHY_CDR_EN'
   QSGMII_PHY_CDR_EN |
   ^
   In file included from drivers/staging/ft1000/ft1000-usb/ft1000_debug.c:42:0:
   drivers/staging/ft1000/ft1000-usb/ft1000_usb.h:31:0: warning: "FALSE" redefined
   #define FALSE 0
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/staging/ft1000/ft1000-usb/ft1000_debug.c:37:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
   #define FALSE (1 == 0)
   ^
   In file included from drivers/staging/ft1000/ft1000-usb/ft1000_debug.c:42:0:
   drivers/staging/ft1000/ft1000-usb/ft1000_usb.h:32:0: warning: "TRUE" redefined
   #define TRUE 1
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/staging/ft1000/ft1000-usb/ft1000_debug.c:37:
   include/acpi/actypes.h:438:0: note: this is the location of the previous definition
   #define TRUE (1 == 1)
   ^
   In file included from drivers/staging/ft1000/ft1000-usb/ft1000_download.c:15:0:
   drivers/staging/ft1000/ft1000-usb/ft1000_usb.h:31:0: warning: "FALSE" redefined
   #define FALSE 0
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,
   from include/linux/ethtool.h:16,
   from include/linux/netdevice.h:42,
   from drivers/staging/ft1000/ft1000-usb/ft1000_download.c:11:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
   #define FALSE (1 == 0)
   ^
   In file included from drivers/staging/ft1000/ft1000-usb/ft1000_download.c:15:0:
   drivers/staging/ft1000/ft1000-usb/ft1000_usb.h:32:0: warning: "TRUE" redefined
   #define TRUE 1
   ^
   In file included from include/acpi/acpi.h:58:0,
   from include/linux/acpi.h:33,
   from arch/arm64/include/asm/dma-mapping.h:21,
   from include/linux/dma-mapping.h:86,
   from include/linux/skbuff.h:34,
   from include/linux/if_ether.h:23,
   from include/uapi/linux/ethtool.h:17,

vim +78 drivers/pci/host/pcie-designware.c

340cba60 Jingoo Han             2013-06-21   8   *
340cba60 Jingoo Han             2013-06-21   9   * This program is free software; you can redistribute it and/or modify
340cba60 Jingoo Han             2013-06-21  10   * it under the terms of the GNU General Public License version 2 as
340cba60 Jingoo Han             2013-06-21  11   * published by the Free Software Foundation.
340cba60 Jingoo Han             2013-06-21  12   */
340cba60 Jingoo Han             2013-06-21  13  
f342d940 Jingoo Han             2013-09-06 @14  #include <linux/irq.h>
f342d940 Jingoo Han             2013-09-06  15  #include <linux/irqdomain.h>
340cba60 Jingoo Han             2013-06-21  16  #include <linux/kernel.h>
340cba60 Jingoo Han             2013-06-21  17  #include <linux/module.h>
f342d940 Jingoo Han             2013-09-06  18  #include <linux/msi.h>
340cba60 Jingoo Han             2013-06-21  19  #include <linux/of_address.h>
804f57b1 Lucas Stach            2014-03-05  20  #include <linux/of_pci.h>
340cba60 Jingoo Han             2013-06-21  21  #include <linux/pci.h>
340cba60 Jingoo Han             2013-06-21  22  #include <linux/pci_regs.h>
4dd964df Kishon Vijay Abraham I 2014-07-17  23  #include <linux/platform_device.h>
340cba60 Jingoo Han             2013-06-21  24  #include <linux/types.h>
340cba60 Jingoo Han             2013-06-21  25  
4b1ced84 Jingoo Han             2013-07-31  26  #include "pcie-designware.h"
340cba60 Jingoo Han             2013-06-21  27  
340cba60 Jingoo Han             2013-06-21  28  /* Synopsis specific PCIE configuration registers */
340cba60 Jingoo Han             2013-06-21  29  #define PCIE_PORT_LINK_CONTROL		0x710
340cba60 Jingoo Han             2013-06-21  30  #define PORT_LINK_MODE_MASK		(0x3f << 16)
4b1ced84 Jingoo Han             2013-07-31  31  #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
4b1ced84 Jingoo Han             2013-07-31  32  #define PORT_LINK_MODE_2_LANES		(0x3 << 16)
340cba60 Jingoo Han             2013-06-21  33  #define PORT_LINK_MODE_4_LANES		(0x7 << 16)
5b0f0738 Zhou Wang              2015-05-13  34  #define PORT_LINK_MODE_8_LANES		(0xf << 16)
340cba60 Jingoo Han             2013-06-21  35  
340cba60 Jingoo Han             2013-06-21  36  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
340cba60 Jingoo Han             2013-06-21  37  #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
340cba60 Jingoo Han             2013-06-21  38  #define PORT_LOGIC_LINK_WIDTH_MASK	(0x1ff << 8)
4b1ced84 Jingoo Han             2013-07-31  39  #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
4b1ced84 Jingoo Han             2013-07-31  40  #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
4b1ced84 Jingoo Han             2013-07-31  41  #define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
5b0f0738 Zhou Wang              2015-05-13  42  #define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
340cba60 Jingoo Han             2013-06-21  43  
340cba60 Jingoo Han             2013-06-21  44  #define PCIE_MSI_ADDR_LO		0x820
340cba60 Jingoo Han             2013-06-21  45  #define PCIE_MSI_ADDR_HI		0x824
340cba60 Jingoo Han             2013-06-21  46  #define PCIE_MSI_INTR0_ENABLE		0x828
340cba60 Jingoo Han             2013-06-21  47  #define PCIE_MSI_INTR0_MASK		0x82C
340cba60 Jingoo Han             2013-06-21  48  #define PCIE_MSI_INTR0_STATUS		0x830
340cba60 Jingoo Han             2013-06-21  49  
340cba60 Jingoo Han             2013-06-21  50  #define PCIE_ATU_VIEWPORT		0x900
340cba60 Jingoo Han             2013-06-21  51  #define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
340cba60 Jingoo Han             2013-06-21  52  #define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
340cba60 Jingoo Han             2013-06-21  53  #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
340cba60 Jingoo Han             2013-06-21  54  #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
340cba60 Jingoo Han             2013-06-21  55  #define PCIE_ATU_CR1			0x904
340cba60 Jingoo Han             2013-06-21  56  #define PCIE_ATU_TYPE_MEM		(0x0 << 0)
340cba60 Jingoo Han             2013-06-21  57  #define PCIE_ATU_TYPE_IO		(0x2 << 0)
340cba60 Jingoo Han             2013-06-21  58  #define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
340cba60 Jingoo Han             2013-06-21  59  #define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
340cba60 Jingoo Han             2013-06-21  60  #define PCIE_ATU_CR2			0x908
340cba60 Jingoo Han             2013-06-21  61  #define PCIE_ATU_ENABLE			(0x1 << 31)
340cba60 Jingoo Han             2013-06-21  62  #define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
340cba60 Jingoo Han             2013-06-21  63  #define PCIE_ATU_LOWER_BASE		0x90C
340cba60 Jingoo Han             2013-06-21  64  #define PCIE_ATU_UPPER_BASE		0x910
340cba60 Jingoo Han             2013-06-21  65  #define PCIE_ATU_LIMIT			0x914
340cba60 Jingoo Han             2013-06-21  66  #define PCIE_ATU_LOWER_TARGET		0x918
340cba60 Jingoo Han             2013-06-21  67  #define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
340cba60 Jingoo Han             2013-06-21  68  #define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
340cba60 Jingoo Han             2013-06-21  69  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
340cba60 Jingoo Han             2013-06-21  70  #define PCIE_ATU_UPPER_TARGET		0x91C
340cba60 Jingoo Han             2013-06-21  71  
4b1ced84 Jingoo Han             2013-07-31  72  static struct hw_pci dw_pci;
4b1ced84 Jingoo Han             2013-07-31  73  
73e40850 Bjorn Helgaas          2013-10-09  74  static unsigned long global_io_offset;
340cba60 Jingoo Han             2013-06-21  75  
340cba60 Jingoo Han             2013-06-21 @76  static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
340cba60 Jingoo Han             2013-06-21  77  {
84a263f3 Lucas Stach            2014-09-05 @78  	BUG_ON(!sys->private_data);
84a263f3 Lucas Stach            2014-09-05  79  
340cba60 Jingoo Han             2013-06-21  80  	return sys->private_data;
340cba60 Jingoo Han             2013-06-21 @81  }
340cba60 Jingoo Han             2013-06-21  82  
a01ef59e Pratyush Anand         2013-12-11  83  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
340cba60 Jingoo Han             2013-06-21  84  {

:::::: The code at line 78 was first introduced by commit
:::::: 84a263f39403ca3b399af77499876e02e634b00b PCI: designware: Check private_data validity in single place

:::::: TO: Lucas Stach <l.stach@pengutronix.de>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--6TrnltStXW4iwmi0
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
k9sgvwnK8PJ/oetCEUTEAgA=

--6TrnltStXW4iwmi0--

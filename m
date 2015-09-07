Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37417 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588AbbIGIvG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Sep 2015 04:51:06 -0400
Message-ID: <1441615864.3174.2.camel@pengutronix.de>
Subject: Re: [pci:pci-4.4/host-designware 4/5]
 drivers/pci/host/pci-keystone-dw.c:73:13: error: conflicting types for
 'ks_dw_pcie_get_msi_addr'
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 07 Sep 2015 10:51:04 +0200
In-Reply-To: <201509050132.BtjF0zsN%fengguang.wu@intel.com>
References: <201509050132.BtjF0zsN%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Am Samstag, den 05.09.2015, 01:38 +0800 schrieb kbuild test robot:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-4.4/host-designware
> head:   59f6d039d7eaa0c851b712bc0aa1c804c727de61
> commit: ec8d33e0c5ade5d6d2c0ececff44a0ad5ed35df1 [4/5] PCI: designware: Make get_msi_addr() return phys_addr_t, not u32
> config: arm-keystone_defconfig (attached as .config)
> reproduce:
>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>   chmod +x ~/bin/make.cross
>   git checkout ec8d33e0c5ade5d6d2c0ececff44a0ad5ed35df1
>   # save the attached .config to linux build tree
>   make.cross ARCH=arm 
> 
> All error/warnings (new ones prefixed by >>):
> 
> >> drivers/pci/host/pci-keystone-dw.c:73:13: error: conflicting types for 'ks_dw_pcie_get_msi_addr'
>     phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
>                 ^
>    In file included from drivers/pci/host/pci-keystone-dw.c:24:0:
>    drivers/pci/host/pci-keystone.h:40:5: note: previous declaration of 'ks_dw_pcie_get_msi_addr' was here
>     u32 ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
>         ^
> --
> >> drivers/pci/host/pci-keystone.c:287:2: warning: initialization from incompatible pointer type
>      .get_msi_addr = ks_dw_pcie_get_msi_addr,
>      ^
> >> drivers/pci/host/pci-keystone.c:287:2: warning: (near initialization for 'keystone_pcie_host_ops.get_msi_addr')
> 
> vim +/ks_dw_pcie_get_msi_addr +73 drivers/pci/host/pci-keystone-dw.c
> 
>     67						     u32 *bit_pos)
>     68	{
>     69		*reg_offset = offset % 8;
>     70		*bit_pos = offset >> 3;
>     71	}
>     72	
>   > 73	phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
>     74	{
>     75		struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
>     76	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Totally my fault for not properly building all affected platforms.

Can you squash in the following?

Regards,
Lucas
--------------------------------->8-------------------------------
diff --git a/drivers/pci/host/pci-keystone.h
b/drivers/pci/host/pci-keystone.h
index 478d932b602d..f0944e8c4b02 100644
--- a/drivers/pci/host/pci-keystone.h
+++ b/drivers/pci/host/pci-keystone.h
@@ -37,7 +37,7 @@ struct keystone_pcie {
 
 /* Keystone DW specific MSI controller APIs/definitions */
 void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int
offset);
-u32 ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
+phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
 
 /* Keystone specific PCI controller APIs */
 void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie);

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |


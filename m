Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757511AbcLAQeW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 11:34:22 -0500
Date: Thu, 1 Dec 2016 10:34:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Dongdong Liu <liudongdong3@huawei.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [pci:pci/ecam 9/12] drivers/pci/host/pcie-hisi.c:88:8: error:
 implicit declaration of function 'acpi_get_rc_resources'
Message-ID: <20161201163418.GD19681@bhelgaas-glaptop.roam.corp.google.com>
References: <201612011838.nMLxDd6f%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201612011838.nMLxDd6f%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 06:52:42PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ecam
> head:   652f5e38afee70579c8723730c08d197a90e5b3a
> commit: 7fcacb5eb93142e603f07b5d629e06e20e1a461f [9/12] PCI: Add MCFG quirks for HiSilicon Hip05/06/07 host controllers
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 7fcacb5eb93142e603f07b5d629e06e20e1a461f
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/pci/host/pcie-hisi.c: In function 'hisi_pcie_init':
> >> drivers/pci/host/pcie-hisi.c:88:8: error: implicit declaration of function 'acpi_get_rc_resources' [-Werror=implicit-function-declaration]
>      res = acpi_get_rc_resources("HISI0081", root->segment);
>            ^~~~~~~~~~~~~~~~~~~~~
> >> drivers/pci/host/pcie-hisi.c:88:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>      res = acpi_get_rc_resources("HISI0081", root->segment);
>          ^
>    cc1: some warnings being treated as errors
> 
> vim +/acpi_get_rc_resources +88 drivers/pci/host/pcie-hisi.c
> 
>     82		void __iomem *reg_base;
>     83	
>     84		/*
>     85		 * Retrieve RC base and size from a HISI0081 device with _UID
>     86		 * matching our segment.
>     87		 */
>   > 88		res = acpi_get_rc_resources("HISI0081", root->segment);
>     89		if (!res) {
>     90			dev_err(dev, "can't get rc base address\n");
>     91			return -ENOMEM;

Fixed, thanks.

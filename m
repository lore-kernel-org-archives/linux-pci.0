Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbeE3PU5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 11:20:57 -0400
Date: Wed, 30 May 2018 10:20:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/sparc 4/4] arch/sparc/kernel/pci_common.c:539:13:
 error: 'dev' undeclared; did you mean 'pdev'?
Message-ID: <20180530152056.GD39853@bhelgaas-glaptop.roam.corp.google.com>
References: <201805301201.LYoeKRvY%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201805301201.LYoeKRvY%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 12:16:03PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/sparc
> head:   81729bfd0f58568d6ebb162b2a004f8e9291a004
> commit: 81729bfd0f58568d6ebb162b2a004f8e9291a004 [4/4] sparc/PCI: Use dev_printk() when possible
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 81729bfd0f58568d6ebb162b2a004f8e9291a004
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All errors (new ones prefixed by >>):

I fixed these and updated my "next" branch.

>    In file included from include/linux/pci.h:31:0,
>                     from arch/sparc/kernel/pci_common.c:9:
>    arch/sparc/kernel/pci_common.c: In function 'pci_scan_for_parity_error':
> >> arch/sparc/kernel/pci_common.c:539:13: error: 'dev' undeclared (first use in this function); did you mean 'pdev'?
>        pci_info(dev, "%s: Device saw Parity Error [%016x]\n",
>                 ^
>    include/linux/device.h:1382:46: note: in definition of macro 'dev_info'
>     #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
>                                                  ^~~
>    arch/sparc/kernel/pci_common.c:539:4: note: in expansion of macro 'pci_info'
>        pci_info(dev, "%s: Device saw Parity Error [%016x]\n",
>        ^~~~~~~~
>    arch/sparc/kernel/pci_common.c:539:13: note: each undeclared identifier is reported only once for each function it appears in
>        pci_info(dev, "%s: Device saw Parity Error [%016x]\n",
>                 ^
>    include/linux/device.h:1382:46: note: in definition of macro 'dev_info'
>     #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
>                                                  ^~~
>    arch/sparc/kernel/pci_common.c:539:4: note: in expansion of macro 'pci_info'
>        pci_info(dev, "%s: Device saw Parity Error [%016x]\n",
>        ^~~~~~~~
> --
>    In file included from arch/sparc/kernel/pci_impl.h:12:0,
>                     from arch/sparc/kernel/pci_msi.c:11:
>    arch/sparc/kernel/pci_msi.c: In function 'sparc64_teardown_msi_irq':
> >> arch/sparc/kernel/pci_msi.c:204:16: error: expected ')' before string constant
>       pci_err(pdev "%s: teardown: ops->teardown() on MSI %u, "
>                    ^
>    include/linux/pci.h:2300:46: note: in definition of macro 'pci_err'
>     #define pci_err(pdev, fmt, arg...) dev_err(&(pdev)->dev, fmt, ##arg)
>                                                  ^~~~
> 
> vim +539 arch/sparc/kernel/pci_common.c
> 
>    523	
>    524	void pci_scan_for_parity_error(struct pci_pbm_info *pbm,
>    525				       struct pci_bus *pbus)
>    526	{
>    527		struct pci_dev *pdev;
>    528		struct pci_bus *bus;
>    529	
>    530		list_for_each_entry(pdev, &pbus->devices, bus_list) {
>    531			u16 status, error_bits;
>    532	
>    533			pci_read_config_word(pdev, PCI_STATUS, &status);
>    534			error_bits =
>    535				(status & (PCI_STATUS_PARITY |
>    536					   PCI_STATUS_DETECTED_PARITY));
>    537			if (error_bits) {
>    538				pci_write_config_word(pdev, PCI_STATUS, error_bits);
>  > 539				pci_info(dev, "%s: Device saw Parity Error [%016x]\n",
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

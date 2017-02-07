Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932674AbdBGXHv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Feb 2017 18:07:51 -0500
Date: Tue, 7 Feb 2017 17:07:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [pci:pci/host-designware 2/6] drivers/pci/dwc/pci-imx6.c:634:2:
 error: implicit declaration of function 'hook_fault_code'
Message-ID: <20170207230747.GE11659@bhelgaas-glaptop.roam.corp.google.com>
References: <201702040736.vjbWSLqV%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201702040736.vjbWSLqV%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

I dropped the "Add COMPILE_TEST to all DesignWare-based drivers" patch
for now because I don't want to add errors to these non-ARM builds.

At least one caller (brcmstb_gisb_arb_probe()) uses "#ifdef ARM"
around the call to hook_fault_code().  I guess we could do that, too.

On Sat, Feb 04, 2017 at 07:18:39AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-designware
> head:   ac4108c530acc8f1c964a8b1c04d4523d026fd29
> commit: 2b5839db931bcc499fe85e843297f1518385780a [2/6] PCI: dwc: Add COMPILE_TEST to all DesignWare-based drivers
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 2b5839db931bcc499fe85e843297f1518385780a
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/dwc/pci-imx6.c: In function 'imx6_pcie_probe':
> >> drivers/pci/dwc/pci-imx6.c:634:2: error: implicit declaration of function 'hook_fault_code' [-Werror=implicit-function-declaration]
>      hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
>      ^~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> --
>    drivers/pci/dwc/pci-keystone.c: In function 'keystone_pcie_fault':
> >> drivers/pci/dwc/pci-keystone.c:256:7: error: 'struct pt_regs' has no member named 'uregs'
>       regs->uregs[reg] = -1;
>           ^~
> >> drivers/pci/dwc/pci-keystone.c:257:7: error: 'struct pt_regs' has no member named 'ARM_pc'
>       regs->ARM_pc += 4;
>           ^~
>    drivers/pci/dwc/pci-keystone.c: In function 'ks_pcie_host_init':
> >> drivers/pci/dwc/pci-keystone.c:288:2: error: implicit declaration of function 'hook_fault_code' [-Werror=implicit-function-declaration]
>      hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
>      ^~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/hook_fault_code +634 drivers/pci/dwc/pci-imx6.c
> 
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  618  	struct pcie_port *pp;
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  619  	struct resource *dbi_base;
> 13957652 drivers/pci/host/pci-imx6.c Bjorn Helgaas   2016-10-06  620  	struct device_node *node = dev->of_node;
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  621  	int ret;
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  622  
> 13957652 drivers/pci/host/pci-imx6.c Bjorn Helgaas   2016-10-06  623  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  624  	if (!imx6_pcie)
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  625  		return -ENOMEM;
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  626  
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  627  	pp = &imx6_pcie->pp;
> 13957652 drivers/pci/host/pci-imx6.c Bjorn Helgaas   2016-10-06  628  	pp->dev = dev;
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  629  
> e6f1fef0 drivers/pci/host/pci-imx6.c Andrey Smirnov  2016-05-02  630  	imx6_pcie->variant =
> 13957652 drivers/pci/host/pci-imx6.c Bjorn Helgaas   2016-10-06  631  		(enum imx6_pcie_variants)of_device_get_match_data(dev);
> e3c06cd0 drivers/pci/host/pci-imx6.c Christoph Fritz 2016-04-05  632  
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  633  	/* Added for PCI abort handling */
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26 @634  	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  635  		"imprecise external abort");
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  636  
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  637  	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 13957652 drivers/pci/host/pci-imx6.c Bjorn Helgaas   2016-10-06  638  	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
> b391bf31 drivers/pci/host/pci-imx6.c Fabio Estevam   2013-12-02  639  	if (IS_ERR(pp->dbi_base))
> b391bf31 drivers/pci/host/pci-imx6.c Fabio Estevam   2013-12-02  640  		return PTR_ERR(pp->dbi_base);
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  641  
> bb38919e drivers/pci/host/pci-imx6.c Sean Cross      2013-09-26  642  	/* Fetch GPIOs */
> 
> :::::: The code at line 634 was first introduced by commit
> :::::: bb38919ec56e0758c3ae56dfc091dcde1391353e PCI: imx6: Add support for i.MX6 PCIe controller
> 
> :::::: TO: Sean Cross <xobs@kosagi.com>
> :::::: CC: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

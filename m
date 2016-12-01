Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757669AbcLAQep (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 11:34:45 -0500
Date: Thu, 1 Dec 2016 10:34:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/ecam 11/12] drivers/pci/host/pci-thunder-pem.c:328:2:
 error: 'ret' undeclared
Message-ID: <20161201163439.GE19681@bhelgaas-glaptop.roam.corp.google.com>
References: <201612011917.XDzbxV0b%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201612011917.XDzbxV0b%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 07:03:21PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ecam
> head:   652f5e38afee70579c8723730c08d197a90e5b3a
> commit: 47381174ac0162a6ed29159df6eaed5f437f4c06 [11/12] PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 47381174ac0162a6ed29159df6eaed5f437f4c06
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/host/pci-thunder-pem.c: In function 'thunder_pem_acpi_init':
> >> drivers/pci/host/pci-thunder-pem.c:328:2: error: 'ret' undeclared (first use in this function)
>      ret = acpi_get_rc_resources("THRX0002", root->segment, res_pem);
>      ^~~
>    drivers/pci/host/pci-thunder-pem.c:328:2: note: each undeclared identifier is reported only once for each function it appears in
> >> drivers/pci/host/pci-thunder-pem.c:328:8: error: implicit declaration of function 'acpi_get_rc_resources' [-Werror=implicit-function-declaration]
>      ret = acpi_get_rc_resources("THRX0002", root->segment, res_pem);
>            ^~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/ret +328 drivers/pci/host/pci-thunder-pem.c
> 
>    322	{
>    323		struct device *dev = cfg->parent;
>    324		struct acpi_device *adev = to_acpi_device(dev);
>    325		struct acpi_pci_root *root = acpi_driver_data(adev);
>    326		struct resource *res_pem;
>    327	
>  > 328		ret = acpi_get_rc_resources("THRX0002", root->segment, res_pem);
>    329		if (ret) {
>    330			dev_err(dev, "can't get rc base address\n");
>    331			return ret;

Fixed, thanks.  All the fixes are courtesy of Dongdong.

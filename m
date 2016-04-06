Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34232 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbcDFRMI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2016 13:12:08 -0400
Subject: Re: [PATCH next 1/2] PCI: keystone: add pci error irq handler
To: kbuild test robot <lkp@intel.com>
References: <201603230621.h4pXMyFx%fengguang.wu@intel.com>
CC: <kbuild-all@01.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <bhelgaas@google.com>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <5705435B.6020806@ti.com>
Date: Wed, 6 Apr 2016 13:11:55 -0400
MIME-Version: 1.0
In-Reply-To: <201603230621.h4pXMyFx%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/22/2016 06:23 PM, kbuild test robot wrote:
> Hi Murali,
> 
> [auto build test ERROR on next-20160322]
> 
> url:    https://github.com/0day-ci/linux/commits/Murali-Karicheri/PCI-keystone-add-pci-error-irq-handler/20160323-035516
> config: arm-multi_v7_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/host/pci-keystone.c: In function 'ks_pcie_probe':
>>> drivers/pci/host/pci-keystone.c:410:16: error: 'node' undeclared (first use in this function)
>      ks_pcie->np = node;
>                    ^
>    drivers/pci/host/pci-keystone.c:410:16: note: each undeclared identifier is reported only once for each function it appears in
> 
> vim +/node +410 drivers/pci/host/pci-keystone.c
> 
>    404			return PTR_ERR(reg_p);
>    405		ks_pcie->device_id = readl(reg_p) >> 16;
>    406		devm_iounmap(dev, reg_p);
>    407		devm_release_mem_region(dev, res->start, resource_size(res));
>    408	
>    409		pp->dev = dev;
>  > 410		ks_pcie->np = node;
>    411		platform_set_drvdata(pdev, ks_pcie);
>    412		ks_pcie->clk = devm_clk_get(dev, "pcie");
>    413		if (IS_ERR(ks_pcie->clk)) {
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
I had posted v1 of this patch which is still waiting to be applied. Wondering
who is going to pick this up?

-- 
Murali Karicheri
Linux Kernel, Keystone

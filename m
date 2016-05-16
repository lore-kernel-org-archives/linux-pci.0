Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33904 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754441AbcEPUKF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 May 2016 16:10:05 -0400
Date: Mon, 16 May 2016 15:10:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Joerg Roedel <jroedel@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Build breakage for pci-next since v4.6-rc5
Message-ID: <20160516201000.GB20759@localhost>
References: <20160513115642.GA22906@wunner.de>
 <36D38C1F74839847A52A484C31F3E51A62221FEF@irsmsx105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <36D38C1F74839847A52A484C31F3E51A62221FEF@irsmsx105.ger.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 13, 2016 at 12:25:36PM +0000, Lawrynowicz, Jacek wrote:
> Lukas, thanks for the heads up.
> 
> The actual commit that needs rebasing is:
>     commit f0af9593372abfde34460aa1250e670cc535a7d8
>     Author: Bjorn Helgaas <bhelgaas@google.com>
>     Date:   Wed Feb 24 13:43:45 2016 -0600
>     PCI: Add pci_add_dma_alias() to abstract implementation
> 
> It changes all direct usages of PCI_DEV_FLAGS_DMA_ALIAS_DEVFN to a
> pci_add_dma_alias  function call.
> 
> Bjorn, you want me to post the rebased version?

I don't want to rebase my "next" branch, but if you could post the 
incremental patch to fix up drivers/iommu/amd_iommu.c, I'll ask Linus
to include that when he pulls my branch.

> -----Original Message-----
> From: Lukas Wunner [mailto:lukas@wunner.de] 
> Sent: Friday, May 13, 2016 1:57 PM
> To: Joerg Roedel <jroedel@suse.de>; Lawrynowicz, Jacek
> <jacek.lawrynowicz@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Alex Williamson
> <alex.williamson@redhat.com>; linux-pci@vger.kernel.org
> Subject: Build breakage for pci-next since v4.6-rc5
> 
> Hi Jacek, Hi Jörg,
> 
> in case this isn't on your radar yet, Bjorn Helgaas' next branch
> currently no longer builds when merged with Linus' master branch
> because this commit introduced with v4.6-rc5:
> 
>     commit e3156048346c28c695f5cf9db67a8cf88c90f947
>     Author: Joerg Roedel <jroedel@suse.de>
>     Date:   Fri Apr 8 15:12:24 2016 +0200
>     iommu/amd: Fix checking of pci dma aliases
> 
> adds an occurrence of PCI_DEV_FLAGS_DMA_ALIAS_DEVFN but this
> commit on Bjorn's next branch:
> 
>     commit 338c3149a221527e202ee26b1e35f76c965bb6c0
>     Author: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
>     Date:   Thu Mar 3 15:38:02 2016 +0100
>     PCI: Add support for multiple DMA aliases
> 
> removed all other occurrences of this macro. A rebase of the
> latter commit is required to fix the build breakage. I was
> made aware of this yesterday by Intel's 0-DAY kernel test
> infrastructure (see below).
> 
> Thanks,
> 
> Lukas
> 
> ----- Forwarded message from kbuild test robot <fengguang.wu@intel.com> -----
> 
> Date: Thu, 12 May 2016 21:38:46 +0800
> From: kbuild test robot <fengguang.wu@intel.com>
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: kbuild-all@01.org, Lukas Wunner <lukas@wunner.de>
> Subject: [l1k:thunderbolt_runpm_v2 1/14] drivers/iommu/amd_iommu.c:266:22:
> 	error: 'PCI_DEV_FLAGS_DMA_ALIAS_DEVFN' undeclared
> User-Agent: Mutt/1.5.23 (2014-03-12)
> 
> tree:   https://github.com/l1k/linux thunderbolt_runpm_v2
> head:   308f7c892de104a57f50dda4761c10c094f5e80d
> commit: 376a0f25bf07bdd90c58985f210c95a59d21fe1b [1/14] Merge remote-tracking
> branches 'helgaas/next', 'helgaas/for-linus' and 'helgaas/pci/pm' into HEAD
> config: x86_64-rhel (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.3-14) 4.9.3
> reproduce:
>         git checkout 376a0f25bf07bdd90c58985f210c95a59d21fe1b
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> Note: the l1k/thunderbolt_runpm_v2 HEAD 308f7c892de104a57f50dda4761c10c094f5e80d
> builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/iommu/amd_iommu.c: In function 'get_alias':
> >> drivers/iommu/amd_iommu.c:266:22: error: 'PCI_DEV_FLAGS_DMA_ALIAS_DEVFN'
> undeclared (first use in this function)
>       pdev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
>                          ^
>    drivers/iommu/amd_iommu.c:266:22: note: each undeclared identifier is
> reported only once for each function it appears in
> >> drivers/iommu/amd_iommu.c:267:7: error: 'struct pci_dev' has no member named
> 'dma_alias_devfn'
>       pdev->dma_alias_devfn = ivrs_alias & 0xff;
>           ^
> 
> vim +/PCI_DEV_FLAGS_DMA_ALIAS_DEVFN +266 drivers/iommu/amd_iommu.c
> 
> e3156048 Joerg Roedel 2016-04-08  260  	/*
> e3156048 Joerg Roedel 2016-04-08  261  	 * If we don't have a PCI DMA alias and
> the IVRS alias is on the same
> e3156048 Joerg Roedel 2016-04-08  262  	 * bus, then the IVRS table may know
> about a quirk that we don't.
> e3156048 Joerg Roedel 2016-04-08  263  	 */
> e3156048 Joerg Roedel 2016-04-08  264  	if (pci_alias == devid &&
> e3156048 Joerg Roedel 2016-04-08  265  	    PCI_BUS_NUM(ivrs_alias) ==
> pdev->bus->number) {
> e3156048 Joerg Roedel 2016-04-08 @266  		pdev->dev_flags |=
> PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> e3156048 Joerg Roedel 2016-04-08 @267  		pdev->dma_alias_devfn =
> ivrs_alias & 0xff;
> e3156048 Joerg Roedel 2016-04-08  268  		pr_info("AMD-Vi: Added PCI DMA
> alias %02x.%d for %s\n",
> e3156048 Joerg Roedel 2016-04-08  269  			PCI_SLOT(ivrs_alias),
> PCI_FUNC(ivrs_alias),
> e3156048 Joerg Roedel 2016-04-08  270  			dev_name(dev));
> 
> :::::: The code at line 266 was first introduced by commit
> :::::: e3156048346c28c695f5cf9db67a8cf88c90f947 iommu/amd: Fix checking of pci
> dma aliases
> 
> :::::: TO: Joerg Roedel <jroedel@suse.de>
> :::::: CC: Joerg Roedel <jroedel@suse.de>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 
> 
> ----- End forwarded message -----



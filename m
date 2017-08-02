Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752519AbdHBRFv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 13:05:51 -0400
Date: Wed, 2 Aug 2017 12:05:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pci:for-linus 1/2] drivers/pci/pci.c:4283:7: error: implicit
 declaration of function 'pci_dev_reset'
Message-ID: <20170802170548.GA20308@bhelgaas-glaptop.roam.corp.google.com>
References: <201708020922.GaknMGx6%fengguang.wu@intel.com>
 <20170802083234.30c18a83@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170802083234.30c18a83@why.wild-wind.fr.eu.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 02, 2017 at 08:32:34AM +0100, Marc Zyngier wrote:
> On Wed, 2 Aug 2017 09:53:26 +0800
> kbuild test robot <fengguang.wu@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
> > head:   39d14168af01c696cfcab4770e2b9a56d6e73679
> > commit: 39767ee127c680aed6d94bbcd429bb5242ef4f1f [1/2] PCI: Add pci_reset_function_locked()
> > config: i386-randconfig-x019-201731 (attached as .config)
> > compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> > reproduce:
> >         git checkout 39767ee127c680aed6d94bbcd429bb5242ef4f1f
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/pci/pci.c: In function 'pci_reset_function_locked':
> > >> drivers/pci/pci.c:4283:7: error: implicit declaration of function 'pci_dev_reset' [-Werror=implicit-function-declaration]  
> >      rc = pci_dev_reset(dev, 1);
> >           ^~~~~~~~~~~~~
> > >> drivers/pci/pci.c:4289:7: error: implicit declaration of function '__pci_dev_reset' [-Werror=implicit-function-declaration]  
> >      rc = __pci_dev_reset(dev, 0);
> >           ^~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> 
> [...]
> 
> Ah, the patch has raced against 52354b9d1f46 ("PCI: Remove
> __pci_dev_reset() and pci_dev_reset()") and applies on top of
> mainline without conflicts. Bah...
> 
> The fixlet below addresses the issue (tested with 4.13-rc3 on
> AMD Seattle).

I folded this into the patch on my for-linus branch, thanks!

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ffddd574a79e..e20ce77e7ec3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4280,13 +4280,13 @@ int pci_reset_function_locked(struct pci_dev *dev)
>  {
>  	int rc;
>  
> -	rc = pci_dev_reset(dev, 1);
> +	rc = pci_probe_reset_function(dev);
>  	if (rc)
>  		return rc;
>  
>  	pci_dev_save_and_disable(dev);
>  
> -	rc = __pci_dev_reset(dev, 0);
> +	rc = __pci_reset_function_locked(dev);
>  
>  	pci_dev_restore(dev);
>  -- 
> Without deviation from the norm, progress is not possible.

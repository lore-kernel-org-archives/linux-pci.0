Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbdHBHcr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 03:32:47 -0400
Date: Wed, 2 Aug 2017 08:32:34 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: <kbuild-all@01.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pci:for-linus 1/2] drivers/pci/pci.c:4283:7: error: implicit
 declaration of function 'pci_dev_reset'
Message-ID: <20170802083234.30c18a83@why.wild-wind.fr.eu.org>
In-Reply-To: <201708020922.GaknMGx6%fengguang.wu@intel.com>
References: <201708020922.GaknMGx6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2 Aug 2017 09:53:26 +0800
kbuild test robot <fengguang.wu@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
> head:   39d14168af01c696cfcab4770e2b9a56d6e73679
> commit: 39767ee127c680aed6d94bbcd429bb5242ef4f1f [1/2] PCI: Add pci_reset_function_locked()
> config: i386-randconfig-x019-201731 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 39767ee127c680aed6d94bbcd429bb5242ef4f1f
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/pci.c: In function 'pci_reset_function_locked':
> >> drivers/pci/pci.c:4283:7: error: implicit declaration of function 'pci_dev_reset' [-Werror=implicit-function-declaration]  
>      rc = pci_dev_reset(dev, 1);
>           ^~~~~~~~~~~~~
> >> drivers/pci/pci.c:4289:7: error: implicit declaration of function '__pci_dev_reset' [-Werror=implicit-function-declaration]  
>      rc = __pci_dev_reset(dev, 0);
>           ^~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

[...]

Ah, the patch has raced against 52354b9d1f46 ("PCI: Remove
__pci_dev_reset() and pci_dev_reset()") and applies on top of
mainline without conflicts. Bah...

The fixlet below addresses the issue (tested with 4.13-rc3 on
AMD Seattle).

Thanks,

	M.


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ffddd574a79e..e20ce77e7ec3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4280,13 +4280,13 @@ int pci_reset_function_locked(struct pci_dev *dev)
 {
 	int rc;
 
-	rc = pci_dev_reset(dev, 1);
+	rc = pci_probe_reset_function(dev);
 	if (rc)
 		return rc;
 
 	pci_dev_save_and_disable(dev);
 
-	rc = __pci_dev_reset(dev, 0);
+	rc = __pci_reset_function_locked(dev);
 
 	pci_dev_restore(dev);
 -- 
Without deviation from the norm, progress is not possible.

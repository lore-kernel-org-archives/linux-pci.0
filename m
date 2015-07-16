Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35414 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810AbbGPXIg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2015 19:08:36 -0400
Received: by iecuq6 with SMTP id uq6so66525685iec.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2015 16:08:36 -0700 (PDT)
Date: Thu, 16 Jul 2015 18:08:31 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Gregor Dick <gdick@solarflare.com>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, stable@kernel.org
Subject: Re: [PATCH] PCI: Don't use SR-IOV lock for ATS
Message-ID: <20150716230831.GF25591@google.com>
References: <1434617420-18313-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434617420-18313-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg,

On Thu, Jun 18, 2015 at 10:50:20AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The use of the SR-IOV lock for ATS causes a dead-lock in the
> AMD-IOMMU driver when virtual functions are added that have
> an ATS capability.
> 
> The problem is that the VFs will be added to the bus with
> the SR-IOV lock held. While added to the bus the
> device-notifiers will run and invoke AMD IOMMU code, which
> itself will assign the device to a domain try to enable ATS.
> When it calls pci_enable_ats() this will dead-lock.

I'm trying to connect the dots here.  What's the notifier that invokes the
AMD IOMMU code?  I thought it would be a BUS_NOTIFY_ADD_DEVICE notifier,
but I haven't found it yet.

> Fix this by introducing a global ats_lock. ATS enablement
> and disablement isn't in any fast-path, so a global lock
> shouldn't hurt here.
> 
> Cc: stable@kernel.org
> Reported-by: Gregor Dick <gdick@solarflare.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/pci/ats.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index a8099d4..f0c3c6f 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -17,6 +17,8 @@
>  
>  #include "pci.h"
>  
> +static DEFINE_MUTEX(ats_lock);
> +
>  static int ats_alloc_one(struct pci_dev *dev, int ps)
>  {
>  	int pos;
> @@ -67,7 +69,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  	if (dev->is_physfn || dev->is_virtfn) {
>  		struct pci_dev *pdev = dev->is_physfn ? dev : dev->physfn;
>  
> -		mutex_lock(&pdev->sriov->lock);
> +		mutex_lock(&ats_lock);
>  		if (pdev->ats)
>  			rc = pdev->ats->stu == ps ? 0 : -EINVAL;
>  		else
> @@ -75,7 +77,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  
>  		if (!rc)
>  			pdev->ats->ref_cnt++;
> -		mutex_unlock(&pdev->sriov->lock);
> +		mutex_unlock(&ats_lock);

The mutex was originally added by e277d2fc79d6 ("PCI: handle Virtual
Function ATS enabling").  I assume the purpose is to protect the
ats_alloc_one().

This seems overly complicated.  I think we can simplify this by doing some
of this work earlier, in pci_init_capabilities().  I'll work this up and
you can see what you think.

Bjorn

>  		if (rc)
>  			return rc;
>  	}
> @@ -116,11 +118,11 @@ void pci_disable_ats(struct pci_dev *dev)
>  	if (dev->is_physfn || dev->is_virtfn) {
>  		struct pci_dev *pdev = dev->is_physfn ? dev : dev->physfn;
>  
> -		mutex_lock(&pdev->sriov->lock);
> +		mutex_lock(&ats_lock);
>  		pdev->ats->ref_cnt--;
>  		if (!pdev->ats->ref_cnt)
>  			ats_free_one(pdev);
> -		mutex_unlock(&pdev->sriov->lock);
> +		mutex_unlock(&ats_lock);
>  	}
>  
>  	if (!dev->is_physfn)
> -- 
> 1.9.1
> 

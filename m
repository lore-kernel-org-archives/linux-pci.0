Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34802 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbbIRWbG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 18:31:06 -0400
Received: by iofb144 with SMTP id b144so71500287iof.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2015 15:31:04 -0700 (PDT)
Date: Fri, 18 Sep 2015 17:30:59 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: Fix pci_claim_bridge_resource() resource claiming
Message-ID: <20150918223059.GO25767@google.com>
References: <1441877628-28879-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441877628-28879-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 10, 2015 at 10:33:48AM +0100, Lorenzo Pieralisi wrote:
> Commit 8505e729a2f6eb ("PCI: Add pci_claim_bridge_resource() to clip
> window if necessary") introduced a new API to claim bridge resources.
> pci_claim_bridge_resource() tries to claim a bridge resource, and if
> the claiming fails the function tries to clip the resource to make
> it fit within the parent resource window.
> If the clipping succeeds the bridge aperture is set-up accordingly
> and pci_claim_bridge_resource() tries to claim the resource again.
> 
> Commit c770cb4cb505 ("PCI: Mark invalid BARs as unassigned") added
> code that sets the IORESOURCE_UNSET flag on claiming failure.
> 
> This means that the second resource claiming after window clipping will
> always fail, since the resource flags contain IORESOURCE_UNSET,
> previously set on failure by pci_claim_resource(), so the subsequent
> pci_claim_resource() call ends up spitting a log message and return
> failure with no chance whatsoever to succeed.
> 
> This patch clears the IORESOURCE_UNSET in the bridge resource flags
> after clipping the bridge window successfully, so that the subsequent
> pci_claim_resource() has a chance to succeed.
> 
> Fixes: c770cb4cb505 ("PCI: Mark invalid BARs as unassigned")
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <stable@vger.kernel.org> # 4.1+
> ---
>  drivers/pci/setup-bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 508cc56..6de55d0 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -733,6 +733,13 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Clear the IORESOURCE_UNSET flag set by the previous
> +	 * pci_claim_resource() failure so that the resource
> +	 * claiming can actually be carried out
> +	 */
> +	bridge->resource[i].flags &= ~IORESOURCE_UNSET;
> +
>  	if (pci_claim_resource(bridge, i) == 0)
>  		return 0;	/* claimed a smaller window */
>  

Thanks, Lorenzo, this is definitely a problem.  I propose the
patch below instead because:

  - I like clearing IORESOURCE_UNSET at the point where we actually
    update res->start and res->end (which will also fix any other
    future callers of pci_bus_clip_resource()), and

  - Doing it there means the printk will show how we changed the
    addresses, not just the size change.

Can you try this out and see if it also solves the problem you're
seeing?

I wasn't sure about the provenance of your patch, Lorenzo.  You had a
Signed-off-by from Yinghai, but I didn't see the original posting.  If
it originally came from Yinghai, I should change the
"Based-on-patch-by" below.

Bjorn


commit a4ad03352739c96842af5d06387595665cdd875e
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Sep 18 17:15:01 2015 -0500

    PCI: Clear IORESOURCE_UNSET when clipping a bridge window
    
    c770cb4cb505 ("PCI: Mark invalid BARs as unassigned") sets IORESOURCE_UNSET
    if we fail to claim a resource.  If we tried to claim a bridge window,
    failed, clipped the window, and tried to claim the clipped window, we
    failed again because of IORESOURCE_UNSET.
    
    When pci_bus_clip_resource() clips a bridge window to fit inside an
    upstream window, we're reassigning the window, so clear the
    IORESOURCE_UNSET flag.  Also clear IORESOURCE_UNSET in our copy of the
    unclipped window so we can see exactly what the original window was and how
    it now fits inside the upstream window.
    
    Fixes: c770cb4cb505 ("PCI: Mark invalid BARs as unassigned")
    Based-on-patch-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: stable@vger.kernel.org	# 4.1+

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 6fbd3f2..d3346d2 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -256,6 +256,8 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 
 		res->start = start;
 		res->end = end;
+		res->flags &= ~IORESOURCE_UNSET;
+		orig_res.flags &= ~IORESOURCE_UNSET;
 		dev_printk(KERN_DEBUG, &dev->dev, "%pR clipped to %pR\n",
 				 &orig_res, res);
 

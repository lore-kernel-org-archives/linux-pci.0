Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753967AbdBOX5L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Feb 2017 18:57:11 -0500
Date: Wed, 15 Feb 2017 17:56:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, mstowe@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RESENT PATCH] PCI/MSI: Fix msi_desc->affinity memory leak when
 freeing MSI IRQs.
Message-ID: <20170215235657.GC26758@bhelgaas-glaptop.roam.corp.google.com>
References: <1487177588-31369-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487177588-31369-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 15, 2017 at 11:53:08AM -0500, Prarit Bhargava wrote:
> No response ... trying again.
> 
> P.
> 
> ---8<---
> 
> During device setup, msix_setup_entries() and msi_setup_entry() allocate
> msi_desc by calling alloc_msi_entry().  alloc_msi_entry() can also allocate a
> affinity cpumask.  During device teardown free_msi_irqs() is called and the
> msi_desc is freed, but the affinity cpumask is leaked.
> 
> Fix it by calling free_msi_entry() which frees both the msi_desc and the
> affinity cpumask.

Sorry for the delay, Prarit.  I started looking at this when you first
posted it.  The more I looked at it, the less I liked the setup/free
paths -- they're not very parallel and I don't remember what else.

But I guess it's probably a longer term effort to clean that up.

Do you have a bug report or anything for this, or did you just find
this by code inspection?  If there's a bugzilla or even a symptom, we
could mention it in the changelog.

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: mstowe@redhat.com
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/msi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 50c5003295ca..3d709311052d 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -379,7 +379,7 @@ static void free_msi_irqs(struct pci_dev *dev)
>  		}
>  
>  		list_del(&entry->list);
> -		kfree(entry);
> +		free_msi_entry(entry);
>  	}
>  
>  	if (dev->msi_irq_groups) {
> -- 
> 1.7.9.3
> 

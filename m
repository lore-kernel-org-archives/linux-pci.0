Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934978AbdBQVrO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Feb 2017 16:47:14 -0500
Date: Fri, 17 Feb 2017 15:47:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, mstowe@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RESENT PATCH] PCI/MSI: Fix msi_desc->affinity memory leak when
 freeing MSI IRQs.
Message-ID: <20170217214710.GF17762@bhelgaas-glaptop.roam.corp.google.com>
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
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: mstowe@redhat.com
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/msi for v4.11, thanks, Prarit!

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

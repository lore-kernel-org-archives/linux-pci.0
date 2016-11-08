Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752621AbcKHVxN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Nov 2016 16:53:13 -0500
Date: Tue, 8 Nov 2016 15:53:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
        hch@lst.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: pci_irq_get_affinity() should cope with NULL
 affinity vector
Message-ID: <20161108215309.GG14322@bhelgaas-glaptop.roam.corp.google.com>
References: <5821904A020000780011CF55@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5821904A020000780011CF55@prv-mh.provo.novell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 08, 2016 at 12:43:54AM -0700, Jan Beulich wrote:
> msi_setup_entry() only logs a message when the affinity vector can't be
> allocated, and hence pci_irq_get_affinity() indexing entry->affinity is
> wrong without a prior check.
> 
> Fixes: ee8d41e53efe "pci/msi: Retrieve affinity for a vector"
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Christoph Hellwig <hch@lst.de>

Applied to pci/msi for v4.10 with Christoph's reviewed-by and the following
changelog:

  PCI/MSI: Check for NULL affinity mask in pci_irq_get_affinity()
  
  If msi_setup_entry() fails to allocate an affinity mask, it logs a message
  but continues on and allocates an MSI entry with entry->affinity == NULL.
  
  Check for this case in pci_irq_get_affinity() so we don't try to
  dereference a NULL pointer.

> ---
>  drivers/pci/msi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- 4.9-rc4/drivers/pci/msi.c
> +++ 4.9-rc4-PCI-MSI-no-affinity/drivers/pci/msi.c
> @@ -1294,7 +1294,8 @@ const struct cpumask *pci_irq_get_affini
>  	} else if (dev->msi_enabled) {
>  		struct msi_desc *entry = first_pci_msi_entry(dev);
>  
> -		if (WARN_ON_ONCE(!entry || nr >= entry->nvec_used))
> +		if (WARN_ON_ONCE(!entry || !entry->affinity ||
> +				 nr >= entry->nvec_used))
>  			return NULL;
>  
>  		return &entry->affinity[nr];
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

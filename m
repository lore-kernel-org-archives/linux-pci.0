Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753302AbdA3W4i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jan 2017 17:56:38 -0500
Date: Mon, 30 Jan 2017 16:56:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH] PCI: Avoid possible deadlock on pci_lock and p->pi_lock
Message-ID: <20170130225628.GX20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170118234612.26157.95913.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170118234612.26157.95913.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2017 at 05:46:12PM -0600, Bjorn Helgaas wrote:
> pci_lock is an IRQ-safe spinlock that protects all accesses to PCI
> configuration space (see PCI_OP_READ() and PCI_OP_WRITE() in pci/access.c).
> 
> The pci_cfg_access_unlock() path acquires pci_lock, then p->pi_lock (inside
> wake_up_all()).  According to lockdep, there is a possible path involving
> snbep_uncore_pci_read_counter() that could acquire them in the reverse
> order: acquiring p->pi_lock, then pci_lock, which could result in a
> deadlock.  Lockdep details are in the bugzilla below.
> 
> Avoid the possible deadlock by dropping pci_lock before waking up any
> config access waiters.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=192901
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/enumeration for v4.11.

> ---
>  drivers/pci/access.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index db239547fefd..68bd7201d8bc 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -684,8 +684,9 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
>  	WARN_ON(!dev->block_cfg_access);
>  
>  	dev->block_cfg_access = 0;
> -	wake_up_all(&pci_cfg_wait);
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
> +
> +	wake_up_all(&pci_cfg_wait);
>  }
>  EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

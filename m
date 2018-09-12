Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeILGL2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Sep 2018 02:11:28 -0400
Date: Tue, 11 Sep 2018 20:09:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH for-rc v2 3/3] IB/hfi1: Prefer new
 __pci_reset_function_locked() API with reset type
Message-ID: <20180912010929.GA118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180905160805.5680-1-okaya@kernel.org>
 <20180905160805.5680-3-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905160805.5680-3-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 04:08:05PM +0000, Sinan Kaya wrote:
> pci_reset_bus() is being called from the probe context and causes
> a deadlock since pci_reset_bus() also tries to obtain kernel lock.

This doesn't tell me what the deadlock is.

> Use __pci_reset_function_locked() that provides locking guarantees.

And the previous patch that adds the "reset_type" parameter doesn't
tell me anything about what locking guarantees it provides.

I want to merge minimal changes for v4.19 to fix the known problems.

It's not clear to me what actually broke hfi1.  You mention a deadlock
above, so I assume some locking change broke it, but 811c5cb37df4 isn't
obviously related to locking.

It's obvious that 811c5cb37df4 tested the return value of
pci_probe_reset_slot() incorrectly, so there's no problem with patch 1/1.

But patches 2 & 3:

  PCI: Request reset type as part of function reset
  IB/hfi1: Prefer new __pci_reset_function_locked() API with reset type

do not connect the dots for me.

> Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200985
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> index eec83757d55f..13162289b748 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -900,7 +900,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
>  	 * delay after a reset is required.  Per spec requirements,
>  	 * the link is either working or not after that point.
>  	 */
> -	return pci_reset_bus(dev);
> +	return __pci_reset_function_locked(dev, PCI_RESET_LINK);
>  }
>  
>  /*
> -- 
> 2.18.0
> 

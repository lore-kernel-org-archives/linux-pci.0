Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48037 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbdEPJXC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 May 2017 05:23:02 -0400
Date: Tue, 16 May 2017 12:22:48 +0300
From: Imre Deak <imre.deak@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v5 1/2] PCI / PM: Add needs_resume flag to avoid suspend
 complete optimization
Message-ID: <20170516092248.GA17645@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Thu, May 4 2017 at 12:48:35 +0300, Imre Deak wrote:
> Some drivers - like i915 - may not support the system suspend direct
> complete optimization due to differences in their runtime and system
> suspend sequence. Add a flag that when set resumes the device before
> calling the driver's system suspend handlers which effectively disables
> the optimization.
> 
> Needed by the next patch fixing suspend/resume on i915.
> 
> Suggested by Rafael.

Are you planning to merge this one patch via the pci tree? It's a
dependency for fixing a regression in the i915 driver.

Thanks,
Imre

> 
> v2-v3:
> - unchanged
> 
> v4:
> - Move the flag to dev_flags instead of using a bit field. (Rafael)
> 
> v5:
> - Rebase on pci/next branch using the free next enum number available.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@xxxxxxxxx>
> Cc: Bjorn Helgaas <bhelgaas@xxxxxxxxxx>
> Cc: linux-pci@xxxxxxxxxxxxxxx
> Cc: stable@xxxxxxxxxxxxxxx
> Signed-off-by: Imre Deak <imre.deak@xxxxxxxxx>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@xxxxxxxxx>
> 
> ---
> 
> [ Bjorn, could you apply this one patch to the pci tree? We would merge
>   the second patch via the drm-tip tree once this one shows up in Linus'
>   tree. ]
> ---
>  drivers/pci/pci.c   | 3 ++-
>  include/linux/pci.h | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b01bd5b..563901c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2144,7 +2144,8 @@ bool pci_dev_keep_suspended(struct pci_dev *pci_dev)
>  
>  	if (!pm_runtime_suspended(dev)
>  	    || pci_target_state(pci_dev) != pci_dev->current_state
> -	    || platform_pci_need_resume(pci_dev))
> +	    || platform_pci_need_resume(pci_dev)
> +	    || (pci_dev->dev_flags & PCI_DEV_FLAGS_NEEDS_RESUME))
>  		return false;
>  
>  	/*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 88185ff..ce82b60 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -183,6 +183,11 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT = (__force pci_dev_flags_t) (1 << 9),
>  	/* Do not use FLR even if device advertises PCI_AF_CAP */
>  	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
> +	/*
> +	 * Resume before calling the driver's system suspend hooks, disabling
> +	 * the direct_complete optimization.
> +	 */
> +	PCI_DEV_FLAGS_NEEDS_RESUME = (__force pci_dev_flags_t) (1 << 11),
>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 2.7.4

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:52597 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1173533AbdDXUCQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2017 16:02:16 -0400
Date: Mon, 24 Apr 2017 22:02:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI / PM: Add needs_resume flag to avoid suspend
 complete optimization
Message-ID: <20170424200230.GA9910@wunner.de>
References: <1493044063-2095-1-git-send-email-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493044063-2095-1-git-send-email-imre.deak@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 24, 2017 at 05:27:42PM +0300, Imre Deak wrote:
> Some drivers - like i915 - may not support the system suspend direct
> complete optimization due to differences in their runtime and system
> suspend sequence. Add a flag that when set resumes the device before
> calling the driver's system suspend handlers which effectively disables
> the optimization.

FWIW, there are at least two alternative solutions to this problem which
do not require changes to the PCI core:

(1) Add a ->prepare hook to i915_pm_ops which calls pm_runtime_get_sync()
    and a ->complete hook which calls pm_runtime_put().

(2) Assign a struct dev_pm_domain to the GPU which overrides the PCI
    ->prepare hook to return 0 unconditionally.  See here for an example:
    http://lxr.free-electrons.com/source/drivers/gpu/vga/vga_switcheroo.c#L1056

It may be worth considering approach (1) (which is the simpler of the two)
in favor of this patch.  Because I'm not sure there are many drivers that
will make use of this change to the PCI core.

It's unfortunate that the return value of PCI drivers' ->prepare hooks
has totally different semantics than that of bus types, thereby
necessitating such workarounds. :-(

Best regards,

Lukas

> 
> Needed by the next patch fixing suspend/resume on i915.
> 
> Suggested by Rafael.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/pci/pci.c   | 3 ++-
>  include/linux/pci.h | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7904d02..020f02d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2141,7 +2141,8 @@ bool pci_dev_keep_suspended(struct pci_dev *pci_dev)
>  
>  	if (!pm_runtime_suspended(dev)
>  	    || pci_target_state(pci_dev) != pci_dev->current_state
> -	    || platform_pci_need_resume(pci_dev))
> +	    || platform_pci_need_resume(pci_dev)
> +	    || pci_dev->needs_resume)
>  		return false;
>  
>  	/*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e2d1a12..3fe00a6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -316,6 +316,9 @@ struct pci_dev {
>  	unsigned int	hotplug_user_indicators:1; /* SlotCtl indicators
>  						      controlled exclusively by
>  						      user sysfs */
> +	unsigned int	needs_resume:1;	/* Resume before calling the driver's
> +					   system suspend hooks, disabling the
> +					   direct_complete optimization. */
>  	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
>  
> @@ -1113,6 +1116,10 @@ bool pci_check_pme_status(struct pci_dev *dev);
>  void pci_pme_wakeup_bus(struct pci_bus *bus);
>  void pci_d3cold_enable(struct pci_dev *dev);
>  void pci_d3cold_disable(struct pci_dev *dev);
> +static inline void pci_resume_before_suspend(struct pci_dev *dev, bool enable)
> +{
> +	dev->needs_resume = enable;
> +}
>  
>  static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
>  				  bool enable)
> -- 
> 2.5.0
> 

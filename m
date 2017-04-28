Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46499 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031559AbdD1VjS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2017 17:39:18 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Imre Deak <imre.deak@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI / PM: Add needs_resume flag to avoid suspend complete optimization
Date: Fri, 28 Apr 2017 23:33:02 +0200
Message-ID: <4849096.yzbfqj2AUz@aspire.rjw.lan>
In-Reply-To: <1493388963-5278-1-git-send-email-imre.deak@intel.com>
References: <1493388963-5278-1-git-send-email-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, April 28, 2017 05:16:02 PM Imre Deak wrote:
> Some drivers - like i915 - may not support the system suspend direct
> complete optimization due to differences in their runtime and system
> suspend sequence. Add a flag that when set resumes the device before
> calling the driver's system suspend handlers which effectively disables
> the optimization.
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

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The reason why the opt-out flag was not added on day one was because we were
not sure whether or not it would be necessary at all.

Quite evidently, it is needed.

> ---
> 
> [ After discussing with Jani, I'm going to apply this and the next patch
>   for now to the intel-gfx specific CI branch to unblock our testing. ]
> 
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
> index 5948cfd..2f012f8 100644
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
> @@ -1110,6 +1113,10 @@ bool pci_check_pme_status(struct pci_dev *dev);
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
> 

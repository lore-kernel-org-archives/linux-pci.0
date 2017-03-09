Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753747AbdCIWgT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Mar 2017 17:36:19 -0500
Date: Thu, 9 Mar 2017 16:27:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Message-ID: <20170309222751.GD19517@bhelgaas-glaptop.roam.corp.google.com>
References: <1489005551-23598-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489005551-23598-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Wed, Mar 08, 2017 at 03:39:11PM -0500, Sinan Kaya wrote:
> When the operating system is booted with the default ASPM policy
> (POLICY_DEFAULT), current code is querying the enable/disable
> states from ASPM registers to determine the policy.
> 
> For example, a BIOS could set the power saving state to performance
> and clear all ASPM control registers. A balanced ASPM policy could
> enable L0s and disable L1. A power conscious BIOS could enable both
> L0s and L1 to trade off latency and performance vs. power.
> 
> After hotplug removal, pcie_aspm_exit_link_state() function clears
> the ASPM registers. An insertion following hotplug removal reads
> incorrect policy as ASPM disabled even though ASPM was enabled
> during boot.
> 
> This is caused by the fact that same function is used for reconfiguring
> ASPM regardless of the of the power on state.
> 
> This patch builds some state info into pcie_aspm_cap_init() function.
> 
> Adding a flag and a counter to the struct pci_dev to save the
> power up policy in the bridge during boot. ASPM enable counter is
> used as a switch to determine when to use saved value.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
> ---
>  drivers/pci/pcie/aspm.c | 21 +++++++++++++++++----
>  include/linux/pci.h     |  2 ++
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 17ac1dc..63435b0 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -338,8 +338,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  	}
>  }
>  
> -static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> +static void pcie_aspm_cap_init(struct pci_dev *pdev, int blacklist)
>  {
> +	struct pcie_link_state *link = pdev->link_state;
>  	struct pci_dev *child, *parent = link->pdev;
>  	struct pci_bus *linkbus = parent->subordinate;
>  	struct aspm_register_info upreg, dwreg;
> @@ -397,8 +398,20 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
>  	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
>  
> -	/* Save default state */
> -	link->aspm_default = link->aspm_enabled;
> +	/*
> +	 * Save default state from FW when enabling ASPM for the first time
> +	 * during boot by looking at the calculated link->aspm_enabled bits
> +	 * above and aspm_enable_cnt will be zero.
> +	 *
> +	 * If this path is getting called for the second/third time
> +	 * (aspm_enable_cnt will be non-zero). Assume that the current state
> +	 * of the ASPM registers may not necessarily match what FW asked us to
> +	 * do as in the case of hotplug insertion/removal.
> +	 */
> +	if (atomic_inc_return(&pdev->aspm_enable_cnt) == 1)
> +		pdev->aspm_default = link->aspm_default = link->aspm_enabled;
> +	else
> +		link->aspm_default = pdev->aspm_default;

This is an aspect of the ASPM design that I don't like:

  - pcie_aspm_init_link_state() is called on a *bridge* after we've
    enumerated any devices below the bridge, and we allocate the
    link_state.

  - pcie_aspm_exit_link_state() is called on an *endpoint*, and if
    we're removing the last endpoint below a bridge, we release the
    *parent's* link_state.

This leads to the problem you're trying to solve here: we throw away
all the bridge's ASPM information when the child is removed, so we
lose the original settings from firmware.

Your solution is to add some state outside the link_state structure,
and initialize it the first time we enable ASPM for the link.  With
the current design, you don't really have much choice, but I think it
ends up being more complicated than it should be.

How hard do you think it would be to rework this path slightly so we:

  - call pcie_aspm_init_link_state() for every device, maybe from
    pci_init_capabilities()

  - for bridges, have pcie_aspm_init_link_state() allocate a
    link_state, regardless of whether it currently has any children,
    and save the ASPM settings done by firmware

  - for endpoints, have pcie_aspm_init_link_state() do the actual ASPM
    setup of the link as it currently does

  - for endpoints, change pcie_aspm_exit_link_state() so it cleans up
    the device's own state and disables ASPM if necessary, but doesn't
    remove the parent's link_state

  - for bridges, change pcie_aspm_exit_link_state() so it frees the
    bridge's own link_state

?

>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
> @@ -599,7 +612,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  	 * upstream links also because capable state of them can be
>  	 * update through pcie_aspm_cap_init().
>  	 */
> -	pcie_aspm_cap_init(link, blacklist);
> +	pcie_aspm_cap_init(pdev, blacklist);
>  
>  	/* Setup initial Clock PM state */
>  	pcie_clkpm_cap_init(link, blacklist);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e2d1a12..aa7bd7e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -321,6 +321,8 @@ struct pci_dev {
>  
>  #ifdef CONFIG_PCIEASPM
>  	struct pcie_link_state	*link_state;	/* ASPM link state */
> +	unsigned int	aspm_default;		/* ASPM policy set by BIOS */
> +	atomic_t	aspm_enable_cnt;	/* ASPM policy initialization */
>  #endif
>  
>  	pci_channel_state_t error_state;	/* current connectivity state */
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

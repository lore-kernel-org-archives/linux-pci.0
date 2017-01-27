Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 27 Jan 2017 11:07:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI/ASPM: reconfigure ASPM following hotplug
Message-ID: <20170127170755.GB17251@bhelgaas-glaptop.roam.corp.google.com>
References: <1485471092-16906-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1485471092-16906-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, cov@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Thu, Jan 26, 2017 at 05:51:32PM -0500, Sinan Kaya wrote:
> When the operating system is booted with the default ASPM policy,
> the current code is determining the ASPM policy by querying the
> enable/disable states from ASPM registers.
> 
> In the case of hotplug removal, the ASPM registers get cleared by
> calling the exit function.

I assume you mean pcie_aspm_exit_link_state().  It'd be easier if you
were specific about that.

But I don't know whether this is relevant anyway.  In a surprise
removal we won't call pcie_aspm_exit_link_state(), will we?

> An insertion following remove reads incorrect policy as disabled
> even though ASPM was enabled during boot.
> 
> Adding a flag to the struct pci_dev and saving the power up policy
> in the bridge to be reused during hotplug insertion. Bridge's enable
> counter is used as a switch to determine when to use saved value.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pcie/aspm.c | 13 ++++++++++---
>  include/linux/pci.h     |  1 +
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 17ac1dc..32b8a86 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -338,7 +338,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  	}
>  }
>  
> -static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> +static
> +void pcie_aspm_cap_init(struct pci_dev *pdev, struct pcie_link_state *link,
> +			int blacklist)
>  {
>  	struct pci_dev *child, *parent = link->pdev;
>  	struct pci_bus *linkbus = parent->subordinate;
> @@ -398,7 +400,12 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
>  
>  	/* Save default state */
> -	link->aspm_default = link->aspm_enabled;
> +	if (!atomic_read(&pdev->enable_cnt)) {
> +		link->aspm_default = link->aspm_enabled;
> +		pdev->aspm_default = link->aspm_default;
> +	} else {
> +		link->aspm_default = pdev->aspm_default;
> +	}

This connection with enable_cnt is too obtuse.  There's no obvious
connection between enabling the device and computing the default ASPM
state.

We're working on the bridge (the upstream end of a link).  If I
understand correctly, the case of interest here is where the bridge
stays put and an endpoint below the bridge is removed and re-added.
Why can't we figure out the policy the same way as when we first
enumerated the bridge?

In POLICY_PERFORMANCE and POLICY_POWERSAVE, I assume the original BIOS
configuration doesn't matter.  Maybe the point here is to remember the
original BIOS configuration for POLICY_DEFAULT?  If so, the patch
should mention POLICY_DEFAULT somehow to help the reader connect the
dots.

>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
> @@ -599,7 +606,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  	 * upstream links also because capable state of them can be
>  	 * update through pcie_aspm_cap_init().
>  	 */
> -	pcie_aspm_cap_init(link, blacklist);
> +	pcie_aspm_cap_init(pdev, link, blacklist);

I think "link" is always "pdev->link_state", so we should be able to
pass only "pdev" here, and pcie_aspm_cap_init() could use
pdev->link_state internally.

>  	/* Setup initial Clock PM state */
>  	pcie_clkpm_cap_init(link, blacklist);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e2d1a12..d0ecde6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -316,6 +316,7 @@ struct pci_dev {
>  	unsigned int	hotplug_user_indicators:1; /* SlotCtl indicators
>  						      controlled exclusively by
>  						      user sysfs */
> +	unsigned int	aspm_default;	/* aspm policy set by BIOS */

We already have an #ifdef CONFIG_PCIEASPM above, and this should go
under that.  "aspm" in English text is an acronym and should be
capitalized, just like "BIOS".

>  	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

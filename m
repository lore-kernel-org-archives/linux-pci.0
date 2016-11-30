Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0046.outbound.protection.outlook.com ([104.47.33.46]:60416
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758299AbcK3R1C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Nov 2016 12:27:02 -0500
Message-ID: <583F082F.1010701@caviumnetworks.com>
Date: Wed, 30 Nov 2016 09:11:11 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "Shawn Lin" <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>
Subject: Ping: [PATCH] PCI/ASPM: Don't retrain link if ASPM not possible.
References: <1479421501-31029-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1479421501-31029-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/17/2016 02:25 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> Some (defective) PCIe devices are not able to reliably do link
> retraining.
>
> Check to see if ASPM is possible between link partners before
> configuring common clocking, and doing the resulting link retraining.
> If ASPM is not possible, there is no reason to risk losing access to a
> device due to an unnecessary link retraining.
>

Hi Bjorn,

It has been a couple of weeks since I originally sent this, and I wanted 
to know if you have had a chance to look at it.  If possible, it would 
be nice to consider for the approaching merge window.

Thanks,
David Daney


> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>   drivers/pci/pcie/aspm.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 0ec649d..d6667db 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -351,12 +351,26 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>   		return;
>   	}
>
> +	/* Get upstream/downstream components' register state */
> +	pcie_get_aspm_reg(parent, &upreg);
> +	child = list_entry(linkbus->devices.next, struct pci_dev, bus_list);
> +	pcie_get_aspm_reg(child, &dwreg);
> +
> +	/*
> +	 * If ASPM not supported, don't mess with the clocks and link,
> +	 * bail out now.
> +	 */
> +	if (!(upreg.support & dwreg.support))
> +		return;
> +
>   	/* Configure common clock before checking latencies */
>   	pcie_aspm_configure_common_clock(link);
>
> -	/* Get upstream/downstream components' register state */
> +	/*
> +	 * Re-read upstream/downstream components' register state
> +	 * after clock configuration
> +	 */
>   	pcie_get_aspm_reg(parent, &upreg);
> -	child = list_entry(linkbus->devices.next, struct pci_dev, bus_list);
>   	pcie_get_aspm_reg(child, &dwreg);
>
>   	/*
>


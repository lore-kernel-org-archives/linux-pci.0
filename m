Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42752 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbcFQWwK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jun 2016 18:52:10 -0400
Date: Fri, 17 Jun 2016 17:52:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 07/13] PCI: pciehp: Ignore interrupts during D3cold
Message-ID: <20160617225204.GC10416@localhost>
References: <cover.1463134231.git.lukas@wunner.de>
 <98a243badc295903ec4cf7de5e2985b468c45907.1463134231.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <98a243badc295903ec4cf7de5e2985b468c45907.1463134231.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Mika, Rafael]

On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> If a hotplug port is suspended to D3cold, its slot status register
> cannot be read.  If that hotplug port happens to share its IRQ with
> other devices, then whenever an interrupt occurs for one of these
> devices, a "no response from device" message is logged with level
> KERN_INFO.  Apart from this annoyance, CPU time is needlessly spent
> trying to read the slot status register even though we know in advance
> that it will fail.

I guess this is a pretty generic problem that could affect any device
that shares an IRQ.

I think I'll queue this on my pci/pm branch, since it seems closely
related to Mika's "PCI: Add runtime PM support for PCIe ports".

Did you check for the same issue in other likely places, e.g., AER,
PME, etc.?

> On MacBook Pros introduced 2011 and 2012, the IRQ of a Thunderbolt
> hotplug port is unfortunately shared with a wireless card, an audio card
> and an SDXC controller.  When the Thunderbolt controller is powered
> down, the machine carries out at least one unneeded slot status register
> read for each wireless packet received and prints a corresponding error
> message to the system log.
> 
> The hotplug port's current_state will be D3cold when it's powered down,
> so ignore interrupts that occur during that power state.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 5c24e93..08e84d6 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -546,6 +546,10 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
>  	u8 present;
>  	bool link;
>  
> +	/* Interrupts cannot originate from a controller that's asleep */
> +	if (pdev->current_state == PCI_D3cold)
> +		return IRQ_NONE;
> +
>  	/*
>  	 * In order to guarantee that all interrupt events are
>  	 * serviced, we need to re-inspect Slot Status register after
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

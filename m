Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbdBFRyK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Feb 2017 12:54:10 -0500
Date: Mon, 6 Feb 2017 11:54:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Yinghai Lu <yinghai@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend
Message-ID: <20170206175405.GA15565@bhelgaas-glaptop.roam.corp.google.com>
References: <d1ae979d256631e7c189694a6d3e1a518abf3fc8.1486359844.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d1ae979d256631e7c189694a6d3e1a518abf3fc8.1486359844.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 06:54:37AM +0100, Lukas Wunner wrote:
> Since commit 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
> hotplug ports") we runtime suspend a hotplug port to D3hot when all its
> children are runtime suspended or none are present.
> 
> When runtime suspending the port the PCI core automatically enables PME:
>     pci_pm_runtime_suspend()
>         pci_finish_runtime_suspend()
>             __pci_enable_wake()
> 
> According to the PCI Express Base Specification, section 6.7.3.4:
>    "Note that PME and Hot-Plug Event interrupts (when both are
>     implemented) always share the same MSI or MSI-X vector [...]
>     If wake generation is required by the associated form factor
>     specification, a hot-plug capable Downstream Port must support
>     generation of a wakeup event (using the PME mechanism) on hotplug
>     events that occur when the system is in a sleep state or the Port
>     is in device state D1, D2, or D3Hot."
> 
> Thus, if the port is runtime suspended even though it is still occupied,
> it may immediately be woken by a PME interrupt.  

The spec goes on to say that a wakeup event should be generated when
all three of these conditions occur:

  - status register for an enabled [hotplug] event transitions from
    not set to set

  - Port is in D1, D2, or D3hot,

  - PME_En is set

I think you're saying that if we put a hotplug-capable port that
controls an occupied slot into D3hot, the port may immediately
generate a wakeup PME.

What is the hotplug event that causes generation of this wakeup event?

> One scenario where this
> happens is if all children of the hotplug port have runtime suspended.
> Another scenario is power control via sysfs:  If a user manually turns
> the hotplug port off (e.g. to safely remove the card), PME will signal
> an interrupt for the still-occupied slot, which is interpreted by pciehp
> as re-insertion of a card.  As a result, power control via sysfs is no
> longer possible.  This was observed and reported by Yinghai Lu.
> 
> PME is in fact unnecessary on hotplug ports:  Hotplug can be signaled
> even in D3hot,

How are hotplug events signaled in D3hot without using PME?  I'm
looking at the PCI PM spec, r1.2, table 5-4 (p 49 in my copy), which
says a function in D3hot can only generate PME.

> and commit 68db9bc81436 ensures that all parents of the
> hotplug port are kept awake so that interrupts can be delivered.
> PME would allow us to runtime suspend the parent ports as well, but we
> do not make use of it because we cannot be sure if PME actually works.
> Thunderbolt controllers for instance advertise PME capability, but at
> least on Macs the PME pin is not connected.
> 
> Since we do not rely on PME for hotplug ports, we may as well not enable
> it, thereby avoiding its negative side effects.  However the present
> commit deliberately only avoids enabling PME on runtime suspend, the
> ability to enable it for system sleep is retained.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193951
> Fixes: 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
>     hotplug ports")
> Reported-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> 
> v1-> v2:
>  Move check for is_hotplug_bridge from pci_finish_runtime_suspend()
>  down into pci_dev_run_wake(), this seems cleaner, less clumsy.
> 
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a881c0d..9c22e62 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2096,6 +2096,14 @@ bool pci_dev_run_wake(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->bus;
>  
> +	/*
> +	 * Don't enable PME at runtime on hotplug ports (even if supported)
> +	 * since PME sends unwanted interrupts if the slot is occupied while
> +	 * suspended to D3hot (PCIe Base Specification, section 6.7.3.4).
> +	 */
> +	if (dev->is_hotplug_bridge)
> +		return false;
> +
>  	if (device_run_wake(&dev->dev))
>  		return true;
>  
> -- 
> 2.11.0
> 

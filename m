Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbdBNUic (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Feb 2017 15:38:32 -0500
Date: Tue, 14 Feb 2017 14:38:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 2/8] PCI: Allow runtime PM on Thunderbolt ports
Message-ID: <20170214203827.GA19040@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1486913733.git.lukas@wunner.de>
 <656ca6114612a11469d4f124425437f7ac6803c6.1486913733.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <656ca6114612a11469d4f124425437f7ac6803c6.1486913733.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
> PCIe ports are only allowed to go to D3 if the BIOS is dated 2015+ to
> avoid potential issues with old chipsets.  However for Thunderbolt we
> know that even the oldest controller, Light Ridge (2010), is able to
> suspend its ports to D3 just fine.
> 
> We're about to add runtime PM for Thunderbolt on the Mac.  Apple has
> released multiple EFI updates since 2015 but not everyone has installed
> them (https://support.apple.com/en-us/HT201222).  Those users should
> still benefit from the achievable power saving.  Thus, special-case
> Thunderbolt in pci_bridge_d3_possible().
> 
> This allows the Thunderbolt controller to power down but the root port
> to which the Thunderbolt controller is attached remains in D0 unless
> an EFI update is installed.  Users can pass pcie_port_pm=force on the
> kernel command line if they cannot install an EFI update but still want
> to benefit from the additional power saving of putting the root port
> into D3.  In practice, root ports can be suspended to D3 without issues
> at least on 2012 Ivy Bridge machines.
> 
> If the BIOS cut-off date is ever lowered to 2010 and runtime PM is
> allowed on all native hotplug ports, the Thunderbolt special case can be
> removed.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Amir Levy <amir.jer.levy@intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7904d02ffdb9..441083a0d5b0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2224,7 +2224,7 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
>   * @bridge: Bridge to check
>   *
>   * This function checks if it is possible to move the bridge to D3.
> - * Currently we only allow D3 for recent enough PCIe ports.
> + * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
>   */
>  bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  {
> @@ -2253,6 +2253,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (pci_bridge_d3_force)
>  			return true;
>  
> +		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> +		if (bridge->is_thunderbolt)
> +			return true;

Does this whole function connect with anything in a spec?  For
example, I see how dev->pme_support, pci_pme_capable(), etc., relate
to PCI_PM_PMC in the PM Capability (PCI PM r1.1, sec 3.2.3).  But I'm
not a PM guy, so I'm kind of at a loss to see how
pci_bridge_d3_possible() is related to that.

My larger question is about dev->is_thunderbolt.  After the previous
patch, every device downstream of a Thunderbolt controller will be
marked "is_thunderbolt".  If I understand correctly, a downstream
device could be an arbitrary PCIe device totally unrelated to
Thunderbolt except that some upstream bridge is a Thunderbolt device.

I guess I'm just unclear on the purpose of pci_bridge_d3_possible().
The comment says "is it possible to move the bridge to D3".  I would
have expected that to involve PCI_PM_PMC and other questions of what
the hardware can do.  But I can't connect the dots.

>  		/*
>  		 * It should be safe to put PCIe ports from 2015 or newer
>  		 * to D3.
> -- 
> 2.11.0
> 

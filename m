Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbdA1XJc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Jan 2017 18:09:32 -0500
Date: Sat, 28 Jan 2017 17:00:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 3/8] PCI: Don't block runtime PM for Thunderbolt host
 hotplug ports
Message-ID: <20170128230020.GO20550@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1484486499.git.lukas@wunner.de>
 <be633737115c0be241fccd75bc136dd1da72c1b5.1484486499.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <be633737115c0be241fccd75bc136dd1da72c1b5.1484486499.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
> Hotplug ports generally block their parents from suspending to D3hot as
> otherwise their interrupts couldn't be delivered.

Well, the hotplug ports don't actually block anything.  We may decide
not to suspend the parent because normal PCIe hotplug ports deliver
interrupts through their parent, and if we suspend the parent to
D3hot, we won't get those interrupts.  I guess that's being pedantic.

> An exception are Thunderbolt host controllers:  They have a separate
> GPIO pin to side-band signal plug events even if the controller is
> powered down or its parent ports are suspended to D3.  They can be told
> apart from Thunderbolt controllers in attached devices by checking if
> they're situated below a non-Thunderbolt device (typically a root port,
> or the downstream port of a PCIe switch in the case of the MacPro6,1).
> 
> To enable runtime PM for Thunderbolt on the Mac, the downstream bridges
> of a host controller must not block runtime PM on the upstream bridge as
> power to the chip is only cut once the upstream bridge has suspended.
> Amend the condition in pci_dev_check_d3cold() accordingly.
> 
> This change does not impact non-Macs as their Thunderbolt hotplug ports
> are handled by the firmware rather than natively by the OS:  The hotplug
> ports are not allowed to suspend in pci_bridge_d3_possible() and keep
> their parent ports awake all the time.  Consequently it is meaningless
> whether they block runtime PM on their parent ports or not.

I think the references to Macs in the discussion above is confusing.
To cut power to a switch, I assume we have to suspend both upstream
and downstream ports whether it's plain PCIe or Thunderbolt, Mac or
not.

The "non-Mac Thunderbolt ports being handled by firmware" statement is
true today, but there's nothing intrinsic that makes it true; it could
change tomorrow.

> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Amir Levy <amir.jer.levy@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8ed098db82e1..e7a354cd13ce 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2269,6 +2269,24 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  	return false;
>  }
>  
> +static bool pci_hotplug_bridge_may_wakeup(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent, *grandparent;
> +
> +	/*
> +	 * Thunderbolt host controllers have a pin to side-band signal
> +	 * plug events.  Their hotplug ports are recognizable by having
> +	 * a non-Thunderbolt device as grandparent.

This comment should say something about the host controller vs.
attached device distinction you made in the changelog.

> +	 */
> +	if (dev->is_thunderbolt &&
> +	    (parent = pci_upstream_bridge(dev)) &&
> +	    (grandparent = pci_upstream_bridge(parent)) &&
> +	    !grandparent->is_thunderbolt)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
>  {
>  	bool *d3cold_ok = data;
> @@ -2284,7 +2302,7 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
>  	    !pci_power_manageable(dev) ||
>  
>  	    /* Hotplug interrupts cannot be delivered if the link is down. */

I think the point of this patch is that there are exceptions to the
statement in the comment, so please update the comment.

> -	    dev->is_hotplug_bridge)
> +	    (dev->is_hotplug_bridge && !pci_hotplug_bridge_may_wakeup(dev)))
>  
>  		*d3cold_ok = false;
>  
> -- 
> 2.11.0
> 

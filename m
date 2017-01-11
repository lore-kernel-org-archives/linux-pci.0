Return-Path: <SRS0=1VDW=YZ=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=1VDW=YZ=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 11 Jan 2017 12:02:10 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Amir Levy <amir.jer.levy@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 3/8] PCI: Don't block runtime PM for Thunderbolt host
 hotplug ports
Message-ID: <20170111100210.GL2330@lahna.fi.intel.com>
References: <cover.1483806825.git.lukas@wunner.de>
 <89e0512762e0062ad1f1884ebfaaf71e3b731237.1483806825.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <89e0512762e0062ad1f1884ebfaaf71e3b731237.1483806825.git.lukas@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 08, 2017 at 09:41:45AM +0100, Lukas Wunner wrote:
> Hotplug ports generally block their parents from suspending to D3hot as
> otherwise their interrupts couldn't be delivered.
> 
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
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Amir Levy <amir.jer.levy@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8ed098d..0b03fe7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2271,6 +2271,7 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  
>  static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
>  {
> +	struct pci_dev *parent, *grandparent;
>  	bool *d3cold_ok = data;
>  
>  	if (/* The device needs to be allowed to go D3cold ... */
> @@ -2284,7 +2285,17 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
>  	    !pci_power_manageable(dev) ||
>  
>  	    /* Hotplug interrupts cannot be delivered if the link is down. */
> -	    dev->is_hotplug_bridge)
> +	    (dev->is_hotplug_bridge &&
> +
> +		/*
> +		 * Exception:  Thunderbolt host controllers have a pin to
> +		 * side-band signal plug events.  Their hotplug ports are
> +		 * recognizable by having a non-Thunderbolt device as
> +		 * grandparent.
> +		 */
> +		!(dev->is_thunderbolt && (parent = pci_upstream_bridge(dev)) &&
> +				 (grandparent = pci_upstream_bridge(parent)) &&
> +						!grandparent->is_thunderbolt)))

Can you move this to its own helper function?

>  
>  		*d3cold_ok = false;
>  
> -- 
> 2.11.0

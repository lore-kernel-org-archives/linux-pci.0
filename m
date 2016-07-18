Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50711 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751251AbcGRNuO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2016 09:50:14 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 09/13] PCI: Do not write to PM control register while in D3cold
Date: Mon, 18 Jul 2016 15:55:06 +0200
Message-ID: <8931841.P295yLpjlt@vostro.rjw.lan>
In-Reply-To: <1741c0949a06c96a5bae9ef5d8eceaba8188730e.1463134232.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de> <1741c0949a06c96a5bae9ef5d8eceaba8188730e.1463134232.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, May 13, 2016 01:15:31 PM Lukas Wunner wrote:
> The PM control register is not accessible in D3cold so we shouldn't try
> writing to it in pci_raw_set_power_state() and return an error instead.
> 
> The current behaviour is fatal for devices which are not power-managed
> by the platform, yet can be runtime suspended to D3cold with some other
> mechanism by the driver:
> 
> - When the device is runtime resumed, pci_pm_runtime_resume() first
>   calls pci_restore_standard_config() which calls pci_set_power_state()
>   which calls pci_raw_set_power_state() to put the device into D0.
>   This fails since the device is still in D3cold.  It will be powered up
>   later on when pci_pm_runtime_resume() calls the driver's
>   ->runtime_resume callback.
> 
> - pci_raw_set_power_state() prints a message that the device refused to
>   change power state and returns 0.  Further up in the call stack,
>   pci_restore_standard_config() calls pci_restore_state(), which fails
>   since the device is in D3cold, but nevertheless invalidates the
>   saved_state.
> 
> - When pci_pm_runtime_resume() finally calls the driver ->runtime_resume
>   callback to power up the device, the saved_state is gone.
> 
> Return an error from pci_raw_set_power_state() to avoid this.
> 
> An example for devices affected by this are Thunderbolt controllers
> built into Macs which can be put into D3cold with nonstandard ACPI
> methods.
> 
> Unfortunately we rely on pci_raw_set_power_state()'s current behaviour
> in several places: When platform_pci_set_power_state() is called to wake
> a device from D3cold, its current_state is not updated even though it is
> no longer in D3cold.  Instead, pci_raw_set_power_state() is assumed to
> clean up the resulting incongruence.  Fix by setting current_state to
> PCI_UNKNOWN after platform_pci_set_power_state().
> 
> Also, when a bridge is put into D3cold, its children's current_state is
> changed to D3cold in __pci_complete_power_transition().  (Introduced by
> commit 448bd857d48e ("PCI/PM: add PCIe runtime D3cold support").) This
> doesn't necessarily reflect the children's actual power state: They may
> still be powered on, they're just no longer accessible.  However this
> shouldn't be a concern because if the children are accessed, their
> parent needs to resume anyway and the PM core takes care of this.
> Again, pci_raw_set_power_state() is relied upon to clean up the
> current_state when the children are resumed the next time.  We cannot
> reliably reconstruct the children's current_state when resuming their
> parent.  We also shouldn't blindly set it to PCI_UNKNOWN since some
> children may actually be turned off and D3cold is their correct
> current_state.  Therefore fix by no longer touching the children's
> current_state at all.
> 
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.c | 43 ++++++++++---------------------------------
>  1 file changed, 10 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95727b4..791dfe7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -612,6 +612,9 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>  	if (!dev->pm_cap)
>  		return -EIO;
>  
> +	if (dev->current_state == PCI_D3cold)
> +		return -EIO;
> +

I can agree with this.

>  	if (state < PCI_D0 || state > PCI_D3hot)
>  		return -EINVAL;
>  
> @@ -728,8 +731,10 @@ void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
>   */
>  void pci_power_up(struct pci_dev *dev)
>  {
> -	if (platform_pci_power_manageable(dev))
> +	if (platform_pci_power_manageable(dev)) {
>  		platform_pci_set_power_state(dev, PCI_D0);
> +		dev->current_state = PCI_UNKNOWN;

Why is this necessary?

> +	}
>  
>  	pci_raw_set_power_state(dev, PCI_D0);
>  	pci_update_current_state(dev, PCI_D0);
> @@ -746,8 +751,10 @@ static int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state)
>  
>  	if (platform_pci_power_manageable(dev)) {
>  		error = platform_pci_set_power_state(dev, state);
> -		if (!error)
> +		if (!error) {
> +			dev->current_state = PCI_UNKNOWN;

Again, why is this necessary?

>  			pci_update_current_state(dev, state);
> +		}
>  	} else
>  		error = -ENODEV;
>  
> @@ -809,30 +816,6 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
>  }
>  
>  /**
> - * __pci_dev_set_current_state - Set current state of a PCI device
> - * @dev: Device to handle
> - * @data: pointer to state to be set
> - */
> -static int __pci_dev_set_current_state(struct pci_dev *dev, void *data)
> -{
> -	pci_power_t state = *(pci_power_t *)data;
> -
> -	dev->current_state = state;
> -	return 0;
> -}
> -
> -/**
> - * __pci_bus_set_current_state - Walk given bus and set current state of devices
> - * @bus: Top bus of the subtree to walk.
> - * @state: state to be set
> - */
> -static void __pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
> -{
> -	if (bus)
> -		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
> -}
> -
> -/**
>   * __pci_complete_power_transition - Complete power transition of a PCI device
>   * @dev: PCI device to handle.
>   * @state: State to put the device into.
> @@ -841,15 +824,9 @@ static void __pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
>   */
>  int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state)
>  {
> -	int ret;
> -
>  	if (state <= PCI_D0)
>  		return -EINVAL;
> -	ret = pci_platform_power_transition(dev, state);
> -	/* Power off the bridge may power off the whole hierarchy */
> -	if (!ret && state == PCI_D3cold)
> -		__pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
> -	return ret;
> +	return pci_platform_power_transition(dev, state);
>  }
>  EXPORT_SYMBOL_GPL(__pci_complete_power_transition);

What about if powering off the bridge does remove power from the hierarchy
below?

Thanks,
Rafael


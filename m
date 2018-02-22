Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933427AbeBVRpN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 12:45:13 -0500
Date: Thu, 22 Feb 2018 11:45:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: dri-devel@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pierre Moreau <pierre.morrow@free.fr>,
        Bastien Nocera <hadess@hadess.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/7] PCI: Make pci_wakeup_bus() &
 pci_bus_set_current_state() public
Message-ID: <20180222174511.GA16519@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1518941072.git.lukas@wunner.de>
 <9d36522bc3d7e0ed1c1d5f653514d9fb0d34c0a8.1518941073.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9d36522bc3d7e0ed1c1d5f653514d9fb0d34c0a8.1518941073.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 18, 2018 at 09:38:32AM +0100, Lukas Wunner wrote:
> There are PCI devices which are power-manageable by a nonstandard means,
> such as a custom ACPI method.  One example are discrete GPUs in hybrid
> graphics laptops, another are Thunderbolt controllers in Macs.
> 
> Such devices can't be put into D3cold with pci_set_power_state() because
> pci_platform_power_transition() fails with -ENODEV.  Instead they're put
> into D3hot by pci_set_power_state() and subsequently into D3cold by
> invoking the nonstandard means.  However as a consequence the cached
> current_state is incorrectly left at D3hot.
> 
> What we need to do is walk the hierarchy below such a PCI device on
> powerdown and update the current_state to D3cold.  On powerup the PCI
> device itself and the hierarchy below it is in D0uninitialized, so we
> need to walk the hierarchy again and wake all devices, causing them to
> be put into D0active and then letting them autosuspend as they see fit.
> 
> To this end make pci_wakeup_bus() & pci_bus_set_current_state() public
> so PCI drivers don't have to reinvent the wheel.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c   | 8 ++++----
>  include/linux/pci.h | 2 ++
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f694650235f2..6e6e322a5a7d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -800,7 +800,7 @@ static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
>   * pci_wakeup_bus - Walk given bus and wake up devices on it
>   * @bus: Top bus of the subtree to walk.
>   */
> -static void pci_wakeup_bus(struct pci_bus *bus)
> +void pci_wakeup_bus(struct pci_bus *bus)
>  {
>  	if (bus)
>  		pci_walk_bus(bus, pci_wakeup, NULL);
> @@ -850,11 +850,11 @@ static int __pci_dev_set_current_state(struct pci_dev *dev, void *data)
>  }
>  
>  /**
> - * __pci_bus_set_current_state - Walk given bus and set current state of devices
> + * pci_bus_set_current_state - Walk given bus and set current state of devices
>   * @bus: Top bus of the subtree to walk.
>   * @state: state to be set
>   */
> -static void __pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
> +void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
>  {
>  	if (bus)
>  		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
> @@ -876,7 +876,7 @@ int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state)
>  	ret = pci_platform_power_transition(dev, state);
>  	/* Power off the bridge may power off the whole hierarchy */
>  	if (!ret && state == PCI_D3cold)
> -		__pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
> +		pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(__pci_complete_power_transition);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 024a1beda008..ae42289662df 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1147,6 +1147,8 @@ void pci_pme_wakeup_bus(struct pci_bus *bus);
>  void pci_d3cold_enable(struct pci_dev *dev);
>  void pci_d3cold_disable(struct pci_dev *dev);
>  bool pcie_relaxed_ordering_enabled(struct pci_dev *dev);
> +void pci_wakeup_bus(struct pci_bus *bus);
> +void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state);
>  
>  /* PCI Virtual Channel */
>  int pci_save_vc_state(struct pci_dev *dev);
> -- 
> 2.15.1
> 

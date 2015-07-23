Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55B0F91A.7020206@ti.com>
Date: Thu, 23 Jul 2015 10:24:26 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: <linux@arm.linux.org.uk>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM/PCI: set MPS before pci_bus_add_devices()
References: <1437514519-18545-1-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1437514519-18545-1-git-send-email-m-karicheri2@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/21/2015 05:35 PM, Murali Karicheri wrote:
> The MPS configuration should be done *before* pci_bus_add_devices().
> After pci_bus_add_devices(), drivers may be bound to devices, and
> the PCI core shouldn't touch device configuration while a driver
> owns the device.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   arch/arm/kernel/bios32.c | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index fcbbbb1..17efde7 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -520,7 +520,8 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
>   	list_for_each_entry(sys, &head, node) {
>   		struct pci_bus *bus = sys->bus;
>
> -		if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +		if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
> +			struct pci_bus *child;
>   			/*
>   			 * Size the bridge windows.
>   			 */
> @@ -530,25 +531,15 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
>   			 * Assign resources.
>   			 */
>   			pci_bus_assign_resources(bus);
> -		}
>
> +			list_for_each_entry(child, &bus->children, node)
> +				pcie_bus_configure_settings(child);
> +		}
>   		/*
>   		 * Tell drivers about devices found.
>   		 */
>   		pci_bus_add_devices(bus);
>   	}
> -
> -	list_for_each_entry(sys, &head, node) {
> -		struct pci_bus *bus = sys->bus;
> -
> -		/* Configure PCI Express settings */
> -		if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
> -			struct pci_bus *child;
> -
> -			list_for_each_entry(child, &bus->children, node)
> -				pcie_bus_configure_settings(child);
> -		}
> -	}
>   }
>
>   #ifndef CONFIG_PCI_HOST_ITE8152
>
Bjorn,

When you get a chance, please review this. We discussed this change in a 
separate thread and agreed for a patch from me.

Thanks and regards

-- 
Murali Karicheri
Linux Kernel, Keystone

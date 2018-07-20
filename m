Return-Path: <SRS0=DcJx=KE=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=DcJx=KE=h08.hostsharing.net=foo00@kernel.org>
Date: Fri, 20 Jul 2018 10:18:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [pci:pci/hotplug 34/35] drivers/pci/pci.c:2311:37: error:
 implicit declaration of function 'pciehp_is_native'; did you mean
 'pcie_ports_native'?
Message-ID: <20180720081841.GA9952@wunner.de>
References: <201807200731.O8W2VHW6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201807200731.O8W2VHW6%fengguang.wu@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 20, 2018 at 07:53:33AM +0800, kbuild test robot wrote:
> commit: 50b623f07b02fc48e4d7d3e8b5a302abf40b3a7a [34/35] PCI: Whitelist native hotplug ports for runtime D3
> 
>    drivers/pci/pci.c: In function 'pci_bridge_d3_possible':
> >> drivers/pci/pci.c:2311:37: error: implicit declaration of function 'pciehp_is_native'; did you mean 'pcie_ports_native'? [-Werror=implicit-function-declaration]
>       if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
>                                         ^~~~~~~~~~~~~~~~
>                                         pcie_ports_native
>    cc1: some warnings being treated as errors

Hm, there is a conflict on the pci/hotplug branch wherein commit
"PCI: hotplug: Implement hotplug_is_native() only when CONFIG_ACPI=y"
removes the pciehp_is_native() declaration for the CONFIG_ACPI=n
case (because there was previously only one caller of that function
and that caller depended on CONFIG_ACPI=y), but the succeeding commit
"PCI: Whitelist native hotplug ports for runtime D3" now adds another
caller of that function which also exists in the CONFIG_ACPI=n case.

Can the former commit be amended to leave the pciehp_is_native()
declaration in place for CONFIG_ACPI=n?

I'm wondering if we should be checking hotplug_is_native() instead of
pciehp_is_native() in pci_bridge_d3_possible().  There appears to be
an ordering issue if we do that because shpchp_is_native() checks
bridge->shpc_managed, but that is only set to true by shpc_probe().
Now the problem is, the shpc pci_driver is registered with module_init().
If shpc is built-in, that becomes a device_initcall().

And pci_bridge_d3_possible() is called from pcie_portdrv_probe(),
and portdrv is also registered with a device_initcall().

Thus, if hotplug_is_native() is called from pci_bridge_d3_possible(),
it's result in the shpc case depends on the link order if shpc is
built-in.  If shpc is a module, it will always return false for the
shpc case.

I'm sorry, I'm pretty clueless about shpc and whether or not portdrv
should activate runtime PM whether an shpc port is controlled by
the firmware.

Thanks,

Lukas

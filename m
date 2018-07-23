Return-Path: <SRS0=jfRc=KH=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=jfRc=KH=linux.intel.com=mika.westerberg@kernel.org>
Date: Mon, 23 Jul 2018 09:39:16 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [pci:pci/hotplug 34/35] drivers/pci/pci.c:2311:37: error:
 implicit declaration of function 'pciehp_is_native'; did you mean
 'pcie_ports_native'?
Message-ID: <20180723063916.GT2534@lahna.fi.intel.com>
References: <201807200731.O8W2VHW6%fengguang.wu@intel.com>
 <20180720081841.GA9952@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180720081841.GA9952@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 20, 2018 at 10:18:41AM +0200, Lukas Wunner wrote:
> I'm wondering if we should be checking hotplug_is_native() instead of
> pciehp_is_native() in pci_bridge_d3_possible().  There appears to be
> an ordering issue if we do that because shpchp_is_native() checks
> bridge->shpc_managed, but that is only set to true by shpc_probe().
> Now the problem is, the shpc pci_driver is registered with module_init().
> If shpc is built-in, that becomes a device_initcall().
> 
> And pci_bridge_d3_possible() is called from pcie_portdrv_probe(),
> and portdrv is also registered with a device_initcall().
> 
> Thus, if hotplug_is_native() is called from pci_bridge_d3_possible(),
> it's result in the shpc case depends on the link order if shpc is
> built-in.  If shpc is a module, it will always return false for the
> shpc case.
> 
> I'm sorry, I'm pretty clueless about shpc and whether or not portdrv
> should activate runtime PM whether an shpc port is controlled by
> the firmware.

We only enable D3 for PCIe ports in pci_bridge_d3_possible(). We don't
do it for conventional PCI so I think calling pciehp_is_native() there
is the right thing to do.

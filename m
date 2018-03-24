Return-Path: <SRS0=8W8s=GO=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=8W8s=GO=h08.hostsharing.net=foo00@kernel.org>
Date: Sat, 24 Mar 2018 14:48:07 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
Message-ID: <20180324134807.GA2627@wunner.de>
References: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0gOrQhXzLHDnABEYHxGbHVY89Nij9uQzqx-oyYmFwzuSg@mail.gmail.com>
 <20180314120547.GB2703@lahna.fi.intel.com>
 <20180314123332.GC19651@wunner.de>
 <20180320104508.GF2703@lahna.fi.intel.com>
 <20180320113556.GA24197@wunner.de>
 <20180322104517.GA20389@wunner.de>
 <20180322165317.GI2703@lahna.fi.intel.com>
 <20180322173903.GA15503@wunner.de>
 <20180322193630.GB252023@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180322193630.GB252023@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 22, 2018 at 02:36:30PM -0500, Bjorn Helgaas wrote:
> I hope we can avoid adding suspend_late/resume_early callbacks in
> struct pcie_port_service_driver,

I'm fairly certain that we cannot avoid adding at least a ->resume_noirq
callback to struct pcie_port_service_driver to fix a pciehp use case:

On ->resume_noirq the PCI core walks down the hierarchy to put every
device in D0 and restore its state (with a few exceptions such as direct
complete).  However with hotplug ports, it's possible that the user has
unplugged devices while the system was asleep, or replaced them with
other devices.  That's a very real use case with Thunderbolt and we're
handling it poorly or not at all currently.  We need to check if the
devices below a hotplug port are still there or have been replaced
(can probably be recognized by looking at vendor/device IDs across the
entire sub-hierarchy) during the ->resume_noirq phase.  We could mark
them with pci_dev_set_disconnected(), then skip putting them into D0
if that flag has been set.


> @@ -102,7 +88,6 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.thaw		= pcie_port_device_resume,
>  	.poweroff	= pcie_port_device_suspend,
>  	.restore	= pcie_port_device_resume,
> -	.resume_noirq	= pcie_port_resume_noirq,
>  	.runtime_suspend = pcie_port_runtime_suspend,
>  	.runtime_resume	= pcie_port_runtime_resume,
>  	.runtime_idle	= pcie_port_runtime_idle,

So the above would have to be reverted unfortunately when we fix this
use case.

Thanks,

Lukas

Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 24 Mar 2018 09:09:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
Message-ID: <20180324140950.GG210003@bhelgaas-glaptop.roam.corp.google.com>
References: <CAJZ5v0gOrQhXzLHDnABEYHxGbHVY89Nij9uQzqx-oyYmFwzuSg@mail.gmail.com>
 <20180314120547.GB2703@lahna.fi.intel.com>
 <20180314123332.GC19651@wunner.de>
 <20180320104508.GF2703@lahna.fi.intel.com>
 <20180320113556.GA24197@wunner.de>
 <20180322104517.GA20389@wunner.de>
 <20180322165317.GI2703@lahna.fi.intel.com>
 <20180322173903.GA15503@wunner.de>
 <20180322193630.GB252023@bhelgaas-glaptop.roam.corp.google.com>
 <20180324134807.GA2627@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180324134807.GA2627@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 24, 2018 at 02:48:07PM +0100, Lukas Wunner wrote:
> On Thu, Mar 22, 2018 at 02:36:30PM -0500, Bjorn Helgaas wrote:
> > I hope we can avoid adding suspend_late/resume_early callbacks in
> > struct pcie_port_service_driver,
> 
> I'm fairly certain that we cannot avoid adding at least a ->resume_noirq
> callback to struct pcie_port_service_driver to fix a pciehp use case:
> 
> On ->resume_noirq the PCI core walks down the hierarchy to put every
> device in D0 and restore its state (with a few exceptions such as direct
> complete).  However with hotplug ports, it's possible that the user has
> unplugged devices while the system was asleep, or replaced them with
> other devices.  That's a very real use case with Thunderbolt and we're
> handling it poorly or not at all currently.  We need to check if the
> devices below a hotplug port are still there or have been replaced
> (can probably be recognized by looking at vendor/device IDs across the
> entire sub-hierarchy) during the ->resume_noirq phase.  We could mark
> them with pci_dev_set_disconnected(), then skip putting them into D0
> if that flag has been set.

This is definitely a real issue, and I think it affects more than just
Thunderbolt.  We've never handled undocks very well either.

I certainly agree we need a way to handle this; I would just rather do
it by integrating pciehp and the other services more directly into the
PCI core instead of using the port driver.  Maybe we'll need a
short-term ->resume_noirq, but I don't think the port driver is a good
long-term solution.

Bjorn

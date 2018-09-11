Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 11 Sep 2018 11:53:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 05/10] PCI: portdrv: Resume upon exit from system suspend
 if left runtime suspended
Message-ID: <20180911095340.w2lkv3rycl63hiwk@wunner.de>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
 <20180906155020.51700-6-mika.westerberg@linux.intel.com>
 <20180911082935.gwcwqnk7ohwencui@wunner.de>
 <20180911090817.GS14465@lahna.fi.intel.com>
 <20180911092630.ibn36j54zamhrcoh@wunner.de>
 <20180911094144.GX14465@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180911094144.GX14465@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 11, 2018 at 12:41:44PM +0300, Mika Westerberg wrote:
> On Tue, Sep 11, 2018 at 11:26:30AM +0200, Lukas Wunner wrote:
> > On Tue, Sep 11, 2018 at 12:08:17PM +0300, Mika Westerberg wrote:
> > > On Tue, Sep 11, 2018 at 10:29:35AM +0200, Lukas Wunner wrote:
> > > > On Thu, Sep 06, 2018 at 06:50:15PM +0300, Mika Westerberg wrote:
> > > > > Currently we try to keep PCIe ports runtime suspended over system
> > > > > suspend if possible. This mostly happens when entering suspend-to-idle
> > > > > because there is no need to re-configure wake settings.
> > > > > 
> > > > > This causes problems if the parent port goes into D3cold and it gets
> > > > > resumed upon exit from system suspend. This may happen for example if
> > > > > the port is part of PCIe switch and the same switch is connected to a
> > > > > PCIe endpoint that needs to be resumed. The way exit from D3cold works
> > > > > according PCIe 4.0 spec 5.3.1.4.2 is that power is restored and cold
> > > > > reset is signaled. After this the device is in D0unitialized state
> > > > > keeping PME context if it supports wake from D3cold.
> > > > > 
> > > > > The problem occurs when a PCIe hotplug port is left suspended and the
> > > > > parent port goes into D3cold and back to D0, the port keeps its PME
> > > > > context but since everything else is reset back to defaults
> > > > > (D0unitialized) it is not set to detect hotplug events anymore.
> > > > 
> > > > We call pci_wakeup_bus() in __pci_start_power_transition() for this
> > > > reason.  Why isn't that sufficient in your use case?
> > > 
> > > It would otherwise but __pci_start_power_transition() is never called
> > > because the bridge is left suspended.
> > 
> > You write above that the parent goes to D0, now you say it is left
> > suspended.  Which one is it?
> 
> The port below the parent is left suspended -- the hotplug port.
> 
> Once the upstream port of a PCIe switch is resumed to D0 it will be
> reset and that reset is propagated to other ports in that switch so it
> makes the hotplug port go to D0uninitialized as well.

Yes, but as said when the PCI core runtime resumes the upstream port to D0,
__pci_start_power_transition() should call pci_wakeup_bus() to wake all
devices on its subordinate bus, i.e. all the Downstream Ports, including
hotplug ports.  So they're runtime resumed as well and thus pass from
D0uninitialized to D0initialized.  Is pci_wakeup_bus() not called in your
case, and if so, why not?


> > > > > For this reason change the PCIe portdrv power management logic so that
> > > > > it is fine to keep the port runtime suspended over system suspend but it
> > > > > needs to be resumed upon exit to make sure it gets properly re-initialized.
> > > > > The custom ->prepare() hook with DPM_FLAG_SMART_PREPARE is needed
> > > > > because otherwise pci_pm_prepare() instructs the PM core to go directly
> > > > > to pci_pm_complete() on resume and this skips resuming the port.
> > > > 
> > > > On Macs, if no Thunderbolt device is attached, it is perfectly okay to
> > > > use direct complete and it is also perfectly okay to leave the entire
> > > > controller (including all its PCIe ports) in D3cold when coming out of
> > > > system sleep.  In fact it would be unnecessary and undesirable to
> > > > runtime resume the controller, it would just waste energy for no reason.
> > > 
> > > I'm surprised if it works like that because both PCIe spec and
> > > conventional PCI spec both require reset after D3cold and the only state
> > > for a function after that is D0uninitialized.
> > 
> > The controller is in D3cold when coming out of system sleep if it was in
> > D3cold when sytem sleep commenced.
> 
> In that case if the whole chain is left in D3cold over system sleep
> there is no issue. But at least with the Thunderbolt controllers I've
> been dealing with, the xHCI (or the USB stack) that is part of the PCIe
> switch wants to resume the controller and that also resumes the upstream
> port and the root port which leads to this situation. I did not check
> Apple systems, though but I thought they also include xHCI.

They do not if they're older than Alpine Ridge of course.

Thanks,

Lukas

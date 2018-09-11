Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 11 Sep 2018 12:08:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 05/10] PCI: portdrv: Resume upon exit from system suspend
 if left runtime suspended
Message-ID: <20180911090817.GS14465@lahna.fi.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
 <20180906155020.51700-6-mika.westerberg@linux.intel.com>
 <20180911082935.gwcwqnk7ohwencui@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180911082935.gwcwqnk7ohwencui@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 11, 2018 at 10:29:35AM +0200, Lukas Wunner wrote:
> On Thu, Sep 06, 2018 at 06:50:15PM +0300, Mika Westerberg wrote:
> > Currently we try to keep PCIe ports runtime suspended over system
> > suspend if possible. This mostly happens when entering suspend-to-idle
> > because there is no need to re-configure wake settings.
> > 
> > This causes problems if the parent port goes into D3cold and it gets
> > resumed upon exit from system suspend. This may happen for example if
> > the port is part of PCIe switch and the same switch is connected to a
> > PCIe endpoint that needs to be resumed. The way exit from D3cold works
> > according PCIe 4.0 spec 5.3.1.4.2 is that power is restored and cold
> > reset is signaled. After this the device is in D0unitialized state
> > keeping PME context if it supports wake from D3cold.
> > 
> > The problem occurs when a PCIe hotplug port is left suspended and the
> > parent port goes into D3cold and back to D0, the port keeps its PME
> > context but since everything else is reset back to defaults
> > (D0unitialized) it is not set to detect hotplug events anymore.
> 
> We call pci_wakeup_bus() in __pci_start_power_transition() for this
> reason.  Why isn't that sufficient in your use case?

It would otherwise but __pci_start_power_transition() is never called
because the bridge is left suspended.

> > For this reason change the PCIe portdrv power management logic so that
> > it is fine to keep the port runtime suspended over system suspend but it
> > needs to be resumed upon exit to make sure it gets properly re-initialized.
> > The custom ->prepare() hook with DPM_FLAG_SMART_PREPARE is needed
> > because otherwise pci_pm_prepare() instructs the PM core to go directly
> > to pci_pm_complete() on resume and this skips resuming the port.
> 
> On Macs, if no Thunderbolt device is attached, it is perfectly okay to
> use direct complete and it is also perfectly okay to leave the entire
> controller (including all its PCIe ports) in D3cold when coming out of
> system sleep.  In fact it would be unnecessary and undesirable to
> runtime resume the controller, it would just waste energy for no reason.

I'm surprised if it works like that because both PCIe spec and
conventional PCI spec both require reset after D3cold and the only state
for a function after that is D0uninitialized.

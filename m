Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Peter Wu <peter@lekensteyn.nl>, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>, Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Power on bridges before scanning new devices
Date: Wed, 25 May 2016 22:45:48 +0200
Message-ID: <2037523.0hP3Oc7Pg6@vostro.rjw.lan>
In-Reply-To: <20160525131948.GL1789@lahna.fi.intel.com>
References: <20160519231234.GB1785@al> <20160524211309.GH1789@lahna.fi.intel.com> <20160525131948.GL1789@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, May 25, 2016 04:19:48 PM Mika Westerberg wrote:
> On Wed, May 25, 2016 at 12:13:09AM +0300, Mika Westerberg wrote:
> > On Tue, May 24, 2016 at 03:53:23PM +0300, Mika Westerberg wrote:
> > > > I dropped "ACPI / hotplug / PCI: Runtime resume bridge before rescan"
> > > > on the assumption that "PCI: Power on bridges before scanning new
> > > > devices" is sufficient to cover both the ACPI and the generic PCi
> > > > rescan cases, but I'd like some reassurance about that.
> > > 
> > > I agree with your reasoning that the patch should not be needed anymore.
> > > However, I have the machine which needed that patch at home so I'm not
> > > able to test it now. I'll do that later today when I get back home.
> > 
> > I tried now on my Lenovo Yoga 900 laptop and unfortunately "PCI: Power
> > on bridges before scanning new devices" seems not to be enough. This
> > machine has SD-card reader connected to one PCIe port and once I unload
> > the sdhci-pci driver and enable runtime PM for the device, next system
> > suspend/resume cycle loses the SD-card reader PCI device.
> > 
> > I will investigate more tomorrow -- it is getting late here.
> 
> I think I found reason for the issue.
> 
> When the laptop resumes it will send ACPI BUS_CHECK event for the two
> PCIe root ports. This ends up in acpiphp_check_bridge() where it goes
> through all slots in that bridge checking if the devices are still
> present. This happens before we call pci_scan_bridge() for the bridge
> itself.
> 
> Since the bridge is in D3 config space of the device behind it is not
> available and we determine that the device is not there anymore.
> 
> It looks like we either need that ACPI hotplug patch or alternatively we
> could add pm_runtime_get/put() in acpiphp_check_bridge().

Have you tried the latter?

Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Wed, 25 May 2016 00:13:09 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Peter Wu <peter@lekensteyn.nl>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Power on bridges before scanning new devices
Message-ID: <20160524211309.GH1789@lahna.fi.intel.com>
References: <20160519231234.GB1785@al>
 <1463991648-85051-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160523200042.GB24375@localhost>
 <20160523215015.GA31479@localhost>
 <20160524122357.GA20453@localhost>
 <20160524125323.GE1789@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160524125323.GE1789@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 24, 2016 at 03:53:23PM +0300, Mika Westerberg wrote:
> > I dropped "ACPI / hotplug / PCI: Runtime resume bridge before rescan"
> > on the assumption that "PCI: Power on bridges before scanning new
> > devices" is sufficient to cover both the ACPI and the generic PCi
> > rescan cases, but I'd like some reassurance about that.
> 
> I agree with your reasoning that the patch should not be needed anymore.
> However, I have the machine which needed that patch at home so I'm not
> able to test it now. I'll do that later today when I get back home.

I tried now on my Lenovo Yoga 900 laptop and unfortunately "PCI: Power
on bridges before scanning new devices" seems not to be enough. This
machine has SD-card reader connected to one PCIe port and once I unload
the sdhci-pci driver and enable runtime PM for the device, next system
suspend/resume cycle loses the SD-card reader PCI device.

I will investigate more tomorrow -- it is getting late here.

Anyway, maybe it is safer to postpone this series for v4.8 to give it
more testing time in -next.

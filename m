Return-Path: <SRS0=GJvY=BM=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=GJvY=BM=chromium.org=briannorris@kernel.org>
Date: Fri, 13 Oct 2017 13:44:00 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: jeffy <jeffy.chen@rock-chips.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	shawn.lin@rock-chips.com, dianders@chromium.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20171013204358.GA3585@google.com>
References: <20170911151029.25185-1-jeffy.chen@rock-chips.com>
 <20170911151029.25185-2-jeffy.chen@rock-chips.com>
 <20171013030441.GA25517@bhelgaas-glaptop.roam.corp.google.com>
 <2453698.N4jfPaHx71@aspire.rjw.lan>
 <59E10709.4020300@rock-chips.com>
 <20171013191906.GF25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171013191906.GF25517@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Fri, Oct 13, 2017 at 02:19:06PM -0500, Bjorn Helgaas wrote:
> On Sat, Oct 14, 2017 at 02:33:45AM +0800, jeffy wrote:
> > Hi Rafael,
> > 
> > On 10/13/2017 09:21 PM, Rafael J. Wysocki wrote:
> > >>
> > >>I'm a little skeptical about dev_pm_set_dedicated_wake_irq(), not
> > >>because I know anything at all about it, but because there are only
> > >>five callers in the whole tree, three of which are in UART code, and
> > >>none in anything resembling PCI code.
> > >>
> > >>Is Rockchip really that special, or are we going about this the wrong
> > >>way?
> > 
> > we used to put these codes in the wifi driver, but another wifi
> > vendor suggests these should go into the pcie driver.
> > 
> > and as tony said, it could go into pcie common code :)
> 
> I guess the implication (I'm speculating here) is that in most
> existing cases, the WAKE# signal is fielded by an ACPI BIOS, which
> knows how it's connected.  I suppose that would end up being turned
> into an SCI that Linux already knows how to handle generically.

I wasn't sure how ACPI did this when I first suggested Rockchip take
this approach, but since then I believe have figured it out. We have:

pci_prepare_to_sleep() -> pci_enable_wake()

where pci_enable_wake() will configure PME wakeup and/or "platform" wake
(which presumably is the WAKE# signal). pci-acpi.c has registered hooks
for the latter via pci_set_platform_pm().

This doesn't really make it any more generic for discovering this
platform-specific detail. We'd have to set up some kind of platform ops
that could be shared for any DT-based platforms.

But that *does* answer the question I had about conditionality: should
we always enable WAKE# for platforms that have the pin hooked up to the
host? Or is this configured on a per-device basis? IIUC, the intention
is that there's only a single open-drain WAKE# pin for the whole system,
and it's just pulled high for EPs that don't implement it.

> And further, that the non-ACPI drivers are relatively new and you're
> the first attempt to use WAKE# with a non-ACPI PCI host driver?

Quite possibly. Or everyone just sidestepped this an configured the pin
elsewhere (e.g., you could stick a GPIO like this into a gpio-keys
device and it would mostly work).

> If this setup could be done somewhere in PCIe common code, that would
> be great.  We have so much copy and pasted code already, it'd be nice
> to avoid adding more.  I don't know if this would fit in
> pci_scan_root_bus_bridge(), doing something like dma_configure() does
> to get hold of a struct platform_device * or a struct device * so you
> could lookup the IRQ?

It looks like the infrastructure is in pci_set_platform_pm(), sort of.
But that still doesn't help you for the repetition; you're just lucky
you only have 2 controller drivers that call this right now :)

Side note: there's some dissonance between this statement, in
Documentation/driver-api/pm/devices.rst:

"Device drivers, however, are not expected to call
:c:func:`device_set_wakeup_enable()` directly in any case."

Yet:

$ git grep -l device_set_wakeup_enable drivers/ | wc -l
69

And particularly, I believe that was necessary for Wifi drivers like
drivers/net/wireless/ath/ath10k/wow.c.

Brian

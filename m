Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Tue, 31 May 2016 11:58:05 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>, Peter Wu <peter@lekensteyn.nl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Wait for 50ms after bridge is powered up
Message-ID: <20160531085805.GI1743@lahna.fi.intel.com>
References: <20160524162833.GA30762@localhost>
 <20160526104557.GA6816@wunner.de>
 <20160526110308.GX1789@lahna.fi.intel.com>
 <1576190.gfFb6HhZV6@vostro.rjw.lan>
 <20160530093326.GH1789@lahna.fi.intel.com>
 <20160530144445.GC1743@lahna.fi.intel.com>
 <CAMxnaaXhapETZYMVe6EUoBGaMtxL_fP+uzc30SQpM+6EqPF3CQ@mail.gmail.com>
 <20160531083349.GG1743@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160531083349.GG1743@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 31, 2016 at 11:33:49AM +0300, Mika Westerberg wrote:
> On Mon, May 30, 2016 at 05:19:53PM +0200, Andreas Noever wrote:
> > On Mon, May 30, 2016 at 4:44 PM, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > On Mon, May 30, 2016 at 12:33:26PM +0300, Mika Westerberg wrote:
> > >> I also learned that both of these can be shortened with following
> > >> mechanisms:
> > >>
> > >>  - PCIe readines notifications (6.23 in PCIe spec 3.1a)
> > >>  - ACPI _DSM method returning readines durations from  (4.6.9 in PCI
> > >>    firmware spec 3.2).
> > >
> > > BTW, looks like the latter is already implemented in
> > > pci_acpi_optimize_delay().
> > 
> > 
> > Hmm, Lukas's trace suggest a few independent problems (or optimisations):
> > 1. Those devices are siblings, we should wake all of them in parallel
> > and then wait once instead of one by one.
> > 2. Why are we waiting after _suspend at all? It seems we should only
> > wait before the next access. Sleeping after _suspend looks like a stop
> > gap measure to guarantee that no accesses take place?
> 
> I guess it is because PCI PM spec says that the delay needs to be in
> both directions. See table 5-6 in PCI PM spec v1.2.
> 
> The code in question is in pci_raw_set_power_state():
> 
>         /* Mandatory power management transition delays */
>         /* see PCI PM 1.1 5.6.1 table 18 */
>         if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
>                 pci_dev_d3_sleep(dev);
>         else if (state == PCI_D2 || dev->current_state == PCI_D2)
>                 udelay(PCI_PM_D2_DELAY);
> 
> > 3. The idle timeout is too low, there should be no suspend between
> > discovery and probing.
> 
> I agree. We took the 10ms from the original patch but I don't see why we
> could not increase it to 100ms or even 500ms.
> 
> > 4. Even if the spec says 50ms, we might still want to have shorter
> > sleep times for known good devices. Thunderbolt can produce PCI
> > hierarchies which are 7 levels deep with 4 hp bridges on each level.
> > Waking all of that would take 50ms * 7 * 4 = 1400ms (not counting
> > upstream bridges which have the normal d3 delay).
> 
> PCIe spec want to have 100ms delay from when transitioning from D3cold
> to D0 and we already do that in __pci_start_power_transition().
> 
> In other words we should have all necessary delays for PCIe in place
> already. This patch should not be needed.

To summarize the next steps. I will send new version of the
PCI PM patches with following changes.

  - Drop this 50ms patch, we should have the PCIe 100ms delay already
    covered.

  - Increase runtime PM autosuspend time from 10ms to 500ms (or whatever
    is the prefered default).

  - Add new version of ACPI hotplug patch where pm_runtime_get/put() is
    moved into acpiphp_check_bridge().

Let me know if I'm forgetting something.

Bjorn, is this ok for you? It would be nice to get the updated series to
linux-next for wider testing :)

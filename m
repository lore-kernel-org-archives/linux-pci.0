Return-Path: <SRS0=GJvY=BM=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=GJvY=BM=chromium.org=briannorris@kernel.org>
Date: Thu, 12 Oct 2017 23:27:29 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>, Rajat Jain <rajatja@google.com>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-arm-kernel@lists.infradead.org, furquan@chromium.org
Subject: Re: [PATCH 0/3] PCI: rockchip: assert PERST# in S3
Message-ID: <20171013062728.GA56763@google.com>
References: <20171012205220.130048-1-briannorris@chromium.org>
 <20171013031523.GB25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171013031523.GB25517@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Thu, Oct 12, 2017 at 10:15:23PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 12, 2017 at 01:52:17PM -0700, Brian Norris wrote:
> > Hi,
> > 
> > This patch series should mostly be self-descriptive, but it's motivated by the
> > fact that I've found differing requirements from PCIe endpoint makers regarding
> > the state of PERST# when in system suspend (S3). Additionally, some existing
> > boards are not especially well suited for holding PERST# low in S3 (e.g., the
> > pin is driven by a non-PMU GPIO, so it's hard or impossible to keep it
> > asserted). So the solution is...give it a device tree property!
> 
> How do ACPI systems solve this problem?

I don't really know, because by design ACPI is rather opaque. And I
expect people like it that way.

But from the very little experience I've had looking at ACPI
configuration, this is done on a case-by-case basis. I've heard of cases
where an Intel-based S0ix suspend-to-idle can't reinitialize PCIe
devices reliably if PERST# was asserted and so...the firmware designers
just hacked around it by not asserting PERST# (there was no difference
in power consumption for this endpoint).

For the case I'm particularly looking at (the Wifi card vendor that
suggests not to assert PERST#)...I haven't tested them on an ACPI-based
system. But they claimed that their Windows/ACPI systems don't enter L2
or assert PERST# at all -- they stay in L1.x. But then, I'm not sure
this vendor has been very successful in the desktop/laptop market, where
ACPI is common.

But I'll elaborate a little on my problems on this non-ACPI system,
where apparently I have to defend things in the open, since they're not
hidden behind an opaque BIOS :)

I'm looking at 2 different Wifi card vendors, both in M.2-compliant
packages, and using them on Rockchip RK3399. We want to support
Wake-on-WLAN, and these cards do not have an "auxiliary" power, so we
leave them fully powered in system suspend (S3) and expect them to enter
low power states when prompted. Rockchip supports L0, L0s, L1, and L2/3
link states, but no L1.1 or L1.2. Its PCIe reference clock is driven off
a clock which powers off in S3, and so by my understanding, the only
legal transition is to enter L2/L3 link state before suspend.

Now, one of these 2 Wifi vendors claims higher power consumption with
PERST# asserted, because they exit L2 and go into a detect state. They
also seem to claim that on some Windows/ACPI systems leave their link in
L1.x states in system suspend, and PERST# is not involved there either.

The other vendor is the opposite: when PERST# is not asserted, power
consumption in L2 link state is higher, and (because device is not in D3
cold?) PCIE WAKE# will not activate. After a closer reading of the PCIe
specs, this seems to be a more correct reading of the specs.

> Can you point to any relevant sections in the PCI specs?

Sure, I can try.

Per the above discussion, we expect to enter L2 link state when
suspending. The PCIe Base Specification 3.1 section 5.3.2.3 (Entry into
the L2/L3 Ready State) describes the L2/L3 transition sequence,
involving the PME_Turn_Off and PME_TO_Ack messages. It doesn't describe
what to do with PERST#.

Separately, the PCI Express Card Electromechanical Specification
Revision 3.0 talks about PERST#. Its main description is in section 2:

"PERST# (required): indicates when the applied main power is within the
specified tolerance and stable."

Considering we always keep main power on for the endpoint, this doesn't
appear to suggest anything.

There is more language in 2.2, but it's less clear:

"PERST# is asserted in advance of the power being switched off in a
power-managed state like S3."

Again, no power is switched off. And what is a "state like S3"? Rather
vague. The "S3" I refer to for RK3399 is not determined by an ACPI spec.

The PCIe M.2 specification is even lighter on details. It describes
PERST# but only in the context of powering off. Although it does refer
to the above PCIe Card EM Spec at times.

> Is this a hole in those specs?  Is this something that needs to be
> clarified by the PCI-SIG to improve interoperability?

After re-re-reading the specifications, I'm more convinced that the
first Wifi vendor got it wrong. I also don't trust them to get many
things right in general, so this is pretty much par for the course.

The only things I can suggest:
* "main power" is never defined, as far as I can tell. So "main" and
  "auxiliary" power don't have much meaning for many M.2 cards, and so
  I end up reading much of the spec with a grain of salt
* S3 is never defined in the PCIe Card EM spec, but it's thrown around a
  few times
* if possible, the PCIe base spec should mention something about the
  fundamental reset which is expected with an L2 transition. It's not
  clear what to do if you don't want to switch off power completely (and
  so enter L3), but you also don't have "auxiliary" power

> Why is this problem only showing up now?

Because initial work on RK3399 (and most upstreaming efforts) was done
on boards using the first Wifi vendor as the sole PCIe device on the
bus, and now we're introducing a second Wifi vendor, which is more
closely aligned with the PCIe Card EM spec.

Also, even if the first vendors' chips could handle PERST# OK, the first
boards may not be able to drive PERST# low in S3, as they'll get pulled
up when the GPIO bank shuts off. (It's unclear if just toggling PERST#
is enough to satisfy the spec.)

As to why no one else ran into this, I can only speculate. Maybe our 1st
Wifi vendor is the only vendor that got this wrong. Or maybe anyone who
has handled this stuff just handles it in custom BIOS code that nobody
ever reviewed.

Brian

> > Brian Norris (3):
> >   Documentation/devicetree: Add pcie-reset-suspend property
> >   of/pci: Add of_pci_get_pcie_reset_suspend() to parse
> >     pcie-reset-suspend
> >   PCI: rockchip: Support configuring PERST# state via DT
> > 
> >  Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
> >  drivers/of/of_pci.c                           | 25 +++++++++++++++++++++++++
> >  drivers/pci/host/pcie-rockchip.c              |  7 +++++++
> >  include/linux/of_pci.h                        |  7 +++++++
> >  4 files changed, 50 insertions(+)
> > 
> > -- 
> > 2.15.0.rc0.271.g36b669edcc-goog
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

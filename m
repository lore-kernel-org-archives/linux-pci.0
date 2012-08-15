Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43446 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781Ab2HOMS1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 08:18:27 -0400
Received: by lagy9 with SMTP id y9so789426lag.19
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 05:18:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120815063718.GA15665@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-11-git-send-email-thierry.reding@avionic-design.de>
 <20120814201215.GA10542@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Awbx9-DWM3V02HUg7Xv4tWAhcLO7UKuT_0uXbpZ+nKw@mail.gmail.com> <20120815063718.GA15665@avionic-0098.mockup.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Aug 2012 05:18:04 -0700
Message-ID: <CAErSpo7Y9ADYHwZMjQjDwd7m8jtwgcxsE-NE_K5X_Z+PuV=C4w@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 14, 2012 at 11:37 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Tue, Aug 14, 2012 at 04:50:26PM -0700, Bjorn Helgaas wrote:
>> On Tue, Aug 14, 2012 at 1:12 PM, Thierry Reding
>> <thierry.reding@avionic-design.de> wrote:
>> > On Thu, Jul 26, 2012 at 09:55:12PM +0200, Thierry Reding wrote:
>> >> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
>> >> index a094c97..c886dff 100644
>> >> --- a/arch/arm/boot/dts/tegra20.dtsi
>> >> +++ b/arch/arm/boot/dts/tegra20.dtsi
>> >> @@ -199,6 +199,68 @@
>> >>               #size-cells = <0>;
>> >>       };
>> >>
>> >> +     pcie-controller {
>> >> +             compatible = "nvidia,tegra20-pcie";
>> >> +             reg = <0x80003000 0x00000800   /* PADS registers */
>> >> +                    0x80003800 0x00000200   /* AFI registers */
>> >> +                    0x81000000 0x01000000   /* configuration space */
>> >> +                    0x90000000 0x10000000>; /* extended configuration space */
>> >> +             interrupts = <0 98 0x04   /* controller interrupt */
>> >> +                           0 99 0x04>; /* MSI interrupt */
>> >> +             status = "disabled";
>> >> +
>> >> +             ranges = <0 0 0  0x80000000 0x00001000   /* root port 0 */
>> >> +                       0 1 0  0x81000000 0x00800000   /* port 0 config space */
>> >> +                       0 2 0  0x90000000 0x08000000   /* port 0 ext config space */
>> >> +                       0 3 0  0x82000000 0x00010000   /* port 0 downstream I/O */
>> >> +                       0 4 0  0xa0000000 0x08000000   /* port 0 non-prefetchable memory */
>> >> +                       0 5 0  0xb0000000 0x08000000   /* port 0 prefetchable memory */
>> >> +
>> >> +                       1 0 0  0x80001000 0x00001000   /* root port 1 */
>> >> +                       1 1 0  0x81800000 0x00800000   /* port 1 config space */
>> >> +                       1 2 0  0x98000000 0x08000000   /* port 1 ext config space */
>> >> +                       1 3 0  0x82010000 0x00010000   /* port 1 downstream I/O */
>> >> +                       1 4 0  0xa8000000 0x08000000   /* port 1 non-prefetchable memory */
>> >> +                       1 5 0  0xb8000000 0x08000000>; /* port 1 prefetchable memory */
>> >
>> > I've been thinking about this some more. The translations for both the
>> > regular and extended configuration spaces are configured in the top-
>> > level PCIe controller. It is therefore wrong how they are passed to the
>> > PCI host bridges via the ranges property.
>> >
>> > I remember Mitch saying that it should be passed down to the children
>> > because it is partitioned among them, but since the layout is compatible
>> > with ECAM, the partitioning isn't as simple as what's in the tree. In
>> > fact the partitions will be dependent on the number of devices attached
>> > to the host bridges.
>>
>> I don't understand this last bit about the number of devices attached
>> to the host bridges.  Logically, the host bridge has a bus number
>> aperture that you can know up front, even before you know anything
>> about what devices are below it.  On x86, for example, the ACPI _CRS
>> method has something like "[bus 00-7f]" in it, which means that any
>> buses in that range are below this bridge.  That doesn't tell us
>> anything about which buses actually have devices on them, of course;
>> it's just analogous to the secondary and subordinate bus number
>> registers in a P2P bridge.
>
> That's one of the issues I still need to take care of. Currently no bus
> resource is attached to the individual bridges (nor the PCI controller
> for that matter), so the PCI core will assign them dynamically.

So your PCI controller driver knows how to program the controller bus
number aperture?  Sometimes people start by assuming that two host
bridges both have [bus 00-ff] apertures, then they enumerate below the
first and adjust the bus number apertures based on what they found.
For example, if they found buses 00-12 behind the first bridge, they
make the apertures [bus 00-12] for the first bridge and [bus 13-ff]
for the second.  That might be the case, depending on what firmware
set up, but it seems like a dubious way to do it, and of course it
precludes a lot of hot-plug scenarios.

> If this
> range is known at boot time we could assign ECAM ranges based on the bus
> numbers. Standard ECAM ranges, that is. On Tegra this won't work because
> as Stephen mentioned in a previous mail, the bus field is not the top
> field in the ECAM addresses. Basically what you have is this:
>
>         [27:24] upper 4 bits of the register address for extended
>                 configuration space
>         [23:16] bus number
>         [15:11] device number
>         [10: 8] device function
>         [ 8: 0] register
>
> So the ECAM space cannot be partitioned by bus number.

Ah, OK, so definitely not standard PCIe ECAM.

Bjorn

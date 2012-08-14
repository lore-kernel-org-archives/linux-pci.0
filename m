Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63357 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab2HNXus (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 19:50:48 -0400
Received: by lbbgj3 with SMTP id gj3so565262lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 14 Aug 2012 16:50:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120814201215.GA10542@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-11-git-send-email-thierry.reding@avionic-design.de> <20120814201215.GA10542@avionic-0098.mockup.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 14 Aug 2012 16:50:26 -0700
Message-ID: <CAErSpo6Awbx9-DWM3V02HUg7Xv4tWAhcLO7UKuT_0uXbpZ+nKw@mail.gmail.com>
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

On Tue, Aug 14, 2012 at 1:12 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Thu, Jul 26, 2012 at 09:55:12PM +0200, Thierry Reding wrote:
>> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
>> index a094c97..c886dff 100644
>> --- a/arch/arm/boot/dts/tegra20.dtsi
>> +++ b/arch/arm/boot/dts/tegra20.dtsi
>> @@ -199,6 +199,68 @@
>>               #size-cells = <0>;
>>       };
>>
>> +     pcie-controller {
>> +             compatible = "nvidia,tegra20-pcie";
>> +             reg = <0x80003000 0x00000800   /* PADS registers */
>> +                    0x80003800 0x00000200   /* AFI registers */
>> +                    0x81000000 0x01000000   /* configuration space */
>> +                    0x90000000 0x10000000>; /* extended configuration space */
>> +             interrupts = <0 98 0x04   /* controller interrupt */
>> +                           0 99 0x04>; /* MSI interrupt */
>> +             status = "disabled";
>> +
>> +             ranges = <0 0 0  0x80000000 0x00001000   /* root port 0 */
>> +                       0 1 0  0x81000000 0x00800000   /* port 0 config space */
>> +                       0 2 0  0x90000000 0x08000000   /* port 0 ext config space */
>> +                       0 3 0  0x82000000 0x00010000   /* port 0 downstream I/O */
>> +                       0 4 0  0xa0000000 0x08000000   /* port 0 non-prefetchable memory */
>> +                       0 5 0  0xb0000000 0x08000000   /* port 0 prefetchable memory */
>> +
>> +                       1 0 0  0x80001000 0x00001000   /* root port 1 */
>> +                       1 1 0  0x81800000 0x00800000   /* port 1 config space */
>> +                       1 2 0  0x98000000 0x08000000   /* port 1 ext config space */
>> +                       1 3 0  0x82010000 0x00010000   /* port 1 downstream I/O */
>> +                       1 4 0  0xa8000000 0x08000000   /* port 1 non-prefetchable memory */
>> +                       1 5 0  0xb8000000 0x08000000>; /* port 1 prefetchable memory */
>
> I've been thinking about this some more. The translations for both the
> regular and extended configuration spaces are configured in the top-
> level PCIe controller. It is therefore wrong how they are passed to the
> PCI host bridges via the ranges property.
>
> I remember Mitch saying that it should be passed down to the children
> because it is partitioned among them, but since the layout is compatible
> with ECAM, the partitioning isn't as simple as what's in the tree. In
> fact the partitions will be dependent on the number of devices attached
> to the host bridges.

I don't understand this last bit about the number of devices attached
to the host bridges.  Logically, the host bridge has a bus number
aperture that you can know up front, even before you know anything
about what devices are below it.  On x86, for example, the ACPI _CRS
method has something like "[bus 00-7f]" in it, which means that any
buses in that range are below this bridge.  That doesn't tell us
anything about which buses actually have devices on them, of course;
it's just analogous to the secondary and subordinate bus number
registers in a P2P bridge.

>> +
>> +             #address-cells = <3>;
>> +             #size-cells = <1>;
>> +
>> +             pci@0 {
>> +                     device_type = "pciex";
>> +                     reg = <0 0 0 0x1000>;
>> +                     status = "disabled";
>> +
>> +                     #address-cells = <3>;
>> +                     #size-cells = <2>;
>> +
>> +                     ranges = <0x80000000 0 0  0 1 0  0 0x00800000   /* config space */
>> +                               0x90000000 0 0  0 2 0  0 0x08000000   /* ext config space */
>> +                               0x81000000 0 0  0 3 0  0 0x00010000   /* I/O */
>> +                               0x82000000 0 0  0 4 0  0 0x08000000   /* non-prefetchable memory */
>> +                               0xc2000000 0 0  0 5 0  0 0x08000000>; /* prefetchable memory */
>> +
>> +                     nvidia,num-lanes = <2>;
>> +             };
>> +
>> +             pci@1 {
>> +                     device_type = "pciex";
>> +                     reg = <1 0 0 0x1000>;
>> +                     status = "disabled";
>> +
>> +                     #address-cells = <3>;
>> +                     #size-cells = <2>;
>> +
>> +                     ranges = <0x80000000 0 0  1 1 0  0 0x00800000   /* config space */
>> +                               0x90000000 0 0  1 2 0  0 0x08000000   /* ext config space */
>> +                               0x81000000 0 0  1 3 0  0 0x00010000   /* I/O */
>> +                               0x82000000 0 0  1 4 0  0 0x08000000   /* non-prefetchable memory */
>> +                               0xc2000000 0 0  1 5 0  0 0x08000000>; /* prefetchable memory */
>> +
>> +                     nvidia,num-lanes = <2>;
>> +             };
>> +     };
>
> The same is true for the ranges properties of the PCI host bridge nodes.
> Which part of the configuration spaces maps to the children of the
> respective host bridge depends on the actual device hierarchy.
>
> Would it be possible to alternatively pass the complete range to the
> children without further partitioning?
>
> The driver doesn't actually care about the ranges property and only uses
> the values specified in the reg property of the pcie-controller node.
>
> Thierry

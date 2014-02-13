Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:34839 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754251AbaBMLH7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 06:07:59 -0500
Date: Thu, 13 Feb 2014 11:07:21 +0000
From: Will Deacon <will.deacon@arm.com>
To: Kumar Gala <galak@codeaurora.org>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140213110721.GC13576@mudshark.cambridge.arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <1392236171-10512-4-git-send-email-will.deacon@arm.com>
 <D2AE4AE6-E8FA-4DD8-B92B-E37205A2548C@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <D2AE4AE6-E8FA-4DD8-B92B-E37205A2548C@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 12, 2014 at 09:51:48PM +0000, Kumar Gala wrote:
> 
> On Feb 12, 2014, at 2:16 PM, Will Deacon <will.deacon@arm.com> wrote:
> 
> > This patch adds support for a generic PCI host controller, such as a
> > firmware-initialised device with static windows or an emulation by
> > something such as kvmtool.
> > 
> > The controller itself has no configuration registers and has its address
> > spaces described entirely by the device-tree (using the bindings from
> > ePAPR). Both CAM and ECAM are supported for Config Space accesses.
> > 
> > Corresponding documentation is added for the DT binding.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > .../devicetree/bindings/pci/arm-generic-pci.txt    |  51 ++++
> > drivers/pci/host/Kconfig                           |   7 +
> > drivers/pci/host/Makefile                          |   1 +
> > drivers/pci/host/pci-arm-generic.c                 | 318 +++++++++++++++++++++
> > 4 files changed, 377 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/pci/arm-generic-pci.txt
> > create mode 100644 drivers/pci/host/pci-arm-generic.c
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/arm-generic-pci.txt b/Documentation/devicetree/bindings/pci/arm-generic-pci.txt
> > new file mode 100644
> > index 000000000000..cc7a35ecfa2d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/arm-generic-pci.txt
> > @@ -0,0 +1,51 @@
> > +* ARM generic PCI host controller
> > +
> > +Firmware-initialised PCI host controllers and PCI emulations, such as the
> > +virtio-pci implementations found in kvmtool and other para-virtualised
> > +systems, do not require driver support for complexities such as regulator and
> > +clock management. In fact, the controller may not even require the
> > +configuration of a control interface by the operating system, instead
> > +presenting a set of fixed windows describing a subset of IO, Memory and
> > +Configuration Spaces.
> > +
> > +Such a controller can be described purely in terms of the standardized device
> > +tree bindings communicated in pci.txt:
> > +
> > +- compatible     : Must be "arm,pci-cam-generic" or "arm,pci-ecam-generic"
> > +                   depending on the layout of configuration space (CAM vs
> > +                   ECAM respectively)
> 
> What’s arm specific here?  I don’t have a great suggestion, but seems odd
> for this to be vendor prefixed with "arm".

Happy to change it, but I'm also struggling for names. Maybe "linux,..."?

> > +- ranges         : As described in IEEE Std 1275-1994, but must provide
> > +                   at least a definition of one or both of IO and Memory
> > +                   Space.
> > +
> > +- #address-cells : Must be 3
> > +
> > +- #size-cells    : Must be 2
> > +
> > +- reg            : The Configuration Space base address, as accessed by the
> > +                   parent bus.
> 
> Isn’t the size fixed here for cam or ecam?

Yes, which is why reg just specifies the base address.

> > +Configuration Space is assumed to be memory-mapped (as opposed to being
> > +accessed via an ioport) and laid out with a direct correspondence to the
> > +geography of a PCI bus address by concatenating the various components to form
> > +an offset.
> > +
> > +For CAM, this 24-bit offset is:
> > +
> > +        cfg_offset(bus, device, function, register) =
> > +                   bus << 16 | device << 11 | function << 8 | register
> > +
> > +Whilst ECAM extends this by 4 bits to accomodate 4k of function space:
> > +
> > +        cfg_offset(bus, device, function, register) =
> > +                   bus << 20 | device << 15 | function << 12 | register
> > +
> > +Interrupt mapping is exactly as described in `Open Firmware Recommended
> > +Practice: Interrupt Mapping' and requires the following properties:
> > +
> > +- #interrupt-cells   : Must be 1
> > +
> > +- interrupt-map      : <see aforementioned specification>
> > +
> > +- interrupt-map-mask : <see aforementioned specification>
> 
> Examples are always nice :)

Not in this case! kvmtool generates the following:

	pci {
		#address-cells = <0x3>;
		#size-cells = <0x2>;
		#interrupt-cells = <0x1>;
		compatible = "arm,pci-cam-generic";
		reg = <0x0 0x40000000>;
		ranges = <0x1000000 0x0 0x0 0x0 0x0 0x0 0x10000 0x2000000 0x0 0x41000000 0x0 0x41000000 0x0 0x3f000000>;
		interrupt-map = <0x0 0x0 0x0 0x1 0x1 0x0 0x4 0x1 0x800 0x0 0x0 0x1 0x1 0x0 0x5 0x1 0x1000 0x0 0x0 0x1 0x1 0x0 0x6 0x1 0x1800 0x0 0x0 0x1 0x1 0x0 0x7 0x1>;
		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
	};

I can add it if you like, but it looks like a random bunch of numbers to me.

Will

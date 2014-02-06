Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62035 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754010AbaBFLAs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Feb 2014 06:00:48 -0500
Date: Thu, 6 Feb 2014 11:00:16 +0000
From: Will Deacon <will.deacon@arm.com>
To: Anup Patel <anup@brainfault.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Message-ID: <20140206110016.GI26035@mudshark.cambridge.arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <1391532784-1953-3-git-send-email-will.deacon@arm.com>
 <CAAhSdy0X56UcMrp0bsH0na=GBkND=jqZVqbHxKsBampr8YM3cA@mail.gmail.com>
 <20140206105442.GB4993@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140206105442.GB4993@e106497-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 06, 2014 at 10:54:42AM +0000, Liviu Dudau wrote:
> On Thu, Feb 06, 2014 at 08:54:03AM +0000, Anup Patel wrote:
> > On Tue, Feb 4, 2014 at 10:23 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > This patch adds support for an extremely simple virtual PCI host
> > > controller. The controller itself has no configuration registers, and
> > > has its address spaces described entirely by the device-tree (using the
> > > bindings described by ePAPR). This allows emulations, such as kvmtool,
> > > to provide a simple means for a guest Linux instance to make use of
> > > PCI devices.
> > >
> > > Corresponding documentation is added for the DT binding.
> > >
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  .../devicetree/bindings/pci/linux,pci-virt.txt     |  38 ++++
> > >  drivers/pci/host/Kconfig                           |   7 +
> > >  drivers/pci/host/Makefile                          |   1 +
> > >  drivers/pci/host/pci-virt.c                        | 200 +++++++++++++++++++++
> > >  4 files changed, 246 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/linux,pci-virt.txt
> > >  create mode 100644 drivers/pci/host/pci-virt.c
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/linux,pci-virt.txt b/Documentation/devicetree/bindings/pci/linux,pci-virt.txt
> > > new file mode 100644
> > > index 000000000000..54668a283498
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/linux,pci-virt.txt
> > > @@ -0,0 +1,38 @@
> > > +* ARM Basic Virtual PCI controller
> > > +
> > > +PCI emulations, such as the virtio-pci implementations found in kvmtool
> > > +and other para-virtualised systems, do not require driver support for
> > > +complexities such as regulator and clock management. In fact, the
> > > +controller may not even have a control interface visible to the
> > > +operating system, instead presenting a set of fixed windows describing a
> > > +subset of IO, Memory and Configuration spaces.
> > > +
> > > +Such a controller can be described purely in terms of the standardized
> > > +device tree bindings communicated in pci.txt:
> > > +
> > > +- compatible     : Must be "linux,pci-virt"
> > > +
> > > +- ranges         : As described in IEEE Std 1275-1994, but must provide
> > > +                   at least a definition of the Configuration Space plus
> > > +                   one or both of IO and Memory Space.
> > > +
> > > +- #address-cells : Must be 3
> > > +
> > > +- #size-cells    : Must be 2
> > > +
> > > +Configuration Space is assumed to be memory-mapped (as opposed to being
> > 
> > It would be great to have a flag to specify whether Configuration Space is over
> > ioports or memory mapped.
> 
> This is another reason why I prefer the reg property for specifying the configuration
> space address range. I don't see a straight way of making the distinction you
> need using the ranges property.

Well if we need to distinguish cam vs ecam, then adding ioport to the mix
should be (conceptually) easy and I don't think it would involve the "reg"
property.

However, I'm not planning to add ioport support myself.

Will

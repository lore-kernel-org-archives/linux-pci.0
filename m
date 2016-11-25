Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:4496 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932432AbcKYQ3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 11:29:16 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "T homas Petazzoni" <thomas.petazzo.ni@free-electrons.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        John Garry <john.garry@huawei.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@go og le.com" <bhelgaas@google.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "zhichang.yuan 02@gmail.com" <zhichang.yuan02@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>
Subject: RE: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 25 Nov 2016 16:27:40 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F93B05D@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <4675465.4Qhqy6WU4X@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F939E0A@lhreml507-mbx>
 <107039805.6PaPa1fbx1@wuerfel>
In-Reply-To: <107039805.6PaPa1fbx1@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 25 November 2016 12:04
> To: Gabriele Paoloni
> Cc: linux-arm-kernel@lists.infradead.org; mark.rutland@arm.com;
> catalin.marinas@arm.com; linux-pci@vger.kernel.org;
> liviu.dudau@arm.com; Linuxarm; lorenzo.pieralisi@arm.com; xuwei (O);
> Jason Gunthorpe; T homas Petazzoni; linux-serial@vger.kernel.org;
> benh@kernel.crashing.org; devicetree@vger.kernel.org; minyard@acm.org;
> will.deacon@arm.com; John Garry; olof@lixom.net; robh+dt@kernel.org;
> bhelgaas@go og le.com; kantyzc@163.com; zhichang.yuan 02@gmail.com;
> linux-kernel@vger.kernel.org; Yuanzhichang; zourongrong@gmail.com
> Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Friday, November 25, 2016 8:46:11 AM CET Gabriele Paoloni wrote:
> > > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > >
> > > On Wednesday, November 23, 2016 6:07:11 PM CET Arnd Bergmann wrote:
> > > > On Wednesday, November 23, 2016 3:22:33 PM CET Gabriele Paoloni
> > > wrote:
> > > > > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > > > > > On Friday, November 18, 2016 5:03:11 PM CET Gabriele Paoloni
> > >  /*
> > > @@ -549,9 +548,14 @@ static int of_translate_one(struct device_node
> > > *parent, struct of_bus *bus,
> > >   * that translation is impossible (that is we are not dealing with
> a
> > > value
> > >   * that can be mapped to a cpu physical address). This is not
> really
> > > specified
> > >   * that way, but this is traditionally the way IBM at least do
> things
> > > + *
> > > + * Whenever the translation fails, the *host pointer will be set
> to
> > > the
> > > + * device that lacks a tranlation, and the return code is relative
> to
> > > + * that node.
> >
> > This seems to be wrong to me. We are abusing of the error conditions.
> > So effectively if there is a buggy DT for an IO resource we end up
> > assuming that we are using a special IO device with unmapped
> addresses.
> >
> > The patch at the bottom apply on top of this one and I think is a
> more
> > reasonable approach
> 
> It was meant as a logical extension to the existing interface,
> translating the address as far as we can, and reporting back
> how far we got.
> 
> Maybe we can return 'of_root' by instead of NULL to signify
> that we have converted all the way to the root of the DT?
> That would make it more consistent, but slightly more complicated
> for the common case.

Mmm not sure really...the point is that now the **host parameter is
used both as a flag and also in of_translate_ioport...the problem
that I see is where we set the "host" parameter...I have a proposal
below...

[...]

> pci_bus_alloc_resource(struct
> > > pci_bus *bus,
> > >  			void *alignf_data);
> 
> [Many lines of reply trimmed here, please make sure you don't quote too
> much context when you reply, it's really annoying to read through
> it otherwise]

Sorry! I'll take care of this in the future...

> 
> >  /*
> > + * of_isa_indirect_io - get the IO address from some isa reg
> property value.
> > + *	For some isa/lpc devices, no ranges property in ancestor node.
> > + *	The device addresses are described directly in their regs
> property.
> > + *	This fixup function will be called to get the IO address of
> isa/lpc
> > + *	devices when the normal of_translation failed.
> > + *
> > + * @parent:	points to the parent dts node;
> > + * @bus:		points to the of_bus which can be used to parse
> address;
> > + * @addr:	the address from reg property;
> > + * @na:		the address cell counter of @addr;
> > + * @presult:	store the address paresed from @addr;
> > + *
> > + * return 1 when successfully get the I/O address;
> > + * 0 will return for some failures.
> > + */
> > +static int of_get_isa_indirect_io(struct device_node *parent,
> > +				struct of_bus *bus, __be32 *addr,
> > +				int na, u64 *presult)
> > +{
> > +	unsigned int flags;
> > +	unsigned int rlen;
> > +
> > +	/* whether support indirectIO */
> > +	if (!indirect_io_enabled())
> > +		return 0;
> > +
> > +	if (!of_bus_isa_match(parent))
> > +		return 0;
> > +
> > +	flags = bus->get_flags(addr);
> > +	if (!(flags & IORESOURCE_IO))
> > +		return 0;
> > +
> > +	/* there is ranges property, apply the normal translation
> directly. */
> > +	if (of_get_property(parent, "ranges", &rlen))
> > +		return 0;
> > +
> > +	*presult = of_read_number(addr + 1, na - 1);
> > +	/* this fixup is only valid for specific I/O range. */
> > +	return addr_is_indirect_io(*presult);
> > +}
> 
> Right, this would work. The reason I didn't go down this route is
> that I wanted to keep it generic enough to allow doing the same
> for PCI host bridges with a nonlinear mapping of the I/O space.
> 
> There isn't really anything special about ISA here, other than the
> fact that the one driver that needs it happens to be for ISA rather
> than PCI.

Yes I see your point please consider the patch at the bottom...

> 
> > +/*
> >   * Translate an address from the device-tree into a CPU physical
> address,
> >   * this walks up the tree and applies the various bus mappings on
> the
> >   * way.
> > @@ -600,14 +643,23 @@ static u64 __of_translate_address(struct
> device_node *dev,
> >  			result = of_read_number(addr, na);
> >  			break;
> >  		}
> > +		/*
> > +		 * For indirectIO device which has no ranges property, get
> > +		 * the address from reg directly.
> > +		 */
> > +		if (of_get_isa_indirect_io(dev, bus, addr, na, &result)) {
> > +			pr_debug("isa indirectIO matched(%s)..addr =
> 0x%llx\n",
> > +				of_node_full_name(dev), result);
> > +			*host = of_node_get(parent);
> > +			break;
> > +		}
> >
> 
> If we do the special case for ISA as you suggest above, I would still
> want
> to keep it in of_translate_ioport(), I think that's a useful change by
> itself in my patch.

This comes without saying...the patch I proposed here already applied on
top of your changes and, in fact, you can see that I set 
"*host = of_node_get(parent);" above in my patch to be used by 
of_translate_ioport()
 
> 
> 	Arnde
> 
> 
> 

Below I have reworked my patch (that still applies on top of your one) to
make it not ISA specific.
Notice that of_translate_ioport() still stands and that in addr_is_indirect_io()
we make sure the bus address to be in the bus address range that the special
host operates on...

---
 drivers/of/address.c       | 56 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/of_address.h | 17 ++++++++++++++
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 5decaba..2b34931 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -540,6 +540,48 @@ static u64 of_translate_one(struct device_node *parent, struct of_bus *bus,
 }
 
 /*
+ * of_get_indirect_io - get the IO address from some reg property value.
+ *	For some special host devices, we have no ranges property node and
+ *	we directly use the bus addresses of the children regs property.
+ *	This fixup function will be called to get the IO address of isa/lpc
+ *	devices when the normal of_translation failed.
+ *
+ * @parent:	points to the parent dts node;
+ * @bus:		points to the of_bus which can be used to parse address;
+ * @addr:	the address from reg property;
+ * @na:		the address cell counter of @addr;
+ * @presult:	store the address parsed from @addr;
+ *
+ * return 1 when successfully get the I/O address;
+ * 0 will return for some failures.
+ */
+static int of_get_indirect_io(struct device_node *parent,
+				struct of_bus *bus, __be32 *addr,
+				int na, u64 *presult)
+{
+	unsigned int flags;
+	unsigned int rlen;
+
+	/* whether support indirectIO */
+	if (!indirect_io_enabled())
+		return 0;
+
+	flags = bus->get_flags(addr);
+	if (!(flags & IORESOURCE_IO))
+		return 0;
+
+	/* there is ranges property, apply the normal translation directly. */
+	if (of_get_property(parent, "ranges", &rlen))
+		return 0;
+
+	*presult = of_read_number(addr + 1, na - 1);
+
+	/* check if the bus address falls into the range of
+	 * the special host device*/
+	return addr_is_indirect_io(*presult);
+}
+
+/*
  * Translate an address from the device-tree into a CPU physical address,
  * this walks up the tree and applies the various bus mappings on the
  * way.
@@ -601,13 +643,23 @@ static u64 __of_translate_address(struct device_node *dev,
 			break;
 		}
 
+		/*
+		 * For indirectIO device which has no ranges property, get
+		 * the address from reg directly.
+		 */
+		if (of_get_indirect_io(dev, bus, addr, na, &result)) {
+			pr_debug("isa indirectIO matched(%s)..addr = 0x%llx\n",
+				of_node_full_name(dev), result);
+			*host = of_node_get(parent);
+			break;
+		}
+
 		/* Get new parent bus and counts */
 		pbus = of_match_bus(parent);
 		pbus->count_cells(dev, &pna, &pns);
 		if (!OF_CHECK_COUNTS(pna, pns)) {
-			pr_debug("Bad cell count for %s\n",
+			pr_err("Bad cell count for %s\n",
 				 of_node_full_name(dev));
-			*host = of_node_get(parent);
 			break;
 		}
 
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 3786473..14848d8 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -24,6 +24,23 @@ struct of_pci_range {
 #define for_each_of_pci_range(parser, range) \
 	for (; of_pci_range_parser_one(parser, range);)
 
+#ifndef indirect_io_enabled
+#define indirect_io_enabled indirect_io_enabled
+static inline bool indirect_io_enabled(void)
+{
+	return false;
+}
+#endif
+
+#ifndef addr_is_indirect_io
+#define addr_is_indirect_io addr_is_indirect_io
+static inline int addr_is_indirect_io(u64 taddr)
+{
+	return 0;
+}
+#endif
+
+
 /* Translate a DMA address from device space to CPU space */
 extern u64 of_translate_dma_address(struct device_node *dev,
 				    const __be32 *in_addr);
-- 
2.7.4




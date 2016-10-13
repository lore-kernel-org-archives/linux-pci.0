Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 13 Oct 2016 17:32:29 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 01/14] drivers: iommu: add FWNODE_IOMMU fwnode type
Message-ID: <20161013163229.GA24568@red-moon>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
 <20160909142343.13314-2-lorenzo.pieralisi@arm.com>
 <20160929141520.GA29244@red-moon>
 <3178073.UTpgCTN6if@vostro.rjw.lan>
 <20160930090702.GA7725@red-moon>
 <CAJZ5v0hK2Ryo32u4S9K=78-Oot13vvVNB+p6N2YC1UMqYW9g7A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hK2Ryo32u4S9K=78-Oot13vvVNB+p6N2YC1UMqYW9g7A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 Eric Auger <eric.auger@redhat.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Dennis Chen <dennis.chen@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
 Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>,
 Prem Mallappa <prem.mallappa@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On Fri, Sep 30, 2016 at 05:48:01PM +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 30, 2016 at 11:07 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Thu, Sep 29, 2016 at 10:59:40PM +0200, Rafael J. Wysocki wrote:
> >> On Thursday, September 29, 2016 03:15:20 PM Lorenzo Pieralisi wrote:
> >> > Hi Rafael,
> >> >
> >> > On Fri, Sep 09, 2016 at 03:23:30PM +0100, Lorenzo Pieralisi wrote:
> >> > > On systems booting with a device tree, every struct device is
> >> > > associated with a struct device_node, that represents its DT
> >> > > representation. The device node can be used in generic kernel
> >> > > contexts (eg IRQ translation, IOMMU streamid mapping), to
> >> > > retrieve the properties associated with the device and carry
> >> > > out kernel operation accordingly. Owing to the 1:1 relationship
> >> > > between the device and its device_node, the device_node can also
> >> > > be used as a look-up token for the device (eg looking up a device
> >> > > through its device_node), to retrieve the device in kernel paths
> >> > > where the device_node is available.
> >> > >
> >> > > On systems booting with ACPI, the same abstraction provided by
> >> > > the device_node is required to provide look-up functionality.
> >> > >
> >> > > Therefore, mirroring the approach implemented in the IRQ domain
> >> > > kernel layer, this patch adds an additional fwnode type FWNODE_IOMMU.
> >> > >
> >> > > This patch also implements a glue kernel layer that allows to
> >> > > allocate/free FWNODE_IOMMU fwnode_handle structures and associate
> >> > > them with IOMMU devices.
> >> > >
> >> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> > > Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> > > Cc: Joerg Roedel <joro@8bytes.org>
> >> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> > > ---
> >> > >  include/linux/fwnode.h |  1 +
> >> > >  include/linux/iommu.h  | 25 +++++++++++++++++++++++++
> >> > >  2 files changed, 26 insertions(+)
> >> > >
> >> > > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> >> > > index 8516717..6e10050 100644
> >> > > --- a/include/linux/fwnode.h
> >> > > +++ b/include/linux/fwnode.h
> >> > > @@ -19,6 +19,7 @@ enum fwnode_type {
> >> > >   FWNODE_ACPI_DATA,
> >> > >   FWNODE_PDATA,
> >> > >   FWNODE_IRQCHIP,
> >> > > + FWNODE_IOMMU,
> >> >
> >> > This patch provides groundwork for this series and it is key for
> >> > the rest of it, basically the point here is that we need a fwnode
> >> > to differentiate platform devices created out of static ACPI tables
> >> > entries (ie IORT), that represent IOMMU components.
> >> >
> >> > The corresponding device is not an ACPI device (I could fabricate one as
> >> > it is done for other static tables entries eg FADT power button, but I
> >> > do not necessarily see the reason for doing that given that all we need
> >> > the fwnode for is a token identifier), so FWNODE_ACPI does not apply
> >> > here.
> >> >
> >> > Please let me know if it is reasonable how I sorted this out (it
> >> > is basically identical to IRQCHIP, just another enum entry), the
> >> > remainder of the code depends on this.
> >>
> >> I'm not familiar with the use case, so I don't see anything unreasonable
> >> in it.
> >
> > The use case is pretty simple: on ARM SMMU devices are platform devices.
> > When booting with DT they are identified through an of_node and related
> > FWNODE_OF type. When booting with ACPI, the ARM SMMU platform devices,
> > to be equivalent to DT booting path, should be created out of static
> > IORT table entries (that's how we describe SMMUs); we need to create
> > a fwnode "token" to associate with those platform devices and that's
> > not a FWNODE_ACPI (that is for an ACPI device firmware object, here we
> > really do not need one), so this patch.
> >
> >> If you're asking about whether or not I mind adding more fwnode types in
> >> principle, then no, I don't. :-)
> >
> > Yes, that's what I was asking, the only point that bugs me is that for
> > both FWNODE_IRQCHIP and FWNODE_IOMMU the fwnode is just a "token" (ie a
> > valid pointer) used for look-up and the type in the fwnode_handle is
> > mostly there for error checking, I was wondering if we could create a
> > specific fwnode_type for this specific usage (eg FWNODE_TAG and then add
> > a type to it as part of its container struct) instead of adding an enum
> > value per subsystem - it seems there are other fwnode types in the
> > pipeline :), so I am asking:
> >
> > lkml.kernel.org/r/3D1468514043-21081-3-git-send-email-minyard@acm.org
> 
> OK, I see your concern now, so thanks for presenting it so clearly.
> 
> While I don't see anything wrong with having per-subsystem fwnode
> types in principle, I agree that if the only purpose of them is to
> mean "this comes from ACPI, but from a static table, not from the
> namespace", it would be better to have a single fwnode type for that,
> like FWNODE_ACPI_STATIC or similar.

Coming back to this, I updated the series with new fwnode type
FWNODE_ACPI_STATIC, which IMHO makes more sense (because that
represents the FW interface it was obtained from rather than
its content and plays better with upcoming extension above - DMI is a
different firmware interface so it will be represented with a different
fwnode type). Thanks.

However, I still have a question. The approach I took (create platform
devices out of static IORT table entries for SMMUs) is common in ACPI
(eg GHES, ACPI watchdog) even though those subsystems ignore the fwnode,
but I think that's a detail.

Still, fixed HW like power button and sleep button took a different
approach, which consists in creating struct acpi_device objects out
of FADT fixed HW features (with a NULL ACPI handle because there is
no real ACPI object in the namespace for them).

I would like to understand the reasoning behind the difference (I
think it is related to notification events and the need for an
ACPI object for them - and sysfs userspace HID IF exposure ?).

In theory (but looks crazy to me that's why I did not do it), I could
fabricate a Device object in the ACPI namespace (?) (with _HID, _CRS and
related properties - is that doable ?) out of the static table entry in
the IORT table that provides the ARM SMMU component data (ie its MMIO
space, IRQs and SMMU properties like cache coherency), this would
allow the kernel to create a struct acpi_device (and related fwnode)
+ its physical node platform device but that looks insanely complicated
(if feasible and more importantly if correct from an ACPI standpoint).

This approach would allow me to match the SMMU driver with an _HID,
the kernel would create a physical_node (ie platform_device) for
me out of the namespace ACPI device object and I would get the
FWNODE_ACPI for free (out of the struct acpi_device) instead of having
to fiddle about with a new fwnode_handle type.

I think this alternative approach (if doable at all) creates more issues
than it solves but I wanted to make sure what I am doing is kosher
from an ACPI perspective so I am asking.

I definitely think the current approach I took is much better, with its
own downsides (eg matching the ARM SMMU driver by name instead of
acpi_device_id/_HID), but I wanted to ask.

The point is: ARM SMMU drivers are platform drivers. In DT the SMMUs
are represented through DT nodes, in ACPI through _static_ IORT table
entries, somehow a platform device must be created for them, so
this whole series (and related fwnode issues).

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

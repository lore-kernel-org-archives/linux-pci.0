Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160930090702.GA7725@red-moon>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
 <20160909142343.13314-2-lorenzo.pieralisi@arm.com> <20160929141520.GA29244@red-moon>
 <3178073.UTpgCTN6if@vostro.rjw.lan> <20160930090702.GA7725@red-moon>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Sep 2016 17:48:01 +0200
Message-ID: <CAJZ5v0hK2Ryo32u4S9K=78-Oot13vvVNB+p6N2YC1UMqYW9g7A@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] drivers: iommu: add FWNODE_IOMMU fwnode type
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 30, 2016 at 11:07 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Sep 29, 2016 at 10:59:40PM +0200, Rafael J. Wysocki wrote:
>> On Thursday, September 29, 2016 03:15:20 PM Lorenzo Pieralisi wrote:
>> > Hi Rafael,
>> >
>> > On Fri, Sep 09, 2016 at 03:23:30PM +0100, Lorenzo Pieralisi wrote:
>> > > On systems booting with a device tree, every struct device is
>> > > associated with a struct device_node, that represents its DT
>> > > representation. The device node can be used in generic kernel
>> > > contexts (eg IRQ translation, IOMMU streamid mapping), to
>> > > retrieve the properties associated with the device and carry
>> > > out kernel operation accordingly. Owing to the 1:1 relationship
>> > > between the device and its device_node, the device_node can also
>> > > be used as a look-up token for the device (eg looking up a device
>> > > through its device_node), to retrieve the device in kernel paths
>> > > where the device_node is available.
>> > >
>> > > On systems booting with ACPI, the same abstraction provided by
>> > > the device_node is required to provide look-up functionality.
>> > >
>> > > Therefore, mirroring the approach implemented in the IRQ domain
>> > > kernel layer, this patch adds an additional fwnode type FWNODE_IOMMU.
>> > >
>> > > This patch also implements a glue kernel layer that allows to
>> > > allocate/free FWNODE_IOMMU fwnode_handle structures and associate
>> > > them with IOMMU devices.
>> > >
>> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> > > Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>> > > Cc: Joerg Roedel <joro@8bytes.org>
>> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> > > ---
>> > >  include/linux/fwnode.h |  1 +
>> > >  include/linux/iommu.h  | 25 +++++++++++++++++++++++++
>> > >  2 files changed, 26 insertions(+)
>> > >
>> > > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
>> > > index 8516717..6e10050 100644
>> > > --- a/include/linux/fwnode.h
>> > > +++ b/include/linux/fwnode.h
>> > > @@ -19,6 +19,7 @@ enum fwnode_type {
>> > >   FWNODE_ACPI_DATA,
>> > >   FWNODE_PDATA,
>> > >   FWNODE_IRQCHIP,
>> > > + FWNODE_IOMMU,
>> >
>> > This patch provides groundwork for this series and it is key for
>> > the rest of it, basically the point here is that we need a fwnode
>> > to differentiate platform devices created out of static ACPI tables
>> > entries (ie IORT), that represent IOMMU components.
>> >
>> > The corresponding device is not an ACPI device (I could fabricate one as
>> > it is done for other static tables entries eg FADT power button, but I
>> > do not necessarily see the reason for doing that given that all we need
>> > the fwnode for is a token identifier), so FWNODE_ACPI does not apply
>> > here.
>> >
>> > Please let me know if it is reasonable how I sorted this out (it
>> > is basically identical to IRQCHIP, just another enum entry), the
>> > remainder of the code depends on this.
>>
>> I'm not familiar with the use case, so I don't see anything unreasonable
>> in it.
>
> The use case is pretty simple: on ARM SMMU devices are platform devices.
> When booting with DT they are identified through an of_node and related
> FWNODE_OF type. When booting with ACPI, the ARM SMMU platform devices,
> to be equivalent to DT booting path, should be created out of static
> IORT table entries (that's how we describe SMMUs); we need to create
> a fwnode "token" to associate with those platform devices and that's
> not a FWNODE_ACPI (that is for an ACPI device firmware object, here we
> really do not need one), so this patch.
>
>> If you're asking about whether or not I mind adding more fwnode types in
>> principle, then no, I don't. :-)
>
> Yes, that's what I was asking, the only point that bugs me is that for
> both FWNODE_IRQCHIP and FWNODE_IOMMU the fwnode is just a "token" (ie a
> valid pointer) used for look-up and the type in the fwnode_handle is
> mostly there for error checking, I was wondering if we could create a
> specific fwnode_type for this specific usage (eg FWNODE_TAG and then add
> a type to it as part of its container struct) instead of adding an enum
> value per subsystem - it seems there are other fwnode types in the
> pipeline :), so I am asking:
>
> lkml.kernel.org/r/3D1468514043-21081-3-git-send-email-minyard@acm.org

OK, I see your concern now, so thanks for presenting it so clearly.

While I don't see anything wrong with having per-subsystem fwnode
types in principle, I agree that if the only purpose of them is to
mean "this comes from ACPI, but from a static table, not from the
namespace", it would be better to have a single fwnode type for that,
like FWNODE_ACPI_STATIC or similar.

Thanks,
Rafael

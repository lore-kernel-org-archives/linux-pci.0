Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>
Subject: RE: [PATCH v9 2/4] iommu/dma: Add a helper function to reserve HW
 MSI address regions for IOMMU drivers
Date: Wed, 18 Oct 2017 14:23:31 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838448A48@FRAEML521-MBX.china.huawei.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
 <20171006140450.89652-3-shameerali.kolothum.thodi@huawei.com>
 <20171013192350.GA32130@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83844672A@FRAEML521-MBX.china.huawei.com>
 <1d49243a-4746-f189-7c5d-4b98937115fb@arm.com>
In-Reply-To: <1d49243a-4746-f189-7c5d-4b98937115fb@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, John Garry <john.garry@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>, "Guohanjun \(Hanjun
 Guo\)" <guohanjun@huawei.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devel@acpica.org" <devel@acpica.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Wednesday, October 18, 2017 1:34 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> Will Deacon <will.deacon@arm.com>
> Cc: lorenzo.pieralisi@arm.com; Gabriele Paoloni
> <gabriele.paoloni@huawei.com>; marc.zyngier@arm.com; linux-
> pci@vger.kernel.org; joro@8bytes.org; John Garry <john.garry@huawei.com>;
> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Linuxarm
> <linuxarm@huawei.com>; linux-acpi@vger.kernel.org; iommu@lists.linux-
> foundation.org; Wangzhou (B) <wangzhou1@hisilicon.com>;
> sudeep.holla@arm.com; bhelgaas@google.com; linux-arm-
> kernel@lists.infradead.org; devel@acpica.org
> Subject: Re: [PATCH v9 2/4] iommu/dma: Add a helper function to reserve HW
> MSI address regions for IOMMU drivers
> 
> On 16/10/17 17:09, Shameerali Kolothum Thodi wrote:
> > Hi Robin,
> >
> >> -----Original Message-----
> >> From: Will Deacon [mailto:will.deacon@arm.com]
> >> Sent: Friday, October 13, 2017 8:24 PM
> >> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> >> Cc: lorenzo.pieralisi@arm.com; marc.zyngier@arm.com;
> >> sudeep.holla@arm.com; robin.murphy@arm.com; joro@8bytes.org;
> >> bhelgaas@google.com; Gabriele Paoloni <gabriele.paoloni@huawei.com>;
> >> John Garry <john.garry@huawei.com>; iommu@lists.linux-foundation.org;
> >> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org; linux-
> >> pci@vger.kernel.org; devel@acpica.org; Linuxarm
> <linuxarm@huawei.com>;
> >> Wangzhou (B) <wangzhou1@hisilicon.com>; Guohanjun (Hanjun Guo)
> >> <guohanjun@huawei.com>
> >> Subject: Re: [PATCH v9 2/4] iommu/dma: Add a helper function to reserve
> HW
> >> MSI address regions for IOMMU drivers
> >>
> >> On Fri, Oct 06, 2017 at 03:04:48PM +0100, Shameer Kolothum wrote:
> >>> IOMMU drivers can use this to implement their .get_resv_regions callback
> >>> for HW MSI specific reservations(e.g. ARM GICv3 ITS MSI region).
> >>>
> >>> Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> >>> ---
> >>>  drivers/iommu/dma-iommu.c | 20 ++++++++++++++++++++
> >>>  include/linux/dma-iommu.h |  7 +++++++
> >>>  2 files changed, 27 insertions(+)
> >>
> >> I'd like to see Robin's Ack on this, because this is his code and he had
> >> ideas on ways to solve this problem properly.
> >
> > Please let us know if it is ok to go ahead with ACPI support for now.
> > It will help our customers to start using pass-through for PCIe.
> >
> > Thanks,
> > Shameer
> >
> >>
> >> Will
> >>
> >>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> >>> index 9d1cebe..bae677e 100644
> >>> --- a/drivers/iommu/dma-iommu.c
> >>> +++ b/drivers/iommu/dma-iommu.c
> >>> @@ -19,6 +19,7 @@
> >>>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >>>   */
> >>>
> >>> +#include <linux/acpi_iort.h>
> >>>  #include <linux/device.h>
> >>>  #include <linux/dma-iommu.h>
> >>>  #include <linux/gfp.h>
> >>> @@ -27,6 +28,7 @@
> >>>  #include <linux/iova.h>
> >>>  #include <linux/irq.h>
> >>>  #include <linux/mm.h>
> >>> +#include <linux/of_iommu.h>
> >>>  #include <linux/pci.h>
> >>>  #include <linux/scatterlist.h>
> >>>  #include <linux/vmalloc.h>
> >>> @@ -198,6 +200,24 @@ void iommu_dma_get_resv_regions(struct device
> >> *dev, struct list_head *list)
> >>>  }
> >>>  EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> >>>
> >>> +/**
> >>> + * iommu_dma_get_msi_resv_regions - Reserved region driver helper
> >>> + * @dev: Device from iommu_get_resv_regions()
> >>> + * @list: Reserved region list from iommu_get_resv_regions()
> >>> + *
> >>> + * IOMMU drivers can use this to implement their .get_resv_regions
> >>> + * callback for HW MSI specific reservations. For now, this only
> 
> This doesn't make an awful lot of sense - there's only one reserved
> region callback, so iommu-dma shouldn't be offering two separate and
> non-overlapping implementations.
> 
> >>> + * covers ITS MSI region reservation using ACPI IORT helper function.
> >>> + */
> >>> +int iommu_dma_get_msi_resv_regions(struct device *dev, struct
> list_head
> >> *list)
> >>> +{
> >>> +	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode))
> >>> +		return iort_iommu_msi_get_resv_regions(dev, list);
> 
> Either this call knows how to do the right thing for any platform and
> should be made from iommu_dma_get_reserved_regions() directly, or it's
> tightly coupled to the HiSilicon quirk in the SMMUv3 driver and
> iommu-dma doesn't need to know - the middle ground presented here is
> surely the worst of both worlds.

Right. I think we have discussed this earlier[1] and had a v4 based on invoking
the iort_iommu_its_get_resv_regions() within the iommu_dma_get_resv_regions().
But later as you rightly pointed out, we were not checking for platforms which
requires this quirk inside the iort code and that will break the platforms which are 
happy with MSI translations. Hence moved to the current implementation in v6
after this discussion here[2]
 
And earlier I think in the v3 version we had the function called from smmu driver
directly and the feedback was that it should be abstracted from the driver.

May be it is still possible to move the function call inside the 
iommu_dma_get_resv_regions() and do the smmu model check inside
 the iort helper function and selectively apply the HW MSI reservations.

But I think it is much neater if we can invoke the iort_get_msi_regions() directly
from SMMUv3 based on the model.

Thoughts?

Thanks,
Shameer
1. https://patches.linaro.org/patch/106268/
2. https://www.spinics.net/lists/arm-kernel/msg599162.html



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

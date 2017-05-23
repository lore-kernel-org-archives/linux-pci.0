Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 23 May 2017 10:26:59 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH V11 08/11] drivers: acpi: Handle IOMMU lookup failure
 with deferred probing or error
Message-ID: <20170523092659.GA19999@red-moon>
References: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
 <1491823266-1209-9-git-send-email-sricharan@codeaurora.org>
 <41668eff-271c-1c4c-7665-3bf0faa74669@codeaurora.org>
 <20170523085241.GA18204@red-moon>
 <c6d5c033-a8f9-03e3-9963-cd291ae2d7e1@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <c6d5c033-a8f9-03e3-9963-cd291ae2d7e1@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org,
 frowand.list@gmail.com, m.szyprowski@samsung.com, linux-arch@vger.kernel.org,
 tn@semihalf.com, joro@8bytes.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, lenb@kernel.org, devicetree@vger.kernel.org,
 arnd@arndb.de, linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, Nate Watterson <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 02:31:17PM +0530, Sricharan R wrote:
> Hi Lorenzo,
> 
> On 5/23/2017 2:22 PM, Lorenzo Pieralisi wrote:
> > On Tue, May 23, 2017 at 02:26:10AM -0400, Nate Watterson wrote:
> >> Hi Sricharan,
> >>
> >> On 4/10/2017 7:21 AM, Sricharan R wrote:
> >>> This is an equivalent to the DT's handling of the iommu master's probe
> >>> with deferred probing when the corrsponding iommu is not probed yet.
> >>> The lack of a registered IOMMU can be caused by the lack of a driver for
> >>> the IOMMU, the IOMMU device probe not having been performed yet, having
> >>> been deferred, or having failed.
> >>>
> >>> The first case occurs when the firmware describes the bus master and
> >>> IOMMU topology correctly but no device driver exists for the IOMMU yet
> >>> or the device driver has not been compiled in. Return NULL, the caller
> >>> will configure the device without an IOMMU.
> >>>
> >>> The second and third cases are handled by deferring the probe of the bus
> >>> master device which will eventually get reprobed after the IOMMU.
> >>>
> >>> The last case is currently handled by deferring the probe of the bus
> >>> master device as well. A mechanism to either configure the bus master
> >>> device without an IOMMU or to fail the bus master device probe depending
> >>> on whether the IOMMU is optional or mandatory would be a good
> >>> enhancement.
> >>>
> >>> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> >>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> >>> [Lorenzo: Added fixes for dma_coherent_mask overflow, acpi_dma_configure
> >>>           called multiple times for same device]
> >>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >>> ---
> >>>  drivers/acpi/arm64/iort.c  | 33 ++++++++++++++++++++++++++++++++-
> >>>  drivers/acpi/scan.c        | 11 ++++++++---
> >>>  drivers/base/dma-mapping.c |  2 +-
> >>>  include/acpi/acpi_bus.h    |  2 +-
> >>>  include/linux/acpi.h       |  7 +++++--
> >>>  5 files changed, 47 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >>> index 3dd9ec3..e323ece 100644
> >>> --- a/drivers/acpi/arm64/iort.c
> >>> +++ b/drivers/acpi/arm64/iort.c
> >>> @@ -543,6 +543,14 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
> >>>  	const struct iommu_ops *ops = NULL;
> >>>  	int ret = -ENODEV;
> >>>  	struct fwnode_handle *iort_fwnode;
> >>> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> >>> +
> >>> +	/*
> >>> +	 * If we already translated the fwspec there
> >>> +	 * is nothing left to do, return the iommu_ops.
> >>> +	 */
> >>> +	if (fwspec && fwspec->ops)
> >>> +		return fwspec->ops;
> >>
> >> Is this logic strictly required? It breaks masters with multiple SIDs
> >> as only the first SID is actually added to the master's fwspec.
> > 
> > My bad, that's indeed a silly bug I introduced. Please let me know if the
> > patch below fixes it, we will send it upstream shortly.
> > 
> 
> oops, i think emails crossed. Please let me know if you are ok to add
> this to the other fixes.

No worries, yes I am ok thanks but please give Nate some time to report
back to make sure the diff I sent actually fixes the problem.

Apologies for the breakage.

Lorenzo

> 
> Regards,
>  Sricharan
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

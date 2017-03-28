Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 28 Mar 2017 10:00:01 -0500
From: Rob Herring <robh@kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [V9, 07/11] iommu: of: Handle IOMMU lookup failure with deferred
 probing or error
Message-ID: <20170328150001.j57jko6mx35npgp2@rob-hp-laptop>
References: <1489086061-9356-8-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1489086061-9356-8-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org, joro@8bytes.org,
 will.deacon@arm.com, robdclark@gmail.com, okaya@codeaurora.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 hanjun.guo@linaro.org, linux-pci@vger.kernel.org, bhelgaas@google.com,
 tn@semihalf.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 10, 2017 at 12:30:57AM +0530, Sricharan R wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Failures to look up an IOMMU when parsing the DT iommus property need to
> be handled separately from the .of_xlate() failures to support deferred
> probing.
> 
> The lack of a registered IOMMU can be caused by the lack of a driver for
> the IOMMU, the IOMMU device probe not having been performed yet, having
> been deferred, or having failed.
> 
> The first case occurs when the device tree describes the bus master and
> IOMMU topology correctly but no device driver exists for the IOMMU yet
> or the device driver has not been compiled in. Return NULL, the caller
> will configure the device without an IOMMU.
> 
> The second and third cases are handled by deferring the probe of the bus
> master device which will eventually get reprobed after the IOMMU.
> 
> The last case is currently handled by deferring the probe of the bus
> master device as well. A mechanism to either configure the bus master
> device without an IOMMU or to fail the bus master device probe depending
> on whether the IOMMU is optional or mandatory would be a good
> enhancement.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Laurent Pichart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/base/dma-mapping.c | 5 +++--
>  drivers/iommu/of_iommu.c   | 4 ++--
>  drivers/of/device.c        | 7 ++++++-
>  include/linux/of_device.h  | 9 ++++++---
>  4 files changed, 17 insertions(+), 8 deletions(-)

Maybe it is the same issue reported for VFIO, but virtio-pci is broken 
with v8 of this series. Bisecting blames this commit which looks like it 
hasn't changeed. 

Rob

P.S. Doesn't look like you have copied the DT maintainers nor list for 
the DT changes.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

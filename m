Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 28 Jan 2017 15:10:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH V7 00/11] IOMMU probe deferral support
Message-ID: <20170128211029.GI20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org, joro@8bytes.org,
 will.deacon@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2017 at 09:48:02PM +0530, Sricharan R wrote:
> This series calls the dma ops configuration for the devices
> at a generic place so that it works for all busses.
> The dma_configure_ops for a device is now called during
> the device_attach callback just before the probe of the
> bus/driver is called. Similarly dma_deconfigure is called during
> device/driver_detach path.
> ...

>  arch/arm64/mm/dma-mapping.c       | 132 ++++----------------------------------
>  drivers/acpi/arm64/iort.c         |  40 +++++++++++-
>  drivers/acpi/glue.c               |   5 --
>  drivers/acpi/scan.c               |   7 +-
>  drivers/base/dd.c                 |   9 +++
>  drivers/base/dma-mapping.c        |  41 ++++++++++++
>  drivers/iommu/arm-smmu-v3.c       |  46 +------------
>  drivers/iommu/arm-smmu.c          |  58 +++--------------
>  drivers/iommu/of_iommu.c          | 114 +++++++++++++++++++++++---------
>  drivers/of/address.c              |  20 +++++-
>  drivers/of/device.c               |  36 ++++++-----
>  drivers/of/platform.c             |  10 +--
>  drivers/pci/probe.c               |  28 --------
>  include/acpi/acpi_bus.h           |   2 +-
>  include/asm-generic/vmlinux.lds.h |   1 -
>  include/linux/acpi.h              |   7 +-
>  include/linux/acpi_iort.h         |   3 -
>  include/linux/dma-mapping.h       |   3 +
>  include/linux/of_device.h         |  10 ++-
>  19 files changed, 252 insertions(+), 320 deletions(-)

I'm assuming this will go via some other tree, maybe the IOMMU tree?
I acked the PCI parts, so let me know if you need anything more from me.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

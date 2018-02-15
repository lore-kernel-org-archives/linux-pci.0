Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 15 Feb 2018 10:59:09 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
Message-ID: <20180215095909.r4nwqjhuijusssuy@8bytes.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-2-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
In-Reply-To: <20180212183352.22730-2-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, ilias.apalodimas@linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, xuzaibo@huawei.com,
 jonathan.cameron@huawei.com, will.deacon@arm.com, okaya@codeaurora.org,
 yi.l.liu@intel.com, lorenzo.pieralisi@arm.com, ashok.raj@intel.com,
 tn@semihalf.com, robdclark@gmail.com, bharatku@xilinx.com,
 linux-acpi@vger.kernel.org, catalin.marinas@arm.com, rfranz@cavium.com,
 lenb@kernel.org, devicetree@vger.kernel.org, jacob.jun.pan@linux.intel.com,
 alex.williamson@redhat.com, robh+dt@kernel.org, thunder.leizhen@huawei.com,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
 shunyong.yang@hxt-semitech.com, dwmw2@infradead.org, liubo95@huawei.com,
 rjw@rjwysocki.net, jcrouse@codeaurora.org, iommu@lists.linux-foundation.org,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 christian.koenig@amd.com, nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 12, 2018 at 06:33:16PM +0000, Jean-Philippe Brucker wrote:
  
> +config IOMMU_SVA
> +	bool "Shared Virtual Addressing API for the IOMMU"
> +	select IOMMU_API
> +	help
> +	  Enable process address space management for the IOMMU API. In systems
> +	  that support it, device drivers can bind process address spaces to
> +	  devices and share their page tables using this API.
> +
> +	  If unsure, say N here.

I think this should be an option selected by IOMMU driver and not be
activly selectable by the user.

> +/**
> + * iommu_sva_device_shutdown() - Shutdown Shared Virtual Addressing for a device
> + * @dev: the device
> + *
> + * Disable SVA. The device should not be performing any DMA while this function
> + * is running.

Is this a good idea? How about devices that get hot-unplugged while
processes still use them and there is DMA going back and forth? This
function can be the point to shut down all ongoing stuff first and the
shutdown the device.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

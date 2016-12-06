Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] ACPI/IORT: Make dma masks set-up IORT specific
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Joerg Roedel
 <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 <iommu@lists.linux-foundation.org>
References: <20161205122619.25045-1-lorenzo.pieralisi@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <58466EFC.3070109@huawei.com>
Date: Tue, 6 Dec 2016 15:55:40 +0800
MIME-Version: 1.0
In-Reply-To: <20161205122619.25045-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Sricharan R <sricharan@codeaurora.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
 linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
 Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dennis Chen <dennis.chen@arm.com>, Prem Mallappa <prem.mallappa@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/12/5 20:26, Lorenzo Pieralisi wrote:
> The introduction of acpi_dma_configure() allows to configure DMA
> and related IOMMU for any device that is DMA capable. To achieve
> that goal it ensures DMA masks are set-up to sane default values
> before proceeding with IOMMU and DMA ops configuration.
>
> On x86/ia64 systems, through acpi_bind_one(), acpi_dma_configure() is
> called for every device that has an ACPI companion, in that every device
> is considered DMA capable on x86/ia64 systems (ie acpi_get_dma_attr() API),
> which has the side effect of initializing dma masks also for
> pseudo-devices (eg CPUs and memory nodes) and potentially for devices
> whose dma masks were not set-up before the acpi_dma_configure() API was
> introduced, which may have noxious side effects.
>
> Therefore, in preparation for IORT firmware specific DMA masks set-up,
> wrap the default DMA masks set-up in acpi_dma_configure() inside an IORT
> specific wrapper that reverts to a NOP on x86/ia64 systems, restoring the
> default expected behaviour on x86/ia64 systems and keeping DMA default
> masks set-up on IORT based (ie ARM) arch configurations.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>

Add this patch on top of your v9 acpi smmu patchset,
tested on Hisilicon D03 (ARM64), devices with SMMU
enabled work fine,

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

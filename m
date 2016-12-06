Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 6 Dec 2016 09:43:04 +0000
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, joro@8bytes.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        iommu@lists.linux-foundation.org,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ACPI/IORT: Make dma masks set-up IORT specific
Message-ID: <20161206094304.GA2498@arm.com>
References: <20161205122619.25045-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161205122619.25045-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 05, 2016 at 12:26:19PM +0000, Lorenzo Pieralisi wrote:
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
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Sricharan R <sricharan@codeaurora.org>
> ---
> Joerg,
> 
> pending Rafael's ACK on it, given the 4.10 release timing and that the
> series is queued via the IOMMU tree please consider applying this patch to
> your arm/smmu branch for 4.10, it is not fixing a bug but it is modifying
> the x86/ia64 code path; I prefer preventing any issue related to default
> dma masks on x86/ia64 so I hope it can get merged along with the rest of
> the ACPI IORT SMMU series.
> 
> Thanks a lot and apologies,
> Lorenzo
> 
>  drivers/acpi/arm64/iort.c | 22 ++++++++++++++++++++++
>  drivers/acpi/scan.c       | 14 +-------------
>  include/linux/acpi_iort.h |  2 ++
>  3 files changed, 25 insertions(+), 13 deletions(-)

Looks straightforward to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Joerg can probably just pick this on top of his queue.

Will

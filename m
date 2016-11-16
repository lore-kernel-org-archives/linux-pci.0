Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161109141948.19244-8-lorenzo.pieralisi@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com> <20161109141948.19244-8-lorenzo.pieralisi@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Nov 2016 01:55:27 +0100
Message-ID: <CAJZ5v0jJ7ehTpd_Q0_hfqC7J+wMi8x0+O+eSJ0iQyJbzYy1vLg@mail.gmail.com>
Subject: Re: [PATCH v7 07/16] drivers: acpi: implement acpi_dma_configure
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
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

On Wed, Nov 9, 2016 at 3:19 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On DT based systems, the of_dma_configure() API implements DMA
> configuration for a given device. On ACPI systems an API equivalent to
> of_dma_configure() is missing which implies that it is currently not
> possible to set-up DMA operations for devices through the ACPI generic
> kernel layer.
>
> This patch fills the gap by introducing acpi_dma_configure/deconfigure()
> calls that for now are just wrappers around arch_setup_dma_ops() and
> arch_teardown_dma_ops() and also updates ACPI and PCI core code to use
> the newly introduced acpi_dma_configure/acpi_dma_deconfigure functions.
>
> Since acpi_dma_configure() is used to configure DMA operations, the
> function initializes the dma/coherent_dma masks to sane default values
> if the current masks are uninitialized (also to keep the default values
> consistent with DT systems) to make sure the device has a complete
> default DMA set-up.
>
> The DMA range size passed to arch_setup_dma_ops() is sized according
> to the device coherent_dma_mask (starting at address 0x0), mirroring the
> DT probing path behaviour when a dma-ranges property is not provided
> for the device being probed; this changes the current arch_setup_dma_ops()
> call parameters in the ACPI probing case, but since arch_setup_dma_ops()
> is a NOP on all architectures but ARM/ARM64 this patch does not change
> the current kernel behaviour on them.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> [pci]
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

LGTM

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

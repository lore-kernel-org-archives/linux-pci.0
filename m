Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v6 00/16] ACPI IORT ARM SMMU support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <e52c2ad5-08fc-f236-a768-fbf03dd3d552@linaro.org>
Date: Tue, 25 Oct 2016 23:24:30 +0800
MIME-Version: 1.0
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/10/19 0:03, Lorenzo Pieralisi wrote:
> This patch series is v6 of a previous posting:
>
> https://lkml.org/lkml/2016/9/9/418
>
> v5 -> v6
> 	- Rebased against v4.9-rc1
> 	- Changed FWNODE_IOMMU to FWNODE_ACPI_STATIC
> 	- Moved platform devices creation into IORT code
> 	- Updated fwnode handling
> 	- Added default dma masks initialization
>
> v4 -> v5
> 	- Added SMMUv1/v2 support
> 	- Rebased against v4.8-rc5 and dependencies series
> 	- Consolidated IORT platform devices creation
>
[...]
>
> The ACPI IORT table provides information that allows instantiating
> ARM SMMU devices and carrying out id mappings between components on
> ARM based systems (devices, IOMMUs, interrupt controllers).
>
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>
> Building on basic IORT support, this patchset enables ARM SMMUs support
> on ACPI systems.
>
> Most of the code is aimed at building the required generic ACPI
> infrastructure to create and enable IOMMU components and to bring
> the IOMMU infrastructure for ACPI on par with DT, which is going to
> make future ARM SMMU components easier to integrate.
>
[...]
>
> This patchset is provided for review/testing purposes here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/iort-smmu-v6
>
> Tested on Juno and FVP models for ARM SMMU v1 and v3 probing path.

I rebased my platform MSI, interrupt producer and mbi-gen patch set
on top of yours, and test it on Hisilicon D03 board with SMMv3
enabled, USB and SAS are working properly with configuration
in IORT (yes, I need to add patch from Robin - iommu/arm-smmu: Don't
inadvertently reject multiple SMMUv3s),

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

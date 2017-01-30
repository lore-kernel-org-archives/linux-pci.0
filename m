Return-Path: <SRS0=Orsw=ZM=codeaurora.org=sricharan@kernel.org>
Return-Path: <SRS0=Orsw=ZM=codeaurora.org=sricharan@kernel.org>
From: "Sricharan" <sricharan@codeaurora.org>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: <robin.murphy@arm.com>,
	<will.deacon@arm.com>,
	<joro@8bytes.org>,
	<lorenzo.pieralisi@arm.com>,
	<iommu@lists.linux-foundation.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>,
	<m.szyprowski@samsung.com>,
	<bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org> <20170128211029.GI20550@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170128211029.GI20550@bhelgaas-glaptop.roam.corp.google.com>
Subject: RE: [PATCH V7 00/11] IOMMU probe deferral support
Date: Mon, 30 Jan 2017 14:50:35 +0530
Message-ID: <005801d27ada$2127ee90$6377cbb0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

>On Mon, Jan 23, 2017 at 09:48:02PM +0530, Sricharan R wrote:
>> This series calls the dma ops configuration for the devices
>> at a generic place so that it works for all busses.
>> The dma_configure_ops for a device is now called during
>> the device_attach callback just before the probe of the
>> bus/driver is called. Similarly dma_deconfigure is called during
>> device/driver_detach path.
>> ...
>
>>  arch/arm64/mm/dma-mapping.c       | 132 ++++----------------------------------
>>  drivers/acpi/arm64/iort.c         |  40 +++++++++++-
>>  drivers/acpi/glue.c               |   5 --
>>  drivers/acpi/scan.c               |   7 +-
>>  drivers/base/dd.c                 |   9 +++
>>  drivers/base/dma-mapping.c        |  41 ++++++++++++
>>  drivers/iommu/arm-smmu-v3.c       |  46 +------------
>>  drivers/iommu/arm-smmu.c          |  58 +++--------------
>>  drivers/iommu/of_iommu.c          | 114 +++++++++++++++++++++++---------
>>  drivers/of/address.c              |  20 +++++-
>>  drivers/of/device.c               |  36 ++++++-----
>>  drivers/of/platform.c             |  10 +--
>>  drivers/pci/probe.c               |  28 --------
>>  include/acpi/acpi_bus.h           |   2 +-
>>  include/asm-generic/vmlinux.lds.h |   1 -
>>  include/linux/acpi.h              |   7 +-
>>  include/linux/acpi_iort.h         |   3 -
>>  include/linux/dma-mapping.h       |   3 +
>>  include/linux/of_device.h         |  10 ++-
>>  19 files changed, 252 insertions(+), 320 deletions(-)
>
>I'm assuming this will go via some other tree, maybe the IOMMU tree?
>I acked the PCI parts, so let me know if you need anything more from me.

Thanks for the review/acks.
Ya, via the IOMMU tree looks correct.

Regards,
 Sricharan

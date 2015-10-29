Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5631BE8D.10604@huawei.com>
Date: Thu, 29 Oct 2015 14:37:01 +0800
From: Hanjun Guo <guohanjun@huawei.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Hanjun Guo <hanjun.guo@linaro.org>
CC: Bjorn Helgaas <helgaas@kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	<bhelgaas@google.com>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V4 0/8] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com> <24127028.eJSjD1i70u@vostro.rjw.lan> <5630D38F.804@linaro.org> <1545680.eQNYNjjaSj@vostro.rjw.lan>
In-Reply-To: <1545680.eQNYNjjaSj@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/29 0:00, Rafael J. Wysocki wrote:
> On Wednesday, October 28, 2015 09:54:23 PM Hanjun Guo wrote:
>> Hi Rafael,
>>
>> On 10/27/2015 11:27 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, October 27, 2015 09:52:50 AM Bjorn Helgaas wrote:
>>>> Hi Suravee,
>>>>
>>>> On Wed, Oct 21, 2015 at 08:52:03AM -0700, Suravee Suthikulpanit wrote:
>>>>> This patch series adds support to setup DMA coherency for PCI device using
>>>>> the ACPI _CCA attribute. According to the ACPI spec, the _CCA attribute
>>>>> is required for ARM64. Therefore, this patch is a pre-req for ACPI PCI
>>>>> support for ARM64 which is currently in development.  Also, this should
>>>>> not affect other architectures that does not define
>>>>> CONFIG_ACPI_CCA_REQUIRED, since the default value is coherent.
>>>>>
>>>>> In the process, this series also introduces enum dev_dma_attr and a set
>>>>> of APIs to query device DMA attribute. These APIs replace the obsolete
>>>>> device_dma_is_coherent(), and acpi_check_dma().
>>>>>
>>>>> I have also included a patch from Jeremy posted here:
>>>>>      http://www.spinics.net/lists/linux-usb/msg128582.html
>>>>>
>>>>> This patch series  has been tested on AMD Seattle RevB platform.
>>>>> The git tree containing tested code and pre-req patches are posted here:
>>>>>
>>>>>      http://github.com/ssuthiku/linux.git pci-cca-v4
>>>>>
>>>>> Changes from V3: (https://lkml.org/lkml/2015/8/26/389)
>>>>>      * Clean up suggested by Bjorn
>>>>>      * Introduce enum dev_dma_attr
>>>>>      * Replace device_dma_is_coherent() and acpi_check_dma() with
>>>>>        new APIs.
>>>>>
>>>>> Changes from V2: (https://lkml.org/lkml/2015/8/25/549)
>>>>>      * Return -ENOSUPP instead of -1 (per Rafael's suggestion)
>>>>>      * Add WARN() when fail to setup DMA for PCI device when booting
>>>>>        ACPI (per Arnd's suggestion)
>>>>>      * Added Acked-by from Rob.
>>>>>      * Minor clean up
>>>>>
>>>>> Changes from V1: (https://lkml.org/lkml/2015/8/13/182)
>>>>>      * Include patch 1 from Jeremy to enable support for _CCA=0
>>>>>      * Clean up acpi_check_dma() per Bjorn suggestions
>>>>>      * Split the original V1 patch into two patches (patch 3 and 4)
>>>>>
>>>>> Jeremy Linton (1):
>>>>>    Honor ACPI _CCA attribute setting
>>>>>
>>>>> Suravee Suthikulpanit (7):
>>>>>    device property: Introducing enum dev_dma_attr
>>>>>    acpi: Adding DMA Attribute APIs for ACPI Device
>>>>>    device property: Adding DMA Attribute APIs for Generic Devices
>>>>>    device property: acpi: Make use of the new DMA Attribute APIs
>>>>>    device property: acpi: Remove unused DMA APIs
>>>>>    PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
>>>>>    PCI: ACPI: Add support for PCI device DMA coherency
>>>>>
>>>>>   drivers/acpi/acpi_platform.c              |  7 +++++-
>>>>>   drivers/acpi/glue.c                       |  8 +++---
>>>>>   drivers/acpi/scan.c                       | 42 +++++++++++++++++++++++++++++++
>>>>>   drivers/base/property.c                   | 32 +++++++++++++++++------
>>>>>   drivers/crypto/ccp/ccp-platform.c         |  9 ++++++-
>>>>>   drivers/net/ethernet/amd/xgbe/xgbe-main.c |  9 ++++++-
>>>>>   drivers/of/of_pci.c                       | 20 ---------------
>>>>>   drivers/pci/probe.c                       | 36 ++++++++++++++++++++++++--
>>>>>   include/acpi/acpi_bus.h                   | 36 +++-----------------------
>>>>>   include/linux/acpi.h                      |  7 +++++-
>>>>>   include/linux/of_pci.h                    |  3 ---
>>>>>   include/linux/property.h                  | 10 +++++++-
>>>>>   12 files changed, 145 insertions(+), 74 deletions(-)
>>>> I had a couple minor comments.  It's sort of a toss-up, but this feels
>>>> more ACPI-flavored than PCI, so I assume Rafael will take this whole
>>>> series unless I hear otherwise.
>>> I'll do that.
>> If Suravee address the comments and send another version,
>> an it be merged into 4.4?
> Well, it is likely, but not guaranteed.
>
> We're only a few days from the beginning of the merge window and I'm still
> in Seoul.

No problem, it's up to you :), thanks for the quick response.

Hanjun


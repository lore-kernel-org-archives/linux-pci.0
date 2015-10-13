Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V3 2/4] ACPI/scan: Clean up acpi_check_dma
To: Bjorn Helgaas <bhelgaas@google.com>, <rjw@rjwysocki.net>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1440597279-11802-3-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150914163411.GL829@google.com> <561D28B5.7030303@amd.com>
CC: <lenb@kernel.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <hanjun.guo@linaro.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Jeremy Linton <Jeremy.Linton@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Message-ID: <561D9978.9090406@amd.com>
Date: Tue, 13 Oct 2015 18:53:28 -0500
MIME-Version: 1.0
In-Reply-To: <561D28B5.7030303@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn / Rafael,

On 10/13/2015 10:52 AM, Suravee Suthikulpanit wrote:
>
> On 09/14/2015 09:34 AM, Bjorn Helgaas wrote:
>> [..]
>> I think acpi_check_dma_coherency() is better, but only slightly.  It
>> still doesn't give a hint about the *sense* of the return value.  I
>> think it'd be easier to read if there were two functions, e.g.,
>
> I have been going back-and-forth between the current version, and the
> two-function-approach in the past. I can definitely go with this route
> if you would prefer. Although, if acpi_dma_is_coherent() == 0, it would
> be ambiguous whether DMA is not supported or non-coherent DMA is
> supported. Then, we would need to call acpi_dma_is_supported() to find
> out. So, that's okay with you?

Thinking about this again, I still think having one API (which can tell 
whether DMA is supported or not, and if so whether it is coherent or 
non-coherent) would be the least confusing and least error prone.

What if we would just have:

     enum dev_dma_type acpi_get_dev_dma_type(struct acpi_device *adev);

where:
     enum dev_dma_type {
         DEV_DMA_NOT_SUPPORTED,
         DEV_DMA_NON_COHERENT,
         DEV_DMA_COHERENT,
     };

This would probably mean that we should modify drivers/base/property.c 
to replace:
     bool device_dma_is_coherent()
to:
     enum dev_dma_type device_get_dma_type()

We used to discuss the enum approach in the past 
(https://lkml.org/lkml/2015/8/25/868). But we only considered at the 
ACPI level at the time. Actually, this should also reflect in the 
property.c.

At this point, only drivers/crypto/ccp/ccp-platform.c and 
drivers/net/ethernet/amd/xgbe/xgbe-main.c are calling the 
device_dma_is_coherent(). So, it should be easy to change this API.

Please let me know your opinions, or if you have other suggestions.

Thanks again,
Suravee


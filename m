Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0062.outbound.protection.outlook.com ([157.56.111.62]:61792
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752407AbbJTMx3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 20 Oct 2015 08:53:29 -0400
Subject: Re: [PATCH V3 2/4] ACPI/scan: Clean up acpi_check_dma
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1440597279-11802-3-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150914163411.GL829@google.com> <561D28B5.7030303@amd.com>
 <561D9978.9090406@amd.com> <20151020021735.GA20869@localhost>
CC: Bjorn Helgaas <bhelgaas@google.com>, <rjw@rjwysocki.net>,
	<lenb@kernel.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <hanjun.guo@linaro.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Jeremy Linton <Jeremy.Linton@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Message-ID: <56263947.2090805@amd.com>
Date: Tue, 20 Oct 2015 07:53:27 -0500
MIME-Version: 1.0
In-Reply-To: <20151020021735.GA20869@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn/Rafael,

Let me redo the patch with enum then. At least, that's more clear to 
everyone.

Thanks,

Suravee

On 10/19/15 21:17, Bjorn Helgaas wrote:
> On Tue, Oct 13, 2015 at 06:53:28PM -0500, Suravee Suthikulanit wrote:
>> Bjorn / Rafael,
>>
>> On 10/13/2015 10:52 AM, Suravee Suthikulpanit wrote:
>>>
>>> On 09/14/2015 09:34 AM, Bjorn Helgaas wrote:
>>>> [..]
>>>> I think acpi_check_dma_coherency() is better, but only slightly.  It
>>>> still doesn't give a hint about the *sense* of the return value.  I
>>>> think it'd be easier to read if there were two functions, e.g.,
>>>
>>> I have been going back-and-forth between the current version, and the
>>> two-function-approach in the past. I can definitely go with this route
>>> if you would prefer. Although, if acpi_dma_is_coherent() == 0, it would
>>> be ambiguous whether DMA is not supported or non-coherent DMA is
>>> supported. Then, we would need to call acpi_dma_is_supported() to find
>>> out. So, that's okay with you?
>>
>> Thinking about this again, I still think having one API (which can
>> tell whether DMA is supported or not, and if so whether it is
>> coherent or non-coherent) would be the least confusing and least
>> error prone.
>>
>> What if we would just have:
>>
>>      enum dev_dma_type acpi_get_dev_dma_type(struct acpi_device *adev);
>>
>> where:
>>      enum dev_dma_type {
>>          DEV_DMA_NOT_SUPPORTED,
>>          DEV_DMA_NON_COHERENT,
>>          DEV_DMA_COHERENT,
>>      };
>>
>> This would probably mean that we should modify
>> drivers/base/property.c to replace:
>>      bool device_dma_is_coherent()
>> to:
>>      enum dev_dma_type device_get_dma_type()
>>
>> We used to discuss the enum approach in the past
>> (https://lkml.org/lkml/2015/8/25/868). But we only considered at the
>> ACPI level at the time. Actually, this should also reflect in the
>> property.c.
>>
>> At this point, only drivers/crypto/ccp/ccp-platform.c and
>> drivers/net/ethernet/amd/xgbe/xgbe-main.c are calling the
>> device_dma_is_coherent(). So, it should be easy to change this API.
>
> OK, I'm fine with either the enum or Rafael's 0/1/-ENOTSUPP idea.
>
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

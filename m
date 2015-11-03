Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50731 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674AbbKCPK1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2015 10:10:27 -0500
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
To: Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org> <20151103141512.GC3574@red-moon>
 <5638C728.2020503@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5638CE5D.4030703@codeaurora.org>
Date: Tue, 3 Nov 2015 10:10:21 -0500
MIME-Version: 1.0
In-Reply-To: <5638C728.2020503@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/3/2015 9:39 AM, Tomasz Nowicki wrote:
>>>> +struct pci_ops pci_root_ops = {
>>>> +    .map_bus = pci_mcfg_dev_base,
>>>> +    .read = pci_generic_config_read,
>>>> +    .write = pci_generic_config_write,
>>>
>>>
>>> Can you change these with pci_generic_config_read32 and
>>> pci_generic_config_write32? We have some targets that can only do 32
>>> bits PCI config space access.
>>
>> No.
>>
>> http://www.spinics.net/lists/linux-pci/msg44869.html
>>
>> Can you be a bit more specific please ?
>>
>> Sigh. Looks like we have to start adding platform specific quirks even
>> before we merged the generic ACPI PCIe host controller implementation.
>>
>
> The sad reality... But my next version will be still generic. Once that
> one appear to be in good shape then we can add quirks.

Thanks.

I don't see anywhere in the SBSA spec addendum that the PCI 
configuration space section that unaligned accesses *MUST* be supported.

If this is required, please have this info added to the spec. I can work 
with the designers for the next chip.

Unaligned access on the current hardware returns incomplete values or 
can cause bus faults. The behavior is undefined.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project

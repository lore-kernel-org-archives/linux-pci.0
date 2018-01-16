Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40730 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeAPDEZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jan 2018 22:04:25 -0500
Subject: Re: [PATCH 3/4] PCI/DPC: Enable DPC in conjuction with AER
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Maik Broemme <mbroemme@libmpq.org>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20171219210643.24615-3-keith.busch@intel.com>
 <0fb4494a-bd74-8ff9-f4d6-04409965cf58@codeaurora.org>
 <20180116013315.GC32369@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <c14eecfa-77cc-95e2-debe-2e12c130a95c@codeaurora.org>
Date: Mon, 15 Jan 2018 22:04:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180116013315.GC32369@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/15/2018 8:33 PM, Keith Busch wrote:
> On Mon, Jan 15, 2018 at 09:43:22AM -0500, Sinan Kaya wrote:
>> On 12/19/2017 4:06 PM, Keith Busch wrote:
>>> @@ -289,6 +290,9 @@ static int dpc_probe(struct pcie_device *dev)
>>>  	int status;
>>>  	u16 ctl, cap;
>>>  
>>> +	if (pcie_aer_get_firmware_first(pdev))
>>> +		return -ENOTSUPP;
>>> +
>>
>> There are two ways to support firmware first handling along with DPC.
>>
>> The first one is to tie DPC handling to the firmware first enable.
>>
>> The second one is to enable DPC ERR_COR signalling so that firmware
>> gets notified on each DPC event occurrence.
>>
>> While the first one gives more control to the firmware, I think it beats
>> the purpose of the DPC. The first approach requires firmware to do some
>> "pre-processing" before notifying operating system of a failure.
>>
>> The goal of the DPC is to put hardware into safe state when a PCIe error
>> happens. The best software recovery following this is to notify endpoint
>> drivers of failures and shutdown threads/processes accessing the hardware
>> as quick as possible.
>>
>> The firmware-first event notification is through ACPI GHES and firmware injects
>> an artifical uncorrected AER error to the operating system. Once OS gets
>> notified, it tries to recover drivers through AER fatal error recovery mechanism.
>>
>> While the semantics of this path is clearly defined in ACPI, it is also known
>> to be slow as well. During the time firmware does its business, operating
>> system still could be trying to access the endpoint address space.
>>
>> My suggestion is to enable ERR_COR signalling so firmware gets a notification
>> on each DPC event for logging purposes. 
>>
>> OS handles DPC natively and tries to recover hardware without any external
>> influence.
> 
> I see what you're saying, but if a device has a firmware first policy,
> doesn't that mean firmware owns the DPC Control register? The OS shouldn't
> be mucking with it in that case, right?
> 

I agree. I looked at the spec one more time. These are the two paragraphs mentioning
firmware first. Unfortunately, it will come down to the quality of firmware implementation
to make something useful out of DPC functionality.

There should have been a DPC control request as well as a firmware-first control request
instead of tying these together.

"Determination of DPC Control
DPC may be controlled in some configurations by platform firmware and in other configurations by
the operating system. DPC functionality is strongly linked with the functionality in Advanced Error
Reporting. To avoid conflicts over whether platform firmware or the operating system have control
of DPC, it is recommended that platform firmware and operating systems always link the control of
DPC to the control of Advanced Error Reporting."

"Use of DPC ERR_COR Signaling
It is recommended that operating systems use DPC interrupts for signaling when DPC has been
triggered. While DPC ERR_COR signaling indicates the same event, DPC ERR_COR signaling is
primarily intended for use by platform firmware, when it needs to be notified in order to do its own
logging of the event or provide “firmware first” services"




-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

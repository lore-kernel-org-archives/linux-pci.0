Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965327AbeAJPwZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jan 2018 10:52:25 -0500
Subject: Re: [PATCH 4/4] PCI/DPC: Print AER status in DPC event handling
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20171219210643.24615-4-keith.busch@intel.com>
 <35445e86-e7b6-3fed-f26a-954a0f8d5e8a@codeaurora.org>
 <20171221051256.GA15276@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ea609f8a-1d79-c2fe-e9e5-5993e418f9cc@codeaurora.org>
Date: Wed, 10 Jan 2018 10:52:23 -0500
MIME-Version: 1.0
In-Reply-To: <20171221051256.GA15276@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On 12/21/2017 12:12 AM, Keith Busch wrote:
> On Wed, Dec 20, 2017 at 11:43:07PM -0500, Sinan Kaya wrote:
>> +Oza
>>
>> On 12/19/2017 4:06 PM, Keith Busch wrote:
>>> A DPC enabled device will suppress sending ERR_FATAL and ERR_NONFATAL,
>>> which prevents the AER handler from reporting the details of the
>>> error. This patch will have the DPC driver get the AER status registers
>>> from the downstream port that detected the uncorrectable error, and
>>> print out additional information.
>>>
>>> Signed-off-by: Keith Busch <keith.busch@intel.com>
>>> ---
>>
>> Oza is doing some restructuring to unify DPC and AER error handling path per
>> feedback from Bjorn. It is almost done. He is testing it. 
>>
>> Can this patch wait until you review his version? I'm thinking this could
>> be something that can be added to his series instead.
> 
> No problem.
>  
>> Coming back to this patch. The interrupt number for DPC and AER could be the
>> same or different. 
> 
> Only if you're talking about root ports. DPC is also a feature of
> switch downstream ports, which don't generate interrupts on AER events
> (they don't have a Root Error Command register).
> 
>> According to the spec, AER errors are always reported
>> regardless of DPC driver presence (see the famous flow chart).
> 
>> If the interrupt IDs are the same for AER and DPC, your patch would introduce
>> double printing for AER errors.
> 
> The AER Uncorrectable Status Register of the detecting port would
> indeed be set with the appropriate status if that's the type of error
> that occured, but when DPC is enabled, the root port never observes an
> ERR_FATAL/ERR_NONFATAL message required for it to get set the Root Error
> Status Register. The Linux AER handler requires the Root Error Status
> be set in order for it to print anything, so I don't think we're at risk
> of double printing with this patch even if the root port is DPC capable.
> 

Coming back to this. Oza posted his patch that integrates DPC into PORTDRV similar
to AER driver. 

"[PATCH v3 0/4] Address error and recovery for AER and DPC"

We are looking for feedback on the series.

The idea in a nut shell is to collect all endpoint error recovery code into a
new file called pcie-err.c and then invoke callbacks before DPC driver shuts down
the currently active driver.

There is however, still one more problem that has not been tacked.

Since the AER status is set when we observe DPC event and nobody is clearing these
we won't observe another DPC event until somebody clears these. We can say that
we are resetting the endpoints as part of the DPC but we are not touching the
switch downstream port or the root port registers.

Somebody still needs to clear these in addition to printing whatever information
is available in the AER registers.

Do you agree?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

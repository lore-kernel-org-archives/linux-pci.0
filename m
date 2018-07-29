Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbeG2Uwe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Jul 2018 16:52:34 -0400
Subject: Re: [PATCH v6 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
References: <20180728091324.154795-1-okaya@kernel.org>
 <20180728091324.154795-2-okaya@kernel.org> <20180729115703.GA2781@wunner.de>
 <CAK9iUCNfu8pKd1bHiQWVSYg+dppTSPV-Qa7YWBtaNLU_cwL8AA@mail.gmail.com>
 <20180729173907.GA27216@wunner.de>
 <bab51f0c-378b-5f2c-679d-4fd4390c0ac6@kernel.org>
 <20180729190755.GA16418@wunner.de>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <f8571a30-15a3-60a8-2a62-9d67764e6155@kernel.org>
Date: Sun, 29 Jul 2018 12:21:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180729190755.GA16418@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/29/2018 12:07 PM, Lukas Wunner wrote:
> On Sun, Jul 29, 2018 at 11:30:09AM -0700, Sinan Kaya wrote:
>> Yes, slot power needs to be kept on.
>>
>> pciehp shouldn't attempt recovery.
>>
>> If link goes down due to a DPC event, it should be recovered by DPC status
>> trigger. Injecting a cold reset in the middle can cause a HW
>> lockup as it is an undefined behavior.
>>
>> Similarly, If link goes down due to an AER secondary bus reset issue, it
>> should be recovered by HW. Injecting a cold reset in the middle of a
>> secondary bus reset can cause a HW lockup as it is an undefined behavior.
> 
> Thanks a lot for the explanation, understood now.
> 
> 
>> Maybe, this helps:
>>
>> 1. HP ISR observes link down interrupt.
>> 2. HP ISR checks that there is a fatal error pending, it doesn't touch
>> the link.
>> 3. HP ISR waits until link recovery happens.
>> 4. HP ISR calls the read vendor id function.
>>
>> DPC link recovery is very quick (100ms at most). Secondary bus reset
>> recovery should be contained within 1 seconds for most cases but
>> spec allows a device to extend vendor id read as much as it wants via
>> CRS response. We poll up to an additional 60 seconds in read vendor
>> id function.
> 
> Yes, that proposal makes a lot of sense to me.  This should also work
> regardless whether pciehp or DPC/AER react first to the Link Down.
> Could you rebase your patch on the current pci/hotplug branch
> and insert the procedure you've outlined above at the top of
> pciehp_handle_presence_or_link_change() in pciehp_ctrl.c,
> or put it in a helper that's called at the top of that function.
> 
> Your patch "[PATCH v6 1/1] PCI: pciehp: Ignore link events when there
> is a fatal error pending" only checks once for a pending fatal error,
> it should poll until either the fatal error is gone or a timeout is
> hit.  If the fatal error is gone and the link is up, you can just return
> from pciehp_handle_presence_or_link_change().  Else (in the timeout case)
> fall back to the normal handling of a Link Down, i.e. let it bring down
> the slot.
> 
> Please add a code comment in pciehp_handle_presence_or_link_change()
> along the lines of
> 
> 	/* If a fatal error is pending, wait for AER or DPC to handle it. */
> 
> The information in your e-mail that a cold reset would incorrectly
> interfere with error recovery is a crucial piece of information that
> should be included at least in the commit message.  (I was unaware
> of that.)
> 
> If you have any further questions on pciehp, ask away.
>

Great, let me take one more iteration on this after rebasing to the
new branch.


> Thanks!
> 
> Lukas
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbeG2UB3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Jul 2018 16:01:29 -0400
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
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <bab51f0c-378b-5f2c-679d-4fd4390c0ac6@kernel.org>
Date: Sun, 29 Jul 2018 11:30:09 -0700
MIME-Version: 1.0
In-Reply-To: <20180729173907.GA27216@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/29/2018 10:39 AM, Lukas Wunner wrote:
>> ere is the issue with mixing pciehp link handler and fatal error
>> recovery paths.
>>

Let me put all use cases to the table:

use case A

1. DPC fatal error happens. Link goes down in HW by the DPC.
2. Pciehp ISR executes first and turns off slot power
3. DPC Fatal error recovery executes dpc
     status trigger via reset_link() function to recover the link.
4. Link doesn't recover because power is off.

use case B
1. AER fatal error happens. Link is up.
2. AER ISR executes first.
3. AER Fatal error recovery executes secondary bus reset aka warm
reset via AER error recovery in reset_link() to recovery the link
4. Link goes down.
5. Pciehp ISR executes and turns off slot power
6. AER link recovery fails because power is off.

use case C
1. AER fatal error happens. Link goes down after observing a fatal
error before observing ISR.
2. Pciehp ISR executes and turns off slot power
3. AER ISR executes.
4. AER Fatal error recovery executes secondary bus reset aka warm
reset via AER error recovery in reset_link() to recovery the link
5. AER link recovery fails because power is off.

 > With the new code on the pci/hotplug branch, the expected behavior is:
 >
> 4. Having brought the slot down after the DLLSC event,
>     pciehp_handle_presence_or_link_change() notices that the slot is
>     occupied ("Slot(...): Card present") and immediately tries to
>     bring the slot up again:
>     Slot power is re-enabled, green LED is set to blinking.
>     pciehp_check_link_status() then waits 1 second for the link to
>     go up.  If the link does not come up within 1 second, an error
>     message is logged but the procedure does not abort yet.  We then
>     wait for 100 ms and poll for 1 second whether the vendor ID of
>     slot 0 function 0 becomes readable.  Only if the link has not come
>     up at this point is the procedure aborted.

Thanks for the heads up. I didn't realize HP was trying to recover the
link as well.

This is the situation that I'm trying to avoid. AER and DPC resets are 
known as warm-resets.

HP link recovery is known as cold-reset via power-off and power-on command.

In the middle of a warm-reset operation(AER/DPC), we are:
1. turning off the slow power
2. performing a cold reset
causing Fatal Error recovery to fail.

> 
> So the question is:
> 
> a. Is DPC/AER able to recover from the error if slot power is disabled?
>     Or do we need to synchronize with pciehp to keep slot power enabled
>     so that the error can be handled?

Yes, slot power needs to be kept on.

> 
> b. How fast is DPC/AER able to recover from a fatal error?
>     If it's more than 2.1 seconds, pciehp will not bring the slot up
>     automatically and the user is required to bring it up manually via
>     sysfs.  If we know that DPC/AER need a specific amount of time that
>     is longer than 2.1 seconds, we can amend board_added() to poll until
>     recovery from the fatal error (or use a waitqueue which is woken on
>     recovery), with a sufficient timeout.

pciehp shouldn't attempt recovery.

If link goes down due to a DPC event, it should be recovered by DPC 
status trigger. Injecting a cold reset in the middle can cause a HW
lockup as it is an undefined behavior.

Similarly, If link goes down due to an AER secondary bus reset issue, it 
should be recovered by HW. Injecting a cold reset in the middle of a
secondary bus reset can cause a HW lockup as it is an undefined behavior.

> .
> Does this work for you?

Not much, but along the lines of your thinking, I can propose this
as an alternative.

Maybe, this helps:

1. HP ISR observes link down interrupt.
2. HP ISR checks that there is a fatal error pending, it doesn't touch
the link.
3. HP ISR waits until link recovery happens.
4. HP ISR calls the read vendor id function.

DPC link recovery is very quick (100ms at most). Secondary bus reset
recovery should be contained within 1 seconds for most cases but
spec allows a device to extend vendor id read as much as it wants via
CRS response. We poll up to an additional 60 seconds in read vendor
id function.

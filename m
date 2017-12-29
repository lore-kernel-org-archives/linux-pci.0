Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdL2SAD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 13:00:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 29 Dec 2017 23:30:02 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 2/4] PCI/DPC/AER: Address Concurrency between AER and
 DPC
In-Reply-To: <20171229172324.GF16407@localhost.localdomain>
References: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
 <1514532259-19383-3-git-send-email-poza@codeaurora.org>
 <20171229172324.GF16407@localhost.localdomain>
Message-ID: <481784bb38707839493fc04e6a2b4068@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-12-29 22:53, Keith Busch wrote:
> On Fri, Dec 29, 2017 at 12:54:17PM +0530, Oza Pawandeep wrote:
>> This patch addresses the race condition between AER and DPC for 
>> recovery.
>> 
>> Current DPC driver does not do recovery, e.g. calling end-point's 
>> driver's
>> callbacks, which sanitize the device.
>> DPC driver implements link_reset callback, and calls pci_do_recovery.
> 
> I'm not sure I see why any of this is necessary for two reasons:
> 
> 1. A downstream port containment event disables the link. How can a 
> driver
> sanitize an end device when all the end devices below the containment 
> are
> physically inaccessible? Any attempt to access such devices will just
> end with either CA or UR (depending on DPC control settings). Since we
> already know the failed outcome from attempting to access such devices,
> why do you want the drivers to do anything?
> 
Ok I think my statement was misleading, not device sanitation, but the 
device driver making
SW sanitize.
for e.g. have a look at e1000_io_error_detected which is called say in 
case of AER ERR_FATAL msg.
which sanitizes sw stack, interrupts management (synchronize_irq), 
delete timers etc..

yes, DPC would have made the link state disabled, and HW would have 
reset the internal logic with
quiescence activities so yes, any transaction on will end with CA or UR. 
well but device driver
has to handle rest of the possible things as I mentioned (error 
callbacks)

> 2. A DPC event suppresses the error message required for the Linux
> AER driver to run. How can AER and DPC run concurrently?

I afraid I could not grasp the first line completely.

but they way it is triggering AER and DPC on our platform concurrently 
is, we have same MSIx registered
for both AER and DPC, and linux calls the shared handlers to handle both 
the triggers anyway.

otherwise also if ERR_FATAL msg occurs, the Root port should trigger 
both AER and DPC
(assuming both are enabled, and no FW first for AER/DPC)

the problem with the current framework of AER and DPC in Linux is:
both try to act independently, while we know that (for e.g. ERR_FATAL 
msg) is responsible for triggering
both AER and DPC depending on the configuration.  (currently DPC is 
configured for both FATAL and NONFATAL in linux anyway)

It does not make sense that AER goes ahead and attempts to sanitize with 
the device driver's callbacks as I mentioned.
and DPC being unaware, asynchronously disables the link (although this 
is all HW)
but DPC service driver should adapt to some kind of error handling and 
error resume which AER has adapted.

Hence this whole design changes proposed with respect to error handling.

Let me give you another problem statement on the same line:
when DPC is active, AER does not need to act at all...because it doesnt 
make sense for AER to act independently.,
without knowing what DPC service driver is upto!

which is handled in one of the patches.
the point I am trying to make is: DPC should not rely on AER to call 
error callbacks, and AER should not be doing it without knowing that
DPC is active and it is also going to some course of action (be in HW or 
SW)

Regards,
Oza.

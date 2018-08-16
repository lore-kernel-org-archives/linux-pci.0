Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48620 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeHPMAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2018 08:00:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 16 Aug 2018 14:33:18 +0530
From: poza@codeaurora.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <05bc3bccb2c6a0cb1696faf20073e567d7a5b8ee.camel@kernel.crashing.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
 <5bd99bcacb772b588771fce62c61a59fdeb167f3.camel@kernel.crashing.org>
 <290750445f084c479963f54dd36af63a@codeaurora.org>
 <05bc3bccb2c6a0cb1696faf20073e567d7a5b8ee.camel@kernel.crashing.org>
Message-ID: <2894d8df6e44860456377dade9ea5737@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-16 13:42, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-16 at 13:37 +0530, poza@codeaurora.org wrote:
>> >
>> > In fact looking at pcie_do_nonfatal_recovery() it's indeed completely
>> > broken. It tells the driver that the slot was reset without actually
>> > resetting anything... Ugh.
>> >
>> > Ben.
>> 
>> pcie_do_nonfatal_recovery() exhibit the same behavior with or without
>> the patch-series.
>> in short, there was no functional change brought in to
>> pcie_do_nonfatal_recovery()
> 
> Yes, I know, I'm just saying what it does is broken :-)


when I meant spec, i meant PCIe Spec.
At least spec distinguish fatal and non-fatal

"
Non-fatal errors are uncorrectable errors which cause a particular 
transaction to be unreliable but the Link is otherwise fully functional.
Isolating Non-fatal from Fatal errors provides Requester/Receiver logic 
in a device or system management software the opportunity to recover
from the error without resetting the components on the Link and 
disturbing other transactions in progress.
"

Here the basic assumption is link is fully functional, hence we do not 
initiate link reset. (while in case FATAL we do initiate Secondary Bus 
Reset)


okay, so here is what current pcie_do_nonfatal_recovery() doe.

pcie_do_nonfatal_recovery
     report_error_detected()    >> calls driver callbacks
     report_mmio_enabled()
     report_slot_reset()  >> if PCI_ERS_RESULT_NEED_RESET
     report_resume()

If you suggest how it is broken, it will help me to understand.
probably you might want to point out what are the calls need to be added 
or removed or differently handled, specially storage point of view.

Regards,
Oza.

> 
> Keep in mind that those callbacks were designed originally for EEH
> (which predates AER), and so was the spec written.
> 
> We don't actually use the AER code on POWER today, so we didn't notice
> how broken the implementation was :-)
> 
> We should fix that.
> 
> Either we can sort all that out by email, or we should plan some kind
> of catch-up, either at Plumbers (provided I can go there) or maybe a
> webex call.
> 
> Cheers,
> Ben.

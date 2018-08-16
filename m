Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390887AbeHPRJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2018 13:09:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 16 Aug 2018 19:41:04 +0530
From: poza@codeaurora.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <9c7c60eb765c61d007169c9142fb335b0a4080df.camel@kernel.crashing.org>
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
 <2894d8df6e44860456377dade9ea5737@codeaurora.org>
 <9c7c60eb765c61d007169c9142fb335b0a4080df.camel@kernel.crashing.org>
Message-ID: <c00a1ad4ffbf7ccecf3c8d05df4d8d82@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-16 15:37, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-16 at 14:33 +0530, poza@codeaurora.org wrote:
>> On 2018-08-16 13:42, Benjamin Herrenschmidt wrote:
>> >
>> when I meant spec, i meant PCIe Spec.
>> At least spec distinguish fatal and non-fatal
> 
> Yes, I'm well aware of that, however the policy implemented by EEH is
> stricter in that *any* uncorrectable error will trigger an immediate
> freeze of the endpoint in order to prevent bad data propagation.
> 
> However, you don't have to implement it that way for AER. You can
> implement a policy where you don't enforce a reset of the device and
> link unless the driver requests it.
> 
> However if/when the driver does, then you should honor the driver wish
> and do it which isn't currently the case in the AER code.
> 
> Note that the current error callbacks have no way to convey the fatal
> vs. non-fatal information to the device that I can see, we might want
> to change the prototype here with a tree-wide patch if you think that
> drivers might care.
> 
>> Non-fatal errors are uncorrectable errors which cause a particular
>> transaction to be unreliable but the Link is otherwise fully 
>> functional.
>> Isolating Non-fatal from Fatal errors provides Requester/Receiver 
>> logic
>> in a device or system management software the opportunity to recover
>> from the error without resetting the components on the Link and
>> disturbing other transactions in progress.
>> "
>> 
>> Here the basic assumption is link is fully functional, hence we do not
>> initiate link reset. (while in case FATAL we do initiate Secondary Bus
>> Reset)
> 
> See above.
>> 
>> okay, so here is what current pcie_do_nonfatal_recovery() doe.
>> 
>> pcie_do_nonfatal_recovery
>>      report_error_detected()    >> calls driver callbacks
>>      report_mmio_enabled()
>>      report_slot_reset()  >> if PCI_ERS_RESULT_NEED_RESET
> 
> Above if the driver returned "NEED RESET" we should not just "report" a
> slot reset, we should *perform* one :-) Unless the AER code does it in
> a place I missed...

I am willing work on this if Bjorn agrees.
but I am still trying to figure out missing piece.

so Ben,
you are suggesting

ERR_NONFATAL handling
pcie_do_nonfatal_recovery
      report_error_detected()    >> calls driver callbacks
       report_mmio_enabled()
       report_slot_reset()  >> if PCI_ERS_RESULT_NEED_RESET
Here along with calling slot_reset, you are suggesting to do Secondary 
Bus Reset ?

but this is ERR_NONFATAL and according to definition the link is still 
good, so that the transcriptions on PCIe link can happen.
so my question is why do we want to reset the link ?

although
I see following note in the code as well.
                 /*
		 * TODO: Should call platform-specific
		 * functions to reset slot before calling
		 * drivers' slot_reset callbacks?
		 */

Regards,
Oza.

> 
> Also we should do a hot reset at least, not just a link reset.
> 
>>      report_resume()
>> 
>> If you suggest how it is broken, it will help me to understand.
>> probably you might want to point out what are the calls need to be 
>> added
>> or removed or differently handled, specially storage point of view.
> 
> 
>> Regards,
>> Oza.
>> 
>> >
>> > Keep in mind that those callbacks were designed originally for EEH
>> > (which predates AER), and so was the spec written.
>> >
>> > We don't actually use the AER code on POWER today, so we didn't notice
>> > how broken the implementation was :-)
>> >
>> > We should fix that.
>> >
>> > Either we can sort all that out by email, or we should plan some kind
>> > of catch-up, either at Plumbers (provided I can go there) or maybe a
>> > webex call.
>> >
>> > Cheers,
>> > Ben.

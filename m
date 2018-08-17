Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57054 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeHQNcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2018 09:32:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 17 Aug 2018 15:59:39 +0530
From: poza@codeaurora.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <def1568d0c8ce9a455760da1271724d6e65a3286.camel@kernel.crashing.org>
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
 <c00a1ad4ffbf7ccecf3c8d05df4d8d82@codeaurora.org>
 <def1568d0c8ce9a455760da1271724d6e65a3286.camel@kernel.crashing.org>
Message-ID: <65ec0c5b4682c0f0215114ac09d46cf5@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-17 05:00, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-16 at 19:41 +0530, poza@codeaurora.org wrote:
>> 
>> > See above.
>> > >
>> > > okay, so here is what current pcie_do_nonfatal_recovery() doe.
>> > >
>> > > pcie_do_nonfatal_recovery
>> > >      report_error_detected()    >> calls driver callbacks
>> > >      report_mmio_enabled()
>> > >      report_slot_reset()  >> if PCI_ERS_RESULT_NEED_RESET
>> >
>> > Above if the driver returned "NEED RESET" we should not just "report" a
>> > slot reset, we should *perform* one :-) Unless the AER code does it in
>> > a place I missed...
>> 
>> I am willing work on this if Bjorn agrees.
>> but I am still trying to figure out missing piece.
>> 
>> so Ben,
>> you are suggesting
>> 
>> ERR_NONFATAL handling
>> pcie_do_nonfatal_recovery
>>       report_error_detected()    >> calls driver callbacks
>>        report_mmio_enabled()
>>        report_slot_reset()  >> if PCI_ERS_RESULT_NEED_RESET
>> Here along with calling slot_reset, you are suggesting to do Secondary
>> Bus Reset ?
>> 
>> but this is ERR_NONFATAL and according to definition the link is still
>> good, so that the transcriptions on PCIe link can happen.
>> so my question is why do we want to reset the link ?
> 
> The driver responded to you from error_detected() or mmio_enabled()
> that it wants the slot to be reset. So you should do so. This comes
> from the driver deciding that whatever happens, it doesn't trust the
> device state anymore.
> 
> report_slot_reset() iirc is about telling the driver that the reset has
> been performed and it can reconfigure the device.
> 
> To be frank I haven't looked at this in a while, so we should refer to
> the document before ou patched it :-) But the basic design we created
> back then was precisely that the driver would have the ultimate say in
> the matter.

The existing design is; framework dictating drivers what it should do 
rather than driver deciding.
let me explain.

aer_isr
     aer_isr_one_error
          get_device_error_info   >> this checks
               {
                 /* Link is still healthy for IO reads */    >> Bjorn 
this looks like a very strange thing to me, if link is not healthy we 
are not even going for pcie_do_fatal_recovery()
		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
			&info->status);
		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK,
			&info->mask);
		if (!(info->status & ~info->mask))
			return 0;

               {
         handle_error_source
         pcie_do_nonfatal_recovery or pcie_do_fatal_recovery

now it does not seem to me that driver has some way of knowing if it has 
to return PCI_ERS_RESULT_CAN_RECOVER ? or PCI_ERS_RESULT_NEED_RESET?

let us take an example of storage driver here e.g. NVME
nvme_error_detected()  relies heavily on pci_channel_state_t which is 
passed by error framework  (err.c)

I understand your point of view and original intention of design that 
let driver dictate whether it wants slot_reset ?
but driver relies on framework to pass that information in order to take 
decision.

In case of pci_channel_io_frozen  (which is ERR_FATAL), most of the 
drivers demand link reset.

but in case of ERR_NONFATAL, the link is supposed to be functional and 
there is no need for link reset.
and exactly all the PCI based drivers returns 
PCI_ERS_RESULT_CAN_RECOVER, which is valid.


so I think to conclude, you are referring more of your views towards
pcie_do_fatal_recovery()


which does

> remove_devices from the downstream link
> reset_link()   (Secondary bus reset)
> re-enumerate.

and this is what DPC defined, and AER is just following that.

Regards,
Oza.

> 
> Also because multiple devices, at least on power, can share a domain,
> we can get into a situation where one device requires a reset, so all
> will get reset, and their respective drivers need to be notified.
> 
> Note: it's not so much about resetting the *link* than about resetting
> the *device*.
> 
>> although
>> I see following note in the code as well.
>>                  /*
>> 		 * TODO: Should call platform-specific
>> 		 * functions to reset slot before calling
>> 		 * drivers' slot_reset callbacks?
>> 		 */
> 
> Yup :-)
> 
> Cheers,
> Ben.
> 
>> Regards,
>> Oza.
>> 
>> >
>> > Also we should do a hot reset at least, not just a link reset.
>> >
>> > >      report_resume()
>> > >
>> > > If you suggest how it is broken, it will help me to understand.
>> > > probably you might want to point out what are the calls need to be
>> > > added
>> > > or removed or differently handled, specially storage point of view.
>> >
>> >
>> > > Regards,
>> > > Oza.
>> > >
>> > > >
>> > > > Keep in mind that those callbacks were designed originally for EEH
>> > > > (which predates AER), and so was the spec written.
>> > > >
>> > > > We don't actually use the AER code on POWER today, so we didn't notice
>> > > > how broken the implementation was :-)
>> > > >
>> > > > We should fix that.
>> > > >
>> > > > Either we can sort all that out by email, or we should plan some kind
>> > > > of catch-up, either at Plumbers (provided I can go there) or maybe a
>> > > > webex call.
>> > > >
>> > > > Cheers,
>> > > > Ben.

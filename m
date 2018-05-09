Return-Path: <SRS0=iM4V=H4=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=iM4V=H4=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 09 May 2018 18:44:53 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>,
 linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v15 3/9] PCI/AER: Handle ERR_FATAL with removal and
 re-enumeration of devices
In-Reply-To: <20180509130730.GA236548@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-4-git-send-email-poza@codeaurora.org>
 <20180508235330.GN161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180509130730.GA236548@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <b1f9aaf43300ef7a829001e964bf4e72@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-09 18:37, Bjorn Helgaas wrote:
> On Tue, May 08, 2018 at 06:53:30PM -0500, Bjorn Helgaas wrote:
>> On Thu, May 03, 2018 at 01:03:52AM -0400, Oza Pawandeep wrote:
>> > This patch alters the behavior of handling of ERR_FATAL, where removal
>> > of devices is initiated, followed by reset link, followed by
>> > re-enumeration.
>> >
>> > So the errors are handled in a different way as follows:
>> > ERR_NONFATAL => call driver recovery entry points
>> > ERR_FATAL    => remove and re-enumerate
>> >
>> > please refer to Documentation/PCI/pci-error-recovery.txt for more details.
>> >
>> > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> >
>> > diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
>> > index 779b387..206f590 100644
>> > --- a/drivers/pci/pcie/aer/aerdrv.c
>> > +++ b/drivers/pci/pcie/aer/aerdrv.c
>> > @@ -330,6 +330,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>> >  	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
>> >  	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
>> >
>> > +	/*
>> > +	 * This function is called only on ERR_FATAL now, and since
>> > +	 * the pci_report_resume is called only in ERR_NONFATAL case,
>> > +	 * the clearing part has to be taken care here.
>> > +	 */
>> > +	aer_error_resume(dev);
>> 
>> I don't understand this part.  Previously the ERR_FATAL path looked 
>> like
>> this:
>> 
>>   do_recovery
>>     reset_link
>>       driver->reset_link
>>         aer_root_reset
>>           pci_reset_bridge_secondary_bus                # <-- reset
>>     broadcast_error_message(..., report_resume)
>>       pci_walk_bus(..., report_resume, ...)
>>         report_resume
>>       if (cb == report_resume)
>>         pci_cleanup_aer_uncorrect_error_status
>>           pci_write_config_dword(PCI_ERR_UNCOR_STATUS)  # <-- clear 
>> status
>> 
>> After this patch, it will look like this:
>> 
>>   do_recovery
>>     do_fatal_recovery
>>       pci_cleanup_aer_uncorrect_error_status
>>         pci_write_config_dword(PCI_ERR_UNCOR_STATUS)    # <-- clear 
>> status
>>       reset_link
>>         driver->reset_link
>>           aer_root_reset
>>             pci_reset_bridge_secondary_bus              # <-- reset
>>             aer_error_resume
>>               pcie_capability_write_word(PCI_EXP_DEVSTA)        # <-- 
>> clear more
>>               pci_write_config_dword(PCI_ERR_UNCOR_STATUS)      # <-- 
>> clear status
>> 
>> So if I'm understanding correctly, the new path clears the status too
>> early, then clears it again (plus clearing DEVSTA, which we didn't do
>> before) later.
>> 
>> I would think we would want to leave aer_root_reset() alone, and just 
>> move
>> the pci_cleanup_aer_uncorrect_error_status() in do_fatal_recovery() 
>> down so
>> it happens after we call reset_link().  That way the reset/clear 
>> sequence
>> would be the same as it was before.
> 
> I've been fiddling with this a bit myself and will post the results to 
> see
> what you think.


ok so you are suggesting to move pci_cleanup_aer_uncorrect_error_status 
down which I can do.

And not to call aer_error_resume, because you think its clearing the 
status again.

following code: calls aer_error_resume.
pci_broadcast_error_message()
  /*
                  * If the error is reported by an end point, we think 
this
                  * error is related to the upstream link of the end 
point.
                  */
                 if (state == pci_channel_io_normal)
                         /*
                          * the error is non fatal so the bus is ok, just 
invoke
                          * the callback for the function that logged the 
error.
                          */
                         cb(dev, &result_data);
                 else
                         pci_walk_bus(dev->bus, cb, &result_data);


besides aer_error_resume does following things in addition to clearing 
PCI_ERR_UNCOR_STATUS

/* Clean up Root device status */
	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);

if (dev->error_state == pci_channel_io_normal)
		status &= ~mask; /* Clear corresponding nonfatal bits */
	else
		status &= mask; /* Clear corresponding fatal bits */
	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);


so we have to have conditional call
such as
if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
            error_resume


so the code might look like this..

do_recovery
    do_fatal_recovery
        reset_link
          driver->reset_link
            aer_root_reset
                pci_reset_bridge_secondary_bus              # <-- reset
            if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
            {
                aer_error_resume
                    pcie_capability_write_word(PCI_EXP_DEVSTA)        # 
<-- clear more
                    pci_write_config_dword(PCI_ERR_UNCOR_STATUS)      # 
<--
            }
            pci_cleanup_aer_uncorrect_error_status(dev);


does it make sense ?

Regards,
Oza.

Return-Path: <SRS0=OpPG=H5=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=OpPG=H5=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 10 May 2018 19:48:48 +0530
From: poza@codeaurora.org
To: okaya@codeaurora.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner
 <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate
 Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Timur Tabi
 <timur@codeaurora.org>, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v15 3/9] PCI/AER: Handle ERR_FATAL with removal and
 re-enumeration of devices
In-Reply-To: <3cb8c2046967fd9a81a8f846dbafaa82@codeaurora.org>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-4-git-send-email-poza@codeaurora.org>
 <20180508235330.GN161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180509130730.GA236548@bhelgaas-glaptop.roam.corp.google.com>
 <b1f9aaf43300ef7a829001e964bf4e72@codeaurora.org>
 <20180509232111.GA43216@bhelgaas-glaptop.roam.corp.google.com>
 <c2238d174e550250b0b93a497c40cf6a@codeaurora.org>
 <20180510131027.GB173327@bhelgaas-glaptop.roam.corp.google.com>
 <3cb8c2046967fd9a81a8f846dbafaa82@codeaurora.org>
Message-ID: <13b86ad03bd859dd4863766d984fcd04@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-10 18:45, okaya@codeaurora.org wrote:
> On 2018-05-10 14:10, Bjorn Helgaas wrote:
>> On Thu, May 10, 2018 at 12:31:16PM +0530, poza@codeaurora.org wrote:
>>> On 2018-05-10 04:51, Bjorn Helgaas wrote:
>>> > On Wed, May 09, 2018 at 06:44:53PM +0530, poza@codeaurora.org wrote:
>>> > > On 2018-05-09 18:37, Bjorn Helgaas wrote:
>>> > > > On Tue, May 08, 2018 at 06:53:30PM -0500, Bjorn Helgaas wrote:
>>> > > > > On Thu, May 03, 2018 at 01:03:52AM -0400, Oza Pawandeep wrote:
>>> > > > > > This patch alters the behavior of handling of ERR_FATAL, where removal
>>> > > > > > of devices is initiated, followed by reset link, followed by
>>> > > > > > re-enumeration.
>>> > > > > >
>>> > > > > > So the errors are handled in a different way as follows:
>>> > > > > > ERR_NONFATAL => call driver recovery entry points
>>> > > > > > ERR_FATAL    => remove and re-enumerate
>>> > > > > >
>>> > > > > > please refer to Documentation/PCI/pci-error-recovery.txt for more details.
>>> > > > > >
>>> > > > > > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>>> > > > > >
>>> > > > > > diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
>>> > > > > > index 779b387..206f590 100644
>>> > > > > > --- a/drivers/pci/pcie/aer/aerdrv.c
>>> > > > > > +++ b/drivers/pci/pcie/aer/aerdrv.c
>>> > > > > > @@ -330,6 +330,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>> > > > > >         reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
>>> > > > > >         pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
>>> > > > > >
>>> > > > > > +       /*
>>> > > > > > +        * This function is called only on ERR_FATAL now, and since
>>> > > > > > +        * the pci_report_resume is called only in ERR_NONFATAL case,
>>> > > > > > +        * the clearing part has to be taken care here.
>>> > > > > > +        */
>>> > > > > > +       aer_error_resume(dev);
>>> > > > >
>>> > > > > I don't understand this part.  Previously the ERR_FATAL path looked
>>> > > > > like
>>> > > > > this:
>>> > > > >
>>> > > > >   do_recovery
>>> > > > >     reset_link
>>> > > > >       driver->reset_link
>>> > > > >         aer_root_reset
>>> > > > >           pci_reset_bridge_secondary_bus                # <-- reset
>>> > > > >     broadcast_error_message(..., report_resume)
>>> > > > >       pci_walk_bus(..., report_resume, ...)
>>> > > > >         report_resume
>>> > > > >       if (cb == report_resume)
>>> > > > >         pci_cleanup_aer_uncorrect_error_status
>>> > > > >           pci_write_config_dword(PCI_ERR_UNCOR_STATUS)  # <-- clear
>>> > > > > status
>>> > > > >
>>> > > > > After this patch, it will look like this:
>>> > > > >
>>> > > > >   do_recovery
>>> > > > >     do_fatal_recovery
>>> > > > >       pci_cleanup_aer_uncorrect_error_status
>>> > > > >         pci_write_config_dword(PCI_ERR_UNCOR_STATUS)    # <-- clear
>>> > > > > status
>>> > > > >       reset_link
>>> > > > >         driver->reset_link
>>> > > > >           aer_root_reset
>>> > > > >             pci_reset_bridge_secondary_bus              # <-- reset
>>> > > > >             aer_error_resume
>>> > > > >               pcie_capability_write_word(PCI_EXP_DEVSTA)        #
>>> > > > > <-- clear more
>>> > > > >               pci_write_config_dword(PCI_ERR_UNCOR_STATUS)      #
>>> > > > > <-- clear status
>>> > > > >
>>> > > > > So if I'm understanding correctly, the new path clears the status too
>>> > > > > early, then clears it again (plus clearing DEVSTA, which we didn't do
>>> > > > > before) later.
>>> > > > >
>>> > > > > I would think we would want to leave aer_root_reset() alone, and
>>> > > > > just move
>>> > > > > the pci_cleanup_aer_uncorrect_error_status() in do_fatal_recovery()
>>> > > > > down so
>>> > > > > it happens after we call reset_link().  That way the reset/clear
>>> > > > > sequence
>>> > > > > would be the same as it was before.
>>> > > >
>>> > > > I've been fiddling with this a bit myself and will post the results to
>>> > > > see
>>> > > > what you think.
>>> > >
>>> > >
>>> > > ok so you are suggesting to move
>>> > > pci_cleanup_aer_uncorrect_error_status down
>>> > > which I can do.
>>> > >
>>> > > And not to call aer_error_resume, because you think its clearing the
>>> > > status
>>> > > again.
>>> > >
>>> > > following code: calls aer_error_resume.
>>> > > pci_broadcast_error_message()
>>> > >  /*
>>> > >                  * If the error is reported by an end point, we
>>> > > think this
>>> > >                  * error is related to the upstream link of the end
>>> > > point.
>>> > >                  */
>>> > >                 if (state == pci_channel_io_normal)
>>> > >                         /*
>>> > >                          * the error is non fatal so the bus is ok,
>>> > > just
>>> > > invoke
>>> > >                          * the callback for the function that logged
>>> > > the
>>> > > error.
>>> > >                          */
>>> > >                         cb(dev, &result_data);
>>> > >                 else
>>> > >                         pci_walk_bus(dev->bus, cb, &result_data);
>>> >
>>> > Holy crap, I thought this could not possibly get any more complicated,
>>> > but you're right; we do actually call aer_error_resume() today via an
>>> > extremely convoluted path:
>>> >
>>> >   do_recovery(pci_dev)
>>> >     broadcast_error_message(..., error_detected, ...)
>>> >     if (AER_FATAL)
>>> >       reset_link(pci_dev)
>>> >         udev = BRIDGE ? pci_dev : pci_dev->bus->self
>>> >         driver->reset_link(udev)
>>> >           aer_root_reset(udev)
>>> >     if (CAN_RECOVER)
>>> >       broadcast_error_message(..., mmio_enabled, ...)
>>> >     if (NEED_RESET)
>>> >       broadcast_error_message(..., slot_reset, ...)
>>> >     broadcast_error_message(dev, ..., report_resume, ...)
>>> >       if (BRIDGE)
>>> >         report_resume
>>> >           driver->resume
>>> >             pcie_portdrv_err_resume
>>> >               device_for_each_child(..., resume_iter)
>>> >                 resume_iter
>>> >                   driver->error_resume
>>> >                     aer_error_resume
>>> >         pci_cleanup_aer_uncorrect_error_status(pci_dev)       # only if
>>> > BRIDGE
>>> >           pci_write_config_dword(PCI_ERR_UNCOR_STATUS)
>>> >
>>> > aerdriver is the only port service driver that implements
>>> > .error_resume(), and aerdriver only binds to root ports.  I can't
>>> > really believe all these device_for_each_child()/resume_iter()
>>> > gyrations are necessary when this is AER code calling AER code.
>>> >
>>> > Bjorn
>>> 
>>> here is the code of do_fatal_recovery, where I have moved the things 
>>> down
>>> and doing only if it is bridge.
>>> let me know how this looks to you, so then I can post v16.
>> 
>> This looks superficially OK.  It is very difficult for me to verify 
>> that
>> the behavior is equivalent to the current code, but that's not your 
>> fault;
>> it's just a consequence of the existing design.
>> 
>> I have a couple trivial comments elsewhere, and I'll respond to those
>> patches individually.
>> 
>>> static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int 
>>> severity)
>>> {
>>>         struct pci_dev *udev;
>>>         struct pci_bus *parent;
>>>         struct pci_dev *pdev, *temp;
>>>         struct aer_broadcast_data result_data;
>>>         pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
>>> 
>>> 
>>>         if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
>>>                 udev = dev;
>>>         else
>>>                 udev = dev->bus->self;
>>> 
>>>         parent = udev->subordinate;
>>>         pci_lock_rescan_remove();
>>>         list_for_each_entry_safe_reverse(pdev, temp, 
>>> &parent->devices,
>>>                                  bus_list) {
>>>                 pci_dev_get(pdev);
>>>                 pci_dev_set_disconnected(pdev, NULL);
>>>                 if (pci_has_subordinate(pdev))
>>>                         pci_walk_bus(pdev->subordinate,
>>>                                      pci_dev_set_disconnected, NULL);
>>>                 pci_stop_and_remove_bus_device(pdev);
>>>                 pci_dev_put(pdev);
>>>         }
>>> 
>>>         result = reset_link(udev, severity);
>>>         if (severity == AER_FATAL && dev->hdr_type ==
>>> PCI_HEADER_TYPE_BRIDGE) {
>>>                 pci_walk_bus(dev->subordinate, report_resume, 
>>> &result_data);
> 
> Why are we calling resume?

the reason we have to call resume here, because we are not calling 
aer_resume() any more in root_reset.
and we have to call resume only in bridge case.
please have a look at couple of conversation back with Bjorn.
the objective is to align the sequence close to the current code.

> 
>>>                 pci_cleanup_aer_uncorrect_error_status(dev);
>>>                 dev->error_state = pci_channel_io_normal;
>>>         }
>>>         if (result == PCI_ERS_RESULT_RECOVERED)
>>>                 if (pcie_wait_for_link(udev, true))
>>>                         pci_rescan_bus(udev->bus);
>>> 
>>>         pci_unlock_rescan_remove();
>>> 
>>>         return result;
>>> }
>>> 
>>> Regards,
>>> Oza.
>>> 
>>> 

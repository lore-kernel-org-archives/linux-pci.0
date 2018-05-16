Return-Path: <SRS0=sGOI=ID=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=sGOI=ID=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 16 May 2018 19:28:45 +0530
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
Subject: Re: [PATCH v16 8/9] PCI/DPC: Unify and plumb error handling into DPC
In-Reply-To: <20180516130455.GA233993@bhelgaas-glaptop.roam.corp.google.com>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
 <1526035408-31328-9-git-send-email-poza@codeaurora.org>
 <a497fae20a326bdf67395c907a5b6b0d@codeaurora.org>
 <20180515235632.GB11156@bhelgaas-glaptop.roam.corp.google.com>
 <2ca65f6b38668cfcf553833409ee38e3@codeaurora.org>
 <20180516105236.GA217390@bhelgaas-glaptop.roam.corp.google.com>
 <3822b5ea0b05f9836b991ce18f16a30f@codeaurora.org>
 <20180516130455.GA233993@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <1efff82478fd1a7386bec8a2a797bed0@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-16 18:34, Bjorn Helgaas wrote:
> On Wed, May 16, 2018 at 05:45:58PM +0530, poza@codeaurora.org wrote:
>> On 2018-05-16 16:22, Bjorn Helgaas wrote:
>> > On Wed, May 16, 2018 at 01:46:25PM +0530, poza@codeaurora.org wrote:
>> > > On 2018-05-16 05:26, Bjorn Helgaas wrote:
>> > > > On Fri, May 11, 2018 at 05:22:08PM +0530, poza@codeaurora.org wrote:
>> > > > > On 2018-05-11 16:13, Oza Pawandeep wrote:
>> > > > > > DPC driver implements link_reset callback, and calls
>> > > > > > pci_do_fatal_recovery().
>> > > > > >
>> > > > > > Which follows standard path of ERR_FATAL recovery.
>> > > > > >
>> > > > > > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> > > > > >
>> > > > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> > > > > > index 5e8857a..6af7595 100644
>> > > > > > --- a/drivers/pci/pci.h
>> > > > > > +++ b/drivers/pci/pci.h
>> > > > > > @@ -354,7 +354,7 @@ static inline resource_size_t
>> > > > > > pci_resource_alignment(struct pci_dev *dev,
>> > > > > >  void pci_enable_acs(struct pci_dev *dev);
>> > > > > >
>> > > > > >  /* PCI error reporting and recovery */
>> > > > > > -void pcie_do_fatal_recovery(struct pci_dev *dev);
>> > > > > > +void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service);
>> > > > > >  void pcie_do_nonfatal_recovery(struct pci_dev *dev);
>> > > > > >
>> > > > > >  bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>> > > > > > diff --git a/drivers/pci/pcie/aer/aerdrv_core.c
>> > > > > > b/drivers/pci/pcie/aer/aerdrv_core.c
>> > > > > > index fdfc474..36e622d 100644
>> > > > > > --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> > > > > > +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> > > > > > @@ -254,7 +254,7 @@ static void handle_error_source(struct pcie_device
>> > > > > > *aerdev,
>> > > > > >  	} else if (info->severity == AER_NONFATAL)
>> > > > > >  		pcie_do_nonfatal_recovery(dev);
>> > > > > >  	else if (info->severity == AER_FATAL)
>> > > > > > -		pcie_do_fatal_recovery(dev);
>> > > > > > +		pcie_do_fatal_recovery(dev, PCIE_PORT_SERVICE_AER);
>> > > > > >  }
>> > > > > >
>> > > > > >  #ifdef CONFIG_ACPI_APEI_PCIEAER
>> > > > > > @@ -321,7 +321,7 @@ static void aer_recover_work_func(struct work_struct
>> > > > > > *work)
>> > > > > >  		if (entry.severity == AER_NONFATAL)
>> > > > > >  			pcie_do_nonfatal_recovery(pdev);
>> > > > > >  		else if (entry.severity == AER_FATAL)
>> > > > > > -			pcie_do_fatal_recovery(pdev);
>> > > > > > +			pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_AER);
>> > > > > >  		pci_dev_put(pdev);
>> > > > > >  	}
>> > > > > >  }
>> > > > > > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> > > > > > index 80ec384..5680c13 100644
>> > > > > > --- a/drivers/pci/pcie/dpc.c
>> > > > > > +++ b/drivers/pci/pcie/dpc.c
>> > > > > > @@ -73,29 +73,31 @@ static void dpc_wait_link_inactive(struct dpc_dev
>> > > > > > *dpc)
>> > > > > >  	pcie_wait_for_link(pdev, false);
>> > > > > >  }
>> > > > > >
>> > > > > > -static void dpc_work(struct work_struct *work)
>> > > > > > +static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>> > > > > >  {
>> > > > > > -	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
>> > > > > > -	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
>> > > > > > -	struct pci_bus *parent = pdev->subordinate;
>> > > > > > -	u16 cap = dpc->cap_pos, ctl;
>> > > > > > -
>> > > > > > -	pci_lock_rescan_remove();
>> > > > > > -	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
>> > > > > > -					 bus_list) {
>> > > > > > -		pci_dev_get(dev);
>> > > > > > -		pci_dev_set_disconnected(dev, NULL);
>> > > > > > -		if (pci_has_subordinate(dev))
>> > > > > > -			pci_walk_bus(dev->subordinate,
>> > > > > > -				     pci_dev_set_disconnected, NULL);
>> > > > > > -		pci_stop_and_remove_bus_device(dev);
>> > > > > > -		pci_dev_put(dev);
>> > > > > > -	}
>> > > > > > -	pci_unlock_rescan_remove();
>> > > > > > -
>> > > > > > +	struct dpc_dev *dpc;
>> > > > > > +	struct pcie_device *pciedev;
>> > > > > > +	struct device *devdpc;
>> > > > > > +	u16 cap, ctl;
>> > > > > > +
>> > > > > > +	/*
>> > > > > > +	 * DPC disables the Link automatically in hardware, so it has
>> > > > > > +	 * already been reset by the time we get here.
>> > > > > > +	 */
>> > > > > > +
>> > > > > > +	devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
>> > > > > > +	pciedev = to_pcie_device(devdpc);
>> > > > > > +	dpc = get_service_data(pciedev);
>> > > > > > +	cap = dpc->cap_pos;
>> > > > > > +
>> > > > > > +	/*
>> > > > > > +	 * Waiting until the link is inactive, then clearing DPC
>> > > > > > +	 * trigger status to allow the port to leave DPC.
>> > > > > > +	 */
>> > > > > >  	dpc_wait_link_inactive(dpc);
>> > > > > > +
>> > > > > >  	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
>> > > > > > -		return;
>> > > > > > +		return PCI_ERS_RESULT_DISCONNECT;
>> > > > > >  	if (dpc->rp_extensions && dpc->rp_pio_status) {
>> > > > > >  		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
>> > > > > >  				       dpc->rp_pio_status);
>> > > > > > @@ -108,6 +110,17 @@ static void dpc_work(struct work_struct *work)
>> > > > > >  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
>> > > > > >  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
>> > > > > >  			      ctl | PCI_EXP_DPC_CTL_INT_EN);
>> > > > > > +
>> > > > > > +	return PCI_ERS_RESULT_RECOVERED;
>> > > > > > +}
>> > > > > > +
>> > > > > > +static void dpc_work(struct work_struct *work)
>> > > > > > +{
>> > > > > > +	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
>> > > > > > +	struct pci_dev *pdev = dpc->dev->port;
>> > > > > > +
>> > > > > > +	/* From DPC point of view error is always FATAL. */
>> > > > > > +	pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_DPC);
>> > > > > >  }
>> > > > > >
>> > > > > >  static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>> > > > > > @@ -288,6 +301,7 @@ static struct pcie_port_service_driver dpcdriver = {
>> > > > > >  	.service	= PCIE_PORT_SERVICE_DPC,
>> > > > > >  	.probe		= dpc_probe,
>> > > > > >  	.remove		= dpc_remove,
>> > > > > > +	.reset_link	= dpc_reset_link,
>> > > > > >  };
>> > > > > >
>> > > > > >  static int __init dpc_service_init(void)
>> > > > > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> > > > > > index 33a16b1..29ff148 100644
>> > > > > > --- a/drivers/pci/pcie/err.c
>> > > > > > +++ b/drivers/pci/pcie/err.c
>> > > > > > @@ -185,7 +185,7 @@ static pci_ers_result_t default_reset_link(struct
>> > > > > > pci_dev *dev)
>> > > > > >  	return PCI_ERS_RESULT_RECOVERED;
>> > > > > >  }
>> > > > > >
>> > > > > > -static pci_ers_result_t reset_link(struct pci_dev *dev)
>> > > > > > +static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
>> > > > > >  {
>> > > > > >  	struct pci_dev *udev;
>> > > > > >  	pci_ers_result_t status;
>> > > > > > @@ -200,7 +200,7 @@ static pci_ers_result_t reset_link(struct pci_dev
>> > > > > > *dev)
>> > > > > >  	}
>> > > > > >
>> > > > > >  	/* Use the aer driver of the component firstly */
>> > > > > > -	driver = pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);
>> > > > > > +	driver = pcie_port_find_service(udev, service);
>> > > > > >
>> > > > > >  	if (driver && driver->reset_link) {
>> > > > > >  		status = driver->reset_link(udev);
>> > > > > > @@ -287,7 +287,7 @@ static pci_ers_result_t
>> > > > > > broadcast_error_message(struct pci_dev *dev,
>> > > > > >   * followed by re-enumeration of devices.
>> > > > > >   */
>> > > > > >
>> > > > > > -void pcie_do_fatal_recovery(struct pci_dev *dev)
>> > > > > > +void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>> > > > > >  {
>> > > > > >  	struct pci_dev *udev;
>> > > > > >  	struct pci_bus *parent;
>> > > > > > @@ -313,7 +313,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev)
>> > > > > >  		pci_dev_put(pdev);
>> > > > > >  	}
>> > > > > >
>> > > > > > -	result = reset_link(udev);
>> > > > > > +	result = reset_link(udev, service);
>> > > > > >
>> > > > > >  	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> > > > > >  		/*
>> > > > > > diff --git a/include/linux/aer.h b/include/linux/aer.h
>> > > > > > index 8f87bbe..0c506fe 100644
>> > > > > > --- a/include/linux/aer.h
>> > > > > > +++ b/include/linux/aer.h
>> > > > > > @@ -14,6 +14,7 @@
>> > > > > >  #define AER_NONFATAL			0
>> > > > > >  #define AER_FATAL			1
>> > > > > >  #define AER_CORRECTABLE			2
>> > > > > > +#define DPC_FATAL			4
>> > > >
>> > > > I think DPC_FATAL can be 3, since these values are not used as a bit
>> > > > mask.
>> > > >
>> > > > > >  struct pci_dev;
>> > > > >
>> > > > >
>> > > > > Hi Bjorn,
>> > > > >
>> > > > >
>> > > > > I have addressed all the comments, and I hope we are heading towards
>> > > > > closure.
>> > > > >
>> > > > > I just figure that pcie_do_fatal_recovery  (which is getting
>> > > > > executed for
>> > > > > DPC as well)
>> > > > >
>> > > > > if (result == PCI_ERS_RESULT_RECOVERED) {
>> > > > >                 if (pcie_wait_for_link(udev, true))
>> > > > >                         pci_rescan_bus(udev->bus);
>> > > > >                 pci_info(dev, "Device recovery successful\n");
>> > > > >         }
>> > > > >
>> > > > > I have to correct it to
>> > > > >
>> > > > > if (service==AER  && result == PCI_ERS_RESULT_RECOVERED) {
>> > > > >                 if (pcie_wait_for_link(udev, true))
>> > > > >                         pci_rescan_bus(udev->bus);
>> > > > >                 pci_info(dev, "Device recovery successful\n");
>> > > > >         }
>> > > >
>> > > > This patch is mostly a restructuring of DPC and doesn't really change
>> > > > its
>> > > > behavior.  DPC didn't previously call pcie_wait_for_link() or
>> > > > pci_rescan_bus(), so I agree that adding the "service==AER" test will
>> > > > help preserve the existing DPC behavior.
>> > > >
>> > > > However, the rescan should happen with DPC *somewhere* and we should
>> > > > clarify where that is.  Maybe for now we only need a comment about where
>> > > > that happens.  Ideally, we could eventually converge this so the same
>> > > > mechanism is used for AER and DPC, so we wouldn't need a test like
>> > > > "service=AER".
>> >
>> > Please still add a comment here about why the rescan behavior is
>> > different.
>> >
>> > > I am sorry I pasted the wrong snippet.
>> > > following needs to be fixed in v17.
>> > > from:
>> > >    if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> > >                 /*
>> > >                  * If the error is reported by a bridge, we think
>> > > this error
>> > >                  * is related to the downstream link of the bridge,
>> > > so we
>> > >                  * do error recovery on all subordinates of the bridge
>> > > instead
>> > >                  * of the bridge and clear the error status of the
>> > > bridge.
>> > >                  */
>> > >                 pci_walk_bus(dev->subordinate, report_resume,
>> > > &result_data);
>> > >                 pci_cleanup_aer_uncorrect_error_status(dev);
>> > >         }
>> > >
>> > >
>> > > to
>> > >
>> > >    if (service==AER  && dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> > >                 /*
>> > >                  * If the error is reported by a bridge, we think
>> > > this error
>> > >                  * is related to the downstream link of the bridge,
>> > > so we
>> > >                  * do error recovery on all subordinates of the bridge
>> > > instead
>> > >                  * of the bridge and clear the error status of the
>> > > bridge.
>> > >                  */
>> > >                 pci_walk_bus(dev->subordinate, report_resume,
>> > > &result_data);
>> > >                 pci_cleanup_aer_uncorrect_error_status(dev);
>> > >         }
>> > >
>> > > this is only needed in case of AER.
>> >
>> > Oh, I missed this before.  It makes sense to clear the AER status
>> > here, but why do we need to call report_resume()?  We just called all
>> > the driver .remove() methods and detached the drivers from the
>> > devices.  So I don't think report_resume() will do anything
>> > ("dev->driver" should be NULL) except set the dev->error_state to
>> > pci_channel_io_normal.  We probably don't need that because we didn't
>> > change error_state in this fatal error path.
>> 
>> if you remember, the path ends up calling
>> aer_error_resume
>> 
>> the existing code ends up calling aer_error_resume as follows.
>> 
>> do_recovery(pci_dev)
>>     broadcast_error_message(..., error_detected, ...)
>>     if (AER_FATAL)
>>       reset_link(pci_dev)
>>         udev = BRIDGE ? pci_dev : pci_dev->bus->self
>>         driver->reset_link(udev)
>>           aer_root_reset(udev)
>>     if (CAN_RECOVER)
>>       broadcast_error_message(..., mmio_enabled, ...)
>>     if (NEED_RESET)
>>       broadcast_error_message(..., slot_reset, ...)
>>     broadcast_error_message(dev, ..., report_resume, ...)
>>       if (BRIDGE)
>>         report_resume
>>           driver->resume
>>             pcie_portdrv_err_resume
>>               device_for_each_child(..., resume_iter)
>>                 resume_iter
>>                   driver->error_resume
>>                     aer_error_resume
>>         pci_cleanup_aer_uncorrect_error_status(pci_dev)       # only 
>> if
>> BRIDGE
>>           pci_write_config_dword(PCI_ERR_UNCOR_STATUS)
>> 
>> hence I think we have to call it in order to clear the root port
>> PCI_ERR_UNCOR_STATUS and PCI_EXP_DEVSTA.
>> makes sense ?
> 
> I know I sent you the call graph above, so you would think I might
> understand it, but you would be mistaken :)  This still doesn't make
> sense to me.
> 
> I think your point is that we need to call aer_error_resume().  That
> is the aerdriver.error_resume() method.  The AER driver only binds to
> root ports.
> 
> This path:
> 
>   pcie_do_fatal_recovery
>     pci_walk_bus(dev->subordinate, report_resume, &result_data)
> 
> calls report_resume() for every device on the dev->subordinate bus
> (and for anything below those devices).  There are no root ports on
> that dev->subordinate bus, because root ports are always on a root
> bus, never on a subordinate bus.
> 
> So I don't see how report_resume() can ever get to aer_error_resume().
> Can you instrument that path and verify that it actually does get
> there somehow?


Then I being to wonder that aer_error_resume() gets ever called from 
anywhere ?
because I was testing this with EP poit of view.

another thing is aer_error_resume() does clear the things for RP, so it 
makes sense to call it in BRIDGE case.
anyway let me go ahead and call this code to see what gets called.

Regards,
Oza.

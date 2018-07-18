Return-Path: <SRS0=u+xi=KC=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=u+xi=KC=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 18 Jul 2018 14:43:46 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 1/6] PCI/AER: Take severity mask into account while
 clearing error bits
In-Reply-To: <20180717213601.GC128988@bhelgaas-glaptop.roam.corp.google.com>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
 <1529661494-20936-2-git-send-email-poza@codeaurora.org>
 <20180717190329.GA128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180717213601.GC128988@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <e0296f79855257d6960a63471c53fbf1@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-18 03:06, Bjorn Helgaas wrote:
> On Tue, Jul 17, 2018 at 02:03:29PM -0500, Bjorn Helgaas wrote:
>> Hi Oza,
>> 
>> Thanks for doing this!
>> 
>> On Fri, Jun 22, 2018 at 05:58:09AM -0400, Oza Pawandeep wrote:
>> > pci_cleanup_aer_uncorrect_error_status() is called by different slot_reset
>> > callbacks in case of ERR_NONFATAL.
>> 
>> IIRC, the current strategy is:
>> 
>>   ERR_COR: log only
>>   ERR_NONFATAL: call driver callbacks (pci_error_handlers)
>>   ERR_FATAL: remove device and re-enumerate
>> 
>> So these slot_reset callbacks are only used for ERR_NONFATAL, which
>> are all uncorrectable errors, of course.
>> 
>> This patch makes it so that when the slot_reset callbacks call
>> pci_cleanup_aer_uncorrect_error_status(), we only clear the
>> bits set by ERR_NONFATAL events (this is determined by
>> PCI_ERR_UNCOR_SEVER).
>> 
>> That makes good sense to me.  All these status bits are RW1CS, so they
>> will be preserved across a reset but will be cleared when we
>> re-enumerate, in this path:
>> 
>>   pci_init_capabilities
>>     pci_aer_init
>>       pci_cleanup_aer_error_status_regs
>>       # clear all PCI_ERR_UNCOR_STATUS and PCI_ERR_COR_STATUS bits
>> 
>> > AER uncorrectable error status should take severity into account in order
>> > to clear the bits, so that ERR_NONFATAL path does not clear the bit which
>> > are marked with severity fatal.
>> 
>> Two comments:
>> 
>> 1) Can you split this into two patches, one that changes
>> pci_cleanup_aer_uncorrect_error_status() so it looks like the error
>> clearing code in aer_error_resume(), and a second that factors out the
>> duplicate code?
>> 
>> 2) Maybe use "sev" or "sever" instead of "mask" for the local
>> variable, since there is also a separate PCI_ERR_UNCOR_MASK register,
>> which is not involved here.
> 
> Let me back up a little here: I'm not asking you to do the things
> below here.  They're just possible future things, so we can think
> about them after this series.  And the things above are things I can
> easily do myself.  So no action required from you, unless you think
> I'm on the wrong track :)

I agree with your points, and have taken them into account for future 
series reference as well.

what about PATCH-2 of this series ?
that clears ERR_FATAL bits, but as you said, during re-enumeration
pci_init_capabilities
      pci_aer_init
        pci_cleanup_aer_error_status_regs
        # clear all PCI_ERR_UNCOR_STATUS and PCI_ERR_COR_STATUS bits

but that should clear the ERR_FATAL of the devices beneath.

PATCH2: we are doing it for BRIDGE where we think where ERR_FATAL was 
reported by bridge and the problem is with downstream link.
if ((service == PCIE_PORT_SERVICE_AER) &&
	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
		/*
		 * If the error is reported by a bridge, we think this error
		 * is related to the downstream link of the bridge, so we
		 * do error recovery on all subordinates of the bridge instead
		 * of the bridge and clear the error status of the bridge.
		 */
		pci_cleanup_aer_uncorrect_error_status(dev);
	}


so overall, I think all the patches are required, if you have comments 
please let me know.
so far I see that, no action is required from me.

> 
>> 3) The "pci_cleanup_aer_uncorrect_error_status()" name no longer
>> really describes what this does.  Something like
>> "pci_aer_clear_nonfatal_status()" would be more descriptive.  But I
>> see you have a subsequent patch (which I haven't looked at yet) that
>> is related to this.
>> 
>> 4) I don't think the driver slot_reset callbacks should be responsible
>> for clearing these AER status bits.  Can we clear them somewhere in
>> the pcie_do_nonfatal_recovery() path and remove these calls from the
>> drivers?
>> 
>> 5) In principle, we should only read PCI_ERR_UNCOR_STATUS *once* per
>> device when handling an error.  We currently read it three times:
>> 
>>   aer_isr
>>     aer_isr_one_error
>>       find_source_device
>>         find_device_iter
>>           is_error_source
>>             read PCI_ERR_UNCOR_STATUS              # 1
>>       aer_process_err_devices
>>         get_device_error_info(e_info->dev[i])
>>           read PCI_ERR_UNCOR_STATUS                # 2
>>         handle_error_source
>>           pcie_do_nonfatal_recovery
>>             ...
>>               report_slot_reset
>>                 driver->err_handler->slot_reset
>>                   pci_cleanup_aer_uncorrect_error_status
>>                     read PCI_ERR_UNCOR_STATUS      # 3
>> 
>> OK, that was more than two comments :)

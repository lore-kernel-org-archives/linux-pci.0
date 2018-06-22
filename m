Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933440AbeFVKLv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2018 06:11:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 22 Jun 2018 15:41:50 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 5/7] PCI/DPC: Print AER status in DPC event handling
In-Reply-To: <20180621140525.GB26623@localhost.localdomain>
References: <20180620213833.25072-1-keith.busch@intel.com>
 <20180620213833.25072-5-keith.busch@intel.com>
 <9cc1594055f03c0e4b4d1b50384107e8@codeaurora.org>
 <20180621140525.GB26623@localhost.localdomain>
Message-ID: <f25c5f839166d0f94fc8a1b6def2fe14@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-21 19:35, Keith Busch wrote:
> On Thu, Jun 21, 2018 at 02:46:10PM +0530, poza@codeaurora.org wrote:
>> On 2018-06-21 03:08, Keith Busch wrote:
>> > @@ -185,6 +187,10 @@ static void dpc_work(struct work_struct *work)
>> >  	/* show RP PIO error detail information */
>> >  	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
>> >  		dpc_process_rp_pio_error(dpc);
>> > +	else if (reason == 0 && aer_get_device_error_info(pdev, &info)) {
>> > +		aer_print_error(pdev, &info);
>> > +		pci_cleanup_aer_uncorrect_error_status(pdev);
>> 
>> 6.2.10 for Downstream Port Containment:
>> 
>>   When DPC is triggered due to receipt of an uncorrectable error 
>> Message,
>>   the Requester ID from the Message is recorded in the DPC Error
>>   Source ID register and that Message is discarded and not forwarded
>>   Upstream. When DPC is triggered by an unmasked uncorrectable error,
>>   that error will not be signaled with an uncorrectable error Message,
>>   even if otherwise enabled.
>> 
>> Inst the message is discarded and not forwarded to upstream.
>> which means that we should not find AER status set in RP or Switch.
>> in other words, at time either we will find DPC or AER triggered but 
>> not
>> both at the same time.
>> then when DPC is triggered why do we need to
>> pci_cleanup_aer_uncorrect_error_status(pdev); ?
> 
> According to the sequence diagram in 6.2.5, an uncorrectable error has
> the cooresponding bits set in the Device Status and AER Uncorrectable
> Error Status registers before DPC specifics are considered. DPC just
> suppresses the ERR_[NON]FATAL messages, but the detecting ports AER
> status, if implemented, should reflect what occured.

Hi Keith,

was thinking that current code
pcie_do_fatal_recovery already does call

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


instead of calling it here in dpc driver, can we make use of that 
existing call ?
probably we just might need to remove
if ((service == PCIE_PORT_SERVICE_AER) condition

Regards,
Oza.

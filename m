Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeEQPEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2018 11:04:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 17 May 2018 20:34:13 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCHv2 7/7] PCI/DPC: Print AER status in DPC event handling
In-Reply-To: <12ab6f9ef1ab79fd09ff7ec583e1d2da@codeaurora.org>
References: <20180402162203.3370-1-keith.busch@intel.com>
 <20180402162203.3370-8-keith.busch@intel.com>
 <12ab6f9ef1ab79fd09ff7ec583e1d2da@codeaurora.org>
Message-ID: <f9bb09d1d73b19231017a42258eef340@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-17 20:32, poza@codeaurora.org wrote:
> On 2018-04-02 21:52, Keith Busch wrote:
>> A DPC enabled device suppresses ERR_(NON)FATAL messages, preventing 
>> the
>> AER handler from reporting error details. If the DPC trigger reason 
>> says
>> the downstream port detected the error, this patch has the DPC driver
>> collect the AER uncorrectable status for logging, then clears the 
>> status.
>> 
>> Signed-off-by: Keith Busch <keith.busch@intel.com>
>> ---
>>  drivers/pci/pcie/pcie-dpc.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
>> index e12837ee4f1c..76f963a5089e 100644
>> --- a/drivers/pci/pcie/pcie-dpc.c
>> +++ b/drivers/pci/pcie/pcie-dpc.c
>> @@ -85,6 +85,7 @@ static void dpc_wait_link_inactive(struct dpc_dev 
>> *dpc)
>> 
>>  static void dpc_work(struct work_struct *work)
>>  {
>> +	struct aer_err_info info;
>>  	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
>>  	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
>>  	struct pci_bus *parent = pdev->subordinate;
>> @@ -108,8 +109,12 @@ static void dpc_work(struct work_struct *work)
>>  		 (ext_reason == 1) ? "software trigger" :
>>  				     "reserved error");
>> 
>> -	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
>> +	if (dpc->rp_extensions && reason == 3 && ext_reason == 0) {
>>  		pio_status = dpc_process_rp_pio_error(dpc);
>> +	} else if (reason == 0 && aer_get_device_error_info(pdev, &info)) {
>> +		aer_print_error(pdev, &info);
>> +		pci_cleanup_aer_uncorrect_error_status(pdev);
>> +	}
>> 
>>  	pci_lock_rescan_remove();
>>  	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> 
> 
> I am not sure if this series is in pursuit. but was wondering why do
> we need to clear aer status in DPC (when DPC is triggered)?
> because
> 
> 6.2.10 for Downstream Port Containment:
> 
>   When DPC is triggered due to receipt of an uncorrectable error 
> Message,
>   the Requester ID from the Message is recorded in the DPC Error
>   Source ID register and that Message is discarded and not forwarded
>   Upstream. When DPC is triggered by an unmasked uncorrectable error,
>   that error will not be signaled with an uncorrectable error Message,
>   even if otherwise enabled.
> 
> so when DPC is active, the msg is discarded and not forwarded to 
> upstream.
> which means that we should find AER status set in RP or Switch.
> 
> Regards,
> Oza.

Correction: which means that we should *not* find AER status set in RP 
or Switch.

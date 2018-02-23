Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBWFWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 00:22:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 23 Feb 2018 10:52:47 +0530
From: poza@codeaurora.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v9 7/7] PCI/DPC: Enumerate the devices after DPC trigger
 event
In-Reply-To: <d8da89bf-aaa1-c6ed-d21a-4cd51265d4a2@infradead.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
 <1519285571-5634-8-git-send-email-poza@codeaurora.org>
 <d8da89bf-aaa1-c6ed-d21a-4cd51265d4a2@infradead.org>
Message-ID: <a5cd1c22acb9178301dd415e67f40f89@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-02-23 00:53, Randy Dunlap wrote:
> On 02/21/2018 11:46 PM, Oza Pawandeep wrote:
>> Implement error_resume callback in DPC so, after DPC trigger event
>> enumerates the devices beneath.
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
>> index fce4518..59c01c7 100644
>> --- a/drivers/pci/pcie/pcie-dpc.c
>> +++ b/drivers/pci/pcie/pcie-dpc.c
>> @@ -129,6 +129,23 @@ static void dpc_wait_link_inactive(struct dpc_dev 
>> *dpc)
>>  }
>> 
>>  /**
>> + * dpc_error_resume - enumerate the devices beneath
>> + * @dev: pointer to Root Port's pci_dev data structure
> 
>     * @pdev: ...
> 
>> + *
>> + * Invoked by Port Bus driver during nonfatal recovery.
>> + */
>> +static void dpc_error_resume(struct pci_dev *pdev)
>> +{
>> +	bool active = true;
>> +
>> +	if (pci_wait_for_link(pdev, active)) {
>> +		pci_lock_rescan_remove();
>> +		pci_rescan_bus(pdev->bus);
>> +		pci_unlock_rescan_remove();
>> +	}
>> +}
>> +
>> +/**
>>   * dpc_reset_link - reset link DPC  routine
>>   * @dev: pointer to Root Port's pci_dev data structure
>>   *
>> diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
>> index 6844347..4950f49 100644
>> --- a/drivers/pci/pcie/pcie-err.c
>> +++ b/drivers/pci/pcie/pcie-err.c
>> @@ -256,6 +258,15 @@ static pci_ers_result_t 
>> broadcast_error_message(struct pci_dev *dev,
>>  		result_data.result = PCI_ERS_RESULT_RECOVERED;
>> 
>>  	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> +		/* If DPC is triggered, call resume error hanlder
> 
> 		                                          handler
> 
> Kernel multi-line comment style is:
> 		/*
> 		 * Begin comment here.
> 		 * foo bar blah
> 		 */
> 
>> +		 * because, at this point we can safely assume that
>> +		 * link recovery has happened.
>> +		 */
>> +		if ((severity == DPC_FATAL) &&
>> +			(cb == report_resume)) {
>> +			cb(dev, NULL);
>> +			return PCI_ERS_RESULT_RECOVERED;
>> +		}
>>  		/*
>>  		 * If the error is reported by a bridge, we think this error
>>  		 * is related to the downstream link of the bridge, so we
> 
> thanks,

Thanks for the comments,
All your comments are taken care in v10, though I will post v11.

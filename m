Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753433AbeARGEM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jan 2018 01:04:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 18 Jan 2018 11:34:11 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v5 3/4] PCI/DPC: Unify and plumb error handling into DPC
In-Reply-To: <d78da5a5465c7a1696db755385393519@codeaurora.org>
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
 <1516185438-31556-4-git-send-email-poza@codeaurora.org>
 <298df660-1f7d-85ab-51db-11dc5d80cc75@codeaurora.org>
 <d78da5a5465c7a1696db755385393519@codeaurora.org>
Message-ID: <4a68efd464e5debe81db8f7b4ddccc8f@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-18 10:52, poza@codeaurora.org wrote:
> On 2018-01-17 22:15, Sinan Kaya wrote:
>> On 1/17/2018 5:37 AM, Oza Pawandeep wrote:
>>> +		driver = pci_find_dpc_service(udev);
>>> +#endif
>>>  #if IS_ENABLED(CONFIG_PCIEAER)
>>> -	/* Use the aer driver of the component firstly */
>>> -	driver = pci_find_aer_service(udev);
>> 
>> I think we need a pci_find_service function that unifies these two.
> 
> Right now, find_xxx_service are in their respective file and exporting 
> it.
> which makes sense no less than having generic function.
> 
> If I have to change pci_find_service(...., int service_name) then it
> has to be somewhere in generic file.
> probably portdrv_core.c
> 
> either way I am fine but just thinking out if its really required.
> 
> Regards,
> Oza.

Should I be doing in next patch-set series ?

Regards,
Oza.

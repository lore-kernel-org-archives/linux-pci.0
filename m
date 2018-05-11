Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51670 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEKPei (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 May 2018 11:34:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 11 May 2018 21:04:36 +0530
From: poza@codeaurora.org
To: Lukas Wunner <lukas@wunner.de>
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
Subject: Re: [PATCH v16 5/9] PCI/AER: Factor out error reporting from AER
In-Reply-To: <20180511125857.GA23225@wunner.de>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
 <1526035408-31328-6-git-send-email-poza@codeaurora.org>
 <20180511125857.GA23225@wunner.de>
Message-ID: <7317531a7a85404d590008a27131955f@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-11 18:28, Lukas Wunner wrote:
> On Fri, May 11, 2018 at 06:43:24AM -0400, Oza Pawandeep wrote:
>> +void pcie_do_fatal_recovery(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *udev;
>> +	struct pci_bus *parent;
>> +	struct pci_dev *pdev, *temp;
>> +	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
>> +	struct aer_broadcast_data result_data;
>> +
>> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
>> +		udev = dev;
>> +	else
>> +		udev = dev->bus->self;
>> +
>> +	parent = udev->subordinate;
>> +	pci_lock_rescan_remove();
>> +	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
>> +				 bus_list) {
>> +		pci_dev_get(pdev);
>> +		pci_dev_set_disconnected(pdev, NULL);
>> +		if (pci_has_subordinate(pdev))
>> +			pci_walk_bus(pdev->subordinate,
>> +				     pci_dev_set_disconnected, NULL);
>> +		pci_stop_and_remove_bus_device(pdev);
>> +		pci_dev_put(pdev);
>> +	}
> 
> Any reason not to simply call
> 
> 	pci_walk_bus(udev->subordinate, pci_dev_set_disconnected, NULL);
> 
> before the list_for_each_entry_safe_reverse() iteration, instead of
> calling it for each device on the subordinate bus and for each
> device's children?  Should be semantically identical, saves 3 LoC
> and saves wasted cycles of acquiring pci_bus_sem over and over again
> for each device on the subordinate bus.
> 
> Thanks,
> 
> Lukas

Well this is borrowed code from DPC driver, hence I thought to keep the 
same.
but to me it looks like its taking care of PCIe switch where is goes 
through all the subordinates, and which could turn out to be more 
swicthes down the line, and son on...
it goes all the way down to the tree
Am I missing something here ?

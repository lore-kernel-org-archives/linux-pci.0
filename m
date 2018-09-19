Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbeISWZo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 18:25:44 -0400
Subject: Re: [PATCHv3 10/10] PCI: Make link active reporting detection generic
From: Sinan Kaya <okaya@kernel.org>
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-11-keith.busch@intel.com>
 <f695a8f4-a359-389f-b27e-c1d998a50b0b@kernel.org>
Message-ID: <196cd477-ad06-a75b-a013-6c5c231419a3@kernel.org>
Date: Wed, 19 Sep 2018 12:46:58 -0400
MIME-Version: 1.0
In-Reply-To: <f695a8f4-a359-389f-b27e-c1d998a50b0b@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/19/2018 12:42 PM, Sinan Kaya wrote:
> On 9/18/2018 7:57 PM, Keith Busch wrote:
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -93,10 +93,12 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>>       pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>>                     PCI_EXP_DPC_STATUS_TRIGGER);
>> +    if (!pcie_wait_for_link(pdev, true))
>> +        return PCI_ERS_RESULT_DISCONNECT;
>> +
> 
> We are already doing this in err.c in pcie_do_fatal_recovery() as follows.
> 
>      result = reset_link(udev, service);
>      ...
>      if (result == PCI_ERS_RESULT_RECOVERED) {
>          if (pcie_wait_for_link(udev, true))
>              pci_rescan_bus(udev->bus);
>          pci_info(dev, "Device recovery from fatal error successful\n");
>      }
> 
> This would be an unnecessary duplication.
> 
> You may want to move this piece into err.c and change the return code to 
> PCI_ERS_RESULT_DISCONNECT
> right after return from reset_link().
> 
>>       return PCI_ERS_RESULT_RECOVERED;
>>   }
>> -
> 

Nevermind. I just realized that you unified error recovery handlers into
pcie_do_recovery().

Please disregard this comment.

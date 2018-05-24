Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:38148 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031263AbeEXRvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 13:51:06 -0400
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Doug Meyer <dmeyer@gigaio.com>
References: <20180524173913.4506-1-logang@deltatee.com>
 <b2481367-3acc-4d54-bae7-cc27fb38232e@infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2ab7b5f8-f068-026a-bc79-5c589dcdb07e@deltatee.com>
Date: Thu, 24 May 2018 11:51:03 -0600
MIME-Version: 1.0
In-Reply-To: <b2481367-3acc-4d54-bae7-cc27fb38232e@infradead.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2] PCI: Expand documentation for pci_add_dma_alias()
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 24/05/18 11:44 AM, Randy Dunlap wrote:
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index dbfe7c4f3776..1c0c1ea23b90 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5395,8 +5395,19 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>>   * @dev: the PCI device for which alias is added
>>   * @devfn: alias slot and function
>>   *
>> - * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
>> - * It should be called early, preferably as PCI fixup header quirk.
>> + * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
>> + * which is used to program permissible BDF source addresses for DMA
> 
> It took me a few seconds to decode BDF.  FWIW, I would prefer to see
> bus-devfn or bus-dev-fn or bus-dev-func or bus-dev-function.

Yes, there's a lot of overlapping terminology here. In circles I've
discussed this stuff, BDF is a common acronym. The kernel uses
Bus/Slot/Function in some places, but devfn is also common. In any case,
I like bus-devfn so I'll make these changes and send a v3 shortly.

Thanks,

Logan

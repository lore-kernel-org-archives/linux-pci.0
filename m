Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:47668 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754530AbeFVUvC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jun 2018 16:51:02 -0400
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180622194315.10475-1-logang@deltatee.com>
 <20180622194315.10475-2-logang@deltatee.com>
 <1222da4e-864c-5e27-b735-99fc53d1e367@infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <baccb879-0ddc-37e0-1d54-747beb47e6a8@deltatee.com>
Date: Fri, 22 Jun 2018 14:50:45 -0600
MIME-Version: 1.0
In-Reply-To: <1222da4e-864c-5e27-b735-99fc53d1e367@infradead.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 1/3] PCI: Make specifying PCI devices in kernel
 parameters reusable
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 22/06/18 02:05 PM, Randy Dunlap wrote:
> Hi,
> 
> On 06/22/2018 12:43 PM, Logan Gunthorpe wrote:
> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 97acba712e4e..cb999b2a9530 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -191,6 +191,92 @@ void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
>>  EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
>>  #endif
>>  
>> +/**
>> + * pci_dev_str_match - test if a string matches a device
>> + * @dev:    the PCI device to test
>> + * @p:      string to match the device against
>> + * @endptr: pointer to the string after the match
>> + *
>> + * Test if a string (typically from a kernel parameter) matches a
>> + * specified. The string may be of one of the following formats:
> 
> "matches a specified."  eh?

Shoot, must have been over edited. Will fix for v5.

Logan

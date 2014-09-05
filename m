Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:54319 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564AbaIEAP7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 20:15:59 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 5 Sep 2014 10:15:57 +1000
Date: Fri, 5 Sep 2014 10:15:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org,
	alex.williamson@redhat.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Export MSI message relevant functions
Message-ID: <20140905001555.GA9963@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400468470-11262-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20140904225736.GJ17125@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140904225736.GJ17125@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 04, 2014 at 04:57:36PM -0600, Bjorn Helgaas wrote:
>On Mon, May 19, 2014 at 01:01:07PM +1000, Gavin Shan wrote:
>> The patch exports 2 MSI message relevant functions, which will be
>> used by VFIO PCI driver. The VFIO PCI driver would be built as
>> a module.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
>I think Alex will merge this along with the other ones.  Sorry this
>took so long.  I don't really like this, but I just can't figure out
>any solution that's better.
>

Thanks, Bjorn. I thought you must forget this. Lets get it in firstly
and I'll do more investigation later to see if I can figure out something
better.

Thanks,
Gavin

>> ---
>>  drivers/pci/msi.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 955ab79..2350271 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -324,6 +324,7 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
>>  
>>  	__get_cached_msi_msg(entry, msg);
>>  }
>> +EXPORT_SYMBOL_GPL(get_cached_msi_msg);
>>  
>>  void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>>  {
>> @@ -368,6 +369,7 @@ void write_msi_msg(unsigned int irq, struct msi_msg *msg)
>>  
>>  	__write_msi_msg(entry, msg);
>>  }
>> +EXPORT_SYMBOL_GPL(write_msi_msg);
>>  
>>  static void free_msi_irqs(struct pci_dev *dev)
>>  {
>> -- 
>> 1.8.3.2
>> 
>


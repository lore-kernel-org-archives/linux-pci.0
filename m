Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:39713 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbFCBty (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2015 21:49:54 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 3 Jun 2015 11:49:51 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 805312BB0054
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2015 11:49:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t531mPA159965470
	for <linux-pci@vger.kernel.org>; Wed, 3 Jun 2015 11:48:34 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t531m0Qj006352
	for <linux-pci@vger.kernel.org>; Wed, 3 Jun 2015 11:48:01 +1000
Date: Wed, 3 Jun 2015 09:47:42 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 04/10] powerpc/eeh: Trace first 7 BARs in address cache
Message-ID: <20150603014742.GC7387@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150601233233.GE3631@google.com>
 <20150602035115.GB6785@richard>
 <20150602041124.GA19672@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150602041124.GA19672@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 02, 2015 at 02:11:24PM +1000, Gavin Shan wrote:
>On Tue, Jun 02, 2015 at 11:51:15AM +0800, Wei Yang wrote:
>>On Mon, Jun 01, 2015 at 06:32:33PM -0500, Bjorn Helgaas wrote:
>>>The subject says "Trace first 7 BARs..."  I think maybe you meant "Track
>>>first 7 BARs" or maybe "Cache only BARs, not windows or IOV BARs"
>>>
>>
>>Agree, Track is more accurate.
>>
>>Gavin,
>>
>>Which subject you prefer?
>>
>
>"Cache only BARs, not windows or IOV BARs" is better.
>
>>>On Tue, May 19, 2015 at 06:50:06PM +0800, Wei Yang wrote:
>>>> EEH address cache, which helps to locate the PCI device according to
>>>> the given (physical) MMIO address, didn't cover PCI bridges. 
>>>
>>>"doesn't contain PCI bridge windows"?
>>>
>>>I see that eeh_addr_cache_insert_dev() ignores bridges because it never
>>>calls __eeh_addr_cache_insert_dev() when "(dev->class >> 16) ==
>>>PCI_BASE_CLASS_BRIDGE".  I think it would be more technically correct if
>>>you removed that test and relied on the "i <= PCI_ROM_RESOURCE" test in
>>>this patch, because it is legal (though rare) for bridge devices to have
>>>two BARs, and I assume you would want to put those in your cache if they
>>>exist.
>>>
>>
>>I think this is fine to remove the test "(dev->class >> 16) ==
>>PCI_BASE_CLASS_BRIDGE" for a bridge and rely on the "i <= PCI_ROM_RESOURCE"
>>
>>Gavin,
>>
>>Do you thinks this is fine?
>>
>
>Fine to me.

Thanks, I will change accordingly and do some tests.

>
>>>> Also, it
>>>> shouldn't return PF with address in PF's IOV BARs. Instead, the VFs
>>>> should be returned.
>>>> The patch restricts the address cache to cover first 7 BARs for the
>>>> above purposes.
>>>> 
>>>> [gwshan: changelog]
>>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>> ---
>>>>  arch/powerpc/kernel/eeh_cache.c |    2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>> 
>>>> diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
>>>> index eeabeab..f6c5f05 100644
>>>> --- a/arch/powerpc/kernel/eeh_cache.c
>>>> +++ b/arch/powerpc/kernel/eeh_cache.c
>>>> @@ -196,7 +196,7 @@ static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
>>>>  	}
>>>>  
>>>>  	/* Walk resources on this device, poke them into the tree */
>>>> -	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>>>> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>>>>  		unsigned long start = pci_resource_start(dev,i);
>>>>  		unsigned long end = pci_resource_end(dev,i);
>>>>  		unsigned int flags = pci_resource_flags(dev,i);
>>>> -- 
>>>> 1.7.9.5
>>>> 
>>
>>-- 
>>Richard Yang
>>Help you, Help me

-- 
Richard Yang
Help you, Help me


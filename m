Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:36320 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab3KHBfp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2013 20:35:45 -0500
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 8 Nov 2013 11:35:42 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9303A2BB0055
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2013 12:35:39 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rA81ZRnQ65536012
	for <linux-pci@vger.kernel.org>; Fri, 8 Nov 2013 12:35:27 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rA81ZcsB011998
	for <linux-pci@vger.kernel.org>; Fri, 8 Nov 2013 12:35:39 +1100
Date: Fri, 8 Nov 2013 09:35:37 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Nishank Trivedi <nistrive@cisco.com>
Subject: Re: [PATCH] PCI: Use pci_is_root_bus() to check for root bus
Message-ID: <20131108013537.GA15600@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20131105232903.3790.8738.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAE9FiQX74B32iD2LAaWxwOAH62YAFWkt2=hK9pVDCDUnfrEaNw@mail.gmail.com>
 <20131106181558.GA14444@google.com>
 <20131107030054.GA11245@weiyang.vnet.ibm.com>
 <20131107215918.GC2955@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131107215918.GC2955@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 07, 2013 at 02:59:18PM -0700, Bjorn Helgaas wrote:
>On Thu, Nov 07, 2013 at 11:00:54AM +0800, Wei Yang wrote:
>> Thanks Bjorn, this is really a potential problme. And your patches fix this
>> problem.
>> 
>> While I did a small change on the seconde one like this. Hope you like it :-)
>> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index bdd64b1..8d0ce48 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1153,7 +1153,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
>>         if (!dev)
>>                 return;
>>  
>> -       pci_enable_bridge(dev->bus->self);
>> +       pci_enable_bridge(pci_upstream_bridge(dev));
>>  
>>         if (pci_is_enabled(dev)) {
>>                 if (!dev->is_busmaster) {
>> @@ -1190,7 +1190,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>>         if (atomic_inc_return(&dev->enable_cnt) > 1)
>>                 return 0;               /* already enabled */
>>  
>> -       pci_enable_bridge(dev->bus->self);
>> +       pci_enable_bridge(pci_upstream_bridge(dev));
>>  
>>         /* only skip sriov related */
>>         for (i = 0; i <= PCI_ROM_RESOURCE; i++)
>
>Thanks for looking at these.  I think the latest version (the ones
>acked by Yinghai) do basically what you're suggesting.

Agree :-)

>
>> BTW, pci_enable_bridge() is only called in pci_enable_device_flags(). After
>> change in these two patches, we pass a 'upstream bridge' to
>> pci_enable_bridge(). I am not sure whether this 'upstream bridge' could be a
>> VF? I took a look at the SPEC again, but not find clear clause.
>> 
>> In case the 'upstream bridge' is always a PF, maybe we could simplize the
>> logic in pci_enable_bridge(). While current logic is reasonable and clear.
>
>I doubt it's possible for a VF to be a bridge, but I don't think
>there's really any reason to build that assumption into the code
>here.

Yep, the latest version is more general.

>
>Bjorn

-- 
Richard Yang
Help you, Help me


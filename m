Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:47353 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbCBHfk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2015 02:35:40 -0500
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 2 Mar 2015 17:35:38 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0C1692CE804E
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2015 18:35:36 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t227ZRe946858244
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2015 18:35:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t227Z1kk004624
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2015 18:35:02 +1100
Date: Mon, 2 Mar 2015 15:34:45 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	gwshan@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v12 11/21] powerpc/pci: Don't unset PCI resources for VFs
Message-ID: <20150302073445.GF21571@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083413.32124.11968.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224084450.GH6220@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150224084450.GH6220@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 24, 2015 at 02:44:50AM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 24, 2015 at 02:34:13AM -0600, Bjorn Helgaas wrote:
>> From: Wei Yang <weiyang@linux.vnet.ibm.com>
>> 
>> If we're going to reassign resources with flag PCI_REASSIGN_ALL_RSRC, all
>> resources will be cleaned out during device header fixup time and then get
>> reassigned by PCI core.  However, the VF resources won't be reassigned and
>> thus, we shouldn't clean them out.
>> 
>> If the pci_dev is a VF, skip the resource unset process.
>
>I think this patch is correct, but we should include a little more detail
>in the changelog to answer questions like mine and Ben's
>(http://lkml.kernel.org/r/1423528584.4924.70.camel@au1.ibm.com).
>

Ok, I will add more change log to explain this.

>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  arch/powerpc/kernel/pci-common.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index 2a525c938158..82031011522f 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -788,6 +788,10 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
>>  		       pci_name(dev));
>>  		return;
>>  	}
>> +
>> +	if (dev->is_virtfn)
>> +		return;
>> +
>>  	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>>  		struct resource *res = dev->resource + i;
>>  		struct pci_bus_region reg;
>> 

-- 
Richard Yang
Help you, Help me


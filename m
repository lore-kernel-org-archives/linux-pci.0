Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:51231 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933190AbbBJBwT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 20:52:19 -0500
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 10 Feb 2015 11:52:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8907E3578053
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 12:52:13 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1A1q5D845350992
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 12:52:13 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1A1pd1Y008158
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 12:51:40 +1100
Date: Tue, 10 Feb 2015 09:51:23 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, bhelgaas@google.com,
	gwshan@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V11 07/17] powerpc/pci: Don't unset pci resources for VFs
Message-ID: <20150210015123.GC6326@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-8-git-send-email-weiyang@linux.vnet.ibm.com>
 <1423528584.4924.70.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423528584.4924.70.camel@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 10, 2015 at 11:36:24AM +1100, Benjamin Herrenschmidt wrote:
>On Thu, 2015-01-15 at 10:27 +0800, Wei Yang wrote:
>> If we're going to reassign resources with flag PCI_REASSIGN_ALL_RSRC, all
>> resources will be cleaned out during device header fixup time and then get
>> reassigned by PCI core. However, the VF resources won't be reassigned and
>> thus, we shouldn't clean them out.
>> 
>> This patch adds a condition. If the pci_dev is a VF, skip the resource
>> unset process.
>
>I don't understand this, can you elaborate ? Why wouldn't we reassign
>the IOV resource just like everything else ?

Sure.

VFs work a little bit different from normal devices. On powernv platform, we
have PCI_REASSIGN_ALL_RSRC set, which means all resource retrieved from
hardware will be cleaned and re-assigned by kernel. While VF's resources are
calculated from PF's IOV BAR, in virtfn_add(). And after this, there is not
re-assign process for VFs.

>
>Ben.
>
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/pci-common.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index 37d512d..889f743 100644
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
>

-- 
Richard Yang
Help you, Help me


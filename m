Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:38250 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbGOBjK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 21:39:10 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 15 Jul 2015 11:39:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id CF03B2BB0040
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 11:39:05 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6F1cvkN48365690
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 11:39:05 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6F1cW0W019789
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 11:38:32 +1000
Date: Wed, 15 Jul 2015 09:38:15 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Don't update VF's BAR
Message-ID: <20150715013815.GA6525@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1435649834-3148-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150714221511.GM24416@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150714221511.GM24416@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 14, 2015 at 05:15:11PM -0500, Bjorn Helgaas wrote:
>On Tue, Jun 30, 2015 at 03:37:14PM +0800, Wei Yang wrote:
>> VF BARs are RO zero, so updating VF BARs will not take any effect.
>> See the SR-IOV spec r1.1, sec 3.4.1.11.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/setup-res.c |    7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index 232f925..334b394 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -37,6 +37,13 @@ void pci_update_resource(struct pci_dev *dev, int resno)
>>  	struct resource *res = dev->resource + resno;
>>  
>>  	/*
>> +	 * Per SRIOV SPEC 3.4.1.11, VF BARs are RO zero.
>> +	 * If this is a VF, just return.
>> +	 */
>> +	if (dev->is_virtfn)
>> +		return;
>
>Does this fix a problem?  Are you seeing the "BAR %d: error updating"
>message?
>

Yes, I see the "error updating" message when doing vfio pass through.

>I wouldn't think we would even call pci_update_resource() for VFs, except
>for pci_restore_bars().  Maybe we should check there?
>

This happens after commit <6eb7018705de> ("vfio-pci: Move idle devices to 
D3hot power state"). When do vfio, it will set the power state, and which in
turn update the BAR.

Hmm... yes, maybe the pci_restore_bars() is a good place to check.

>If the PCI core is assigning space directly to VF BARs and trying to update
>them, I'd like to know about that rather than silently ignoring it.
>

Ok, so I would add a warning at this place.

>> +
>> +	/*
>>  	 * Ignore resources for unimplemented BARs and unused resource slots
>>  	 * for 64 bit BARs.
>>  	 */
>> -- 
>> 1.7.9.5
>> 

-- 
Richard Yang
Help you, Help me


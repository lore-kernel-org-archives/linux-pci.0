Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:49791 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaHAEkc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Aug 2014 00:40:32 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 1 Aug 2014 14:40:30 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id EA48A2BB0023
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2014 14:40:26 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay06.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s714esBN12779636
	for <linux-pci@vger.kernel.org>; Fri, 1 Aug 2014 14:40:54 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s714eQPe011507
	for <linux-pci@vger.kernel.org>; Fri, 1 Aug 2014 14:40:26 +1000
Date: Fri, 1 Aug 2014 14:40:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Mark broken INTx masking for Mellanox devices
Message-ID: <20140801044021.GA30733@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1406865063-24775-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1406865990.2963.167.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406865990.2963.167.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 31, 2014 at 10:06:30PM -0600, Alex Williamson wrote:
>On Fri, 2014-08-01 at 13:51 +1000, Gavin Shan wrote:
>> The VFIO driver is routing LSI interrupts by capturing, masking,
>> and then delivering. When passing though Mallanox adapters from
>> host to guest, interrupt storm was reported from host and guest.
>> That's because we can't mask the LSI interrupt with help of PCI
>> command register.
>> 
>> The patch marks broken INTx masking for Mellanox devices so that
>> the VFIO driver will always mask the interrupt from interrupt
>> controller side to avoid interrupt storm.
>> 
>> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/quirks.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index d0f6926..8c2b96f 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2977,6 +2977,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, 0x0030,
>>  			 quirk_broken_intx_masking);
>>  DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
>>  			 quirk_broken_intx_masking);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0x1003,
>> +			 quirk_broken_intx_masking);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0x6750,
>> +			 quirk_broken_intx_masking);
>>  /*
>>   * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
>>   * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC
>
>Is there an lspci description for the devices that we can also include?
>You might also want to cc the driver maintainers to see if they're aware
>or have any comments.  Thanks,
>

Yes, I'll include that in next revision and cc driver's maintainer.

Thanks,
Gavin


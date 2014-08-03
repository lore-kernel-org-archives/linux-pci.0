Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:37928 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbaHCIU5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Aug 2014 04:20:57 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Sun, 3 Aug 2014 18:20:55 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 487BC2BB002D
	for <linux-pci@vger.kernel.org>; Sun,  3 Aug 2014 18:20:53 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay06.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s738LNiN11206774
	for <linux-pci@vger.kernel.org>; Sun, 3 Aug 2014 18:21:23 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s738KqTV000790
	for <linux-pci@vger.kernel.org>; Sun, 3 Aug 2014 18:20:52 +1000
Date: Sun, 3 Aug 2014 18:20:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Amir Vadai <amirv@mellanox.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	alex.williamson@redhat.com,
	Yevgeny Petrilin <yevgenyp@mellanox.com>,
	Peter Paneah <peter@mellanox.com>, Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
Message-ID: <20140803082046.GA8962@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53DDE9EC.5040303@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53DDE9EC.5040303@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 03, 2014 at 10:51:08AM +0300, Amir Vadai wrote:
>On 8/1/2014 7:54 AM, Gavin Shan wrote:
>> The VFIO driver is routing LSI interrupts by capturing, masking,
>> and then delivering. When passing though Mallanox adapters from
>> host to guest, interrupt storm was reported from host and guest.
>> That's because we can't mask the LSI interrupt with help of PCI
>> command register.
>Hi Gavin,
>
>What is the problem with masking the interrupts with the PCI command
>register? I'm asking because I want to understand in which devices we
>have the problem, and if it could be fixed by firmware guys.
>What are the implications of having the quirk?
>

The way to mask the interrupt through PCI command register isn't
taking effect on IBM power platform. So we have to have the quirk
so that the interrupt could be masked from interrupt controller
side with function disable_irq_nosync().

If the interrupt can't be masked properly, we detect interrupt
storm reported from host/guest when passing through those devices
via VFIO without suprise.

>> 
>> [root@ncc-1701 ~]# lspci | grep Mellanox
>> 0001:05:00.0 Ethernet controller: Mellanox Technologies MT27500 \
>>              Family [ConnectX-3]
>> 0005:01:00.0 Ethernet controller: Mellanox Technologies MT26448 \
>>              [ConnectX EN 10GigE, PCIe 2.0 5GT/s] (rev b0)
>> 
>> The patch marks broken INTx masking for Mellanox devices so that
>> the VFIO driver will always mask the interrupt from interrupt
>> controller side to avoid interrupt storm.
>> 
>> Cc: Amir Vadai <amirv@mellanox.com>
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
>I still don't understand what exactly is the problem, but I assume that
>there are other Mellanox devices that suffer from it.
>

Yeah, that's possible. I didn't have chance to test other Mellanox
devices except the above two.

>>  /*
>>   * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
>>   * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC
>> 
>
>Thanks,
>Amir
>

Thanks,
Gavin


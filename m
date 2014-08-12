Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:43627 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbaHLDwk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Aug 2014 23:52:40 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 12 Aug 2014 13:52:38 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 691032BB0047
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 13:52:36 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s7C3TF9I1180130
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 13:29:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s7C3qUTC001748
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 13:52:30 +1000
Date: Tue, 12 Aug 2014 13:52:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	amirv@mellanox.com, alex.williamson@redhat.com
Subject: Re: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
Message-ID: <20140812035226.GA15421@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20140811134854.GA5794@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140811134854.GA5794@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 11, 2014 at 09:48:54PM +0800, Wei Yang wrote:
>On Fri, Aug 01, 2014 at 02:54:31PM +1000, Gavin Shan wrote:
>>The VFIO driver is routing LSI interrupts by capturing, masking,
>>and then delivering. When passing though Mallanox adapters from
>
>one typo                                  Mellanox
>
>Others, looks good to me.
>

Thanks, Richard. I'll correct it in next revision. However, I'm
still waiting for comments or ACK from Alex/Eli/Amir.

Thanks,
Gavin

>>host to guest, interrupt storm was reported from host and guest.
>>That's because we can't mask the LSI interrupt with help of PCI
>>command register.
>>
>>[root@ncc-1701 ~]# lspci | grep Mellanox
>>0001:05:00.0 Ethernet controller: Mellanox Technologies MT27500 \
>>             Family [ConnectX-3]
>>0005:01:00.0 Ethernet controller: Mellanox Technologies MT26448 \
>>             [ConnectX EN 10GigE, PCIe 2.0 5GT/s] (rev b0)
>>
>>The patch marks broken INTx masking for Mellanox devices so that
>>the VFIO driver will always mask the interrupt from interrupt
>>controller side to avoid interrupt storm.
>>
>>Cc: Amir Vadai <amirv@mellanox.com>
>>Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>> drivers/pci/quirks.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>index d0f6926..8c2b96f 100644
>>--- a/drivers/pci/quirks.c
>>+++ b/drivers/pci/quirks.c
>>@@ -2977,6 +2977,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, 0x0030,
>> 			 quirk_broken_intx_masking);
>> DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
>> 			 quirk_broken_intx_masking);
>>+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0x1003,
>>+			 quirk_broken_intx_masking);
>>+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0x6750,
>>+			 quirk_broken_intx_masking);
>> /*
>>  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
>>  * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC
>>-- 
>>1.8.3.2
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>-- 
>Richard Yang
>Help you, Help me


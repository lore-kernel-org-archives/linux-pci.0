Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:34465 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbaHKNtE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Aug 2014 09:49:04 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 11 Aug 2014 19:19:01 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 47CC93940017
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2014 19:18:58 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s7BDnJZk61800628
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2014 19:19:20 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s7BDmvcu032423
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2014 19:18:57 +0530
Date: Mon, 11 Aug 2014 21:48:54 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, amirv@mellanox.com,
	alex.williamson@redhat.com
Subject: Re: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
Message-ID: <20140811134854.GA5794@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 01, 2014 at 02:54:31PM +1000, Gavin Shan wrote:
>The VFIO driver is routing LSI interrupts by capturing, masking,
>and then delivering. When passing though Mallanox adapters from

one typo                                  Mellanox

Others, looks good to me.

>host to guest, interrupt storm was reported from host and guest.
>That's because we can't mask the LSI interrupt with help of PCI
>command register.
>
>[root@ncc-1701 ~]# lspci | grep Mellanox
>0001:05:00.0 Ethernet controller: Mellanox Technologies MT27500 \
>             Family [ConnectX-3]
>0005:01:00.0 Ethernet controller: Mellanox Technologies MT26448 \
>             [ConnectX EN 10GigE, PCIe 2.0 5GT/s] (rev b0)
>
>The patch marks broken INTx masking for Mellanox devices so that
>the VFIO driver will always mask the interrupt from interrupt
>controller side to avoid interrupt storm.
>
>Cc: Amir Vadai <amirv@mellanox.com>
>Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---
> drivers/pci/quirks.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>index d0f6926..8c2b96f 100644
>--- a/drivers/pci/quirks.c
>+++ b/drivers/pci/quirks.c
>@@ -2977,6 +2977,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, 0x0030,
> 			 quirk_broken_intx_masking);
> DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
> 			 quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0x1003,
>+			 quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0x6750,
>+			 quirk_broken_intx_masking);
> /*
>  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
>  * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC
>-- 
>1.8.3.2
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me


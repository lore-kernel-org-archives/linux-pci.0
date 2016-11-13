Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53819 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752814AbcKMX0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2016 18:26:20 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uADNNOF6095768
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2016 18:26:19 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26ppvqxm8s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2016 18:26:19 -0500
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Mon, 14 Nov 2016 09:26:16 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
        by d23dlp01.au.ibm.com (Postfix) with ESMTP id 14AE62CE8054
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 10:26:15 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id uADNQF5H63373506
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 10:26:15 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
        by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id uADNQEBc016741
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 10:26:14 +1100
Date: Mon, 14 Nov 2016 10:27:24 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Noa Osherovich <noaos@mellanox.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        gwshan@linux.vnet.ibm.com, majd@mellanox.com
Subject: Re: [PATCH 1/4] PCI: Use FINAL fixup to mark broken INTx masking
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1479046901-25360-1-git-send-email-noaos@mellanox.com>
 <1479046901-25360-2-git-send-email-noaos@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479046901-25360-2-git-send-email-noaos@mellanox.com>
Message-Id: <20161113232724.GB12678@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 13, 2016 at 04:21:39PM +0200, Noa Osherovich wrote:
>Convert all quirk_broken_intx_masking quirks from HEADER to FINAL.
>None of those calls need to be in HEADER but some might need to be
>called as FINAL. Moving them all to FINAL will save time during
>pci_do_fixups.
>
>Signed-off-by: Noa Osherovich <noaos@mellanox.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> drivers/pci/quirks.c | 72 ++++++++++++++++++++++++++--------------------------
> 1 file changed, 36 insertions(+), 36 deletions(-)
>
>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>index c232729f5b1b..85048fdf2474 100644
>--- a/drivers/pci/quirks.c
>+++ b/drivers/pci/quirks.c
>@@ -3146,53 +3146,53 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
> {
> 	dev->broken_intx_masking = 1;
> }
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, 0x0030,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
>-			 quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x0030,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
>+			quirk_broken_intx_masking);
> /*
>  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
>  * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC
>  *
>  * RTL8110SC - Fails under PCI device assignment using DisINTx masking.
>  */
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
>-			 quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8169,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
>+			quirk_broken_intx_masking);
>
> /*
>  * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
>  * DisINTx can be set but the interrupt status bit is non-functional.
>  */
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1572,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1574,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1580,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1581,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1583,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1584,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1585,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1586,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1587,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1588,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1589,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d0,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d1,
>-			 quirk_broken_intx_masking);
>-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d2,
>-			 quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1572,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1574,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1580,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1581,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1583,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1584,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1585,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1586,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1587,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1588,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1589,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d0,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d1,
>+			quirk_broken_intx_masking);
>+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d2,
>+			quirk_broken_intx_masking);
>

There could be one follow-up patch to combine those intel's
quirks to one, so that more time can be saved. We don't have
to cover it in this patchset though.

> static void quirk_no_bus_reset(struct pci_dev *dev)
> {

Thanks,
Gavin


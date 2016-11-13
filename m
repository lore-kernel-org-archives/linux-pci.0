Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35607 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935190AbcKMXiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2016 18:38:20 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uADNXxqA110451
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2016 18:38:20 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26ppvqxy30-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2016 18:38:19 -0500
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Mon, 14 Nov 2016 09:38:17 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
        by d23dlp02.au.ibm.com (Postfix) with ESMTP id 973FD2BB0055
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 10:38:14 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id uADNcEgs7668060
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 10:38:14 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
        by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id uADNcENx003014
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 10:38:14 +1100
Date: Mon, 14 Nov 2016 10:39:24 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Noa Osherovich <noaos@mellanox.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        gwshan@linux.vnet.ibm.com, majd@mellanox.com
Subject: Re: [PATCH 2/4] PCI: Convert Mellanox quirks to be for listed
 devices only
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1479046901-25360-1-git-send-email-noaos@mellanox.com>
 <1479046901-25360-3-git-send-email-noaos@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479046901-25360-3-git-send-email-noaos@mellanox.com>
Message-Id: <20161113233924.GA14481@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 13, 2016 at 04:21:40PM +0200, Noa Osherovich wrote:
>Change Mellanox's broken_intx_masking quirk from an "all Mellanox
>devices" to a quirk for listed devices only.
>
>Signed-off-by: Noa Osherovich <noaos@mellanox.com>
>Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> drivers/pci/quirks.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 52 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>index 85048fdf2474..d3977c847e1f 100644
>--- a/drivers/pci/quirks.c
>+++ b/drivers/pci/quirks.c
>@@ -3158,8 +3158,59 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
>  */
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8169,
> 			quirk_broken_intx_masking);
>+
>+#define PCI_DEVICE_ID_MELLANOX_HERMON_SDR 0x6340
>+#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR 0x634a
>+#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR 0x6354
>+#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2 0x6732
>+#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2 0x673c
>+#define PCI_DEVICE_ID_MELLANOX_HERMON_EN 0x6368
>+#define PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2 0x6750
>+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN 0x6372
>+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2 0x675a
>+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2 0x6764
>+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2 0x6746
>+#define PCI_DEVICE_ID_MELLANOX_CONNECTX2 0x676e
>+#define PCI_DEVICE_ID_MELLANOX_CONNECTX3 0x1003
>+#define PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO 0x1007
>+#define PCI_DEVICE_ID_MELLANOX_CONNECTIB 0x1011
>+#define PCI_DEVICE_ID_MELLANOX_CONNECTX4 0x1013
>+#define PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX 0x1015
>+
>+static u16 mellanox_broken_intx_devs[] = {
>+	PCI_DEVICE_ID_MELLANOX_HERMON_SDR,
>+	PCI_DEVICE_ID_MELLANOX_HERMON_DDR,
>+	PCI_DEVICE_ID_MELLANOX_HERMON_QDR,
>+	PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2,
>+	PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2,
>+	PCI_DEVICE_ID_MELLANOX_HERMON_EN,
>+	PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2,
>+	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN,
>+	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2,
>+	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2,
>+	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2,
>+	PCI_DEVICE_ID_MELLANOX_CONNECTX2,
>+	PCI_DEVICE_ID_MELLANOX_CONNECTX3,
>+	PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO,
>+	PCI_DEVICE_ID_MELLANOX_CONNECTIB,
>+	PCI_DEVICE_ID_MELLANOX_CONNECTX4,
>+	PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX
>+};
>+
>+static void mellanox_check_broken_intx_masking(struct pci_dev *dev)
>+{
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(mellanox_broken_intx_devs); i++) {
>+		if (dev->device == mellanox_broken_intx_devs[i]) {
>+			dev->broken_intx_masking = 1;
>+			return;
>+		}
>+	}
>+}
>+

@dev might be replaced with @pdev. Usually, @dev means "struct device"
instance while @pdev represents "struct pci_dev" instance. The older
PCI code seems using them interchangeably.

> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
>-			quirk_broken_intx_masking);
>+			mellanox_check_broken_intx_masking);
>
> /*
>  * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,

Thanks,
Gavin


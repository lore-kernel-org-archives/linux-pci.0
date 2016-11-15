Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33533 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752194AbcKOWlZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2016 17:41:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAFMcpXX089792
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2016 17:41:24 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26r9rwbfd8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2016 17:41:24 -0500
Received: from localhost
        by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Wed, 16 Nov 2016 08:41:21 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
        by d23dlp01.au.ibm.com (Postfix) with ESMTP id 436372CE8046
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 09:41:20 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id uAFMfKRl30343228
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 09:41:20 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id uAFMfJUA022580
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 09:41:19 +1100
Date: Wed, 16 Nov 2016 09:42:30 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Noa Osherovich <noaos@mellanox.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, majd@mellanox.com,
        gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v1 3/3] PCI: Add checks to
 mellanox_check_broken_intx_masking
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1479196800-32191-1-git-send-email-noaos@mellanox.com>
 <1479196800-32191-4-git-send-email-noaos@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479196800-32191-4-git-send-email-noaos@mellanox.com>
Message-Id: <20161115224230.GA8355@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 15, 2016 at 10:00:00AM +0200, Noa Osherovich wrote:
>Mellanox devices were marked as having INTx masking ability broken.
>As a result, the VFIO driver fails to start when more than one device
>function is passed-through to a VM if both have the same INTx pin.
>
>Prior to Connect-IB, Mellanox devices exposed to the operating system
>one PCI function per all ports.
>Starting from Connect-IB, the devices are function-per-port. When
>passing the second function to a VM, VFIO will fail to start.
>
>Exclude ConnectX-4, ConnectX4-Lx and Connect-IB from the list of
>Mellanox devices marked as having broken INTx masking:
>
>- ConnectX-4 and ConnectX4-LX firmware version is checked. If INTx
>  masking is supported, we unmark the broken INTx masking.
>- Connect-IB does not support INTx currently so will not cause any
>  problem.
>
>Fixes: 11e42532ada31 ('PCI: Assume all Mellanox devices have ...')
>Signed-off-by: Noa Osherovich <noaos@mellanox.com>
>Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---
> drivers/pci/quirks.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 55 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>index 228a4e8a8aeb..112a5fcad2f5 100644
>--- a/drivers/pci/quirks.c
>+++ b/drivers/pci/quirks.c
>@@ -3192,13 +3192,25 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
> 	PCI_DEVICE_ID_MELLANOX_CONNECTX2,
> 	PCI_DEVICE_ID_MELLANOX_CONNECTX3,
> 	PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO,
>-	PCI_DEVICE_ID_MELLANOX_CONNECTIB,
>-	PCI_DEVICE_ID_MELLANOX_CONNECTX4,
>-	PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX
> };
>
>+#define CONNECTX_4_CURR_MAX_MINOR 99
>+#define CONNECTX_4_INTX_SUPPORT_MINOR 14
>+
>+/*
>+ * Checking ConnectX-4/LX FW version to see if it supports legacy interrupts.
>+ * If so, don't mark it as broken.
>+ * FW minor > 99 means older FW version format and no INTx masking support.
>+ * FW minor < 14 means new FW version format and no INTx masking support.
>+ */
> static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
> {
>+	__be32 __iomem *fw_ver;
>+	u16 fw_major;
>+	u16 fw_minor;
>+	u16 fw_subminor;
>+	u32 fw_maj_min;
>+	u32 fw_sub_min;
> 	int i;
>
> 	for (i = 0; i < ARRAY_SIZE(mellanox_broken_intx_devs); i++) {
>@@ -3207,6 +3219,46 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
> 			return;
> 		}
> 	}
>+
>+	/* Getting here means Connect-IB cards and up. Connect-IB has no INTx
>+	 * support so shouldn't be checked further
>+	 */
>+	if (pdev->device == PCI_DEVICE_ID_MELLANOX_CONNECTIB)
>+		return;
>+
>+	if (pdev->device != PCI_DEVICE_ID_MELLANOX_CONNECTX4 &&
>+	    pdev->device != PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX)
>+		return;
>+
>+	/* For ConnectX-4 and ConnectX-4LX, need to check FW support */
>+	if (pci_enable_device_mem(pdev)) {
>+		dev_warn(&pdev->dev, "Can't enable device memory\n");
>+		return;
>+	}
>+
>+	/* Convert from PCI bus to resource space. */
>+	fw_ver = ioremap(pci_resource_start(pdev, 0), 4);
>+	if (!fw_ver) {
>+		dev_warn(&pdev->dev, "Can't map ConnectX-4 initialization segment\n");

pci_disable_device(pdev) is missed.

>+		return;
>+	}
>+
>+	/* Reading from resource space should be 32b aligned */
>+	fw_maj_min = ioread32be(fw_ver);
>+	fw_sub_min = ioread32be(fw_ver + 1);
>+	fw_major = fw_maj_min & 0xffff;
>+	fw_minor = fw_maj_min >> 16;
>+	fw_subminor = fw_sub_min & 0xffff;
>+	if (fw_minor > CONNECTX_4_CURR_MAX_MINOR ||
>+	    fw_minor < CONNECTX_4_INTX_SUPPORT_MINOR) {
>+		dev_warn(&pdev->dev, "ConnectX-4: FW %u.%u.%u doesn't support INTx masking, disabling. Please upgrade FW to %d.14.1100 and up for INTx support\n",
>+			 fw_major, fw_minor, fw_subminor, pdev->device ==
>+			 PCI_DEVICE_ID_MELLANOX_CONNECTX4 ? 12 : 14);
>+		pdev->broken_intx_masking = 1;
>+		pci_disable_device(pdev);

This pci_disable_device() should be called unconditionally
before iounmap();

>+	}
>+
>+	iounmap(fw_ver);
> }
>
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,

Thanks,
Gavin


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50775 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750890AbcKNAOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2016 19:14:32 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAE0EOfd009877
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2016 19:14:31 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26ptu97njf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2016 19:14:31 -0500
Received: from localhost
        by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Mon, 14 Nov 2016 10:14:28 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
        by d23dlp03.au.ibm.com (Postfix) with ESMTP id 19EC13578056
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 11:14:27 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id uAE0ERPQ5505392
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 11:14:27 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id uAE0EQPH000392
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 11:14:26 +1100
Date: Mon, 14 Nov 2016 11:15:35 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Noa Osherovich <noaos@mellanox.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        gwshan@linux.vnet.ibm.com, majd@mellanox.com
Subject: Re: [PATCH 3/4] PCI: Add checks to mellanox_check_broken_intx_masking
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1479046901-25360-1-git-send-email-noaos@mellanox.com>
 <1479046901-25360-4-git-send-email-noaos@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479046901-25360-4-git-send-email-noaos@mellanox.com>
Message-Id: <20161114001535.GB14481@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 13, 2016 at 04:21:41PM +0200, Noa Osherovich wrote:
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

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

With below comments addressed:

>---
> drivers/pci/quirks.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 55 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>index d3977c847e1f..cbd6776e70e6 100644
>--- a/drivers/pci/quirks.c
>+++ b/drivers/pci/quirks.c
>@@ -3192,21 +3192,70 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
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
> static void mellanox_check_broken_intx_masking(struct pci_dev *dev)
> {
>+	__be32 __iomem *fw_ver;
>+	u16 fw_major;
>+	u16 fw_minor;
>+	u16 fw_subminor;
>+	u32 fw_maj_min;
>+	u32 fw_sub_min;
> 	int i;
>
>+	dev->broken_intx_masking = 1;
>+
> 	for (i = 0; i < ARRAY_SIZE(mellanox_broken_intx_devs); i++) {
>-		if (dev->device == mellanox_broken_intx_devs[i]) {
>-			dev->broken_intx_masking = 1;
>+		if (dev->device == mellanox_broken_intx_devs[i])
> 			return;
>-		}
> 	}
>+
>+	/* Getting here means Connect-IB cards and up. Connect-IB has no INTx
>+	 * support so shouldn't be checked further
>+	 */
>+	if (dev->device == PCI_DEVICE_ID_MELLANOX_CONNECTIB) {
>+		dev->broken_intx_masking = 0;
>+		return;
>+	}
>+
>+	/* For ConnectX-4 and ConnectX-4LX, need to check FW support */
>+	if (pci_enable_device_mem(dev)) {
>+		dev_warn(&dev->dev, "Can't enable device memory\n");
>+		return;
>+	}

It might be safer to set @broken_intx_masking in the failing path. On the
following exit or failing path, the device needs to be disabled with function
pci_disable_device(). Otherwise, &dev->enable_cnt, tracking if the device is
enabled or not, will be unbalanced.

>+
>+	/* Convert from PCI bus to resource space. */
>+	fw_ver = ioremap(pci_resource_start(dev, 0), 4);
>+	if (!fw_ver) {
>+		dev_warn(&dev->dev, "Can't map ConnectX-4 initialization segment\n");
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
>+	    fw_minor < CONNECTX_4_INTX_SUPPORT_MINOR)
>+		dev_warn(&dev->dev, "ConnectX-4: FW %u.%u.%u doesn't support INTx masking, disabling. Please upgrade FW to %d.14.1100 and up for INTx support\n",
>+			 fw_major, fw_minor, fw_subminor, dev->device ==
>+			 PCI_DEVICE_ID_MELLANOX_CONNECTX4 ? 12 : 14);
>+	else
>+		dev->broken_intx_masking = 0;
>+
>+	iounmap(fw_ver);
> }

Noa, it doesn't look quite correct: when a device ID doesn't match with
anyone in the list, CONNECTIB, CONNECT4 or CONNECTX4_LX. The code goes
though as it's CONNECT4 or CONNECT4_LX. The firmware version retrieved
from MMIO register (BAR 0, offset 0/4) are checked. I don't think it's
assured that the registers are for firmware version on the device. It
seems you need more checks here: @broken_intx_masking is untouched and
kept as 0 by default when the device ID isn't in the intrest list, which
is the policy you introduced in PATCH[2/3]. Something like below would
work:

static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
{
     /*
      * Set @broken_intx_masking to 1 when device ID matches with
      * anyone in the list. No code change to PATCH[2/3] is needed.
      */
     if (pdev->device in mellanox_broken_intx_devs) {
         pdev->broken_intx_masking = 1;
         return;
     }

     if (dev->device == PCI_DEVICE_ID_MELLANOX_CONNECTIB)
         return;

     if (dev->device != PCI_DEVICE_ID_MELLANOX_CONNECTX4 &&
         dev->device != PCI_DEVICE_ID_MELLANOX_CONNECTX4_LE)
         return;

     /* Check firmware version on CONNECT4 or CONNECT4_LE */
}

>
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,

Thanks,
Gavin


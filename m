Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868D3955EF;
	Tue,  1 Sep 2026 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255291; cv=fail; b=JxI4c8pJLhKz755P5wyPAgWwQyU0xzY70CapTpyA9K47j9BlBe/x+vvudztEDd1nEUp3dYOdXCsX7ibhGtPxJMy4cVe9koj3WuvyvN6B3B/1H2WYYViatFa0kI1bBWH+kWkOtiJ7JOhohZYbki1y6Ksj91MyP/kLYF/fp4+eSs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255291; c=relaxed/simple;
	bh=lP9kP7DCdKujEUq/92dquV6AQq1zF82/IU9NMClYwf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLQZnSv9beB9AL51NywrxyngvzRH3XpQb28+WdNGXCxUyetx0El3BmlfI40JUf7I8XzJx+fQ8Dp1idiraT7297vLNJ6Yv0+VTWUVnMa+dqiH+MPw4PN88rSP0nDe/n6xVGVovp81e50m4PrC5wJGBPXlmnLOeTNwVTv3UFmtHig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jn0TSUOS; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jn0TSUOS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuyzUD9zImcPK9PYz7yHZDylLCfgnOsrQ4GGlthnqlqgPt3liSZgV3pKVkgQKkqHedyvhkFwdxCmRcN7qZGGdB0b3+OTludX0YQUUObj6bNCoZ0ciDSe0yVtmBscYj8WwcOSTFkzugJKidzForRQ7ccbGKCpseqSzcfqC5dSdOOK8ajQiEPqjedEzjaa8bvjNQ5TfOta/c3HVpNvi8hsrOxE/fbkq0JD/2f5sEmH7lltI/GJd/ztDLlLRtm7NtyqyKkFozJHwMA3rbEHKM9a9G2/izVDSvaCQ7+oeMI0++td/n0bnbvCriKiCOVwcZnzkddLWYUrdF1MTfHOapoJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd0srwENxB6+E1FwtIKPOG831nCxmcLFbgoM+joZ+O0=;
 b=WjyTR4YMiTd3M4UzLuChuMomv0U4hYOMrYVuG3Y479jVPrHOH6apxmjzMemk10essQ1cgFi2TMB9jY1DZmqmzJ7u9FQCsbpq3OnzBFKWp++DCO6yQIFNDDJ+Ot2XIqagIqeZ2lyO1gwqvTS9wrCUGiKh3lVu+lRnZkjk0k8IFNCd5Q4eXLM9tfAe4SrKuKPHLr/ZmSq7MzK2LBAi7GN+JgPfVLQrNRdRk2z/7pBbreFSE/yDDLsRsDQJkBmsJy36t+wGHZ17Gpo45/PL/doN7hRdJ9sIcu5M1ZWNc+Z6zFoKMGmLDC85iUHUPBZ/Og9x4e+USgRaxufOP20X5di3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd0srwENxB6+E1FwtIKPOG831nCxmcLFbgoM+joZ+O0=;
 b=Jn0TSUOSK6Gxd+u8HiJbVKIy6Q8enRIql8czs12rpBv91IqEIsX3O9Xwe3Icr0O/h8NAxoe4+hPank2APi6lhRl1svmnznpdUeUCSMbR8704N4F71kQXt2hHe85iKlMxo/L/Ux0UNEr+5ZdoPBjR2jIiZPHLQMu2h/1TXCzC69UC1DDoItDne6ihOhHCMaU6dli3FJC/sGJQDThvWXVfI4paOjM1cUIPxIyqT/fm0HTeQvQF3MZTFm8MUuBnOP/hTWQIuDBZz9PZQdI4Vr+TbxCacUq50kfwckW+njSJHN9KYuNqbMeiJPkT8pI65eTFppshVuJULVklQDnr8/pVyQ==
Received: from CH2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:610:50::28)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 1 Sep
 2026 09:34:31 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::53) by CH2PR16CA0018.outlook.office365.com
 (2603:10b6:610:50::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:13 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:10 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 16/19] vfio/pci: Quiesce INTx during PCI recovery
Date: Tue, 1 Sep 2026 10:32:14 +0100
Message-ID: <20260901093217.8539-17-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901093217.8539-1-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0693c4-41d1-4ce9-56e4-08df080c39e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|5023799004|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aO5W8mSZMLmXO3yUVXEHRUfz2WUuJ4PERqtuc9jcqGrQqLdIzv9x7EBdSYnj3SiYri/lKVuYy4Q2BCU8IFCgUD9JfAuIfWUbH9Dky1icETNRXdNpt6GrX743PjLi/r8Pzbs2CRyBMGXT9namKgTJqGrpuK1s6H8iRlooFf+YsgXhlByoS6wZBIYwGc8E7YA8qYjI3F0jTdTix7zbG/RoT4HoEcy5+cm1EoOHp1LNS/m8ZZNKeTV34eWIJLblgMXnCRhghjbsjaVfoXfqpxgjksOCVc6B99CxDv3jaaSAYEri0yRNvuTl9A4PO8RSOrimDKhnWqPmkjvDO2P1Ijv07NeMbZA199Noep9FyqPkzP8nAcQ82X1FkbNyiDz/N69odbhpqnpXlLz9/aBUg9QGo1qu4ZTt7sncHeu137HTJs5AD48TM/Wpn4Vf9mPjJ1iWHEgVhUh/Qu3OxkNcq6Qq8OcQY+G9jUz6nMd8X/8l7M8xEIWMhnxDkDDoWd38AUz7hOZB3RA5AOdEY8rueIOeWn/pd5ZVVVOasUf82VqG013CzYdx8o84IhClNbOboe0EYbWmBuwp78sAxzJL40mXYSxjf+5axPaK+piBI5Hc8WGZjg+YLG0Hl7Vh9t4pByQmM6rVR97kZPS0bIcP6vHuHfMk6YLpzaOjOy2ZhjSKDJYXLngQpFKrZHl/BRh5lxqUwW5t9/yiKgoqFDGkYtEcbQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(5023799004)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bTKRxJ9jkYbRtiGkKma1YD+x0GoE9SJAQGwSqUCn28ylwlLgHeY4O17mvH2iEqoN7enaDuecDS8vtRIsaJGeCqFj4Xt8K+IzZLiZi+NJRMHD2Z46CqV3SwxkL3cCCbD1TojvPFNo7tERDugbMruysUbEgHzclXxyWWa3qlExO3teUwKlVnoZ4psWDxTM4qkQc02wH5FG+FEb0fCEwwcIf5X855R2Ve4rCrkXXQku1vPGz2HjL8WFuXGmsOCjkgHNV9+mTXWSArPq9pjIgdzOYNPZFdwQ6LJHsYVbeqPkWyktAEIsA2RIvGfvGGLPWlcuCfoLT5C8fXSUFuHtmaMY/IygqCPQ+9kAKhoceqv6gW6eJHTtc23IAT4Vx7ufh2muoaPjWMsscEnYu+8vhN7emUratASgvMU/pVTx+ocyRhV3tlHwsPOGYBULjRvNAloP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:31.2565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0693c4-41d1-4ce9-56e4-08df080c39e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098

Mask INTx when recovery blocks device access. A PCI 2.3 device shares its
line, so leaving a level interrupt asserted and returning IRQ_NONE would
storm until note_interrupt() disables the line for every device on it.
Mask through pci_check_and_mask_intx() and return IRQ_HANDLED instead. A
device without per-function masking has the line to itself and is quiesced
through genirq.

That is a different job from the masking recovery does for itself, so
vfio_pci_intx_mask_for_recovery() gains a @quiesce argument to tell them
apart. The handler knows an interrupt has fired but not whether this
device is the one asserting the shared line, which is what
pci_check_and_mask_intx() reports, and a false return means the interrupt
belongs to another device. It is also the user who unmasks afterwards,
having been sent the eventfd, so the handler does not record the mask as
one recovery owes.

Record unmask requests received during recovery instead of losing them, so
vfio_pci_intx_recovery_finish() can replay them once the event ends.

The unmask handler checks for a blocked device before the existing INTx
test, so a blocked device is not touched through pci_intx(). It only
dereferences the interrupt context once that test has passed. The DisINTx
emulation calls the unmask path whatever irq_type is set to, and the
context is NULL when INTx is not in use.

Replay from the reset path as well. The unmask eventfd reaches
vfio_pci_intx_unmask_handler() through virqfd, which takes no recovery_lock
and so cannot be refused, and VFIO_DEVICE_RESET blocks access for its
duration. Without a replay there the line stays masked and the guest waits
for an interrupt which cannot arrive, since it only unmasks again after
receiving one.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c  |  1 +
 drivers/vfio/pci/vfio_pci_intrs.c | 61 ++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index b3ad7ed261e1..658cccecab12 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1558,6 +1558,7 @@ int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev,
 						  VFIO_PCI_RECOVERY_FAILED))) {
 			vfio_pci_recovery_rom_disable(vdev);
 			WRITE_ONCE(vdev->pci_recovery_access_blocked, false);
+			vfio_pci_intx_recovery_finish(vdev);
 		}
 		up_write(&vdev->recovery_lock);
 		/*
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index c4a075b5bb2e..1981a64b6e18 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -51,6 +51,15 @@ static bool is_irq_none(struct vfio_pci_core_device *vdev)
 		 vdev->irq_type == VFIO_PCI_MSIX_IRQ_INDEX);
 }
 
+static bool vfio_pci_recovery_blocks_irq(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->pci_recovery_supported)
+		return false;
+
+	return READ_ONCE(vdev->pci_recovery_enabled) &&
+	       READ_ONCE(vdev->pci_recovery_access_blocked);
+}
+
 static
 struct vfio_pci_irq_ctx *vfio_irq_ctx_get(struct vfio_pci_core_device *vdev,
 					  unsigned long index)
@@ -173,6 +182,16 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
 	int ret = 0;
 
 	spin_lock_irqsave(&vdev->irqlock, flags);
+	/*
+	 * Check for a blocked device before the INTx test below, so a blocked
+	 * device is not touched through pci_intx(). @ctx is only valid when
+	 * INTx is in use, so record the request only then.
+	 */
+	if (unlikely(vfio_pci_recovery_blocks_irq(vdev))) {
+		if (is_intx(vdev))
+			ctx->unmask_pending = true;
+		goto out_unlock;
+	}
 
 	/*
 	 * Unmasking comes from ioctl or config, so again, have the
@@ -184,6 +203,9 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
 		goto out_unlock;
 	}
 
+	ctx->unmask_pending = false;
+	ctx->recovery_masked = false;
+
 	if (ctx->masked && !vdev->virq_disabled) {
 		/*
 		 * A pending interrupt here would immediately trigger,
@@ -224,13 +246,16 @@ void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
 
 /*
  * Mask INTx because recovery has blocked device access. Returns true if this
- * call did the masking, which means recovery is the one which must unmask.
+ * call did the masking.
  *
- * Nothing is normally asserted when a recovery starts, and
+ * Set @quiesce when recovery is masking the line itself rather than masking
+ * one delivered interrupt. Nothing is normally asserted at that point, and
  * pci_check_and_mask_intx() only writes DisINTx when the status register says
- * an interrupt is pending, so it would leave the line alone. pci_intx() masks
- * whatever the device is doing, as __vfio_pci_intx_mask() already does for the
- * same reason.
+ * an interrupt is pending, so it would leave the line alone. The interrupt
+ * handler wants that test, since a false return there means the interrupt
+ * belongs to another device on a shared line. @quiesce also records that
+ * recovery is the one which must unmask. A masked interrupt which was
+ * delivered is the user's to unmask, exactly as outside recovery.
  *
  * Masking a pci_2_3 device goes through config space. If the error left
  * config space unreadable the write has no effect and the line stays
@@ -239,7 +264,8 @@ void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
  * access is blocked.
  */
 static bool vfio_pci_intx_mask_for_recovery(struct vfio_pci_core_device *vdev,
-					    struct vfio_pci_irq_ctx *ctx)
+					    struct vfio_pci_irq_ctx *ctx,
+					    bool quiesce)
 {
 	lockdep_assert_held(&vdev->irqlock);
 
@@ -248,11 +274,14 @@ static bool vfio_pci_intx_mask_for_recovery(struct vfio_pci_core_device *vdev,
 
 	if (!vdev->pci_2_3)
 		disable_irq_nosync(vdev->pdev->irq);
-	else
+	else if (quiesce)
 		pci_intx(vdev->pdev, 0);
+	else if (!pci_check_and_mask_intx(vdev->pdev))
+		return false;
 
 	ctx->masked = true;
-	ctx->recovery_masked = true;
+	if (quiesce)
+		ctx->recovery_masked = true;
 	return true;
 }
 
@@ -264,6 +293,19 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	int ret = IRQ_NONE;
 
 	spin_lock_irqsave(&vdev->irqlock, flags);
+	if (unlikely(vfio_pci_recovery_blocks_irq(vdev))) {
+		/*
+		 * Mask rather than return IRQ_NONE with the line still
+		 * asserted. For a shared pci_2_3 line an unhandled level
+		 * interrupt storms until note_interrupt() disables the line
+		 * for every device on it, not just this one.
+		 */
+		if (vfio_pci_intx_mask_for_recovery(vdev, ctx, false))
+			ret = IRQ_HANDLED;
+		else if (ctx->masked && !vdev->pci_2_3)
+			ret = IRQ_HANDLED;
+		goto out_unlock;
+	}
 
 	if (!vdev->pci_2_3) {
 		disable_irq_nosync(vdev->pdev->irq);
@@ -275,6 +317,7 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 	}
 
+out_unlock:
 	spin_unlock_irqrestore(&vdev->irqlock, flags);
 
 	if (ret == IRQ_HANDLED)
@@ -298,7 +341,7 @@ void vfio_pci_intx_recovery_start(struct vfio_pci_core_device *vdev)
 	if (WARN_ON_ONCE(!ctx))
 		goto out_unlock;
 
-	vfio_pci_intx_mask_for_recovery(vdev, ctx);
+	vfio_pci_intx_mask_for_recovery(vdev, ctx, true);
 
 out_unlock:
 	spin_unlock_irqrestore(&vdev->irqlock, flags);
-- 
2.43.0


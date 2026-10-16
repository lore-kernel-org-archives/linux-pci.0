Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D4545D97;
	Fri, 16 Oct 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167815; cv=fail; b=ROT8eR2DRF0gFIlV4CuXkIns6pCZUN2xbKmJ5MkLfrSUY28KVNApGMvZlEbbejjCKoQWKD1hIHPQeeDqWcWSqBzcgxmPJ3Qc0ZbFskxhJwhjTNdpCtbQLSITsLC7Nl6H0yLVs2aTm2kea45EfMvxT+Z98zCv9maY2nqqPLxQUDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167815; c=relaxed/simple;
	bh=jw6n4P53i4PHeNqA4dJ4QpCkTgpAm8VspXMty/BMICo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccY4qL69o5qr0ZulprHwsA93kUNOC3q+S/XchGqQa4tADlKO8zWDcCv+vi0Hv8Qz+39e8cZYUw5V9O2ijFwy9JiZLKdVLFt5J2tsGKamStcFX1cuIgxBsnDfBBlS/rHSacLi9tpcc9P1RSmm3MIyyGdVsEn8JHrs1RhLPhYnzEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VrgRIWl5; arc=fail smtp.client-ip=52.101.52.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VrgRIWl5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8EYoYa4rr+qS36WscJzZvEy+7ABshCUCXx073wPLn+BlMs9gtyI/v6ExAiqpwgYhQ7vhG8V2tzm+fDJ30q2C9XAMhuSc099iciW5dAODEsTo5D15MtU+gVtDLOrQ7gdmLageM7fgYpT2O9v73LE7xttJph52dglQZYehdLbDlQBDj2oXhGpg7jlubjGEW9V9XrczbHj/3xTdDu0TyW3Kroegr6wIgZJA7mdvDwlynlBp1LaP7/2AvhydAtcGhdhGxFW8jymS2Qtgy/+R3SUzilRbUkamDGV1NfN4Ez3291mszHbTlrIpDRb7SY2LhmzDjLWy/ZwKL7wEQIYspCtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pkw9wHuHpuhuOAN/VzWaUZ36r4dZTYB+6IBsyGD+//E=;
 b=dS+BWICbyYpy+De3WRyZO7PjiKyw6i4Fhr/raewLo4AdKAS4X067ObXW+gRE9oS5x1DN72eLDJ6sKJNBsZZwriWzWvQd3W8rQyyRJ7LZalB6TcMAxoIpV/QBHDXZEy5ofxfzbjvUiv2JOXMFwF3vQUeWwNulYyzqhE86+2kN/npcjNV+oNh3nSpOlr52K4eYn2DVzJY/7XuInofvRgT2zJQYbAOJuTOeVcAV/nOXP39+IB1wMmmvGUNvPopprNwnm9S5GqTWN1Cj4WxILFxu1vfXfSCmMmvASQloPe05nKa9HuoiXz3+AaPmna6F1xRsi0Bh+rwHLkOOfxRhgeDdmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pkw9wHuHpuhuOAN/VzWaUZ36r4dZTYB+6IBsyGD+//E=;
 b=VrgRIWl5hOItkLMO/s7QROfgkIAtlCCuCkobP39nd/Anma7x1RLE48N6mYYtNpnUgGHqZnwTTgZDtzxYdu6jvZcKbR6mTYYfrlnEYReWuTgjzgIcB4uYk3WJgsXeSeSYrJDzgOEzrEGtWGr4Kztzo7fl6RqnN/UwOzc52Tu9Fm0pCtCROXVF9LCn9hGSmpydMTTIusP3xjawZCbJX4hMrPqn+TG1EkvGv2q8i3KqBVAXkY/UBcBJ8qIjxThin4RTYCQdjjqsrsE/qICARdSkCX80cjRcEAsmBCD6ar4liruUFoCxtO3VvrX05YcxCO6IPkHjHyHemfayAGCcnDkd4w==
Received: from DS1PR04CA0001.namprd04.prod.outlook.com (2603:10b6:8:44f::8) by
 PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.15; Fri, 16 Oct 2026 16:23:21 +0000
Received: from DM3PEPF000265AF.namprd02.prod.outlook.com
 (2603:10b6:8:44f:cafe::44) by DS1PR04CA0001.outlook.office365.com
 (2603:10b6:8:44f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:23:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM3PEPF000265AF.mail.protection.outlook.com (10.167.23.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:23:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:22:55 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:22:46 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v6 26/31] vfio/cxl: Restore the HDM decoder after a hot reset
Date: Fri, 16 Oct 2026 21:48:33 +0530
Message-ID: <20261016161839.2765592-27-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265AF:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: c6840375-0d25-44ea-6640-08df2ba1cb55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|82310400026|376014|23010399003|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	riGAt802PBjxwFQVte5VgSv+9lDeQxaEBNBbTnhuNCRh8Iqs6440JFvS5Bv9uuNnQcthrilMEzxUsy2rRfoTlBI6JfDdWPs/8fRV12WUm4QntEs5E8Cw4/sbClrFzYhrw8eK44vbkUCT+l0Cp4mQDznCjokuBL0EHXAsqRz82UJpmOtca+gaknB6RHLyfFVec0uE7Ihb6L7NL8NHCGraQv9wAX7moqNrYsJ/S/B294uHQ0cjaSRv18TrtT8rA6QIExDdLexeTQpE2RYkx+4tQ056hh22pTqKSn1XWsvlI3gqelu6h0ZRV+it3Vu5nQtK+GIuVir0GQTwBBQVpE4q1emuf/r3QECTJIrKC9MImUKwp7kgubRMXkKiJpH7mBJO4hXhnOfxtqT4NidehYgN+akuRTpGn51XpplQ2ZbH1UbcrwgDdVs3ivydiIn5oepdYQLFVK6o9o9QGLR77f4mhjme0eE3JKs3Vm/b6rd6vs868WVOaBVQpXJDs2pQAvA20p88Ns0051mRruyNQ7VqYK8q8ivNjZVnOks2N3KoK0WnRUKX/afGuxRzqXKYFu5WTl7+fei/+UHa473EHCRC2GzftaHyhrd4wm8FbukrIKBeUtOZQaK/szz4DtZn+mXllx6lRTGxICOBBGf62n4j+LFheWLNML+kLOfTmJ4WY1dWk/xRoYqznopDrvQSg+W6NevE1O2yj4D5IKnL+POBZdRPDgeCFY/DMIek9QxehHwVz1pNev6jCGxpxaSJd5h6
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(82310400026)(376014)(23010399003)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	walzou4mmzBeqW/2XcGjNChNmzHJmkVTWupVjHjIFK9GyImTLJs5FUGmlpADKMhf5zUl7Kz5ffsna3Js57htXMpNpwVuTmeIi/1lE7MYpTuiEqTGFG9Y30lojus2JDWk4TnIhl66Cwp7YgCbzumRxshahOVYPglmVafEEKIo8+UZqwWEc4XlOSRKuBKeqNdHcj76cDyH0Obl4Ul51FJzU2rwNQuTslIandmZ3sqvygQfeKV5YznA6LXCrH3Xvw7humkBOREpsKU+gWwB1KykBpIG3RWebAA+GNBs6Q+WwahjgkPyM/tvz898GGAxrB8hp2aodUbND+01ZR2wYXmAFwpq8CWowaO9vIhacubaJg/807zhc5cNpFTV8gKDksjIknrlss2S7CpvT9y6fV1YLl8aJIEp4bZBYUIjrDuuANKmcYu4y22KMj1nqsVvKQKT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:23:20.9482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6840375-0d25-44ea-6640-08df2ba1cb55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

From: Manish Honap <mhonap@nvidia.com>

The HDM memory fault inserts a PFN only when the decoder is in a
known-good state (cxl->hdm_valid), so the host CPU never faults the
coherent range into a disabled decoder.

VFIO_DEVICE_PCI_HOT_RESET drives a plain secondary bus reset rather than
the CXL reset sequence. A secondary bus reset only reaches a CXL
endpoint when the upstream port has SBR unmasked (CXL r4.0 sec 8.1.5.2).
With SBR masked the PCI core now refuses the bus reset, so the hot reset
fails instead of doing nothing. With SBR unmasked the reset is a Hot
Reset, which returns the decoder's RWL fields, Commit included, to their
defaults and decommits it (CXL r4.0 sec 8.2.4.20.7, Table 8-1).

Take the HDM memory region out of use in reset_prepare. In reset_done,
when the port has SBR unmasked and the decoder is no longer committed,
restore it with cxl_restore_state_after_pci_reset(), the helper the PCI
core's cxl_bus reset method uses, and put the region back. A decoder
that is still committed, after an FLR or a cxl_bus reset that restored
it itself, is left alone. If the restore fails, reset_done returns the
error, the hot reset ioctl fails with it, and the region stays out of
use until a reset succeeds. reset_done also runs after a reset method
that failed and after resets that do not reach the decoder; then put the
region back only if it was in use when reset_prepare ran. Before putting
the region back, reset_done waits for Memory_Active as power_up does, and
returns -ETIMEDOUT if the memory does not come back.

AER and DPC recovery can reset the link without reset_done. The HDM
region is taken out of use when the error is reported and put back when
recovery resumes the device only if it was in use before and the decoder
is still committed; recovery does not restore config space, so otherwise
the region stays out of use until the user resets the device. The
resume path also waits for Memory_Active before it puts the region back.

vfio_cxl_sbr_unmasked() mirrors the cxl_sbr_masked() check the PCI core
uses (drivers/pci/pci.c) for its own CXL bus reset. power_up now also
skips the restore when the decoder is still committed, as after a D3
request that left the device in D0.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 156 +++++++++++++++++++++++++--
 1 file changed, 147 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 68e898ee1985..3cbb9fbc8328 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/vfio_pci_core.h>
 #include <cxl/cxl.h>
+#include <cxl/cxl_regs.h>
 #include <cxl/hdm.h>
 #include <cxl/pci.h>
 
@@ -35,6 +36,7 @@
  * @await_mem_active: the device reported its memory active at bind, so wait
  *	for Memory_Active before host access reopens after a reset or low power
  * @mem_region_index: vfio region index of the HDM memory region while open, else 0
+ * @hdm_open_at_prepare: @hdm_valid as reset_prepare found it; under memory_lock
  */
 struct vfio_cxl_state {
 	struct cxl_dev_state cxlds;
@@ -48,6 +50,7 @@ struct vfio_cxl_state {
 	bool hdm_valid;
 	bool await_mem_active;
 	unsigned int mem_region_index;
+	bool hdm_open_at_prepare;
 };
 
 static unsigned long vfio_cxl_mem_pgoff(struct vm_area_struct *vma,
@@ -684,15 +687,6 @@ static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
 	cxl->mem_region_index = 0;
 }
 
-static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
-{
-}
-
-static int vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
-{
-	return 0;
-}
-
 /*
  * Take the HDM memory region out of use: zap its mmaps and revoke its
  * dma-bufs. A fault then gets SIGBUS from vfio_cxl_mem_huge_fault() until
@@ -756,6 +750,33 @@ static int vfio_cxl_reset(struct vfio_pci_core_device *vdev)
 	return pci_cxl_reset_owned(vdev->pdev, vdev->cxl->hpa_res);
 }
 
+/*
+ * Report whether the device still decodes its HDM range: memory decode on,
+ * CXL.mem enabled in the CXL Device DVSEC and the decoder committed. A
+ * secondary bus reset or a link down clears all three. Config space is read
+ * first; the decoder registers sit in a BAR and are read only while memory
+ * decode is on.
+ */
+static bool vfio_cxl_hdm_intact(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	struct pci_dev *pdev = vdev->pdev;
+	u16 cmd, ctrl;
+	u32 dctrl;
+
+	if (pci_read_config_word(pdev, PCI_COMMAND, &cmd) ||
+	    PCI_POSSIBLE_ERROR(cmd) || !(cmd & PCI_COMMAND_MEMORY))
+		return false;
+
+	if (pci_read_config_word(pdev, cxl->hdm->dvsec + PCI_DVSEC_CXL_CTRL,
+				 &ctrl) ||
+	    PCI_POSSIBLE_ERROR(ctrl) || !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
+		return false;
+
+	dctrl = readl(cxl->hdm_regs + CXL_HDM_DECODER0_CTRL_OFFSET(0));
+	return dctrl != U32_MAX && (dctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+}
+
 /* Low power loses the committed decoder: close host access until restored. */
 static void vfio_cxl_power_down(struct vfio_pci_core_device *vdev)
 {
@@ -770,6 +791,16 @@ static void vfio_cxl_power_up(struct vfio_pci_core_device *vdev)
 
 	lockdep_assert_held_write(&vdev->memory_lock);
 
+	/*
+	 * A D3 request that failed, or a quirk that kept the device in D0,
+	 * lost nothing: reopen without decommitting and recommitting.
+	 */
+	if (vfio_cxl_hdm_intact(vdev)) {
+		if (!vfio_cxl_await_mem_active(vdev))
+			vfio_cxl_rearm_hdm(vdev);
+		return;
+	}
+
 	/*
 	 * Restore the decoder that low power lost. The restore needs the device
 	 * lock; if it is contended, keep host access closed until a reset
@@ -793,6 +824,112 @@ static void vfio_cxl_power_up(struct vfio_pci_core_device *vdev)
 	}
 }
 
+/* A PCI core reset may clear the decoder: take the HDM region out of use. */
+static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
+{
+	vdev->cxl->hdm_open_at_prepare = vdev->cxl->hdm_valid;
+	vfio_cxl_revoke_hdm(vdev);
+}
+
+/*
+ * A secondary bus reset only reaches a CXL endpoint when the upstream port
+ * has SBR unmasked (CXL r4.0 sec 8.1.5.2); otherwise the Bridge Control SBR
+ * bit is ignored and the decoder is left intact. Mirrors the cxl_sbr_masked()
+ * check the PCI core uses for its own CXL bus reset.
+ */
+static bool vfio_cxl_sbr_unmasked(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
+	u16 dvsec, ctl;
+
+	if (!bridge)
+		return false;
+
+	dvsec = pci_find_dvsec_capability(bridge, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_PORT);
+	if (!dvsec)
+		return false;
+
+	if (pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &ctl))
+		return false;
+
+	return ctl & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
+}
+
+static int vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	struct pci_dev *pdev = vdev->pdev;
+	int ret;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	/*
+	 * VFIO_DEVICE_PCI_HOT_RESET drives a plain secondary bus reset, not the
+	 * CXL-aware cxl_reset_bus_function(). When the upstream port has SBR
+	 * unmasked the reset decommits the decoder. The PCI core has restored
+	 * config space by now; restore the decoder with the same helper its
+	 * cxl_bus reset method uses. A masked port refuses the bus reset. Other
+	 * resets (FLR, the cxl_reset and cxl_bus methods) leave the decoder
+	 * committed or restore it themselves; restore only a decoder that is
+	 * gone, so a committed one is not decommitted and committed again.
+	 */
+	if (vfio_cxl_sbr_unmasked(pdev) && !vfio_cxl_hdm_intact(vdev)) {
+		ret = pci_save_state(pdev);
+		if (!ret)
+			ret = cxl_restore_state_after_pci_reset(pdev, cxl->hdm);
+		if (ret) {
+			pci_warn(pdev, "vfio-cxl: HDM decoder restore failed: %d\n",
+				 ret);
+			vfio_cxl_sync_mem_enable(vdev);
+			return ret;
+		}
+	} else if (!cxl->hdm_open_at_prepare) {
+		/*
+		 * reset_done runs even when the reset method failed. Nothing
+		 * restored the decoder, and it was not known good before this
+		 * reset (a failed reset or a skipped restore closed the gate),
+		 * so keep host access closed.
+		 */
+		return 0;
+	}
+
+	ret = vfio_cxl_await_mem_active(vdev);
+	if (ret)
+		return ret;
+
+	vfio_cxl_rearm_hdm(vdev);
+	return 0;
+}
+
+/*
+ * AER or DPC recovery resumes the device without restoring its config space,
+ * so do not restore the decoder here. Put the HDM region back only if the
+ * device still decodes it; otherwise the user's reset restores it.
+ */
+static void vfio_cxl_error_resume(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	/* Low power closed the region; vfio_cxl_power_up() reopens it. */
+	if (pdev->current_state != PCI_D0)
+		return;
+
+	/* The region was closed before the error; keep it that way. */
+	if (!vdev->cxl->hdm_open_at_prepare)
+		return;
+
+	if (!vfio_cxl_hdm_intact(vdev)) {
+		pci_warn(pdev, "vfio-cxl: HDM decoder lost in error recovery, reset the device to restore it\n");
+		return;
+	}
+
+	if (!vfio_cxl_await_mem_active(vdev))
+		vfio_cxl_rearm_hdm(vdev);
+}
+
 static const struct vfio_cxl_ops vfio_cxl_ops = {
 	.init		= vfio_cxl_init_device,
 	.release	= vfio_cxl_release_device,
@@ -800,6 +937,7 @@ static const struct vfio_cxl_ops vfio_cxl_ops = {
 	.close_device	= vfio_cxl_close_device,
 	.reset_prepare	= vfio_cxl_reset_prepare,
 	.reset_done	= vfio_cxl_reset_done,
+	.error_resume	= vfio_cxl_error_resume,
 	.reset		= vfio_cxl_reset,
 	.power_down	= vfio_cxl_power_down,
 	.power_up	= vfio_cxl_power_up,
-- 
2.53.0


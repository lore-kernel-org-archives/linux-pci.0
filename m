Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80F314D34;
	Fri,  3 Jul 2026 04:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051694; cv=fail; b=pMWHYKYNN2w1Sxas9D9oCYngLixhdUWBDp7JrUCyRAYtAkkeCism5CyK5NdU7f3V7r5/rj4HssuViTU1rlSy1SsUE2bKpOfpK6QqoSwi0uUfQhES7xJXvpBonq+1RudoqGq/CH2bVxilhwkKa4Pp40Y2RAPw/Fy90r++PN+fUj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051694; c=relaxed/simple;
	bh=plo3qncT7q1l/efIoJDhgHiOLkJ4niZkQGjxQRCEkSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCusVbOdvnZw2CP0xBUA0mD6cYWqJCdU9uE1CvDDV6rKB35FpyoRqNIir/TxMqp8Hl9vHtVTLbOKBf25tdfrG0vDxsw6QPtEKYU+Zqr/NsbGqh9dz4ubzuLAQqd3pf4WrPCI4HvarcGJGWhcxb4/+4/Z2ajBNIGdTFXUXzwjb2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P04nCC1t; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P04nCC1t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psxf7dsnKJAv2gZVacvxfaDQiiSXLhdHPTuST0XYFk6BGerGHmhGA7wsfE2sZ5PoLQ3f6/0sgWYaUQJCeYOk5H5mT12PtJc9VutSdAL7h/6c10dfKNY6geln1+7YoeCzMuKceLR7QfKtqwnSaTFiJTFFBnuiyue7/tsS1KzVFZTAIZGnkJFzbzP4LsGjRPc6upEVA6Lhyk7QOSa+Qc0V7wnh4rxjMuc2+OLJl3VATCJi7Jzg1KG+CZGt1cQjbaNVx7slzMvu23+rGFn7M78jR23YMC+7hGnQvjZUvxb7rrZlS4jl/IyimRQ+AvSISfaOWG2yEljVMh2Y4iB3TLnmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UhTEhfqHqHnPeFNM86QHlVk2WKDMucC+478CCVzCFg=;
 b=UN2USN1thmZhNNQJgkF6Ja/Sz3gjpCM63rFfJx8g7/cTTSf1cb85OZ9R0vjO8mTdX8FwTv5+q+WDHBAU34Hje1cFNaUBIXhRQ5glGIVU6oHVjplZaUsVJjQrR3HOplJVJBgGDC1pmAftuDpbk4dq9wv3uNSc1DejQL13Afr16fQ8v8LVvRbpULKCBNpcZA10FXnCiJOS358FWt+jIRe4G+5lNnq/KBg4cJTzLBy/8V7EWGx/44C/HpIOObkttH5yeGZbQuJSJw4D+3mb2t8DghuLu4KJN+OZiCKvSu/VA3jDWOFvMUEdFxAN2qwtSqawXDv2gh6AVDpefExz/BuX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UhTEhfqHqHnPeFNM86QHlVk2WKDMucC+478CCVzCFg=;
 b=P04nCC1ttumPr30hZgDRXSufuTsoCIacwxf91Va+l/nBqS5SKYu+XDFPm2+Ink+Z7DkxLN6Cm/Z6aIJzs+VoejswYceBkqpqnozl38ksHpZFozyksWavTXPhoh4ilCYnM6by1HX14rqtvmFKU9mgPzBNItncM4VsisFkmZ/yRFDWKF1MO/x5T5UrJ/Vu5KmlLZniwJt6pqAQb+VJuav9BUpgsAJOqkdRWEwg+s3salHT5OKQSUmmf6762H8wKgBQamLrQhWOdU+2Anrb5EsudyMky85+kTfE/vPhkPfbPKJhp1eA08pLYIiRHnbZSxM/kn3yTqMWWpcitgh5wrFacg==
Received: from SN7PR04CA0189.namprd04.prod.outlook.com (2603:10b6:806:126::14)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 04:07:52 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::7a) by SN7PR04CA0189.outlook.office365.com
 (2603:10b6:806:126::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 04:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:07:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v5 03/18] PCI: Propagate FLR return values to callers
Date: Thu, 2 Jul 2026 21:06:28 -0700
Message-ID: <b00acbe0755fa5999491368eaac26a78d522e2ed.1783044582.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f0f2b8-9300-4c37-6d61-08ded8b8a6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|11063799006|18002099003|22082099003|6133799003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	OTLpokAwdfP28hd/f/ZEdkoK7ephGKWVhXpwzyTlf1pgcH/MXJRr3ApyYPwMBzwJ4MYHeDknLbo2MUV7IUpLuhcX+0H8gwIkvky3HaT9RzGRagNUimv7iKvZGUdqDlHumzEhlRarR/sruObP9cAwmVXsmRKyuOhubJeEvifrYudLO0icqA0j+G9Mks5DrXD8rk2jZotBQF4KTnym2xARcMfGdGimaXbj0yn3d5eiKFlqM/4/DlgpxF1ylxYaZuEALtKbjO0opiI30SPQ9mSBd+vDE0S5jlw3tSIDmU81icY5GGvR+h2Pl5QSNbgVR+nKF2IU+ANSawcC/8d7dugcCD4O3kVLjTdTkcjO07peLZKeayhgodFfpx5aFcqJkoUjZq+4w3kx+gAPLnwLIIGhQKiWFt7gPpAhKOMSo50vtEWWshv7dysqrOrf3Zu5zsvDzJz4LRuLeg710THxUNFIv9VHbprws3vAQZ/Ak7sCacNj26DKjdZZ1pqdTPlWOBkhizs34bOcb/65wjUaC3BmBHoGldzmvFSztnHK1EouC2GyGYbEK6O4NGgwTsAczNFRVs9bL/qMWBvHqbrfuLsm8gcZ77DsDcr3+PuOMxa2YjY8ybKO920R9yy7s/EFtr9INiKFPaRO+W1MJi10Q3DhvclokTdcJOo0nt1pjL/200P4d/DKnsmfRRhGFg9nvf81jubtcROevq21+BeotZDnJw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(11063799006)(18002099003)(22082099003)(6133799003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LNicIyQGjx9vtqAoukTuG4UA88bl85o5Xx17gDNRezdayqfpRre3GaFBkHZotoQkDrYBMnkk84v5u3Atyrn3YiE+1aX3YAdAYwWsXGITEglWOEEotvS5jMdNMj+eSyCEHYKYbb4MO2NzUsiJ08rutwpndPk0hs/hn2Cti1Remru7FBvNwWjpW9G6tc0a+fzZVsC6AGfXcJ/u3ygyAX5IorzqyBzOf5WA8z3O4iVKHGPiCEB5VmlZQgnWbEHjFPzcbUKt8EtJ3VjgWLTGUvvXby+Gq18zpOi8rkhZZhME3qKTii/OTpPUhHMIsnilnjPTYGWG42XM5hnTETKRcPXDEZ5xvEKd9R6VzaHVOz5BcaS2eiPWeSdh5bC3ZHwe4pKSLkVTKfbWgz2ObWDPxcL3k2nlv3eCG529EHWa4nazzCcKU2QgUe4C6HBlvX7kFASh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:07:51.6230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f0f2b8-9300-4c37-6d61-08ded8b8a6d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926

A reset failure implies that the device might be unreliable. E.g. its ATC
might still retain stale entries. Thus, the IOMMU layer cannot trust this
device to resume its ATS function that can lead to memory corruption. So,
a subsequent change to pci_dev_reset_iommu_done() will keep such a failed
device blocked instead of recovering its IOMMU pathway.

Several quirk functions in the pci_dev_reset_methods array call pcie_flr()
but discard its return value and unconditionally report success, hiding a
failed reset from __pci_reset_function_locked(). Return the value instead.

Nothing is short-circuited on failure: each quirk still runs its restore or
settle steps as before, and reset_hinic_vf_dev() also reports its firmware
FLR-completion timeout, keeping an earlier pcie_flr() error if any.

Note that a kept pcie_flr() error does not misreport a normal reset: as per
the erratum in commit 411e2a43d210e ("PCI: Work around Huawei Intelligent
NIC VF FLR erratum"), the VF responds to config reads before its firmware
completes the reset processing, so pci_dev_wait() returns promptly instead
of timing out.

However, pcie_flr() reports a device that did not come back after the FLR
as -ENOTTY, and __pci_reset_function_locked() takes any -ENOTTY as "try the
next method". Since these quirks have always returned success, escalating
would be a new and harmful behavior: the next method is typically the plain
"flr" method, which would re-run the same FLR without the extra steps the
quirk wraps around its pcie_flr() call. Add quirk_flr_err() converting that
-ENOTTY to -ETIMEDOUT, so the cascade still stops at the quirk as before.
The early "not applicable" -ENOTTY returns are left intact, and they still
ask the caller to try the next method.

Convert it at the quirk level rather than in pcie_flr() or pci_dev_wait(),
because those also serve the native "flr"/"af_flr"/"pm" methods, where the
-ENOTTY on timeout is deliberate per commit 91295d79d658 ("PCI: Handle FLR
failure and allow other reset types"): a timed-out native FLR escalates to
a stronger reset (e.g. bus reset), which skips no workaround there and may
recover the device. Converting in the core would also change the value seen
by every direct pcie_flr() caller.

This is not a bug fix, since these functions have always returned success
and the propagated values are only consumed by incoming work.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/quirks.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8ecd1bc561d28..7f6d1574fe2bf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3934,6 +3934,18 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are
  * not available.
  */
+
+/*
+ * pcie_flr() reports a device that did not come back after the FLR as -ENOTTY.
+ * The caller __pci_reset_function_locked() takes that as "try the next method"
+ * and ignores the error, which is wrong for the quirk functions below. Return
+ * -ETIMEDOUT instead.
+ */
+static int quirk_flr_err(int err)
+{
+	return err == -ENOTTY ? -ETIMEDOUT : err;
+}
+
 static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, bool probe)
 {
 	/*
@@ -3945,7 +3957,7 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, bool probe)
 	 * supported.
 	 */
 	if (!probe)
-		pcie_flr(dev);
+		return quirk_flr_err(pcie_flr(dev));
 	return 0;
 }
 
@@ -4003,6 +4015,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
 {
 	u16 old_command;
 	u16 msix_flags;
+	int ret;
 
 	/*
 	 * If this isn't a Chelsio T4-based device, return -ENOTTY indicating
@@ -4048,16 +4061,15 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
 				      PCI_MSIX_FLAGS_ENABLE |
 				      PCI_MSIX_FLAGS_MASKALL);
 
-	pcie_flr(dev);
+	ret = quirk_flr_err(pcie_flr(dev));
 
 	/*
 	 * Restore the configuration information (BAR values, etc.) including
-	 * the original PCI Configuration Space Command word, and return
-	 * success.
+	 * the original PCI Configuration Space Command word.
 	 */
 	pci_restore_state(dev);
 	pci_write_config_word(dev, PCI_COMMAND, old_command);
-	return 0;
+	return ret;
 }
 
 #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
@@ -4140,9 +4152,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 
 	pci_iounmap(dev, bar);
 
-	pcie_flr(dev);
-
-	return 0;
+	return quirk_flr_err(pcie_flr(dev));
 }
 
 /*
@@ -4154,14 +4164,17 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
  */
 static int delay_250ms_after_flr(struct pci_dev *dev, bool probe)
 {
+	int ret;
+
 	if (probe)
 		return pcie_reset_flr(dev, PCI_RESET_PROBE);
 
-	pcie_reset_flr(dev, PCI_RESET_DO_RESET);
+	ret = quirk_flr_err(pcie_reset_flr(dev, PCI_RESET_DO_RESET));
 
+	/* Settle the device even on a failed FLR */
 	msleep(250);
 
-	return 0;
+	return ret;
 }
 
 #define PCI_DEVICE_ID_HINIC_VF      0x375E
@@ -4177,6 +4190,7 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	unsigned long timeout;
 	void __iomem *bar;
 	u32 val;
+	int ret;
 
 	if (probe)
 		return 0;
@@ -4197,12 +4211,13 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	val = val | HINIC_VF_FLR_PROC_BIT;
 	iowrite32be(val, bar + HINIC_VF_OP);
 
-	pcie_flr(pdev);
+	ret = quirk_flr_err(pcie_flr(pdev));
 
 	/*
 	 * The device must recapture its Bus and Device Numbers after FLR
 	 * in order generate Completions.  Issue a config write to let the
-	 * device capture this information.
+	 * device capture this information. Note that pcie_flr() can fail
+	 * after the reset is asserted. So, recapture it unconditionally.
 	 */
 	pci_write_config_word(pdev, PCI_VENDOR_ID, 0);
 
@@ -4220,11 +4235,13 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 		goto reset_complete;
 
 	pci_warn(pdev, "Reset dev timeout, FLR ack reg: %#010x\n", val);
+	/* Preserve pcie_flr()'s error if it failed before the device ack stage */
+	ret = ret ? : -ETIMEDOUT;
 
 reset_complete:
 	pci_iounmap(pdev, bar);
 
-	return 0;
+	return ret;
 }
 
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
-- 
2.43.0


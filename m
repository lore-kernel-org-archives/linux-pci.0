Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F5307AF4;
	Thu, 23 Jul 2026 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823069; cv=fail; b=vEC981tlHRdIjo9pL6X8hdQg4AQsbkv/HTWCsfAdEpcSzB2fKsmxNNUJhx9PJ2vdGlYi99uEn5vzImQYpLbm3p4QFdE5xjswN8KknF7yUnO82V6hkbPazR8pXLIBWkTSWvKXHFG3pRxq0eI8CvjEGBNwq4fuyaBhf4AfL54oK2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823069; c=relaxed/simple;
	bh=GqlE1gcfvgXfAA8/MkyXN9gwYd1jadHIv4xtYqhuVaA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cciwSCYg8ba/USpg8Sq2xYAIDLmOkacmS/S+znrf0hXBTdyFJ25Gs+RlUHxbJrxb0fTPoDskiMF+TQQsE3AOjV3Sj2qC5nJTtAC4u5gcIbAL18d73RtPaBRhYnoBxx/U2JXOYKLjV6WLwBJ0d6aUYuWMPAB+EwmxCecr7cVnrQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Etee05g6; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Etee05g6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md9QF0SoKMORp+5++aG1MctmCZp+ce1P/RdPligfl0d2BtLLbcv8fxb67E1wCvS0ZTH+cA4lY9stTdwHkmaIeQ8E07mPglHUc9FPZPgw4aK+kEzA03eEdEyEK80HvBnf1EOmxWwo086p9soXTsdME76F/f2C2Uwdu7po6TxxNvptRgH9qCpv9gRPo45MAJXntecS46hYOd0z79LeOHtLKy6eS8vrcrt4CCDIzwlTw96bi5Kbwfkl0E6rzAO/FLVrcY5oo3eBhPuJOqdCiZJb6N7H+OvlwfQPDSKgZsvlDIdaKP1eqd1l/uCRNkFUJWZFoHx4at7EyazI0e1s1Gq+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj+3cHvDZySXVprlFU3LOBXFg2Q+VbLpZbK117JC8Ao=;
 b=DaK3VUBWf8QPJhYU0NhOiRGqWVYRax3Oo0gN3WKIbyTd7fb3PbeF1IjsNLhsVwqmqnMJ2PiB+qEf/6ZQxQ/i8L+P9ipj8c1UvmBfKdqqpOULf0u0H9lCqclM8nsGIiNv36s/7F7BiBr7H/YxIVeQ8ISmTF0V3NrfboO+6EJGKUEwJXA+GNkaiOV2jesB+RnwQL8Mcd/0rsdqBHcqBbbjWcnaFG3afkUDJ3qCcdogSbYX2QZD9d1Ulyy6hY2SBN/7zLfRFOKDRKAjkdPhdHZV3M/vxIXW6qwYG5mpHfcZjpx1nnAWiUk9qNqYax9yhjlzXi5dD1GhAe/OpkEbDdTcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj+3cHvDZySXVprlFU3LOBXFg2Q+VbLpZbK117JC8Ao=;
 b=Etee05g6KKfpmnN0Cuoi8p/OTbkPmVDXdenNPTPr1WAYmsxPXRMoIwII9bwecTZomeRy57tb8eV81BcDYY6b/QNSO9u4qzKbNh6uf/nnUoJn20XZk7UjPgXpEtEHoFdOczU3p9/jOSw+FNfX5aSmhUlGjBMHf8HxItT9+U29QfaUdkWnTIIUBKgvMp6vtjNt2tL8y7XmNYjkb9NiGmDKWhwUv4Y9TUeeN8GQV4oK4jCrcA3nrB80eMjhJhrnqLHIQuQEFDMHyAVpP/qkgT9eUqop5WYrx0rZgqA0jUabWBOURFQ6P/YBfsfPRXMvgbCn+mb27gk1EWlQyswcbSP/xQ==
Received: from BL1PR13CA0373.namprd13.prod.outlook.com (2603:10b6:208:2c0::18)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 16:11:00 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::d) by BL1PR13CA0373.outlook.office365.com
 (2603:10b6:208:2c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Thu, 23
 Jul 2026 16:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 16:10:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 23 Jul
 2026 09:10:27 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Jul 2026 09:10:26 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Nirmoy Das <nirmoyd@nvidia.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, JC Chen <jc_chen@diodes.com>
Subject: [RFC PATCH] PCI: Work around Pericom PI7C9X3G606GPC Port 4 BAR erratum
Date: Thu, 23 Jul 2026 09:10:00 -0700
Message-ID: <20260723161010.2638956-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b8f046-133a-41c5-5e62-08dee8d4fc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|11063799006|10067099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DyZAUzNn89bFPu4fCgwBSW0Gi91L/zj3A0ShpyiPq7LtssGd23C18U7PjKaGmDRM0IHHxjdW7CE6saRh61w9AaSQhS1WIXiTELah8PERXHP/+Hs//JENH7coFXZCiFx85TxejfVK2PcGPcsasslAGTiNrDluQBz9BuWLS+6gkqRsYrFc6lQubqMDmn1PUftHENIEqA9XGDV3q8MRgEBRJgDJ0UKHR23qpPvL0Xm66QbKfzqgvK3AcBade/P1r9LtrbwzzD3v/QRVRdZ3bYlgRrBc3IjGkd0Pd7YYlpPRdtXPQk22Z1TRtn7a7TFGt3gLKcmS8+c3UHxofdGqujDh/pspeSGGUH7IRZgyfOqKAbKJ62BmMeG36nHEmyZ1cxHGvbhE5voztWgESIJboKPN0rH+RKIbEvRUKekmJcWIvlwXzryAccLict1DMHBKnGrZ5Vj1d2iQoa9pL8+5tADTTkoxOd5DKiJxHjUhmUFT6OH0GsPCH7/3PFo39eT4ZyIt3fNnlYYyKOqMqilouvqPXtsNe1hXlrcjGhLzBHmFoxDty3hnoszqLjEcnouJIqe1XfNP464BbxOzQVa2YvWX+jFSH2vjTo0Mkt2V77KbAE0FX2gm9cAZRtuO8Zs/n6XzRcvocHFgKQmvRgJHjCfQgBwYn2QTBjjtlk6w0WKW1gB8RooyCAQKyixLrdyQhyObw4r6TXFfdhaqE17dayUVGA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q/yxu19z7X9EnLfdiDiLfW+0TcZOZYtCj72B9wXhKjT34JT0ddftQTX6Y65sKaFda358RJQYkaLf91IW46fLaonfCMxIf2lrOG0QZLEUtvftuAOfY9AKPg9LcVk5YmYOyQ2fV6Td3t49K4MU+HS7zYTxaryI6lK8XQjzrcykRUE38eKHqdP2WK8yKTY2QqVwjErw1vZWXq43aSPrLgZcRImkAN26Ke1yYH6oKt7PKPDYSltxPtwAH1aSrzgh4GrhL8+dxTo3eJGiY3oiyBCbi0Qiuacitch5VgaVVY5XFfwwcsE6RvSblDxGmH2opMaDPBofMDSgWj/kHcSkEVbeJu+GiCxUd2tzp938GegZJhDxhxxKUlmfeGTwE3DXxplbPi/2AGc5nA39Mv8IH+O3fvaTLX7ZOroLjMuBxXS50aSIBvyo2zBuNDYCkz+RAuog
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:10:59.6163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b8f046-133a-41c5-5e62-08dee8d4fc62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816

The Pericom PI7C9X3G606GPC PCIe switch has an erratum where downstream
Port 4 retains a default MSI-X table and PBA decode when BAR 0 is zero.
Memory reads that match this window are dropped with an Unsupported
Request completion, which may cause the SoC to report a timeout.

The workaround is to make Port 4 BAR 0 mirror BAR 0 of the immediate
upstream port. Firmware may establish this at boot, but PCI resource
assignment can move upstream BAR 0 without updating Port 4.

For a 64-bit BAR, also mirror BAR 1 while memory decoding is disabled,
matching the PCI core update sequence. Port 4 BAR 0 may read back as zero
after a successful write, so do not use readback to validate the update.

Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 drivers/pci/quirks.c | 92 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846fc..fa8098d77adb5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6264,6 +6264,98 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
 			 pci_fixup_pericom_acs_store_forward);
 
+#define PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC 0xc008
+
+/*
+ * Pericom PI7C9X3G606GPC switch erratum E15 -
+ * Downstream Port 4 BAR 0 must mirror the immediate upstream port BAR 0
+ *
+ * Port 4 uses BAR 0 for its MSI-X table and PBA. Firmware may program this
+ * mirror at boot, but Linux resource assignment can move the upstream BAR
+ * and leave Port 4 with a stale mirror.
+ *
+ * Diodes confirmed Tile0/P4 appears to Linux as device 4, function 0 on the
+ * bus below the upstream port. Match that downstream function and re-apply
+ * the mirror after resource assignment and early resume.
+ */
+static void pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror(struct pci_dev *pdev)
+{
+	struct pci_dev *upstream;
+	bool bar0_64, disable_mem;
+	u16 cmd = 0;
+	u32 bar = 0, bar1 = 0, upstream_bar = 0, upstream_bar1 = 0;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	if (PCI_SLOT(pdev->devfn) != 4 || PCI_FUNC(pdev->devfn))
+		return;
+
+	upstream = pci_upstream_bridge(pdev);
+	if (!upstream || upstream->vendor != PCI_VENDOR_ID_PERICOM ||
+	    upstream->device != PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC ||
+	    pci_pcie_type(upstream) != PCI_EXP_TYPE_UPSTREAM)
+		return;
+
+	pci_read_config_dword(upstream, PCI_BASE_ADDRESS_0, &upstream_bar);
+	if (upstream_bar & PCI_BASE_ADDRESS_SPACE_IO)
+		return;
+
+	bar0_64 = (upstream_bar & PCI_BASE_ADDRESS_MEM_TYPE_MASK) ==
+		  PCI_BASE_ADDRESS_MEM_TYPE_64;
+	if (bar0_64)
+		pci_read_config_dword(upstream, PCI_BASE_ADDRESS_1,
+				      &upstream_bar1);
+
+	if (!(upstream_bar & PCI_BASE_ADDRESS_MEM_MASK) &&
+	    (!bar0_64 || !upstream_bar1)) {
+		pci_warn(pdev, "skipping PI7C9X3G606GPC BAR 0 mirror workaround because upstream BAR 0 is unassigned\n");
+		return;
+	}
+
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &bar);
+	if (bar0_64) {
+		pci_read_config_dword(pdev, PCI_BASE_ADDRESS_1, &bar1);
+		if (bar == upstream_bar && bar1 == upstream_bar1)
+			return;
+	} else {
+		if (bar == upstream_bar)
+			return;
+	}
+
+	/*
+	 * Port 4 BAR 0 may read back as zero even after a successful write.
+	 * If BAR 0 is configured as 64-bit, BAR 1 is the upper half.
+	 * Disable memory decoding while updating both dwords, matching PCI
+	 * core's 64-bit BAR update sequence.
+	 */
+	disable_mem = bar0_64 && !pdev->mmio_always_on;
+	if (disable_mem) {
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		pci_write_config_word(pdev, PCI_COMMAND,
+				      cmd & ~PCI_COMMAND_MEMORY);
+	}
+
+	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, upstream_bar);
+	if (bar0_64)
+		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_1, upstream_bar1);
+	if (disable_mem)
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	if (bar0_64)
+		pci_info(pdev, "wrote upstream BAR 0/1 %#x/%#x to Port 4 BAR 0/1 for PI7C9X3G606GPC BAR 0 mirror workaround\n",
+			 upstream_bar, upstream_bar1);
+	else
+		pci_info(pdev, "wrote upstream BAR 0 %#x to Port 4 BAR 0 for PI7C9X3G606GPC BAR 0 mirror workaround\n",
+			 upstream_bar);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM,
+			PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC,
+			pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_PERICOM,
+			       PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC,
+			       pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror);
+
 static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 {
 	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0


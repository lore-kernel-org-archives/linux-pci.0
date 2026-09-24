Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8E41DE11;
	Thu, 24 Sep 2026 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245198; cv=fail; b=EjsLPFpMlvrcy2o+yJHmphzA4p1kRuvuGI4OwzyIvKlRxzCHnTjWG7JjIpcDBLG89TDci6e0ik4EYmzYinZZsR231MLjhxK176x2PYKLMnanxgDdX//xVERjm+g4bZRVoqpFqjpjtlg3joRZzmxVfvhB7TB3Rp1qYCDJtKolB8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245198; c=relaxed/simple;
	bh=x9czK8VnCYZ0E1OUEq+OZv2qADpoVrrf3ctdDFpigAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WYKoNaxEfgh3a24j7CQi0swM7U8L3NuDYwM1IzQcgu/1IV2I8+0D/zBSs8OZGQ6GXS0Q9sEc5wIuZSoGUOJBeLaE/srCYppB9BUeJIhMdrbNjrK4s0bZ+gGkD+0nXUJFKtx+XZKUCrnmu7JSoPWu9ijT7BPR6QTmq3SM4NUYQCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pMsZXrLf; arc=fail smtp.client-ip=40.93.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pMsZXrLf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONK5oQyA/75QfwfrEVzSo4QcwBI16F0W8NVs/MDixbvqWcaCgnXisDrIvEtiui0jD6AemPGj9JI/9HOgVOAv7WMsdwT6oP4I9r1rm+oxY3KRIk+2WoLFHI334qC8FYDYxyNSVHqDAGiK5+TKKlvJSn4De7KQOqj1vUZvAzmaYc5iNKRk6aw44k76RBw9mNni6E2YC3Y+wHgM8pUQp2PVGL5PDdeRbENGfAMSomwQSJOc7HDpP/79OgNxnf1dyG37xaG/b27dKC9NZfNmfuM6l+BshN3NFKC2/iAA2uATcPg4nSROSsqYGtt7Ll231amvEabyGX0bFFGUvI+q+UzEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDQ/zGrGUS8kCZNpsPfUrqSF7XQJfGJizHYTnzUUlJk=;
 b=OUS/UIfzCS2rVlJUQUXm7xvAxha8XTmWWmebWs99Qhrxofjl6we/gk+39e6TOkiJvZsL/RMkcO0GDRH8TXFfpYYdEgNSkUYuwY8hRInXyAkJqsCFeIjc6xneaa/UATa3HsKypRxa2051NqqCyJy0dWLjnNHbfz9O37zFyjpjvOoktjYAv6Nk8sSsri5rNraB04CzsM4Atu1KhubNRsYk2OhvTaG7UbtsEel4nga81FKWvoV3YexK+7XNqTdL3C7H8t2o7mUw+iAbTksSFpuTjVWTnCxZVwbRgGyH3rM6iAC1JPLKa7uByofGzwN1o+2ULP7xxTRX7RYQFmI6J/EUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDQ/zGrGUS8kCZNpsPfUrqSF7XQJfGJizHYTnzUUlJk=;
 b=pMsZXrLfz6M4qmrWUSWH4Y33uerjnwcJlUM/Nnvxu2n4n48MtZpB0M7pgpJ2w+I5mExlJyeAvqV1424jBqdagVZZmdHbgiyB4+xMF/EvH/NfEc//oXtTjodbAk5dlPjx2dUIYZzeBTd6iyA/p4yeNDcADHXgFhglWlQnlpWAF3U=
Received: from CH5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:1f4::21)
 by SAWPR12MB999164.namprd12.prod.outlook.com (2603:10b6:806:4e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:19:48 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::3) by CH5PR04CA0020.outlook.office365.com
 (2603:10b6:610:1f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 10:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 10:19:48 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 05:19:46 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <qiyuzhu2@amd.com>
Subject: [PATCH] PCI: pciehp: Re-read Slot Control when cached HPIE is clear
Date: Thu, 24 Sep 2026 10:19:29 +0000
Message-ID: <20260924101929.143806-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SAWPR12MB999164:EE_
X-MS-Office365-Filtering-Correlation-Id: fad2ec3d-342c-4401-b27b-08df1a255cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IQ/L526BVpfbnJr++W/6StF4KEkESf2T/+bpxi4KNAfVyZE/LDlS+P0BVLb9nueVODtH9TRykMuDmvqgn2lnpNWdRVjP2sYzqe3UIauyJwx4IXLYeoGhkYlrvZDCg5i48UMNA32bL2a7H+iOeNGjWMzAjELwsXAv9q2bf+dgrtvsZa4iIrIfmVD/PflafXYcwljmYDZpzQBKj4/A6UxbHGQrN24qo+gkcjIoQDqCPnIqRHdZ5Svvc+HOF3Kw61FwTbmytnC2R46nSkGmx6H28vYdRcjdk4yPfDP7+y+KU7SWPG5Y7BrZ9yz78hSLOkPyUseGxhSE2ONrXAWAq2bROJlmuC7A0i0qMhJUNLQp/bcPWxKzP4QJukecAPC6Cpg4+Z45QTzv40Xeq7OXDv4YJgZmrwhAn/9aDts1XDBTh+dOqoJSORHjvX6CcuO2NxiXFW1+O8m6vx7Vps8X8XIVXQln980v7vwNubf/HrF7p5oxvPi90DGqkAICTb0oCWZJJMOFHknGCQGwqw2Gmg1rUlT1hgn2tzaO2tf+5d24UFWssvdbKZ3f5iQ3+i2M6QSIxhILzXMwqCOB63Z80qO0QvsbFMUp11ytILusDBddFPUHQtzWbvcgc238GNP4t8UKbrVp2LyVYwNHUxKB/jJH6GDq4BDakrKGNlcPP7navLV71vOJgKuFfbPUSPQNOU/FIR4ZVQis6LBvTexD1CCUUw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XYUSGYRSLBM+eUaaJEDGFDiIPQBGXYfdqXwZMTomxsIQDej+3A87S4HDbKOwjhaCnCGISlwLDIV1G8OZgYNj7Sah0e1nelnW6GblBKissggx79c/6PAVoj4hB37cb10W6tFPCcUGCP70hn6X/WDym8lUvQOiwXat6V/Tx9kkxbuGjG3XK9ebpo1yOrcPbyijNPA8fZObnEndTu6lag73ePxCrnhRJbv5W2NDnc3c9x+R25IsWogNntH3+xw6GyMedWQIMfW997fKqBvRAfwwW7AZ6/a6sgQzqQZNOxpluFDrSkCkiovRpCLYYcZjC/Qm7RSInnoaOwxz2YwZepZ2SUisH5ITPwbnmgxqYQihck65pcBIQiidiQZYDNIZ7sKS4vqCZICOMF/Oenc1NKkQ2cW4EnZFObCvo4SneUqJrqhSCY44Deo/2jqtWZRs8bTr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:19:48.3542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad2ec3d-342c-4401-b27b-08df1a255cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999164

pciehp_isr() dismisses an interrupt as not ours (IRQ_NONE) when the
Hot-Plug Interrupt Enable (HPIE) bit is clear in ctrl->slot_ctrl, the
driver's cached copy of the Slot Control register.

This can drop hotplug events during PCIe hot-add.  On an AMD EPYC
platform, sometimes hot-adding an PCIe device delivered only the
Presence Detect Changed (PDC) event while the Data Link Layer State
Changed (DLSC) event was lost. Afterwards lspci still showed the
Link State Changed bit latched in Slot Status, i.e. the DLSC interrupt
was never serviced:

  pcieport 0000:c0:03.4: pciehp: pending interrupts 0x0008 from Slot Status
  pcieport 0000:c0:03.4: pciehp: Slot(71): Card present

  lspci -vvv after hot-add:
    SltCtl: Enable: ... PresDet+ HPIrq+ LinkChg+
    SltSta: Changed: MRL- PresDet- LinkState+

Only PDC (Slot Status 0x0008) was reported; LinkState+ (DLSC) stayed
latched and unhandled. This will affect the device's next hot-plug
operation, causing the state machine to become inconsistent.

The root cause is a stale cache.  Platform firmware transiently clears
HPIE in hardware and restores it shortly afterwards.  While handling the
PDC event the driver updates the slot indicators via
pciehp_set_indicators(), which issues a Slot Control read-modify-write
(pcie_do_write_cmd()).  If that read occurs while firmware has HPIE
cleared, HPIE=0 is read back and stored into ctrl->slot_ctrl.  Firmware
then restores HPIE=1 in hardware, but the cached HPIE=0 remains, so the
following DLSC interrupt is misjudged as not ours and dropped.

The hardware HPIE bit is correct in this case, so consult hardware rather
than the possibly stale cache.  To keep the fast path cheap and avoid any
behavioural change for low-power ports, only re-read Slot Control when the
cache says HPIE is disabled and the port is in D0 (accessible and
enabled).  In a lower-power state the port may be inaccessible, so the
cached value remains authoritative and the existing early return is
preserved.  Surprise removal is handled via PCI_POSSIBLE_ERROR().

This changes behaviour only in the previously broken case (D0, cached
HPIE clear but hardware HPIE set).  Poll mode, the shared-INTx early
return while suspended, and the D3hot deferral to the IRQ thread are
unchanged.

Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb44..df977d4af4056 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -628,13 +628,34 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	u16 status, events = 0;
 
 	/*
-	 * Interrupts only occur in D3hot or shallower and only if enabled
-	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
+	 * Interrupts only occur in D3hot or shallower (PCIe r4.0, sec 6.7.3.4).
 	 */
-	if (pdev->current_state == PCI_D3cold ||
-	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
+	if (pdev->current_state == PCI_D3cold)
 		return IRQ_NONE;
 
+	/*
+	 * Interrupts are only sent if enabled in the Slot Control register
+	 * (PCIe r4.0, sec 6.7.3.4).  ctrl->slot_ctrl caches that register, but
+	 * the cached Hot-Plug Interrupt Enable bit can fall transiently out of
+	 * sync with the hardware if platform firmware clears it behind the
+	 * driver's back (e.g. concurrently with a Slot Control read-modify-
+	 * write).  While the port is in D0 it is accessible, so re-read the
+	 * register from hardware before dismissing the interrupt as not ours.
+	 * In a low-power state the port may be inaccessible and the cached
+	 * value is authoritative.
+	 */
+	if (!pciehp_poll_mode && !(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE)) {
+		u16 slot_ctrl;
+
+		if (pdev->current_state != PCI_D0)
+			return IRQ_NONE;
+
+		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+		if (PCI_POSSIBLE_ERROR(slot_ctrl) ||
+		    !(slot_ctrl & PCI_EXP_SLTCTL_HPIE))
+			return IRQ_NONE;
+	}
+
 	/*
 	 * Keep the port accessible by holding a runtime PM ref on its parent.
 	 * Defer resume of the parent to the IRQ thread if it's suspended.
-- 
2.43.0


Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB8A463B6F;
	Fri, 25 Sep 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336819; cv=fail; b=jIp/eBqUhdMNMQp7TpUDNP122TnQ6hv7NyiD5a2KpIsxUWNrhuBE1itFuzelSIOdkVFYDwtnbvgpneuOJ8VrI5efsrkRXKPTrMgGJdcYvqvkzJBtKUFDh4rqQAD/T4xJLjJ2uwb7Dy6TWPRd+ersu8rtuRsrb1Owx0RdOogIc10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336819; c=relaxed/simple;
	bh=UyRbee0h3JCE8d84aBZQYXF1h3dS+Ip8+H4198kXcY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bz1ajbl99qX+j/bHqKO54Myov8OborW4VFcrBnsZ6KpQk5a11wRbVZA9vI3PozCV5/YODktjNum1LVuGShdDv3ATg7AIFKfG9Xg3L7CZK8Snks6sK5H4EJ5dP1X+qt+tLpdCF2pU0wWYNW+rweaLeREkJR/3TAEFgGasChzrZyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UwKWW1og; arc=fail smtp.client-ip=40.107.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UwKWW1og"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GseuQpbzHuVdvTH4BHDDpob4Hzc//CLaGjkpHZI4daTfw+IUiTOXrLS0ryAah67skq891mJgMjPN/LVDRNvgrMvHiAtmTn/6KOolmaqfvpWthAXck8LjJFpf2rSiENLIyAW2uggLH1UAM5sWa0X/OfzLfO3uOdgcghOM3/KgVBRb6lJZPvFiy9npteuAKYBa69ZHcwRBWKvW5RVmVqnajyGDtRtib6gptBvqnKu+urN90VfCmCVNUALyLzYnbqnMezfCw4Vv5+NaGh8mns/LFgEEaU4mnrBQAhdH4A1D+jJirLsBtk5P/U5awMYlcWJZ2yp/MRCGAAr96177Ukjorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+VyS3uP5K+d6Xb13KGZ2vP55swMRudWSLMZS8JBtgQ=;
 b=HuW88a7IybkJ0XSMJyheEuDNPn3NXOgGKu6zCnozPwyAMlfqu+l+UpgT+nV0pABzM3ltZyPgHUKtchUh9nT5SMz2Q/spJEcr+7KEY6YV48eqhONf/hAtwesFi0f0oPVpfWzNAUbYM+QHIJWcKkjwXZlXeFpPH+Q+k0IR9//3R3x0eaW6FRbpPgGVurD6H6Btta0XQ2ZoDJHMVcCUyly+CODqnFPGG/r/XAYEZTqIgFFHvnKXWRGQFSy+YJVrs1az8r5L1qemK+qzMF/qhSVX/vJh8vEnMsLlu+J7Z7I9WHMiBJTfS6A7oGIv+JfitLpmaJPc0dTv/TzxSv5MPRu+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+VyS3uP5K+d6Xb13KGZ2vP55swMRudWSLMZS8JBtgQ=;
 b=UwKWW1oglDE5fZ3AJpWDWB7L4Uw7u4QK2P/5+a/NskjrXUHqhDin/5oA3GWrebHzP0N3NH+OAPuNJE/sHa0qYnl9CUoRPCul3sljA4O0TwBd3kQxkBIBe74CgG36ukELBg2igHxNFYMii9MQkgUDjfkoPFmvXZH3CODCEvMbpeg=
Received: from BN0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:e8::13)
 by DSWPR12MB999178.namprd12.prod.outlook.com (2603:10b6:8:36f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 11:46:53 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::5f) by BN0PR04CA0038.outlook.office365.com
 (2603:10b6:408:e8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 11:46:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:46:53 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:46:51 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <qiyuzhu2@amd.com>, Lukas Wunner
	<lukas@wunner.de>
Subject: [PATCH v2] PCI: pciehp: Avoid dropping hotplug interrupts due to stale HPIE
Date: Fri, 25 Sep 2026 11:46:35 +0000
Message-ID: <20260925114635.192878-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924101929.143806-1-qiyuzhu2@amd.com>
References: <20260924101929.143806-1-qiyuzhu2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|DSWPR12MB999178:EE_
X-MS-Office365-Filtering-Correlation-Id: 58193fbf-c349-4a94-4a41-08df1afab1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|8126099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KzDi7OJ86ApTFjRXkmtheL/j+bJrxgIw7zXIukEfX040sj4bq75A6g1SsiWx/l6LLUKAbtkgZos+cND9WgdivLLNrrJAtX2O3c52qJk/8LXsHUPveFYNiGhzrv+FffYAXGdaZRKpF16spqp0nH+yjrLqX2Ic3KziQ/eLI/yV/avtCmATe+OXrvVdX1Fi9QKA4fRa38yfSnKXzmzaVPxkv0CtoegTpO6Ynmhs7k4uVmxPua9uUbbMxgUigHK3nuPH7SBWPqQNIX9IRNfehcXmxvKDfk4svss/nEukCz2rLiAWaw6fGF9g4RAWro+xGBr+OAuPvGFG6/9JqxjcjUXJFyaGscEyZFVOwDh0SPwdaDWvwbkeCgGngw8MFyxXEjPcLywoVR807n0G8cE5r2pwfP+4r1AIFnwHqxwoBuWB+c8809A4dVbh/rG+mip9GB3GM+8MDH70STiISvtKD0xSh5rjUYtuemCVYv1wLK8xPoYQqCioNkstEmAk0eS8rb0JAqCqurCb3nRKigvh9mFM9jo3btmEm/siV2NmHmSDwc5D137QvhwERVtV9arrpGtdJcgONQQM1cLvqAxBMhBJA+3uyeHANsuobAkGrKZ+cFxMBkRCOggdR5ntYniijgropPqebXCyCUQCKl7pLwE3BvHKwc4CG+p8qvHmWqwaFWHh8a84yeSQPSH4uhZhqxDtWTeCN+wVoooRt4FZ3UUJSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(8126099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oYe/+YT7/PJ+UpceMfUDraFBktII8xZ/7Stw0pdNqRr6AyldiBQlPo9k2NVB9ChAimdWgHnP+6eQHn5MOdDOLR2geokmTHMZ8xXXt+Q4XeRZaBqB9BqDS7cXnu7kzqWkyJtoa1wbqjhsLQsJdEbtRZJXHrq2sQdvWAENx8cN6gHKUzS9Ze20meWqBfx3Ixu232Yvy11kW0wj+2rqfTnWsyfYNtYQbaA1z9RFxru4i9nnhoAaC3v1X6QZ6cyZkkQcsPA6wQ0EPCUAq42rt9y+GO3qAPGpIcDD+RpkDqyjMjfwF6bxvhTQJ9k0MssA74M3XhhBrcYX22YySKdsIyJRZbGnToo2R0sNS3ctSbOqIEjbitq17GosMPT+ED8c/pPUe6OWHNuYbnnNi4kvax5hv0QqM4zqlEz+UsR/X904bihcDEoJed8p3ZNwY5ayyVEc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:46:53.7620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58193fbf-c349-4a94-4a41-08df1afab1dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999178

pciehp_isr() uses the Hot-Plug Interrupt Enable (HPIE) bit in
ctrl->slot_ctrl to reject interrupts when hotplug interrupts are
disabled.  This check is needed because hotplug can share an interrupt
with other sources, including native PME.

However, ctrl->slot_ctrl is updated from hardware on every Slot Control
Register read-modify-write.  A firmware change to HPIE can race with an
unrelated driver operation, such as an LED indicator update:

  1. The driver enables hotplug interrupts, setting both hardware HPIE
	  and the cached HPIE bit to 1.
  2. Firmware temporarily clears hardware HPIE; the cached bit remains 1.
  3. pcie_do_write_cmd() reads Slot Control for an indicator update and
	  observes HPIE=0.  Since the command's mask excludes HPIE, it
	  preserves the value read from hardware.
  4. The driver updates ctrl->slot_ctrl and writes Slot Control.  Both
	  hardware and cached HPIE are now 0, although the driver did not
	  explicitly disable hotplug interrupts.
  5. Firmware restores hardware HPIE to 1 after the driver's write,
	  but the cached bit remains 0.
  6. A subsequent hotplug interrupt reaches pciehp_isr(), which sees
	  cached HPIE=0 and returns IRQ_NONE without reading or clearing
	  Slot Status, leaving the event pending.

ctrl_lock serializes driver commands, but cannot prevent this race
because firmware does not acquire it.

Track the driver's HPIE setting separately.  Update it under ctrl_lock
only when the command's mask includes HPIE, before writing Slot Control.
Use this setting in the ISR so unrelated hardware readbacks cannot
override the driver's enable/disable state.  This adds no configuration
space accesses to the ISR and leaves the register writes and runtime PM
flow unchanged.

Wait for command completion interrupts only when the software HPIE
setting and the cached HPIE and CCIE bits are all set; otherwise poll.
Also check cmd_busy when polling to recognize completions already
consumed by the ISR.

This prevents stale-cache rejection of delivered interrupts, but does
not restore hardware interrupt delivery.  If firmware restores HPIE
before the driver's write, that write may clear it again.

Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>
---
Changes in v2:
- Replace the Slot Control re-read in the ISR with a separate software
  HPIE setting.  A parent runtime PM reference does not prevent the port
  itself from entering D3cold, so it cannot guarantee that the added
  configuration access is safe.
- Update the setting only for explicit HPIE commands, under ctrl_lock,
  using READ_ONCE()/WRITE_ONCE() for concurrent access.  Keep the early
  interrupt-disable check and the existing ISR runtime PM flow.
- Require the software setting as well as cached HPIE/CCIE for command
  completion interrupt waits.  Check cmd_busy when polling to recognize
  completions already consumed by the ISR.
- Explain the race step by step and clarify that the fix does not
  restore hardware interrupt delivery.
- Retitle the patch to describe the failure rather than the solution.

 drivers/pci/hotplug/pciehp.h     |  3 +++
 drivers/pci/hotplug/pciehp_hpc.c | 18 ++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb2..819899d04a418 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -54,6 +54,8 @@ extern int pciehp_poll_time;
  *	controller and disabled per spec recommendation (PCIe r5.0, appendix I
  *	implementation note)
  * @slot_ctrl: cached copy of the Slot Control register
+ * @hpie_enabled: driver's Hot-Plug Interrupt Enable setting, updated only
+ *	by commands that explicitly change HPIE, not by hardware readback
  * @ctrl_lock: serializes writes to the Slot Control register
  * @cmd_started: jiffies when the Slot Control register was last written;
  *	the next write is allowed 1 second later, absent a Command Completed
@@ -96,6 +98,7 @@ struct controller {
 	unsigned int inband_presence_disabled:1;
 
 	u16 slot_ctrl;				/* control register access */
+	bool hpie_enabled;
 	struct mutex ctrl_lock;
 	unsigned long cmd_started;
 	unsigned int cmd_busy:1;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb44..ab1c6da9054e1 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -89,6 +89,10 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 	u16 slot_status;
 
 	do {
+		/* The IRQ handler may have consumed the completion event. */
+		if (!ctrl->cmd_busy)
+			return 1;
+
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 		if (PCI_POSSIBLE_ERROR(slot_status)) {
 			ctrl_info(ctrl, "%s: no response from device\n",
@@ -106,7 +110,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 		msleep(10);
 		timeout -= 10;
 	} while (timeout >= 0);
-	return 0;	/* timeout */
+	return !ctrl->cmd_busy;
 }
 
 static void pcie_wait_cmd(struct controller *ctrl)
@@ -137,7 +141,8 @@ static void pcie_wait_cmd(struct controller *ctrl)
 	else
 		timeout = cmd_timeout - now;
 
-	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
+	if (READ_ONCE(ctrl->hpie_enabled) &&
+	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
 	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
 		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
 	else
@@ -179,6 +184,9 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	ctrl->cmd_busy = 1;
 	smp_mb();
 	ctrl->slot_ctrl = slot_ctrl;
+	/* Do not let unrelated read-modify-writes change the IRQ setting. */
+	if (mask & PCI_EXP_SLTCTL_HPIE)
+		WRITE_ONCE(ctrl->hpie_enabled, !!(cmd & PCI_EXP_SLTCTL_HPIE));
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
 	ctrl->cmd_started = jiffies;
 
@@ -629,10 +637,12 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	/*
 	 * Interrupts only occur in D3hot or shallower and only if enabled
-	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
+	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).  Use the
+	 * driver's HPIE setting, not a cached hardware value which may be
+	 * affected by firmware changes to Slot Control.
 	 */
 	if (pdev->current_state == PCI_D3cold ||
-	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
+	    (!READ_ONCE(ctrl->hpie_enabled) && !pciehp_poll_mode))
 		return IRQ_NONE;
 
 	/*
-- 
2.43.0


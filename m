Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798343DA2E;
	Wed, 16 Sep 2026 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592084; cv=fail; b=cAOiOJfgHr4fW3nYuks9717drRpswfSqknuuTccku4NCRYnVGFYFC9nDEhmJGSrOEzuDbov8Qi+HxRAAfkqfUthmeUbw7FKCS8pY6/gFVzopGGmzI5JgcBIw55k2y6L9j/QFrjYnfks1arG2VpAov4FwbzBfkjBJiDBNIc5gRBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592084; c=relaxed/simple;
	bh=a/nYmtGQZD5BjAOphsL1kAfLW9zOvFpBYlI557Qxydg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twZ3CisF8kYmCFnfHYPHuyGFbUYazBxHTAkZvXCvtJTfyXVsU16PdyGzewKJ4V90UzbRyHzX5bS59tCCG1WAttyZb/4q/Zl8EhcDkHtak3FOcH7zxKmDuWdEsEL9Y4iqzkMIHDy4htNfAJ9dS2E+QF6lJpa7ZOmOE3g8HVBZgSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kbY2m8Me; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kbY2m8Me"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfY1YiHCj//ZII1+r12m/EjJuwYZNKV2brW9fihqJyEufsKrf99NvjCkGAQkeVMSPtrK7iXEAYNe8qfo+bfvc3GhdZXGJ4IusPo0CwZqU3YbPKl867xbdnVsk8gfgR8rWtdPz4bjofWf1hGzLVWUAA8Au8tcuOLqRpkSe+dbVdxViowo/729TUIYic+mqP6FloFlsNG1CwetQgqAqxbWnkDIQYcMCks1MCNa5PM1lti7F+E0KXnmu9F/4VBuciNhHZ8sAI0rDuDiDJNXA8hCAwB41Z/Ti5TI/Er31FFh9k9CILksR0LyJ8pfsAx1o5YCJtVtPW/K9c3Rmu+wbfJ+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A2TsXk/kei5fwJK4HRbbFgsS4ATcOZ/Dhyvx3qbStw=;
 b=ISiu1o4Q51PNZSGLuCa5hLnaDzdAeCaXMttRKBogb4jQfNN6aVuA5GOhtYAktv3RSswga64YpPkE86cUrpDJAkLIxlTDdbtJbdMX5YYn18PNdgf11ecXGwX8I6jOsN7pyzWTlU8tcp6bk8zlSZjSeM4i9TMuC8WXPCu/OpLKJTu54C/o7fdquxjgFAvO8NjZw0sbKjOMd2qP7ag/azKTNZfL+vDopHcbmIai90pIhqXspMObkQRMqT1Ndw0gcTZcv6H72B9B+xMe1jfLOPYSghEv5ksLMTvkzIsyeQXlOg4OmyLAPylIHUwCE0qQc3mTbhvZk+/Krx0uFE8J+C1WTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A2TsXk/kei5fwJK4HRbbFgsS4ATcOZ/Dhyvx3qbStw=;
 b=kbY2m8MeDH1QLaFg7YgVJ+GcQwjhi4X4ePwaVgZd3A1cuuwgcg6X1+qhZ4hChOWkuhi9H1dhU8MMvhHRrVCv4B4Y0+emDKllOVuBrwevvKJfVI+wnxWJSJteAsoG84F+Kq4nwbxF9YKzUMMXu9msOhvljCITTixxSguaBZxcKqA=
Received: from CH5PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610:1f0::19)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 20:53:56 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::7f) by CH5PR05CA0001.outlook.office365.com
 (2603:10b6:610:1f0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 16
 Sep 2026 20:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 20:53:56 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 15:53:55 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, <linux-pm@vger.kernel.org>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, AceLan Kao
	<acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>, Eric Naim
	<dnaim@cachyos.org>
Subject: [PATCH v5 2/2] PCI: Align hibernate poweroff flow with suspend flow for bridges
Date: Wed, 16 Sep 2026 15:53:40 -0500
Message-ID: <20260916205340.2466679-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916205340.2466679-1-mario.limonciello@amd.com>
References: <20260916205340.2466679-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: ca01fa7c-83f8-4d8a-7ab5-08df14349fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|23010399003|1800799024|376014|36860700016|6133799003|18002099003|22082099003|3023799007|5023799004|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gb8GwihHrpYtU2NaRpKse3dLhRlP69SBK4KSwuv9bLccMDeDwGTCeZRyO+kFssJpXsW6WAxkBZqKGbRsFnZWJYFimyrSCxtpRCUdwERE8rVw3wlAB2a3/epFvEiIkyPPbH2tZ1zDHMtuWxZhBqAnJ40t2nifK2mqGmPxyQztRB/t7HqOczebMwaqWWPgrBM8TGjYr09/LAiXT8WWDGWbVq2qA4shFM2cq7O6Nq7Uw1jl1ntkptzuOznIdM9QcArT76yM6ZcdOB7X22DwdIKyU1+IqtVe/yaF3t3GNDbF+lEfJgN2PEW4XkfiOAMznxnKtTR0cFcVLvvKJ3rBcwXPJ0dgtVkzC/rC3W+Yf7PVSEEuJzaVpel9h2PRpJhzKWfvPpkpTGbTgyG13PjKvkv08b50f4ajNEAD2mSgiQ15MoFig9URH78ma+19e9/OI2cTk6Q2+Ip8awSVscVsgGLJobAjV892ZW/cIj1ex1XSgFQQKpsoxg/pkWBR5YssiOLZfysEAkNE+KDDD/kqeyZeaL401PWLtC0rpz5GgFVSX0TTx1OunVBp0EYR96/6uDodqvWSZUcnajcpcKmind4LAlDZM8Iuxj4dsof6KPsKXJRbT+MtyQ93AtG0ATqR+hzxnCCkfc0d2/zX/YEtpzXu+VJVadvXAkNyuFo9147U2R9QBKCfJ77BKddZY5ezN9HCs9FnyOwmDMEAw7u8yYQTWQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(18002099003)(22082099003)(3023799007)(5023799004)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qRtCk5bs4X6AgXvoqTcJ2ut8psXZZA9y1w0QEygStD8+TrnTKLDxE7YEIffFA8HhJsu1frgGtukQAQyZ9jZFBGtA994mtYY9gdP7YLJZy0WNSNeydmtiljGnt8XFa4g4ZFNPdnHOvNcF7V9gvje29N2uSyDY5n3hkr2IfkI/8BTgnKgfF35Ld/bgzIaSMldS403PKkBzaAy66LBrMPOaI+Acee18cabeprBujqLqMnmBJS6Iv1M9uIimcgFgMzonF3/m6ZnxeAgmxnI6DG3DUvBZ4XAR+DwMfxpsjhyIrUfz3iigG/hk/cbG3oJsi0Vb5+399/g9zBFIprXpBCYBCbjaoSX7AwfATjbioF1G6FDV4nEyazRKCMtxMlwsdPsGlZoapkPzQ1Jj3G4XPKwq3PadhPMyY89SYHrA1i2v4pJtHKIFxoJNwZZxqKw46MCW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 20:53:56.3455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca01fa7c-83f8-4d8a-7ab5-08df14349fef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

During S3 suspend, pci_pm_suspend_noirq() puts PCIe bridges with
downstream devices into a low-power state (D3hot or D3cold) when the
platform allows it.  The hibernate poweroff_noirq path never did this:
it only called pci_prepare_to_sleep() for devices with no subordinate,
so bridges with active children were left in D0.

On many designs the platform firmware leaves bridges alone when the
system enters S4. This prevents being able to meet various energy
certification criteria for different parts of the world, particularly
in designs with a dGPU.

Align the hibernate flow with suspend by making pci_pm_poweroff_noirq()
use pci_pm_suspend_noirq_common() instead of the open-coded
pci_prepare_to_sleep() call.  This reuses exactly the logic the S3
suspend path uses, including the skip_bus_pm handling that keeps a
bridge in D0 when a downstream device must stay in D0 (e.g. a
configured wakeup source) and the pm_suspend_no_platform() bus-PM skip.
No restore-side change is needed: the hibernation image is snapshotted
during the freeze phase, before poweroff_noirq runs, so the powered-down
bridge state is never part of the image, and resuming from it goes
through a full boot that re-enumerates and retrains the PCIe links.

Mirror the suspend_noirq guard for drivers as well: if a driver's
poweroff_noirq callback already left the device in a low-power state
without saving its configuration, skip pci_pm_suspend_noirq_common() and
go straight to the fixups, exactly as pci_pm_suspend_noirq() does.  This
avoids having the core call pci_save_state() on a device the driver has
already powered down, whose configuration space may no longer be
readable, which could otherwise corrupt the saved state used on a
poweroff abort.

Because the poweroff_noirq path now mirrors the already-shipping
suspend_noirq path and is guarded identically, bridges that must remain
in D0 are unaffected; only bridges that S3 suspend would have powered
down are now also powered down at hibernate.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Denis Benato <benato.denis96@gmail.com>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * Add a guard like suspend path has
 * Add tag for Rafael
 * Reword title
 * Clarify that not all designs leave bridges alone at S4
---
 drivers/pci/pci-driver.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8334214f8c1ed..8d293ca66a0d9 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -818,7 +818,7 @@ static void pci_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
-#if defined(CONFIG_SUSPEND)
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATE_CALLBACKS)
 /**
  * pci_pm_suspend_noirq_common - prepare a device to enter a low-power state
  * @pci_dev: pci device
@@ -862,7 +862,7 @@ static bool pci_pm_suspend_noirq_common(struct pci_dev *pci_dev)
 
 	return false;
 }
-#endif /* CONFIG_SUSPEND */
+#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATE_CALLBACKS */
 
 #ifdef CONFIG_SUSPEND
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
@@ -1217,6 +1217,8 @@ static int pci_pm_poweroff(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	pci_dev->skip_bus_pm = false;
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
@@ -1259,6 +1261,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	bool skip_bus_pm;
 
 	if (dev_pm_skip_suspend(dev))
 		return 0;
@@ -1272,16 +1275,26 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	}
 
 	if (pm->poweroff_noirq) {
+		pci_power_t prev = pci_dev->current_state;
 		int error;
 
 		error = pm->poweroff_noirq(dev);
 		suspend_report_result(dev, pm->poweroff_noirq, error);
 		if (error)
 			return error;
+
+		if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
+		    && pci_dev->current_state != PCI_UNKNOWN) {
+			pci_WARN_ONCE(pci_dev, pci_dev->current_state != prev,
+				      "PCI PM: State of device not saved by %pS\n",
+				      pm->poweroff_noirq);
+			goto Fixup;
+		}
 	}
 
-	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
-		pci_prepare_to_sleep(pci_dev);
+	skip_bus_pm = pci_pm_suspend_noirq_common(pci_dev);
+	if (skip_bus_pm)
+		goto Fixup;
 
 	/*
 	 * The reason for doing this here is the same as for the analogous code
@@ -1290,6 +1303,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
+Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
 	return 0;
-- 
2.43.0


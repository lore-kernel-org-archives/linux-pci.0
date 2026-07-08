Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822EC3AC0F4;
	Wed,  8 Jul 2026 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524432; cv=fail; b=oECbbtRfiu5tI68SCCCynX8mNgL7cO8EHYdWVcRF1mBphH7rtijkbIm6iiE+tJFOJoEiKLlJkLYOiCNZO3ChAm2S7bk3QGL2L+bAU6yY8QR/JTaa+mENqFIrLMSl9Ghss3Zzb8Df+gQHNYPHtS9arpKCqXV7ZJyplKZD4ENCjjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524432; c=relaxed/simple;
	bh=QB//qGVeHXFi2Ahaw+OQ23CiZBwJ74N9oMyvMo5FeUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aP0OG1UYzYcYDZTIUiD8smikCGmt8eAPQTzohRWUa+GN/mxJ0FikiPv/jcdhLPSDQXPfjk7+MSdUj6lxNO8Jgh7zh841fJXclh0IQy+qLjAyIvvIQVV3aNAzY/pUE5OQOA2LaL24kuoL96RswSiogIGSz/2g5X6Be3FX26edhRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gT6fI7ZO; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gT6fI7ZO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygx7jDgpOzADCWSPLygj+hkvPRTl4PlZ2VqYsz5ApfZvQAXiQoP3CDOqxxQXkurWOQD4P7dBT2YItpoIcfXXAiJx1BMx8Z12/3KUU4tua3Evz9SaafWHVp8dWiSOJrFUkrBBWh2Rc+W8wDH/AvGJNHaqZOBx2kQpbdAJu5akrNIj2y5VJ7+QlNHfO/AspmDcoascN628+d6wioSRCZzqzGTGXwmvtzrKgkWMBTxtS0juZ1WFc0UMSauhwIsQ+DUfAGB8RQl6/ftu5gpklMY6fFgZuxGkvLxnaa+jbV+ASIKsjBcfk9f+4f+wM+T7yUHRSHG8QePIPjsODcOP/IaNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJj24AjlA3JCzvYrFdCQO5CT5GlrAxr8weXXAQakw1E=;
 b=iXPvtzxQivR8gL0T+0luzzmUAZiuueQzKAcFmpHWUolUp3P3/QAjvtzZy2DFvKQ1mFweaiYg8EKjMVdd8ZvmoAG99ytjSZ5XktEa95JtJN7KQ/5ay3C5UOVMJEPMxSrfO3QlWeTWJJR0yV+sw6G/d/TSxtjARvB/S0S2p+p/pqjJRmzAag+aKlg1fXPbrVD9P2ntw5vtI19WB/dNb1v/dR14nUs5Z03SjIyvY9HqGh4Y/n6j7m347F5pJ6Q+W34ulUh3pH3pom+VF4pXJuu5qPXDwJTODPlk0HHWdsZVK/gd3YUqr9W5J6HbtIGzogBCe5SN2zH4SWzkvkuKYqK+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJj24AjlA3JCzvYrFdCQO5CT5GlrAxr8weXXAQakw1E=;
 b=gT6fI7ZO5aGEgbquscRylynUnf7zq1EJkdmI1AuHjtlsyfvlDwXsSoi8purlJrPHETSM1w1ruUDBX5rxhxjDg/U8+hoRbhBZXHRE+zJtj/U3QP2jVux9DruO/UXDMslAgRqsg6XMKjv2tqV4CyY/PwiDct7Ey6pYmPSv1qJanLs=
Received: from BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::27)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 15:27:06 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::7f) by BLAP220CA0022.outlook.office365.com
 (2603:10b6:208:32c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 15:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 15:27:05 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 10:27:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, "open list:PCI
 SUBSYSTEM" <linux-usb@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <mrh@frame.work>, <stern@rowland.harvard.edu>,
	<hannes@vonhaugwitz.com>, <jase_harley@protonmail.com>,
	<superveridical@gmail.com>, <david.c.hubbard@gmail.com>,
	<bugzilla@logical.ink>, <michal.pecio@gmail.com>
Subject: [PATCH] PCI: Apply mandatory recovery delay on return from D3cold
Date: Wed, 8 Jul 2026 10:26:50 -0500
Message-ID: <20260708152650.536604-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708152650.536604-1-mario.limonciello@amd.com>
References: <20260708152650.536604-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0918fa-d655-4423-68fb-08dedd055dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|18002099003|22082099003|13003099007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	DxVl3pDNU3de2iFdYl5o8oKiAyUKemTuY6PoqEQERsjYh4smrmeyFE4VKDtma5Yzjk7i5DBBr8IL4LT/YBz33vDAu3xVwTC9Q4iWdBkCPyUvoTqTR9X+ecvnC+QkHjW6Up7eELYjVoxJ8vYcpthvt5q9gaQ9R97U+MU+Lgty3FjBI8ZN1gBFOnNQCa6x5zXgmLNe0oDuSSEt8kFYghSxzrJQkqTp4fAfTuu/zEKAdcBodhz2bwt/nCufMsN2nebkChHJemc7lmmZXOxPSkn5HlN7FkHelSm6bbxWY2k6lMFidb43db8FvOlEq7OuEryECL6dkbzcdnZRmVUhYq3pxZEe4H6hBEUGZ5kJZ+O5mSBRglT+NQjiUdQQvdmY8obPNBsq7vFG4h+0PJBFTTtmKAKIrCy9l+c34q+qF2mFJWNbJpFogzc1JS5HHkuVPlYunoC/un4Pid61AV4leaKE8685b3Qk9Ez4i0YCVvGAT5o2D8vKPuph42x6DqPBXy9NNYG1Tul0NbXHOBg9I5mVMCzVF+iaLVErAbyoUNOUdcK85us5Y6EusbSev+aRkO5CcVaRNU3xUUTIDLp2u91xHncjLxUzk+AqWLnjzgcnvBo1GVe+fe9vGi1Kg8Z72Jpz0fLrMMnuERbrLMVTczXGB+7xUo4sNMIJLONOg0pfcJJp8dWYkOINzMzRZJh+26SQKmRF4WHUesJnn2WXQSxFgg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18002099003)(22082099003)(13003099007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	saWjGB3uP7pKeBFeRAMru1dNSw2sohcS7SD0d2r9FUVGc7gdFB1VgNHQVv4S3EOh6Ktouoqqg9zqCvDUAdNIjkwplWCKuI72TBHd4cMGsyqtwJBYoUt3iWmIJtG1UvLurZllU06JJIZS44d3YlCtqUUD5McQ4LN5wwZ3hw1xrxpWn4r8h7xWX2qhiQ11Yyr4mFipaPrioZAH8ecZC5HvoP2K6DtD51LjzTzBmFOYOftgBKT0NGPiCSgm1FwAEwnjZ+79bF7HWTXrUalZ/nN98dbcrl4dG5y3G8z8vFNreMZ1wG8ydeWtPwQ5mk+m9rmJ43s1JXXJSvivxsFVb+olQNkz3gm28LDhiXe7huomEeunVIxt8ZiNWZM4B3uZK7fFWn6D1L86b6X/Q+JT2aDWFih+4UOx3gYlQX5eil/xO/N4Owy26JmErsyq6TJzxWbo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:27:05.4149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0918fa-d655-4423-68fb-08dedd055dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756

Per the "PCI Bus Power Management Interface Specification", rev. 1.2,
sec. 5.4, there is a minimum recovery time between programming a function
from D3 to D0 and accessing it.  The spec does not limit this to D3hot; it
applies to the D3cold to D0 transition as well.

pci_power_up() only honors this delay on the D3hot branch.  When a device
returns from D3cold, platform_pci_set_power_state() has already restored
main power before PCI_PM_CTRL is read, so the state read from the register
is D0 and the transition delay block is skipped by the

	if (state == PCI_D0)
		goto end;

early return.  The register value is masked with PCI_PM_CTRL_STATE_MASK
and cannot represent D3cold, so only dev->current_state still reflects the
D3cold origin at this point.

Apply the delay based on dev->current_state, ahead of the early return, so
it takes effect on the D3cold to D0 path before the device is accessed.
Use the device's d3cold_delay, which the platform may tune via _DSM and
quirks may raise, rather than the D3hot delay.

To keep the existing D3hot callers unchanged, pci_dev_d3_sleep() now takes
the delay in milliseconds and a pci_dev_d3hot_sleep() wrapper supplies the
D3hot delay as before.

Reported-by: mrh@frame.work
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221073
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: mrh@frame.work
Cc: stern@rowland.harvard.edu
Cc: hannes@vonhaugwitz.com
Cc: jase_harley@protonmail.com
Cc: superveridical@gmail.com
Cc: david.c.hubbard@gmail.com
Cc: bugzilla@logical.ink
Cc: michal.pecio@gmail.com
---
 drivers/pci/pci.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee615..e09cfb28fe61c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -81,9 +81,8 @@ struct pci_pme_device {
  */
 #define PCIE_RESET_READY_POLL_MS 60000 /* msec */
 
-static void pci_dev_d3_sleep(struct pci_dev *dev)
+static void pci_dev_d3_sleep(unsigned int delay_ms)
 {
-	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
 	unsigned int upper;
 
 	if (delay_ms) {
@@ -94,6 +93,11 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 	}
 }
 
+static void pci_dev_d3hot_sleep(struct pci_dev *dev)
+{
+	pci_dev_d3_sleep(max(dev->d3hot_delay, pci_pm_d3hot_delay));
+}
+
 bool pci_reset_supported(struct pci_dev *dev)
 {
 	return dev->reset_methods[0] != 0;
@@ -1333,6 +1337,16 @@ int pci_power_up(struct pci_dev *dev)
 	need_restore = (state == PCI_D3hot || dev->current_state >= PCI_D3hot) &&
 			!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
 
+	/*
+	 * A device returning from D3cold has already been powered back on by
+	 * platform_pci_set_power_state() above, so PCI_PM_CTRL now reads back
+	 * as D0 and the transition delays below are skipped.  PCI PM 1.2 still
+	 * requires a minimum recovery time on the D3 to D0 transition, so apply
+	 * the device's D3cold recovery delay here before it is accessed.
+	 */
+	if (dev->current_state == PCI_D3cold)
+		pci_dev_d3_sleep(dev->d3cold_delay);
+
 	if (state == PCI_D0)
 		goto end;
 
@@ -1344,7 +1358,7 @@ int pci_power_up(struct pci_dev *dev)
 
 	/* Mandatory transition delays; see PCI PM 1.2. */
 	if (state == PCI_D3hot) {
-		pci_dev_d3_sleep(dev);
+		pci_dev_d3hot_sleep(dev);
 		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
 			ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
 					   PCIE_RESET_READY_POLL_MS);
@@ -1514,7 +1528,7 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
 
 	/* Mandatory power management transition delays; see PCI PM 1.2. */
 	if (state == PCI_D3hot)
-		pci_dev_d3_sleep(dev);
+		pci_dev_d3hot_sleep(dev);
 	else if (state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
@@ -4511,12 +4525,12 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D3hot;
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
-	pci_dev_d3_sleep(dev);
+	pci_dev_d3hot_sleep(dev);
 
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D0;
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
-	pci_dev_d3_sleep(dev);
+	pci_dev_d3hot_sleep(dev);
 
 	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
 	pci_dev_reset_iommu_done(dev);
-- 
2.43.0


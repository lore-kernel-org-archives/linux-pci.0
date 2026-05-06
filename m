Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AF2459DC
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085863; cv=fail; b=Bst/62h83KnD0/DSWl8KPOzo+QXfzhpY+7B6I5kDmfzUT9dQpGFK7lmpOZC2eGFeabfj1i0EPbd9F+/i7WMvAG77UwCGDCbPZceMuTmDU+z+ALMcwYqT3p9+rUQW5k8AHHnx0MtLqJZz1EU8XY8whpL1RynmHiO5HqYQzrOWRB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085863; c=relaxed/simple;
	bh=5gydPzGIr2pJ+BpzOzTt0yocbdi+nHaLBNCecwjYbYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DlnYwDnd11pZTjQh5HlHq3Z9VryQzKLtUnuyuJd2Tsihgh+uVz88LWiD9PJ/zRFHXaOlSIa4VmFUPxbsC6+HmMGOYELsH4D4Dr5O+++VQ29A7XqqcV8LyKFohJF/wvZYdgj3FdOb5tLgMcEnD2jpOGBhBdRpOkLwKWRg1ji+E28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=djzV6Mui; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="djzV6Mui"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCOmWs+DpqMijJckGI4TnvbpX4ckvqq+yjzVWqFRl/qEilztCOL3txtMvNdsbwt/pxxZlHRuvp+wGnlzlrpY/cU7bhz43Wufq+9ev9oRnal7V2uMaAKjyH3rI6Hr8U3M8K8vQ3NsMFI6P68KH6/gTRTwM4J5HFtjdHpEIlghbi3hsaJyrq1a3f5xgMTW8Azx52I3H4/7b3iLgK3XEy5GRrxg8IoI8RfE/LXLoiFyYoTZ0DrQdsk4cZfOTmOeyu6ZGZspAQjmBDnQDSiaIcFkMj2T7wSEY9NCEUfUNphh09xRT0Fb/qBb9ZEPDCFYLIwKqy3zTsw3BmToyVuuHlTsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m40KyCjZMrguKRNYdY0ZzEiO83V6diO9eTXOnDvtLNA=;
 b=NRar4YlKvKZpgmxDSvIK2ttsjn/9qfnQAUsE/sZJDriZbCu1CLNcMeS7LdKeIBu2Q5p1Cu83csbQJW+D9Z2TC0RV9ekPqIMh0rXuUPjYex74HhmNPOU27esOhpDvOwNRO+cKGY68gnJp2r/CIo65grl3w4ra9oCbmDAWOOLTEdk03qM31djYQAFe19z374LKfvMTolW1f8B8KqCjSZZqWTyGy7Kmabm6FdortqlxXBJ8cIkJ/XYrVjKTi6oErwbZ6OT/O9EWxQNIqvmGkz8x26hk401s3sKxFn9F2qD7vCZp6K33unIDboVl6yQiIw5vTnPXqfr/tjbH/XHSWBR8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m40KyCjZMrguKRNYdY0ZzEiO83V6diO9eTXOnDvtLNA=;
 b=djzV6Muiv2SGZspn4biKNOmaBfBTxXHB6dc4ZQIuEFGmdwhCsNI+c4QMIJc6xI1Amz8lqN9ZSl55ktffunQUqhxYhuW5ySf4uAO1KSYnwAsEvusp5KpRTh3mPTw0Bt6HPdE4805KtHjB5ln37fm6WlrExMpYfLZJ6HLghFB8Jls=
Received: from BY1P220CA0049.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::15)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 16:44:11 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::3c) by BY1P220CA0049.outlook.office365.com
 (2603:10b6:a03:59e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Wed,
 6 May 2026 16:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 16:44:10 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 11:44:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <bhelgaas@google.com>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: pciehp: Disable link and turn off slot power while removing
Date: Wed, 6 May 2026 11:43:50 -0500
Message-ID: <20260506164353.1278571-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: e40e74e4-6fcc-4ee0-6508-08deab8eb304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	14nyXlwHL5ICrSECovg+QPktkN5qnQBl+IzYiDhl5a3Vr13k/UQ7YedGKgIghMGsxLn54oFJ5ajXXALOdZJTsWllPC4jOUeK7os7AXJyt4SOy6VGByfelP9gGEF8FcrB0kAnaGF3TdzSlJZucxA6KzCdhr3IrtMrXKeuVFQWFtcYpPioY033YWtRsrkTUpHjIdw1X316KMpF+szW1EYdmX58nQKE/SgbrL2HGpYGmynaBAR6EnajhmCOA+lX9rfHdKe0hn0jUDvc7Al/4ij8tAQekFZO4rFpzY6PGC8yOE9am7UKkpw5CmDUO2a96CuZSYtVcD9vI4xE1cq4omT5whzuH+wfGxF8oczprNrrFTcErTObaAMIi7BuaSSwVTmAbgCX9K/wOWcQGc/Exwv2400x+kIqTvGvdYOv2O5bBOuCltRZuylxILYEoRKqRJRn8Gqc4cD2Ybfr1YOv5V89dAXQFcg0otNpSeVSBV/BnaqJEHdHxmP+pF4al3sSZOkGyd5YIEElCTUmIa7wMz1yJgwIwjKiKEosvWddyga2nWwThzoX1EEUn+M70DmcN5SRMxV+DNG/YYuXNehjN8b2z2JLZwyGh85ozLmhL/mrKaF7c6bHfuaQOh+aycTgij1yp7WAaCc5hHF9cu4fznCz2atrHw75QFnnwEa3gaPXL4CMghc4HiZ9rpupyeeYaTRrJSNPQqu0pZ01hP2vNnnXCeNagZHFPy0STqukx7574SA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fLUg2FQp2HyytOtuJm+RPgMPpLBYeFA+J4XIvSMIOBDRvRxcJVDDN7Ohzo1l9XMx/VOI/vr/N9itwtucUPnqFj5YEZd6ZjKqntFZvevb+a2ZdceVGC+rmgB8uZpqwXKG4Fixw2pEtknKWLDtp182pscYhuUFjzTESUIsqrTuxGjlozm39Jo1iwteozv2zU6kAc10jTDq1ygKy93iqV1MNdtvyKEK12Em++PFrRW57MNDBsxB5Cxl4SBxm6VXR3Zf8A4TUTokpleVRWXfsiQc74hLOksA6Xu4PF3esdEY3Bo8iUmd9M50yaA/CBAKhlWvm15DspjoRVZOG7zb+sh18wsIhkoBzXUcDeZxnRgLxdI4UY/auSWZaLN5e73vkrbYMHgwLG3qN9VjTeKtEOEzMzZ//PD7jt9Fu+eTKuISX+ZfvUDT5yLsXFL+4ypAy70H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:44:10.9217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e40e74e4-6fcc-4ee0-6508-08deab8eb304
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

When a hotplug slot is removed, pciehp still leaves both the slot and link
active. If a device is still physically connected, platform firmware
may continue to poll the link. On some systems with Thunderbolt 3 devices
connected this prevents the system from shutting down until the device is
disconnected.

To fix this add code to pciehp_power_off_slot() to reverse the init
sequence from pciehp_power_on_slot() (power on, then enable link becomes
disable link, then power off).

Call this cleanup when releasing the controller so the link is disabled
during driver removal.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb44..6705dcaf1ad0c 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -348,6 +348,11 @@ static int pciehp_link_enable(struct controller *ctrl)
 	return __pciehp_link_set(ctrl, true);
 }
 
+static int pciehp_link_disable(struct controller *ctrl)
+{
+	return __pciehp_link_set(ctrl, false);
+}
+
 int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 				    u8 *status)
 {
@@ -558,6 +563,12 @@ int pciehp_power_on_slot(struct controller *ctrl)
 
 void pciehp_power_off_slot(struct controller *ctrl)
 {
+	int retval;
+
+	retval = pciehp_link_disable(ctrl);
+	if (retval)
+		ctrl_err(ctrl, "%s: Can not disable the link!\n", __func__);
+
 	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
@@ -1096,6 +1107,8 @@ struct controller *pcie_init(struct pcie_device *dev)
 void pciehp_release_ctrl(struct controller *ctrl)
 {
 	cancel_delayed_work_sync(&ctrl->button_work);
+	if (POWER_CTRL(ctrl))
+		pciehp_power_off_slot(ctrl);
 	kfree(ctrl);
 }
 
-- 
2.43.0


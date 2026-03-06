Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85EC17B50A;
	Fri,  6 Mar 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789052; cv=fail; b=NvtBrdJccuBv0nWQ0cPiRBuniNwr5UiWymWtDGGALHANvKFFnf4wDlVa0KkcXHeMmWeabZJIT8LdrhvBZCXE6zDK26eOfKs4F9DzYjxMCppBNsmLvB/906dECnoqP8Xr8KS3QKuGjyIeZqrZ78j1z+U85OOvDztihS2UilrcDyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789052; c=relaxed/simple;
	bh=i+lYCD12sTfBNIkPLBPxOtq94/f6tdPFWVCVi7V3giY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IL5ErKTFjVRhzXyBOgXkuoSvh+y7Cu9GVdq8EdTffRJri4EQPw28o3LDbT14hz/2WANlnJt+9keetSb+EzNP6VMb84VxDcUoAQmST+3uDG8xqE5JU8sGrcorleJOeppAW0Seyj5Z8+6OVpjfK+9TQzAug2ciST26Yq06oNuSKIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VyY9vqlp; arc=fail smtp.client-ip=40.107.209.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VyY9vqlp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBnuiXTdS/1rC2iP91BIaPVPHwO3NU+Lu3WBw//Ylw+QDzyXeH/i6REvq8ZCROcuei6N+j+w2aKf8529CzE+pnugeixkV6q16Nh/1oTozOtDpRhP7pxNWeHaw7lI91OPxMcS/w3zaepxFGFNMBhTpZLBszp3C21cKfj9wRVqLHj6DnPJUov7S8Wzxqm2G9yOA/f88Qjhg2axc3LGNjbKVsoWfPmRk87Bmey/s/qU01zjxuNa3y9rZ6MG7zb8i09Vcxri5YdwCUb/8BMbgpTOuyiPFPjeKucosDZlHk1zURn/Kn831vSLSal6ncf00n/42TnTPErneYRBGZwYSuYhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSkIGoMsjTsI5KMR2NE7sZccN3ffl7njvXi+F0Nh0YU=;
 b=Cm03UuGOmfu69DwvjlvIQshctvg4toqhpr5IAuhDRUqIG9kVRFUjGC2KaOold51CFb6RpdkgFNV4dkiLyoXKBY+SPWoVpc3iukvqEHa3AlmTe1fAhccL2SCjxUFqm/VH8BNYlW8+4unJFcKVk0Ret4Ufgi2Y1uW0ade2GZVR6vTRLbrPa4PKYbdB/v0Yc0cRtMYUu6WPIe0nqdeWipqhnhuhVF6jQFZRH6ePCUQ65jO6+TdLgaS1ky2kULgd+VKBYt2gYrs2ifMhbNqVOXxC7kyT803HzU5hfs7RujKc3h3xF++I5KBbQBnQik27rwBcAjP/RMW9hZv4uRvRoylFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSkIGoMsjTsI5KMR2NE7sZccN3ffl7njvXi+F0Nh0YU=;
 b=VyY9vqlpjyW17aNSj28YmKdeLe0U8U2FbxxG7lT8k3ldcQtSvwj0JsuflkSuEh4DVjg87zpS2wawz0u7wp3ZadEx33WaaAQTND4Y8CEfS/HslzSbjw7MJpd3PDJoNs+kBzB+fBWtj4j5YoVh3Bimgnf89d+/+mP33QNkRRd8cwn4Kt7mj2JsgAtaP5MDeFN0skZEf7A9BIJH7CVazAt4HWerktbAn35bl6XBGlnxOJ+PvD0L8/gjXFUFkKefRcl2JHqMXo8XQHPnAWnhsqI31NEtnYRUbtLczxakvTqzBZFw4YVkZbWeKkw5WuJlLsy0sO8QydGS+wAvkyo6DhYQzA==
Received: from BN1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:408:e2::31)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 09:24:04 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::59) by BN1PR13CA0026.outlook.office365.com
 (2603:10b6:408:e2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 09:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:24:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:44 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:44 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 6 Mar 2026 01:23:42 -0800
From: <smadhavan@nvidia.com>
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Subject: [PATCH v5 2/7] PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
Date: Fri, 6 Mar 2026 09:23:17 +0000
Message-ID: <20260306092322.148765-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306092322.148765-1-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ee23d3-1832-4992-a868-08de7b621c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	MrJVdi5AScx2TEamFI31Brgj0CsULuzprR99vReVe+hK2HmQ2axvT8V7kZJwBGgG+WjgeItkYqvS6GpG9C6kFR4J4De2mZwNLet9cKzJorAbqCLb/SF5gwxchsX8nhl/zwxuNPDT4J3RNhN688miJ8pNLhdTdmUIwmGktUmyXTClVd947sP2AHEicEy6O9EUjpqnvj4kODWsLdYuN6QizrK4uo5JbnTGa+GE0moKFAZBcnffD+/6Xr6dB2VgRX152e0GHhrE9kevNWm+GwzBfGBVzvx8jvUFsWDWylfZyILVBOZU06RwprXfCDVPEOTxqKyJu29NCQJCP5cw0OwcombxR3uk+0BIAt2YTJwH6oRagGqqvNMI3bqp1T3MLQeITabpnu7x9RhoPxPGU1zdk1T/znMw+inx5akGDjFqkp/y4nmUmYMZxnvor6z9MNwMg3Ktap58we0w9AY0mXk6qYdgx5Pnkt7ayB4ztELnuwU5rY7NrS58FSBfdpMbLxp615F3aHM2N8SlxMavxhhFMkzVXsyj7lPeHzLpESfxIWgCLhRrYEhqGmoQ5OuJGip/rmDX6TUnL9RXE6t5vBgFVlC1QQ+/op5CsiAmJOJBrpyu3Wan7vXM3Qi9Ng+AWPxahikhDsQkkIfsi1la0/joVT6YmRf3BvohxcaJ/GqpiJsxpP/mlB5Yz+rkF+thlaOAsdIufga2HjmQ0xhGWlsRP2YGd8qByna5KvB8heLa/ItN4gIcAlyIWPMSF/dqOZIZozuLETu1H7hxzS7yFiSEbg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8PuvYx0PjQDfd90kycQ3RliDGy6IL6RgRlj43WtobmFJb4P2HxUw5bpBaqZUvXjWEOyOiScvxwD0tprSG1C49BtlL8bqkvrf6W2W3pLti5kbRNoKjOGjaLdV2mrfDCkXGeeqGzqSwzU8jJSNPY8tu5V9LzatP61wFD/M/iQAZfYPQ2IIIV7F390JREV5rCTjtvuztxtWikHNsYD8SNdBFhZMnBDfPELD2hrliBi3h1tLDJsLJ4P+GvCkfpeRTsTf7a7CCuvt/Fb89VeabxFsH3ckvef8Qacz6k6oUPSoDzr7Zrw4kK0HEfLDa6UC0XAzckick9fhlOFdchzbXN5rQiFawuwfJRICaCcZUz57teeA9wimTmBOnLIWI2UHdZTeefp25jTJH/uJ/I2hQGJL1Dk8TPt5Bw1BjechadM7E3kWWTsQWZPT+BwhqnEQec7y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:24:04.4887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ee23d3-1832-4992-a868-08de7b621c83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421

From: Srirangan Madhavan <smadhavan@nvidia.com>

Export pci_dev_save_and_disable() and pci_dev_restore() so that
subsystems performing non-standard reset sequences (e.g. CXL)
can reuse the PCI core standard pre/post reset lifecycle:
driver reset_prepare/reset_done callbacks, PCI config space
save/restore, and device disable/re-enable.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c   | 21 +++++++++++++++++++--
 include/linux/pci.h |  3 +++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 497720c64d6d..2ef8d7274b30 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5033,7 +5033,15 @@ void pci_dev_unlock(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_dev_unlock);

-static void pci_dev_save_and_disable(struct pci_dev *dev)
+/**
+ * pci_dev_save_and_disable - Save device state and disable it
+ * @dev: PCI device to save and disable
+ *
+ * Save the PCI configuration state, invoke the driver's reset_prepare
+ * callback (if any), and disable the device by clearing the Command register.
+ * The device lock must be held by the caller.
+ */
+void pci_dev_save_and_disable(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
@@ -5066,8 +5074,16 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 */
 	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
 }
+EXPORT_SYMBOL_GPL(pci_dev_save_and_disable);

-static void pci_dev_restore(struct pci_dev *dev)
+/**
+ * pci_dev_restore - Restore device state after reset
+ * @dev: PCI device to restore
+ *
+ * Restore the saved PCI configuration state and invoke the driver's
+ * reset_done callback (if any). The device lock must be held by the caller.
+ */
+void pci_dev_restore(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
@@ -5084,6 +5100,7 @@ static void pci_dev_restore(struct pci_dev *dev)
 	else if (dev->driver)
 		pci_warn(dev, "reset done");
 }
+EXPORT_SYMBOL_GPL(pci_dev_restore);

 /* dev->reset_methods[] is a 0-terminated list of indices into this array */
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..b229c1d93735 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2007,6 +2007,9 @@ int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
 DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))

+void pci_dev_save_and_disable(struct pci_dev *dev);
+void pci_dev_restore(struct pci_dev *dev);
+
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
  * a PCI domain is defined to be a set of PCI buses which share
--
2.43.0


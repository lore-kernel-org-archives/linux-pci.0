Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128837AA61;
	Mon, 23 Feb 2026 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887173; cv=fail; b=MAtXcyzF5TmGqtA3aNT+wrwlkfUyZqk6BT9mRcR6990lXfL+pjlzrtmihQW0amVsmmrmL360UU0Ioq/grTYJ4/3WldXV7t2rRzlc0GQSQV4bLFiDb581hHvw5JwM23VBvpq+/w7fmexO5h52SvxRlCcIlZI22wpBwYxDJntz2CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887173; c=relaxed/simple;
	bh=eFOQ9t5BULozlY/uklgQTW8eXCURqfbpNDGDpTqyTdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZ29luwwzuBHM+6VgrepYAQjaA4FdCjK9pkNsYnjBy2TNoR6oaxB0WCTZRJAfKwjf+j9QxkuoXgcrEeaq14nmsiQPmER+PsdIcgOZutCTRufcXl56unrRWRV+CBnxaD6LLeMmXhXoDPjaTIOQHEJakjz4tSIMedg9ng1oV9yDaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gGYWTE7i; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gGYWTE7i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joH8I/CH5e01wNn8aVa3W/dkTt+5WrMx2gsgVj3kEIbykJ4BDXn5qMWZL4yzA2i1bPO78KdtYIKqCXY+C8QkSWIRKU84Wl3zxWJjINpoK2BYprA2Hid5KxG5qslwkbbg1eUR6d5VFraeI45pZ5FlZiYIR71mDci6hBjpESmdXpQd+sm1bFSDiV9Kr6zc1UqQPXbQEwRDOnv3zNtWjJ+iUusdbrB11fcTtfDegqvSajjNdiiuWbt7SoGVYrllvfjfthsk/OaQ3h3IlOXlL6lp3FKdiNJQ/DeY7XEhbhl0FJo5cPu2AZA94qd4GJqlqN+TIFVXqGl6v9uwbzuFuUNxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmghuQRyC2IShLegKZaFkdRZLzD0BJdcuP0poKQz0T8=;
 b=k7ekbGesSyxz1ULTOuUeKuwVWb/PD4JMOI5rdxgmoNWkgGN1F/w5CHTmx2i6V4b5RxTCLnk2eIcYMGVDjuVjw1X2klUIDatEEIlt1cbpFU0Tx88ysjmJuwMxTsS8qUTKPW87wb/xEBMfzshOZYRfq8rduI1x8alLh0qxJ0SMEsoAwPVGRoAjsg6lr5zLCgxN36swgWi5GT6CayaeLRzEiTXOKaEpUe6jWyvQiCmApS28y3sG5ZcBIW8X3N1s0YsEo034SErxIAnOZH/K7n9io8y9NQFfuD9ySeHIl2FgeyzJujRUYf+7PPInl9jvmcBmpx83t7UHa8YX5gHGaa3AoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmghuQRyC2IShLegKZaFkdRZLzD0BJdcuP0poKQz0T8=;
 b=gGYWTE7iw2T/Ihu4L1ZlcZuJyYjMQI8V4Zz12xxhpyOki0V/Mqoelioua/J42+yQqguE6ecXwcO3AwiAR7kuWuy/yqgAPdNdmyiTOVMVZ5o3B/j48BQcbIeMPXMmYI8VxuItazaTG4el9NE1LyTMBFa0bdXGbn30V+jb3YgO5vM7l5QmvLjEJ/KjmVGoEVPsfpdP4il7GXpHy07S0P28qMNtKNQJh596vYd5sRnPXZQ3zUvgjk6OzwY8k5ncbajuLHJr/2qXOqa3zxSjHtiHmWpJ9VlTpnzV2VKUX0uVH8eI0j7KWgpmjz/udwhN4KCOyYL/6rSRmwomnR/gGbm+nQ==
Received: from SA1P222CA0123.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::10)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 22:52:47 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::b7) by SA1P222CA0123.outlook.office365.com
 (2603:10b6:806:3c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 22:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 22:52:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 14:52:31 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 14:52:31 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 14:52:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 2/3] PCI: Allow ATS to be always on for pre-CXL devices
Date: Mon, 23 Feb 2026 14:52:21 -0800
Message-ID: <7f286263987e8bf9d2a094799dbb1496e8dd67d2.1771886695.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771886695.git.nicolinc@nvidia.com>
References: <cover.1771886695.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 9622c2ea-3625-49c6-5b24-08de732e4336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZPFRZ6E+GSnG7bzmURTv9M8ypdGA45p6HYQ/VamD7bDN1i+TJGZUWGOOeRhe?=
 =?us-ascii?Q?hzeAcEReCaxc+L76/iGZEX3sVwea44+3u6Lq6cy8GJc01t2zNc/sourTQos9?=
 =?us-ascii?Q?3QhmkS4xsxvPO34bJlmucA+oq4WkA6MjWH/pj8qxfnMwfr1xKy1ZMtDA2FvR?=
 =?us-ascii?Q?+3fZeJQ5vY7PQ0W7v0uQLUdjiJcoc384CXAw388HmCVX4VXrXp88A94ic5eG?=
 =?us-ascii?Q?VNNRXkTqbdPQASD7+H3yfJv7bvKNvNE6Tc5XnyYAnwJx5oymObLkHrHhoIuC?=
 =?us-ascii?Q?Pzi7OSp1lbJy6oZLWrpCK38qjIQVxL6zjnog7MCcfdw8mKpXivqxiQNVUMEm?=
 =?us-ascii?Q?g3w4gMpM2/hC6zfJEyRFOSnU65Czd83tgsahKN/0xujBQ0/vaWCzrVOAHIUu?=
 =?us-ascii?Q?bQnNEo21jcV7FxDu3Ua48EGGafY3JbS3hxwmw3OAvfVyFmVMPYfUmA1yzwra?=
 =?us-ascii?Q?68krnx7B0F8bGkDPHbODaHcEmcLzjeMQG5DbSr5YnaHhjBLO0lJ4JWg0rPQr?=
 =?us-ascii?Q?jLMoCbXAuYuu4cvqhxUC+nKs/VtJUDBGQ1rILKHzE7L1xHx7dPNVC7pH8mpF?=
 =?us-ascii?Q?z5TYVES5niXHriwLY2CoiuUZDabqD2EUTewrfby3QhvP5lr3rRFyx+/xDBGN?=
 =?us-ascii?Q?qHee8xNkHuTHv5vLYbFOeSB80bUfecGUPXz4aMgiXx3OUnbUEFmZi5yFu6Yn?=
 =?us-ascii?Q?+urPfclB/ZX9jNC/5hhETMKUVdtEAP0gvYAnwj7oeU8NysE3wgPjrJq/GItx?=
 =?us-ascii?Q?372z6jYH1RAtC0q2yAT1/4X+OnHMYSzlvjLmwnklvjH0jQ0vH9BQFzRlE0VD?=
 =?us-ascii?Q?lCo6wm8+hpiHJ9MRMeJRJQ1nixuvQM3ahlkJPUdxUhsC4x7GSaKGH9ysPAvF?=
 =?us-ascii?Q?rWmVz4LzOnmvfpJoHPrD7HPTRU2V7pMIdq71bnqfBadAj3Ro1hbn5M545PIT?=
 =?us-ascii?Q?S9W+TXUNpsL1/rdfFt/SROopW1k/EsAaIYekT+8NNSmul2H06Uqr1k8bV/ok?=
 =?us-ascii?Q?vgGRXq7G9xhFcXO6FJ58UyGtCSZKD4x/Fxx8OF034eNLbnuFF7HDw/i8Pyu4?=
 =?us-ascii?Q?qEZyunPFwAvtOAb5ziv0wo9pjZRh1ZHn3Q9+QdhpJS/U9X7vLAsZqyaoHZU+?=
 =?us-ascii?Q?TI8uHhZxjkhN5ttRO8rqbhZh9maA4ookkNmlZoPyjWd/8Jwp84DvZiY2sjLe?=
 =?us-ascii?Q?A2MuUzn+UTBAwiJ9uUfVZSjW8T1ynoh9JfzB279OBzh7QSapeuIgzseCcHQ+?=
 =?us-ascii?Q?6ILZCV3v4wo815XAwN0fkE12Y8QMkrw42yPPXIYA/ihNc5rN3cgzlJHQRiQm?=
 =?us-ascii?Q?1wnGDGRxva7nEyepPtwqEA4GIJXpxvGZTjv8bNVl0cXk7q1QeT2avLKAX+zY?=
 =?us-ascii?Q?qpxbz6wmSiO+GqqJi9USkjqJ8Qo/xDC3DO1+6dcSOgxu1RwquElWOZQ2qPTP?=
 =?us-ascii?Q?0Pdg7jfP0OcqRXJgCp68pkzEFVwyPTKEuP9Tcq0aFWpv8z1TbZhzVtUJs6rx?=
 =?us-ascii?Q?BMfmz7sAl2cptWBxOUvqAkX49nczMi/iTUneE98OJAA6jo46/TQWr4HtE0zT?=
 =?us-ascii?Q?9QITYkm3BMxgDAWFdS4I/GizfYCTCUoq7YuULjyFYMqqIiErpe0JjOtz6XI7?=
 =?us-ascii?Q?4NKplaQE0XgMRs8f/YOglUUqg64zTiwgw20xDctEPA/PhUdBOV8sLjVgNUPI?=
 =?us-ascii?Q?SxpmIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OFIWCN9J9CuKa+Q26JkdIxXIMuGxiztOjuoEJojgoQAyGG/jcEa8vUnquPD7gaEZzApSqiFim0MTCft5YBkYdoaYMRWyDmFGdoCHii6KReReauE7MxgbJ04qGHyoFiZ9SmhlCEgc8syBOWD3u+g9a0MppoFCfxsNWIguINYms2NnKSCnH0ognarP85Q9YmLAlSDoVHxofP7mLQY+OJiJGnFgtZLkwjlFEHwfqFHuYyg8Ntz3CW8DAopHVk+q1O9odOKuuvC83paHrdAh+4BrIneP/yllh3o1mYWj7ok59IJq9EM069iJjdfoZjMnCXyd9Pbge0p6x3mILXXDn/Snk9fGRraRF9pCymebctu3rzpwI9ffXkgzJkg0amwOeE/qNMU/zELgYUIOd8A2VYeJyfT1NbDAYsS5k277R+mPtA0S7l8EreSSarriJCzx7c8P
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 22:52:46.4897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9622c2ea-3625-49c6-5b24-08de732e4336
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507

Some NVIDIA GPU/NIC devices, although don't implement the CXL config space,
they have many CXL-like properties. Call this kind "pre-CXL".

Similar to CXL.cache capaiblity, these pre-CXL devices also require the ATS
function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.

Introduce pci_dev_specific_ats_always_on() quirk function to scan a list of
IDs for these device. Then, include it pci_ats_always_on().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.h    |  9 +++++++++
 drivers/pci/ats.c    |  3 ++-
 drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce6..13fa71f965900 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1150,6 +1150,15 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 }
 #endif
 
+#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_PCI_ATS)
+bool pci_dev_specific_ats_always_on(struct pci_dev *dev);
+#else
+static inline bool pci_dev_specific_ats_always_on(struct pci_dev *dev)
+{
+	return false;
+}
+#endif
+
 #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
 int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 			  struct resource *res);
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 93060fdc0d3c0..ae3152be018a7 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -245,7 +245,8 @@ bool pci_ats_always_on(struct pci_dev *pdev)
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
-	return pci_cxl_ats_always_on(pdev);
+	return pci_cxl_ats_always_on(pdev) ||
+	       pci_dev_specific_ats_always_on(pdev);
 }
 EXPORT_SYMBOL_GPL(pci_ats_always_on);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be72..21451e62f284e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5714,6 +5714,32 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
+
+static const struct pci_dev_ats_always_on {
+	u16 vendor;
+	u16 device;
+} pci_dev_ats_always_on[] = {
+	/* NVIDIA GPUs */
+	{ PCI_VENDOR_ID_NVIDIA, 0x2e12, },
+	{ PCI_VENDOR_ID_NVIDIA, 0x2e2a, },
+	{ PCI_VENDOR_ID_NVIDIA, 0x2e2b, },
+	/* NVIDIA CX10 Family NVlink-C2C */
+	{ PCI_VENDOR_ID_MELLANOX, 0x2101, },
+	{ 0 }
+};
+
+/* Some pre-CXL devices require ATS on the RID when it is IOMMU-bypassed */
+bool pci_dev_specific_ats_always_on(struct pci_dev *pdev)
+{
+	const struct pci_dev_ats_always_on *i;
+
+	for (i = pci_dev_ats_always_on; i->vendor; i++) {
+		if (i->vendor == pdev->vendor && i->device == pdev->device)
+			return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.43.0


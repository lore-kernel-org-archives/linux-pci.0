Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407D27AC45;
	Tue, 20 Jan 2026 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948026; cv=fail; b=inUkWK6MdHmfk6qYRu7gGPtKLHeicPb9FvxoPdKz5LwGbqjJkYa3OSF6PVJKLfTLNtJ4A647kr4+s2AKhKLksxJ/Tw59j9k4wH4DKmeK714h8zCNzJO5EgYHWBYs+mpC7IBOuuF4hIMKvByFeIEcTjNCCIJuEHJ15ScIeHnhw8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948026; c=relaxed/simple;
	bh=wNwy/iDYpLI67nIE/7ciZ2+5pbbFcvQkHnPawSU6Ak8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbP6PoAszzXt2dLQFO2qTgcrR7KXHd+vN97JtbcKHo1Hw/FF7Ilp+IzMpeG0/gTYEGUabDjXk9EpXGHWY5Hjufpi/vb6zUfEnkMl1BAx09W2VrZh0UT1t61cg7te2utQn/3tRjY7VYNV1VEFH9HRaUqyiEdY6nxmCv4Ee/izGdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AWlJssxc; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AWlJssxc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moiXn9/hgQGrl3bIjyxl0KXAmt+FMVrE0YxQHFSxfkoLjCMVh3N0rDn7MuqRnEWDVLrKKxc2hDi8JiM0OeSkxUZ9Sh/tJP8NBEbqlTgibGZ/BXaIFGAvpb7Gbx+Tj+MMX/TZiTKL+JEI7aCRp+vV1944XWzoHHrfSA/+07ZOgqBV1CzRZjGDbw6wCc5ttgAuZvpGiVmlMFFgKndSZaZCkTs30KSqumg+6/hWo2wdsnb3wqcOC730BNvqmygDo7LbNE6I3QdnkTXnX5BAnW2HHRUeihhkZSC6uGypE/2NhrUm6vz4E+W0StNd4REnMZ5m4EPmOrwu8mqXsdfpT2YCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK9pyhReHnf2LilWzFZoN2t8qlR1+qa2xYqcAXlDBGg=;
 b=YiZ0gDKy6TCccziXlaUl7E+agcMuSmE7XCY9mMLl3JD/xSWJjzgeWVBFdZE5+MO3MZmo2a9DfaUoAe1ruslr23yLxss8agSgAYjs6lfLGg4sg9tx/5F4TpFdd51gOtnIV3/5eiU7eJaFBwWY+7gLIZQ5K7v8OrizgunOn4Zd4z8OQiwRiRA/+2zkjXdbpZ7YUZvfjAAjXV1tTJBoKadLeM5pxmoKnPagxYHm03pWE3tglE/q96vclb2BplV+56XBraBotH1nB+JmEJokNPR68n9lZ4HgN2YM+RDXgDvNyWUweAmEWysHJCaq0zhl+dC64TTEAMf9WOAkMpRhO/DSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK9pyhReHnf2LilWzFZoN2t8qlR1+qa2xYqcAXlDBGg=;
 b=AWlJssxcN3Pnrn+ko8nYezxeyPr/qeOkv5D9nN2jNJe8NdEGLbWqr/lCz+URzdv/qJ6XDsPMvX0EVKZQjjCXYXBfnat6Ue/uMxlkXFG+k6C0w0GkdGNWBDBBaDAljcf1m88D+S7cQFYfy88Xjl5EvPYNaK6rnoOD2XgNTKrzbYnVw70fEP6qrVE/AiE4LREsjW7nYevgPCPJ1rhxR4/k9uGYkNIFNiXtksK+4J9tGi9lR3TBrKA2tD2crNZ++dmvqLCeCawmIAmv9s9eDL3w4gd8iosPGQYHsYY+aizWKejSfddnKesSG0NN42ZPxJOgNWCh6oPs7ijY1HPS9K/x8A==
Received: from MW4PR04CA0327.namprd04.prod.outlook.com (2603:10b6:303:82::32)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 22:26:49 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::2a) by MW4PR04CA0327.outlook.office365.com
 (2603:10b6:303:82::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 22:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 22:26:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:24 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:23 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v4 03/10] cxl: add type 2 helper and reset DVSEC bits
Date: Tue, 20 Jan 2026 22:26:03 +0000
Message-ID: <20260120222610.2227109-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120222610.2227109-1-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 195f30ac-5a24-44d2-9edb-08de5872fffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eVLPhOPQFN9O10MTxxUl1mgPBDBac1EH4DIMn4DvYtg0VTRG7oc4MJMRaBUg?=
 =?us-ascii?Q?5647dKTzZjt1ZUYJJoeCwPS1uWtIzytWt6vuYjOI50Fs7HLfsKyuLP9v8mWu?=
 =?us-ascii?Q?h3cvMoJJovM22DDtnnAgn/pSiYWygNmvPsck+QJJSXXP9oapf4xqobn1WMvE?=
 =?us-ascii?Q?RCAD3w0hd52ZU/ro2JvJqgT+5bb0lEbnKo+ilTl69kOTzO+dSVY1Xa7h8FWF?=
 =?us-ascii?Q?vl7qnbRDUd9a+K2lNbWdY/VKmaJPGi4UZ8z+2mCXIvgWdSbPWaW7uEEifpgf?=
 =?us-ascii?Q?Vp6DKbI4QJ9dn4wOA1yAYpJXiJKLd1EGJ5OIqXAMCsUiR65lF8HhZAwjcoZe?=
 =?us-ascii?Q?TkrTIZMdR+npUK2uI3pj8DMzAOUcRp99Vb9gyTIRMQ9Zw3CHruyJoXfOuffl?=
 =?us-ascii?Q?ZGjfAUScoHBFlCrpeFTYS09BRFXI4tmoWRpoUvweTVf6YNjYeJq3/Wrad3Kv?=
 =?us-ascii?Q?m+ZmSOa19DLQGxT8wqFr01Xjcqp2+zpIIMlioOGTR/P2wiNRhYOn1Wyd5CgW?=
 =?us-ascii?Q?7SdHbF0LSjrYGCuv6CPWHs6LY27I9/rlYOskHlzzGsoLy01dyIBHSHjefrBu?=
 =?us-ascii?Q?nBwPcefIfFUuV7OtBYTsUhPWNkRNcy2E60tfeW3kTQ2BrQgxnYxWGLCGWEuK?=
 =?us-ascii?Q?/a+5NEErLsozHEU1e+3EvqiJ9buhoPieI225RkM8fBrFrGuzYd0SL1xWVzvP?=
 =?us-ascii?Q?y66IhugyqubPHhZ+8yqyKwRE8mF5G8yGt8cufjaaf3ezwVGcgvtLl/YG6c3r?=
 =?us-ascii?Q?A+WT105TOUFetBLoVbs9TARtCwpXEZ/F8/XedwxhPt4GJGWMynv2C/i6y12Z?=
 =?us-ascii?Q?BHkxP5XjCPbdIZuXVAxgqK3h5AbK8Az0a3dJLl4m54q53Fcghf1N2KPslrUP?=
 =?us-ascii?Q?Q/YVV0Fb8EaajDg2g/GkmNIYb6ZWHwQZO9qGQMtW3w4BCbys/gAxa6PA0q8A?=
 =?us-ascii?Q?I2+4hdvwWAHz1ozSVte/KMUOiR6stdYnp3BXVEv1UCV7aFhEQTl2+pR7iDGg?=
 =?us-ascii?Q?QKqFtZFIPIu/nz041H1b0GUOJZN9nXMb1YttvWI7vr4Y2XlYHUhgT6i/uDfh?=
 =?us-ascii?Q?+UJ976/adn3KOPhz6cJlHJ0p6UNFujZIbVJ5q1JxBXy3WuS1eqbxZHstaxmo?=
 =?us-ascii?Q?eD8t4OZkh8beGM83UHu8PnT22Bow+tbZ8ev8H8vjdcCeDiPTAmvLKWtVqE8T?=
 =?us-ascii?Q?8BLiON8wNExwFGWttO78kPIDp8lAeWM3PQILdFKQt5pgGyRCmCd3rCfrVqHr?=
 =?us-ascii?Q?hpEOr33PzAfNIfysVsvEgq4lcO1ES78JFMnW18aac85Nk639fNEf4e1ZLqQU?=
 =?us-ascii?Q?IPEmCX1Iux2GluBA9xfZ6bQWajGiy95yrDFhN9gksNDSsH00LBL6+LJ+k34R?=
 =?us-ascii?Q?55zCdT4iWZ5uS5khwCX43zd+ziauEeVGesgYSZNL7avKlqcKqI9vSxh9xwHe?=
 =?us-ascii?Q?j2RL6ZaMkC8MctJIH25SHtUV438B2X31Hi9OxzfELqcFbBx+m/wf6+JdFAnc?=
 =?us-ascii?Q?aYaycSo8HBKIAKLAvSD787YkQTSnaN3zvRsWuAkGcJZR360exbE0AXR3aBeY?=
 =?us-ascii?Q?WMIZniZv/w+HrpiSV8NTifyz3rax2U6aSLsKY6++68YB7brLa9UwdNSjmQCC?=
 =?us-ascii?Q?ZJ9CjzxRG4/a4Pt2f3xoIfO2PF+yK6QxwmKecvjPBtTJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:26:47.6469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195f30ac-5a24-44d2-9edb-08de5872fffe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419

From: Srirangan Madhavan <smadhavan@nvidia.com>

Introduce a helper to identify CXL Type 2 devices and define the DVSEC
reset/cache control bits used by the reset flow.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/pci.c | 10 ++++++++++
 include/cxl/pci.h | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 55c767df4543..b562e607ec46 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1075,6 +1075,16 @@ static pci_ers_result_t cxl_slot_reset(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_RECOVERED;
 }

+bool cxl_is_type2_device(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+	if (!cxlds)
+		return false;
+
+	return cxlds->type == CXL_DEVTYPE_DEVMEM;
+}
+
 static void cxl_error_resume(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 728ba0cdd289..71d8de5de948 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -14,10 +14,24 @@
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 #define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_CACHE_CAPABLE	BIT(0)
 #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
 #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define     CXL_DVSEC_CACHE_WBI_CAPABLE	BIT(6)
+#define     CXL_DVSEC_CXL_RST_CAPABLE	BIT(7)
+#define     CXL_DVSEC_CXL_RST_TIMEOUT_MASK	GENMASK(10, 8)
+#define     CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE	BIT(11)
 #define   CXL_DVSEC_CTRL_OFFSET		0xC
 #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_CTRL2_OFFSET	0x10
+#define     CXL_DVSEC_DISABLE_CACHING	BIT(0)
+#define     CXL_DVSEC_INIT_CACHE_WBI	BIT(1)
+#define     CXL_DVSEC_INIT_CXL_RESET	BIT(2)
+#define     CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE	BIT(3)
+#define   CXL_DVSEC_STATUS2_OFFSET	0x12
+#define     CXL_DVSEC_CACHE_INVALID	BIT(0)
+#define     CXL_DVSEC_CXL_RST_COMPLETE	BIT(1)
+#define     CXL_DVSEC_CXL_RESET_ERR	BIT(2)
 #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
 #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
 #define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
--
2.34.1


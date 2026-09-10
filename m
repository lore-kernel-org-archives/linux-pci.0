Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658D3CEB84;
	Thu, 10 Sep 2026 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024135; cv=fail; b=RtbRmUoQAWgFJRinYb91gLZKn0EYdZtcdqkp6du+O2nvobxnnlewGPa79zLP1FWv1Qtcht9vsrW1TBMesnEWYHezO2BQ+HHc+G/hE0xZL+7HXAAsfJbjSpG9JdWwJWgyPFrK6StSjDJK3fXIzBm+awW+K/DLfdQj0a9zqbZ7ZlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024135; c=relaxed/simple;
	bh=R2ARSFtm/Vo3tl4epYJyxrFCZdSbYgO47gm20p48DoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKjbZFlSot3bm37WINtaozPJztDhzxdMjosP7S5bNQJPxoRkUnW7qnd3W4X/DA9R518RtPZDe5U0n3TaRDlfw8ByKmzeQXFu+lB8KILmwkYNw3/IKOJotc1NVNm89tUq8nlvMRShpyzUvhlsSblTM2SDZXXI968zpFejYA60wEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CGLO/s9v; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CGLO/s9v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWkdLVMlTJwPbxkjGG8N1eHmfFs/IWufMAyn+5h+k/5/jqQ6aUIhT5wmSBgLU7H2syCNY2DTjrTHzDIuObRZ5RGG3ee6sBBGBgTa5dMUx99D4BGwK2QA8YPQnPSkP0s0TVwpcmM4eSBEMGgmA9mavhgDTwaIa410zVKVwDKdGeoauuh/pGO6yFtU5bX2+Hcnk6pTx5PElhsx6scozNIU3h9cpol5Y02xbuVAUSY7XwhwYlOb5hfpvPmWdpL5dkMAzKqcQmikRGMgFehCOe+SqiP0pOXyNbGU3FsUbJvTFjlEWlKEau5tFNAJmM8lJAqsVW98dnS9cbqOXiAhESWmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p3cH6fcTyF964EabAxgpkDiI1ncpddCk7U8fXwAG1I=;
 b=g11vPmQmFaMtWAmM6d868CTzIJ5hybixgZV/UorzEB9rcfUwAigbWIMq3SONEGsfmqdgQAw0/p+FeT08aULAAv5Fe+aWrpERC0EIqzhbs5Mpss5cyDD5lvW9aJkHmylpcE62pO7+KhWg3PdYq75dfcpsEo1+mVLiPqZokSpZcMtiaGp86U94lxv+EX8kBOvsRiVB1WZojpMWEPpG+Q3q2N5b6alsjsUaMVEz0Rs7Id5WbcHgc+ARoy157HtSYzCqkghJGgvxiBMuUD/AE2Ah7BSVYJgTQ2tyB3EFkB4S9xNdbYWanjcHOPBs3izqOdt+8HzI80h2A83YuiEHuoavcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p3cH6fcTyF964EabAxgpkDiI1ncpddCk7U8fXwAG1I=;
 b=CGLO/s9v3xfQFa+rFZNdWyoSOfXnKHLLTq4m4gCv0KVfbMyMxZ6kHXJGKHSMMHtDmnEdwrCa9pd9WhTvXrkDxzNB3SBuv0B+hm9sPq9bVu50Ez91VIsYbWbn3Bi+1k/2QWhzTwNR+OfAFDbQUvP1uS3WFv8fYGIodOwOw2Ky2P5JhG6p+it8YpePpmGcOsGZkriFnzL9q5ATE+pWOfJd3zsJ06/3ywh8fgdiMPq0Y7S5MV5bkOIXoMwotaocikJv3O23vm7l8lHm9/AQLVW3ZdB/N63iXVwviUUris01vdaRnA7m74i4MhIOqOgT1kk8YifoNZVAQ0K/PYIXMRV7Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:31 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:30 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v12 06/12] cxl: Add CXL Device Reset helper
Date: Thu, 10 Sep 2026 07:08:02 +0000
Message-ID: <20260910070808.1444264-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 49564bea-f9f8-45cd-9a8c-08df0f0a51db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|5023799004|56012099006|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	eEm4itMa7dtDS6Az1SSYin2iIMcTCjhBk+XPs7ubqTgyv320bJWM/dKDNmcy61NACSTTLATM87F7EzilL5/eCRlCLgvEF/irpGNmTdM0b73+p8A8tskXQflkR3IAe68UDJwR47gQdSKHQ3oUQc5CmNhSYo9XoHsyS+zBh4segGyyoOEHXXOROPePMYB9Qzk5eBrJn0eL5z3jwnLBWRCjWpC00ixvVszALupi6I9eynp7PKIag2YolynvARTI8aC1pIez/bAc8Tr3kiFXP09STNzHNFIUxOMZnuDS0ahVhpc8pkFF3fGUD68OXHhgWxCL5Hvd8NEZ5fjz2W0rWm1P6huCZbhuzNP50s4niM0SXXxy8oc7ikAxJk3TZbPSTmqELcTFM/k3wHeYrmOPeeXC8t4v0zJ/cwr+KN4raFMyiDiIWAgO+N2ypZDWpcE2nNbrcR1n7kvAhxMPOugyMPDGIp87ZlBa6o6BaaRsF66SJb6bSzn2mUT4gJVBc3UGcZFdSP0x6uDz6owJkHbTiYUe0Ngz3H2llaQPZf4L6/MKcbKKAjI1/C7RxAkLq2+PG5cD1g2Pqdn6n+yTKL9p6/6SLspmI+Z9wuXFm3Hhmk/oHm4fhzoQaMNk8x2+ZaT/rlTpcMpyDTJ0CaCW/vd2TJsQPd0gew2kWvR65Sj4xg57DXy8wGqWzxnEI5G9etnbgeVCujbVl4wW7/CIHT2GMcJY6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9OYCkDUFtR0Axw1VWVdew7sO3BHASuqLynSItkYutWaTJ+N22/CM1+pjXim6?=
 =?us-ascii?Q?yMCS4yQht9MpxDeQffHG3VAuBaD+gHxAhwRwF3NpjCRzfXPZ5VQccUMVTlbZ?=
 =?us-ascii?Q?H1bxx6J7/gzZhNAqr2QqYi3Bd41pXeAmR2lU1fBFpTcfL+d6eDPbPUqxBz1r?=
 =?us-ascii?Q?GK7cy951bY860Cw3HiS1ONMIBIRwY4mxcfw0o4XVXiWqZH7tliVGj69uonD9?=
 =?us-ascii?Q?9cZbO+nfrYUBQocJQXazoowpFG8hiXkVjWXGGxDBLneNhS8SyUkiKRphu8en?=
 =?us-ascii?Q?0qgdLY/GLjelyQ+7SHwpxALZrQmyUJfzZBmapTC4YifcTxphTtmn/kcK4RsG?=
 =?us-ascii?Q?6QTkfV1YcmT4bV08vydkB3YKGiEDakxSX//D/ilxmufTdqqrvPrD3yXd44Xb?=
 =?us-ascii?Q?1p7Vho3BD/frx5LGxMJHMGTlVwLmIKxs1LVrkgZxAfic0Aj+abmq3Hs9tebs?=
 =?us-ascii?Q?Wav8MMz5hM+DKbkjkjXhusMU/iqOAUDOL3PLvCtJtDmSO0R8s7y7pa3s722U?=
 =?us-ascii?Q?EQe2VW3bBZEa12yiP5RNIN9Wg4/KGDDtYvT6YgR3NEgdtou2JRzhbpEG3ZjQ?=
 =?us-ascii?Q?VxxXBUWgQZuwObFwgQAnKXyf4atFXyE1FZUakuc26aAbAbMSOrz/CyAE1l8Y?=
 =?us-ascii?Q?ZDpldObV4t45p81xdAcaEj1bze6PfN+pUwfykz9xBj8dwW17UKmxVQ89y2Vv?=
 =?us-ascii?Q?Hh/4gZZ9i8AY2FmMzfGbadjTSYtv9gSFvMzBZAPjl7oKUWEEyII8aQkC5kGX?=
 =?us-ascii?Q?lQ9X0KgSmM8J22GwfQWk3cDebLG/lCHaiE2Ho5RQNRPrrjnsGKNSbOrscI7e?=
 =?us-ascii?Q?IxWm7Ew4tK7Ndqe1iRLK5fPm99oPIoSbxot5bSnvRI9B+2nYS7ioFhWQQBTu?=
 =?us-ascii?Q?CpqlF7f5FXuAWxQWKUGBC1WjOobXOQeVXkpPL6/Z2FSykheRvaw8bBeO2uON?=
 =?us-ascii?Q?YxMTd7d1sSQlbxgH7AqIqYOUi/rDFFzDy3TDoIoq7VB/z5jb9VlCE5qrsjZH?=
 =?us-ascii?Q?trWJUQsWUX/MOO29ij6sEQBR5KsiF+QH1v5r4X5iwFuRp+BpGpBss1ull+0g?=
 =?us-ascii?Q?TfaqwvvnksICVsH9S3QXWhFVTQkjsusNdQniaziXr3a8IH2kvyeQqSLg17np?=
 =?us-ascii?Q?Pqky9+wypQhw8ifWOW5SEnHwJnS5Kj6MZmgOlXlN1udy2ti0+jSNRI6ooiZx?=
 =?us-ascii?Q?LQihjqWIt+/n00iDdpPEjCZw4uCeIE12l5nLExJBhnALEiBVMHe+mnkgfYB6?=
 =?us-ascii?Q?i2X4qYF7p0OXJphi603sW3I0W0VmGQvgNM429xd7yAwWmEwjF3EsIwCH6EdR?=
 =?us-ascii?Q?XNxQSVVMki5YyMzxNvRXt+89KbwQMok4diZoEN8kST7DF1c4z49avcN891zu?=
 =?us-ascii?Q?k1yxafj5vjUDIWxS4eEhu3vBNQ5M5+IpdRzDH0CZk7h8mmk+h8NLJDTXyjYy?=
 =?us-ascii?Q?TqxdLylUkH8Z1UM2JeKfl3OwP4kn1rHoHXEpDrY6FWWPbc5ZErJaAhnf8zEO?=
 =?us-ascii?Q?VGaWUFsc94Tn6w+MFVG+8EEFDDcIE5lqRuO8jB1w0wIxDiYnzyrcMujWb5Im?=
 =?us-ascii?Q?U4E6B8tK2EYnPnMLEgTDLUHZnE2dTCGXq4dEshoNfLAXqT3tOLIrbfjAda7b?=
 =?us-ascii?Q?NkaZ2BI1Lgf59vZZgSxa6lCDMLBvwZsQX1no34tDZ/rKagAUOEH22Y6nYuMI?=
 =?us-ascii?Q?KQOQBrCxEEV2h28ZFHK5zxgMS+Z4P5NKs0kPeWcQkyuAGqxdA0ZIFzd0ImKV?=
 =?us-ascii?Q?zNX3Qih6Tg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49564bea-f9f8-45cd-9a8c-08df0f0a51db
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:30.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41PjlKv7UvkA0RXkGR+owKOQ3UQBtuKr3gnrsZw74I142sqYhbNJKDy0LpeJ7EAL+OMfOnrr+1A203y2l+CEcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Add an internal CXL Device Reset helper for Type 2 functions that
advertise CXL Reset and CXL Reset Memory Clear in the CXL Device DVSEC.
The helper disables CXL.cache, performs cache writeback when supported,
initiates reset with Memory Clear enabled, waits for completion, and
re-enables CXL.cache on exit.

Leave the helper unregistered until range validation and reset-scope
validation are in place.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c   | 251 ++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h             |   7 +
 include/uapi/linux/pci_regs.h |  14 ++
 3 files changed, 272 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 6d9f8fe14b16..9c1aa0800521 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -8,6 +8,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -492,3 +494,252 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
 	if (rc && rc != -ENOTTY && rc != -ENODEV)
 		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
 }
+/*
+ * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
+ * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
+ * initiating CXL Reset, then limits software to CXL Status2 access until
+ * reset completion, timeout, or error.
+ */
+#define CXL_RESET_RRS_WAIT_MS 100
+#define CXL_RESET_STATUS_POLL_MS 20
+static const u32 cxl_reset_timeout_ms[] = {
+	10, 100, 1000, 10000, 100000,
+};
+
+#define CXL_CACHE_WBI_TIMEOUT_US 100000
+#define CXL_CACHE_WBI_POLL_US 100
+
+static int cxl_reset_get_dvsec(struct pci_dev *pdev, u16 *cap_out)
+{
+	int dvsec, rc;
+	u16 cap, ctrl;
+
+	dvsec = cxl_pci_get_device_dvsec_cap(pdev, 0, &cap);
+	if (dvsec < 0)
+		return dvsec;
+
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
+		return -ENOTTY;
+
+	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
+		return -ENOTTY;
+	if (!(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
+	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
+		return -ENOTTY;
+
+	*cap_out = cap;
+	return dvsec;
+}
+
+#define CXL_RESET_CTRL2_CMD_MASK \
+	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
+
+static int cxl_reset_read_ctrl2(struct pci_dev *pdev, int dvsec, u16 *ctrl2)
+{
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	*ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
+	return 0;
+}
+
+static int cxl_reset_write_ctrl2(struct pci_dev *pdev, int dvsec, u16 ctrl2)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_reset_modify_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
+				  u16 clear)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
+	if (rc)
+		return rc;
+
+	ctrl2 &= ~clear;
+	ctrl2 |= set;
+	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
+}
+
+static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
+{
+	return cxl_reset_modify_ctrl2(pdev, dvsec, 0,
+				      PCI_DVSEC_CXL_DISABLE_CACHING);
+}
+
+static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
+{
+	return cxl_reset_modify_ctrl2(pdev, dvsec,
+				      PCI_DVSEC_CXL_INIT_CXL_RST |
+				      PCI_DVSEC_CXL_RST_MEM_CLR_EN, 0);
+}
+
+static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
+{
+	unsigned long deadline;
+	u16 status2;
+	int rc;
+
+	rc = cxl_reset_modify_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
+	if (rc)
+		return rc;
+
+	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
+	do {
+		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
+
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (status2 != U16_MAX && (status2 & PCI_DVSEC_CXL_CACHE_INV))
+			return 0;
+	} while (time_before(jiffies, deadline));
+
+	return -ETIMEDOUT;
+}
+
+static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc, rc2;
+
+	rc = cxl_reset_modify_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
+	if (rc)
+		return rc;
+
+	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
+		return 0;
+
+	rc = cxl_reset_wait_cache_wbi(pdev, dvsec);
+	if (!rc)
+		return 0;
+
+	/*
+	 * Restore the default CXL.cache policy after error paths that
+	 * successfully set DISABLE_CACHING before reset completion.
+	 */
+	rc2 = cxl_reset_enable_cache(pdev, dvsec);
+	if (rc2)
+		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
+
+	return rc;
+}
+
+static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	unsigned long deadline;
+	u32 timeout_ms;
+	u16 status2;
+	bool final = false;
+	int idx, rc;
+
+	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
+	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
+		int last = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
+
+		pci_warn(pdev,
+			 "unknown CXL reset timeout encoding %d; using %u ms\n",
+			 idx, cxl_reset_timeout_ms[last]);
+		idx = last;
+	}
+
+	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
+			   CXL_RESET_RRS_WAIT_MS);
+	msleep(CXL_RESET_RRS_WAIT_MS);
+	deadline = jiffies + msecs_to_jiffies(timeout_ms -
+					      CXL_RESET_RRS_WAIT_MS);
+
+	do {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+
+		if (status2 != U16_MAX) {
+			if (status2 & PCI_DVSEC_CXL_RST_ERR)
+				return -EIO;
+
+			if (status2 & PCI_DVSEC_CXL_RST_DONE)
+				return 0;
+		}
+
+		if (time_after_eq(jiffies, deadline)) {
+			if (final)
+				return -ETIMEDOUT;
+			final = true;
+			continue;
+		}
+
+		msleep(CXL_RESET_STATUS_POLL_MS);
+	} while (true);
+}
+
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	bool target_prepared = false;
+	int rc, rc2;
+
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (rc)
+		return rc;
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc)
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+	else
+		target_prepared = true;
+
+	if (!rc)
+		rc = cxl_reset_initiate(pdev, dvsec);
+	if (!rc)
+		rc = cxl_reset_wait_done(pdev, dvsec, cap);
+
+	rc2 = cxl_reset_enable_cache(pdev, dvsec);
+	if (rc2 && rc)
+		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
+	else if (rc2)
+		rc = rc2;
+
+	if (target_prepared)
+		pci_dev_reset_iommu_done(pdev);
+	return rc;
+}
+
+int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	int dvsec;
+	u16 cap;
+
+	dvsec = cxl_reset_get_dvsec(pdev, &cap);
+	if (dvsec < 0)
+		return dvsec;
+
+	if (probe)
+		return 0;
+
+	return cxl_reset_execute(pdev, dvsec, cap);
+}
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index c8070d9cfbfb..856abbcd5f18 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -9,6 +9,7 @@
 #include <linux/node.h>
 #include <linux/ioport.h>
 #include <linux/range.h>
+#include <linux/errno.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -165,6 +166,7 @@ struct cxl_hdm_info {
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
+int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
 {
@@ -173,6 +175,11 @@ static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
 static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
 {
 }
+
+static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	return -ENOTTY;
+}
 #endif
 
 struct cxl_reg_map {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..4f5942ebd29b 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,8 +1352,22 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
+#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_CTRL2				0x10
+#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
+#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
+#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
+#define  PCI_DVSEC_CXL_STATUS2				0x12
+#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
+#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
+#define   PCI_DVSEC_CXL_RST_ERR			_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
-- 
2.43.0


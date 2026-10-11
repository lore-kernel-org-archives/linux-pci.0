Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6582F8BEE;
	Sun, 11 Oct 2026 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684916; cv=fail; b=DRkEDHzaC/KUOjxNq6J8cL8UOrOudJ2ciTE+AwXylXbvSTkDASy+bUaxPgSIckbCnoZs9l4+A8DkTg8eiwc5ev29nbz468qdCwr7ge80vIKPIxO8dCSUoLcoso3x4up3w0lJPUW/FlMParYeRzIjI8N00ZoWXlCCHLroWgZSZSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684916; c=relaxed/simple;
	bh=em0uQRLh3jlugObZZzao4Vc8IAMIn9xvm/1vA492Ohg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RqmOHrowjCGwiw38uxf0kA7qLQMhxf8BvRwOs7sakqgrpWaZ7uFA64oD3FiYHWM1ip+Nm5AbCQrHF/LFhoodvV6L8R9kiVj+ul/6Wm0+X0XXjOZ9RIqrewnTBinlwdKRCGIT4m+CqBB60d1bgRhBDnvuq61AmvU8h1StDhoQ5p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H4N/cBn4; arc=fail smtp.client-ip=52.101.52.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H4N/cBn4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StlKFebTklQsIdSy85y3yQMKDeHl6Y1A/6ijC2RwsPN251kSl3DdcjWQLaA62i7GjCOm0zt+0OGhNGWKgoMYAkg2yrLrtt11TJb2ztWeh4S56+Ds0LT+/7mzonuYU7X2ncBD1y9YVxArg0UECf9RdwZQF1rEZEa5ZhjcUtPdIaJPzEzHWJpH1ZdHbUN5QJwBDVqS4Jr61jeAdUMLRZO6CSrso3iwIfNmPnjANuY/tEEb8MewbvNs6YFQoceOABFRco+uJByGFDJAEHn2zL/FYyF3z69vpo7WlUcrTNGwWegDaWLx/vyVYDmQXQ6GUy9Kk8NPpTrUtSdhnkc4Xr03fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ReAhrOSfMg/WPn990fW5FI8ph1zvShTJOhXGzS5Ho8=;
 b=Vcp60sz8CQvO2RvGGhyGs/79RE3PBZeISEDJuL50vzBpY0Db3vGz2+KVWpUV7miqVT1bTFOlUI8g1ZxtCfQqKIXVu+O7vbffUSPj8ekCoVhGyC11vNGdtOJzjJBQZA0KTaCwPfcLGmaaarFtwk30GtkJZUeaJF152qARvt6P7xxpHoMDEfNza1PzF3/2F+y4CqqAOKeq1mD/mQ/SzsJAE1j7qCLzYVNEqmr7IDXlOsp83BCe1UODWsmB+v7M2a2bs9g2DBQ4dBXlG1b7zLtofixtgxcUAB90kZUo+TAJB/CNnD69eH1R5t60sOtVHFBihua8ieDWgM+CMQr5hFcgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ReAhrOSfMg/WPn990fW5FI8ph1zvShTJOhXGzS5Ho8=;
 b=H4N/cBn4FijqM9yseIjPxIHyz1N5k7oh2VjOvH0ygoeOA/6AEv5TNIaaMF2Ah/lQ+6J1G8t9SdtDvbrwdVzlNXTPvEID1G5LLgx5ffSxLzvFl0e3Nk+yLQTd6fbPZcqiyLkN/WKp/ikCLNbeXelrOX47V3ZuscOFVTViSGdltN656RqQXWGVSiI5vzsNhcWSgmyTR0cTWAvxdr8rFW3Jw+sqAp2G9qr1zgMXSmlChrujwIDlBZPJvif/eZuhhvlN74hPq2GokaQpo+k63gg7ZZxNfGh7LMsLw5EnlV6iEghJ5tNTivh718UXiw6g9vQ1fLK1wjrIRmLfFCaE4FJyDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:15:05 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:15:05 +0000
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
Subject: [PATCH v15 14/16] PCI/CXL: Expose CXL Reset as a PCI reset method
Date: Sun, 11 Oct 2026 02:14:20 +0000
Message-ID: <20261011021422.3428136-15-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:510:f::21) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c4de2a-3fb3-416f-3dbc-08df273d76ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|3023799007|261009223027099003|921020|11063799006|5023799004|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ia66btFFng1eZ/QRVFN7+5kDnqdvi1QRi6IGPdPRYsqmrtMrfTN6iB/P1At7LEVNs2dC7YaeUl+wgzPO5cG0wnzPxH2dxyCbnHti0jWN6Vi55YYTVwJSEK+vwGrbLyuU8n3VCcwwC6niJlXnsmqqBSUgB+Za5AvxEk9x+kGe2+k17Ub0qJrAz2y6dk1ZpM/7rehMeFnmKVu+bZwz0JVqvNCMuBy5Fnv71Z0DZZeimFbCGP44HZALEcypGf/wrE+me+zWwSN6g4dNQVTjAya07arQ8wqKogCFIy2apIWE2e63y+KDwmghv8KWccGzwaPM3Ex/mBKxQHu+9BK/54VX7WuEUM4eSiXN+n2BIYuptIESCPY/SfOBdMgtCULs+gaUK3MSWO2EpEWefBkFEFELXG/mAtNl5oYS6hw1p5febxLuYDloI0tj59GpVIPxb/bQYGtrrKH9GdXOI4QYVBTATKt4M6RYqe7h6oOdeDHmSim4ajfx6Rh5ZTy3RNU6sIBkRDJZuudfqm7+O1DrAx/TUu3y0jc0RqLSufmkZwQSR1H/jWbOQwpIaJHxrvxR9gktkkLDXORHsz4Z3R4TOVkJs9zIn6bR9ASKgUsLlJT1VOKsSYZGSN7FEIkKn514H4tSewxmogDhC2lA6OteFfPdwoMdXDBLJDGzN5Io92t3P3pV/kNk0M25Xolt8vnQXpQfxWXjCYA/Qd1kbdomKCI/xA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JpmKBw5JVF3OlG9iWEU+2yJ3eENeEB08FUd+Np9tgeuEc8qhSVUHgHgtObCL?=
 =?us-ascii?Q?B3/NDAV+y569DXZfsKliKRjevIavh4gTmiem5UXtuCZJ+H1eX+kT9numgV6z?=
 =?us-ascii?Q?k/+fPQfPvE/f7F55nnVZKbAP6PzA9wxcWGuWWIcFXsD+kzBruAH5lasRTX8w?=
 =?us-ascii?Q?SXZPBCLK8ukkXn2YW4vPojlHh9BfOjEeOqwND9sLtcELQYJKmbX6RHfmXHOv?=
 =?us-ascii?Q?aFj/Y7p7sFWnyTAYBW2MvBsXff+a9vm6Y3aBHNox2mbkC9vcSJo+HSsUfabs?=
 =?us-ascii?Q?iQpJdvfUOwFtE13CzatXpTut5DT7FDzEr8zV9TmgK15oKywKdQyvJZBEO5h6?=
 =?us-ascii?Q?o3oPXtVL0dTCLSnSmEKvnMd42VVFr0GHNvFA5L3Z8S/XbG6CKpasi82+UnYK?=
 =?us-ascii?Q?Cvx9U1oGlQbkIBrBfN/8vjdoW8GpKSGDkV+NK/UbN6VAiOmKmx6Hu350C5KC?=
 =?us-ascii?Q?V8jvfqYW2giihiO+hXb5xzvAPQQ3EFHoiPCL/1l7DctkQrx8SZr1nqnN+3hx?=
 =?us-ascii?Q?zM1p5NUW0D6Jt5kPtIy2Paaq8EzCtQiB+j551Pf2S7aqdyIownsLkBt8WcyQ?=
 =?us-ascii?Q?f0RAaxs4Aw/0I6jFJCUHEfmV16W1cZLK1rJ6PyzERaDGOTZjplcwIKlzR4uv?=
 =?us-ascii?Q?95yK2rIyJzxMlukLYwvWWim2yDIuAqbDGdjVJndADYN2297ADjaA1TlXNQg9?=
 =?us-ascii?Q?4W2p7NfgIFQMa2BqzcWXbdsVWt/1/rVKo4uwORqqpuAMBE+sYlk6bWbNJGiP?=
 =?us-ascii?Q?L6n30ETTdASGJ7TkRHdMo23sNwXkvFlIxUM6WRzdquBpFfdQ8AELajDcladw?=
 =?us-ascii?Q?qbyMEGpas4+cgs7Cc3vezLXxCJsjFiLUjIIjfoJtu5plYuCasulj6FWeqs8x?=
 =?us-ascii?Q?TXmreEiuf4nva4bZm8806lbjU6g3RClEkNTYqeeHPmvmYRYNtw1WPUMqduZb?=
 =?us-ascii?Q?SsCg4HQoRyrKf2stvBy3k61ggAMYwXoQA0q9eSKbWJ9y4ma8eNjphRIS9wWs?=
 =?us-ascii?Q?D7trX8lyBUYGFuEAWNbKzt+oMVmLZ7MeS+/whcgKBS4tg77zT+wgM4dZJ5Gh?=
 =?us-ascii?Q?gVxplLkGpilgN3eFjEatZWXomdSjvBZsz3bLPRujD42kVnyALoXHVTCOSeD3?=
 =?us-ascii?Q?dUEwovPG9ZpvYR83vCNdXkNJp1xwPxDQ0XSLnMnGCCI0V8Y7Wv5YGE77/Akk?=
 =?us-ascii?Q?a5DGQvOKK1u5ZXXpPfojpzObLW0ZccT9Y8Jyt2Zvuj34sQ27AUJneg8tpQUx?=
 =?us-ascii?Q?vR5cjhtZo1pg2ykup5rQZK1j8CdmHFEsRTAJGOt0RRdspcqOYCLtGfE+IiF3?=
 =?us-ascii?Q?yipLW1iZxO0IHT/h+bbutwxrIq7XmxGPOp+Ir2YPHfsQHVkTgbTP+9gLgrfa?=
 =?us-ascii?Q?vRtuEPNYi2Yj8JYOPwesJh8W6ao8R3TSl4vcQy1CTJWUke9VZqseY2jGvNMv?=
 =?us-ascii?Q?3TjsVQ0mlz75xNHMzMgilhGRsp3Iw7QuDpsTvBtGVEVMqG4j/fV5SzFCPOpv?=
 =?us-ascii?Q?5fs9W9L/f1fRY9SlcVbfxeBqVbIs9qSEu/HjZJJrSZDVH8TW+NyhYrBnSrYO?=
 =?us-ascii?Q?lBcOs7HYBjTc96fhpPR51xbn+dTUPFMWjF/L7DRVQ4Q8VDgIrBQFN/pcwwV7?=
 =?us-ascii?Q?Rt1xaRPNQQiqJPmpJMJQhNueDxPzIipyoS1cpSzRpe75v1jOcHpLNZqjXF67?=
 =?us-ascii?Q?xEbNtOip04ykwBefKy2xeaHkuPam5ImkS0hfhLy5J1u7DjHRH+OduvpiamTj?=
 =?us-ascii?Q?54jTXHr6oA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c4de2a-3fb3-416f-3dbc-08df273d76ce
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:15:05.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wf2Ewnvpn4+Icj+8B0S09yA/kcFf55dKl0aQXa6UzfwSy6qspcepIxjFKLCD+XOX4jKAcG5rA22625nuBZdreA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

Register cxl_reset with the PCI reset-method interface and place it before
FLR, which does not reset CXL.cache or CXL.mem protocol state.

Return -ENOTTY when device capabilities, function scope, cached HDM state,
or required cache synchronization do not permit a safe reset.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/cxl.c   | 12 +++++++++---
 drivers/pci/pci.c   |  1 +
 include/linux/pci.h |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 4c6b712ed4fa..7a225e215ca5 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -642,7 +642,7 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
 	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
 	if (rc)
-		return rc;
+		return probe ? -ENOTTY : rc;
 	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
 	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
 	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
@@ -651,9 +651,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
 	if (rc)
-		return pcibios_err_to_errno(rc);
+		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
 	if (PCI_POSSIBLE_ERROR(ctrl))
-		return -ENODEV;
+		return probe ? -ENOTTY : -ENODEV;
 	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
 	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
 		return -ENOTTY;
@@ -675,5 +675,11 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (!cpu_cache_has_invalidate_memregion())
 		return -ENOTTY;
 
+	/* Raw reset callers may not have saved the PCI state needed for restore. */
+	if (!pdev->state_saved) {
+		pci_err(pdev, "CXL reset requires saved PCI state\n");
+		return -EINVAL;
+	}
+
 	return cxl_reset_execute(pdev, dvsec, cap);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fe611340f5ab..b58a6a613311 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5148,6 +5148,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
 	{ pci_dev_acpi_reset, .name = "acpi" },
+	{ cxl_reset_function, .name = "cxl_reset" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7bb37fcb556d..743b57ff885a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -52,7 +52,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.43.0


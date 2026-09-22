Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9451AFDE;
	Tue, 22 Sep 2026 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066381; cv=fail; b=DT5kJ5V79mn0wsHX1CrsefvwyJSnDj7gm+qlpGC4/BNtncT8pp3EnqgqvVyOi/NSEpd0q/mzBL66oRl6D6KUhE0cGAJV8Swr8B3WMVF+DnReNnPRZKT+WWgMjUeRgWvNMqwGLX6c+f5xtHtTUkV14yfDBkWnvGvWUddVdWUb5+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066381; c=relaxed/simple;
	bh=dTy2nEmaBS4kcVvolEyycwfci2Vl8UU/GiJszcVpvto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VmQRLIJDASE+GPm0QONsDuKk8seVkkaZTrh8ZOI9PiFmjMUS/ELpMWzrolTVlw4i7zeI8+gL+uLWvky/1s5tgBwvIjgP3s2kBu1DVtYoFoiMfdrJSuQqXc/OM6XtMysLz6eQ+wPgwoCofm32PcL/xaHPl5ETiIG/oulH+INqI+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P706QW7V; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P706QW7V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+pv96DaJcM+XSPkl3wZBj0IDCjNS3N6lI47hhBP32hpUQ8KZAxkEgQ1D10oqlDNLPJ9XM/qUp6EfWJ9DHXoJZ3UmG+TBTp5Qus7K7aoKWaE0nPllRxq0h0PKNA11Tw1uuiAb3AqV5zxac/eQcfudS1D5z9LSJzSYws2kIbJygLopC+/u2eDcnHNSiEVJpwLN96dKYv7O7eiMWNz+qLtTiEbiw+6BZAMl+jo04veW2WUjt71uktbEJUt6lHWDeX+j7YQaXIdGAo9jLb0OK/4bOABLx8QTdiE9KPmEkITeslbLpRbe1pNGE5+I29Qr9/WrcKdEiWUA47aK3V2SswNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3LiXgqLZr1Y1808i63g4SXmRQ7dGhJeXFK0BldNuOc=;
 b=vigwwXGiVqTWG2LKxZH5AlEZLcZXBqx+LQ3kvraXIL+7Kuf3+LJkbvZvi6bIBoZ6+TkeTE8/a48llnlcYvEIqd/6AyuosArYtlJuLd5rrX37YxwyDLWvRGBM5HTB4ZJyd3tYm1df+KpiX6/AIJJGGtlXEcetJipsILjGGhbiqiIM5O8RF6/XTxDVliHwBq4fWFd8EU8DMvfTmATiL06Cn6mW+e0Z1xyYI26FV2N/HrAwG3HPoaj0F7OL8Y0E+KxlD+4s46GZCOxN21h2A5Y/TcJVGR7Nw4KKl0YyfL7S7oTG9otbf8BSKQISV2oTLbwT0NSu7FO8zPQgxPP+dInafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3LiXgqLZr1Y1808i63g4SXmRQ7dGhJeXFK0BldNuOc=;
 b=P706QW7VMQgvB8LBSlVTVTklsAIhgx0FJFRhV3ouSzpCB5cdxeEwp5dMhWtUEN8P3BNopb8iOlM2GiGI66wWX6ftOeaK0RkV/G/BIqGNrr82zgP1GBl4dWu8P0E3j15zzhWyHZcNvU18RH8R56KKUBYbdUHfGNQSa6HwrAspmruQCtmiMG4X4oQvd8ugSnORtKMJv9423NGRS8sNPClOCtXUVbraoru1gDhujx054NjYWPU/1B4g38JlP623TqRPKg0OE1m9tsr6iJET+tHmOL4IlahvVYJq1dK2ZCNE6spbMUtv34/UcObM4BDCn/vl/OhtwvC3T2s9zxyYnxDxIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:36 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:35 +0000
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
Subject: [PATCH v13 03/15] cxl: Move HDM decoder programming helpers
Date: Tue, 22 Sep 2026 08:39:12 +0000
Message-ID: <20260922083924.2451158-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 826f1adc-6644-4d55-4cfb-08df1885084c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fvI1043xIn0XR6ATQpm9BnWiuLuPxeH21tgppHYElHjfq5G1HREb+PKVQJD2v9+AQMmmN+Ob672Zkht+Xw7555TDW1hJt8qJp8MGouXju2CQZwSDUV/NDRzAPHQWLo+jSCXrQKPoiB2AgW5ldLmj68ROkfILMSrhzb1TIR+IXiUn8vuv7r7ZUqkVfvRJx5Um73owX1cZqBqLWWKxNsdOsdP8kY+sFBBorRZxfDF3rIPGEyNbzmWJTDdJP6ym1Qbb1MQzjWFmGgzFOcCYXiXSlfHfXOdOgjxmozhjLiiir6DGx/ilTBQe0CGk7C57pOwBBZyQpyk287f6cdfSAdimN5uW+6M+PpjHWh6IqySInpWM1zhEf6wu/gskSpH6JvPqJOX7GIPAfZK36Z+jETlJpzwJCdgv7Zj80qIyWgOJNejeCFEp67883RJUrIM8QGuVobt0oCRyzFvLfeE2LjK89yOCQarzd2yhaFf50KjtkqV0qwgPPXjV3HVlGrZian3JA+es53lggiKermLrvrCVMBw+WfYWbY5Dx4Dx3zNz50ZwpMOcJ7eUMwYu87Ua8YrZ57TtmmciUmJa6rMkaYRD2bk8ngKRsMpOYxOlxANff0pEsNYNlkfK4sEEYqfYc0JDpjXrlS6Kk2cVSOYN2+usRYBNLy9ewmxQEZkPE8ox+f90gkDef1M3q54Hxy+j0MmmkXtLLUP50Pr4TTpHEu5Zag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nLVRM4FiWz2roV+UZ5aEaTvBnFitvNGMFfDKoHA5dvXJyord6W1Zqi2hBRQd?=
 =?us-ascii?Q?BiyuvHZ3/rqhL1VkAOWxTP4cm9v/2xr4rmxxzgX1qauU0aiI338qgMEIudD7?=
 =?us-ascii?Q?Tr3J9tSsSrLoNzHVnoYB6xtgoiGysXyQGUUoSazzEJ+wP+fOJiphrh70eibD?=
 =?us-ascii?Q?tiuvq50eCtuF7aben2yLNafmd/M7jTD/Y6hSBCLT1hgSsjrO3/I7BIEFZt73?=
 =?us-ascii?Q?GgnfJ+AcVC4kv2ffZCDnWN2RvFaAksyju5f1DW+47Yr2tBPR61KRBA/MhbBc?=
 =?us-ascii?Q?k3+Wm3NbxtAeO7rNUqJn0/hae5ukHzGd86zkzZDG7WHfc0/sMn/ai+d5YTgh?=
 =?us-ascii?Q?RtU6MP+YxLfHAbTFKRyKXOPe2sODIUJLzg8oIiag6fL+j4mz248DTqX4ZN2b?=
 =?us-ascii?Q?kLYr7TxA1kWwE+2BxSfOrGLaaH93gMJQYlIPPcj9Ff0hRQBg6GnvqhWD6o2J?=
 =?us-ascii?Q?yfLQqFOv4HX4Y2djD2eyClJjWoC73HjIgQdSykorOvIOPYjJm7KP4fYcOb0d?=
 =?us-ascii?Q?0YFzZ//YcVnqLFvVErx6WzE9FtpZ/JZccJH59qb3GlnAYUDHhegtO1Yfq9Ws?=
 =?us-ascii?Q?eFSFYO5qT7dcvJLmTn+lDCzieadRGSB0T7msuXYIQlU8cfnKs5jf+NT1QaqM?=
 =?us-ascii?Q?n2yHVC9h8f8O64VfOcMPd5qJ8kPlp5hVGZgE6KJC6SCMG3eB/hnnROw+vUww?=
 =?us-ascii?Q?PnQKFDbvX+IOLDP8r2c9rjlJr5XoPdCXf7cr50zrPDZgSJ5BU7zPBPe+eHd8?=
 =?us-ascii?Q?q1Llw8hLNbwIcIYyAmNaaCZt6NGBCLBTl5jRNWNeSTTEAGBgFb0n1RwyY0oF?=
 =?us-ascii?Q?m6gW0ZB95ChE4YmZAqzPvUsBUoHgN+SWGY0le3uyJKMdx5J12GbMUVz7KdGd?=
 =?us-ascii?Q?4+P+uzgcDgY/XqJNKeqNX1j7CPSgUMeLmfLwgwjHVI5lPFWnGtF4RQ+6HHu0?=
 =?us-ascii?Q?lkNIn84K7hRhpRzpezXA3ZisFBsK9fwlQiXzkJuQeIfinCt4KNsbchbPNtLO?=
 =?us-ascii?Q?8Z2jGF3ZkFKuSq9BNJyTKwQms9ZFR40AmU2MOIFH85ZPqgZpIESkQQEX1iS8?=
 =?us-ascii?Q?jrFSWQh2HYpWSGGWsRODuh16hXz+bmA8UhAMJkrbCFVbAkd0TUBzjrtJEwug?=
 =?us-ascii?Q?1Wne/98nXZzqxTt/h7aHQ8vnYPne9kK43XyyJDQGzpHToAmHOsS2Ue9vht0G?=
 =?us-ascii?Q?uhGndvtPjFYpRp0Dgef8CrcPKysmQ/nEgIw6TnyeBs1uWP3Dnjd2TnC8l/Gs?=
 =?us-ascii?Q?y8Zte+TcLzPYZH6du8rnTZXhUWH2uRTWMFTI/D64lPcx3hCXdzdVh+QWEFkI?=
 =?us-ascii?Q?5IBKxf1HFGU43xBIOjdsFwKKVMjodzq6Gag//2kOaVE0PQacjbfubxPTdhRA?=
 =?us-ascii?Q?FOi2iH2Qodtq0oFFRLeTYCAYSKQTOYTww7/vdaBmLE8Z6kQJVsElvt3OdtFW?=
 =?us-ascii?Q?KqfWBl1FFnnBLZYka6YKUxdmBisijEahq31FOVjC7J2nKZiJxAUJlu7rd6cB?=
 =?us-ascii?Q?y8kbkc2Zc4Dm4sTz6i7RCtw6VVp0RRCq1aK0OKJG98nVl88SfbWemIcZJedX?=
 =?us-ascii?Q?TdShSabITZqMX8G7JCNCv/dgd1BIfbr7aZwdVro6yhJw8eRsBTkShj+fSAJP?=
 =?us-ascii?Q?/iyu0xTAPdrSpeDeHq/PButc5ETi9uFuT9xttAyoChliqAProUCx7hFiGQiJ?=
 =?us-ascii?Q?qfOLIlxvKhJSkee5f/MkdoeKaLSuUVXnFJIxH920NQ/SaXIFPDGYH6hrijKu?=
 =?us-ascii?Q?HUAT/tO4CA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826f1adc-6644-4d55-4cfb-08df1885084c
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:35.9469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IpJ5H+tZ4pI6oo4wmyMBmORk1abF/pBpptrp3zSvxHbJlsLidj28/nFOh7Y5bJf3JBesrp7WJluXcODSHyDXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

Move the HDM decoder programming helpers and cxl_rwsem from hdm.c to
resource.c for reuse by reset restoration. Keep their behavior unchanged
and expose only the cross-object helpers within cxl_core.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile   |   1 +
 drivers/cxl/core/core.h     |   4 ++
 drivers/cxl/core/hdm.c      | 103 +--------------------------------
 drivers/cxl/core/resource.c | 110 ++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/Kbuild    |   1 +
 5 files changed, 117 insertions(+), 102 deletions(-)
 create mode 100644 drivers/cxl/core/resource.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..57995777af0d 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -6,6 +6,7 @@ ccflags-y += -I$(srctree)/drivers/cxl
 CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
+cxl_core-y += resource.o
 cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 983d7690c3a5..9c6d4b99f787 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -139,6 +139,10 @@ struct cxl_rwsem {
 
 extern struct cxl_rwsem cxl_rwsem;
 
+int cxld_await_commit(void __iomem *hdm, int id);
+void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt);
+void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 39fe283cbc74..008f04f0ca25 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,11 +16,6 @@
  * for enumerating these registers and capabilities.
  */
 
-struct cxl_rwsem cxl_rwsem = {
-	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
-	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
-};
-
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
@@ -707,36 +702,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
-{
-	u16 eig;
-	u8 eiw;
-
-	/*
-	 * Input validation ensures these warns never fire, but otherwise
-	 * suppress unititalized variable usage warnings.
-	 */
-	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
-		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
-		      "invalid interleave_granularity: %d\n",
-		      cxld->interleave_granularity))
-		return;
-
-	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
-	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
-	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
-}
-
-static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
-{
-	u32p_replace_bits(ctrl,
-			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
-			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
-}
-
-static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
+void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 {
 	struct cxl_dport **t = &cxlsd->target[0];
 	int ways = cxlsd->cxld.interleave_ways;
@@ -758,73 +724,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
 }
 
-/*
- * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
- * committed or error within 10ms, but just be generous with 20ms to account for
- * clock skew and other marginal behavior
- */
-#define COMMIT_TIMEOUT_MS 20
-static int cxld_await_commit(void __iomem *hdm, int id)
-{
-	u32 ctrl;
-	int i;
-
-	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
-		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
-			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
-			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-			return -EIO;
-		}
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
-			return 0;
-		fsleep(1000);
-	}
-
-	return -ETIMEDOUT;
-}
-
-static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
-{
-	int id = cxld->id;
-	u64 base, size;
-	u32 ctrl;
-
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
-	size = range_len(&cxld->hpa_range);
-
-	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
-	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
-	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
-
-	if (is_switch_decoder(&cxld->dev)) {
-		struct cxl_switch_decoder *cxlsd =
-			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
-		u64 targets;
-
-		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
-	} else {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
-
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
-	}
-
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-}
-
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
new file mode 100644
index 000000000000..68d40f745acc
--- /dev/null
+++ b/drivers/cxl/core/resource.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#include <linux/delay.h>
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+
+#include "cxl.h"
+#include "core.h"
+
+struct cxl_rwsem cxl_rwsem = {
+	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
+	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
+};
+
+static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+{
+	u16 eig;
+	u8 eiw;
+
+	/*
+	 * Input validation ensures these warns never fire, but otherwise
+	 * suppress unititalized variable usage warnings.
+	 */
+	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
+		return;
+	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
+		      "invalid interleave_granularity: %d\n",
+		      cxld->interleave_granularity))
+		return;
+
+	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
+	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
+	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
+}
+
+static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
+{
+	u32p_replace_bits(ctrl,
+			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
+			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+}
+
+/*
+ * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
+ * committed or error within 10ms, but just be generous with 20ms to account for
+ * clock skew and other marginal behavior
+ */
+#define COMMIT_TIMEOUT_MS 20
+int cxld_await_commit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+			return -EIO;
+		}
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+{
+	int id = cxld->id;
+	u64 base, size;
+	u32 ctrl;
+
+	/* common decoder settings */
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+	cxld_set_interleave(cxld, &ctrl);
+	cxld_set_type(cxld, &ctrl);
+	base = cxld->hpa_range.start;
+	size = range_len(&cxld->hpa_range);
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
+		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
+		u64 targets;
+
+		cxlsd_set_targets(cxlsd, &targets);
+		writel(upper_32_bits(targets), tl_hi);
+		writel(lower_32_bits(targets), tl_lo);
+	} else {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
+		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
+
+		writel(upper_32_bits(cxled->skip), sk_hi);
+		writel(lower_32_bits(cxled->skip), sk_lo);
+	}
+
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..6c09932587ce 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -60,6 +60,7 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
+cxl_core-y += $(CXL_CORE_SRC)/resource.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
-- 
2.43.0


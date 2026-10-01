Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66F4CDDC5;
	Thu,  1 Oct 2026 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846572; cv=fail; b=UBxENiVoVjz1muo/MBesbE6ZgakSgCb8cBOBd9kjS1QrNJK62y46P0Iykv5kCwv6MluYpDFvJ4o8XAzPZm+d3/P088qNcp4qDbi+JkqgZxPDSDf0rrU+7eFIswxWwQUq7HEJlwVuSvyVHtoeOrZ0jto0lYpj4Ppu6Dr2PMc32l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846572; c=relaxed/simple;
	bh=ha8+15PhP+5/1vPMFKtSKCHF/Jc+IPbN72gQGehssXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N8MASbmQevDuS+2MVn7WQ4Rfl+QeLu0fggGBvQTQUn8sG5RxLUMG/c1HlqkMY3UfJBA0QHuAGLBSEtKqKvKH82EJuB3fUw8dc3PlD4KWaK1IyGC/ex86F/3twD9SnOACByaZMV5Tw7TvssheJ4+CEzZKGTdhrG7Ng+s4sF+QcoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nbgFkzaw; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nbgFkzaw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mf3lsy1rnEbkvqsRejcQ5B4bqtL1ePmhKhQ1b8Wblgw6cChtabZz3wtMusHausiyJiZ7I3o/rP88WEPg9VVYSBETvMkcnUQDM7tRqynWKCKvsATBiTNtQLxApAimKkic92aDyoaqc1NWmm3C2YmdC/xedLggw7q8kHhQaz0PMDlhizYsg0Gykf0EwgnAIt7b39p4KNLZy7QkflJnfeg0bLVbnK0bZdPKuDtGwTaK2458Zje+gjv+jxWzWJcj4xPXw0xcJz5KwRREemwEYl8qowC0qHvX0NJTbBDUeMVVCTCs7q/e8JP3uvWHyuD9iPjQu7uH93Rd36zPeb2bfbfNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8ct9P5SkvZDtxMoLO/lvLd4N7p4WrI4vIlfmGDDP9Y=;
 b=afRn+hZKEppBQW/y92p55AZRMouBV4VTmaUMsXWVIG3GC0JvRAyBVK3rpRhd9cUnWZ/fb4LA801+VV43O8Ms/WKuUQxceM2txini2WlfHmqjF18yndrP52eabiUrcTkoBfB0vg0wb8pXGtAs+OFQeYeSRFTcjxpgZZSrz3LnHEb7TMDwT4T3LxBbzyjIZvnwPoB8Ow9bvp8DJDPdyDbMZcFOzMv1jz19ykwsUGP9d4mx4marZ2fCXcuiSAXMudM5BWDz4zuWm8EDgA18tEJqpPa0VVUnZO4WbNitq4SFRYGskGRZS0mE9P3I5BbU74OVNKofWA1FzXJd9FGX9olTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8ct9P5SkvZDtxMoLO/lvLd4N7p4WrI4vIlfmGDDP9Y=;
 b=nbgFkzawmyZL34QJJD/dRW8ffYvTQwKNDsy3oU8TF6rfVlnMJksu6s1HkOAG7+shNxADeqnuptQHsGqwZ/tpp7GhzrpzkFSfppbUtwtZVQspAK8sNKJewFQk4EsYrfx3c6pbZLJxVz8TIMTVghLovIWMyEJbpoQR93qFvSKHt239IXzAL46duC/kgk6C8y6aUvlduLEVx20ZQJeAKAs0qMF+cWp7pRryRrEg3uIwVtD7tM7O5lDsqUXj/hzMnY6cRln/Ti5fL4Juur0/rEhsBZm4fap4Yr+CW20FujqhCbv+88LvKWn22M9xEDreegIjhSVydbWyW0T7LFBEmsdyKg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:22:44 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:22:44 +0000
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
Subject: [PATCH v14 05/16] cxl: Introduce reusable HDM decoder settings
Date: Thu,  1 Oct 2026 09:22:16 +0000
Message-ID: <20261001092227.3004747-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::20) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a966f8-31ef-4ce2-8a42-08df1f9d8caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EBV3wsKIyj01tcsqVpHWqQb4CHczcfuSbhp7VA4lOnhb/fM9xEDNe5o5sRtmoktVMBlqUfT4OA9BykEjTZQ7RgALyd0XLikuYDReCc0yTUGqY9k3Th3jGHaEHwMXU7CDTSKJ++HVu9gFO/Hegfm0mz2tTdrX5Es1dAoUdGWTKnw2ZyZO3cTj5ngKajmBAJoKpyTEAM3gLu47VdYh0NHpEYyC6GwqmqPbzGNQi/f3+HA+j1IWznv6bR5KYURb2f+bjRsSXOm5Lec4KdGvHVC/irp405UzgEouRV2KUfxJylkGHZ3dA/Sc0UrmB9mPwBVA2VH/Nlqm5kzAsWlX/L2xACzkxcKCdVAqAKNz1OZ+AydwIp7GDA9FmveU9CBO8ZQrEr/Zy0h+OGtd3dEXJZReWjyc0WVeDErOzgqOsk/nrCyzOFPsCMv5wFKNay1/39RnqLi6nZsQQ5qhaRS7U3z8dpBSUWbNm4ZfB8/22yiQ4nPTdRGNvP3AEqkdRABgKG0TTJ0UlaL7iPmubSHpQDkzfOx0PbB/VVf1DNHx8Ju1fkG2b+A3SzFv8y6OALmsNjLJ7poMh0RM+4eDtU+i0Iff3ge5qPHFO2Eou4u0aY1suv/FfBcB3rNC5KZSgm6L7glOxoOrtpqZ2jtJ2/PyIJI1WilfDd/uIMVro5sKt7eq1OpaMCO7o7D3m0TFuM50RQ3IgzWTBjpDLteLXeFW0YUpLQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+n+l8zI4IdKteUf86V3rPhhnGVBIc6CsHVge8TLOOC3Q6o3wLoItkLsfY/6v?=
 =?us-ascii?Q?JJf7vdpOri/yx8ZRPWVafFBeYsq2AgMaq59lB2/73/L0aEXI7OB10vCKavj4?=
 =?us-ascii?Q?xqUyPnkgGZ+a2os67sbMa3gRMk+OdEvA8zQ0C1DtR3pR/ms7i/ayhAVEcGng?=
 =?us-ascii?Q?qIjv6TuHPqVn5L2/eYP5fKPDwUABKJXbQtwE9DOR6ollT+OWosYUszImXbaP?=
 =?us-ascii?Q?XYnHeQyOsikRicnbwmZ1kZnRxWzFVBTC0w8eY2u8WCBFqU0tewXlOOKjVCjK?=
 =?us-ascii?Q?0XIQ2GJfd7Q+AtLsSsuLR8w1Ut0W7oErzpD+grx4YwWvnvRJth1VIqTe+gNT?=
 =?us-ascii?Q?W7jTfElzOrdBZA5mQ3IT2LQRNO03QnLgBNsUpE7bKwCMLmjxiRS3ylXAWEFY?=
 =?us-ascii?Q?+wb7XYR8L9roVhGl6sIv2x/A4p5Ep1Ayfyq4dTbuIj2z67i1CpzN7u5n7wyJ?=
 =?us-ascii?Q?FF4MyJ3nS+JvY2NvQogee5TOGhvnDmg9fTs3aUMEerSXZ+CLhdWzXO3EHwWk?=
 =?us-ascii?Q?NUv8HH+IMxrzjAVKnreQyfP6STMWRpE7DCC3GNnlUlLF1+R17qwgNMXc9TN1?=
 =?us-ascii?Q?g3rk1NTKR7g1MeH6DwlT0tJi6rXTNmDWLxUKtH3ccnHg2fkO7hR7qpSLiqzE?=
 =?us-ascii?Q?k9MOnZbcf1k2f+MoNFRM5G4v36Oh5WcuyYXqLfyETf0CzRs1O9KnZR3SeGE8?=
 =?us-ascii?Q?zqVGE66FEZZuhfxqHdqJ5ylXUlDYh/yhH2Vs0hLe+x3pINq9BcjQg6/8etaV?=
 =?us-ascii?Q?LD6i61wWrhp56EXdv40SKBG4EQ1nSV9GhVKaFU81guwZA3LPqentVNgZokUY?=
 =?us-ascii?Q?yjEjlH3Ire3WKN2yBqUC+Kfw0jpeE4n3N2rwbDEnkJx4+bIxvdA5wYSAvPkM?=
 =?us-ascii?Q?Z6PxEJYwwmwwIT2cugLhpi1DxhxMz+KTe66D75+XhqHnoMhSNqWMtDrSSpux?=
 =?us-ascii?Q?xjNmHlqEQ2vs428LgyGndpj5w38Vei/L9A1FFFIwOqkBSCd5jHlctart5HEd?=
 =?us-ascii?Q?inaw+k4s9yAN+HnjAXY2xOzoyzaUyapmk93nj7tjyOL9MyzclCOGK9DjcrYv?=
 =?us-ascii?Q?6VeLecyXXEe9w3eRD77bo3OLcad0t6d3cwHFT+9a/P/VsyK3dvEoKqqmnyLQ?=
 =?us-ascii?Q?bN4B6KOcKX70a/uiamTxaGb3mp+xIluQCvFOU2hn6DGkkft921aWJP/2GxER?=
 =?us-ascii?Q?Ve/slekisE0N3wKdFwh8i8d3jvNI9c6x9tNbNrAQHUx8Hv+1QIgEqDbBBk1b?=
 =?us-ascii?Q?WZlwTWQPsz/hEGQ+YCnONf5pmdxSoY36NtzyCyPkeCpkL9HAnvlLg2V5Wq46?=
 =?us-ascii?Q?Ub/rHgjBb15YX2PUv7TIBFl7EBRS9O4GacskiDLZSozin+nfS0sFXSaP1NQX?=
 =?us-ascii?Q?B2Ap87uvOYk8+gddir22y6YlDTRS23Qv2kFDXTfzS6rB0kpYu6D2s3wRn9Gt?=
 =?us-ascii?Q?PI9cPubrI9XaAkzaH1uS7rOVp+e2JAmSH3PQvS+T1/930S94xrhc6qwmJfBr?=
 =?us-ascii?Q?0tJA5FbV9K5znvBYqQbUoYok9wdSqC0N4mwX9WnJEWVhMWKRnydulGxbR1pv?=
 =?us-ascii?Q?Nr+PIeMBGIfuWW+qf6YOc2GsHpfZrGnLaw2WFeThH3EMCvFrn0lta5fGwJ0x?=
 =?us-ascii?Q?Y+Ex/6K5KVrk24qK1eiB+N+NX5tHjoDyhc9d0dVOpsg3OivyTxHx55TRumna?=
 =?us-ascii?Q?/FGA8vhKjGm06x7+n136t7T+tUcYrwr+zrcyOs3EYvKgWSf7+0wpuwVcGLO+?=
 =?us-ascii?Q?Wg4/CqUVYg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a966f8-31ef-4ce2-8a42-08df1f9d8caf
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:22:44.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/nWym8r1EvIjWwCx7Q/Hmp5aBfsAwV5QBl9Utwvb1BhGr2n/1YZyPPyI3XCJgYsERnZEIIf5h6YErFGCsCsTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

Represent HDM programming state with struct cxl_decoder_settings and pass
it to the commit helpers. Keep endpoint skip and switch targets with their
owning types and flatten them only into transient programming settings.
Place flags with the programming state and leave runtime region ownership
outside the snapshot.

Separate commit initiation from completion waiting so reset restoration
can reuse register programming without changing normal DPA-lock policy.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/core.h |  3 ++
 drivers/cxl/core/hdm.c  | 82 ++++++++++++++++++++++++++---------------
 include/cxl/cxl.h       | 10 +++++
 3 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 983d7690c3a5..a3fddb2bed63 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -139,6 +139,9 @@ struct cxl_rwsem {
 
 extern struct cxl_rwsem cxl_rwsem;
 
+void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
+int cxld_await_commit(void __iomem *hdm, int id);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 9e05032a5426..d3f21dfda146 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -707,7 +707,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_interleave(struct cxl_decoder_config *config, u32 *ctrl)
 {
 	u16 eig;
 	u8 eiw;
@@ -716,12 +716,12 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	 * Input validation ensures these warns never fire, but otherwise
 	 * suppress unititalized variable usage warnings.
 	 */
-	if (WARN_ONCE(ways_to_eiw(cxld->config.interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", cxld->config.interleave_ways))
+	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n", config->interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->config.interleave_granularity, &eig),
+	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
 		      "invalid interleave_granularity: %d\n",
-		      cxld->config.interleave_granularity))
+		      config->interleave_granularity))
 		return;
 
 	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
@@ -729,10 +729,10 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
 }
 
-static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_type(struct cxl_decoder_config *config, u32 *ctrl)
 {
 	u32p_replace_bits(ctrl,
-			  !!(cxld->config.target_type == CXL_DECODER_HOSTONLYMEM),
+			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
@@ -764,7 +764,7 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
  * clock skew and other marginal behavior
  */
 #define COMMIT_TIMEOUT_MS 20
-static int cxld_await_commit(void __iomem *hdm, int id)
+int cxld_await_commit(void __iomem *hdm, int id)
 {
 	u32 ctrl;
 	int i;
@@ -784,45 +784,66 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
-static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+static void setup_hw_decoder(void __iomem *hdm,
+			     struct cxl_decoder_settings *settings)
 {
-	int id = cxld->config.id;
+	struct cxl_decoder_config *config = &settings->config;
+	int id = config->id;
+	u64 target_or_skip_reg_val;
 	u64 base, size;
 	u32 ctrl;
 
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->config.id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->config.hpa_range.start;
-	size = range_len(&cxld->config.hpa_range);
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	cxld_set_interleave(config, &ctrl);
+	cxld_set_type(config, &ctrl);
+	base = config->hpa_range.start;
+	size = range_len(&config->hpa_range);
+	target_or_skip_reg_val = settings->target_or_skip_reg_val;
 
 	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
 	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	/* Target-list and endpoint-skip registers alias the same slot. */
+	writel(upper_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(lower_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_LOW(id));
+
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
+{
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	setup_hw_decoder(hdm, settings);
+}
+
+/*
+ * Endpoint skip and switch targets have different owners. Keep that state with
+ * its owning type and flatten it only into a transient register-programming
+ * snapshot.
+ */
+static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
+				 struct cxl_decoder_settings *settings)
+{
+	lockdep_assert_held(&cxl_rwsem.dpa);
+
+	*settings = (struct cxl_decoder_settings) {
+		.config = cxld->config,
+	};
 
 	if (is_switch_decoder(&cxld->dev)) {
 		struct cxl_switch_decoder *cxlsd =
 			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
 		u64 targets;
 
 		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
+		settings->target_or_skip_reg_val = targets;
 	} else {
 		struct cxl_endpoint_decoder *cxled =
 			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
 
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
+		settings->target_or_skip_reg_val = cxled->skip;
 	}
-
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 }
 
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
@@ -830,6 +851,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_decoder_settings settings;
 	int id = cxld->config.id, rc;
 
 	if (cxld->config.flags & CXL_DECODER_F_ENABLE)
@@ -862,10 +884,12 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		}
 	}
 
-	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
-		setup_hw_decoder(cxld, hdm);
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		cxl_decoder_snapshot(cxld, &settings);
+		cxl_commit_start(hdm, &settings);
+	}
 
-	rc = cxld_await_commit(hdm, cxld->config.id);
+	rc = cxld_await_commit(hdm, settings.config.id);
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 237b31d54249..67c81be47fbb 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -72,6 +72,16 @@ struct cxl_decoder {
 	void (*reset)(struct cxl_decoder *cxld);
 };
 
+/**
+ * struct cxl_decoder_settings - CXL HDM decoder programming snapshot
+ * @config: common decoder configuration
+ * @target_or_skip_reg_val: switch target list or endpoint skip register value
+ */
+struct cxl_decoder_settings {
+	struct cxl_decoder_config config;
+	u64 target_or_skip_reg_val;
+};
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
-- 
2.43.0


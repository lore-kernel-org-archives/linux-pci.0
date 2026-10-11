Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4432EEE63;
	Sun, 11 Oct 2026 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684900; cv=fail; b=TleeQOdy4Jnz7o8KnBiTI+mf49ldKpZ5vxeZ22MJGGA8yRErX0yqZb7+8h5G+N+7/03UknMWTCmeJFSRG7ZL1qvNlyHAwR7iWfZeeI5HPndiTz/5VqqF8TPzQT6otrIG0A9dXZ37oS2zftU/OaaMzdnS8mwRYbDxzVjXS4ehh2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684900; c=relaxed/simple;
	bh=6gGh3T7D0uJd/2tYokXpH1m/5YjxLIi9SJVxp4gFmss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rxMiLWwe4FTf8KdUQ8tgyiVwWMfRshRgYdOrO88UwSXxkEwrjs7ujRlTJyoiluxE+0xA919PbBdT7aLAOvXRaGJ0t/wv2/hGgtNSpTbhSV0OJ9mz3cYul3WMRDbI1CmoI5SSG7rLDJBCUOP7PSikBFgHQKHd8piV/ogszHNsfuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kvvtOY2a; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kvvtOY2a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdhZYdJCF0e7EGQ1ALysQtz1Y7VIkSMEbTiLt9lTzbuB7TGGqj63iMd32/FjNZ5UIvxRqOTim70gAdKIl9DaIy3UFy/4m08JfcWlWG1X+v8FvOVC7Z4wjAf6AQx6btaF0/6a78NqAnaPaImP7MHjoxVJSK6tn6f5kBWbL/S8Z36U/66d04myIahUg7VtszKVYj3GKZnusd77wFf0uwFeK0fSQAzXCaTMLxqFrum8LnHiAT5yoxWDrWmhPGUMXWnymVgtN3a0BeJkMVxclBbp560GTtknbdo271QbCCag19boLFVRXRuZEgCk9bYBJmkA33SRLgTDTawecYe0TpYA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7x6qFMv79ouO/Djg3XQ/NWoNV/z1/sICVRLLY5w+6U=;
 b=S+zyuUfIJ/OHZqZELXE6aAY2r8BhbDmmd/VEzhRlNS96cDJhfRs9qZeAhX9bsbZRZFXLHuLrJTKBdSFNFDG89ASX/NxhLD/KQF1TlTScZzMd6M1z7JP+FHAQ0wyXrTWD2wmLv6DYTis/7mCe9nYdI3vyq9IW2FFYtf7NqMgVKSwJ7b678VUCwUQCmR3oesGce/XnBnhN9QI//0UQcZcyi0U8oeiuq7piXmZHEvkIVN/sQrXiZMM8n+0EaFHCgKuTsF62RUBSrBOIgo+imhAVqdlQBMyysAZc4mGpSdaNAfKadfgPbxA98zz5Y6Mo1BV2dz1UBI+aa4M7y+auyBZ6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7x6qFMv79ouO/Djg3XQ/NWoNV/z1/sICVRLLY5w+6U=;
 b=kvvtOY2aE9vDwmj05RPWobE5JhKuXHeurQyhRDzofHrBTcb6MUROsZ7j8mOGE+N7AU41Aa4tzXigrB5RAVGKZLmXmtKVjX876cU1SgUQYX2cdzhkSzuXJ0rgvAzBZ4LAS469DeXzsL7kqemuXq8ad9PmeuY8o4HR5JA7wQfw7ujDeTjwhkf0+wCpCXWUIeHX2sNdOhwOd4KLR2RFPn8Gwud9pPrqNZsxWLuJgxKmp0OxE2jO7tGjdcOXMTZniczoP5woKNauG0PHMB4serBYAguDKVoQaFuino02J/HUroXwp1r7QTqyfvHBbRRb1PTpMpmAsVDW10BCFy+2TVvCrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:47 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:47 +0000
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
Subject: [PATCH v15 07/16] cxl: Share HDM decoder register unpacking
Date: Sun, 11 Oct 2026 02:14:13 +0000
Message-ID: <20261011021422.3428136-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0309.namprd04.prod.outlook.com
 (2603:10b6:303:82::14) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 35589105-44f5-46ad-3895-08df273d6c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|260925021911599003|260925021311599003|260925022911599003|10067099003|3023799007|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LfvliC21Ak14GkTMPxZFyTECyf4SEae+lljmmauL+7zaPJ7TYsgPsDJEC9pWU2fOoW5HtLvIvEQ+xBpDihjjCCG17/aRoiS82KaCB60z5p9E46nPR3IQ7KjfidYSiPiiuxicL7szs5qmA8kbhODHQfZR2KUZ7aP/htzu1GZtenRSxTDjDrxXw+AzXhKJhFWUBjGTUJo8YBAh8dMOQULXU0pcK09RyjMiKEFSiHAYrkKqPFFqia3pjRglQmR2xrxCrVUEpSFK3uHth+Y3PGaqQCnFFMYP77Z4P2GFZOsS/qQmvpPhp0LYeeeouBqwDwQbBlZpd4LZ79F0+G4wt2r/qh4RMuXA+9iQZpU8rxqLRfYZ6VHZ46JqzUs8dO5MxcKymVqJ+cjs4co5x6mZJ+lYfSZAnNv8xT+Q7MiEDyb4qOaxjjaUzVDLQPXXdT92teUGVRBhTj6Suu9HT/U8yA8kV1gPx6WvncaaVRUw23N8J3tpWFfpSX6E2l8gZJXxD2pEpuYFEmH1DGhbC/oh+n0r+kHXptZ/04bBlsUGNrDRHyxhFe1fKbUhuURAVWf83wuzCamc/lh4RZG8b6GEGOY8VvNGyTefzA1Ohn7UnfjlLb8IAt5XM1nRp3u9jfchfjAv7hAICNTryFcGLB4W1SCocKuDfkItq6J35cW20TlDamCl+ZVTjE/6u377WMHGvDnWtrOujifhRilsIn9h6Z/YXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IVhGiCY8+u5WrpFfTkO84oJ7wg0Qr9+A64PP+s51vsO3SWWqw6t294lMLngB?=
 =?us-ascii?Q?iuAT7xV34dtoY+I/OT37ePuInbbzI3n0E/T5ngbXrFiQho4Q9zoBP2twTGJz?=
 =?us-ascii?Q?98KGF1vrUUcyLmJji7kC7Q/WTAnCN+AHBZhL6dFTAra7Qhe6QvdevXu+M+BW?=
 =?us-ascii?Q?y6OS6TlyABhNCdN1PgRm7iLQbdZBKdxcyJS4UY7C77dSAVcncp+kGGwDciKf?=
 =?us-ascii?Q?132eNNVUm477+31XBpN29SOtS3sqQivd7ZOTrlhNglnxPsRzmXz1dQ+caK0E?=
 =?us-ascii?Q?AOqn9nDZvua66smKPaJKjfoAdrqVuHjudaQ6kFmrN08p3ieC/ONyYIR8/suD?=
 =?us-ascii?Q?H1gU22532g9xFUgU9AymaTnNhocShv03ypNWH+oour2PKIeTFh597QmckJyL?=
 =?us-ascii?Q?a3vPWhroE0LbfvJzEVdi6DpkESefFR+2FtLK63vYJ7JKjQQP9Jq/gZ5qya71?=
 =?us-ascii?Q?fXEFdUKtdjggt/bDxYBDDdo2MHvYXHuLQRLZUlrOhSDGZoE+eaKzKw8W70n/?=
 =?us-ascii?Q?IWK9Vy0BFZ0y1oD9whqOAVIMTZycMPCc5es3o5ZWCS+O2dX9298YxvYCGFJd?=
 =?us-ascii?Q?+VwGU9TWsuCjhthhAhGPQsxzNbKRyYb7l5XmPftkAFMUZgEoCoOJOuSNVrP/?=
 =?us-ascii?Q?gGqVZUaPq3pwCK5edXEkBkXgeB0wzL2u43Y1PXlLXrg8yxl+UHtyarydL9zm?=
 =?us-ascii?Q?hvPYObc7jANNkwzC767nP87l2iiZ/zWmu5RBHI0LqX5i5DhfjcTHin/NGCqB?=
 =?us-ascii?Q?1o1M4/N5m9IDELVnaqaPwJ6G6AiEPb3J7iHlongRr2en5+nnwx6PHald06h6?=
 =?us-ascii?Q?YsqV7yzctOP1UAP7llm3ILydASmBH47t36fdVVt/tVpppVkh4EVTb1e1R8f8?=
 =?us-ascii?Q?RhwhO/Mu1pzGpfEYdIgjEF1byVx/3XZm22VESuMqydlnYLHDDTvZossdZI33?=
 =?us-ascii?Q?YW7GPJPGYgYzrfnad4Uc5PD0E4LghOkuZwVSlljNcGnbyYlrzQE3iF9XB7na?=
 =?us-ascii?Q?S2Cae580aTWDgevIhdr5MiSnBcZ1Z704MY6ku7xfzfD0K6gxiK+RHf1hF2q2?=
 =?us-ascii?Q?xJVg2sR+T3umLVsyL3TkJCrpUlmLFlUbSvyJ2oRLJbQHvO6pUiiZ8CCq+bwn?=
 =?us-ascii?Q?CDPbgiOD3i9l8sdyKFr6OZd+5mPZwT95YHSpmb1c3+h3Bw+065N5pKfcHY4i?=
 =?us-ascii?Q?l5xKTPYgfVe9lS+V6SmOFugVZ7CiRHSmpSli+ATllF830Jsb4O4FDw8RCgxZ?=
 =?us-ascii?Q?q0i1vFg+EP30szx+KcSjTvuaUDp06d/brHw2MWyAmq8kBICHRrZ+TGKy1Hho?=
 =?us-ascii?Q?I9HAh2zofcB9TTA1y1R3yryKbOI4WdrngHaELc4N5sGVgEKcvv9POLrqxdKJ?=
 =?us-ascii?Q?uJaJsvtFNVB4tIvOvyf+lOdiVI6u+gnpou60fPKtGl+OB2v1F3gByvsFoquZ?=
 =?us-ascii?Q?fNv/C47dJcNN1XynOBkOTc3LSVZuOhaZQC13gl3vWhdE0SVAZ5zly1hFrYGR?=
 =?us-ascii?Q?OmdOF/2Fh7fTwI4hCB5e7yco/ZauGsz8kJ1dPMeiVjsHcSoWiVTwfrM0ALZ3?=
 =?us-ascii?Q?mC95tRSneuljsljsD7lD3X/HxYDlUEDN0OnjHvgCzywgx/b8ztnB062f60O2?=
 =?us-ascii?Q?JUjAFg+H9YkXn/ERB+lG8WEAm/lpsUiMMGQy1xdslFyZSn7yoDsaCmyrLizq?=
 =?us-ascii?Q?y0CAmHUxBRhF2FY9mKb69aUvHw8fN9htMS9RzZsSXskqrM5xl7YFQcTK1d7d?=
 =?us-ascii?Q?5w8gqQk7Xw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35589105-44f5-46ad-3895-08df273d6c75
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:47.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAcnHo99vQUK9hYwmBy7gE8sGAjd5u3ZObDszF38bhW/kLyYmogEQ1bi8nWw0bjfTOFNx4vodmXNxnvt9Uz8dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

Factor common HDM register parsing into cxl_hdm_unpack_decoder().
Validate range and interleave parameters in locals before publishing the
decoder configuration, including enable and lock flags. Reject nonzero
ranges whose end overflows the address space while preserving the
zero-size range representation.

Read switch target lists and endpoint DPA skip in their respective
branches of init_hdm_decoder().

Preserve the decoder ID allocated by cxl_decoder_init() when publishing
the parsed configuration.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=7d6ed7faf7d8e14abce8ae23902d5323738868d2
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM
---
 drivers/cxl/core/core.h     |  3 ++
 drivers/cxl/core/hdm.c      | 54 +++++++++-------------------------
 drivers/cxl/core/hdm_regs.c | 58 +++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 41 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index fb14b222f3ca..d69864b25656 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -147,6 +147,9 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
 			     u64 targets, void __iomem *hdm);
 int cxld_await_commit(void __iomem *hdm, int id);
 
+int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
+			   u32 ctrl, u64 base, u64 size);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 47cf49bcd2e5..1a19078e6c6c 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -939,8 +939,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
+	struct cxl_decoder_config config;
 	u64 size, base, skip, dpa_size, lo, hi;
-	bool committed;
 	u32 remainder;
 	int i, rc;
 	u32 ctrl;
@@ -960,35 +960,24 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
 	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
 	size = (hi << 32) + lo;
-	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	rc = cxl_hdm_unpack_decoder(&config, cxld->config.id, ctrl, base, size);
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
+			 port->id, cxld->config.id, ctrl, rc);
+		return rc;
+	}
+
 	cxld->commit = cxl_decoder_commit;
 	cxld->reset = cxl_decoder_reset;
-
-	if (!committed)
-		size = 0;
-	if (base == U64_MAX || size == U64_MAX) {
-		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
-			 port->id, cxld->config.id);
-		return -ENXIO;
-	}
+	cxld->config = config;
+	size = range_len(&cxld->config.hpa_range);
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->config.hpa_range = (struct range) {
-		.start = base,
-		.end = base + size - 1,
-	};
 
 	/* decoders are enabled if committed */
-	if (committed) {
-		cxld->config.flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->config.flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
-		else
-			cxld->config.target_type = CXL_DECODER_DEVMEM;
-
+	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->config.id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -1022,23 +1011,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->config.interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->config.id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->config.interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->config.id, ctrl);
-		return rc;
-	}
-
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->config.id, cxld->config.hpa_range.start, cxld->config.hpa_range.end,
 		cxld->config.interleave_ways, cxld->config.interleave_granularity);
@@ -1053,7 +1025,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		return 0;
 	}
 
-	if (!committed)
+	if (!(cxld->config.flags & CXL_DECODER_F_ENABLE))
 		return 0;
 
 	dpa_size = div_u64_rem(size, cxld->config.interleave_ways, &remainder);
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
index 53d2f236e49c..b6ee4becde8d 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -116,3 +116,61 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
 	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");
+
+int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
+			   u32 ctrl, u64 base, u64 size)
+{
+	bool committed = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+	enum cxl_decoder_type target_type = 0;
+	int interleave_granularity;
+	int interleave_ways;
+	unsigned long flags = 0;
+	struct range hpa_range;
+	u64 end;
+	int rc;
+
+	if (!committed)
+		size = 0;
+	if (base == U64_MAX || size == U64_MAX)
+		return -ENXIO;
+	if (size && check_add_overflow(base, size - 1, &end))
+		return -ENXIO;
+	if (!size)
+		end = base - 1;
+
+	hpa_range = (struct range) {
+		.start = base,
+		.end = end,
+	};
+
+	if (committed) {
+		flags |= CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			flags |= CXL_DECODER_F_LOCK;
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
+			target_type = CXL_DECODER_HOSTONLYMEM;
+		else
+			target_type = CXL_DECODER_DEVMEM;
+	}
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &interleave_ways);
+	if (rc)
+		return rc;
+	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
+				&interleave_granularity);
+	if (rc)
+		return rc;
+
+	*config = (struct cxl_decoder_config) {
+		.id = id,
+		.hpa_range = hpa_range,
+		.interleave_ways = interleave_ways,
+		.interleave_granularity = interleave_granularity,
+		.target_type = target_type,
+		.flags = flags,
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
-- 
2.43.0


Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C66353A82;
	Fri,  3 Jul 2026 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116326; cv=fail; b=EjfnjwIapBJojb1znrIAVlWVW0H4TZMlnr7gjAlHDLZ4XD6ew6o8SvMeRLyPT48oR/59WoDfA7/VdbABWOSso+JYW0rt/U/RHaoAC4txALRsNxoQChp0nIfTYtTiqv47ezuZXoVtDvL+nPx3Yfrj6pMpt3pNdvuuy7jkYkaZ0rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116326; c=relaxed/simple;
	bh=nrqQ9Y/ND7X8YsiQmDRfgG/BeyJR2F9wwEAtua18arM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdSJLMz49IUvkTokicfTJutZ/OZpXWKbz3PCEL0ORWGrQqviq7B4L+oTJlypAPCZCAzFCtgcWBURqsUfX43cb74YTvUS+MMjxH8QwLpVIOT2ind6PJe2t/CG+kDViKIgUTPEEKxtn5j8HqTDy/ecpuKyAGgVINQ9qupVSiNrNfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DWV+/IH9; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DWV+/IH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSewlUtpMYKfU1PSfRMlnA+wcdpWoJo2WqkgPxXGsmKwXWgdpJ+36EzSzP4rYfeZjgybyp4NFWXGn9MQZq32mhaBH5WJkayDyNcIU5YYILsobl28PPOOiVBQmYwRLD0lFsdeJRYguOdy2sAtuq4qtGQ9x2J/1uUTM+q8T1awdcvKCiHxQx4M22yN0Nvop983dT5v0amFoAuWJYejt/DDlOESfXJHw692fciAwNr297sGFwUcSt2kPaDb5NlVrhg6osob87jw+R3jVwX/OYk3Yt/qZPgp/TpRpRA+QHcTbCXAxQuuCFrPoFy15zkVLiDEv+8risI3p3C5SdiboIpN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta4nHjTYApOxKeZq31gakMwXUiw/E63x0fZtyKu2YLQ=;
 b=TCADjWvMMn2NBEaddyWKxvj520pfIZUZUG6kd1PZTCHos26T1NP2gWQfq5jHYZm1Sr/shCCq70iB7HKkw4KAJFapMYLmPBC7xpUYZvURqfDbIiNh4OxtC1miAtIKtaVUYPPgp3NmROxeGSaBH6R6j9quFPPZ0DnqVzCKkPiPFNV0tU6utVz8JuYTTaJVBcnf9ftIba/2IryoyWwFdk1pcjWKAUCKXJmTBhn5W48kyWd99xihBKn6iS/t9KYgHvaNm8GN5SZC3LiUcVOvtYj22HDiP2PKXAmE+X3tuZz+nrEI5Yaopz9yRQ+VOxpTbTHfc6i9n7qH/4EJ4fuy0Wz7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta4nHjTYApOxKeZq31gakMwXUiw/E63x0fZtyKu2YLQ=;
 b=DWV+/IH9OJIzRV8+qIBuxYHLpeGtCypu7hufkI6Kn4BaUo8WgUTV0UDglqrjqG0nx0wL8+hmRCBJxu4KlEA++BBZBwJ7LE+eoeVX4PEJ9gjtwR9mdbKPlE/MHepE32uERnsNp7cfNnWK+R3odwyzxAUV6XzPM7fKq3m6IayacCUR0gR9jsxqV3MomUqSGLIsxYHWT0nuDofcfLMn74Bsq1mtarTK9j1kcarfEBd5xrWiSMxSZqsIci/GZuFND2JS1LO7jC3FNrtZrrMPDFgl8JYIdsWPd0sHqHBHLB8zua/KcpdQTlCdTDnHjY1E86N0kRYkQ6Au5aEQ573z1lrdEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:19 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:19 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
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
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v8 03/10] cxl: Share HDM decoder decode logic
Date: Fri,  3 Jul 2026 22:05:01 +0000
Message-ID: <20260703220508.546528-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0047.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::9) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 18eb742d-d42f-4d83-7691-08ded94f2b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	8kQkoR6eYwLMWfg6wgGnorQQgiMciIU4lhh/IiyjHZgcz8DBmJo052sGoAfNzlpwzuFUX4KturdsxDXLJcpyQolQLHHjoXV4j2mOr1MSl2sdaoRwrjqJYYujjzgBPKBSzYXekCEOTkrH64xRuFTbjHBJoOhcnrWgmFWkDuqUBUl1Ls91U+YqPEKD0IUljIJoWa8pMPBCQoprTsg80c00fmadZ3ZHpBABaeDY7HY9rmdT9NvccYDicSIssy9bFZm3onuaQIsvrEZev4lJ1Y+E950L8n85S7l84AVUEqo32/k5qBcw462n3FAcibNISByglv2PHHVIV164uH4hDHcTYNuUlqSd/6+9d/yok1MlwYiMcZCWrRJ/6Z7gXqqMIo3QzHcX6LrgdVw60CP+n4P5v5CWzCefjIXy4D6bKSzfywtqGB9ZaX39CeIXHnia+KntQK6VWLXlPnUp/BBVaDzbNGa6MAo5cemnZCB3Xx6k0gcblIZjn9bYce8jL9MZLuOoi0ako2gSUy0r80Sgc7Upl3XCLlcb276lL1LJNcbjCLR/hgSd2+BMQVxEAtx5vhFa+ztbbyYQfd2w7Gdoj/dx9Z9Ih1udorns67XZrxv26xOHmoJ4VdrcsNhk78Ut+UhmfT9zNdud3hfddoIsWFwH34iPmBryaymuiLcpZU6MB0Y+IT394vQenz23UCZLfbaQOF+c2Lpn3+MLes+a32hfWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Uv1rnUfEekhGmxFB9fPT3vdGFYWOQ+o6DWVrTM7yBoL33e3AZLNpVwiv/ly?=
 =?us-ascii?Q?qrsHfNwaqTF19dyVXTyk8sy74zXQm87Vu0/NDxBYB3Q0YRhpcK2yrknTjz46?=
 =?us-ascii?Q?UinAfj5BKDTvwVIZv3rcRvkyvxiG55AGVPC8ZJS6euoEYOT0YZ+R8eBLEzIh?=
 =?us-ascii?Q?9yTNhLpAmoLpDeEpC1cVbde2GlVFSBeELWOw+KF0rpquinBD+tZkGLmMn2fN?=
 =?us-ascii?Q?wR+BU03K+KdgA6y60EMirX5vuMt2XuhxDNwTolx5ky+TVoG2xNJOHCgXxRHi?=
 =?us-ascii?Q?V2SIGMT8yol7ApkeEICAwywZwQ7Bw4/sAlmMNQBSmdx9oY81jcGSlTVe7QNw?=
 =?us-ascii?Q?SsD3wp/sYrPz1+IbioPW/69B/85pK7Y8Jzd6QMQjiN97T4VnynzxztOq4PFl?=
 =?us-ascii?Q?y0rtYHxjy7S1Vpkteh5YGApmcDpKtUUS9RDaAitZiKmbl1N/5O12FfRUzwts?=
 =?us-ascii?Q?fiK0orwSsLLOhsscmRBGUy2XUey1h8xTKrnC5YfNe6rBaQMNBFq/UxSj4FH0?=
 =?us-ascii?Q?LBvcm5ipA9mX3n/wPy/X/vvLFN2RLwzGW3MmbJhEZD4NtLkcRkGfZ3Ypb1Mj?=
 =?us-ascii?Q?mhdzOzCYZH+hNKimtWEjGE0B18v09pNiBmuEMC9V5sNODrx7+0SLGShr2X2U?=
 =?us-ascii?Q?glUnckWdRpgBBBh1xVDBVfruIfK0CNrs1MHBpORhI7MJaYAKVwDcmr0eY79K?=
 =?us-ascii?Q?XAyRa10ucsTExLJTEVVLQDa7+hgsuQhPCA5Ottg7/hLeNIK2bPB2ku5S1Pfq?=
 =?us-ascii?Q?2HpAcF/K0eSHgCub2IPq1eC9OkjttaoxDrVLFp86Z5Pr3CrlrZoF5l46+zGm?=
 =?us-ascii?Q?F8JeKsayBfkROyL4A/Q+porpknJCB6GsOvwR0WO8uu6ARtX3ttdeKhY4SS8l?=
 =?us-ascii?Q?+z/jpNIg23KexqHn0SQd8NxZstP1mdKWQjuJkgNC2+RFGDz7B17uziNVXHJL?=
 =?us-ascii?Q?1Sl9s+mnBwZNrvA57UlUjuZQdRxpfLft9zshk6/pftDY5SuvMDMKABSNtoUH?=
 =?us-ascii?Q?/7WZ6qRdWV/senF84rQUWLdXzdkhgaSVO/lKfKIfh2t5Ftr8y/lMjF+CI4jT?=
 =?us-ascii?Q?6CwmpUbggi2x0K9754AeoOKSDGBAVz35iWV97UjwSymbs+1MnSoztMtYM5kQ?=
 =?us-ascii?Q?LyOOVKz7w+H1+vBL8nlX/f6NXE+7wLjId9DShzRj8P5OtionFW0jwSfStrKa?=
 =?us-ascii?Q?f5jZWcnGWFDY4Re80sJo1HgznHZGFa+7Y7MRwvvdrGsb20Y2pyoW+E6KRBsI?=
 =?us-ascii?Q?II/QGIsK+XPfTBA8ibr/cDfbNzL980v2uKHl2baV94hE+3XzEHHJ3QGSVZZS?=
 =?us-ascii?Q?rX6zs/tlFzVmEs/dwzrnSDXuonQ0jH5U7OXX2nrwYTjwAeElGoDvqj2hZL4n?=
 =?us-ascii?Q?LAqRUfIqakrPzeP9p0R3R2o3sorRYtLZ3N1+WBXXpNFn2ybgnCTpm1KruUJb?=
 =?us-ascii?Q?o1pEqeY81qhfnPaNHXq5uI5p92pAL0zR4deXqUj0qMEsJFCeu3VF8Rl4QspW?=
 =?us-ascii?Q?BxUDjYk/3ZMbsBun1fC+drrXfPSNPjNqN3VdJ+KcuEOXYm3NVpLBIQDV3qjX?=
 =?us-ascii?Q?xrefjZnoB0ipaBuk9dwhdM2i4DLHK1ywnepNtXmz9bzx95wEfhQe9RGwYMca?=
 =?us-ascii?Q?/Bsjx4FHpwn+OCraVDijzRKnzO//1wYV9i46jjaADDaa0HcxtOpV3GOR9Vsd?=
 =?us-ascii?Q?qNylERJE9kRt6I7JzytF2aVbGPfC6pzX8uM8kMaN5BxwfwNppBHlDbljqzgx?=
 =?us-ascii?Q?Bhf4z0o1Lg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18eb742d-d42f-4d83-7691-08ded94f2b9b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:19.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQ9TJU2b7zNj5mlJtJwI6BPumMtl0m3o0RWBHOZ9dh9BhyJY1Zop8NUVpJHn1pWbc6pUi3ikM12bH5ypiSpX7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

Move HDM decoder register decoding into a helper shared by normal CXL
core enumeration and early PCI HDM cache setup. This keeps validation of
base, size, interleave, target type, and enable state in one place before
adding another HDM parser.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c   | 60 ++++++++++------------------------------
 drivers/cxl/core/reset.c | 45 ++++++++++++++++++++++++++++++
 include/cxl/cxl.h        |  3 ++
 3 files changed, 63 insertions(+), 45 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 83cda63f76a5..bd1d92e5add2 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -968,35 +968,28 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
 	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
 	size = (hi << 32) + lo;
-	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+	hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
+	target_list.value = (hi << 32) + lo;
+	rc = cxl_hdm_decode_decoder(&settings, which, ctrl, base, size,
+				    target_list.value, &committed);
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
+			 port->id, cxld->id, ctrl, rc);
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
-			 port->id, cxld->id);
-		return -ENXIO;
-	}
+	cxld->settings = settings;
+	size = range_len(&cxld->hpa_range);
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->hpa_range = (struct range) {
-		.start = base,
-		.end = base + size - 1,
-	};
 
 	/* decoders are enabled if committed */
 	if (committed) {
-		cxld->flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-		else
-			cxld->target_type = CXL_DECODER_DEVMEM;
-
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -1036,32 +1029,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
-		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
-		target_list.value = (hi << 32) + lo;
-		cxld->targets = target_list.value;
 		for (i = 0; i < cxld->interleave_ways; i++)
 			cxld->target_map[i] = target_list.target_id[i];
 
@@ -1078,9 +1050,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			port->id, cxld->id, size, cxld->interleave_ways);
 		return -ENXIO;
 	}
-	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
-	skip = (hi << 32) + lo;
+	skip = cxld->skip;
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 14f024098e82..4c977fc47f8d 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -116,3 +116,48 @@ int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm)
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit, "cxl_core");
+
+int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
+			   bool *committed)
+{
+	bool enabled = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+	int rc;
+
+	*settings = (struct cxl_decoder_settings) {
+		.id = id,
+		.targets = target_or_skip,
+		.target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
+			       CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM,
+	};
+
+	if (committed)
+		*committed = enabled;
+	if (!enabled)
+		size = 0;
+	if (base == U64_MAX || size == U64_MAX ||
+	    (size && base > U64_MAX - (size - 1)))
+		return -ENXIO;
+	if (enabled && !size)
+		return -ENXIO;
+
+	settings->hpa_range = (struct range) {
+		.start = base,
+		.end = base + size - 1,
+	};
+	if (enabled) {
+		settings->flags = CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			settings->flags |= CXL_DECODER_F_LOCK;
+	}
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &settings->interleave_ways);
+	if (rc)
+		return rc;
+
+	return eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK,
+				    ctrl),
+				  &settings->interleave_granularity);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 84924ca06e52..80839517eabf 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -133,6 +133,9 @@ struct cxl_hdm_info {
 	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
 };
 
+int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size, u64 target_or_skip,
+			   bool *committed);
 int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
 
 struct cxl_reg_map {
-- 
2.43.0


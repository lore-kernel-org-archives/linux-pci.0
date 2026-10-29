Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285839;
	b=4NlsPOSGaCiE5Ujji3mzAwVo29bbQwrrJ+AjjYwO8eQ6gas01qZEPuEs+CGdZVKoe0Zt
	 OqNeA4/MuMYMk6HSAxGvNG0S89fyC0s7MsDVpWEDDdfB+ChvpqXHqX12va/oGezcnTf3P
	 74fghpEqr+1hba1XjTStWKAfclpDFDQllW6pF4+9/l6VCuGyavV6Hxei4f0MK0SypaiA3
	 wbhDOOUt3CzIDSFFpA5kW2i7ciBSBj4pR7DazQD61RHNnvoCRWeBVBZtDGt5N1+FBY5uZ
	 YE3dfhPvzhAGPsYFF/VcG+gG5sSHNDZ4FM8tSuDBaragt1EHcUdbilgCoWP0SBznMKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285839;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=t0a/v8azAOP14NZE2lQjMyPdGcxFd1OXJgNWJNqERmw=;
	b=JwQbJ/vXJGadkHmSop8UnXwdA4LipnrNBr8QiqxfJpCDYd99fvC0RJ2xhtHTJ6v6Z9eP
	 HsF0z7U79ROXgckNTTXTS+RCVbHIob0Pcwr2sC9w9b09zizkuAvPlMIMK1j2fH6zmmdz1
	 AeyPl1urCYIyd3E/+7/BjTMiiazgkNovP+OLr7jCNSLaACDVw87hVFJd3l/byBtfofwKK
	 dCcbWOtmlZQX6iY67QpDV5VDER2bKkqcegz6KLKzi2FGSZgUSicI9IVx0R7GgXv02zzz3
	 e1hiQ/2wRMCLNSjRc7MfVCkPPa8VfO1PdvcBWdpNtMeOjqFDRO7BWNfQVUTTLSwVIMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=byZYQcZk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.14
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA3606A320;
	Thu, 29 Oct 2026 14:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04BA3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=byZYQcZk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEv+ODCL1I0dRJO4KRCoG6CcAJy6qvlC+fXuyQNR8Opdiom5dWFubZO0H4v4hTeBLRnjxGBMQ85vNGmBEDRGeGE4UVBAlkYRUt7/NeohW9/kHJXaoYTpp2tQ/+ZfYN+EZoiMyTgvtOZ3bKD28eFJyzvO7NhsIcF2cUziuRHuVTkG3EU7iB4pPwBWhno7Dc8BTuopU6xHdeUbNJJcJBu3t11bm9I0yXuYfoZsEl9fEYv/rzBxHpSeMByKFNx0v0D5WCVKxyEGzRuJpMtNw2wa7P+CefRrRCBd3yANJ52eFehbTo/v6POagfDYXedGfNVz8+doA33aUbMhowSs4/1oZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0a/v8azAOP14NZE2lQjMyPdGcxFd1OXJgNWJNqERmw=;
 b=pU7wHU2vBw5tv2g8G2nJ40l7pBMMeazdwgScjeqIchDIlfWlIMm1uNY5zs6kPiiiieZvw7yUQbJa//Z1e/ueoGi7rsd94xP3WfRMNc3pdaS4YxUHp9cEHcFPDDi8NfA8JBbPXepyNXEDRbDTWHTcomVf/nN2mgRoI3w9rnQ6GAVoyvJCJuOz4AcX0dpKDzPvn6GbbS5uzj4AAbDZBcdmxN6rP5AhVjVeXaA/bRwfK7BlB9zKmc7UsfQm6Y+vRz4pdhzDZYjz7rzydHKOI2hwWGA5q1XRFX3GttCrWiN2/onue60Bp/nsjjLz7TBuOBdWCDtXpRlEWHATQUXq3rmIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0a/v8azAOP14NZE2lQjMyPdGcxFd1OXJgNWJNqERmw=;
 b=byZYQcZkm52JqVaM3jADrCUE8Xf9vl9u9Pnxbe/7yIzjIwpvp0Gr/ize7EbokrGi969wmI0jrgkDjG5W8R02B6+Zto5v6P6ouXLTeggo5vRc14dJj1P/LECHvWYU/xZrzOLY93PJEe8szAGZRT004IdrHWV6IwJkDm/rVQ9Q0QK+X5+Te8UKDnmjGUBWiYFGqZ0ApQCTzJWFPC5BC2HTxMws1745sQ1yf9A2xdz2umx4aKNubjMJ87XjwrDIq9gNaWVCbMmGajBu8T23172E8mYQMOec3ZCZ3X5o4as5QFSgVn7VNfULWyqXPeP1NpApzWkmgeblOgwhOFYdKGb1Cg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB6014.namprd12.prod.outlook.com
 (2603:10b6:408:170::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:16 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:16 +0000
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
Cc: Li Ming <ming.li@zohomail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v16 01/18] cxl: Clarify decoder interleave limit
Date: Thu, 29 Oct 2026 14:56:46 +0000
Message-ID: <20261029145703.2185231-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:303:dd::31) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 8368484d-c3ff-4cbd-829b-08df35ccec16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|261028144727099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uN8YKlRgQbcACKU++FnOoJphr35svQfGHt8ofq0M6BK7uvkFTCGPzMp1duGQthQsJV5mNvnMgxR/daGl15uFCTuDSZ0CpRgh0CsjabfI4eh/ZcJDC4lPOuvgkFqDZPIQiRsv5b5G2H+SDgmzZH2kf0WcgRNhQWgUnfH45p4IRetxFnXIt/Y6/79wF8ia7H5YMS0uv+Ll17NUTxf7RoZ+miZr6l3eAKnVD47PpAwr0emA9HjdwjsjZ99T9TynxFCteph1pSPGRwaNBEgSc9JkywVdmaTpMJ8clFLxOi7qXI14xrXO/Y7YCwuP2kQBgxzzGQqvJ+eX1YNV6RNU5+W3XqnYxwDZmfq/jj3OC8r7tkhf3aeaf7w4frx14+BeQZZ0aa78OVDvzvAMLzCYS918omBLSfzRzvE5fLQOQc74xrb+1QZar2LkLeMbjOo3dZ05vH/2D+aPYrVEu95Vj3yRu+E6UFLvmEYbK6/4AQGxee/J7edQ5uRUwTaCKY3EYGQXe1nS7xp4N6tRyTJ8NpE/3NPpGuxL0Ojtmuz2FL8mTPxBZoIU84Ex9b9a5A884P7Rs/W9vGZD98xsM+6AGfFwyBZM/r8DTwqTAhj0UUrEV6uhVRObabU420LDgJ3ohhZB7eyvNSrQUifCs5coxc9DaX7uX8y2RsiyyZi3Lk1CMewDszX8KXbMaCCUBpbb4A76Cn57Q62EZoehbnpUyvLaqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kJJzPmmvRAN0ILYRygBkvKLyeSSsVNCOieTOwkeVnaGnCH681GqiZkrk7W5h?=
 =?us-ascii?Q?32zQfyr8XVZ8IPrb21/Vet6aMomsxCuYH/2YJ4RHki1fAvSD2sR5tb78LMkq?=
 =?us-ascii?Q?L8w7MblMTWzRZecNzg/Zi3T/IEK7CwsXslVi5IR+dL5jwL5SCFwCiaQDVvDZ?=
 =?us-ascii?Q?tRzauTdScIRYNOtuGbWDlCYDg/UGks43tkuHzU+hH6SXDBvUuf1Uguc6M3eL?=
 =?us-ascii?Q?w/Jk8LU74t40kgo0R5tZjAVtGSqKQeaYu9DY+vrw0ArvRKd6ecjkoaN1pvft?=
 =?us-ascii?Q?/BtsbquIf8JLALtF5hgwMmr4wJNUyUL8zMomxeuWnPZNyZyJkNTpfQ9k7bV3?=
 =?us-ascii?Q?zNGdFa5N+7Wf3skOx3v++14YkNpsZazyQ43+cAbJRUfTkSTaljRVxqjp72UD?=
 =?us-ascii?Q?1wWFaUr10JdXM9DCNrP8yBVqK91UT6s4GKuHNbsSBHP57CwnF1zg11bgCJqq?=
 =?us-ascii?Q?O7WUca0+6zDiuuehcpDQ8ZxjO5xGmU2GJpPx2/hI5Rj7p8IVhEaLFzAF0pBt?=
 =?us-ascii?Q?Okdvy3imHsh2pDp7MX6h78eq6Ay0jbSqM5tBC/v7EsAjXavv/21ZC2r03Lp7?=
 =?us-ascii?Q?mEYYjCiO7EZrn+3UcOomseJ1o1b3LR1IRTREh2QaQWG2TEfAMO0xBOe1+Et1?=
 =?us-ascii?Q?VlUY852MWkT2Pt/JsZzHI0ZeSVOIoV9zHXkpFxU2aM48htUEso8AEFaRi+hq?=
 =?us-ascii?Q?HCv+GPCaP+2m40Qp6AH7LFiImuP4k0km6MHW548TVIsdhGSzzY2bsJggJxtf?=
 =?us-ascii?Q?9k3itJ5+bPAYwbUmktW/3L1XwQ5LW0CAr9BykLbAk5otAeAbA7X4jOLISDeh?=
 =?us-ascii?Q?GvDn7TjT/i8YOyLmZI680q4zGC2ahFyNBR6zGTOydxfDjScUd182e67+5f7k?=
 =?us-ascii?Q?Ots1Vw6iShqlt3wyOlBAZ0o19d3uyr6w651T7XXs591RdWtgwMDswE141Zb/?=
 =?us-ascii?Q?VNs+Yerjpt7Zaj2ZU4DkXWQEVpsHXy5C4v9dxZKLFtY3Uzc1ETS04Mlea3T1?=
 =?us-ascii?Q?mz6YUxHqDv7NsE45i2MDb6oOgSrlFCx2ZJ4TWN22OMeX5ZkhQ1r61dPbCEhH?=
 =?us-ascii?Q?yM6373LEZt4/SNlqycnjkuVnHRLsFWio3e9spnEgMuSBv240PgiUho4kteSY?=
 =?us-ascii?Q?HSzjFiu/NGADyVZ3zbFdPvdjyhWwVXtTONrLJQ5y+Yo6Oxet6R34oDBJaMgT?=
 =?us-ascii?Q?CGV1CUAqsJmQk3gZdrupVQ2PIRot0VNqF0sZ+JDZbRf3lVOrN2GnBEC0z/8l?=
 =?us-ascii?Q?Gu9uDRf0qOvPHeHMXo1XKFqe9MBMbSMKPOZmjAYd16pZnjDcSSxhjeWxRaoE?=
 =?us-ascii?Q?0IMmxrXHjIb4GbX0UHTDVVl8izowG6ny+G2khXFg27xw4oTbZtFsfFNN1sNj?=
 =?us-ascii?Q?8IZLzeDE4cIAEUhkfDCGythY90Xg652IFTHQCYB9M7B+dB0sMxkgU88VsB96?=
 =?us-ascii?Q?Mz6dIj4jbQyBBdPCdWc3E8Lfs9OMv3XHElY4m2uwyDUEiu8wNbTEd2m1RZ3+?=
 =?us-ascii?Q?PYx8vJNHrLRJ9+0NTJZbxFRypX7XQMkklUK+MUoQfwUGDKjwSjhxjXmlE4w+?=
 =?us-ascii?Q?rAUMYq3GjOMZme0dDqR/4kMWkUvn+sd4aYbMAvrOq/X0nwanSUdjU3iXsTqU?=
 =?us-ascii?Q?8bR7YHnLUWwIZeyFtNtj6CM3mhy6zoix94NPCW+ExQHu71dIvMiXFL6Ftu3t?=
 =?us-ascii?Q?aDGO7c2DAkvfes2EWd+RzBLuNdLWSNdIKl/u5IBsu2FLX2MlGipr3yfBKlSn?=
 =?us-ascii?Q?HHIhbH93tg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8368484d-c3ff-4cbd-829b-08df35ccec16
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:16.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7kr9jZu+gcmcc6mRbTZfNwAyyz1lg3P/avQiSrGxl6yHS0+7+YLAZjDPNroqpjYhMUVqIHxMfiyc1XVumcYSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

CXL 2.0 added 16-way memory interleaving, making the comment that the
specification supports only 8-way interleaving stale. Explain that 16 is
the largest interleave a decoder can express, without changing the limit.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hlaptop/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/cxl.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3ef0810ab86b..50af716f69df 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -269,10 +269,7 @@ enum cxl_decoder_type {
 	CXL_DECODER_HOSTONLYMEM = 3,
 };
 
-/*
- * Current specification goes up to 8, double that seems a reasonable
- * software max for the foreseeable future
- */
+/* 16 is the largest interleave a decoder can express (CXL 4.0 8.2.4.20.7). */
 #define CXL_DECODER_MAX_INTERLEAVE 16
 
 #define CXL_QOS_CLASS_INVALID -1
-- 
2.43.0


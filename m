Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285845;
	b=Mym7QM/n7BI1vUZrxB1Ti+8Cv8JOqbJPnaZmVkKevpvb5xv29JMpIsE/67fhhQSmkAv6
	 /BFOYptAn5N5qMbGZjX0dXOOpxbK73XH1Of+4qWR6LFeGEkAjDAKjs3ln4tGea9YJTZrB
	 LL8PachpFOO10SGClWD/CdP6agIP6g0k9dDul/EnNXic9j7EWxUtsGPozPypGgZ/Y4U24
	 FTBjChF+zQUXNbitItHzONAT6qcHp+mcO/ivLbzOcfhZXiRhA1aRV4++/STrRuA7ZSLHD
	 l/cK590/DQr9m07tEy2sOZoHrZcz1bMAacUe2pGzw1aDI5EwmPirG7y/XnUm3yXi44w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285845;
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
	bh=76nCmwTZRgYRCe1/OIK5Wc/nOzIVJAakWFcX3FLE5bM=;
	b=do982X/mshEO5RUbxp/fM3SxqMx/xcg1LM8JlzZ4Fg6EKxSy1VuyNSPeVXVzaC2TyEqq
	 cGRArbTT6lj8TuzSAgK6cKY+RiGsEkLTlvC0IZqTeUcMBjNAu2R+n4/yAoFROxK9c+6ZB
	 2XfhKVTACT2LtWXDNmIgqnNHuSsT+hZZzH72MuNrXN7IooRCkLestSVPcg4dz0zueNGlc
	 yU+98R154sWzEKZhJ2c68a0w8EL9ZG3TIQEPKZcG8SiPwTaKXaGJLyr/nHFBrMxTkMPbJ
	 Pl7TGrHgw02pD/Awwg45YGndYGgHrbq3Chn1Ef0kdKtZgxwPxS4JCePINdET0So8eZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RSjpE+1f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.30
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0DA606A32A;
	Thu, 29 Oct 2026 14:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D0DA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RSjpE+1f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSDSbnScMGw7TtFssYoLqv4q7itkAqdeR7sW2Kietisvbd5iz5GYR4H2f4v9e5afxAk9kTDvutq23nytxkksT5ovxs+a1428nY8t9tlixwbRzlag3QAvq0iMSUuMwd2v6DFz3uCDRKdqV4eh1dBjIYBdPj2DY7OLJ+WKJdnS7RZSfatxivTduIzvI/ETgF4WxuZZAbDOfkFhD6zs0HElW4Ka8TEjGfiOJUqf7omZSQaRgV4Dd/ML9mKt6N4Zxyjf4APvA8iYCflPELZsVPORY9I8v1bnBMHYuuJVi0mlwAv/dSoGNxAW0ggcUCvaAk07Eidq23xIfboiC1wI2V1Ogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76nCmwTZRgYRCe1/OIK5Wc/nOzIVJAakWFcX3FLE5bM=;
 b=NMhFgzwEkrXljKyQA2WP3LmxXtDgUqaY2rcfk9f2j13e61VVGS8AeJ8JwqR7yARh8gnFZrmrLYHJ5JGqVWK+4ajhCtyezjU8W4emJ65LGCdwVeiT49GAQWYW1Ij1XpngTGefwMQ6tkuqdZwr3S4+UxCMNOagKNIqO0X5jNQQc4Dk8DYugD+0zMnXswKFo5fuZJ6I+7hDcQUGrP/ZhaA1Wl4Y0AFW3qnd6K7JmFNFyA5OKmv7wVO88Q4CfhPXe+aHWl7/M5O6vpEmmDiAMP5uxd0GD2b3qKDHkoKkxjTqOYto2+sVSaWwpNPBAVLgz0oHIB91dI+r8ditkHarlILqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76nCmwTZRgYRCe1/OIK5Wc/nOzIVJAakWFcX3FLE5bM=;
 b=RSjpE+1fqb93k+ndWJZB8qfqPB6BBw9xX2xCtaXFGWC8DL370BQPOl9Hh5j/hw18tNtdyLCni5mch1/BRXMYygN1jBFbpAdfTazGbuTlwgPTzp2A0hW00ybjRKE23kGo/UFJDEKRpDrE2+cvNka9pWSNEN4ZcfMWBXTmx+YX1kQauwaBPwagDMeR8+IsUCLdBL5qvQKkGaiMxgeYPwlWxRF82q9m28adnBvIPfVXQHqiC25h82zEuqmOZ3e6tmaa09Q9qj/Tyl4mpNSrXsSLqKteCkH/90vVixYv7niKTbWfnR4B89PLqE+WJh9pvbciYwPCH1D8T2wcENe3pmV1XA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB6014.namprd12.prod.outlook.com
 (2603:10b6:408:170::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:21 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:21 +0000
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
Subject: [PATCH v16 03/18] cxl: Move decoder declarations to shared header
Date: Thu, 29 Oct 2026 14:56:48 +0000
Message-ID: <20261029145703.2185231-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 4233835c-68df-4c85-d398-08df35ccef5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|261028144727099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+esmJ6BmxXoeSxJlMG1J33dcDBARLZ3LDwxvkSpTMgKlaDXKLYxi87+jdxPdW2JBrm1Vu8qC3G8IQhFnVJHYyYDcXon+nyQ06AjNjGumKDytTNudhiPEQEj5jNjbtoh7E2jOoSkkLjfEx7E/xkBhuz4kMjEtBqO/w+cFUnEqKlCHdC9mxOOb9UuciuJMFCjLCkRVsqSDG4fyxKmRvs7w7aM0GjpmaIlc0x0+5EqqC7wg6yyjNEsAYvJdDprM4mYAuXBQ+w7h69m6kdGXAGWzKNXblqqHP80bGJTtcbnquBdwMJOeaH0GNgLFPDRdwyn5cuL3zzfr4xTypLnGlQedctZBtlmDGddoGgMkdiaitaoWiYWDy5c1yttaWuwfmHoezSJHp3O+qL6RiAY/M8ufQ6+FdtIcKcFROyH1Z7g99h4QN4UHYeOna6MPqdYMzCgP7G3N9jM4pIL3lKrCGhgcYs+pcgWJNrK8leXDpRH292LjuDi29BqgMtvE6WhHrSeXjLVN9Hk/R++Ka9/sm0B2CwrwWLjNoj6ETYfHUCfEGp+IbVIBIjbnaa8p+rxEYJITIacxZmXzsQcwLyd+UIXO4khHpqcqurS3OKxm+Zn0BThNu74tVzOnekCqzCLmBBtGaSVWScBqItidz6jwFqrIBQFT541bxMuiKkT7oAVA1OmJ0JNFjBzY0HBqs4eLFMPUK6PD2f3+RadxN6fnnXh4Yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W1nyN1fzZKsAeHIqFiXiJwnc3ZQmElgdfw4AOzXCJhWnUCKXsE3+JMPfkjgG?=
 =?us-ascii?Q?0KSjUJM2xh7MDOWPEv3f2GpDwBOc6pbVnfR/QypioMSMZmiSKy2PMZTSuuq/?=
 =?us-ascii?Q?arnSvUhK316c9Hs9WxUBVz6jk3OY+AsySh18nyHxkz1IRfIkcvPZ3uC8byOA?=
 =?us-ascii?Q?VE2H8srCxo0NQtPjdBVe6Q4uhMhY2UyxKS/w8OqQrxErtDMLRcStH9WIiu9X?=
 =?us-ascii?Q?kuI7p/eIpmtq4UbbfBVLsXtNLCZl6NDMRUjBIWAqKwfbi0BCvD/Rrw7g7g/H?=
 =?us-ascii?Q?Ke129R2d0t+2/uQczDgSA2FE+/RGg++7MJgECe4Zx09wvNqLLt3vTDWoIsC7?=
 =?us-ascii?Q?eo9T4sIWGPKYX3s8y40emfBNKsuXxKMJwpij3KxgWNrw86grgFAeCiy+pZf8?=
 =?us-ascii?Q?N8K9/qGNi7XveBYlq0duMzvGAYERqiNMQetIQ9WDd/CDMpHkP/d5TPifIL9q?=
 =?us-ascii?Q?91CzeiXnO+uOUrfn9Lc0TujiyNRB4o3T4m3KdihtOlfH1OFZtufH56DMnppE?=
 =?us-ascii?Q?41MCaEXUJK0vJVccqPH6nB69eTGrio/F7YoLViUcq03ipuCD/vcAAEqGuOSf?=
 =?us-ascii?Q?LLomT+IDd+GG6Eh8QYTpLZZu/eGQtA2jtW4hV5DCR2U2jH7M1Dm66/q3u8UR?=
 =?us-ascii?Q?8N0QORklU5aDn/Vs6wTgVEKQ/LiQyW82hbzlIDpKaBGaRk1x3m2wxS1nGFM3?=
 =?us-ascii?Q?4wnXATk/+Rwd3fzkG9Knu/7kVBAAlra5unNndMJA9FcQV9ser2X5MiHppY1t?=
 =?us-ascii?Q?aaIz5bp5CyQW9fJG3/Cxj55oOcHuJONQO3t5gXrxdcilCTvzbQVlf8822wsN?=
 =?us-ascii?Q?1A1F92dne0aDpmxLkmUM/Gzf5NuipNGJcgBxQf5nHOhzqKoJaJhvHZMF447N?=
 =?us-ascii?Q?OaR48049Xm57efFsEgChDCdPcGlKnSsvPzT4bjRHPSMAL2gCe9iftqwLiMe5?=
 =?us-ascii?Q?cn5Axw99cqHwotPESPQhaQHE4ufLG9mN8u2TFKQppV2HAufKPP4sbHd4ccr6?=
 =?us-ascii?Q?qZpiObwGtZlVqfyyD2TqYP/HRC+kl4yZo0wYQv1CBd2ZFgY/Bw9y/EM5gt3e?=
 =?us-ascii?Q?Zam/SwrgJD7SIdflagvt4bHluYOpTsjup18yD+L4Z8RXE0F0JZuYqEFfzWTQ?=
 =?us-ascii?Q?XAuZN7wL+wlQTwRmDQTFh8ZUWVATCK8aYuJr16hk7z7kgaQlFWJ58ckOxqMu?=
 =?us-ascii?Q?+KrpOSIu5tpdtDobB6pz7hA+xeloh/A1Nwv1CmRsZwvSX+QPFT2NGaDmlMJp?=
 =?us-ascii?Q?tRfZXpfBEKOJC8EexO/4LDumbsHE9qmVc3ZpucBUUoVBfHa+7WvBzjfW6I6J?=
 =?us-ascii?Q?RInBs6hAV8mgaQ0Ez4aNEUkaI/pA2Hh0ScUUoBxCVWKg4W1jbw2p27puPEc1?=
 =?us-ascii?Q?jmIXNI2C6Gi5EZ0HjT3OZyMa7c7W9eIdB6R2MZU9y5+3Tu8G9UVqO1ldIxhG?=
 =?us-ascii?Q?mRiO0Z4aWe1rbQN8rHyI315yvK/7PFnZ9nRgOR/EQ+4yLWDEYw67cG2LMxBZ?=
 =?us-ascii?Q?3gDNUgLqCukFFnM6owIrP4r/n7EA3E9BMyK5ChptNOSWG1O35r/jOZnjMH9d?=
 =?us-ascii?Q?GnadK3vVmstxmZyaehQj+O2mVzPXH22F8qpQNtuFWLEGLadaPazX0gYRjguN?=
 =?us-ascii?Q?ughXiPy5m3tk3+NwuvpnbwpSfJjk/LqYGhwN4ZUiof/pu+rTkHTJprPeDf35?=
 =?us-ascii?Q?G2O5NC8LswvzGdoVWimBW6G87S4pALlZZiI3QRPi/oyUGptKwF8oxVeu7iY7?=
 =?us-ascii?Q?DPbDuIvz/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4233835c-68df-4c85-d398-08df35ccef5d
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:21.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67QkvYXcOYEdWdWPZcc2pApwGKUTJAXx+k5VFxYafCZV/W8fEfW8yBW3vPA0tJSEvKbP4znPSnBRNFccaK7BLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

Move the common decoder declarations to include/cxl/cxl.h for use by
shared decoder settings. Preserve their layout and documentation.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/cxl.h | 38 --------------------------------------
 include/cxl/cxl.h | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 50af716f69df..44ff3334648c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -264,46 +264,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
 #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
-enum cxl_decoder_type {
-	CXL_DECODER_DEVMEM = 2,
-	CXL_DECODER_HOSTONLYMEM = 3,
-};
-
-/* 16 is the largest interleave a decoder can express (CXL 4.0 8.2.4.20.7). */
-#define CXL_DECODER_MAX_INTERLEAVE 16
-
 #define CXL_QOS_CLASS_INVALID -1
 
-/**
- * struct cxl_decoder - Common CXL HDM Decoder Attributes
- * @dev: this decoder's device
- * @id: kernel device name id
- * @hpa_range: Host physical address range mapped by this decoder
- * @interleave_ways: number of cxl_dports in this decode
- * @interleave_granularity: data stride per dport
- * @target_type: accelerator vs expander (type2 vs type3) selector
- * @region: currently assigned region for this decoder
- * @flags: memory type capabilities and locking
- * @target_map: cached copy of hardware port-id list, available at init
- *              before all @dport objects have been instantiated. While
- *              dport id is 8bit, CFMWS interleave targets are 32bits.
- * @commit: device/decoder-type specific callback to commit settings to hw
- * @reset: device/decoder-type specific callback to reset hw settings
-*/
-struct cxl_decoder {
-	struct device dev;
-	int id;
-	struct range hpa_range;
-	int interleave_ways;
-	int interleave_granularity;
-	enum cxl_decoder_type target_type;
-	struct cxl_region *region;
-	unsigned long flags;
-	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
-	int (*commit)(struct cxl_decoder *cxld);
-	void (*reset)(struct cxl_decoder *cxld);
-};
-
 /*
  * Track whether this decoder is free for userspace provisioning, reserved for
  * region autodiscovery, whether it is started connecting (awaiting other
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 802b143de83d..613dab8150c7 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -5,8 +5,10 @@
 #ifndef __CXL_CXL_H__
 #define __CXL_CXL_H__
 
+#include <linux/device.h>
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -23,7 +25,45 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
-struct device;
+struct cxl_region;
+
+enum cxl_decoder_type {
+	CXL_DECODER_DEVMEM = 2,
+	CXL_DECODER_HOSTONLYMEM = 3,
+};
+
+/* 16 is the largest interleave a decoder can express (CXL 4.0 8.2.4.20.7). */
+#define CXL_DECODER_MAX_INTERLEAVE 16
+
+/**
+ * struct cxl_decoder - Common CXL HDM Decoder Attributes
+ * @dev: this decoder's device
+ * @id: kernel device name id
+ * @hpa_range: Host physical address range mapped by this decoder
+ * @interleave_ways: number of cxl_dports in this decode
+ * @interleave_granularity: data stride per dport
+ * @target_type: accelerator vs expander (type2 vs type3) selector
+ * @region: currently assigned region for this decoder
+ * @flags: memory type capabilities and locking
+ * @target_map: cached copy of hardware port-id list, available at init
+ *              before all @dport objects have been instantiated. While
+ *              dport id is 8bit, CFMWS interleave targets are 32bits.
+ * @commit: device/decoder-type specific callback to commit settings to hw
+ * @reset: device/decoder-type specific callback to reset hw settings
+*/
+struct cxl_decoder {
+	struct device dev;
+	int id;
+	struct range hpa_range;
+	int interleave_ways;
+	int interleave_granularity;
+	enum cxl_decoder_type target_type;
+	struct cxl_region *region;
+	unsigned long flags;
+	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
+	int (*commit)(struct cxl_decoder *cxld);
+	void (*reset)(struct cxl_decoder *cxld);
+};
 
 /*
  * Using struct_group() allows for per register-block-type helper routines,
-- 
2.43.0


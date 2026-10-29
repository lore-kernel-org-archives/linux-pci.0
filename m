Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285856;
	b=sTX7CXBdINMoxVpeffvZRgVpb7/x/iL1rsJNiH83yWgUUl06ZmQCVyv5l/TxwgVoUR8x
	 arzrLDqtCLMwdCP8Myni1s9+nMgEBt6xlH6qwviPCkZ409XfO9U5QnyaH0eamIg4zYN58
	 k9mKf31bEk3cvzznHx/rspBHts+PUTF7P+fF7KiC7fWTMQ5DcPV0RiH9QZyoz/DgP+BCu
	 OBgMiAU/okqZa2AivCzkrI55xNaChIlMLxJJqIoMFxooihePirDv3j7zRndpAHWVPDeVV
	 gVxn8MT9jX76cdfjIOlGT4vAUz23hirDJh+KYwkml3hpEd1QyfinwFTiWyA6opNTJxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285856;
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
	bh=BaDR0w06DHP//8BSZoMV7hseLHGXWJNIFfvRtZyDhWs=;
	b=mKvM/1n6Fzz6tT00aQxy6XDWz2KFQ+fnim3iEkh/5EfsGobuKmZhPKLKQxiqa1mOj/16
	 d6Y/5PbMChpKBDCo9dc5w68yntcDr6QEtBeO0QM6X3lc1GpTcLjcEqTnox/ccOHhWI+5i
	 trfxwJGM5phJlkhb2aMqdLoMAXQvrssju7jc5Exn/FWw2HcAa57AR4ALkz24oCE3GOTte
	 nVn9mpSDEsMIzZ3n2iTsOnhTCNpPYUR1hPmsBNQJ7sKPrZ0DxiaZYARBxEj+K27SNw2+d
	 DTfirAa5Rvl+JI/mr2OqQFQIcufJVEkHQWBN7lURIF6hyuGi2AI7M8as/tBvxmFbnQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hz0stlke;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.60
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AD606A32D;
	Thu, 29 Oct 2026 14:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 493AD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hz0stlke
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J26eBuW1l/s+L0NR/vjoYwlQxbl9oEow/xRcgsAc6BS8E6IqyWnld02D5mGbTFTryo+1raZOzb80Lj0br0FjpX7ZpYUEIaSvySdvfBcEVnFkTH2SI9AH5tIm+HLRlcyPXBRitNqHfmjQiDM5Z6O1wUxupgQhaYYYUGoZWzFE/hQ+69emY7UvOhCg+i3KVbyHzCo6k+8viCvziwB1lqDQ//qRawm14Iy8UoahfnhrhfP2TGVYQge3E9CaRehh+exWDckE3eBo/41aSHzMmG6fV+iVbal5NWePp0kOGentM30iu4BJVKudnr4yNFRHqaXQifLZfYpdXVc0L5Y8+2W0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaDR0w06DHP//8BSZoMV7hseLHGXWJNIFfvRtZyDhWs=;
 b=GCrhFkfTvVE8rjU4g165rzey0kzYlmVkm+L9+NZkzegbB+USfLpgzAABKkSUnUHSQq0UCxEZjlxGeZsoEaPu+NVUXiTO2zmtA5kLnFJAUa2Xuk942ZZ1HdkVENS0YjhIdWxlThvTAkKZ9wAcRS9p1T3/R3upTRbuyQ3lpDDznHQGCZ6hWxui10FMhQx9i85C3VZEnNg7dna1k/SqSNUXnNa80BRCDMrI07WsB119PDaHxiZ4mRxc68zf127FG8HOw5Vitd5bNAkGBc+KfSQJQJjroVC+afQluoMx+o0rxmjTXfuge4DrSIDT5BJf83JwY/k0vm2UtR/mWGmjwfuong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaDR0w06DHP//8BSZoMV7hseLHGXWJNIFfvRtZyDhWs=;
 b=Hz0stlkex44ZoKdPqoJMUj7vsE5dWc2DcD2/pU5M7sdHmyY+SjCdVZkHY8fgRYQIaarNsvyX5DfCE0Uw+FJVWUeeLQnT4NoG9DjSW55gtMA+OP9wCoeGpd2eyGT8xv9RxIopZN0iSQ4pJl98G4+yDPYaxAZBsvqtXyd0+KtVI8ZnlT2MUV7Clq/g4YRVzr6KSmO5Vta5qRr6sIyKqr0IaXT2OkcKHRpRFXfyuONVqEWUZntlwhJK6Zs3gH2glcyFkiczONclOrfY6DPpLRryGhUVr1kbeF3vWx2Ld90sFxafQGY0p6brMrJWPJ3duDFRvpRXXKcJFaQKRdnKwFXEZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB6014.namprd12.prod.outlook.com
 (2603:10b6:408:170::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:27 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:27 +0000
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
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v16 05/18] cxl: Introduce endpoint HDM decoder settings
Date: Thu, 29 Oct 2026 14:56:50 +0000
Message-ID: <20261029145703.2185231-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: fb277d96-a784-4f40-efcd-08df35ccf299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|261028144727099003|11063799006|56012099006|261009223027099003|261021123027099003|261022113327099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	I2hvb0a25srecIpk9NfZAYsUp1FDQK4gV//V6rNTs51CeoFwQ8GcPTtfMTVn+qSqAGunXT0leuHdACnaq7EEo5LA+nZiPIsCyoQq1KMjMYDPREG1Cy6espMP163XN6Surll3qJBxOG4SQtW2wb5sTtYVQCXFiPxDQ4J4NSUo0MM8EbmzEci4ESweBQ6C0b1yZqqu0j5Hr0wX7DBzg+FsDDUpZjwjUJ4it6lVBM7M/TbYItrDq9/w2rh5uGOZKZvf/6Ro8VkLxI/PNhBtqI2pm+Y/FSYkuo5e+npXX1I6TjDKODY0QBqihhPYLaxR4viVCl1KlngPT+xbswl6BuKN45OnwRrQO0HjWWxeejg5dFLJly90DZs2IjenVjhLgx4OclaXOpuqj+ps0V/Qk24ySP/YEeZgGzcZIzmkw+dV8aKyQ92t3XjG5oC0MDX7NFT8WT8MKqU/VUH60PObP6NWOiGaa7ecgKs9uZKxiv6R7Qzu3Wfzns37VQXc4+uJQ9D0/a4W9pJfj+1eZAeQ1G5XOaHGPyfv1o1YijqH5GEnyZs8sfZt5iaWp4JZ7U1uBnp3bIjnN2noLAbh57hTZ2f15vMvnIk5nvos6PffqNEsczodZM6JJZCa0BRM+gYGfcaXrXIc3XpNd4hXQokgruN6k+llJ3BO83ZfaC33MlpVPNHmdN55U0TqWskwZwe3UIOPdSWG+1F1LmQrHNThqoL30w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261022113327099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DAAMcIDuYV7+6cBoOTBtEV8P3WeOLrv+q6co0MjqySVOrwNIj9Xn+YeM3pOQ?=
 =?us-ascii?Q?tAu6DawP4r4GxEYLVSUVCMk2VH7fKTBB30wxf8TKJhj9pPWsfbVWTPUU+tR9?=
 =?us-ascii?Q?fPbTfKZZnemM5PMh6bcOklfAONOSiUZyN/30TlFy8MLJNakfmZrfiENAmaYe?=
 =?us-ascii?Q?i4JzAcdIzr6D0kHUck+liByk+t1uJl1h3W+Qkwl/wH2kxcs7atlcZhXumXYS?=
 =?us-ascii?Q?3DoIrRYAqmNBNl3JrH9BLRDpdcjdba0XC8agbKlLO/C9uuMehRNM0TFKdvJK?=
 =?us-ascii?Q?YUcMTBDU81+5VFPDoc20JCpgSU9GFISfainplmWdBUEs5PhG4aH3Cch3grNQ?=
 =?us-ascii?Q?Xoc9RDsgjdd+nTEcJpvUqjopDRdBtCmHnUvQ+mnG92K440Z3IcPjtsHFTqrl?=
 =?us-ascii?Q?bWoJ8VrTRRrwaNX4G56yOUi+Z5o+KMKg9ODQ3oTO4eUjt143Q5+mvmrsb1LD?=
 =?us-ascii?Q?dp72m6pkCk6YXiCxr21+Tuc3uSb+n40al36HJd8JpQM5ZGU17b3axBQP9jFn?=
 =?us-ascii?Q?3UGuMyCFLsTfjuaZh9pfvL8wpkT9r39UuvuEX2A/pktCSfVtXgE5XcCvz5BG?=
 =?us-ascii?Q?qPd+N3NGaGxPzd3YrEWUP0sdn7QWfmt4yNA+AG95IIKsrxANgcE48XnocU4j?=
 =?us-ascii?Q?cr3eWI+HWKxPeHzgzrif5RqFFL09QABeGShtnG1lrmA6UpMGKRzWuJgegOTx?=
 =?us-ascii?Q?Dp1Ih3t71J0DRb+ywRnlz3i6w4ufdaoVwG0FL4X3pTXHBZ39nNzasQCaPuXz?=
 =?us-ascii?Q?wMh4KnOCaOOy9SSV0yfJ1CsfvB4O3HKKfgE6PubmdsSIZLilx5jYTbfPvJSJ?=
 =?us-ascii?Q?K0e9mQmZxMbuZMVp35NI7Pl3cDbcZj5lZTLWbc3pNhj50R9WfHzWb+r38Q/d?=
 =?us-ascii?Q?ldWOTN9k7d5dU4BkATXGETXKHH6BfMgHHrVCcTgsF7kvY4W1qE9euubk3A3V?=
 =?us-ascii?Q?6Iw7xZptYJlVIpj/hrqgTd43kkB5UOdrgG27MWWHijQpisyKSJ/jCXXrmAmK?=
 =?us-ascii?Q?B4rdDUCAMf+WurU1+mXhVJDjBGAeUZRUHGuEteVSYq7zTupdvIf3Du595dCs?=
 =?us-ascii?Q?z6RPqXxUAi26X67fQb8XgeFO/3rk3vnBzTb7jOG1ehoS4QntGgttohWxuxP4?=
 =?us-ascii?Q?SpggpAZPVMD8uosH4PAD0vcWph0bEXcjQoCYOsiMqr7nvuBTmFTRdSrQWteu?=
 =?us-ascii?Q?lIbAPCpM+xIiPJnUwGUAKrS96zWD9kgnsVfQzgwxBYM/t8xB3cpMx2gcGh3o?=
 =?us-ascii?Q?FgQCvTFlY9RvOHO6NkFGK01A1VqPuHIYoHEujeY0SEAeQCbBtJOUknFVFYBC?=
 =?us-ascii?Q?Xt2UKh+UcZR7CSBNcv1P/cUmCbMvWyMD1m71sXXw/ZEJzV//aNqikzZYYYU6?=
 =?us-ascii?Q?4EFQEIwqYCAQ6/7kulCcvKnq97W85oxkUrZjbPcy4LNnBh2mmy4otc6e6/yF?=
 =?us-ascii?Q?eP6dHdPeUOcRNPt38kh1bAIGwsTSAC56Us7PBOEOUpyxKYQAcHtY//+AzsRo?=
 =?us-ascii?Q?wH1yKT1ABUZnnAYJoXZ0/Qy1Qm+AScceTZHBouokDIg0iL+f4aY6R5k7M0+V?=
 =?us-ascii?Q?lluXvC02Ssk+RW5zsyEU1IgiTwpXf3lW/1QyzJlN3zrUuzL2XO1DCTl75sOK?=
 =?us-ascii?Q?yGwe/CY0XXZ5CGsB/TAPP1sRGU7ryGjEDE9lzJd5gCnZOuQj2QmLgVPDIcji?=
 =?us-ascii?Q?KM1Vm+S/MwqCSP8EaF9i97Z2AAUqYEA66ESazWj3k6fcdH4X1e5HPe6toVG0?=
 =?us-ascii?Q?WBzRwTaj+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb277d96-a784-4f40-efcd-08df35ccf299
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:27.0381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LGCECA2sbmt59HQAyKVNpyKkSkCmq+1xpHigkbosloLRkpOcvpUfTNNgcwTVccU4DRNtgGnsMvhApBwHdxqVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

Keep common decoder configuration in cxl_decoder_config and represent
endpoint DPA skip in cxl_endpoint_decoder_settings. Share range
programming, but keep endpoint skip and switch target-list writes in
their respective commit paths.

Separate commit initiation from completion waiting so reset restoration
can reuse register programming without changing normal DPA-lock policy.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Assisted-by: LLM
---
 drivers/cxl/core/core.h |  8 ++++
 drivers/cxl/core/hdm.c  | 95 ++++++++++++++++++++++++++++-------------
 include/cxl/hdm.h       | 19 +++++++++
 3 files changed, 92 insertions(+), 30 deletions(-)
 create mode 100644 include/cxl/hdm.h

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 983d7690c3a5..fb14b222f3ca 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -7,6 +7,8 @@
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
 
+struct cxl_endpoint_decoder_settings;
+
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
 extern const struct device_type cxl_pmu_type;
@@ -139,6 +141,12 @@ struct cxl_rwsem {
 
 extern struct cxl_rwsem cxl_rwsem;
 
+void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
+			       void __iomem *hdm);
+void cxl_commit_start_switch(const struct cxl_decoder_config *config,
+			     u64 targets, void __iomem *hdm);
+int cxld_await_commit(void __iomem *hdm, int id);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 9e05032a5426..af445f1b9798 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/hdm.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -707,7 +708,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
 {
 	u16 eig;
 	u8 eiw;
@@ -716,12 +717,12 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
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
@@ -729,10 +730,10 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
 }
 
-static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
 {
 	u32p_replace_bits(ctrl,
-			  !!(cxld->config.target_type == CXL_DECODER_HOSTONLYMEM),
+			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
@@ -764,7 +765,7 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
  * clock skew and other marginal behavior
  */
 #define COMMIT_TIMEOUT_MS 20
-static int cxld_await_commit(void __iomem *hdm, int id)
+int cxld_await_commit(void __iomem *hdm, int id)
 {
 	u32 ctrl;
 	int i;
@@ -784,45 +785,79 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
-static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+static u32 cxl_hdm_write_range(void __iomem *hdm,
+			       const struct cxl_decoder_config *config)
 {
-	int id = cxld->config.id;
-	u64 base, size;
+	u64 size = range_len(&config->hpa_range);
+	u64 base = config->hpa_range.start;
+	int id = config->id;
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
 
 	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
 	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	return ctrl;
+}
+
+void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
+			       void __iomem *hdm)
+{
+	int id = settings->config.id;
+	u32 ctrl;
+
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	ctrl = cxl_hdm_write_range(hdm, &settings->config);
+	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
+	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+void cxl_commit_start_switch(const struct cxl_decoder_config *config,
+			     u64 targets, void __iomem *hdm)
+{
+	int id = config->id;
+	u32 ctrl;
+
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	ctrl = cxl_hdm_write_range(hdm, config);
+	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+static void
+cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
+			      struct cxl_endpoint_decoder_settings *settings)
+{
+	lockdep_assert_held(&cxl_rwsem.dpa);
+
+	*settings = (struct cxl_endpoint_decoder_settings) {
+		.config = cxled->cxld.config,
+		.skip = cxled->skip,
+	};
+}
+
+static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+{
+	struct cxl_endpoint_decoder_settings settings;
 
 	if (is_switch_decoder(&cxld->dev)) {
 		struct cxl_switch_decoder *cxlsd =
 			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
 		u64 targets;
 
 		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
+		cxl_commit_start_switch(&cxld->config, targets, hdm);
 	} else {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
-
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
+		cxl_endpoint_decoder_snapshot(to_cxl_endpoint_decoder(&cxld->dev),
+					      &settings);
+		cxl_commit_start_endpoint(&settings, hdm);
 	}
-
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 }
 
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
new file mode 100644
index 000000000000..219b9bb67440
--- /dev/null
+++ b/include/cxl/hdm.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#ifndef __CXL_HDM_H__
+#define __CXL_HDM_H__
+
+#include <linux/types.h>
+#include <cxl/cxl.h>
+
+/**
+ * struct cxl_endpoint_decoder_settings - endpoint HDM decoder programming
+ * @config: common decoder configuration
+ * @skip: length of DPA space skipped before this decoder's DPA mapping
+ */
+struct cxl_endpoint_decoder_settings {
+	struct cxl_decoder_config config;
+	u64 skip;
+};
+
+#endif /* __CXL_HDM_H__ */
-- 
2.43.0


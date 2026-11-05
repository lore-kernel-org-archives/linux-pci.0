Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905180;
	b=wcY0DOswExNy/WlQ3lQDZAf5DSzYEHP3xn2kMgaugQwvOKGH7hbLoXpm+N76VkEob2kD
	 BwmBf9WtrBJBWLiVxkUjLhDuCPbxLl5IjC0Nq8qmgr/6a3GeEkvEacaP8SBReGmjJQ5N+
	 MtvOqL8DA0Rd9aM0Beza7dDoYCPH+z+jsPq+rSAqFoiL827gyvHOOC4G/cy1/00fcqyjL
	 CmNuo3naxI1OIV51W4Q9UMXdQFq2bY586IFjpTLRgXdOGsesRm3k7QFICddfjchjGaeGp
	 eocjDCkQFk6gcmREXb3/BGjdNGjplo45MWgubSi3fxLyHO3dxlj8voXrh1vcMny4N2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905180;
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
	b=yuB2Tp1RKCTxC9Loy7qDSExL3kjf6l1MsDO4GrFD114YsQH/sCSrDPYJtU5VbnQkRCYF
	 Li94fysLUbWGeT698xSUflC6oxYPtpvBRDRDzbYASy/fl6SkET3SqF5ilpsLD2Nv+diDN
	 549HmC7jmAFRldlo0PDtHKru9B+lNH7GTtY/vVq1JkporKrxbg+c8J0DdftwKCr37otHB
	 Sjrw9yARphz5fTH5H1/rt9oPzX48nUQqClGNT90kUnjxWmOaKJoY7al+taRn07lkhgGMV
	 19wiJBaOrTBuCBAEn0GKX3m/j4urnPHceDfsDFMhiRODMA/I2pqh2DaYmGfmMMHSETA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WkT3QNcJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.38
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AE606D833;
	Thu,  5 Nov 2026 18:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A0AE606D833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WkT3QNcJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4ySQtP0iYrC7zhvUMUT5MZyzBaciZ298M6jNkXx3bVvSZsPpy1mT2TjYA0KbnWSnEjvlwErsBkuSFplU7ODP+vnFEAd95N22c9LXEhP1csmOxASSpdOKTbjx0Yv4tL2YVuqwgbjzq/w4uOre7IDbDTTdyxuW/VON63P6Zp3qJR8enTI4CmOrTtZYKAChK/qr9FmmOosM2EttvRTeAD+1Fg1Ws00LACeRpYpjHMCFgNsYCyVFbnbsQu83JgwaXAY1r9p4piG0dpfZaU2Ess5SSb4neW+SgSOg/zaWwAxIRGUusmAfRsYCV7RuprWeo/0NKuoV1mO+tGybDvZ5g9BAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaDR0w06DHP//8BSZoMV7hseLHGXWJNIFfvRtZyDhWs=;
 b=bctWONSdgC8taj+UpxYHqv+knGX37e976apxUf+FzBUM/0V4LqNDEfzSZnj/Tfa2e0j8bvR6EWpGi1vGrMBYOWjhoiFMAZG03aTbuEJg1H4DrVPu1AKwfFYsJC2YV/gQSyDTT6nRlxpmDaQ+q+Oz1tkFAGkqaW3Ro9oFQSvKcsuBEDapz5mLKUkGVNai8FXtbRyCO7f3Xst5xmZMyJvcJDj4OihRX6M7/3ZaoeSzrSvTdXVm0c9iMQOkDkaCg2F6QEKB+HKMk2Rwfo2W4DVNeRJnKE9jP4EIVQU6M5J67x7kgIG6HHAIFaMljbmUZ7MAvLQ3iRooD1gLfGeJw5pr2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaDR0w06DHP//8BSZoMV7hseLHGXWJNIFfvRtZyDhWs=;
 b=WkT3QNcJNajBkf+yGNpGzX5p5UikrSxbu7mZYnFVmcenXkg1pWnoq5y+oOjLGUD/LMYUdt1DKqI8zk32/LuUt18DOwwI8ceTTeDRsOCRWGGU8IY5TuBgJT5O459KAYE+IvQHCXwe54q9hSOuOKaPnvRP1fnQhtJiBSEycSTxSVUt+CHfZxEVteDoa8jln2VJt9IciT8YOhxrn4EP1sMuOGN31V4Ahgax69OQu0h8XG4KUo2T56YbGWs9iswUSv4ChJtr3k9O67sNUeHZEIfsYDLLBS6gOm7GGYqBdV/9y3Akc//WYs7lP6RW2WCL0RIdG2ILxDKjwvr0Ttt+JIOZBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DM6PR12MB4105.namprd12.prod.outlook.com
 (2603:10b6:5:217::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:33 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:32 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
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
Subject: [PATCH v17 05/19] cxl: Introduce endpoint HDM decoder settings
Date: Thu,  5 Nov 2026 18:59:03 +0000
Message-ID: <20261105185917.2667656-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: d3061190-6f45-491b-b0d2-08df3b6eed91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|11063799006|261026121527099003|56012099006|261021123027099003|261022075727099003|261026140227099003|261009223027099003|261022113327099003|261021121427099003|261102123227099003|261028144727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	g+OZwAnD3nc26w5+A5CyxkzjhsgyytBew8rqFsly8kakSP0biVhJKa/gqNdeUvphqFOyggsZbvS4KUR+cIqitg0hq2a91eXGZa6bW1mStYhC1XaIDhhefSWKbFJl7x8vntwnUgpQBqdW2AQMC8bujTecyV42ENunQ1tV+IOs2WyUY6Gewpawl7L75g1AmdFHVlJhr3tB+P0/sfJcT1b3jwtekpexy5+Wr0XT8X1ODqelr1lpauO6X/mfxqMAX3TdtQQ7Hg58aJgfLACuKi0l+gEn/qOh8Orcb9ocFUE39PM/Ehaj/7ijVGh2bsisExMS02wdJnKxbIMUoKQk0iPKpF3kG/KpK2czHOHCz2hzB4r0W2tdHg+UVnh5QzMnSoAqrSDFA/VF2yqMNXGOGAjJx0kTe0q+k59m3O0qt1ZsKMFBeOv6kx1My1zDUFJb/JZzEmbyZ7al1WSc77Ti6nnJJxR+VlUqfzAtxZXNNzmanEAyRcQqdAEml2Ckw/NBY6ILz5fNZan4DMPF0K7rMuq0T6dgDzJBs68sMesq7YpmUbu6MoKyejW5lSGyCwtP/C4mZKQdEQ/kCkNE+cTXeUYVatSQFL1nIuz0oZg2Bxkd68vgZkfo4QtpmtZDjILPcZWqc5EJ6qpwzyY4xyjPvs/TWFGlvRcz3i5j/53+X62+IcSxM4Z5Lf+pWS85FhInb9CEf2YYMsRJMoLni2iwLdWZFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(11063799006)(261026121527099003)(56012099006)(261021123027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261022113327099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iyTbXg7e+pY7ZQLHXvKn/XiUr/BTJkTCEjJO0Q9x/AId8vKLw3vTmz02/PoF?=
 =?us-ascii?Q?wa8lTMvYM/Ha6zza7chJKAb4BjlAXJ7G4+/pWtA6G8OS95MrlnNi/yaWqmTN?=
 =?us-ascii?Q?mIJfWLl+IxZSDI9KQHZOleE+szmaSYxiJ0rFRX7u68uLZ14sB/SMeAAmwuN8?=
 =?us-ascii?Q?st3Uh3kOfSQgglVs4RvnQdefxXQoiuvdSiQJO4g3LRjbzjVhuU8pFfkUOYpS?=
 =?us-ascii?Q?eMg5cqdDJ2ANAqPpNBepWwSjT2gdtD4lcryGvXSHi1leq+M7acvadxagz+Ai?=
 =?us-ascii?Q?VmOjLUnLv4ucXRvW448587KwuVApVByRUnlo0J6wFEYkMuHDH9pMsqHuM31D?=
 =?us-ascii?Q?Kb0VQVm1zf4tJxtu/tQj6y4vA5n3sB6PlKforuv8WJm/ImtmDzHaXLervDZr?=
 =?us-ascii?Q?fMg0EfNaICla9rm+uQnZAv0cxIuH0bCcXrpuES9TdQqRn4x6httzHb0FDYrj?=
 =?us-ascii?Q?zGMMT9W54WAPd0kh/nPqUvDmkB08qTR8AVk4iSvb7s6Zo7kw6mRSdKrTNEze?=
 =?us-ascii?Q?CDM7C2vfSXkLzxQVtm8dP3FQ+j8UR7i2H3T0/Y6zWJ3JJccq2chpsvwhxs38?=
 =?us-ascii?Q?TaomLcVb8Yr41x6vIudfnYNP1zqRVW325v4SnDW30FjBfdS4DKlA42NzCG8z?=
 =?us-ascii?Q?AbSNmeZxRQyRFC5lJ5u1/L4mcmBI6KYYdwMY3J7rMGjZwyo2W8KJqwg+QfQ5?=
 =?us-ascii?Q?Vf6FhQC3RvXZAUbkW+8zlD5zzlwoGat/o7U2lUWa/k3Yah053uJM2DVHXNbi?=
 =?us-ascii?Q?/gtJGq+TVnpz9Sm7eubyVKtbp92vUGeJ41ETGeH1Ta6+oSEgot6h/QGb3Lmm?=
 =?us-ascii?Q?X0IEvxjioTuxzio6AMCRp3OidrbYxfY/laDhmGgr1lVR6UfajjjCdY5PfmcZ?=
 =?us-ascii?Q?ke7eSIQrjjgTZvdIay7waEoU1t8vbxXreMez0ByMEh1kdpmTfutjlEcdvsmR?=
 =?us-ascii?Q?Ciut/9g3IVFuS9u73/bTvYWalXoR71V1X1Is0gUJGfG+ZD1c96HfaadngdYN?=
 =?us-ascii?Q?PdSRzHk4nv1NrRrpFqag7pFwftJazONetYBkyxB4u24MdCU+51QEQ0eH7HI2?=
 =?us-ascii?Q?HTJN0zZKajxRpoz1vvHByqj3lNPwQH2yp0Jlcw3qSAmsf4+t/9QoGYfSdtWJ?=
 =?us-ascii?Q?KH+fKlfen7Tt81Zbz1+aaOHQu1drr4sH5zp8Ik8X0qd8PLOnjZ+MAqdsNTw1?=
 =?us-ascii?Q?u0k/KWrhMFIvC1NS26mFfY3UI7wRKPyEWb6tglc5MBNwnOVSV1khwcLB7ve7?=
 =?us-ascii?Q?2Ghx7crTp/glyODni88ldKxQigPnkdjbJlQUIbq6ZTuopk3gEs7DulJaC28P?=
 =?us-ascii?Q?pRq5zWzY57LGm4QXRYdpKuC/8T1eF0gg5KYfGFhmpBPZGq1Y8hnhOaoYSZBu?=
 =?us-ascii?Q?XAkUCmpB9StZYlM03bXaEGPxMF7Mg++a3iTqmCvKuU6VYGYs2edIQAmdrx2X?=
 =?us-ascii?Q?RyAtak3SaJrr8QUqLYldDFtyeKSVwCa6KMlwOFeZ0TXOiNNkMwnkWmqtK+Iy?=
 =?us-ascii?Q?dWStzZgbDij+lDBEET9Z9GQdQFWO9AGnUm4MdTKSAHXXCPu5SvuFKmaqQttx?=
 =?us-ascii?Q?3QbPNuPGsNWXukgHhiWnXEewPhEtGnOMmRtX1gkmYALPPTvCr/vtwQm9kX/h?=
 =?us-ascii?Q?DNR57YSUMqYjTa4xhehEuu7l8rfJ0mSmjP8jAl/JfG/SYQEDd2M++qvdDijN?=
 =?us-ascii?Q?d3CmGV2kej5Z4d0txhYbUj2v3J8JKPkQwgAazhc73BJFP/g4Ca11JO2iwmkJ?=
 =?us-ascii?Q?gyIzp6sAKA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3061190-6f45-491b-b0d2-08df3b6eed91
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:32.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erpuvFcdRpUuEpOvxHjtyikQDb/v3ow6u5EAuzZVKPUmV342rmlE+GFacCq83mpEgalz8zI8OuyEcURStV7mag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

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


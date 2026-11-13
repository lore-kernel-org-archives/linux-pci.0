Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576595;
	b=gShO7ntvJ3y/fhqci2WnuspfM9ruc1H/efLLEimiHN11vy4D1FT3z5Xs9hqh/HN+qs3i
	 GPFqFYXxMXPTHVn2qL7rQNg84aSwutPYYzrKdiVGj1Uxhn5M399sK3FyBGtbF+dSHGYcx
	 qDEVJkLVH/+i8XA8w5CFh/nWsV3xcoX+2s4DsNf89AeUaFQL82kNcI8JfIKVW93hPw446
	 PJtrybryIgelmN+vJPr1e28kH+hhCRjCtxpBiL5+VbzrHwIDu3MvFGFBNdSUwa0Nz3yqp
	 VsxBrovY8uQ5nQbUTw4/4hYsKhcWCqR1AHHDih5XK7QT/4ZFKhDtmiWVG+JBVcmLG4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576595;
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
	bh=RWXAiEkaLUK33wD+lAlgirAq7vQB8Q/ZmnlW++ssslI=;
	b=guywLjpZareYFm+m++kDag05JEceHOVZhz9LKRtE3/oBihTO7JjBvd8LojmQG6L0bxZB
	 YUjSbLA4zM1h+Yq8ouCrqRBYK9p3ybCAM3y8cHi4acKr2SJq4kCd8a/xiZYP09xukiFlM
	 7BwUbICJnt/48xEPtP5t1q9ej8Plke3pTcKld0BSPsn75W1h2s75qkk86kGYGkSEFMSdA
	 AZzrmZHJ45+WOfccWaOazec5clqClU0nRe7KMDZZFaPSURlYE4Agp0vkywqN65iDYKdjW
	 6odDIfElXOYwL4PL4gInZzeAJAWK8DvnPUvJKzAYLOuYiCzrH+uV7JV8NRvVJZPfS9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=F7LQroil;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020108.outbound.protection.outlook.com [52.101.229.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9148606BFEF;
	Fri, 13 Nov 2026 13:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9148606BFEF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=F7LQroil
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI23yM1sM0yUXydLM4z89XKSKqk41Azwr4/2yitjTVQuhTX3p1veISP2iFdr2+alUYxljcFN9DLFzUoZil+fuGMmAU7zIDMYKaFJN8RIzxIDXDcv4lvM8ejH39RE5usKU3WUam8UGsEsSxF17bhTjvkpqJ+p29zAR5/aQy+pQ2KoRQZrRMV5XOe6EJZ7jrAof2kkSQICfLy46Xgj1WzRqWpetsiEEQxBqEfU4SsZWDJWw9BDGtd1QhaOv5QsRJnzq5w/ZivtiCxQF1/dhioljskxU3+l/AeuqtI1Mb5NHe1qgBfSKwPvD7CeDmFt+fPPSEuWI7g3X2a/5v1MLqVdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWXAiEkaLUK33wD+lAlgirAq7vQB8Q/ZmnlW++ssslI=;
 b=p9ylNq45zTqJp6xoBj1A6QTmPSiI/+RxU6XQaGAKyFPzrBK42HKv2IV7QxWf5tcHKeRuy0Y63D4xRqNtcVKe0j/AFcdRc1FLw55U4jpABGvq4Cloc395c6zO0KZEplsxLQlzBr8XPObbNPQ8qW2NkFWpKvUEa96+B3w5yW9LsslkniBftsThT6UKyCc6GPuRUC7f79jKNrLW84HmJtAUFo8bY9ZgGjwMsemRIvfOwp9Duk3lSG1fQ8V9JXYrwYqRUz78iHMn8I2+0ui0bjlgM27C8BJGaukJ/RqMTxdz2rahPaDnmeZy4iJw7CeYAaiA8l1lBPemskzSRkqr8jxQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWXAiEkaLUK33wD+lAlgirAq7vQB8Q/ZmnlW++ssslI=;
 b=F7LQroil8U4KTO2110ya3+H6qAeurFqky0QTHeZExqCrhoEuUOsasiA57RZevcyTjj1dKiOdjjUGXziRmC2JGehGjR0ESTmtrx1DA3rUa6F7F0oHjMS2qGrd6WyoOHO62eGPSuiJO2mWkzXQVKj2nn8QU0MgnXS+wHbpnAwhYo0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:29:51 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:29:51 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v10 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
Date: Fri, 13 Nov 2026 22:29:31 +0900
Message-ID: <20261113132935.4152566-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113132935.4152566-1-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0160.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYVP286MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1030775b-7296-4a04-22a7-08df418a320c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|3023799007|56012099006|10067099003|261102123227099003|261026135527099003|261022105027099003|261026121527099003|261022075727099003|261022115727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	45MamPWI+1YUIlU+5RPHlWFBx8e8j5EjVpY3Ckv5+seojT86xbPgtlqbd33X0wDDOBCT7/LLJQ3lDr4QVJP0mJsow9e+wwJ3UMCavtMh7Gyw5Pk7hyWPB8P4OknE6Zn7fF0UX9/rpKGN+u0wioYoveamu5rXS8Io5IU7Wz9wga8eF/d5hxFriBv52uU2ckkmraYLNB5RlwQU5DBNE8yfjX8XwSzZR1ie8DK+YGdds5gi9feHXX9PJ3gaIK7UrIVzmZOVscVqRaaDAPtIduraQKOKUndXMhIKMcFWGvJF8n6GrLAPe53ncpqugIopfqSiVIj1/5+A1Rc/MDGmTBJBdboG56+AttIQKJOP+HKswDCVyik6fxdjDlKSNJHmj5OPXUOypsTwb+yUggT3HV1pC8tq0UVdRLO3/toEgJ/4lDC7J8xLAu+xq3ghXQsDRl/YWHJBm57l9tJu9B98jSrco9v7yThlEMZCGo2pJF7O47nYl03vDuwAjBcoAwLk387pTyB/KjuSgPvjtb9C2w+OgGuMp2jkK3fYTBHuu+3RWVXFYQWsYncyZPbAo0yZbEqCIuJA82DiiFt/aumLFX09p1rrigubqOlAgR3ncBeauaDF5+784FQ/Rf7vHWjJ60DI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(10067099003)(261102123227099003)(261026135527099003)(261022105027099003)(261026121527099003)(261022075727099003)(261022115727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ic5yrHGXML71MahKLElB6XKTbDt5keP5odys+eC3uOJ8iAjYXIH2nCA8qAGl?=
 =?us-ascii?Q?bijMFkq54xqMJffk4mp23kIvsuNmPqazbjCvnhcXN6EGstjsa32bqJiWu0Ti?=
 =?us-ascii?Q?iNBFWLub537E63FCZrmcp0lFVbKXdLNi7VNbO2R8u0QxFvh1iO935EPFQAg9?=
 =?us-ascii?Q?Bzb/6e2bGtwPpfm7CVaqHINbuAQjs8IOSv4mel9+SupwR1euqdatSC6hUx9y?=
 =?us-ascii?Q?xIflDq68D0UlnLy9VTqEgrT0HxcXNtgjcbNbrTwDlZAX1xq6jsNx9NJjJipZ?=
 =?us-ascii?Q?M4cNOB8l5kKA4heszGyr1as+X80IVp5WDQu7t6hTMl+JIVrJ7xZAMKIvkIPB?=
 =?us-ascii?Q?b6Ei72qHzrJi7PNF6GtzDMMlkScUBdzQt/3gQHVhHldkER5r7nOEXlGWSahv?=
 =?us-ascii?Q?9vlq1nexEcuRKwnaWXK343cxipt0kknsExEC6bs+X/qqUzonl7YJJ/c/fTvi?=
 =?us-ascii?Q?VfRRkhjYvA8XiUP2J534eDlJT6orOc/AOgiOdNoS8nBVrMxDDTzHupTFKxNf?=
 =?us-ascii?Q?v5gr5TcAly054ZInu1P19iHHHGNEtRsttL4XcKIu+ffe0sNQzbzgFnsFiB5l?=
 =?us-ascii?Q?2dTAr9X5xsJTVfePlQqqUy/OIDNjKM4OMVkvjz78wxeUU9BDQ11T5sdjBrrf?=
 =?us-ascii?Q?czbYEK3aO6MhmeUEmsA+D+t3rZYknexBH/GZQ85HFrn4ueHWyHwvvVRLy+FG?=
 =?us-ascii?Q?X3nYbWezd05+rMr67oiCYaJ+t98BrG+olqbOOBdA15cRe2TDtMzqi4ZSgjyc?=
 =?us-ascii?Q?Q8+80jnQIpZwTMrmqFIkVFVrSV9Cym+iF4LjRn/qqhfbMWAoO71AuEfnftiX?=
 =?us-ascii?Q?0kPMTPOHmdrQ8SHV6vtDc3I4QTAeVVUieMuTPTTni0ZGVN4HQCnstZGIp6DF?=
 =?us-ascii?Q?2Sxt77Z/VajRZ9opTWW7ADc2LHIA2MStLuimh7XEGyXW9Cy1EQ6DLFtXxDww?=
 =?us-ascii?Q?tKH3jb+eNY7ngRlld26PALrbxhgU68jh7wuV6cwCHYYg/BGEA3YHTfqmSSEk?=
 =?us-ascii?Q?jWpfgln0kIgQJg66DJhjBNj5o9qOCDlHraMwu7ixQzTOoaPkGPA4spUot5ma?=
 =?us-ascii?Q?rt9arKnlg0ujfbpp9KQojmnlKv1aEGrmZQu0acvrvEyCoH6W1j3GVt2nblc9?=
 =?us-ascii?Q?QhiDOqVPALjQrnCCuA/cGPzQioaE6Za90E2SDlrkSyVPxiO9/d3XunekYZ2b?=
 =?us-ascii?Q?1LCvrHPh1yqwJ1qtrYto5Cw9bSUV1oLMAu41uUh4Xu5txigqaKUxmbNWYwYu?=
 =?us-ascii?Q?bTLsoRl4mB5D4iInW2hPe9S3D1nIeXNgvR/iYU5JWp/aGI9FV3K7cfQOLEdU?=
 =?us-ascii?Q?EYAOEXW8n9xLkrvzudSVsdLdxLn02r9ziCpYUdcTfZm8MwyYJIkzWlHIdSrL?=
 =?us-ascii?Q?7f+M25Lyd09qSvP2wZtN7XpJ1W+DYoe0p8eRwQpKGaIQ77nOrJ9sOvlW50Ix?=
 =?us-ascii?Q?HoJ2eMyyo3lsf6HczJyQnjgCmSFV9/xnZH50KXEhgi4TcE+TtjnUdq+C9Ngr?=
 =?us-ascii?Q?JH2EE+WVvTX06LRiStoG5sVNzYfUj79f3nceBSUSZ4O0T8vsW3jsMnaPIODW?=
 =?us-ascii?Q?8QucdPWoP89ZWzOrvcf/wVrsNYwRQY+fXbu5fMIygNtR1IeR2XccocSWWtqk?=
 =?us-ascii?Q?/gIXx+vxowVhAha26xvgAy+3sUmElYtOtuvBgJfZCfHUr6WGMfyWIaI5xA4U?=
 =?us-ascii?Q?MLPl+3VpKb4tJ04s2O8EOVS8nGxMXaFs1YlBZ2xdt7YGXya5uShXUz2oXu0z?=
 =?us-ascii?Q?/KtWgdihNnUy5xXoapM34mrxNXEnn1EkoHsu+ycdn8oASu8rU6YV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1030775b-7296-4a04-22a7-08df418a320c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:29:51.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDvh0Wc84m5JVXaRHNRBuGKb27cxH+ZLxivWhQNI8Oiyv/vakr+4rAbjVFW7YDWcmhSHmdA47H56BfeM5rl5Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716

Some endpoint configurations have no spare BAR for DMA resources. Allow
dma_bar to select an MW BAR and place the DMA ranges after that MW.

DMA submaps have fixed BAR offsets, so a shared MW translation must
cover its configured size. Keep the power-of-two restriction used for
ordinary MWs. The size must also meet the EPC's alignment requirement
for the following DMA submaps.

Older hosts treat the whole BAR as an MW. Fall back to that layout when
LINK_UP does not advertise MW/DMA boundary support, so that NTB keeps
working without DMA: the enumerated BAR size is kept, the MW spans the
whole BAR and the DMA submaps are removed.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v10:
  - No code changes. Add Frank's Reviewed-by.
  - Link to v9: https://lore.kernel.org/r/20261110082459.1798763-7-den@valinux.co.jp/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 220 ++++++++++++++----
 include/linux/pci-epf-ntb.h                   |   3 +
 2 files changed, 178 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index bbe43994078a..fd03fb45a5f2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -84,15 +84,17 @@ enum epf_irq_slot {
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
 
 struct epf_ntb_dma {
+	struct mutex lock; /* Serialize DMA submap and MW updates */
 	struct epf_ntb_dma_ctrl ctrl;
 	struct dma_chan *dchan[EDMA_MAX_RD_CH];
 	void *bar_scratch;
 	dma_addr_t bar_scratch_phys;
 	size_t bar_scratch_size;
-	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
+	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
 	struct pci_epf_bar_submap *reg_submap;
 	unsigned int num_submap;
 	u16 rd_ch_cnt;
+	bool mw_fallback; /* The MW spans the whole shared BAR */
 };
 
 struct epf_ntb {
@@ -229,6 +231,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
+static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	unsigned int i;
+
+	for (i = 0; i < ntb->num_mws; i++)
+		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
+			return ntb->mws_size[i];
+
+	return 0;
+}
+
+static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
+}
+
 struct epf_ntb_dma_filter {
 	struct device *dev;
 	int chan_id;
@@ -353,6 +371,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	unsigned int i;
 	size_t align;
 	u32 next = 0;
+	u64 offset;
 	int ret;
 
 	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
@@ -371,10 +390,30 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	if (!is_power_of_2(align))
 		return -EINVAL;
 
-	if (epf_ntb_is_bar_used(ntb, barno) ||
-	    pci_epc_get_next_free_bar(features, barno) != barno)
+	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
+	    barno == ntb->epf_ntb_bar[BAR_DB])
 		return -EINVAL;
 
+	offset = epf_ntb_dma_bar_offset(ntb, barno);
+	if (pci_epc_get_next_free_bar(features, barno) != barno ||
+	    (!offset && epf_ntb_is_bar_used(ntb, barno)))
+		return -EINVAL;
+	if (offset > U32_MAX)
+		return -EOVERFLOW;
+	if (offset && (!is_power_of_2(offset) || !IS_ALIGNED(offset, align)))
+		return -EINVAL;
+	dma->ctrl.submap.offset = offset;
+	next = offset;
+	if (next) {
+		/*
+		 * submap[0] covers the MW prefix. Keep its temporary
+		 * target at address 0 until the MW translation is
+		 * installed.
+		 */
+		dma->submap[0].size = next;
+		dma->num_submap = 1;
+	}
+
 	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
 	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
 	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
@@ -408,7 +447,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 		chan->desc_addr_lo = lower_32_bits(dma_addr);
 		chan->desc_addr_hi = upper_32_bits(dma_addr);
 	}
-	dma->ctrl.submap.size = next;
+	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
 
 	dma_dev = ntb->epf->epc->dev.parent;
 	for (i = 0; i < dma->rd_ch_cnt; i++) {
@@ -481,6 +520,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
 	if (!dma)
 		return -ENOMEM;
 
+	mutex_init(&dma->lock);
+
 	switch (ctrl->u.dma_ctrl.reg_layout) {
 	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
 		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
@@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
 		return -EOPNOTSUPP;
 
 	barno = ntb->epf_ntb_bar[BAR_DMA];
-	mapped_size = dma->ctrl.submap.size;
+	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
 	/*
 	 * Submaps cannot be installed until the host assigns the BAR address.
 	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
@@ -607,23 +648,29 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
 	memset(bar, 0, sizeof(*bar));
 }
 
-static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, bool use_submap,
+				      const dma_addr_t *mw_addr)
 {
-	struct pci_epf_bar_submap *old_submap;
 	struct epf_ntb_dma *dma = ntb->dma;
-	unsigned int old_num_submap;
-	struct pci_epf_bar *bar;
+	struct pci_epf_bar *bar, old_bar;
+	dma_addr_t old_mw_addr;
 	int restore, ret;
 
-	if (!dma)
-		return -EOPNOTSUPP;
+	lockdep_assert_held(&dma->lock);
 
 	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
-
-	old_submap = bar->submap;
-	old_num_submap = bar->num_submap;
-	bar->submap = dma->submap;
-	bar->num_submap = dma->num_submap;
+	old_bar = *bar;
+	old_mw_addr = dma->submap[0].phys_addr;
+	if (use_submap) {
+		if (mw_addr)
+			dma->submap[0].phys_addr = *mw_addr;
+		bar->submap = dma->submap;
+		bar->num_submap = dma->num_submap;
+	} else {
+		bar->submap = NULL;
+		bar->num_submap = 0;
+		bar->phys_addr = mw_addr ? *mw_addr : 0;
+	}
 
 	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
 			      ntb->epf->vfunc_no, bar);
@@ -631,8 +678,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 		return 0;
 
 	/* A failed dynamic update may have already removed the old mapping. */
-	bar->submap = old_submap;
-	bar->num_submap = old_num_submap;
+	dma->submap[0].phys_addr = old_mw_addr;
+	*bar = old_bar;
 	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
 				  ntb->epf->vfunc_no, bar);
 	if (restore)
@@ -642,6 +689,51 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 	return ret;
 }
 
+static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+
+	if (!dma)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&dma->lock);
+
+	return epf_ntb_dma_set_bar_locked(ntb, true, NULL);
+}
+
+static int epf_ntb_dma_link_up(struct epf_ntb *ntb, u32 argument)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	bool fallback;
+	int ret;
+
+	if (!dma || !dma->ctrl.submap.offset)
+		return 0;
+
+	fallback = !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
+
+	guard(mutex)(&dma->lock);
+
+	if (fallback == dma->mw_fallback)
+		return 0;
+
+	if (fallback) {
+		dev_warn(&ntb->epf->dev,
+			 "Host does not support MW/DMA BAR sharing, exposing the whole BAR as an MW\n");
+		/* Replace installed DMA submaps until the MW is set up. */
+		bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
+		if (bar->num_submap) {
+			ret = epf_ntb_dma_set_bar_locked(ntb, false, NULL);
+			if (ret)
+				return ret;
+		}
+	}
+	dma->mw_fallback = fallback;
+
+	return 0;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -780,7 +872,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 					     EPF_NTB_COMMAND_STATUS_OK;
 		break;
 	case EPF_NTB_COMMAND_LINK_UP:
-		ret = epf_ntb_set_link_enabled(ntb, true);
+		ret = epf_ntb_dma_link_up(ntb, argument);
+		if (!ret)
+			ret = epf_ntb_set_link_enabled(ntb, true);
 		if (ret < 0)
 			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
@@ -1269,6 +1363,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	bool shared;
 	int ret = 0;
 	int i;
 	u64 size;
@@ -1278,22 +1373,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	for (i = 0; i < ntb->num_mws; i++) {
 		size = ntb->mws_size[i];
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-
-		ntb->epf->bar[barno].barno = barno;
-		ntb->epf->bar[barno].size = size;
-		ntb->epf->bar[barno].addr = NULL;
-		ntb->epf->bar[barno].phys_addr = 0;
-		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
-				PCI_BASE_ADDRESS_MEM_TYPE_64 :
-				PCI_BASE_ADDRESS_MEM_TYPE_32;
-
-		ret = pci_epc_set_bar(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      &ntb->epf->bar[barno]);
-		if (ret) {
-			dev_err(dev, "MW set failed\n");
-			goto err_alloc_mem;
+		shared = epf_ntb_dma_shares_bar(ntb, barno);
+
+		if (!shared) {
+			ntb->epf->bar[barno].barno = barno;
+			ntb->epf->bar[barno].size = size;
+			ntb->epf->bar[barno].addr = NULL;
+			ntb->epf->bar[barno].phys_addr = 0;
+			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
+					PCI_BASE_ADDRESS_MEM_TYPE_64 :
+					PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+			ret = pci_epc_set_bar(ntb->epf->epc,
+					      ntb->epf->func_no,
+					      ntb->epf->vfunc_no,
+					      &ntb->epf->bar[barno]);
+			if (ret) {
+				dev_err(dev, "MW set failed\n");
+				goto err_alloc_mem;
+			}
 		}
 
 		/* Allocate EPC outbound memory windows to vpci vntb device */
@@ -1310,10 +1408,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
+	if (!shared)
+		pci_epc_clear_bar(ntb->epf->epc,
+				  ntb->epf->func_no,
+				  ntb->epf->vfunc_no,
+				  &ntb->epf->bar[barno]);
 err_alloc_mem:
 	epf_ntb_mw_bar_clear(ntb, i);
 	return ret;
@@ -1331,10 +1430,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 
 	for (i = 0; i < num_mws; i++) {
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-		pci_epc_clear_bar(ntb->epf->epc,
-				  ntb->epf->func_no,
-				  ntb->epf->vfunc_no,
-				  &ntb->epf->bar[barno]);
+		if (!epf_ntb_dma_shares_bar(ntb, barno))
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
 
 		pci_epc_mem_free_addr(ntb->epf->epc,
 				      ntb->vpci_mw_phy[i],
@@ -1936,6 +2036,28 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	dev = &ndev->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
+	if (epf_ntb_dma_shares_bar(ntb, barno)) {
+		guard(mutex)(&ntb->dma->lock);
+
+		if (ntb->dma->mw_fallback) {
+			if (size > epf_bar->size)
+				return -EINVAL;
+		} else if (size != ntb->mws_size[idx]) {
+			/*
+			 * The MW submap spans the full size configured
+			 * through configfs. DMA submaps follow it at
+			 * fixed BAR offsets. Supporting smaller MWs
+			 * would need a scratch-backed submap to fill
+			 * the gap. Let's add that complexity only when
+			 * it is really needed.
+			 */
+			return -EINVAL;
+		}
+
+		return epf_ntb_dma_set_bar_locked(ntb, !ntb->dma->mw_fallback,
+						  &addr);
+	}
+
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
 	epf_bar->size = size;
@@ -2134,15 +2256,23 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 			resource_size_t *size_max)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+	resource_size_t aalign = SZ_4K;
+	u64 size = ntb->mws_size[idx];
+
+	if (epf_ntb_dma_shares_bar(ntb, barno) && ntb->dma->mw_fallback) {
+		size = ntb->epf->bar[barno].size;
+		aalign = size;
+	}
 
 	if (addr_align)
-		*addr_align = SZ_4K;
+		*addr_align = max_t(resource_size_t, SZ_4K, aalign);
 
 	if (size_align)
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = ntb->mws_size[idx];
+		*size_max = size;
 
 	return 0;
 }
diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
index 5cc0f0badae0..8131ed4c6ac9 100644
--- a/include/linux/pci-epf-ntb.h
+++ b/include/linux/pci-epf-ntb.h
@@ -24,6 +24,9 @@
 #define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
 #define EPF_NTB_MSIX_ENABLE			BIT(16)
 
+/* LINK_UP argument: the host honors the MW/DMA BAR boundary. */
+#define EPF_NTB_LINK_UP_DMA_MW_SUPPORTED		BIT(0)
+
 #define EPF_NTB_COMMAND_STATUS_OK		1
 #define EPF_NTB_COMMAND_STATUS_ERROR		2
 
-- 
2.54.0


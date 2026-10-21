Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.96
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556572;
	b=mMKJr3TEQhAb0wPhXlOyOypRKAHV3JSp+lYNexT8Eyi0y6YdMSERp3wdgnxBWmoSgpBl
	 4c7S5/lfIhAVR7RCZ2DpuzLQtpd+o19DPjQ5iXBaFRnuhzxNSvsivtUuHvfpQtLnYXxWo
	 ZofEDpKK/BpF1HeQ85CVGlnHMIdWab36DULLt8M3wxpgQ8WroDWJOHmGM1xCC3NBlkoSa
	 nx7bQHSrRSOCOYkfO1jYoih4AdTyGQALKtmSyTvcYJV6DWnXKXZZ2kloN+aCcGfsyHAKS
	 ysmBMM/XIaGXmrNLnsW6crQSauEIe79tHgq2vaIRoFwlnQfPtaiYyp+qgyqZeKgkwcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556572;
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
	bh=n0l11lJjx+sNXwZTMr+dfhjAvIPdz6d4CR36z2Lps84=;
	b=ZHbfNYILiX/zJasXg4Zspr6yOuYDPW26iqK06soxKNE2xaVSEq+skc2+MAn+wyunsAZ+
	 JvxkWX9NctvcOWT/5X/kPQwXQ5WAyGtSwMbiohzJTcH02qFRB9NgANl2hOOM5XG2UmUuq
	 6r016Um2utgnvYDkiR9loeuZpVqj9ih225j3H9HRvU8hfPDEDxV5+JNCNaBQZ5vFggA8O
	 4dJUoVbzwcmFapG10qIkhfNFQUMYpbSzy/r1LgpiHa2GHmLczLSMk/J7NYpqLLyj8dBn9
	 19vG00peSLMY1ctdBnn9pzzr7lkumLg9YPP7DeQuCKPrmBT1d17k2Pu+4w/lgTeuABQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=LN3aDWGx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.96
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021096.outbound.protection.outlook.com [40.107.74.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73191606A32F;
	Wed, 21 Oct 2026 04:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73191606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=LN3aDWGx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qS2hduIHZCMmF0dNSrdeL6DEXU8Tq32DVKG0RFZ66fCuW31yz9uJ3ZeoxwOgTBC9FKoXUZ9YrC+GNjCFGvBznMdCIqoAdCPvTuHTkqXa88WSz/Q2Wrra32cCxKuujjU85ayW74eDVgHf45G68MQ2BsLZhfsRnizP1rHkvlmLhkkZXVuaihTcrhyVjM4YLgAJ9fy8l+8fjULkk7X4DotQBavDHn7zK5s7cjdapDDvC3rH/WWiYooU2bVDmefrrs9/CAs0fWtBKeXnFhJqbAVNLjQXVfvigP+hRxW0zw9QmnaE2HT6v0Jm252e7J4yP36Hj1UgY7SiHsTAZIeUx86y0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0l11lJjx+sNXwZTMr+dfhjAvIPdz6d4CR36z2Lps84=;
 b=qifZx/lRxgitNxM4JRKOdW6StFEnudYDOZ0xDG70lOO/NQuW3cMry/DVkYnZ1BEQaTeSCWp30qY2Q3WUtGCrm8mbvByTTo63q2QdzW2t+E9lpu+3tqu6P0RDIBpDo5jMQWRnOIgEJM9b2E7l+0ANXbQ9GLRSRrPXrHVBv+p8tQYbYRyon+2nC1GTLwlKvcTSrwAck+CUMflVfhU4ruz0a2uzTLiqJwjQ+9ag9gqXYfYQuHnXOHGiJpkEOEOAAurW7mtjOQc2qZJoYGzlnwxXlFYoWflDGM6GGG7/OAidrgl9oHrnR8MAj+ro7LVnaayIGVx2p/nv7+NQqeGxkyropA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0l11lJjx+sNXwZTMr+dfhjAvIPdz6d4CR36z2Lps84=;
 b=LN3aDWGxFt32/Kvp+K4DL1V71eqcHVjgi5WWd0XQMuDXBELVyV95k8uPjzmvYZI3L2pv9LQ827P09Cx7ESk9NCE9J4DHFjKb+cgNwPkQf5lkRACmfzoJxJYmgRoCDxyzWV96/CptCUM8FxJ/EAyfEfhCK8V+p8LdgdSYqtFuwiI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3180.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:22:41 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:22:41 +0000
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
Subject: [PATCH v7 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
Date: Wed, 21 Oct 2026 13:22:25 +0900
Message-ID: <20261021042229.2280937-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021042229.2280937-1-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0071.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB3180:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b45d62-95d4-4710-0098-08df2f2af2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	i3lNT27lms38x1ssMpk8R/vbwlLUOAE9OU3KwF0nG/rMRV2zgfg/KYSZCmNbsyFof4xpkzFLHpz7AeljuqRGF1ZAI7ii9GL2Z8VJIZYbpFQWJsZGnnJVEnNFUn86Iwcpg3eplqRgFK2JzsVb3w428KtP7xddIWVxhT4/WiLHaGlaMn3EKw2YIjtZEtNk+UqjSauU6wMcywbmG8R260h74bATSgpzkt7SHhGEanZURak4jNNGgZM3WnkjwFU5V2Z0DwbYop4pfz2j+LLDqz+ltORHN8smj6rkmkvyxMtNX97YaNcHU1pr/MPOVkli6xreXpkz8HWKKVJOdV9Ccf2gpq+29+cvpsNJybCPCUlj95RnbbUr/u2oPmOFgQnUnEzRV+3FN4z2yJxE2w6j+037Gp4pG+FE2VN3F3CbBwAZVaicvN0qEzWE16XSi2okqP86aaEp4Gaxu87pmFrG+66J5CPFNN5Q4Ye/50++7+gFCODvjFpi+pbdt42Sg6YJaQH81LH320lFn32UUxxu/UDwYBLpz1dSWVPLYJfBIvPVDVgL4CK3CMo6ZKNtfVWPpXeeRGM8zr0QzBiTxDs0zRJVSSM0J+kHfJO9qvoaMNBfoAu5ktfpmXlxdinhFTMz0lJZWFvSxvYoJtEaekheaCearPeZOI3TO6epFb+9+uTuifI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CbzS312KSPLzMv5QIBetwoJOJqsCu25JedbcbJwMl8BMJpgGFYumqha/akLP?=
 =?us-ascii?Q?UwTYXyG+FW/pISDisGOm4HcepoooJr+kGPHgJIwSdnSPjKzGYlKecvbAOHT7?=
 =?us-ascii?Q?ND4qUwiLXw+EW34tO/+WhzurQ8k5A5AmhtcfdpbMWbx4AtnCU0IV2xmBLk4B?=
 =?us-ascii?Q?2mHBdfWjB2p+6egfZmO97CQb0xXJzSGwXzpDwbCf/CSy9H5XvWBKBzcBmtd9?=
 =?us-ascii?Q?5phQBcbic4ZqDfIzac/FE7KZZDyB2NtJeFbxS64CPaek1qsbUjcruPSouBup?=
 =?us-ascii?Q?8umoS5b3jxeAR5NTK7X70y7ucc1TrYFZUXXzkOTiDws0djs3WhtilxqZSUsB?=
 =?us-ascii?Q?RwSCauFSFrQ3P18SEEIeL71El7aCrXrICKJfe026v9LKsn44kw3SLvvoyxTM?=
 =?us-ascii?Q?duzCWYNk2aJuM1DMUQC17rBIo0JNYLOT48DwZvx0Sc4Rws4cezQVZfECDc4G?=
 =?us-ascii?Q?LGkFmfvBrIAlD96Rhca3LriZr9hk2CxQUvMe9cv8Qtr+cc5d83FqU/cup3Xg?=
 =?us-ascii?Q?CmTrVQcmttd2APeLmP8neXrFSf5xzGN/ypOldhoWgonLBplAlYivw7WVT4Mv?=
 =?us-ascii?Q?TdgJacrLxFnhnh4NjDooivqDRh/Z24wx2kcoP9ixNFc+0q4eeC6hA8YpUjst?=
 =?us-ascii?Q?vHwDC/BK0KTMdyg70KeU7UAWQI3v6sMJF5GLLAGlHfCxSloh3yDRFtQ8UWq1?=
 =?us-ascii?Q?Zajo5ghV+zlXFtIJPPI28/ELASfy73c0iU1a/6ZxHp/tGj6LoT6KEKLGFJsN?=
 =?us-ascii?Q?jjj0l3OXAaBtXWpDf9VfZ06oYT1yQ2dULCX606liATnlnfqwLtV06PxMQi1+?=
 =?us-ascii?Q?spxKbpmv7b04thJ2WYNuwn6pkI/oCxF/3TchNR9UvkoKmn61BoPtC3uMB2yn?=
 =?us-ascii?Q?11lPhV55X8AqHixvF0SOctMmwK7paTgltv0hmO5QTMl4i00QXRSIuFqB72GA?=
 =?us-ascii?Q?NTRAOy+LYssL0w1QPYf7nnnh3XWU1gbu0+FIAxh/yaaCnIBgJHkhRY/cjbww?=
 =?us-ascii?Q?jTbEoYgsklirnbsl1dASpcDmL+6dv5aBY9NnEez66hWAMk9PjLG3J9wfL4b8?=
 =?us-ascii?Q?XdkjK7W7dfE87X2L62Yp5gW5mSX8NbxUwkRXTLK27AlX8dR6NL7v6u+Eeppl?=
 =?us-ascii?Q?jvMnx535wh9Krum/JH4uqfTCtLmvuyqbPfL3dQkxjHe6iqGEpYlIBzcXuEl5?=
 =?us-ascii?Q?mgzU1WDOA4DVqfeRgBp0oLNCNM3Td4ZmIUO1hwyv+Qk8cLFQ4ri+JOaFUKxu?=
 =?us-ascii?Q?hZXFzPxeHryuAxTXHRgEv3GTKf7WouYqeEwmct7wqVAv7XWHRI09Zog7Nlpi?=
 =?us-ascii?Q?QLmna1pnyNd6agogCgZ77jmnF2odIi53iL+HQ9HDCGcKzf982LT3SKL/8J6U?=
 =?us-ascii?Q?yJbLp1dkQf3KHq1UH8slla/JSPZrLXVFcDsOurHJH9m1y7ys6n8DteaHT0UE?=
 =?us-ascii?Q?IRbqt8H8c8hZ9XKgEQkC/5Ekq7VgBjdXNsOcT81ujMeTBaYfj26888opEAmu?=
 =?us-ascii?Q?fZxJOFpyzOQE+gCXBijeG+AHfIvX26/0My3zfMs6U48PQjDMuvDs6Kr2SPJK?=
 =?us-ascii?Q?CezecGfeBf3SOvR7AgXK3AzWpYZrqc5vhllvB6ZR5ra8BD1Y3wU19yIN/UwV?=
 =?us-ascii?Q?fbl0Oik3MfxNS7BwUdPWhvwLcTeX0KvEL/Cc5nxn5oi7MG9apJYgn76j5fzE?=
 =?us-ascii?Q?zfz7EG7GOAkQvawqd255nkI8m3urLGHDbsEFHasyv2OEHGSYgto39E+XawiV?=
 =?us-ascii?Q?dLyPB9cziRePiNB8koc1qIBKAHt+5YcwOfvnoHz3OS87cpJvEWfc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b45d62-95d4-4710-0098-08df2f2af2bf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:22:41.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3d85OgJDdi71mJ7zLjY7xOJdOrLmajYwXVGOPI81iMVKSXdkptXlzjm9B16VHr4jgY3Mj+5YVMzdJtwqVH34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3180

Some endpoint configurations have no spare BAR for DMA resources. Allow
dma_bar to select an MW BAR and place the DMA ranges after that MW.

DMA submaps have fixed BAR offsets, so a shared MW translation must
cover its configured size. Report that size as the translation alignment
and require it to be a power of two.

Older hosts treat the whole BAR as an MW. Require the host to advertise
MW/DMA boundary support in LINK_UP before enabling a shared-BAR link.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v6:
  - Split out the host-side changes. (Frank)
  - Require MW/DMA BAR boundary support in LINK_UP for shared BARs.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 154 ++++++++++++++----
 include/linux/pci-epf-ntb.h                   |   3 +
 2 files changed, 122 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ac83af54122f..721cd841a1dd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -84,12 +84,13 @@ enum epf_irq_slot {
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
@@ -229,6 +230,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
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
@@ -353,6 +370,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	unsigned int i;
 	size_t align;
 	u32 next = 0;
+	u64 offset;
 	int ret;
 
 	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
@@ -371,9 +389,30 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	if (!is_power_of_2(align))
 		return -EINVAL;
 
-	if (epf_ntb_is_bar_used(ntb, barno) ||
-	    pci_epc_get_next_free_bar(features, barno) != barno)
+	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
+	    barno == ntb->epf_ntb_bar[BAR_DB])
+		return -EINVAL;
+
+	offset = epf_ntb_dma_bar_offset(ntb, barno);
+	if (!offset &&
+	    (epf_ntb_is_bar_used(ntb, barno) ||
+	     pci_epc_get_next_free_bar(features, barno) != barno))
+		return -EINVAL;
+	if (offset > U32_MAX)
+		return -EOVERFLOW;
+	if (offset && !is_power_of_2(offset))
 		return -EINVAL;
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
 
 	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
 	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
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
@@ -607,21 +648,25 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
 	memset(bar, 0, sizeof(*bar));
 }
 
-static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb,
+				      const dma_addr_t *mw_addr)
 {
 	struct pci_epf_bar_submap *old_submap;
 	struct epf_ntb_dma *dma = ntb->dma;
 	unsigned int old_num_submap;
 	struct pci_epf_bar *bar;
+	dma_addr_t old_mw_addr;
 	int restore, ret;
-
-	if (!dma)
-		return 0;
+	lockdep_assert_held(&dma->lock);
 
 	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
 
 	old_submap = bar->submap;
 	old_num_submap = bar->num_submap;
+	if (mw_addr) {
+		old_mw_addr = dma->submap[0].phys_addr;
+		dma->submap[0].phys_addr = *mw_addr;
+	}
 	bar->submap = dma->submap;
 	bar->num_submap = dma->num_submap;
 
@@ -631,6 +676,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 		return 0;
 
 	/* A failed dynamic update may have already removed the old mapping. */
+	if (mw_addr)
+		dma->submap[0].phys_addr = old_mw_addr;
 	bar->submap = old_submap;
 	bar->num_submap = old_num_submap;
 	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
@@ -642,6 +689,18 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 	return ret;
 }
 
+static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+
+	if (!dma)
+		return 0;
+
+	guard(mutex)(&dma->lock);
+
+	return epf_ntb_dma_set_bar_locked(ntb, NULL);
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -780,6 +839,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 					     EPF_NTB_COMMAND_STATUS_OK;
 		break;
 	case EPF_NTB_COMMAND_LINK_UP:
+		if (ntb->dma && ntb->dma->ctrl.submap.offset &&
+		    !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED)) {
+			epf_ntb_set_link_enabled(ntb, false);
+			dev_err(dev, "Host does not support MW/DMA BAR sharing\n");
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
+			break;
+		}
 		ret = epf_ntb_set_link_enabled(ntb, true);
 		if (ret < 0)
 			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
@@ -1269,6 +1335,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	bool shared;
 	int ret = 0;
 	int i;
 	u64 size;
@@ -1278,22 +1345,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
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
@@ -1310,10 +1380,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
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
@@ -1331,10 +1402,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 
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
@@ -1936,6 +2008,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	dev = &ndev->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
+	if (epf_ntb_dma_shares_bar(ntb, barno)) {
+		/* DMA submaps start after the configured MW size. */
+		if (size != ntb->mws_size[idx])
+			return -EINVAL;
+
+		guard(mutex)(&ntb->dma->lock);
+
+		return epf_ntb_dma_set_bar_locked(ntb, &addr);
+	}
+
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
 	epf_bar->size = size;
@@ -2134,15 +2216,17 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 			resource_size_t *size_max)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+	u64 size = ntb->mws_size[idx];
 
 	if (addr_align)
 		*addr_align = SZ_4K;
 
 	if (size_align)
-		*size_align = 1;
+		*size_align = epf_ntb_dma_shares_bar(ntb, barno) ? size : 1;
 
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


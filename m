Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657367;
	b=h9LDOGXFwYsS5AobJe0bwFO8Kux9xNKP7MZsW91pdSlY2+onH1xrlf3llkrozDNgXZPJ
	 PsHEvbW3duVtSQ/1HQaelKXHvZXgobq3+VaxNavyVL0Oec2bIHpUSVYJmOwMnWqmphXfy
	 nEy6pCcLStvvMHuQK3XQ4cBfwJL5y89IxXl97M+EeGHL3pD/ffj9QDDAxQaJTmdNLjbB8
	 phoxQBugbQQ651i3bp63eShRRQdzSR1VS+ZgzGuEtmHrroK6u37BKopzbEozAX2v2GpWh
	 oI76epAWa0pwnm2hlA29rdM4ZnPydYZO/xfQuLmjF50k4lU0XcdrfMRYzDGfbBO2e2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657367;
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
	bh=7c/GQPuZTds0fbbDP+RSxn/l43GeDHlVIpBSFotXF0g=;
	b=DjiuiFQL6/Aa7PyU63QLA1VJ7UaPkZx3641EbjpYYHPzfpOV7QRRC8imnwHGCmQVdRzW
	 Ot6X6oB2wR9c2OinXNIlg+9MbCcvQI/7+KvqVJsjfGtCO8RQURrshkDTwfCbUjE1Sk4dd
	 95wi4Mc8/jo6hEIIYRCumCBV58kF5VssjLOm9iBKLqPlkuVvjTtRhIMfjBBU/QGmg5s45
	 Rl57QUUopXY2cnbym5jG0ZdAnWqUV/+9sX2WdRAK3yPED1z5pc9IFFFyV1upCVYDLup9L
	 3ZdOfpx9cgqQvriC82My2rjedjuN3romqyd+c55uM7+hIMutixFTJcXYZxznAWxpKUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=wBNusL1N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E5606A322;
	Thu, 22 Oct 2026 08:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491E5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=wBNusL1N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNue37LmL4HlFN2hy4wOYg6tTKz5RCOCfZF+8hDzMcobixHm7wskMt9TUblhuw59Fr2c8J/fYWYfmr2pqiNWTawQ5zCiDYrydgs5vNflTRdveSA/kTlUqKCJ5ROV5Smmuv/YaWTNQHbpNnUwrH4SfAoZ9d3GeLDzujn3LlzJrtCpASYaxiXVPbCLNegdI40qi99rx6gYWzTOOZ1K56YbpF/VXaWC+IlQ5gxMAiLR/LLVJrtdVsZ53Simj2ZN7l/NhcciPI/Q8oI8bbGdk9V5JT9QlJftWkZMFUlYnTPqj3zXXiWNv0+77sSbnurfH0Rv60LIo7vv/TqIag1d9Y46qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c/GQPuZTds0fbbDP+RSxn/l43GeDHlVIpBSFotXF0g=;
 b=Zkp7XG3bNiUvXgLw2ydm1egQjZSLpVB0pKX2wHYBQ5fnv5Ch7fCI/zsFhBAxLiaqeeadJVnJcsv6uPc60RV16gYYkmVJaoqKjWC7p1ABMPeMj/7OiQD+uDM11iwFLCggifppPnppZ1jWIb7jPhNDgfE5KsfViIFzMF2O2kgNCHqi3yR1wYyAwm3UzQW2MiR3ZujSv/KH2npJ0xXdLuteQdUVXp3GicZZC+RNCK+xRu9ISr68C4s53pnNQ4gnJ9UpFg/kIQw4wwxCQcONajN4++4gxxgJH/XR/HoVLs0T3VpWX7VIy2aCOdHxXuGS9SD0FweA5ZcCtWTGF9WbBui0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c/GQPuZTds0fbbDP+RSxn/l43GeDHlVIpBSFotXF0g=;
 b=wBNusL1Nw73gpOY+vCjY37K4zlEE0RClp60RBa0irGoQwnezd6QdlV7jZUpgTrvHJSIO2YkwmkCSSufyIjbZ4Ee4XZZ5Cpl2m5Jo+iu1IVMlKuYhEAdER5OhsSW3kPsYPLiBvzb7iOm820Khf1kVj9yTcyTmfQIloqPUGI76oaQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5275.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:22:38 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:22:38 +0000
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
Subject: [PATCH v8 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
Date: Thu, 22 Oct 2026 17:22:26 +0900
Message-ID: <20261022082230.3164834-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022082230.3164834-1-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0026.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bf0617-4b2d-45eb-49bd-08df3015a258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|3023799007|22082099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	xNm8Zq1+rb5XGTqxVc3pGhhTctR2tIvRoRCe6DJbz4Q6ZUnpmiiZMfNoonXvijlZZkfC8l8VNIGuav0U2fNYgo6Dq5Kcln02bkVw8VA1F47dXuqR/RymmanBIAUnzgmkTKhM/iK7Em1zdxdNi9VK5t0dwwaDnUgD+o8Fnh1MG2GQ5oNRzp+IXfoR2BoAY38F+y3hzYmvbqB8s7KAa1rtvahy0Io9rcczw6vArDrymx5twCbI/zuQgZbKZijPD91W6BDi0aU7jR7e0KrJPecMboRUnRbmZvUjZ8f6K31cEqRVudKgBoTmiTE8Gn6BmDohyBzhVZ3xwgzu6FidJJ6jIYFju/jzzICbymhC1pTqfibJ8mvsBCKhr7GVJHBeeH+vjpfbGp+86odMpYTxbo1mC5otj4sgkp5F/sKAPL8E0PbPrcEHD8kWd+HVoGbRWW+c06kwZ/C5o5QXcbaOgtKJDacas8Kk4LSDx7aHSFYi5kDTns869veLkJJ0eFxT+Cgw15EGneezFAQu3RFLBPe0MQBwusGHbrhb6f2QxS92jMFGUkrH/fHa5Nfn1M/rFqI1GwAphnwJ2Lpg7n5Ox5GywbET0+MsqZHl6jkW0nSFTWIiT8yaLnAThw4kpr4BdtlW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(3023799007)(22082099003)(261021123027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5X/yr68BQ/J8LV9mVkI4JkRVxkwX7mE7FHO06PTdGu32cZRAaD9n7N4i3RYq?=
 =?us-ascii?Q?I2lo/FZdMYDjiOfhYlfd1lwjgzap0G+B/W2yb+66TiQNI0Z8/VgZg1W/wLtW?=
 =?us-ascii?Q?GfZQif8tGRPrR16qneEDx+O61CUtvFknPYvp4l6Sho3ZCpj3eox2OOLGmWj5?=
 =?us-ascii?Q?gQYCTyjQjjJouTUXoQrYA/JUslPMStJZYsJl9osOsvv0Vw42c0UUTe2j9idz?=
 =?us-ascii?Q?xKq1MG3tIgy+mTDKQu3gm9bP2L58tsJooeGmwq8lFRapMhKZjS6e6D8ToZWM?=
 =?us-ascii?Q?al6jsvIE3tj+FOnlvoSugPdFvvU8yFSX7/5oYsPPhI/xX0fRXDTajclxqcHr?=
 =?us-ascii?Q?p3gDlk2Z2/V3imoIQse4++yzNJf7kr6VObdxwdEL4nsQBPdHV/om6/Pk0/Xo?=
 =?us-ascii?Q?6slX87QgCJAZ7SXsRmEtErWnM6/+7MzGlYHpGTQZP2odLY1LrebqURppYqQF?=
 =?us-ascii?Q?D1SizuC1Ii73r+TGksEdns5z6y2fJQfTU+6+kd+YIjX4xqgNybcSdeygnmnz?=
 =?us-ascii?Q?nJQkCTtlyrbjFaE57hMkbRLbv2RG9veaxahrm3g7NpIwg+drQOFCUBXFlqxP?=
 =?us-ascii?Q?yuiIW8c8Wu7zbuGbETr96PRNHqlBSiSZHkSq3OLN6Yw3E14+/o+8u3/yWBos?=
 =?us-ascii?Q?31AtETJyolTryo/ZLvNoOJoKcphBFcElRY1XXhkcYrKO6FcT9z+ceylPJAVY?=
 =?us-ascii?Q?a8T1QpoBP/G8OUBJaTwbBaWsLLoYm++4KIAPglnyjziLiEV+sFCJUUd+XuT8?=
 =?us-ascii?Q?0EDruNJjBVwd0moAZRZt1ZnfZpr0KNNJ5YvNwnnuqnYNIHzUKiXsA8djfOnH?=
 =?us-ascii?Q?DxtZnt+p1/Jozxxg2WJRd5ZU9u+AHJqO3Er2lf/5jHuoL1an4i0/oUhY108L?=
 =?us-ascii?Q?pmMYU4rL89Ib2h5GCOSBWF7MboHjLZOHL8DYU7D4kNEl9hPzRQO5Md5dCOth?=
 =?us-ascii?Q?PrhlVgP1cLRSy3TGOCXmwDlo3rLhuy47ZDMnNrMW8/KDU/58ayzlF2Och1sk?=
 =?us-ascii?Q?qcUfujegQs/PEA2YZC/0PaZkS7iXJXh2kLt4IKz+JdSqzKE/IA3/6bOZGUa/?=
 =?us-ascii?Q?PMVXAuLlfmIzrDG7iQKzFBszO3tp9DqGdSButCN3aot6V/yhMm7a+FTn6k8p?=
 =?us-ascii?Q?rAcRukKSKsYc52D2XXrtO/gVkn1EN+q6CSxcHhII5Ky1Du9xdpaJu899+hrh?=
 =?us-ascii?Q?kYotPMfpgBMjRQewrFMSWNvgQjyLuqZSvc8Hdxl02K+8vDUxNb59SJxxtqu7?=
 =?us-ascii?Q?5+ZvutnKCnbdTslx9uUc3akYyLqLC+yPMrq+W4G8STplyUBCUk6t0vG4A8R6?=
 =?us-ascii?Q?NKFMmTdHhDnnVFvh3Ckqy5TXh/F5Yd/EkxQ8wqEeyw+b5TgX0xwlLNnol0EI?=
 =?us-ascii?Q?7EZN03YnN/hs7RKNQEiKvC4VuTB13hnM2VaiiKj4YuPn5T+QkvhI9+E3f71r?=
 =?us-ascii?Q?JLCRbZawh2IxuaURgdm+sZBY41EP00OG0hjbMK9vM3eORodlS7yK9esi6okY?=
 =?us-ascii?Q?ZrRrl3eWTUijte9dJltxgeZafwAMBEalP/sMRgUdE124be8my0MdP+qbmvdZ?=
 =?us-ascii?Q?s1rjg7eNHetRK3abERDFkKN6Z6K12c+pa6/EMnZoB+2B/Kz/1p5yA9DhmrXZ?=
 =?us-ascii?Q?4bLpbwItVKoJudcv2eM37RI5MBWfmx1Tag0MtFFrTlhfmm9E+q3ifOO5D0DT?=
 =?us-ascii?Q?L3Ir/yHgNc45DFDmCB48g3VVOMxehqlVGQM7OyXoGAMvrhSsw8tjo1m8qo27?=
 =?us-ascii?Q?s5QZpy+w9AGUuhd0tErrhGZ81cu+0C1fF0pB97A8E117XHVtiVcL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bf0617-4b2d-45eb-49bd-08df3015a258
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:38.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rC2X3NrnAQVqm/FeioHeBEAUZHudAqk4JRlwT0XnTmQdoGUPcwSsyLk7pAaqjecXcL6AbY3Q/UIZ1hAWJECRyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5275

Some endpoint configurations have no spare BAR for DMA resources. Allow
dma_bar to select an MW BAR and place the DMA ranges after that MW.

DMA submaps have fixed BAR offsets, so a shared MW translation must
cover its configured size. Report that size as the translation alignment
and require it to be a power of two.

Older hosts treat the whole BAR as an MW. Fall back to that layout when
LINK_UP does not advertise MW/DMA boundary support, so that NTB keeps
working without DMA: the enumerated BAR size is kept, the MW spans the
whole BAR and the DMA submaps are removed.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v7:
  - Fall back to exposing the whole shared BAR as an MW for hosts without
    MW/DMA boundary support, instead of rejecting LINK_UP. (Frank)
  - Share BAR update and rollback code between DMA submaps and fallback.
  - Link to v7: https://lore.kernel.org/r/20261021042229.2280937-7-den@valinux.co.jp/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 220 ++++++++++++++----
 include/linux/pci-epf-ntb.h                   |   3 +
 2 files changed, 178 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ac83af54122f..2f41a37a2e9d 100644
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
@@ -371,10 +390,31 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	if (!is_power_of_2(align))
 		return -EINVAL;
 
-	if (epf_ntb_is_bar_used(ntb, barno) ||
-	    pci_epc_get_next_free_bar(features, barno) != barno)
+	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
+	    barno == ntb->epf_ntb_bar[BAR_DB])
 		return -EINVAL;
 
+	offset = epf_ntb_dma_bar_offset(ntb, barno);
+	if (!offset &&
+	    (epf_ntb_is_bar_used(ntb, barno) ||
+	     pci_epc_get_next_free_bar(features, barno) != barno))
+		return -EINVAL;
+	if (offset > U32_MAX)
+		return -EOVERFLOW;
+	if (offset && !is_power_of_2(offset))
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
@@ -408,7 +448,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 		chan->desc_addr_lo = lower_32_bits(dma_addr);
 		chan->desc_addr_hi = upper_32_bits(dma_addr);
 	}
-	dma->ctrl.submap.size = next;
+	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
 
 	dma_dev = ntb->epf->epc->dev.parent;
 	for (i = 0; i < dma->rd_ch_cnt; i++) {
@@ -481,6 +521,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
 	if (!dma)
 		return -ENOMEM;
 
+	mutex_init(&dma->lock);
+
 	switch (ctrl->u.dma_ctrl.reg_layout) {
 	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
 		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
@@ -551,7 +593,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
 		return -EOPNOTSUPP;
 
 	barno = ntb->epf_ntb_bar[BAR_DMA];
-	mapped_size = dma->ctrl.submap.size;
+	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
 	/*
 	 * Submaps cannot be installed until the host assigns the BAR address.
 	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
@@ -607,23 +649,29 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
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
-		return 0;
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
@@ -631,8 +679,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 		return 0;
 
 	/* A failed dynamic update may have already removed the old mapping. */
-	bar->submap = old_submap;
-	bar->num_submap = old_num_submap;
+	dma->submap[0].phys_addr = old_mw_addr;
+	*bar = old_bar;
 	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
 				  ntb->epf->vfunc_no, bar);
 	if (restore)
@@ -642,6 +690,51 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
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
@@ -780,7 +873,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
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
@@ -1269,6 +1364,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	bool shared;
 	int ret = 0;
 	int i;
 	u64 size;
@@ -1278,22 +1374,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
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
@@ -1310,10 +1409,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
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
@@ -1331,10 +1431,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 
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
@@ -1936,6 +2037,21 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
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
+			/* DMA submaps start after the configured MW size. */
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
@@ -2134,15 +2250,29 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 			resource_size_t *size_max)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+	resource_size_t salign = 1;
+	u64 size = ntb->mws_size[idx];
+
+	if (epf_ntb_dma_shares_bar(ntb, barno)) {
+		if (ntb->dma->mw_fallback)
+			size = ntb->epf->bar[barno].size;
+		else
+			/*
+			 * DMA submaps start after the configured MW size.
+			 * Use size_align to require a full-size MW translation.
+			 */
+			salign = size;
+	}
 
 	if (addr_align)
 		*addr_align = SZ_4K;
 
 	if (size_align)
-		*size_align = 1;
+		*size_align = salign;
 
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


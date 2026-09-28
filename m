Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021136.outbound.protection.outlook.com [40.107.74.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35234E3241;
	Mon, 28 Sep 2026 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614396; cv=fail; b=jptALtGpl8GPv6TUpEbsF1EdZwnL8AmWwclwnLVHPgMlCOt8ypXpXujCiU1DXns0P037Zyzr7PwOvmZCQma6v23qN2yI0wWMpM7G4bIiHXjGKAuMagAEdliD+nmbqirmqawBEvwMBQiZcRW0SjhG8vygZXcuyBYzyrnov3OXJJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614396; c=relaxed/simple;
	bh=66ALHeOS3RtEEKGDJ955em/iYTFhfwcYWa6NLyXBPKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OY5Tnsr4tY/pS4tawjsk5hWmTIrnm6Fa7AKMirI+VoU0jeOT7BHy8prYvyZFkhgOqbU4QafDfBORX3LylSrmGr/iNt+j6MctwNCHFbHvrZrzCc68b4y4VtLNv0S1qkWP9IlvEp/f/PFprFxLCjwTjuE8e38EMz1Q00qcfyZipRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UM3bLp6T; arc=fail smtp.client-ip=40.107.74.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UM3bLp6T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZgbHEjf/V3lMgqWugiCt7D67NgBP+JuyM8jNYziYYOox7XlDOjzSKZbVrmf3Pj8gA20/xI4C2btBGCh+/WurOyTxDhIR8R7rJO5LBMdJbhVvf6gDM5PLpslSGD8oIgTLlvIDyGtE93NFuHC3e2t00F1c3MB928LmBVoGCzKOroFfzLZG7GziuapD3tFH/kRuRdkaLvgGO08c53O5a3V6dyeORrgekHBcLIqI+ZtRoUSz5PIzzs+qe6Lj5m6ojb4pJsJ2hM9ohvqnsmODyYqE/KRqoe86lq9E/GuGDNHEf61bDkAmmhjkybPmu3CA1mfH07Otv8xYnXCp6D2li1zQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbsjRyklPpIjbBNrt4UtyglEwWsC4hA6lxcl62p8MnE=;
 b=qkqi7NI8An5DXshPes0SnA4VOenVS7+HwXNrOqX9pSBieqRxfk+MKe6mQufv0fhhVTOP33HKXP7OOwfFdyIpCOfqUzFWbx5Dt1+TTmphaGs5ki/4coxqkLki/qgHI1TVUH7vCIozQx1NHxTJSZcebdv8aSOWLj379Ol00ajl+VhdWNPwfDALpVnndBROBY/MJ0yBH4Wo5eb34XCTr/b1Qn3uE7l+tj12WatFP6NvVVvehoDPRVNtJMLzwmwBMbFVUuC92jzjHjgrdKVZXgq0W827rdSo3tU//xmTVPLpoLBGIysjFsSyWAbk3XX93lnFomIibvBGNsK/kd9Jni+nyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbsjRyklPpIjbBNrt4UtyglEwWsC4hA6lxcl62p8MnE=;
 b=UM3bLp6TlNbDNm16T6vXBVvffHYkGKhLXoc7Qy+WDqTRNR2YOpZqEW21qm5UEzG0nz2YaTXNTgmJO43iO45DPfPAwXUj4iIXjkcEP38rIpVu/+3idBr/j3NPU7vh/e58QEEjH4vsXjVl9t9U7ZYSf6+iHsyKhWAKHHlQl4oG52w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:06 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/15] PCI: rcar-gen4: Add a controller reinitialization callback
Date: Tue, 29 Sep 2026 01:52:23 +0900
Message-ID: <20260928165230.3397664-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a22d09-25ab-4e93-adfa-08df1d80f83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6IfxOmHhBqJUICJlWOa/TAEKaBTUR4uba8rzQsiLjtOJxOFTaup+6mFq5zvqvYLTBIHQmlQqGpST/CH6W19Xd8j7/ZvE2rYSl3Y+cP6eSB32zni/HMsgw7PKrdTLfyE8srosQWoV6c72IxmO9ezQKwkDz0539kGoRxAR+Jvs/ow8vSDuFXYqe30dSaBMVVRReoaCbU4XuXPu2AOuW18to3Z8H+F5fn2Ylt1B6FrgN4Lt9e6yvwLiKtdwOOAHTyVjGbI8bttG5OWrhbYdzrKuHzhx/tVmh7lglnrhhZ4at6Viepf4mK93ogUX5Y/JbMRF3gpRRGuWyXGGM9hECNZckI2mefn5sPYbF73BQAfp8/bzQW/lhvPeSNX+fBPTg9MPlF4XznxfmYmw+skw4GY3cWMQdoXuv3wo3jzhv7q01zVz/kuXvqvarYq6J7RKnvdmNsWp0bbIlnKXegaCBM1BpllPMwnym/DUJXM3IWtF7SkS0mJy5gkSHcNpePXFXTVH0fARqT3/UcI7Gug02RPKs4sOBdkEak+AjH7XOxYgZ6UhTRlHK3qHuElFZrxs4y1gmkE2hWwBV1N4P3wbIKdY6bP500s21h/S8cpDC7kRe3nTXr25V645ssleSE08CfFLup8g3JeNv/Wx1+n5KhtmZrpZ8YXF5jwKxjU4nh5k4nS5V2/7aok8lLjw6KVgijhVAiXIVvPErP9h02IHctLiWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tv0Giuno4y5MkSjfhJ6SG/vhZgtp18uKfP0LTfKkReoGJpqSZ2uK9C608rUa?=
 =?us-ascii?Q?HHHVTaxHgAvvAK4kn08MC1oiqANQgJ8HcqDoPupORz/KmUXHIeNABsb88Hoq?=
 =?us-ascii?Q?KFthw/mWrq2jhgEy0DMsE6SojbYbSqEixKT+7CXpXsPQmMLi0Z7oQHcq4O3Q?=
 =?us-ascii?Q?SdCWeu8N0iInV4M+kw5rnyaGx6hCFKfmcK2lBq0Gt2Bo5tbvWRKtwuKOv4yd?=
 =?us-ascii?Q?KJ+h4CCGmh0YoQI/vpTJmeNWhshy31ouhbnLWnUgZk4/PoyFfFb5HaGcydDI?=
 =?us-ascii?Q?qVTants4/KV4HX2PBjNppgfxw0PLzck3c+NsCX27WPXTf4EcA2kf0QMzFe3t?=
 =?us-ascii?Q?HmvesvEDiIXXaD64ixQWpi/E2TSkcDoKHipt9xFUHoW8pQe/m1cJyyoOZRhK?=
 =?us-ascii?Q?bK1JkpLeDksak/QFA82boFzJuUyJA0EjNg+DA/JDoG5pxdufrdrrWp0+NRYd?=
 =?us-ascii?Q?cq/+bVCP+SBVKv/P9G405WHnIEPu6MH8IPEYggcZ+hTEfiJ75tSmxC7JpKwg?=
 =?us-ascii?Q?4rY+G6eUzJyqu6LhhgwQ4t54BshvK3YGaL2gDMwv0VpnT3vzI7eBOvdvq+wt?=
 =?us-ascii?Q?F6/AomOt7wDqZkC7iBxR7+Yu3PV8lIg/GPhpMSx4tVI3IPzhBAeUs+OhguWK?=
 =?us-ascii?Q?nm81x25nDYXreHMvEEAnA7lfnHQ1CEDgudclCS4pkG0ednHtQMwVbHpVsjJh?=
 =?us-ascii?Q?p6RIGH8b8ayVqiwBM2G+ZNVZQ2qPXF3FM9cLONfo4S6Y4dPtXofliCqVIoJ7?=
 =?us-ascii?Q?fo9rsmEMCXVD+a/GzWu+5k8UZVnDlUfcCNnbOG5aQ7zjsMBVJ+du4HjamAQr?=
 =?us-ascii?Q?s1aUse2oKSRbFM3zw+1bBJ1iawgYqH9TprLo96PzHY4wQEg8AY6yMURsZ/44?=
 =?us-ascii?Q?zwBcWFVPrYN9saql+RLnhjQveozhLUHB/b+M803oLV99M25OjGqzoPBzHdKL?=
 =?us-ascii?Q?Snxt0f43ghdeQsyQxubwEDMNmlO8zhOBXQnl9jq1oVRbRK1UT48CmMCKUJDQ?=
 =?us-ascii?Q?Uf1yfIHiacKNsq9ESJhHgrxv73PQxEcPGkv6fQzNQYYtXuvzz3dBDh0FBtJR?=
 =?us-ascii?Q?5H2r/RWz/ovEEtKtGwerUY0D/fbVZJdKAVQ7NaNHMGyakwk1NVOb36fDSftP?=
 =?us-ascii?Q?edU+vL+Y3i5VFxr/rCMupTwwwHgJgK2clon+BjzPY6QNVm0CUfE4CTWQrNJB?=
 =?us-ascii?Q?pn8fPEkWgkEANRdpxo1+PEhkMYTHymliOpmqrvKKsLH7Do/+Cs0XJvPOM6k8?=
 =?us-ascii?Q?DfLKl/vp5AhPe8QNe6FOChJgXRAIp3DqA3qFTR1BAt3e/Xoc3eSoxMxNngyQ?=
 =?us-ascii?Q?dQoRnv3vgYbo8BlgM985iPKz2hm3QAaDWsWF/dR8kSom66R7FwyjxLONJdl8?=
 =?us-ascii?Q?qrhsWRvWi6CGR+x40rImzkvWW32pZpJo/auJsAi8zlN1uh0AW7eenC7dwyAT?=
 =?us-ascii?Q?BDltFad03zCewVis7n4PJdvFyd7+K3iGmFvBr0htWO4f0r1RNBhjLU6IwC4a?=
 =?us-ascii?Q?4Y4db4E6jAb3JQjUiz0epeMU6lmLu/Dcqar9gvgMCVyhYqmDGvxYd4ajlqbs?=
 =?us-ascii?Q?yCeDcBXLHvn/tzQzv+6s0iZ81atzvAQ+Sx+XzrweyjI7kPtVyO3f5UWt/7QY?=
 =?us-ascii?Q?ngHCzsbq0GBWgeOEryHfkMbW3ifO6nLL4/5b0z+Ox+Yu7yMn9fpy3RGQGdxh?=
 =?us-ascii?Q?AZ+zom0Jp4lyhLmnGsaQEggAvg5i0e3v8yrGl2MOhBY9pRmSJ4sN35GfyydW?=
 =?us-ascii?Q?j0QOGsmu6EB0o/pUvvX57gbzYDfkSh3CbX+g6tQIIvGfMKllC5WU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a22d09-25ab-4e93-adfa-08df1d80f83d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:06.8530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OV7uQcsmhDdjhCji2dA+yZtmuRlz3OcPhEfmeuZimNfDcu3wU9k1OJVoUS3tE8YWn3MLeC/kmyte1/hojhXIMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

Root Port recovery needs to reset and restore the controller while
keeping the clocks enabled and the Gen5 PHY initialized. Reusing .init()
would acquire these resources again, while calling .deinit() first would
make the APP registers inaccessible to interrupt handling.

Add a per-SoC .reinit() callback that repeats the power reset and register
setup without acquiring or releasing resources. Use the same reset and
register setup helpers as .init().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Adapt to the per-SoC .init()/.deinit() callbacks in next-20260925.
    Add .reinit() for recovery without changing their resource ownership
    or taking another PHY initialization reference.
  - Move hardware setup extraction and Gen5 initialization cleanup into
    preceding patches. This patch only adds the callback and its
    implementations.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index e73ef6ccb145..d1ea94272711 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -99,6 +99,8 @@ struct rcar_gen4_pcie;
 struct rcar_gen4_pcie_drvdata {
 	int (*init)(struct rcar_gen4_pcie *rcar);
 	void (*deinit)(struct rcar_gen4_pcie *rcar);
+	/* Reset and restore registers while clocks and PHY remain initialized. */
+	int (*reinit)(struct rcar_gen4_pcie *rcar);
 	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
 	int (*speed_control)(struct rcar_gen4_pcie *rcar);
 	enum dw_pcie_device_mode mode;
@@ -341,6 +343,19 @@ static void rcar_gen4_v4h_v4m_pcie_configure(struct rcar_gen4_pcie *rcar)
 	writel(val, rcar->base + PCIEPWRMNGCTRL);
 }
 
+static int rcar_gen4_v4h_v4m_pcie_reinit(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
+
+	ret = rcar_gen4_pcie_reset(rcar);
+	if (ret)
+		return ret;
+
+	rcar_gen4_v4h_v4m_pcie_configure(rcar);
+
+	return 0;
+}
+
 static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
 {
 	int ret;
@@ -385,6 +400,19 @@ static void rcar_gen5_pcie_configure(struct rcar_gen4_pcie *rcar)
 	writel(val, rcar->base + PCIEPWRMNGCTRL);
 }
 
+static int rcar_gen5_pcie_reinit(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
+
+	ret = rcar_gen4_pcie_reset(rcar);
+	if (ret)
+		return ret;
+
+	rcar_gen5_pcie_configure(rcar);
+
+	return 0;
+}
+
 static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 {
 	int ret;
@@ -1105,6 +1133,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
 	.init = rcar_gen4_pcie_common_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
+	.reinit = rcar_gen4_pcie_reset,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
@@ -1113,6 +1142,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
 static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
 	.init = rcar_gen4_pcie_common_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
+	.reinit = rcar_gen4_pcie_reset,
 	.ltssm_control = r8a779f0_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
@@ -1121,6 +1151,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
+	.reinit = rcar_gen4_v4h_v4m_pcie_reinit,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
@@ -1129,6 +1160,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
+	.reinit = rcar_gen4_v4h_v4m_pcie_reinit,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
@@ -1137,6 +1169,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen5_pcie = {
 	.init = rcar_gen5_pcie_init,
 	.deinit = rcar_gen5_pcie_deinit,
+	.reinit = rcar_gen5_pcie_reinit,
 	.ltssm_control = rcar_gen5_pcie_ltssm_control,
 	.speed_control = rcar_gen5_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
-- 
2.51.0


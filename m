Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465883;
	b=B7xPvkauurXNmaZ2TL7C6IlINqv7r7O2mn99Zj0wvfNrOLMUEtlOvcxESix/6l6xNQ4N
	 LRwVXy3YWy3EeblxLDFszDKrE9GdlBWdptXgWWg1Z0roOPVvbV1zvUAhdIs27NfvHqiJF
	 07YG2JrNMwomRDIxRiVe6wLrGrEMAdOptczuq/2bv4uZbF/UUXElN0GFOLckW2RY745lo
	 A7eqItLcDr+C7xXAMrA92L/Df7bm4l3gIkcbnMU3s2YZFuxNA8EV7v5r5CO2+maJ3dDfq
	 bK9gpEu2Kz62gPVG6/pT47aFTCnK2Jj4aENW2gMI9gPBs4a4/G8D73t6poD/lDToabg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465883;
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
	bh=a2p0CqtSKH7VywuKxBZsmRT5gZiFmS0J4CladMhLqrQ=;
	b=qd2u56taaGqqe83HszgX4xiQ8/ir1mbrIkUwx/pgbxgwtp5NEe7MB7oQHYia9y/lJSwr
	 3REDBBNuvLfeAcD8yJHtIfjKDgbL/lbc6z4dQMWCNdT9bOXZu3c7OBBEdwRyf3oAnC8B3
	 S1JhVVTkha88zkEQunzh/+yer21JnQGhYoC3Dpu6Y+uetUH33fnvqQVmlKHzqRPzBkfzn
	 lWQLZxaUDH1QkV6ITa0A4w5ht0WkQ29m8wFzvjmkNf6SdSXYgjCmf+Xp4A3QdMCnX02rs
	 aTNHeK8x1dgHKcmnD8FQ2WQm8H7h7Og6isKtYy1ipanScHWRE/j+DulMRaqCoKt6p1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=o0cP0k30;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9777606E570;
	Tue, 20 Oct 2026 03:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9777606E570
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=o0cP0k30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBdss0YkQEGF6hSZQ3bzHhgwu+oZAXL3xa2Wnfah0i6Y3i/cEzvZ6PX3KzOm9fGHSyROB182W9KHOoFXRBzBN8Guq7v7mRxyfVNs7stWmOtEPk3IhkdpwmrVVnB9A0SEkwaCWtwatWpD+z2pGLp5qHxlZJiEFTQnt+8fwQHCnaeiYOYlsgvx3Ctc8IUU0tH26TZo2VXaW1g0FiMe7D+xfSjjSxNSFDNFzRUxy2zNL4LyZQtQHgA+w+PciQjls/HtvSt7yyVUQX0UtrxFdOKnK+RDT6njLF2+IJqIDyXyPzihXtLlGu53IBRi8uc6xVUCpZyzMx2as3Xr7kY9+uY6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2p0CqtSKH7VywuKxBZsmRT5gZiFmS0J4CladMhLqrQ=;
 b=wh4j7sa9NWkM+eX/bMZrGsoGvtE+EVQIdcZfZJA2QUDottkmKkyeDYXtvIwOrmdQhwgb2vOwLsUQSY8D3l4Xn5WVxZkm8zeDN1VFftGhd69Tbsx6YDlMI+HzIT07W9X7t2xFyBuOgC4SZDx+OdmMP4mLDPWiiNr6qt4Si91g7gBeu+bmfeY90q4Hv8Rv15GxIHSmXgtwR8JHmJ+wsIzvN/LXpYxMoh9ZWzSiiA2VAE9urM7rTUqWQ7Qs/EptzYoaAnsOQwcMXfff8TurwBZTvjSd4iYuIlG3SNhlRPfJb8E2EIR7wag2rVjgQf+TIgpT+0E0pUd2mLXlAwBE3n+LOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2p0CqtSKH7VywuKxBZsmRT5gZiFmS0J4CladMhLqrQ=;
 b=o0cP0k30hLdI3asfgRdzZGWItJSVEGc2V6yE+JOjP8ykDj6qAOjQTDOLGbwBQQm+EzMiGJpVtAGJxOmZI+Z9I4QrzP/6hwxYlkaLE4bDwFrDhfseUJosCMeCluOXQgqEaULPnO16OQi3EZ/rf2HyiztuCmyyCIi8mkgO/iMYOME=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:11 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v5 14/17] PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
Date: Tue, 20 Oct 2026 12:10:46 +0900
Message-ID: <20261020031049.969895-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e92c6f-f23b-42e3-cebc-08df2e57caf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ExocnxsuLbTbFJ+lZ9jJb59IID2A/81LRIn8LJUuxcMrAJDH5PtlXCntMPZx9dJ6mdZ9hnbf6LL7JC+cXVneGWrLivYqYvSh8ba8ptC7M3sLuGQZ10hBZeuWAf4B5zvjxTnm79Gkbatuu1nJeLePEMHqL7AgIRrMKSRI33ICqf0R4M171pBReD1cBBZr+RYg3gB37zBli0dZiBZGfxu3BCfjoMt/3B47OZ8yYe2YmWSTG4UMSkzcfk35/xeqDXyi8rRme3zO47vvogwLk62AQr0xrMq5/nH05iaBRPieOk8NwkULlh7NV8mEsB9UXa5nWdBHto14BR2zJYLRzjBMV2g8k1PvroRoky9822kQe7YCr/HY3ycWXR06E1Vs4cPwVFSOgeBTTjKG+/HP3jx1LTx9YibxlTcnu3HU1oWvP6CdcEB+781eotuVSM28eO7syrPo/EiC6uTrXLhqG6+fUanlGKtg39CsJF6rIyd0ih4NrgUQ/EFwhbijMlT2GlrhDQG27a4MO+wyohItKO2V4vtffqBwCYa+WarY6h4iGnf29QivX9Xpi0hmlnX/5u4qFlanSQimwARaQhd5NCj0zhfIGbG9anedKT7j9cmRBbdcwz8KVO0OgE/VLcuK0rfIPZBIvOe5l37B8aTvqDSDklTDR2aAWzUZRU1e23uiqaYW8pfVLBrSuEjv/TAgrXJmjlDJ4fdXxD/Sy2eovm+Y5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ban52WWrYpsRd8BpGphKIeEIk4i77MXMitXR+TtzZrMtPRndtRzzlb6RZ71+?=
 =?us-ascii?Q?H42OtPMGGqSsZCT8hl9z6Rq6gLIoMPfGiKSyrsoUC1JYn+tqdQXHum8zhhMX?=
 =?us-ascii?Q?PEM9lNateQn4gwAsB7ijWMV0O/xOV8qdoQDhTMzBqVaTOR91AgyrYuZ29lJ7?=
 =?us-ascii?Q?uBdysUDpPorOG3nMvjT5mqDsg/45Ke3CbmQDyO6nSnOK192Jx0vL+P3rSzv+?=
 =?us-ascii?Q?vR6Tsf4pAB49mbD1Xh187P/EydBWEXWZEga1mODAFxQcTWiwG/4kdJXsUHvk?=
 =?us-ascii?Q?5O0jx1ZFe2t7NQ0dUdQGAJXrYz0D/0q6jwnlc4wz1Bx+aLWdFlTDmbUWLYXk?=
 =?us-ascii?Q?sS5vqgjOsTVEdeC9O54xCGU12IV6meWD27sb5Jao9oTkfNxmfISxpVTbitrg?=
 =?us-ascii?Q?hPD1I9Bnc6f9vU/TjOQCUmnmjxmRMTom88wtgiYaPlALB0AXxNl/HMTvR79V?=
 =?us-ascii?Q?9MzcrCeRYoE2XDbXaRVlxqxCZboO8UyjNswNDapPKIDknUt22DQbOGqjtVQo?=
 =?us-ascii?Q?H3H1z4jucHAwy3woUp3P+78xJc+SPSLMnFuQE4OBISXMx1FP5v8uY6W/IUzD?=
 =?us-ascii?Q?Ih0BXOnT/7N/Bezoqjmf7c5QiwUgrABxlNnD1Oq/m0o4ZgrjhH7wQLSolSu9?=
 =?us-ascii?Q?tUt4UjUKGsiILPtgOzdm4nfImdOUkTiPVAM6RhtXz4tWMMJ8jWbd8LtJgDht?=
 =?us-ascii?Q?9RoESDgEgEzg3L6j99wOG5H+CsMeUSOtos2vSpMqvknpP3ISOi+Xn9utV0DH?=
 =?us-ascii?Q?pRBsTLINYRY2RgtjGcIxqwbSAfUM7b4w7+8Cwx0wDVaKCX5iyX/Mew1efOeA?=
 =?us-ascii?Q?HP0bghXimZWsz4QRtyepqSeT+2ml1IXZPQSJQV47iSLUnOfbyaqMwA4NZvFe?=
 =?us-ascii?Q?boCbHusVJ5GXPWBN2kS9M82aeC5S+gXzdknEcBrOq5TCuK/sjs3wDaKJGkkv?=
 =?us-ascii?Q?MZXnk5nuH2rvzuRBmBaPmpfjqFxRfqL1BGT7GjWtpmzj+DeVPj+NFOoa0Es1?=
 =?us-ascii?Q?5bYIHi7ZnBnZM0Lwr9DOHWbzYqbJYmmwh1QOIFGBHsqIb/iMqPIY10H/GCgZ?=
 =?us-ascii?Q?GlMoXncOUIvPSDAGKJ0yfff/uEC72Dw1GyaD0O245MWTdS22B7XzkxzhiAW+?=
 =?us-ascii?Q?1+6iuKIWzv4jWnGecMZCCaaL9TYwwsbq3+Vh3O5XqbA8xcX9PV/gBhQSHpPk?=
 =?us-ascii?Q?0owFn7wZmEKfdOCHOuNUvOt1WuJr8C1RFPSBxNkL/2DflD/6Z7TK2HgjqTdY?=
 =?us-ascii?Q?HG2Yt5k9TxiqLJ0jTxTdahExzZazjjLQ73Iakfrr9h66aSE4IdVy8S0ClI1b?=
 =?us-ascii?Q?/Ib2Z8uAMC94mNYTyYlaypbVqVh2tSs/a2a9BCN4U5NWqDLI/iw7ET46UvF1?=
 =?us-ascii?Q?U8A5CiQt/LIC6Mq/Ax2z2E7tueNXpfEjdTy4X3iOnayQHQNdNFZ2Soh6/95G?=
 =?us-ascii?Q?NJE7Wd5dyknApTPTr0uC3TB7GK5K8IgKs7BTgFgx5gP4+k8Rf/XBHQ7/mnQ5?=
 =?us-ascii?Q?A66CAlSJnI0pAywcCiyraTw5UL0d/cYcF1JwrmdQJNUYqpSnAU4yoQp4aWvq?=
 =?us-ascii?Q?gJqbczLvAliVVgQf8smoMs4lD3nMEl4f8HTAm99HNhWQ9X1S5uSnktx1SxYz?=
 =?us-ascii?Q?qYqfDpPmV0T6XcU3cwoLF23leikj6Xb7yU8M2NstmFMRtYH+dDSdWwV5gCQi?=
 =?us-ascii?Q?xnLaz1glQF6bAv91RTwUoKs/ez6c4wVLJT8yaUhZBphPS/Mb9kjNB7ADymGR?=
 =?us-ascii?Q?mD+LCifvYsfuWiqbMh2U7AhSohPZpLGTwapBflffUESvaKaVggNh?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e92c6f-f23b-42e3-cebc-08df2e57caf7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:11.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4n7n/cOTwhzknPGN8uKSrojLzZxpiyVkB8p6tAKKQS9z6FIiRGLGowenVicR4tk82Po1DhvbQoLEFgJMmdiDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

The Root Port's PME and link bandwidth notifications are reported in
PCIEINTSTS0 and routed to intreq_pcim_sub, the interrupt shared with the
integrated MSI receiver and the reset requests. Dispatch these
notifications to the virtual Root Port IRQ from the "msi" IRQ handler
after handling any pending iMSI-RX interrupts. This keeps Root Port
service handling out of the path between the reset-request check and
the iMSI-RX status reads. The existing dispatcher rechecks reset requests
before invoking the port services.

Enable the sources only while the Root Port IRQ is unmasked, and clear
the MSI-form latches in irq_ack together with the AER one. On an R-Car
S4 with the GIC ITS as MSI parent, a notification from a link retrain
now reaches the bandwidth controller service, which clears LnkSta.LBMS.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 30 ++++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index b0440f2c5329..063b10563c63 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -66,6 +66,16 @@
 #define AER_RC_ERR_INT		BIT(27)
 #define RP_AER_MASK		(AER_RC_ERR_MSI | AER_RC_ERR_INT)
 
+/* Root Port notifications routed to intreq_pcim_sub ("msi") */
+#define BW_MGT_MSI		BIT(23)
+#define BW_MGT_INT		BIT(22)
+#define LINK_AUTO_BW_MSI	BIT(21)
+#define LINK_AUTO_BW_INT	BIT(20)
+#define PME_MSI			BIT(12)
+#define PME_INT			BIT(10)
+#define RP_SUB_MASK		(BW_MGT_MSI | BW_MGT_INT | LINK_AUTO_BW_MSI | \
+				 LINK_AUTO_BW_INT | PME_MSI | PME_INT)
+
 /* PCIe DMA Interrupt Status Enable */
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
@@ -75,7 +85,8 @@
 
 /* PCIe Interrupt Status 0 Clear */
 #define PCIEINTSTS0CLR		0x0340
-#define RP_LATCHED_MASK		AER_RC_ERR_MSI
+#define RP_LATCHED_MASK		(AER_RC_ERR_MSI | BW_MGT_MSI | LINK_AUTO_BW_MSI | \
+				 PME_MSI)
 
 /* Port Logic Registers 89 */
 #define PRTLGC89		0x0b70
@@ -136,7 +147,7 @@ struct rcar_gen4_pcie {
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
-	/* intreq_pcim_sub ("msi"): iMSI-RX and other controller notifications */
+	/* intreq_pcim_sub ("msi"): iMSI-RX, reset requests, Root Port PME/bandwidth */
 	int msi_irq;
 	struct work_struct link_down_work;
 	/* Allow Root Port event handling after enumeration and until teardown. */
@@ -579,7 +590,7 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
-	val &= ~(MSI_CTRL_INT | RP_AER_MASK);
+	val &= ~(MSI_CTRL_INT | RP_AER_MASK | RP_SUB_MASK);
 	/*
 	 * Note that rcar->rp_events_armed is not checked here because device
 	 * removal may still need iMSI-RX interrupts after Root Port events have
@@ -589,6 +600,8 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 		val |= MSI_CTRL_INT;
 	if (rp_events && rcar->rp_irq_enabled && rcar->aer_irq > 0)
 		val |= RP_AER_MASK;
+	if (rp_events && rcar->rp_irq_enabled)
+		val |= RP_SUB_MASK;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 
 	val = readl(rcar->base + PCIERSTSTSEN);
@@ -736,12 +749,15 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
 
 	status = readl(rcar->base + PCIEINTSTS0) &
 		 readl(rcar->base + PCIEINTSTS0EN);
-	if (!(status & MSI_CTRL_INT))
-		return IRQ_NONE;
+	if (status & MSI_CTRL_INT)
+		dw_handle_msi_irq(&rcar->dw.pp);
+	if (status & RP_SUB_MASK)
+		rcar_gen4_pcie_rp_irq_dispatch(rcar);
 
-	dw_handle_msi_irq(&rcar->dw.pp);
+	if (status & (MSI_CTRL_INT | RP_SUB_MASK))
+		return IRQ_HANDLED;
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int rcar_gen4_pcie_msi_irq_init(struct rcar_gen4_pcie *rcar)
-- 
2.54.0


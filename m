Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D23EC685;
	Thu, 15 Oct 2026 03:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035106; cv=fail; b=lX4WXT8HwIHKnIMNWDf59EiUhMabGmZmE0db9Ul9a1L3OUbHf/oSRu05horSE/9UMqTMyOAC+luAVIvrQkKKTjD+yVVPjv6iOZCY+cSq+180eZXXbsyHC7uTVJzWyUx5mPBc3gPzjeJA2ygX7S0uDT5eUBFnLKVkPYPuM6H7eqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035106; c=relaxed/simple;
	bh=PlbZKW8zzw0fA4AhXp16djDEGr9tRWxAP2IJnPF+aeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQqgCcVSQBHq5WQVAKEhaQf1WGM5kmkfn9g5kpDhzTQLrRT/nnzTA0oJeRbqJR6tJysVkV756/FqNZIQJbELCf6ngVGAwu7zyySxhMHP8ptGTDh3uHLVQUqMwEB779M1D6l5XyackWGlLI+kZnGHDXTtWxAU5NaVC6V8XS6W6vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WznjNic8; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WznjNic8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywRLQ/SPVRkSA0bJzqAXiaq7J7hGo1YatpJF7TO3alM7bCDJzSO0WmiYi9o8oNMsV2Vq1SgcGorT+Ia5lN68rtVY/oOjkOWfSqfUXN5SZVs/77ufTj4x6byoUnezs79nKVdK/keUSjKjf+FY5Ls/PN1OHDVgmVFWqwAHzlVKoBffd+n0QuH4Z8LBgxNrwTKUVQ79iNEJwkvc2sROERXsdvmGHv4zpJtFXrJssOu82vDXBnUdeq+V8mHJc15fbI0aG2MFrVqcNu/o5qplp/tcjAeQxK61DAHZmVDG7zY9aIFNrZkhCEB6FXTRWS1+8Mn8ItivWEKos1g/HK37It36tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFYL+V0oMf/0GXItwPvSJ0eXSzmaPcs5uX+4R+xsCDs=;
 b=Bi151hlhHn3V1zQPh6UoDd1efRSeL1FdTWfvPTBCxBP/QLDBsF0++pdAUUhDU83gNkClUhZwo/aydV0Xf8Ma8o6tabTPoqDyjo6TCODR9cl1kaBFb/BDt1XkFMEP3wtURj6O3fP2KXk+dXxfFI+x8TCBvTBjy18iJAgak6LTF1l7Yof4WFwwpTIvopqiur7qYYiGEhq0lEaefGOTVdyHXBja+u1UlzzFDPBDupHY7o+5wfnXcWfQC5O2mN7h0gfXCOSgpeVvpMrifuIpNBOS4sSCUIdRhk7dVzMyv+qK6KN2XS/993l0m6hOpfm5k2wHFeMDt0mKgxpLHnzecINENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFYL+V0oMf/0GXItwPvSJ0eXSzmaPcs5uX+4R+xsCDs=;
 b=WznjNic8/GKzKtAStvvh5AA8awf6/SsMHY+MpgiomWjNSnFmNFhP5Bdi70YRDieGJM0C6I5F0gGBn4OgTImJ9LwBS62zw0zeT55zN3LVVw/BefnFUjSK6vvGzdw4XtdGq7Wock1cYNVLW7++XaqUyJ0jmp77lfBtXeGuU1OTF7c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:23 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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
Subject: [PATCH v4 15/18] PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
Date: Thu, 15 Oct 2026 12:31:00 +0900
Message-ID: <20261015033103.3076869-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: b20b23d9-6fb0-4503-cea3-08df2a6cc911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wK/YXPGBrYHo+bRf+HsxF0as9mXJkmY3JBcObK2RKzWdn90cdrlLY9zsHlpBtAPnqT8VnELaL1jl26v2wJIQ7Sxm1vxayicucWspSIjY1thwLIyGtsotGUPDuLCbIfvfnxf0QuWlT44LkrzOd16KadkZJ0Hg4dq14Na2jqvRI+I/luabNa9F2v6UfdN0ti0uaLiW1obPkUKPnxIFzPaS8tunK8oUPQ0YKYRRfw7VR5ag3yCaya3M8rREDNwVgJzIfvol2JVH0uVGs5NWtpwnPLU0t1vFuBWZkLmH6hje+ywFE8XcFiD0jpFpzJ/Uv800JaXnxXAqAMXQyZj1ZgDGeUUnZ/1aNvwStMK1r0uWLxpga2IARiWyrpBVl81toYa8GdWdneb9hcOPGQuhE4e2/WvFfLr7k31Q873TaXFVq+VJ9tt3dBw5ZsAL4Q7yJQKrROzOX4bJJoJGaSe88BILi4jxkWJM/6VLYs+MwdS/lfGUEVQtoFgNP+VY7QzzKOjzA6ShoEnr2ebyWxtkZcwiopT7MKEQoeH3Yhfz5ZFQtfaZ9oqd83s5kN6Osq4w7DbGHqSzA43q0h9waDrdQCUNCR74VAm2jua+3hfDG6FBVTJ+iCLtKARUcQxBBZ+GrJXE2SNZ5RFqFfKkl7pkreX4+HXCMGFu49Umkyrmec4kvgzp+RPZiysZo36CwV3/AZsK5DtIONDqh9E9qDv81c+UHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?60RORg/1sFX3JvULbnZ8SUHm+c4JC9oU96sTWVUoyZaal7LVdm5AMHKIaGb6?=
 =?us-ascii?Q?gewU175IA+yPu4zVc/E22c21k7hQS+OZ/uHdfBnptzGtLb4r6bHJWPpG2I0H?=
 =?us-ascii?Q?cjrnhka1iZeK3jRgz6E96M1iEGLyRRosuwBif6K+XlbgzQ+3SNw9Y5HXh9Yd?=
 =?us-ascii?Q?o6bVAeZ3Z+kLR7FuloLU9J3x27ahlxq/g0QrWSS4KPE7DETMjHlpgrASHovv?=
 =?us-ascii?Q?qgsxbVhpEd0mxmXSYEksVLVITGxfjd+tjic0EOyxZ2Hq7wVUjoplvUIunJgH?=
 =?us-ascii?Q?WTMbO+ZQogPNdek+cF0GHvJ3zXWy4DgH8PG9iG9cjLEN62vxXCKF+zJD2F8E?=
 =?us-ascii?Q?W4HxnYBSiIKRVUR3BhuNolrScYC1lfjMqVdDy1tn6KB805K6QM7SPbLIPMO+?=
 =?us-ascii?Q?66BIiMiAd0JP5JHJuQRrV9KucxE4ef89YmfKmVexhAIpTVgyON3or8N+zSWf?=
 =?us-ascii?Q?LZ2+oh3P45M+tQTD4zXiDXU2BS+RBuANn0KtiO5eohz8OyIyRdRgYpiym6rX?=
 =?us-ascii?Q?4XY59H/WQiqW00WmpBq06YptGj+i0LtkceTjxAoB5YQzfTRpBEqC3usalVlT?=
 =?us-ascii?Q?O7eSlV+fcnKPF5BObca2e00sKPE4Bycwx6cqJlEQ0auqdvmwjR3q+KzxJt1r?=
 =?us-ascii?Q?el1PTF6KWxxCUpK/adgBlFzPWmtU3dZRJagBJfdq0QkJ1n13YZgMLnB0Swz6?=
 =?us-ascii?Q?iSf8Fk5CR1uQe6SftQACE/gkQW8JW10gI6KDbL+NMbizEjoLjPcA+2hgwSp1?=
 =?us-ascii?Q?qqKV7gNDgAJnkvdxlifnP9XCKm0PRVFVgSHkOEFaGbSvKWNTmuqiAXzIaIWe?=
 =?us-ascii?Q?Fp/LWexDlg6q8QhNDgyvWwsTWPohKAJdZd1bQ3NKWNnuCTeOlPLboXaxiUOY?=
 =?us-ascii?Q?oD2ltKyIHuUTDs0kGynTp8CdN2u3MiH+nPa/QmaGArDbkVuM6BJZ1W7XS1N+?=
 =?us-ascii?Q?Hlo7QCMU/oM+Pa18PcrQGVpxa8vuZFCyYwS5EyWNtZkl+PprCs0Vj1E2Hjmx?=
 =?us-ascii?Q?jvSwT74R242Hn5YAPMjQ+rtwVo/XQFM4aGvhDV0gbmCxgwI/kQDWBjmNiN2k?=
 =?us-ascii?Q?F74Ejky9QWjvaQwbw4D4riFj8PS1qWfM2wGy5OTfXGxoXc7ZIZ8tg1ZR99Hk?=
 =?us-ascii?Q?m0AkT6BMqOmclXfLva7QL9JkCoB4WbiNg9BJCvrQJhqJy8iEBsp345+SortO?=
 =?us-ascii?Q?lGiCadt8rgzpVwJSt+Z5iz8pgv/ufP1T1NaZodyZeCi8gSPDy4TdbfFF74tv?=
 =?us-ascii?Q?nc+wcgJlIJw+/Zm0L+Py7T51/gMV1ZALfYqrUCdidt2jc1ZLdE1Qdwj9OCkH?=
 =?us-ascii?Q?NLeJ40e+J2odPkwYqf/18I7l1GhMd2Km+/41JCBc82O9qasaXtIFcufAb3ld?=
 =?us-ascii?Q?REdqznuftVxIb53aQLf92y6UIJ4tHIEhFC0E8pi1ORM1oOvWCwUydITmerTn?=
 =?us-ascii?Q?qCOzwmaV2/1pl76pExg4Hs3FKhR1rY293XekNl70mc4rYRKmycNyoybo2Kth?=
 =?us-ascii?Q?k7+0Z1VyOG2E4BguCrcdwc82oIGMIIQ3Aix0WcR3T0opFjbfD28/Bs6+bIaF?=
 =?us-ascii?Q?TIYjCXUVcJnMdthfNo5rnKjnW4nlKwItIXGJK7sjvqijr6qckXpPJDPw3Pxj?=
 =?us-ascii?Q?fiC2RE5vcACCWuNwROaWSHR3P9rXsU2pcO9I9vOZpY/L3BhnMwTZl6N196K1?=
 =?us-ascii?Q?CqUOdJ5PKUNGMJvMtGH8AiGvpzLJMkcK+swQt46CgEqg2E6g7tmEtH2qfZoT?=
 =?us-ascii?Q?svNY5oVIpPxlA6RdGJjoNaliahRn0jACU42W8BtZWtE3NutU++B8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b20b23d9-6fb0-4503-cea3-08df2a6cc911
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:22.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDEcvQJCGNSns3YF1uxB/PwmiePH+iV7V17wr067j+XPJqXLBBR45d2mUeQWEKbr4jFlP/i6F1C/j5MgNE2gEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

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
index db0d5362eaed..040a51f7acb8 100644
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
@@ -737,12 +750,15 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
 
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


Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020139.outbound.protection.outlook.com [52.101.229.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E13ED3AF;
	Tue,  6 Oct 2026 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276432; cv=fail; b=N/Xet83TV1oFl3DGb3MyTEVH4wlO0t+n3qrY70syKitwqeDCyfpgCTVmok5DQcRgFWy855dGDOVzUnIMvK9E3mR9zwyERLzYtM4Hriuyfg29sBulFgS4Y5w9SoJpo9QCrI+BK9xUhNul8STdxOBaKEZnC52Qg+S/KwqY5pel4jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276432; c=relaxed/simple;
	bh=gHjliNT995X4qX+OWr6gW2WNeC5NQ/tD9Px9jQzDol0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UOzb04UgOfpk5bKOuaY0tmbrudVBx20oOyCNgx7L9V1QS22TBCII8sxQtnr1m8DO1n2ihWY+xrcyejm4M7gSdpBpqsaZZdQcZBvbT8oCp6jJ/lyUuFjiBJ4ltdVklnmsLVHxrmLqQV2B952QMbbif88czGy1NBktXsN5ntGKJh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=vKNrvKyv; arc=fail smtp.client-ip=52.101.229.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="vKNrvKyv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAxPvUjVhpJKoOt7SAjqTU4J4GYjduFcbiQt+FJsCoKXVa9Z4TRMyn3ZoaZaaWUAJMPNIVbPuJQvK3Vou6lBo63tpVnPOxSixPlbIeLAeDzaCgUutxLl9Gilhn1AJpqQNFCj/HpI/Ik9GnSmPZopJznxIrxh5jKECFhorXO5ViEhL798ywZtd+AexbcIIuRWAo6N2JCbeKp9/U5ve6Sq54ZvwVbgH42V5XPJtV7/LcaXkAgaLSpGWd5ZlfKLm0OqxhY+0XW/E1f0CRDj/63AuCHBT7a4BPvIVKe51AwTQEUuhZPrQGVEUvSu1elYlSNtKRh1KxzDTxSUGdPjbsXMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVWCJqm9HqpliZCv4z2m50clS5UB+TDkBEpKBk3OsQ8=;
 b=utNahZCwCcj2vY1ljnFHSCbdwINgJo75M/fTJwulet37BkUJwozX3c1KqFIfr2fQeFvwPv3ZuqYzI+QAfUHyyl5Zi7bzYAu5mOVPTgm6fanHjbLDtd+7sJQbwb6ygD81R23vbkrT5mog27rdyeXY/KKLOP/a4QqGzvO4h8oUp2+n2HUm8aNHg8Uq6hduOdGSJcub0JYZzF7au618mRvsbvPV+kco3NybmyiHg2KiWPpFtxFH0GxoCFAi9D7u2fq8K/zAfRko6IFgJfGlfm9iXh+cCmAi8jkNxxoASTW3LbAhy87vIrisHPB1TjR4CDoMUab8hT6Ejaacclth3ejlBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVWCJqm9HqpliZCv4z2m50clS5UB+TDkBEpKBk3OsQ8=;
 b=vKNrvKyvgC4mIZ5Pg/RWTo3jfWrqm2uQZobjt/A3fT7oF5DNqpDnq/vzT1xT0Rb02idYU+lC3Af+d1OcyLh232UzVTSwX0SvQa05rFe6c2vh7e3Z8eXEZc0vMf4YgUjhxAFupRfOogxyWvTiJZXbWq4z3U81USGQPIUludbC+QM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:47:00 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:47:00 +0000
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
Subject: [PATCH v3 15/18] PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
Date: Tue,  6 Oct 2026 17:46:35 +0900
Message-ID: <20261006084638.3821710-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 95284a77-f5b8-40e1-fea9-08df238662ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hDddUeUN8eJyzxv9Ja5dDLpmYknbxg9s1l5hhCRWgEeq850UwT5SQvEhMtvHCqi2saznxWf+jfn+9dHIn3Pd4IXSzjYU563bGnZfv6Zw7XQF2eYH5DuJq9eNxQnxALzqI/Lsa1LcYuXrImumM0TU+U088nn3GxaOoDr/1QFcaABC6iqVzCDi9eZQA1u5mB0+f7whJtGEferICE3jq+BTcDXukwokmwfiWxqQzvkF4grOvxTUwx4y5OomcgEU3dEm3EUPmYj0b0hNKxjJi+VM7kdhnzFvVpnXDgR52r6DH9zv9BMram7SkZI52eveFta7HFJDeIuY5dD99StBOVDlsyn3eDO48wbh95BS7yjqoDmOI4Sj2WiRnd4Ve/EMmTVyJt5HwkLqTZEZxQUR6+fCFZGz9Ay+54sV+zu7S+35HzRk91vYodEqPfH/QB10PgfZyU2CbbYSLUbG5BC6+O1pg0SreaHAueCKcv4kakc667E8205KG4LMu/ncpM3S9W4hDHgR9y9MMlsMfFSNCgzH9PEtoDj4EvUdNl546wEtklymRRYUAQnFzCuYw2UqF7IF5dYoCQxQ+cbx9zj0t0FMx2wqAL80Ibfd0ova2gXr9vDVbAFjquz83pFyt5ah880Y8kXzjRI7xjrE725Yr9xD+Zu6/1PEvk3jhswZPvqXFTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9CN2HCEwm44R//SQGIHGOYw3zdrYvUABM9b+Nec5T3b2wQ33m6N+XWdsQ24h?=
 =?us-ascii?Q?S5lacUYLuuj0UYRUA65IJl/Ci6avwy10siM3dmg35vlUXY0obubOlK7uUEfo?=
 =?us-ascii?Q?2XrFumYAcIEFJz2K8gbnC30q33LfVpEIRCfm7zTkEKFbtd899vd8RLr7Zuot?=
 =?us-ascii?Q?yFTYiGx7A/AUw0A2/EBvhoclDa68UAzUT8IbfZu7f6N+czBlKAa+3tPF5UaQ?=
 =?us-ascii?Q?70iTFwSqrjNAZhnMhfJXlpi0X2Q5Fcp9LKcySnrq+j6GA0Xx9GNaBU8bDh6K?=
 =?us-ascii?Q?ueopNFRovR+UuRXKQ+OXhEGY0nvVVRPVgXBiqtEsYCe2OJnPSs8C0z6Q12jU?=
 =?us-ascii?Q?MO4ElSwGCr1RDlg+6D8aR6qEz+K3GM0lDnorB4uvRikM+97aX+HHHKiuKZ4f?=
 =?us-ascii?Q?iH4d/7fukvQIIEB2ELrF6SyWsqK1f64WU4gRQA8wWePd9RnqnFsUTrrrhKRA?=
 =?us-ascii?Q?6wNisXWzQbHMxtXCFOajR+Vffrq4YzhIs6ak/W0ze07dz2gAXsJ2fnc1wiW1?=
 =?us-ascii?Q?hAn2Ip5e15f0L8ZSszSwGOSiOp/Dsu4E1VdW6R6kctY+XohWQV7OLVtruEec?=
 =?us-ascii?Q?CmaNCkIB/0feqeOaXmvUzC07kNQX4ZhngBH3kb44443SBppVGxumbbcJSy1y?=
 =?us-ascii?Q?2m8WkcPFnK8ou5x36VzLVVzlE7zP4z9F1ZuhywzmGlY7tdkqWBXn8rxk0olW?=
 =?us-ascii?Q?xb1ZRiwU9tgirhLJxRDDux3k/1kEysvYgxeipSo61JCL5gJ5yROcMoWY3HI3?=
 =?us-ascii?Q?yDvBcVZ21Hmi4EGlCaWAL2H6cliIssQ9P96hQRcqrZlM28Aa0Siw6/AQYHkB?=
 =?us-ascii?Q?neXTwGAJXs6JLR2tnqRrkHmt/PL6bep6CWVMqBr8ahtyi4hekHHOEm4zYpE0?=
 =?us-ascii?Q?+zlSEJbjFEuNApswPy91bb5SW8gsbAhaaDAQR/oYC6torQGaXP39bUgtBUnN?=
 =?us-ascii?Q?Ejyv1u5aAtMo/aT5J3dcU4MDa2PjUfL+1VgeoeRvd40ZhFK+R1g5ApSd0Wh1?=
 =?us-ascii?Q?1+5qvWLhxYowFHXO5YNB4w7C/jjSELzBsvl7GfRvkMM95MaSJwosAdigdgpt?=
 =?us-ascii?Q?ModbeARiC9EieyDpfYMsXse2xYhXUXrfNo/37/kJuJmdQ2M8HgnFkHlO/8/A?=
 =?us-ascii?Q?XGEsOk4v9+LQBOdb/R1EsXLUg4pMe49vsaDPt+w+T60IVzywLgNnUFW8/ip+?=
 =?us-ascii?Q?BTnf87GJisy9VRydGrjjKv9eg8I0/iW2aSHNcQl7O8G/i6DlHkBu5RTkWDZM?=
 =?us-ascii?Q?Zm5ZwLu81VJz+GO1M9wNjh91b8OzyiMl2rcZ7QTDhUHzrZGOL/qkuzRemuST?=
 =?us-ascii?Q?GJCB6Qt4FlCHlWDtDnhzM5hoiZ37FaEE8RV7sxSdzmbyOLEv0sJF0kXO3+9I?=
 =?us-ascii?Q?bsxAULlUOAQApZiJ5A/cmFSXrTGPmXB325wxGzanzKQ/V3zMuoRWUNmOk3dR?=
 =?us-ascii?Q?hoodxtQgA7pOa2Fm50LyZlYuddOmkqqMtKE3pzW7hsDQ/XzE46GKj8AtjK+H?=
 =?us-ascii?Q?cdajE0OlgDZUwYPB278I9UWv3385rpNq5e++mGy5I8s7TAA8LY6DFKELID/2?=
 =?us-ascii?Q?i7lhG5dhCshYC64CDTl71WjM+eTFQoiaCpRjusB7soGOK9JOHkvnxqlsp3pR?=
 =?us-ascii?Q?tmb30Hp6pYek/iOVuB8NTp47Zz05dcTw4aZVHz46egR5R8I2a4pjFecc+NGd?=
 =?us-ascii?Q?aXj3M6JLz6Mab/Falnt1UzTWJE/FT3zqAZsChal85ENXfg06rXmOSslda8+b?=
 =?us-ascii?Q?8+jVlDEdRLaJbc2oSiY6y0TOXpJXBPgwxOwF6VO54tT+t8Q9SdKZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 95284a77-f5b8-40e1-fea9-08df238662ca
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:47:00.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11e4eMAEZkp7SAmX8GgRiZiKfbCujsk0G565Cm9CEvkugrduRTIwqMy4Tmguw83KbHcAxGyGSjLboRNUMPYh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

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
Changes in v3:
  - Return IRQ_HANDLED or IRQ_NONE without a ternary operator. (Marek)
  - Add Marek's R-b tag, as the change from v2 is trivial.

v2: https://lore.kernel.org/r/20260928165230.3397664-15-den@valinux.co.jp/

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
2.51.0


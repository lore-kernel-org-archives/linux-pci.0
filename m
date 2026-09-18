Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020136.outbound.protection.outlook.com [52.101.229.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95DE3D5C31;
	Fri, 18 Sep 2026 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701661; cv=fail; b=BewObX8VB2QNA6DMOzWElk2pcC7/THGxne/r61XxsH97mvaQ3/Gez2nJzLQc5M92DmyWHKllO/D9ft8VoUgW5xUbmgbDBIXXiHvGqmygXzU00LZQqG7wtED+2VN5XVZAHlinNQcP2vrnXQr+KGowgZY9ynTDroCDHNEbZtFNGUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701661; c=relaxed/simple;
	bh=XVD0Sk/foCkd0GmKjU3p2+hUlMSEXhzrk1jASV9ifHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BY92I8f9eT5G8veJPeVRqHAVthK/aEBkBTFrzXn8fWgqbg5cvvnUfi4/O9S7bvbQWXUeYujv49JVZiT+eumOJULQcglc3SsxcO7vDogPRALMBCJSORNFNu+mNa+CUxb9RVNlqJinsAWjp+6kfHbXFCMGqWRXVjujrsKJ7ULSUZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ev8PzHca; arc=fail smtp.client-ip=52.101.229.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ev8PzHca"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyDs9x4+3L5afpM8atBcq79N+YR9tBHhcXY1/93YOF5M8akW9FurTvQwrjUbtzutvWQwgvV6oXAO35FIv0blccanERUDMzUDvZu2A5SpInLuq4FOCb88HLjsq2iGZ0JC2GhxRwyiccijHe5V4OFel6S5j+2lTQMo1dRh51FO8GXGPjgW5mIOHZSzH4+nbzFqs0Na2yEq0J+Z6ZB/wl/2alsYAyjqgjfHxscf0iphfdQ77bomnUpOvTH6w320xaypEDNYjs+XtqaQkK+5FBrwotPFlvnJPDNcblveQg600vMZaXSa8jivfJ8dD7tluTTKaSMemb5msDdPgBitJJk0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tna30RKNI7lDs01CtLJFwjZ4wiPUDTYrqtco36k312k=;
 b=V7gVBthve9ImKtDH0temQiP2nyLA+6fhAVUMU2lq0WBwUDbu612SkigwzQ8dbFLD2Ts198O3v9Z56RGPxXxSku/4qkmCdkkc1vobVRYfjSg0EoTbK3YX8/7BfbhcyCCDZLK/GcP42M9CurzLOLkKmugse7JkUWtzchKpYb4n0VueVtvi42aE+fPOmQeJTnr3OCi+iRPjuKdKQC0ieaihsAfgx7lQJ8DRa1V7twiaVpEbAuhPvRXq7r5w9t9U1uvADFxIMu5ZRUBjXC5J5DnS5So+91BRheiBBfrsQkUEHkS+v0FSKkWoIQW48uw6AiWqo8Ojvd+8T5KLL2WiOw3O2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tna30RKNI7lDs01CtLJFwjZ4wiPUDTYrqtco36k312k=;
 b=Ev8PzHca1kz8VodRhJt7vOX00j5PUZLI0NHJNDl1Quf8TtYVA4hjQe1V7yOgIoZtaV3boTC71QDqs5nvYCZsPKWeOSnlo+zl0YX294tzmDIDNxyef3WJzlOOas8yMvfNyk59g/ZyqwsXpluulnSo8sfH/r3cvwPH8saW8bEvDXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:52 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:52 +0000
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
Subject: [PATCH 10/11] PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
Date: Fri, 18 Sep 2026 12:20:37 +0900
Message-ID: <20260918032038.2216471-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0106.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: fee9a3b2-2fa4-4485-f61f-08df1533d7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|6133799003|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Dy0V0enFQOwJkBwUREpvd871QVlgjQkaFHDzXUK2Bbj9zVfuJNyoXG7TCEsuLd8nj9G58BCbzBW1uj+P222Wpp3k7pBdodSdfbjibnY7N+uP2VIzszGWJ0zBRP+dk3REPYoSGH4MGlgfK89dhxgpI0jFRntC99Kun+5PMBDO+plfYe1lwvXsHiUWQYl2vsnZBL2vvLGYR5pBb8R8Y9VaUZtCcEtrFmaWk6U3i7RRI0YkFJrL96vG5DUKc93v1kuF4w5JizZWdFcLgia3HchaJTlVlIZ9wCoZ7Nblam11m6j2mUzIQltU92MUSkP0BLUauy5XCx+8OLHq8bjnvxVTl1tdXb6FwJgswFXpT9cSLAXMfpCzcmf0mmsiqijFvmsZ0PSNqynatDuh13ZoTd7KmJAbhV4AzgXIkrYHovw+Ip7p5IHA5/hUGahY/s8XtwcaywQdfvEG08rLlOZ945y+HBdJD1VGAb7a1ONoGsyIv5D/c6Ecv2zwFNkhbewxBiNYGSVMDKe16RT7ZoIW2EeQfMxm0sohIFc2ggevqxjAM7WSFDMyWHY7om5IB8HN1mK8F1UNZSzV/jrUvU1ni+7HIu7ideyQ+xNX5IjXujXweM7usVZzsToL0Qs59LGDuk67OpSIYDNGgzwMNfOZllYOrn5U6y3FYnBY21ttBxK0yQB3IK8fbbqwduzTRnzVOZEQ4PkbXp3PzDQ50tC3BDTsMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SnqsczjULpXnIjItEf15FRE48SWU/NGPNYE3rDPluloXRgBw5KH5xYfY3wF6?=
 =?us-ascii?Q?AXqi4705GgA5fgtANAHZmXs40djPzXB0B5FZ4x4Uf31cE74E+Oyj6A7+2PKP?=
 =?us-ascii?Q?NWsu96OgcrLIIWgRjcp2mkwk3P3B+KDtX2kDn+eRc0G1wN6To+kLZTMzQlve?=
 =?us-ascii?Q?m+poSkd5V7OtMTXKmyEphsQuVFXIGH/VCNi5972xfXBXKM8n3S50NEZcWoiZ?=
 =?us-ascii?Q?ceN0So6Glyurahf2uUK3lo/wQkfnrFSmrrx0Q5bRci90Mtpdk2vkyMCRw5Fb?=
 =?us-ascii?Q?FR7dTkayqvfhuFXueupOfqj4eqW/4M5QEGuA/BV8nrkLuz1/qG+Tn6gkxWI4?=
 =?us-ascii?Q?Enm4VNvKbdUTkjJH9JdmTFEYsO4Rt/Bmmhpj2zDe73hRpl9lH4U1nue5Thfp?=
 =?us-ascii?Q?pjFkGbk2Ivsx0QeI01xN6I9kdvzzdPj/jZd59QRN2TGwtjsxjqrqwC3RmEZg?=
 =?us-ascii?Q?x2Pdoz47D2zfVOWfnMRw71QkUm+w0vXiziSvYb3tT3gWfHFNTAnEq5tRfEV9?=
 =?us-ascii?Q?1QWw7qbKjDDc8jO1ta8KquWLbBruSf92BGCv373fRr1UzS9y2TDCDSgLVTFg?=
 =?us-ascii?Q?A5IHnSOZ89kH1rWonwFpQ0tX/K4GCLLzG1r+OiKASYNZyPLizec+2z2+5UVd?=
 =?us-ascii?Q?7RwRdMc9ZnmDAUlRzPbOyx1SHcE2GN0xOf3XFeRK0UbuAHGjmT05rg+K/m+c?=
 =?us-ascii?Q?lGSYlEa61eL9vt2iw7ZSjwtDauMqEGs3YO6OvoOw3Ny7VYJQm43nrMckQIOE?=
 =?us-ascii?Q?6Kr/Bo10e0j9+EtDlcrzqPENyzj2RxWyRAodq5s1rKsr0wwlIEKQJPHraJWi?=
 =?us-ascii?Q?MRr52y31p4bDSGFMSNKhLruLN0FSAHU1tOJ6QiOSG7Y3FOxj5TF3/xu2Un+h?=
 =?us-ascii?Q?/UV/UewjTatjHEPyClIPMXkkhDc/urnZyGankjCwbEx23ywDlCzHzMwI0Egl?=
 =?us-ascii?Q?WPtA/lpMbhNx9RRjw9FTo/DMFlEUfLD/SvygJGfbGM65rqfVowQXkaK4CqSs?=
 =?us-ascii?Q?YLe42Qv3ItWi2TUmyqYj40od1wJqstz2QwSr8ZIjzWyvBJlQdkYQ/75J28WS?=
 =?us-ascii?Q?UEg/Z3bPUNnQm8jGX+fEgehZmPV3HtVSdxDS/gC0ySXDnLKmVGc7c3x+xc79?=
 =?us-ascii?Q?+uwgACfwP05ag7VnzskiaMcm/rR3i9MT9S2UdAiABYkqcSuYl9bjgc9m1xCw?=
 =?us-ascii?Q?uxXgjwFYK6onDVAp04Cq9MxLSCRUBSfMPKILiR4hnvh4/STELKQDb1kGuZvI?=
 =?us-ascii?Q?qaJDLVPqC+xU7HQ8JEW+gTUAbtWOBXqM4Kg3SV6Zp5nLv42n/PIBL7pZPCHt?=
 =?us-ascii?Q?C6RmMSM9NYf1VbSg6rMwVgPGtyEHoGPr05d4GyxNFRCHuuVh3/LUHg9hYnt3?=
 =?us-ascii?Q?xsjBGd4vzb6fZk0YH1RDWURZuOiPQeIXwZop8ONP9nWPCJLVQFKfwZ01CJMG?=
 =?us-ascii?Q?23944jDOLNAEtWIAKdaqRuvZ1xFSq8GT1CSoqdL6xZ1DGCW51iH5knJqekln?=
 =?us-ascii?Q?lMctxkxYpApaAkuo28AHzCNh4D9SALy5UCx6ORWJVvMviRZY5ofERG2DJ9Mu?=
 =?us-ascii?Q?pVVy2XGoqH8/pNs6zXFqDYwPuU2jYMuJ+ZCLZUJc8n+qjYe85TVa48+k7fKM?=
 =?us-ascii?Q?ursLWJyUzju23AXSTtBqFT6Q++kUn86A7PxsF71b6HK+oG9A4FrPXUeSkN9I?=
 =?us-ascii?Q?1OaZgaRUkz5DATo5aABVD6J6TiSqvkk6/0ik5TlWssXf9JYW82lM0fzCtByg?=
 =?us-ascii?Q?ScXsgp1ZnQHNE0y9wUcQEk+kaBwl7vUa/UQGWOEDsmF2o5zJxkf3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fee9a3b2-2fa4-4485-f61f-08df1533d7f4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:52.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UGuaAeVAeEdpJPwin/0GCd7ut5kCSJUzrES7v9fhLLaUGAOKLPI5NscBQ4UZgPouXaR6pOWshUNBqxPljIKZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

The Root Port's PME and link bandwidth notifications are latched in
PCIEINTSTS0 and routed to intreq_pcim_sub, the interrupt shared with the
integrated MSI receiver and the reset requests. Dispatch them to the
virtual Root Port IRQ from both interrupt paths: the DesignWare chained
handler through the pre-MSI callback, and the directly requested handler
used with an external MSI controller or pci=nomsi.

Enable the sources only while the interrupt is owned and the Root Port
IRQ is unmasked, and clear the latches in the ack together with the AER
ones. On an R-Car S4 with the GIC ITS as MSI parent, a Link Retrain now
reaches the bandwidth controller service, which clears LnkSta.LBMS.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 28 +++++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index c24ac82a1ec6..20f221cb7a40 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -63,6 +63,16 @@
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
@@ -417,7 +427,7 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
-	val &= ~(MSI_CTRL_INT | RP_AER_MASK);
+	val &= ~(MSI_CTRL_INT | RP_AER_MASK | RP_SUB_MASK);
 	/*
 	 * MSI delivery only depends on DBI being usable; teardown must not
 	 * stop it while devices are still being removed.
@@ -427,6 +437,8 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 		val |= MSI_CTRL_INT;
 	if (armed && rcar->rp_irq_enabled && rcar->aer_irq > 0)
 		val |= RP_AER_MASK;
+	if (armed && rcar->rp_irq_enabled && rcar->sub_irq > 0)
+		val |= RP_SUB_MASK;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 
 	val = readl(rcar->base + PCIERSTSTSEN);
@@ -526,7 +538,8 @@ static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
 		 * Drop any Root Port events triggered by link down; the
 		 * upcoming reset will reinitialize the controller anyway.
 		 */
-		writel(RP_AER_MASK, rcar->base + PCIEINTSTS0CLR);
+		writel(RP_AER_MASK | RP_SUB_MASK,
+		       rcar->base + PCIEINTSTS0CLR);
 	}
 
 	if (schedule)
@@ -585,6 +598,8 @@ static bool rcar_gen4_pcie_pre_msi_irq(struct dw_pcie_rp *pp)
 	if (rcar_gen4_pcie_dbi_unsafe(rcar))
 		return true;
 
+	rcar_gen4_pcie_rp_irq_dispatch(rcar, RP_SUB_MASK);
+
 	/* Check once more right before the DesignWare DBI access. */
 	rcar_gen4_pcie_handle_link_down(rcar);
 
@@ -595,7 +610,10 @@ static irqreturn_t rcar_gen4_pcie_sub_irq_handler(int irq, void *data)
 {
 	struct rcar_gen4_pcie *rcar = data;
 
-	return rcar_gen4_pcie_handle_link_down(rcar) ?
+	if (rcar_gen4_pcie_handle_link_down(rcar))
+		return IRQ_HANDLED;
+
+	return rcar_gen4_pcie_rp_irq_dispatch(rcar, RP_SUB_MASK) ?
 		IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -689,7 +707,7 @@ static void rcar_gen4_pcie_rp_irq_ack(struct irq_data *d)
 	 * Clear APP latches before the service clears Root Error Status so
 	 * we don't drop back-to-back notifications.
 	 */
-	writel(RP_AER_MASK, rcar->base + PCIEINTSTS0CLR);
+	writel(RP_AER_MASK | RP_SUB_MASK, rcar->base + PCIEINTSTS0CLR);
 }
 
 static const struct irq_chip rcar_gen4_pcie_rp_irq_chip = {
@@ -756,7 +774,7 @@ static int rcar_gen4_pcie_rp_irq_init(struct dw_pcie_rp *pp)
 		rcar->rp_irq_enabled = false;
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
-	writel(RP_AER_MASK, rcar->base + PCIEINTSTS0CLR);
+	writel(RP_AER_MASK | RP_SUB_MASK, rcar->base + PCIEINTSTS0CLR);
 
 	/*
 	 * Note: suspend/resume support must not tear down and recreate this
-- 
2.51.0


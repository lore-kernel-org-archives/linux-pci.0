Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021116.outbound.protection.outlook.com [40.107.74.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C414F5DEE;
	Mon, 28 Sep 2026 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614404; cv=fail; b=DTJk1SYQuAjCLRaaFtDSx0GXDC7gZh/CWPBrfgmvM+i9WvzNedLUn2ryd1wAcN1BvhjAIgJuQFI8M/thxZjJpfZTcgHc+mFkSWNoFD0qkshJ1u73mMUohvaUbb6J7svQc5g1vyxA+k8xC/i2HeXmDWpEt1xPeWJlcdgc22khzIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614404; c=relaxed/simple;
	bh=FBKH0Vz3UsVwtcot43mz3D789D/tp+Wuic8RxnuRvG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N3ybyJzYg2vt1DUSkaMmqmtEhASLs5o9CNg0rFDXw1Uftr419m75ZZ4wyPgmEFUSAGc1c7K4tTzy2TQ2fZTWg04GI4QKkjGCo+rdCOZfPp7t4Ivz/qTEiIrPTnOoUyZhJNZkxNx/3cK+CsgmStet/tCOwiHQKSEsjOGz5QpD7Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=P1koglxE; arc=fail smtp.client-ip=40.107.74.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="P1koglxE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjOSPqaktmpMG6lg7bS+bzWRlcH/1BeQKnUNo/2rsU9z0nC+iY/XlhvF6cDWRsAXy8s1aHUO/DNOOLZILP/KkOFlF+oMO5LOg7B7MYdOLrJUHF4kn/dkEpz7YOFKFf2s4oVih9Cyp3FoCje7kUUWZQKIn+qORjpf19JwM8DB1LrBmMswJMjRtNDOiE1SWVpXBFX8YXEDiPi3C9li5tn1lChpN5GWFNEQp/cADYK47TKp/3Qp7tYswZwdbtWLIYrEeNikRbzGjTVsdZSKnyyAWWWYBuWgybgIsvSQ3T4FCqmgByike/BL8bnaJPP3g6ob0nW6lTRgAPv1zg9pGlfsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uw21RYx/ks4ObDfD82j95NDCpwAZbXlcrO6gBwFXeXk=;
 b=zIcG9Y2XahyhrskHjG4kk30DAERoCT3yBdq8jfyQdX20tXJdylamjmg7ZOKZZI31zMof3ZINjlx0bQvcwE1ovAnM3xhFVOfhPChDnzoKvK4zV/4km7ifntwxidSxjB6oL2WT+LUhWjzKpfIb3355tagJ1iYtxfzrilBaGcae14etOrNMtuLvtiTSmUN1QtmMknu4qKorX5r58iM5XdgAZE3+31VLnVg6eWUxMk3gOnrDcAbc5PizPxc8Ei1Bl/T/aMLkPzxYTmIrTmIVqkfGv5s+JBFkf0Rc7p9XReGS7kdQ3T+cvVqO5AHUl97+yRkua6ISU8+8KvZVID0h5EbpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uw21RYx/ks4ObDfD82j95NDCpwAZbXlcrO6gBwFXeXk=;
 b=P1koglxEEuCtxzntYhgn2h1xdQ7tAL2vjEHRzicN8uArhZzc0jeHhIq91gWMhih1E0Xa/kEgBj/AkZ91QDYWjIg/zpbAoxyuXVVMbkzrrTO0c7cPSmeWAvGihNvOGLI1aWUKiL8dAX/t8IZ/oRJQv/lDdCglm8ZCRZIJxuKlS+k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:11 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:11 +0000
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
Subject: [PATCH v2 14/15] PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
Date: Tue, 29 Sep 2026 01:52:29 +0900
Message-ID: <20260928165230.3397664-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0053.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1cb1e9-1a20-48a1-73d5-08df1d80fb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qdsPi9KqUY0w9DeZT3Lx33YimRLAciTEWEc83eF0unkJSRSbf6lMV8Ffw2GZfFkkC8RGjMCQrtowLOUfobg2Xwc3fTfQPBozEqpmRSljHXQ4qI16lbpz2wf6AKSZp46WXflS+iGmxbg0j5VdTRQLxtS740ICq5eP+elZN/vwoycUAdxkcqP9LXw69kkbWELjv8WTXakE3fOFASxrCo8WtSNiRdANkOmMz9BrZk5zlY8Ft9m+/U0K+CyfbaeWF4WIJJPYKjN1j4ftY2v2w1C7RtzJQIE9F8Skv/rd1sZx4XvfDgO1M9Yp2yfeNSBiNjfnbX983JPya4DICl9YQsiwquSR4hXXyh1JI7Q/RI9BR604oohQgplQsES+96EFu+Y7GYwesMWRLmTkoCss7JWsjuQ/TCMZtut6pA36EStMYo3EMEpyazHcx9rewBD8XHqDQiGUDrKo6wc+uoMsDOubKSg6UDRGdwOMN8gjIRKlzNBMYERmCdx0RQNKRWB3yBuYLg5szeEDAGh5/5ty2QpEneoBdKtAJl1ACRs/vv9RfW/6DcCD1SIDr+BN5EkZowS1GdYmAeygmQjqwAVIeWUpOSu485spT26H5JdthmD5NK2hWZhXJFeFPqfb2RVdpezM44YrMYfyebbzEau0KM1SQDCWcgx66QcetevTdUgIx+pWOC94BHOgxGgETvEaIctdVdjm21vkggvGpVp6IFr2GQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?re+bddvLy3YpyG0RCumwcrLefiLq73AwpVwEp+eDMc6bBSWGCEbkMQk6DAdx?=
 =?us-ascii?Q?sjG1YH9TTA/4U/XeJc1WUU9NPVlQjAwsRhMzlOEgEfP294VQOrAnkWo2kcEZ?=
 =?us-ascii?Q?qROm2zJwXsevJxjk2aGimERAqo+G3KptzfZYRfIOj6VX+kCRmWZ16Sq0Vgvt?=
 =?us-ascii?Q?B1YEpNm2tmL9ywmRffoIUeA8kmguvA1ilfSgSxNyIZX/vZzYWC61Q1rturui?=
 =?us-ascii?Q?T85BelIk8rqY4UjtyjpZ2gBcnJAJ3SLvklxQi3LFsgMFW2S00JaEZzaPkQY0?=
 =?us-ascii?Q?67m7HskLsKZbt1hXaUZ/q74MOg7w2gyp4YyYAquK7gHCnV/EryoVk3iVm9/X?=
 =?us-ascii?Q?dZfAzIJxtF+EEh7orYZKUw3pYo7ud97Gl043V0qPNxSdeEur8NFFYVf+9w5p?=
 =?us-ascii?Q?Ys6/WiC5jXg2AGUdXrY0uNSogk7rE11TXWgnzhirv1pYtM4SPNbFEm4zlEuz?=
 =?us-ascii?Q?DSRfjarsc+crTGUbQ+GLpllwbuyPhniMGy/z9MmMzZRJYW4Vsfq7Z+lkoqoG?=
 =?us-ascii?Q?PN4c+m+U3E2UwSE7g9BeipFp3pnIHJhY/AmeHmmr5asIEJcK6yr8IBrdO9dU?=
 =?us-ascii?Q?mFzOrGTycfG5U//6sis+3AJp5MdZIo6Ny2Eane0mXIfTXkjSVwGMjdGG3/iN?=
 =?us-ascii?Q?G3QBYyxkIqqzTfpLZdAWpbILl8gxsxER+7Z/y2Ni0dR+Bejqqvt1crRc0tKv?=
 =?us-ascii?Q?w2uMuPmIzP4vFp3pr32B/E24fDiGdm/MCvFpLLkmUsPz3Pl/qmteM/CXFKIo?=
 =?us-ascii?Q?hzjKKsQBrgeE6XE3Ud75Y+M50ivvkv3N2EskQuZfoCQyufBNtcfsb5ans2u8?=
 =?us-ascii?Q?qef8Y13VeWvtweoOZ8LPM6PQ6hXDbCwO+Vub912jaWNLHNAzjp1heR/Itf32?=
 =?us-ascii?Q?SIA6FmzHjgaxLljVl+C9oDl2zBdEc6qMUaT0upFr9PXSs/QfL4Fcs5+HD2r7?=
 =?us-ascii?Q?dznJASM7BSwrVBFXL0w/ZGtU8h0GRAy8XN1r2mMeFzG8bsAW2AAFh/9jnbkm?=
 =?us-ascii?Q?FRZrjEkjLntfGQEg0NrCczMPqhd0LSg/2cqggz8vnU5CnqpbHbuXiTu01JC+?=
 =?us-ascii?Q?Uu8bWKl5+MB3K4xNpK0N/ppVHdEGQlAgan4iZQecqp87OgIGb2ZNz2M6ccQC?=
 =?us-ascii?Q?wtxsfunFQiQsn27gCLmZVe6L88PTVqko/6tdbUaj187DeTCYHDdsqSiansmV?=
 =?us-ascii?Q?93I0ACfKkMijh3w2R4iHqjdlOdXjYwC1PNJ0kwOp80Ao897aKct18t0REgSf?=
 =?us-ascii?Q?Td47iugcNRJ3FQOHvOHw1YF+svW1bzgKblwnBavJQo/Y1JoBI23Sw26ZEVo0?=
 =?us-ascii?Q?IEdETq5yKQ4pcY/v6khQQ59V1xkxpX9+2gjFHuey8wOBDE0+8nUWm1eE2EH6?=
 =?us-ascii?Q?+c8Dq+D9v/MbZnpumx/g+AQX6RQ/7cwdecQS7URJn23ttW/dnZGUAxS8ogW8?=
 =?us-ascii?Q?U5H8doMFONewENC6XWcf0Uf1jjJKSTDRlpGZYTOYq+2R02H1B+6J3PmaXFnh?=
 =?us-ascii?Q?6wXtzTGSwgIkDe0bSm+ULpRRopyfwlxI/JEztwIm2uBQhMNuilb1KoIQXmgO?=
 =?us-ascii?Q?vNe8frAG3TnUzw3VPu4rMsm6tn41LvR07hHATIcSqf4VD9KoEBQRN/lCn73P?=
 =?us-ascii?Q?AcN08wMKY14L8BbrCJW2bP6fRRjyVsWMxgi2T5niIMx13qfZ16C7w3fFJCbK?=
 =?us-ascii?Q?28MHKdmXBAqkORJVM4G+w7IO4kwobHYihBHlBL2mZWyjNkkZlL1WV+TRGevh?=
 =?us-ascii?Q?jl+2cYfrJZY2kLGOA56phULpRY1VyLnDLVwU4zX0xHQ2fVjsDX3O?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1cb1e9-1a20-48a1-73d5-08df1d80fb26
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:11.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlzQDGVTP2tgKBerOdy0fD/Qet5fvJ/XYZyW2effQljGwirdG8LgYUay9Z2OePkpJjHM8zQRn8TYAC07ypakIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

The Root Port's PME and link bandwidth notifications are reported in
PCIEINTSTS0 and routed to intreq_pcim_sub, the interrupt shared with the
integrated MSI receiver and the reset requests. Dispatch these
notifications to the virtual Root Port IRQ from the "msi" IRQ handler
after handling any pending iMSI-RX interrupts. This keeps Root Port
service handling out of the path between the reset-request check and
the iMSI-RX status reads. The existing dispatcher rechecks reset requests
under rp_irq_lock before invoking the port services.

Enable the sources only while the Root Port IRQ is unmasked, and clear
the MSI-form latches in irq_ack together with the AER one. On an R-Car
S4 with the GIC ITS as MSI parent, a notification from a link retrain
now reaches the bandwidth controller service, which clears LnkSta.LBMS.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Dispatch from the driver's "msi" IRQ handler instead of the
    pre_msi_irq callback and the separate handler used in v1. (Marek)
  - Clear only the MSI-form latches. The corresponding INTx bit
    positions are reserved in PCIEINTSTS0CLR.
  - Revise the commit message.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 29 +++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index c01f157a7198..319f917f9027 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -67,6 +67,16 @@
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
@@ -76,7 +86,8 @@
 
 /* PCIe Interrupt Status 0 Clear */
 #define PCIEINTSTS0CLR		0x0340
-#define RP_LATCHED_MASK		AER_RC_ERR_MSI
+#define RP_LATCHED_MASK		(AER_RC_ERR_MSI | BW_MGT_MSI | LINK_AUTO_BW_MSI | \
+				 PME_MSI)
 
 /* Port Logic Registers 89 */
 #define PRTLGC89		0x0b70
@@ -137,7 +148,7 @@ struct rcar_gen4_pcie {
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
-	/* intreq_pcim_sub ("msi"): iMSI-RX and other controller notifications */
+	/* intreq_pcim_sub ("msi"): iMSI-RX, reset requests, Root Port PME/bandwidth */
 	int msi_irq;
 	struct work_struct link_down_work;
 	/* Allow Root Port event handling after enumeration and until teardown. */
@@ -597,7 +608,7 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
-	val &= ~(MSI_CTRL_INT | RP_AER_MASK);
+	val &= ~(MSI_CTRL_INT | RP_AER_MASK | RP_SUB_MASK);
 	/*
 	 * Note that rcar->rp_events_armed is not checked here because device
 	 * removal may still need iMSI-RX interrupts after Root Port events have
@@ -607,6 +618,8 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 		val |= MSI_CTRL_INT;
 	if (rp_events && rcar->rp_irq_enabled && rcar->aer_irq > 0)
 		val |= RP_AER_MASK;
+	if (rp_events && rcar->rp_irq_enabled)
+		val |= RP_SUB_MASK;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 
 	val = readl(rcar->base + PCIERSTSTSEN);
@@ -753,12 +766,12 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
 
 	status = readl(rcar->base + PCIEINTSTS0) &
 		 readl(rcar->base + PCIEINTSTS0EN);
-	if (!(status & MSI_CTRL_INT))
-		return IRQ_NONE;
+	if (status & MSI_CTRL_INT)
+		dw_handle_msi_irq(&rcar->dw.pp);
+	if (status & RP_SUB_MASK)
+		rcar_gen4_pcie_rp_irq_dispatch(rcar);
 
-	dw_handle_msi_irq(&rcar->dw.pp);
-
-	return IRQ_HANDLED;
+	return status & (MSI_CTRL_INT | RP_SUB_MASK) ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int rcar_gen4_pcie_msi_irq_init(struct rcar_gen4_pcie *rcar)
-- 
2.51.0


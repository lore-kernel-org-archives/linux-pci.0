Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758B03BCD2C;
	Tue,  6 Oct 2026 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276427; cv=fail; b=Bw4MA4zxuyPlV5kJoTjtqgcNpFzPr5fQzFsjcXQ1mlA6TMNY+710mPKMdY1fo8JVkfj8aTN28fhgI+YWCtsWVkWTsNpcyiBb67uU8c145J9zWZIex1ozknfXRsfDJm+5XlIBnmb6np2Peyr9vWmXAgYZnsftWFXbAdPODOScPkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276427; c=relaxed/simple;
	bh=SW4W7flAt9jnrsVaaGm6cdoyLNi6XrOlFd5IbxrRqHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qTTm4aYeDQjP+iE0q4xY9ve9XW6JeiGhIKPAv44qoBVhRydYsqIKe2HWXCUs/9u6sCv9PyQInDhKY8WLq9WrJiNulfFh35si2vYGIKoveJFnTxF+9xPF8g+JTgUqXsFIjQSPswdygV2sEklhvBOhaETzwO1nQDCZerd8D4AJRN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XukP4BzF; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XukP4BzF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0jloQ6J7R0vPeEb7M/Wc8eYPWTfbRMCF8H3Pa6/LypUooZfeCncKBrs4K/3QoGAnMEJcw8uAl0EraYMuBtMGMR5UMjyFzx3moDpq1rf1tXDcEhJhoZUnlkx+hRnEBpLGY9JLPX5+5Hpz8F8J+/AgG/iQkswMG5cQD0zVVF9KmcvIpQez64GHEaZnnDb5gc39F7Yx5lwXKRUP+XXCsPhpiEyW9AddTpicqS+jZxIKszlrSK34ZoBZbLl7tTUCyQxLtUxcit6OqE32SUyUmO8v8slnJHQPKEGCwz0bf3LLQMnVnKnfl0UB1heyuSxsJM8NyPbWkos5AmfqnCjEp+1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXPXsNfD82crZC6nM4vsHqxrrg/k2fw3gXXFfl+V0Ws=;
 b=wFepThrpILf/h4Vc4s5niRIJ+zuC364MIEc6IVdJyQz2zZHZ3rLVsYBj/ABwL9anrOqC3V080dzUV+ZRAu555r5gyGgRCuEyPbEpqUdLE2VRDlj+AiqvQTm3L3n9StDWPnv/+zRll+omadw7zRJPRi48NUkE1W2wP6YZZFTrdYt1tiZ8YCJrDc4ykGGveEylm1MTJi8U2rSQfjnbnp9kuwMBY/P4fhyJKCgjLFrSmC0nLygFHLN009id9hIm6pHkN+QT8peKC5mD0R5ZQog6H/oABbmo/0mPTsC3bMVyoxip8JZ9/pBoHeWbsp0SvjfS68ux7Re0TlUoUw/KCf0zzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXPXsNfD82crZC6nM4vsHqxrrg/k2fw3gXXFfl+V0Ws=;
 b=XukP4BzF71kmGQQ7AiBvjv/nPbSMIB00/wjfBMNbzTuKoXh1M4Qb61dhN2m4uOg4wTGcZq+aZIdCpGbLJqKNaUbio/sf47M9Y2Ckkj/FTGmJEO6kkMr/EyMg7XEGYbCDaROFnPha4oyTvMNekCIIeZd/HIpNHXC/aIs0St3+mn8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:56 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:56 +0000
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
Subject: [PATCH v3 11/18] PCI: rcar-gen4: Take over the iMSI-RX interrupt
Date: Tue,  6 Oct 2026 17:46:31 +0900
Message-ID: <20261006084638.3821710-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0007.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f942079-dbe4-456e-0f76-08df23866076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|5023799004|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X4QGOO7eMQJ/7wj1WX5E0adkxl1ugZuClAmJSo++cdF50GrQF3+Gf1zqr1/u1kGAUm/Cx5OwkZF/FcQiGXrPqlAAWwhCWhtFLK45fe4rGXkYBNAo5qs7/y4Zp3hZ5jhnwP/rejn8qC8Ot6QFwwYgkEirpn1IGD2M2PGcNWUkO5Ip4/C2+kLP9mq9RoDiXuuk4ykrdXPtxICERwyQvI3Jm5VEvGxG7F/0wZd+sYlclVaY/0hpJz9GtADHAB5LXJRdHmlEn6Z2OSg/boeHcBlNPUTdhHtW3WwP5p3o0RPovZRs2Z6rW3R+tREedFZOhOFDgGlhYx+DcUVWPI+K/gZ27YHxi/nU8Ji38l/LYSmeAgm4s5mBCAd+rPyv+uQcebN7enNwYLwSVUYT5q21eZsRpXuxtP/uX+7L5sGPAb643ktwFJbCnzxxIYGKh5e1YFGmlvs08GomunuNVqgDIy4lKEL6moSV8c9MyXeGgF0YvJnKpgJ+rREIloNhJl/KxBwQFSiL7cn0KcgaCd2CHUCoMCoJ61HMHlsfka25UqDFE1s2GVRYuxvK3mlRys8tV2w+E+92dScH2uIJ13I+mhdU3oTqaX3qQtheRJto509G9u4jRHq9EaTqvzVs3gcusZB4IQ1Rnp4yBAQ+yMK8QnN417Pw3fCqSqxAiHTlH/d2DBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(5023799004)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yaYS4A8weN1Dlk73baqAQsHAyFCSv2T2+7yzbzfRt3xoAXxy1jGvu8E/Vv14?=
 =?us-ascii?Q?xNP9mVXm7kLv8XVQC8AShsLWcRq9DzYdIuuxKtUpEs/fNSOSlHKO9YgLgJKM?=
 =?us-ascii?Q?cugxtrZYLNDEayPgvbkww55jvd5pIGZpOvtRqUGkPNT6enYmWt4ptahx5ttz?=
 =?us-ascii?Q?3iQ5IF5yIq3A1E3V/rwo1/SnpgXJhjXJ3G+BNGKCmjZkN/Mh0CNU1fAGqC9H?=
 =?us-ascii?Q?B0hYbmc9tFy4SHR/UCbMRj3lq2YbtkkF5h7SbXjjyzFOfMNMtMSX1Tnn/OjP?=
 =?us-ascii?Q?rj8YhausQENRPJl1dIwGdDEe5uHKPjvdfTCHKBRCY7w2Tz8+utYSny1xa8nI?=
 =?us-ascii?Q?nntt/MIkISWeSyG28wk88Y0JJ6W1bKdY7fm3yePesLILvqRTYqHJ8BAgJNPB?=
 =?us-ascii?Q?E5m3BiwcTHLvBwn+N6vOjSb3sAwkdTLqrTDK+f4rLSPoyw3N6xPDmLG7fHRS?=
 =?us-ascii?Q?MK8JCGyQFmZ9cYVs0f4tvKdvtoowZAwWzPPTxcuACkwG8rwi8NLh0FZj6Waz?=
 =?us-ascii?Q?/oe14a8f9PeEk/4wiZq99KV5Ea7JjsQELSEMYgGPz/BMiy4eEYOmPU41x9ZX?=
 =?us-ascii?Q?RhX3hJ3lx3/0NOmxIJcpVHBUZ1gTrCb6fTUR/AuDs4NvvDrxUozZL3XaRHtc?=
 =?us-ascii?Q?LmcwhlD7As4NRkUG0x0bherOXMdhR3QfgeRdASu5M/QWwvERriI7RXQ9bhgt?=
 =?us-ascii?Q?hpKyc37CGwJaeHiakmBbElHxEqRbGGyhrastG9FXfHFth46Dl2pzVc3Djcac?=
 =?us-ascii?Q?lmoXwwGdCDh7pC2uphcE/Txil2yy6K+ZA4yImW2jNFmRuA8BTgELj09boUV1?=
 =?us-ascii?Q?rtGimbOVTs1kH1AVU+bqZx8/Wx40BK5T+Tm1SWoBEVpF+UuJY3mGifOib+TM?=
 =?us-ascii?Q?9M+SyIYdMlefM1p4EdbbU1noPj2PcKAecGvEIQRtoWrkkmtpVJqSY/ywxbsW?=
 =?us-ascii?Q?WlJ65z99fFR0GX30ROjzWK4krRO77lTmpyudSzHc0xhyENNN8BcDwx71qLNn?=
 =?us-ascii?Q?Hte1VLz18ketciWUE48cAG3yltdc8A2BIwFQRv131iEZkNAHg2A08Id48W2x?=
 =?us-ascii?Q?PmU7tR15P7/RdYOELftHuwb0yhOewv2LDwycsi7lnpu8ajSPVYqmAQbZy2yE?=
 =?us-ascii?Q?Cm9w73SX1flCNS/a2P+2vMX15WNBP9+UU8huuK01fiEiwoCPAXFe1aiA96dR?=
 =?us-ascii?Q?4tAngut8qPnGqlgM1+R9n5YayM2ZwwnORY0O1/hvxg0ec+h04tnjAtT5w89T?=
 =?us-ascii?Q?C9yD71fwW3sTi9FDJS3KH3y2bIu6cdf3J/Mvjaf8PDJ/rgnCRXPQwj+EnTij?=
 =?us-ascii?Q?VEjRWNcPY10/NvIB80NF7Ctiyh3JzrCIp0TKzyypjBz2Sx2h/Gkcq8T6tyKg?=
 =?us-ascii?Q?7EE6jvOj04KFO1+Ae27mBiEHOZb7psjHpA0yZ19P3C16uiztZ+a/AOnUP8+8?=
 =?us-ascii?Q?4N5mDTH61yV6+5gCykxQmz8MDwgLYLhHj3VSJ1hB3TQB1e+on9ppVlA+5zTb?=
 =?us-ascii?Q?/VQZz23Pt32EkwJdDukAB4HTe4ZZiTFzDsqsW0Y6HBASRmiUYmMIIKfOAyrn?=
 =?us-ascii?Q?frHtx6Alz0dtUUVe4lgZi8ldnQWRNP3gfb/cg0VA1ewcmuABZp6T+84gkvSA?=
 =?us-ascii?Q?0/Adp9JHfpY6wpKkHopbpstNyQPEU+igR5oBYlcVLhzTBKMEJpx3o59WH7vG?=
 =?us-ascii?Q?/PcL5uJhg3Y5UZXJTFAQucPpGqNAwx4I+mvEqDWIz34/PjpdD2nDv7JIefCU?=
 =?us-ascii?Q?KBFgS/ERBEIg6UQ0SZbr9ZvQHVyagG+USiTDOfGXNohoAXlIaK3Q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f942079-dbe4-456e-0f76-08df23866076
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:56.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TusSVtpPLbus0xXbzhxcg+Mj6OwUOliNLOguIroupggArCoFUNpfXuk1u2wJLXW/InZdVxZHzI0iWHOp71h4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

On R-Car Gen4 SoCs, intreq_pcim_sub ("msi") carries more than the
integrated MSI receiver: the controller's reset requests and the Root
Port's PME and bandwidth notifications are signalled on the same line,
and the following patches need to handle them. With the DesignWare core
owning the line through its chained handler, the driver would have to
hook into that handler when iMSI-RX is used and request the line itself
otherwise.

Instead, request the interrupt in the driver in all configurations and
set pp->msi_irq[0] to -ENODEV so the core does not install its chained
handler, as spear13xx, keembay and dra7xx do. The handler demultiplexes
the MSIs through dw_handle_msi_irq() when the APP block reports
msi_ctrl_int, in hard IRQ context like the chained handler did. With an
external MSI controller or pci=nomsi the iMSI-RX is not set up, so keep
msi_ctrl_int masked, and the handler has nothing to do there yet.

Request the interrupt in probe with IRQF_NO_AUTOEN and enable it at the
end of .init(), before endpoint drivers can use MSIs from their probe.
Disable it in .deinit(), before the controller is powered down, and
around a Root Port reset, as the handler reads the controller registers.
Suspend and resume go through the same two callbacks.

The DT routes downstream INTx to the same line, but the driver has never
supported INTx (no INTx domain, INTx enables never set), so requesting
the line exclusively takes nothing away.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Request the IRQ in probe with IRQF_NO_AUTOEN, so a failure does not
    toggle PERST#, and enable it in .init().
  - Keep the IRQ registered across suspend/resume, disabling it in
    .deinit() and re-enabling it in .init(). This fixes the unbalanced
    enable Geert reported when combining v2 with the PM ops patch:
    https://lore.kernel.org/CAMuHMdXoKFCroL1d6-fLwYR0UkLBL7suKy=rOFavioLd7rC4OA@mail.gmail.com/
  - Stop the handler in .deinit() while the DWC MSI domain is still
    alive, which the previous patch makes possible. This closes the
    known gap noted in v2.
  - Request the IRQ with devm. The handler is stopped in .deinit(), so
    releasing the IRQ at driver detach is no longer too late.
  - Revise the commit message.

v2: https://lore.kernel.org/r/20260928165230.3397664-11-den@valinux.co.jp/

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 79 ++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 54260e62293b..d51c0fc5ff36 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -115,6 +115,8 @@ struct rcar_gen4_pcie {
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
+	/* intreq_pcim_sub ("msi"): iMSI-RX and other controller notifications */
+	int msi_irq;
 	/*
 	 * The controller needs reinitializing; the APP interrupt sources
 	 * stay masked until a reset succeeds.
@@ -540,13 +542,14 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 
 static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 {
+	struct dw_pcie_rp *pp = &rcar->dw.pp;
 	u32 val;
 
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
 	val &= ~MSI_CTRL_INT;
-	if (!rcar->reinit_pending && pci_msi_enabled())
+	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
 		val |= MSI_CTRL_INT;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 }
@@ -613,6 +616,54 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
+/*
+ * intreq_pcim_sub carries the iMSI-RX interrupt along with other controller
+ * notifications, so the driver owns it instead of the DesignWare core (see
+ * pp->msi_irq[0]) and demultiplexes the MSIs itself.
+ */
+static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
+{
+	struct rcar_gen4_pcie *rcar = data;
+	u32 status;
+
+	status = readl(rcar->base + PCIEINTSTS0) &
+		 readl(rcar->base + PCIEINTSTS0EN);
+	if (!(status & MSI_CTRL_INT))
+		return IRQ_NONE;
+
+	dw_handle_msi_irq(&rcar->dw.pp);
+
+	return IRQ_HANDLED;
+}
+
+static int rcar_gen4_pcie_msi_irq_init(struct rcar_gen4_pcie *rcar)
+{
+	struct device *dev = rcar->dw.dev;
+	int irq, ret;
+
+	irq = platform_get_irq_byname(rcar->pdev, "msi");
+	if (irq < 0)
+		return irq;
+
+	/*
+	 * Child IRQ flow handlers require local IRQs to be disabled. Keep this
+	 * handler in hard IRQ context on PREEMPT_RT.
+	 *
+	 * Keep the IRQ registered for the lifetime of the driver. .init()
+	 * enables it once the controller is set up, and .deinit() disables it
+	 * before the controller is powered down.
+	 */
+	ret = devm_request_irq(dev, irq, rcar_gen4_pcie_msi_irq_handler,
+			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, dev_name(dev),
+			       rcar);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request \"msi\" IRQ\n");
+
+	rcar->msi_irq = irq;
+
+	return 0;
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -710,6 +761,9 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
 		rcar->reinit_pending = true;
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
+
+	/* The MSI status lives in DBI; keep the handler away during the reset. */
+	disable_irq(rcar->msi_irq);
 }
 
 static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
@@ -719,6 +773,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
 		rcar->reinit_pending = !recovered;
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
+
+	enable_irq(rcar->msi_irq);
 }
 
 /*
@@ -796,6 +852,13 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err;
 
+	/*
+	 * Undo IRQF_NO_AUTOEN at probe, or the disable in .deinit() on resume.
+	 * The iMSI-RX interrupts stay disabled until dw_pcie_setup_rc(), so the
+	 * handler cannot run before the MSI domain exists.
+	 */
+	rcar_gen4_pcie_resume_irqs(rcar, true);
+
 	return 0;
 
 err:
@@ -808,6 +871,9 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
+	/* Stop the handler before asserting reset and disabling the clocks. */
+	rcar_gen4_pcie_quiesce_irqs(rcar);
+
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 	rcar->drvdata->deinit(rcar);
 }
@@ -820,15 +886,26 @@ static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
 static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie_rp *pp = &rcar->dw.pp;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_HOST))
 		return -ENODEV;
 
 	raw_spin_lock_init(&rcar->app_lock);
 
+	ret = rcar_gen4_pcie_msi_irq_init(rcar);
+	if (ret)
+		return ret;
+
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
 	pp->use_atu_msg = true;
+	/*
+	 * intreq_pcim_sub ("msi") is shared with other controller
+	 * notifications: the driver requests it itself and demultiplexes the
+	 * iMSI-RX MSIs from its own handler.
+	 */
+	pp->msi_irq[0] = -ENODEV;
 	pp->ops = &rcar_gen4_pcie_host_ops;
 
 	return dw_pcie_host_init(pp);
-- 
2.51.0


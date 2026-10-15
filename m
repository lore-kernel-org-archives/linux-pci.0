Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC23ACF14;
	Thu, 15 Oct 2026 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035095; cv=fail; b=BA+g8jStbYnox7gSHOgVbBWIzHbs4VCTC8sPZM4hsHDKhMHIe5dJtlcjvzjv9FSIUDNsXvhdEScPgJqNNt9ofANFsoxlt5AHhDBoUL0Vbdh2FVtW8dbQWzyffTKVAdWQLYk0QJXMwl9YSpHIULaQ4ahVNiv+YzB8hkKzaQzOlgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035095; c=relaxed/simple;
	bh=wgG+HbAGWz+LjJlG7A/qH07tGcth1IGzXXjIQQ3jymE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THWPckVQT5bZJDkPdbfDvyq9ekdzvSYCu9CnPjrjjAQ7+d6bxeDZisx0+HpZd7o7kMbX3zPHEmoQ4LnwPQmcZqV+n4CW+8j7RhR/iY4mITGDPHAIT7nhOfht3/vuNMGBZJgzwL+Utit/InGKAu2MZB6jOLgzzX7GS6sp1T0YH7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RvGQ7V6H; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RvGQ7V6H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDCydt6KrzMZ4l5ufaRYL69HiiaA/fCkfr96y+6vzE4YqJlXOBK2moDbfH3f9XzqhFdx1gA1l4cVp+ZnQD0x58b8i+HXt5aZbzXfuZmTWd63IKFgpDqQW2s9+NGmXIJE2yWclM3+Auw0kBQlW5BIorVUGl5HtZCiizrE5c/MEstY61HUFfcwz21s85NQk9h+rqg0/pazE1dbpTA2AJP5565wnfg7ZHq2HifRlM7BFleaffOQFQHDxA4t1sAxW1cndnWNql+fDH3Ot+wOLUc7iDZF1NVniUQhT03h0iDt26sY1q8YCvP1zGC2DI8qDYHNpU6CC4y66e71cCh/N5EofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhTeofZFj0Qp6q2APTwVIKwiH/d29bGpU2xQwkrHuw0=;
 b=Uj/+7UbHheTGEV+vkxWJGDra9aHL639Zb2pAEW0c2TTquKL6JSpqSiwLVKfwHbzg7WSvhbfYw+IdzBlXXWecSm1JmkINu+t7ldJ5B+C2KjBTqcv3Q2wELvRFYH43n1BDncjBQ4uITD2M1co+bszIluuKANsXbOm7qY0tmbqMr8rDCovBgltqNI1sXMJw+h0TUiJLXlmaSah+XW6x6fzhhAMFKshSch8kpCykh4rVNw+8lfceqVQY5Oq7tTF+thpetFRy55bJDr3n7mTbngdFCKhbyfAmANQl1cu6uQp9/MvBm3JnvI2uGU9AtoMLRMU/LQ2Ac0Dt9D7N5LVOuHLQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhTeofZFj0Qp6q2APTwVIKwiH/d29bGpU2xQwkrHuw0=;
 b=RvGQ7V6HrQsOL+kulQlzZBL/ix2c4dPSuMrD4PsJTYQY1XPc22ieIsRDYC6t6WHHII/iPLLD97RUEj9ktDOgcLJbpcX/7OkPAYxCGCgSANC0JSbG+NQARfaK6jmnnY9Yp6HciZ/hx02+CC1Wa20JxpPuUJkuoGBJIC7HmR7Tcpw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:19 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:19 +0000
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
Subject: [PATCH v4 11/18] PCI: rcar-gen4: Take over the iMSI-RX interrupt
Date: Thu, 15 Oct 2026 12:30:56 +0900
Message-ID: <20261015033103.3076869-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: ab51d010-f40a-48d8-9bb1-08df2a6cc700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|6133799003|10067099003|22082099003|18002099003|921020|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cjrJ4iuX0mPgyXeEHN4Bry9zpRah0tDVGbmRz1s7AZmKNmSLzzq4MqCesbayO3OwKzXbWhdYrMpW8WOOwMgICEdIHtsLuWnwY9AX8u/7QPTnYLpCOm/EFK7APYxm4OGJIHS/28QWXaF2tEP2g6YF5sLnxzJVadu8Nx5brVDkLzHpYolJUUE+HNQOYrISwr4wrzwX0nkqtgEheVm60labba3qCYg+YfJ8LMaXJI3v8HVErlH/fd9q/6kXkMvDIb0dcskvRKIZy7FOM4JYHMVvAlOyShszNw2PbTN72eXhAhZuL4y64rKVnDDCDJ4tBWDuWTCbid5CFFX9cNOvBQcFiFQ+OmOUHlnrJyd5mTMoh8e/xDu6gMvoRgwLui4IhrQjiNBwR0hYO/04RdCVDIEQLGSxvwuHEeqcI1HzZhhblY424yRkEsLROg1njuR/94oMdVREYRa3nrHLXdC0x+SMAOADJM891x0gajKxkLvMKPOg3KznroJMnQqsRMvQ9I/xWjVwCKVxe+2pqlO/vvH1RHEq5iC+RYqF1jQj/mlvBUViU+KAHQdWBHaoOZ84cQ5gNhseAGe7LRY5eURGONYv+KJRzph//MfIH5HnzoldguDKN3pFDKc69t2cl8MWSjnEleA64m3XXdMzAGWPk7yUOgHJsSBgoeLjDxHDqnHFNN4uaJ3wjHL99VnNefyXpPwcP8Ts2xjtR/PNnYQwE5/a1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWupyTaWOIkUoZbDCGCuO0gBQzFWdc+Vg6UbVIlo/fWh7r8Mcu3Fx6zMbL5g?=
 =?us-ascii?Q?HYyhW4DjQQkrOkkIFnMKj5jNwUaGTIWi/5jrvoY/8wBKB598nG+u3dKTEZ0V?=
 =?us-ascii?Q?QV7mQGKnau1ncjBC4Fc3JV4yBeK33F84GQ8jv4S5SbnehWxlnYmbcsCA9Vnt?=
 =?us-ascii?Q?TYLqEbHB4qCb1hRR/uMBkQnsA0qhS57DWeLLJ4HytEUR6FoyjED0LcaQ/fPk?=
 =?us-ascii?Q?hyEy66zXD+isyMsL8gjjkBeJPn0knVqVVfrm/xVLf31BuFMrFnTCG/yR+Uwl?=
 =?us-ascii?Q?eGD2Y67XH47pIuMmzqkR5215kUOkI2K4bwDut8FerbbKfxUNr8+8YK1jqLys?=
 =?us-ascii?Q?VgsWnNQFw1K/rz2YsVPlXeZLOWaFordVmj19zGsOmYHOzsXJWfgIff5viwSP?=
 =?us-ascii?Q?Y01AFGs/8qAu7mQPxU75Mjr3C5j+BoAArepY3MN3sSuLEag4LiEkCTJQFYwb?=
 =?us-ascii?Q?Gu98qqcE/OLrpPwNaA94CSf3oH1EVqWBwjN6S0Z1zVt6nGFFwS51ag6gKhzM?=
 =?us-ascii?Q?LVTUeCxX7juknIn6EONg4ohsYQo/oBZNXuWKdteZoOY99GpzEWyRvpAQtP1U?=
 =?us-ascii?Q?U0flKKV4FRux1xWZFZ4WFmqD5y5LaZ69QNCtLBAN4KlF33WEXU3LYzDMUa3z?=
 =?us-ascii?Q?IGKSJvDGZSvcQJd3+797dspaNZnK5VDzLYMRMPdwDO5CalwD2Js0neU26aQD?=
 =?us-ascii?Q?3a8S+9DiTcxf/VNV+Y+A69Bg9qxlaIdProjWDGi83lkHVJHQ3UbXbuaunheJ?=
 =?us-ascii?Q?o7wOXpbGLAquNkw+2pDVlFWpRHlHzggvJ0lRCGIko+0QoXYCYcCGO1Ay3C8H?=
 =?us-ascii?Q?G7rfOmE6cPJc8RJ10g1MgNDWPw+wY91tJ93PGirqy0bcPc26qcIZbkU1N9GR?=
 =?us-ascii?Q?63CYwXmnWdsxeDtIg/yiZ9xXIAoNdOFfXJA8cX6HWI2XPCZe79aSckBYJ6RW?=
 =?us-ascii?Q?q2LjFwWWuBpRbNRVDc1VsSK/PhlI3UuRpJ58noJ4pGp3BPKNb0jTPz5QzCNY?=
 =?us-ascii?Q?ldNiyFNVs9IoqC7TolQbmN3oiCaNyw85H43SpA20OyQ7SpG8wScB1ApHiitk?=
 =?us-ascii?Q?v+ZqOU9HnLlnZZTxgBUfylDyj/qrmfAo8KpqYZ66buZo/jhOmw7lf2Zg/7+2?=
 =?us-ascii?Q?Et49lwlzZnIaYRkbLQuH37wFjGv8VD0BkELIG7GCKS60kDIEulGfqT5XBXD2?=
 =?us-ascii?Q?juOj55Et24fq0i2C3i3kDbRwk4+skgJQ1uMl69IRN9N5nQ4VTlu4d2gQZqiv?=
 =?us-ascii?Q?PG9Sx48t4gHWZTQ0EziZlSCXpCMj8TjhobFqeuN+mPCJnKrr/wvbYcr2UkDx?=
 =?us-ascii?Q?29MM/MTwtYy4iwCB5vZ7t39u/ZzMoz6OrxvhBYgwLCLofFGHFswdnriCycjq?=
 =?us-ascii?Q?eYfuoTzr+eOMHpoHRZqzqBxfzNlqE7+EkS/iwXxkxLXnWoyfUe6ifQ9oStJ2?=
 =?us-ascii?Q?0ZUs7MAnI+OydmCHesDE4hUGY1CGgBFurDq37WPC132uJ9JQoEYZ82onrExp?=
 =?us-ascii?Q?t5IIs+0Q2I3kFramOcUdDTjo5Bxb+NrspManA/ZMTxtmPdJEKYNGnVpJ76M/?=
 =?us-ascii?Q?ebdrShH8EYSAoToYGHjPbFlWyNCxaBbU9qmurqpSTsTD7+xpz+xKE9Z6UKOg?=
 =?us-ascii?Q?Bb5I56r2qP8LNuSjfKLs3wYI2TrkdXDgPOFa+GMZdQefOsGDypsCPrSn0skg?=
 =?us-ascii?Q?T7EmROW8ZAco+jHzf6lK7GCWidt11wi0P8tplbPihGiStN0HZ+KEk1YZ1/Tb?=
 =?us-ascii?Q?kNhe5QHbcj4xvk0NW+IbLxLWA5/3hMY7rHXgdqb/r3nwq7EmPCR+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ab51d010-f40a-48d8-9bb1-08df2a6cc700
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:19.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFEZCOp8VVHcLVaH1GL0YILfxE7o7lEsmA+u69mvh5ZqkT8wmNzMHZqw29wSNq+dbGpOudIUyDVwZMbMHa9zFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

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
Changes since v3:
  - No changes.

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
2.54.0


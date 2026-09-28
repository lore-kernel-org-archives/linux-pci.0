Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021116.outbound.protection.outlook.com [40.107.74.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9E64F4730;
	Mon, 28 Sep 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614400; cv=fail; b=KCjbjToMG/Ojm7+rqj+8VCC+asNgwPGxkP5R8lPa/AmyMWopEVVZQFgBsfqVRsQLUTnQM/2q2LcXqv5pNmcVk82BkNFxU5w9P+vronqbPwgxgQNv/ciDW84pONtFn2YhCaBfQ09jPnUb4+JfkNlxz3hHryP8g0uXnsa09Ym2A/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614400; c=relaxed/simple;
	bh=5/mt+7G4/l/I3qh4hH1QWud7bp/7/1ADdodJMgTQM9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GN8TYm/zY43zRBkskPPdwLiXPXVviSyNl/wZmZWrtintJTCK/+rjP1gAtcsAgr2y87ABXnjutDScKEOKiVh5AdQ13McLcMoOyr+2e6rkkkaCPyBQqh9tNzQ9b4eFqGM79IYt59DNI3q1INVV3u5/Z02U7gbPprA+yG7GCw2xn94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oZzYsun3; arc=fail smtp.client-ip=40.107.74.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oZzYsun3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skR0PlS16R9X7+pFCxNkcQKLP08r1FtfodCxFE9x2vDv0dMWPWdftH4ISOP2v+ABvEMgZnrH8v112VXNn7WeE3DrkAsCx8MvC44+qcCgy4YD/4nbgWp1AvYNPlqSSUz49LK2ZtOhSK1cJre3HVjgcURBd0GhKG0VheSAs7IkdXg5oTFeHcdxMRlRt+tpMnNvkup3W+WdsFAhaLcYfhWCloZ6BPsLRM4iEUDWXfbaCS101Hg1+OwPvClbCbjcGazrIc8CiUzBRj0B2yb/59B0KJqZxighXYRs1oaABn2gSWPBNTOLG4u/iwgpQyxGKbBe75GRjyQSzFTRFxO892kTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnUKxm2Cg7hFOy4A5KYdukwPPqXGQn02HtmhNbZB5Ek=;
 b=H7QUL1UdvIsp5k0Hvya9ZmOKiRuF1UpoaiSEoK8g4NXEEbD1ntyuKHqTIS89aIG0Gr4iTV3mQ4TCex3c0SaQ7/1033oitJM7pJYvBIAvWuLXe0ALn8PyzsknyZM/zlKBsFhHpPe18B/BC9JUJEGRV/P0qlCBNZXWHvjljDNLIYFj2j9Ql/fO6dZGpfe+1RTZ8vnGTlLQ6OWYQG6nwzvpPUXfUZ6eM8JYELX0MvStVJ3ErgtF+8psETfFRk6XjB174d1Ja1ql5xN412W2CE1SFJi7OKJxmJI0GjNBGr1FsSI9PZ2yfGGBNii/3HE2jlwc7KdANv8zDuyYEjm/9pwBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnUKxm2Cg7hFOy4A5KYdukwPPqXGQn02HtmhNbZB5Ek=;
 b=oZzYsun3QfNGe9UHJsGUNg87phcGvRUAdIQQHuoQ1rnxC7eK2ufPw8GAwZdRdb8+b4U8gXYmjzFaSO1rMZOef2qbD7VbXv33wIQ6B+l8Quqbi7sfw4II7cfPqgOrlqniY0en3Wf+TYoPjAWRTCP+R6rTOL387/y+KKKDtLstsdA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:08 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:08 +0000
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
Subject: [PATCH v2 10/15] PCI: rcar-gen4: Take over the iMSI-RX interrupt
Date: Tue, 29 Sep 2026 01:52:25 +0900
Message-ID: <20260928165230.3397664-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 333ca749-38c9-4ffe-1b8e-08df1d80f933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|5023799004|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tLptv9ADdDbb1LDq6NnQRAqOxyzNAwM1keQpxyLXITGCBExfjmESi5fun1BMzaVWeuwFPP6qtHkVfgtZZ/B6yF7IrPi5SE/FUn4EUY1rVgJ6K7VgS/Klb/KlIvflvQq8Kr/GPKynQ7+H3yUxOkH/vOSnMLAVtz1xKTZ45kKh9cqTEU5DSZBUhjUfpG/ZX10Mysj9cAXUbP7nYMKLJqjR2KM1STx50jEzVRbzK3PuhTIJfeZLLJ1bw9wYtdTNsrGE2jpnwFMLX7J4pOgmjfP1MUzq4IeoVUse9sTWoL5tkivJTWYL+vQrgut60KthFh/LOw1bSRE2cCheT49XQ+srDcSSZDaZYcopzKdlejXKUDoWG2F3ylSUX0/rnmn+hy8O6AiuDg6QdZRNTOnbz0G8to44aRtRRAtP2ZboW0Bb05i1gGJToGIymd35HA6bGlkv/EJz44Yhyyqliwx10I9k7sCM4R6ZcK2PfYbx7+GTxMF6ul0AflMNWlf1YHwcW5VXbJYL18fvrCOl8H6Zr68Nq019Krbg3xVp4Yu8ktDmgQjipLjq7mNQTmTu6EC4XimUGu06iZVkpwt/gccOh/MUAvdmZfg+6Um8Kw9rmiYLf4c30JMQuvhwj4ifojIJzQNt2kSKwGFF7PwCuoWh5vb5w8AOHXzMOYroX4uMjnzY426cjGumPLbZeUySQ97oQX4jue3EOkjXOBwMmyhUwBzh6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(5023799004)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gbR/UD6a/ODF0YVFukS9ZqdSTi4rEkuCk/ebbG5uC6zwsW1hBW8nWxThWawp?=
 =?us-ascii?Q?DjGOiO4qOML3jtt8clw7nMAQUtMXOctCeNAvlwkWEKG42l3stV4i+8JrVSbE?=
 =?us-ascii?Q?g0RT162L0m4/SW9WEJKPC8dVIRZjXTy2mniswCRYhLrm4of72rUuZ1+BKDMN?=
 =?us-ascii?Q?tpxTGG6I17EvNVJJc1NeYJuTJoMMDOEkTNKsSsYMl0/VeRH+2aPFk4+dJviL?=
 =?us-ascii?Q?ZigJMNjWHydEQFkTyFznY5KvHVqZCLf77Nbp2cwpj55Rj2nHMGrWsGhQTvx1?=
 =?us-ascii?Q?77s/0QONzlbbVYulftNTZmVU8dZj7077Tj1iniwDZwlCT/jjmux67JnwcDOm?=
 =?us-ascii?Q?PiOZRVlmA3b/qGS65dw8kw1zvWlt95Gd9h+3kSqsdTwEvKJ7mnlxVKD7/WYA?=
 =?us-ascii?Q?nvalKREJEPjIYW0mPEK/k7Pzn1sGUdiO6EqDIWQ+NVrYbvZ+XDoOFZ3mocH6?=
 =?us-ascii?Q?aqUtCFmsEy/Lzvvj/mF/wtL7tYYg7i60+EF+3RUnSG3Bx/lJFc8g54ySZSwq?=
 =?us-ascii?Q?+J35JUVhi46v9auOJ4fjRf06dBJBs+13UJvzf9G86ZAZM2TRp4ukf4lZl9WL?=
 =?us-ascii?Q?gzHkDswts3fUrg4MfWlNMWIfkBsmFc7bLazibu5JVoMgZv14ztshuhMg2pNt?=
 =?us-ascii?Q?qcf0NOanQNHU1msIlo1w2lbIvEd2ISCvPYJSxUMh/G2axP9PWMYnIWpo+f6g?=
 =?us-ascii?Q?WQgERzc406yUhXOlJaRqq2LjNeSvm1GJiFs2rFPBGP8SamZognbLb2YZBLT7?=
 =?us-ascii?Q?k5n7kKdGFizU5Rwq9/Z+o19psbEHKK/gaCMQ5l9+mJe/6s5Jx2PmPRz/8nOu?=
 =?us-ascii?Q?+2fYpyWRAB5V310hsPq+DKpKIizfQpWgu72NLnv60Keg+YPR7RjedU1214Fa?=
 =?us-ascii?Q?Ufnf3oCMqUJuKsNQ9Iz79Md3rkbEMxCJj0WMcNdpekHEv50o5hhtLtGqUm+I?=
 =?us-ascii?Q?50nsC7FNck6TF40VZcKi2HoD68HY97d4CktS/aYa5lktfOvM9WLUgsRuc+1g?=
 =?us-ascii?Q?O5KGRsaF0WkwwE5u2vbzILmPL/6J37Wp7BNMm7TY/FfmXkjodsML/S2L5C3I?=
 =?us-ascii?Q?MUDbixJLDswi38CfqTEkYbu+zs4DoVAV2L0hZvVl/HeTY8bKvrehb6AeJcVu?=
 =?us-ascii?Q?5U/NXuVVKWxwNMzHdifiuXZ0Q4getCLyEYxJPpJcnbJquYESd2f/r1O0h4lk?=
 =?us-ascii?Q?hjo7Qb7UFFc4M2qKQv8qLpuQ/Mpz4isl1ymBpsicZXBPfG+Wzwg99vz2pmGV?=
 =?us-ascii?Q?/gJVDLMlfekdrxgPfUukwAA7S6RLrnXGNh10qtxnHBaz/LsVcrixM/rg7XN+?=
 =?us-ascii?Q?4kQeehotVnYrYYMJmbn73GHEEiPOrS1y/UA+pYm6gFOZk/2oEsCP68O6Gbw0?=
 =?us-ascii?Q?+JwANx32doJOrpIyvBO9MOS0p13EAfQBBEF0L6DN1HrZ/peU9Ln43A6jRDf0?=
 =?us-ascii?Q?Oe9kSsSYqJtQ9uOhwwy4VxuabaNinn2BpRuIix7Xnzk2FesxOESeKyDPzBJM?=
 =?us-ascii?Q?DgyasTfbSn1cUsOzwNgLIryAgM8i3Ma3sbUqr96sQzjPm5LxNRLCKit2XBap?=
 =?us-ascii?Q?I2NS1BzpZUXBK9DeBu7+E3perQ7mFWfSaMjolBdsS1uZodtDEu9aMW+TqaVn?=
 =?us-ascii?Q?GA/LoBr0Ngq7k8Gsl89HFTXEfHiPLNwjZQ7v6dP5b3Jzt+hawb16oNKsgarW?=
 =?us-ascii?Q?Y8mQmKe9hZ7OQuLZeaEQOMnts4Hz18BRN/k2rbKW4+Eh4gigi3DZupaCmODi?=
 =?us-ascii?Q?CJwuEPRTFHzYAXzqzeV1iIqEu5UTd8MJSND3ak25awWo2ywxi4Xd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 333ca749-38c9-4ffe-1b8e-08df1d80f933
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:08.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMxRInZkxr3wi67TvOBYYcv3sPNKdeLrQ2SbHOy8vlyXa92IQFC4gi5j3p9q1x7wN5z9HwEwdG/GbJvT51+KYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

On R-Car Gen4, intreq_pcim_sub ("msi") carries more than the integrated
MSI receiver: the controller's reset requests and the Root Port's PME
and bandwidth notifications are signalled on the same line, and the
following patches need to handle them. With the DesignWare core owning
the line through its chained handler, the driver would have to hook into
that handler when iMSI-RX is used and request the line itself otherwise.

Instead, request the interrupt in the driver in all configurations and
set pp->msi_irq[0] to -ENODEV so the core does not install its chained
handler, as spear13xx, keembay and dra7xx do. The handler demultiplexes
the MSIs through dw_handle_msi_irq() when the APP block reports
msi_ctrl_int. With an external MSI controller or pci=nomsi the iMSI-RX
is not set up, so keep msi_ctrl_int masked rather than enabled, and the
handler has nothing to do there yet. Request the interrupt before
enumeration, as endpoint drivers may use MSIs from their probe, with
IRQF_NO_THREAD so the MSIs are demultiplexed in hard IRQ context like
the chained handler did. The interrupt is required by the binding.

Release the interrupt in .deinit, before asserting the controller reset
and disabling its clocks. Disable it around a Root Port reset because
the handler accesses the MSI status registers through DBI.

The DT routes downstream INTx to the same line, but the driver has never
supported INTx (no INTx domain, INTx enables never set), so requesting
the line exclusively takes nothing away.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch. Owning the interrupt in both MSI configurations, as
    suggested by Marek, replaces the pre_msi_irq host op and the
    two-path handling of v1. (Marek)
  - Rename sub_irq to msi_irq to avoid confusion with a child IRQ. In the
    complete series, pcie-rcar-gen4.c uses these names:
      * DT "msi" IRQ: msi_irq (was named sub_irq in v1, after
	                       intreq_pcim_sub)
      * DT "aer" IRQ: aer_irq
      * Virtual Root Port IRQ: rp_irq

Known gap spotted while preparing v2:
  - dw_pcie_host_deinit() frees the iMSI-RX domain before .deinit, so a
    parent handler already past the APP status check can still reach it.
    Not specific to this driver: spear13xx, keembay and dra7xx own their
    parent IRQ the same way (no .remove, so probe unwind only), and
    dw_pcie_free_msi() does not synchronize the core's own chained
    handler either. I believe this needs a common DWC core fix letting
    glue drivers stop the parent IRQ before the domain goes. That would
    require each driver review and testing, so I left it out of scope.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 75 ++++++++++++++++++++-
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index d3f04358bbe3..256410fb4b1c 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -116,6 +116,8 @@ struct rcar_gen4_pcie {
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
+	/* intreq_pcim_sub ("msi"): iMSI-RX and other controller notifications */
+	int msi_irq;
 	/*
 	 * The controller needs reinitializing; the APP interrupt sources
 	 * stay masked until a reset succeeds.
@@ -556,13 +558,14 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 
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
@@ -627,6 +630,52 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
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
+	 * Release the IRQ in .deinit before asserting reset and disabling the
+	 * clocks. Automatic devres cleanup would be too late.
+	 */
+	ret = request_irq(irq, rcar_gen4_pcie_msi_irq_handler, IRQF_NO_THREAD,
+			  dev_name(dev), rcar);
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
@@ -724,6 +773,9 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
 		rcar->reinit_pending = true;
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
+
+	/* The MSI status lives in DBI; keep the handler away during the reset. */
+	disable_irq(rcar->msi_irq);
 }
 
 static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
@@ -733,6 +785,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
 		rcar->reinit_pending = !recovered;
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
+
+	enable_irq(rcar->msi_irq);
 }
 
 /*
@@ -804,11 +858,17 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = rcar_gen4_pcie_host_setup(pp);
 	if (ret)
-		goto err;
+		goto err_deinit;
+
+	ret = rcar_gen4_pcie_msi_irq_init(rcar);
+	if (ret)
+		goto err_assert_perst;
 
 	return 0;
 
-err:
+err_assert_perst:
+	rcar_gen4_pcie_host_perst_assert(pp, true);
+err_deinit:
 	rcar->drvdata->deinit(rcar);
 	return ret;
 }
@@ -818,6 +878,9 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
+	/* Stop the handler before asserting reset and disabling the clocks. */
+	free_irq(rcar->msi_irq, rcar);
+
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 	rcar->drvdata->deinit(rcar);
 }
@@ -842,6 +905,12 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	raw_spin_lock_init(&rcar->app_lock);
 
 	pp->num_vectors = MAX_MSI_IRQS;
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


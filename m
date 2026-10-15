Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04493EA949;
	Thu, 15 Oct 2026 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035096; cv=fail; b=SzFWhVnyfq9g7URV6ta+gtaDoh1LivDB+Vd0/KTFARSJiCz5BGo7op0vPPQmBGG0xCM2SeEjZVytsDvIpZzf9SF2BFckHPN7zfsBl2n/3Vd6qn/sLu1MtQFs5VLmyknwf0gFDQT/6doXkPRXuf1RlKf8aWcAe1LKMJAzd0oYbAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035096; c=relaxed/simple;
	bh=Z8tiIZ+c1aR4B9EvhWzpNenn4u7tlEO7TADz3XltWhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MTdB01EUd8XissPGoQJz7LEDn51Lv1bdh2E+9FrqN30HH7Rp5mXY8PbtdypLwg9HeAPu3r0i6KKXifhkXN06Y4gjVA8Fll4xmZJJsUc5hxvuaYjVYxVpoqnfEyyz+3HTG/da0QXUM+eYv4dK/MOlNdFJYRauRE2NHJ70/0GK+2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cGQ8uSjx; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cGQ8uSjx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWt0wHRigCWMQ4nGtx6frxyjeNyTNx0rzjeiE8eeJz0b9sNqHI5tfBOjIh3fRk5mEOpGW05uWSvRBPytVPPBk7EVBzdxCej2RmY9I5p3zL16/k8jEpQ+7MGyFLACGgCK6GJqcb9EQ7yVOkpmMPRRtByJikb/rnT6YpMdbj5wGHbmLuh8ChLz3oOud/OYZBkzXo7VKoEGAXhx76k1ODUXcckzEgr10NPv5POrIKRHeb5up3EzW6vRS9wNMTmzmFqEIKkMtWXWd7psMll3T5eCuJdXehM1zw4yv4AQ3dbGSQS8EG+iXQvCo0nD/bzcwN+jLGviY3gKSbHK9aFNn7nUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHw1b34MNO6s71sppVolAANEZPgTv0MR042MUBeOfyA=;
 b=jRpbZD0DxofPZvD7wjoHKLlK92QoKrlw0FgVKptXeIB0wExnP0hIaqscC3v/j08A8qIGVDmwGNcTPoZ3fuF8xhA+J5jW3vFOnCviZHt2M46OuEpx1COBuTXIrIb/IoqWmJfByHsdlu8NxN9dd+crU46f1D4bxNRLcan1XT07RxwBvZuBu2PrfmSQ3+1iI1OsX/0AR1Ks70vqbFAsLLHNvlITqHBwiAXUV3q24ABdCsXy/IGHBCz+JE8Fy1A7Go3kYKhkC2iMsaoXKnzoAaJb4uol3B+k14thAd4wsrK6Qw1Thxwb5phcE7qr/BrQf8RlEtU0fnLn9uRsbSUNmNWcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHw1b34MNO6s71sppVolAANEZPgTv0MR042MUBeOfyA=;
 b=cGQ8uSjxCc2i7UrIdsihjzR0dVbXgYnu2+noAVfDXAMoHUUH1H4PREvDqewg53WJfe/hzK/ilzbqIr2k+iKHNVRRy5LWEy0jGaPL9Ba/R1iA/pLsPeI/xjzqwRqFGbXq4OGW3ttkUhHquOZ2DQf87CPGpImKDD4sU5uWku+37UA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:21 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:21 +0000
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
Subject: [PATCH v4 13/18] PCI: dwc: Let glue drivers hide the Root Port MSI capabilities
Date: Thu, 15 Oct 2026 12:30:58 +0900
Message-ID: <20261015033103.3076869-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0072.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8ec43a-8743-4da2-bc3e-08df2a6cc808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|6133799003|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KnzqO7LMgAAA4JywFF0UFVkADr8fAqjx6C6lkL2x7l/Dzlb8NHyJFo8J+sEX4IseKEAf7uTC+CAg2MUprI9UEsqZIcKQXbBU5DBqH9H1P31AxpeMj/OSBCcxujxqAW9i8q7NP8O3+9yB4vEwSORnJL/BZIq5c/6GmEmVzZieWnn8PFxpdL9sAYe+rv182XVFFQk2Nk3s/Vzi32LhCH9TPxFuqUCrG/XTAEKBugFlZfY/BiES68A/yvkab5Y5ItXJ6AFl9wsuqqMVgIByysj1GHcQMSEirz7JWqwz06GFno5aghym0FD32kpjweohjOJnlE+kQMgY6zI+Mp7JjXcsJTpzxLsYhYS0GHBU9ixWPy8vcvNUgnYWdZ2Qi2aqmXVMiKEXkF+Bn39lDh+Zi+qozwZJuuSbpwwvrya+rpvj8FH3ygwZQEDYS0Va47L72p1NiXcN02D3YoQo+uYYTOyKVM+cK5gIqB2dw8WEMimXo3iphfctD5JnhukG5cP2Ax5GJuh3wvwxOahN8sKDafSc4h64AI9XNu0VkUeW0cwCkGPhsfV/OKuF87MA81TZ6Z5lWF4JyBcwwkYTImPSricuaXTF6yFQUYDjKSQ/lX48oLsv5O0XK8QmVT/yXjepZgFmEQAuT7wbPOyore7VTSUP1J9Nj6L4skB+JQxxLyBWIqwjeOtke8rPCRwiGGVnqgnT/IRM8ueKoyKuWUZC8ebgIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xxSyXkNrnH1KpOgyyuuKp0OF6ctjN+jArU8FqFHvjzCjk09wNJqca/7w3FH7?=
 =?us-ascii?Q?KnKC/Kt5bN9thCVi/z0KeCKjcfRD/Xmx2DZs4FX2QStdofERADB5IgFdbns2?=
 =?us-ascii?Q?RMgRsW91WQmvDASbGdigZGiD20lwfCQzMg9WyJvtwO503X8hMGV3QaJjf2Yf?=
 =?us-ascii?Q?kDlHLHluPZ+s8jSDEpteaYM0iXKIUAdHk3TZwguNZaBT9NSHevf7Z9tjOL06?=
 =?us-ascii?Q?LIDPOm1yl5RZo8tK777u9B340k0ImHL9QZj3FTqaLpra+zUmAj8zeHk83tVH?=
 =?us-ascii?Q?1kQysbu69TaOHSxPMdYe+tj7JDo9SD7Mr9ZWxZLLyyDMn4o1Njbs9bRCWCrf?=
 =?us-ascii?Q?34yFDHpR83vpBcyconHuwDkuXrEELhioLHbcJSpt3vccifiCTA/KgK2pb0Ov?=
 =?us-ascii?Q?xGhmyKtf4ThwT4HGdb5JptbR4DXdGKBJMq1A6D7zuKfGtfhBlNXQ3Bv5hkWb?=
 =?us-ascii?Q?faWtQiK3pNniARYfahrjqP94qtlcZL+4K+/7K7icaMW7aPKTcmowhl08kNVI?=
 =?us-ascii?Q?vBja8Ei+EzYsiEriZFTJqZ8iWGE94Q0g18z3z08zFCJ7JxrwyoRCq1myJzEC?=
 =?us-ascii?Q?b4CnUeS3/eKJSQo4FgdCloPvNuEeKDq8fAC3iG0QnCgIW/v/2DopeNYRUbvo?=
 =?us-ascii?Q?25FDeAHclUtQju4+1f3cRZ9JuiYlRmUW93bNFtJ91iXYN9swyS1I2rQk7pE/?=
 =?us-ascii?Q?qf9nbBuxIH0B+msByO21kloZcWHKT+cmvBKvjpQUhhYo5awKGm1BtF/6vMWv?=
 =?us-ascii?Q?HxNAc5QlTPJ0YJnmmx4ML16CPjINZk4LitB59wqP3+HnuJzVXBA4OmEDqgXO?=
 =?us-ascii?Q?gG2MbcZicB6geB2rknGO2WoL94vVGJ2MY0kmMuI8v1cFG5EN+PIUkAOPlhPt?=
 =?us-ascii?Q?WoWbjE9FC06gpNLTxccmWXEb4SFp2PvbSB9I1iEPxcUXRYsHB+HPO40rIdsd?=
 =?us-ascii?Q?x9OSZsPe8bjwEwtdqxrklaZWvlbpQMke+N/mXxFBpcEQQqC8ZED/BdrXCC5b?=
 =?us-ascii?Q?07SUZgGC/FzJSqPITwhm9AomlUFWHRHSX27HGxNX8/zQ9PdIUfAJofFhV64Z?=
 =?us-ascii?Q?rQ+zfmpGLsmUWx8ypyHO8ZRyIXO+x33I32Ebf5BPOGKQGNClIXmn4RpTXnch?=
 =?us-ascii?Q?9LRAhZsEVqDO7knROamYSgx9lbk3E7gbx+l65dJy4bj3KCgjda10qNFXIZQN?=
 =?us-ascii?Q?9hsLVnVRgmZCKfG1QY/N+jsPKFXSwEQ7plib/cyMdBDjIoA7GsI5ZXkOobLT?=
 =?us-ascii?Q?9PpjCfnIrDHK6j6tm90FxKg7R1egPQ60nA+vxp/M8UH1RaakBaoW7BQEZUXq?=
 =?us-ascii?Q?NV2+ZpOPEA+t6rJh15vyEHWdqPZfeKYvmRqAAkm+hNbpR0sATSdgSLYTmZE4?=
 =?us-ascii?Q?5mMYGqvS9mLmndetEzNZrsvgldE+Hc9Nq7w4/hMlzNNYbPjVr6LQeCI9LMSg?=
 =?us-ascii?Q?gIM1D7iZ+k/nfEBjdl50VWHdL2SkdwbFtOgBOX1WEeCeF8SqOoOZGnUx8Pbh?=
 =?us-ascii?Q?bsm33Uibuy8CWjT30ZX5u02xxIuVvjfTThD0mQPAl1LG+MTSVySQ/fU54JhG?=
 =?us-ascii?Q?clDSQCP9sMabFekmnguCMRushQ+Vkysth70iEbjGXKFo5KmIsmMigLCT7xgt?=
 =?us-ascii?Q?HTxuoDJI1WXpmN5+YjxAa+Z+czG/8OOWzgtzlHeDEwuRdwkTxc7SxuCOgz74?=
 =?us-ascii?Q?8R0/0uqV7U25uciqYAylNBnkzEmGmefqRZZLrLc0U8UGrISDqPaiU4f9nxb1?=
 =?us-ascii?Q?C3Op5z22TMLNxjkAQyvDdeb11DJJpAPOLj8aac8Y+MpyGD7bL+G3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8ec43a-8743-4da2-bc3e-08df2a6cc808
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:21.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 406suaYoXat3hRxVL0QoHsusPPLOewXKD58zA1+L2hkYlLk6h2OSoYcPmUF+eVfsj7pK+8Ct9hsak+fLaxRNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
if iMSI-RX is used as MSI controller") hides the Root Port MSI/MSI-X
capabilities when iMSI-RX is the MSI controller, as it cannot receive
the Root Port's own MSIs.

Some platforms cannot deliver them with an external MSI controller
either. The DesignWare core signals Root Port interrupts (AER, PME,
bandwidth, hotplug) as sideband signals on its SII interface and only
turns them into MSI writes with the optional SII2MSI feature. Otherwise
it is up to the vendor wrapper. The controller on R-Car Gen4 SoCs
(DWC 5.20a) appears to lack SII2MSI, and its APP block merely latches
the signals into status registers wired to platform IRQs, so an MSI
targeted at the GIC ITS is never sent.

Add a no_rp_msi flag so glue drivers can request the same INTx fallback
regardless of the MSI controller in use. It is the counterpart of
'keep_rp_msi_en' from commit 3a4e8302e72f ("PCI: imx6: Keep Root Port
MSI capability with iMSI-RX to work around hardware bug"), which keeps
precedence: that one is needed for endpoint MSIs to work at all, whereas
hiding the capability only moves the Root Port services to INTx. The
removal stays in dw_pcie_setup_rc(), which also runs after a Root Port
reset.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 774e1936d999..32e179603cf4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1191,9 +1191,11 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	 * The iMSI-RX module does not support receiving MSI or MSI-X generated
 	 * by the Root Port. If iMSI-RX is used as the MSI controller, remove
 	 * the MSI and MSI-X capabilities of the Root Port to allow the drivers
-	 * to fall back to INTx instead.
+	 * to fall back to INTx instead. Glue drivers set no_rp_msi when the
+	 * platform never delivers the Root Port's own MSIs, whatever the MSI
+	 * controller in use.
 	 */
-	if (pp->use_imsi_rx && !pp->keep_rp_msi_en) {
+	if ((pp->use_imsi_rx || pp->no_rp_msi) && !pp->keep_rp_msi_en) {
 		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
 		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 2ce61709b58c..d94116402b74 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -445,6 +445,7 @@ struct dw_pcie_host_ops {
 struct dw_pcie_rp {
 	bool			use_imsi_rx:1;
 	bool			keep_rp_msi_en:1;
+	bool			no_rp_msi:1;
 	bool			cfg0_io_shared:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
-- 
2.54.0


Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30792499F17;
	Thu, 27 Aug 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854826; cv=fail; b=aiW/FW6vp3TaP0lBtYRzHlFA6hBToIhDF66Ycc7+5+NrnlLLkkllOzOcTXNQpP0XfK+VOJly9VztJvlAvK4LRMzsoqCKxiw/TknIqsfyKro9jlD1XUgL/34tPKTdbkyzTCW5B+FCo4x3tXRjh4otmDdFRPP1ONBz/rYYQL/w8kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854826; c=relaxed/simple;
	bh=gSEV84/4vIvOBMKd4OvjxLQ9yjY+Y+YjfuL2M8EkUtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f7LSw+XlY0ICAOL2HtSn0F7faX570y952XK7JUdY5gNjZ9PU1VUcd7zs5QzfB8mM30vneq9gwvAS0365eBGpH2nwHUoXqJymejbHSrTqCxntotjo6lEZj5WkfU4jCBcpauqwyZnm7d8i170vZY4V4pCi7bgYYol1IwtCrUIshyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=q/COslAs; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="q/COslAs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq559rzPigeeZU5y2uxvzMiUUNuvzNRzaLUx3eXLGO1bLVhfTSyEVysKHktRwm0bQtSqxzeMGU0488kVpgdfqVxvor5buQGyS4G5HhjIt2rYTueOCJtEUNbsDWvr7X6BK4C357m/92+kP2ZxpIItEqfDbkXvMlbLbyuV4C7gKDDhSMYOdc9EYgqBTG3jubVINdFvXWfQSu861cUW8r7ss41GjsqvpLUdFLBk9q7I8rsZyl9fLZlKcAw3mipNBI0J8dSrDawXA+0WSXa8+tDLP7BQCPrBPwtlG9vvSdcg9eP+1RbPdKNMAd/TeBjypxQXPiP6S8pYeWZk8ROaXRMUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Adj1PhWejpLIjLcRuT8yyvBm2g+bncsxMaqqrV/lZIA=;
 b=DetJA3BqMspZN3LB4JAf9RDT34ntuAZzxiWKfUGx6kw67rBpgiPHGpazDtmRIEab1b8b2LOWnS66YwV9YgIbUvtqpZwL5356ydHrpgoWL9CHLFAk3ToxyCAfkLgAoiyPH+89paCXHxmPn5D5JHALzrqb13YaoaoiCfQxDC/jqa+DwiiXpYN9l6whXGEuBMQMe9/evif+wsgDiZOuhDCZ0hv1Cm1RyOAHnuhZIvt5Jn/sKfpOs5WSTGrDX844MTc1DZU+LT72jondn1JqPoUcL3gNgTMqHDAyiDwke4fOFsWZigBlExLabdBX1APoBY/4BG5KaR+0ZsI/hWaFfARoCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Adj1PhWejpLIjLcRuT8yyvBm2g+bncsxMaqqrV/lZIA=;
 b=q/COslAslbdcofgxRY+pu1LE30mBMBjokib4rnbZVupBVcMlQPd/k006rabZQBXGsodbhoXJvBfS2xUMD3jaCBVv5RjSuxNp3uPN5dwYtDiQ6dfNljxwdZx5U9wgFJFXc7P5IQv/am5eD/qYX07onDXlVZrhVcqRK6T/gLLEQZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7058.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 18:20:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 18:20:19 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Aksh Garg <a-garg7@ti.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	ntb@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: dw-rockchip: Support fixed MSI-X table and PBA on RK3588
Date: Fri, 28 Aug 2026 03:20:11 +0900
Message-ID: <20260827182012.1984960-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260827182012.1984960-1-den@valinux.co.jp>
References: <20260827182012.1984960-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0070.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd3733c-38f5-4126-ec2e-08df0467d9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zh4QOejTjREtvY9k+AIV3gmWynGRmclPZM67f7Wr34JFv02kcvtDRr1bHnZNTx3KJgUq6UeU20xlCuP4qLx1RcKxLBPSxYUq3WoY7pvVkoAqv9WajP7QcBchioJiRHdC3W6jrXmCKRPC8cAgWOkmGgA54HKh4k6zovyO7QjZelFXhnnqsN3gXts3S7Vp49LQIZEnt0AxJxScMs9LZNwTSMD/G+av0IB2OJ7+bkcSIzsYfPW102DecatZY18djg4h1j1yvgzMyH7b+D0e8cVG90TjP/N+NJZVoanL/EsnVEeRpKZY+LIWCwEtzcG1hG/2MLJ5GWhyk4sajxYjOOXStN/lBcqnCO0iVBhYlmy/VKmRbCFAOQWGqHqQq6oIAhFqCRilyBtEzh/6vbHDpGnDwPIZ8tiMNoWmQjUwbt+A8YnNNpE8751QKrJjc+tm2hHtgWcNVCnuFTkv6p1ikoGBIRL5gInvvo01dDkW0+y/BC3i3Ra8MX/y5yo8EOhCKE3frXgSOKaxDdCotg6n5Pzfwd2pLptVad+B6gGF2g+98EsHB9sDmCLaVHO/Udv5JSsGv5XIxfTtd2U2604vhbKjuoMGFJyLaPkDxfI09LtpHyjb99EeOQJ47uiJw2ekvmIHMePRtW1uxg4qTHDUuhWkZ39HeGoNYm00oF83YJpTuiw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kAlar234Wmg5xy7rSn9XCtO8e/b6mM7siNYQewX3zayUPhSSVWCMBX1LxHfY?=
 =?us-ascii?Q?FnXk7NhNgnkJHthOhGaMM3AH86y6plgNysvUwM+/9Dkw239Q4VqtMT/EOLJ2?=
 =?us-ascii?Q?yEv8Ct/bcJ83r1Q2ewG8kVZjHtjEoNaem4rZRtb7scnnm4iEpoTDJpFntzpc?=
 =?us-ascii?Q?fGfTOr+nDnKqLiOTe46SLAMbTffyKJUjN5C50KzOkazS9p1r6A0/ZmsvNXQ2?=
 =?us-ascii?Q?i0JWIJ+60aROIVF1wAoi6vFzwMXZLQGjfkthAwStiyRC6plDzJlGq0wqPPZa?=
 =?us-ascii?Q?sxAo9jOLPVkV3qeWxRSGOmyddmWeyjDcM7Ac84dJskOh0sh6LwSgxCsnLYnU?=
 =?us-ascii?Q?0jlh5N8wL+Sn7gwv0qGL5VAnCfy12hsd1t0VA6vDYz213lWaqA5nl9OXLs7S?=
 =?us-ascii?Q?HrNJJk+dnaaqJhsXuwEDxk8RYEagGfF/45Ri/8gv0wq7dFRk9ChU1Gf4aYyI?=
 =?us-ascii?Q?1g1Qm23y+x1MbKIif5MrBOyNeM2w2di2NmGQm46j8hncc1y1jDJDIKMh/Y/8?=
 =?us-ascii?Q?31dpdbCgSaalXFbIemlloepeh/ptnW1A22sXPNABESzmozCBj4yiCyWBekJQ?=
 =?us-ascii?Q?UNEwZfpQKRGOJOFY3o7tXgEEfC415b4k28G0iRdYYxoEJohdJLoB0vP8jHAQ?=
 =?us-ascii?Q?hLN5844UNgQuBndy76LhOlbr9aMoqSpPA6uP3VaC+E1997CTXqEktkkkF656?=
 =?us-ascii?Q?wYO8a7zgVOzu/LBAZnvK+d++wEWDIdn45OH5X+WAr4h4QaVHtXn+PS/OsqB6?=
 =?us-ascii?Q?u7wU+xTFfiCjwrtaWpzLZ9QKnTAigqi7d5KiGho9uzJaBCD268SWVKs3Ngke?=
 =?us-ascii?Q?9qnk/nQUMXg1RcJbEeCkd9QE/56OpbMWSMskDoKwVq3XzKmQ/o03evxjASgW?=
 =?us-ascii?Q?fjFoN2hN9HeBR/NHtfXFXI8TqD9bgglheBFJshgVymiHoQatXcWILDoZbR/O?=
 =?us-ascii?Q?WiPs+/sBPPRnuNLXG/iKE8CoaXrwHGY5QQXTRCGhMP/NGxMeRcL7Zfc+nA1P?=
 =?us-ascii?Q?t6GXdLdz2hn9Z5mLGWZLNdlepKFN1YUf6OhayQkhTTGjDTf/kAJCF69OHmKp?=
 =?us-ascii?Q?P4Hu8ONpx1wV4N84gbeSkdp5MKGVM88TVncgi5mEZboLRGQkXt7rMfOdon21?=
 =?us-ascii?Q?aj95LQvGTg5fZBnXhQ777X06HFfsVnDmw3Z4/utjLfRWFi5qJb/EFj8S1rpM?=
 =?us-ascii?Q?RBFN+BOUAiSaxdnkVCMDa7AENpvD8Zus+OU2pCLXafylP9aDsGsEz/fSu6RR?=
 =?us-ascii?Q?cptnm51d8OB7J51sqOk9SA/6mHNGKM14CzRVtLsGOg8x8YGP/eeiWn8qx93q?=
 =?us-ascii?Q?XPOyfZbJZ6pV/qRKDCeOE3flPK+ADwv+CzSmxFRfoNVLyIMCMzpYslXHklUv?=
 =?us-ascii?Q?/11fH5Ne2FIGlFQeRPgpAwLWm7VrpKd9aUWNkxc0UuYWMkYNmG4NuFnP6haF?=
 =?us-ascii?Q?C1aW6nAdEQank5MEXuZf+N77M827DOWCNzPclAgO6FR3xPvMQmiMGTkOGEB7?=
 =?us-ascii?Q?uJ82fG4KhSwQLtCKJgbF2wUPVXBRx/KoqtFEOYD8qgxnnMm3Wh3NAIKPuZIS?=
 =?us-ascii?Q?nvdxYXzMYUqTu6x/zcBTXT8k1zNLYIuATdYDL/KjeLPmLSaxH1VcF4W0WJuY?=
 =?us-ascii?Q?frTTIafdeF+46mk9dg3zsniqjw24vvqQPadbr6gJiFghWYUTEmnTVqQRE7w9?=
 =?us-ascii?Q?qR0pxwAntaJsbdhpboFMDpG+mtQY8x+smRBD9qPCWbQqR4uJGxKyPgZ1Sw8/?=
 =?us-ascii?Q?M4gjiYnnvzx2u5+9hG6whY+1sGMYlwv5zHToh5dWWJvk/8xcsVwk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd3733c-38f5-4126-ec2e-08df0467d9a1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 18:20:18.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7W3R9kie6C8O/d8rh/6NZ7A6Uc/SrdOKeDtvM9GnBsC8pZmT3Aroo7WigtTHJCGdj6BH8E4309IggKGUgIQHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7058

The RK3588 PCIe endpoint controller exposes its MSI-X table at
BAR4+0x4000 and its PBA at BAR4+0x5000. Describe both as reserved regions
so EPF drivers can select the hardware-owned layout.

The regular DesignWare MSI-X interrupt path reads an EPF-owned table
through epf_bar[]. A reserved, hardware-owned table has no such backing.
Record whether the layout selected for each function matches the
hardware-owned layout, and use the controller MSI-X doorbell on RK3588
only in that case. Continue to use the regular path for EPF-owned
layouts.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 21 ++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 28 +++++++++++++++++--
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 147b043589f0..bc2b63814dea 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -736,6 +736,26 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return val + 1;
 }
 
+static bool
+dw_pcie_ep_msix_layout_is_hw_owned(struct dw_pcie_ep *ep,
+				   const struct pci_epc_msix_layout *layout)
+{
+	const struct pci_epc_features *features;
+	struct pci_epc_msix_layout hw_layout;
+
+	if (!ep->ops->get_features)
+		return false;
+
+	features = ep->ops->get_features(ep);
+	if (pci_epc_get_hw_msix_layout(features, &hw_layout))
+		return false;
+
+	return layout->table_bar == hw_layout.table_bar &&
+	       layout->table_offset == hw_layout.table_offset &&
+	       layout->pba_bar == hw_layout.pba_bar &&
+	       layout->pba_offset == hw_layout.pba_offset;
+}
+
 static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			       u16 nr_irqs,
 			       const struct pci_epc_msix_layout *layout)
@@ -764,6 +784,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	reg = ep_func->msix_cap + PCI_MSIX_PBA;
 	val = layout->pba_offset | layout->pba_bar;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
+	ep_func->msix_hw_owned = dw_pcie_ep_msix_layout_is_hw_owned(ep, layout);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index de4b245b1758..043c39b5881d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -495,6 +495,7 @@ struct dw_pcie_ep_func {
 	u8			func_no;
 	u8			msi_cap;	/* MSI capability offset */
 	u8			msix_cap;	/* MSI-X capability offset */
+	bool			msix_hw_owned;
 	u8			bar_to_atu[PCI_STD_NUM_BARS];
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
 
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 731d93663cca..d622723dfcf8 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -120,6 +120,7 @@ struct rockchip_pcie {
 struct rockchip_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct pci_epc_features *epc_features;
+	bool msix_doorbell;
 };
 
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
@@ -481,6 +482,8 @@ static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 				   unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	struct dw_pcie_ep_func *ep_func;
 
 	switch (type) {
 	case PCI_IRQ_INTX:
@@ -488,6 +491,12 @@ static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	case PCI_IRQ_MSIX:
+		ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+		if (rockchip->data->msix_doorbell && ep_func &&
+		    ep_func->msix_hw_owned)
+			return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
+							      interrupt_num);
+
 		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(pci->dev, "UNKNOWN IRQ type\n");
@@ -517,12 +526,24 @@ static const struct pci_epc_bar_rsvd_region rk3588_bar4_rsvd[] = {
 		.offset = 0x0,
 		.size = 0x2000,
 	},
+	{
+		/* MSI-X Table (BAR4: MSI-X Table) */
+		.type = PCI_EPC_BAR_RSVD_MSIX_TBL_RAM,
+		.offset = 0x4000,
+		.size = SZ_4K,
+	},
+	{
+		/* MSI-X PBA (BAR4: MSI-X PBA) */
+		.type = PCI_EPC_BAR_RSVD_MSIX_PBA_RAM,
+		.offset = 0x5000,
+		.size = SZ_4K,
+	},
 };
 
 /*
- * BAR4 on rk3588 exposes the ATU Port Logic Structure to the host regardless of
- * iATU settings for BAR4. This means that BAR4 cannot be used by an EPF driver,
- * so mark it as RESERVED.
+ * BAR4 on RK3588 exposes the DMA and ATU Port Logic Structures and the MSI-X
+ * table and PBA to the host regardless of iATU settings for BAR4. This means
+ * that BAR4 cannot be used by an EPF driver, so mark it as RESERVED.
  */
 static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
 	DWC_EPC_COMMON_FEATURES,
@@ -841,6 +862,7 @@ static const struct rockchip_pcie_of_data rockchip_pcie_ep_of_data_rk3568 = {
 static const struct rockchip_pcie_of_data rockchip_pcie_ep_of_data_rk3588 = {
 	.mode = DW_PCIE_EP_TYPE,
 	.epc_features = &rockchip_pcie_epc_features_rk3588,
+	.msix_doorbell = true,
 };
 
 static const struct of_device_id rockchip_pcie_of_match[] = {
-- 
2.51.0


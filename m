Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021129.outbound.protection.outlook.com [40.107.74.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E673B19D0;
	Sun, 30 Aug 2026 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788103218; cv=fail; b=laXp6dvE4m3EFst54RwZblFlQ2lST9hElmMgA/lUk7KQ6vanioj9EJ0G4FRkkngz1RVoJr2ztIrKiSnFc3gN45DwtkuqJM15h+C7gu70PI2udUwpwtL+Xg6CWp9LuD/wI/pXhCOT9wsbwyl0AfwOMg7Nbj7NDkh8BkFsTTlVirk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788103218; c=relaxed/simple;
	bh=ps/WPtQaYmiRassaH0Mf2DwEy+hbbFES8CNqTT5a5r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKbsW9+tbHzvxIrCICYbNN1SUEReOJY3lEYd3yPVxo9U9xKensz9VVDEZSG487shW+xD6VUwMF08eHDCNI+uPWiLewwuWILlGWKaFCJD9dY9PXfDx4DMAR2CxdnCourAzb9eQEEFe2Tq1Wtfs3JOXmcItAXZZxQROI/9f2dDq08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bz+Kyq3V; arc=fail smtp.client-ip=40.107.74.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bz+Kyq3V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luXGWPbZSMfIJVr1ktfwJ7yG11MhLZW731FWjjKbRB+psX2tU1Gs0fTiqOBMHUUaBHTP+QoqQ++EREGQp0sZv42XLcPrJvKVyoYZlAhrbX/tVelg8VBdcO/Jgt1GcWdJGp52UAfPN9zspe6gOOp7oTTnhzouA9+G9bcKT9v6chjrStoYKVmq5qcE018zMboVjoUhNPsfwEbltgY1+yWLSVe3A0lvtre7HYwaKcH4Dtahhj/grONEcyWdlZROU4waVeTDgQqn4C2gSUEd/WA20eTACj3gLHjAvUT5ydAcYmTxsngLBys/CiNx6ThztqRfZWbP6LQB/ZHHVWaPg9ExKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K08nhjpY6VLETgYGFjZK7o3d80NLxxcir9aDigmJ7g=;
 b=Rw2sYagFwA7XEOi6glYlCAKI8BSuMcSQKdbRp4uPTfBWFaJTJQ6SNTbGm7twqRSRV4b2EhLt2Zzc53FPd6IHsVo+4XFiHRvB9r6jNqH7UUDKC1VtscjUQwESK0bzhAvFbVqFuvaSC2PvI6hv3xiiScRdmwnCQgtllOwzz7Gi0fdMTvZ5bR2F1/3IE6DJbP2SoXl1le+wnB73WM3Eu7QOmpaFzl2LXqzZZRqcOxRgm0mcyyTM12EGqfGlYVshZpJWDq6aO2ybiublEL810HlCiBkzLh3vP58i9tU1SX9Qn4M29NDSlKfx9rLSmOcEscIxJrtSl3C+FGewUGD+sk6flw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K08nhjpY6VLETgYGFjZK7o3d80NLxxcir9aDigmJ7g=;
 b=bz+Kyq3VFffy2CniAYGyjKgYxcseYgc/+NqbHQYWiJUVndQzb0Aw9821TpycuUKfO6q7ZgtxF8UTZy/LrpFcaRRLibA/ts7CvCxip7z+uknfUTI/UtHYJqoeUkWP03Un8UgNkByboANt9JsVE8u5nTglgkTwfhXxD1bhDii46mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB3211.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:214::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:20:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 15:20:12 +0000
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
Subject: [PATCH v2 2/3] PCI: dw-rockchip: Support fixed MSI-X table and PBA on RK3588
Date: Mon, 31 Aug 2026 00:19:47 +0900
Message-ID: <20260830151948.3547577-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260830151948.3547577-1-den@valinux.co.jp>
References: <20260830151948.3547577-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB3211:EE_
X-MS-Office365-Filtering-Correlation-Id: 33102875-61be-48ec-a54c-08df06aa2f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|10070799003|366016|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S6PaoyqQuo00fda0S2WNBI/zb1qZklJq5d2lyn76sQvHuexELXezNzOKbAyT4MY1RxsfL5KG9auIX/2FS3yAQj/hGkd4fPeXOfUiSwwbm0YYpozvRUoGvbZohiVKLeqsSzisQhngz22rKRYiD2yPIDx1qsYBeX8ZM/i7vurjIpEt34zlK4DMbEYQC1AyNDLIA5jsgTMlht4qcgbyDqO1cj3gLs2n3yintm0B0zj8POaVtC2TvuhZ1PizGVgFLPAqdl/rTMo/iV15E2yA2k/pustCsszmcTnPWzOKWQpKBFu947bO491UnRbZl1hscb8swJSME0QuE8VEpIMOOHeAdVKnGGAZEWqFjEDh53ka/gRfDLACxntS8ui7RfYFxCGtllQpGwnNhFxdM8ue7tdnM42+wHfNmIk4/MOIO96kheKX1XiXK8c6iqNdx55xicR8GFjvvi91ixn1sVejunGMcKGzhP6qdLj40o1Rrw8ZLvTQ3hv0PxWeo7VHyK57UOu/46IxTWfxfZo4nj/SFFjV7ckYF4N+yXaMqKLiO7OgysR52OLOhYhbuF2CLvXw7AV2M6Slg4HgBzzQmBTAAvhtC0QfaONKvibKUZL3Yffw7ROlYTAnTZ+YbsqTBIgYbHMzc++8S8Fe78umV5wLgnZCpciUKg/JlxGGZdS0H/Y4SdA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bi7cQ28ksk36R/Wy85otbj+vayhgagTmY7BkGf86tecYqP+tt+R5WrOXJnFx?=
 =?us-ascii?Q?DBvwfXa6Cz560j2vdAKS9shWub1YvJlSuToO5xG+IREjGCkTHa6jgjLcLjKe?=
 =?us-ascii?Q?yCSyBKaeEZnoxuJ/aMyvc6BknBmaL3c0BuDrhgUbR+YXtcVE13i7f36wmjDc?=
 =?us-ascii?Q?HhWAd3unU9OCliBSzpxYJQxtfkD7xFZqbP9H4kwzh9ET+jqDnIJ42hPfgD4D?=
 =?us-ascii?Q?GxkoCbM0WU8mkwW2atfvnbXYFmP2kH3q/KiMcyzlY+1AP1QZylqTGTYIkWMC?=
 =?us-ascii?Q?eECy7QqMIgsrI+NvOglx7lgnIXDvJba9fsnu7lZ7ENY5XlKMXabIDzqrINCG?=
 =?us-ascii?Q?YguWl1iQrfPbe4OrS61DVnVsAe3sqNxwexuGg3kAKjM8PiQBRqAsg7BMlJJt?=
 =?us-ascii?Q?7225z+OTkQgOQZsPfHLa8gwc4gqmk4KYwnMDRIrTsuwkzJXaZpt1Zwh1fAmU?=
 =?us-ascii?Q?9KTuk6cAElBz4rS/oMoglpVYadFlLxf364mkcwX5v86lJsTnb2O23fLwZ20W?=
 =?us-ascii?Q?MB3YrRDNva0lRvtb16azo4VIE/mmMfaM757o5HsW2AB2inusne9/DXf9RdYI?=
 =?us-ascii?Q?f7moZxTrVVagICMOQELrwke7x/3iqD0vwNwr/W4pw5hqbNpW7HJLNqj1Wrca?=
 =?us-ascii?Q?LcpNlta5XXAq/NK3YcnIu9lU37tX6GHpM+1r3F/yldV6GCRKIso7MaIBycwb?=
 =?us-ascii?Q?iWBL42uEZQ0xHBTsXO2HSCPpaxAo8+ObocWMNv94rr0TGgyzoEvgUG6U91XN?=
 =?us-ascii?Q?KqWPVmotYOKRajdPOeGi/5Uk2TdsxgcV4s8GfhrEFNq1p2ULHg1o4PB/tGsR?=
 =?us-ascii?Q?WEKxVJjzcq5pisTP0k6qWtqMuCTLXw3YrNQ+Bjdk0bkHmlCA9n8ngqAOjaz6?=
 =?us-ascii?Q?42QzBOYyLdsZRkOhxPkIp7yX59VZhBkEVQ3PQQhqpbyhhXQEgevRzB2EA98t?=
 =?us-ascii?Q?5TFjyxd2y/bFchK4vJ+mXwKEAuLAuYkgBvxqRAfVqkJw0RDp+B8dYzEMQluT?=
 =?us-ascii?Q?fSNW4nU+ghWv7oxf9DwJg8THLGS1vBtxe6HBzTwULL/134dBQGkXVrWxyrp7?=
 =?us-ascii?Q?ZpixfWUn1yEflaP3qFz+x5iDk7UUdfxeTJmAzX+DTT07xtXmn5LdnHZpnTPN?=
 =?us-ascii?Q?0pexa6tHN7XjhlC+HE/R/UePrW1sDQUfxQw9jb9Z5aPutyFdMTzcsiTDzVDy?=
 =?us-ascii?Q?CckSfmVg0iEeZT8dvU48pohZKrZHbxGn40LtA10uaWo5+VlVREt+sZaG/rsq?=
 =?us-ascii?Q?LV3OWY8VyLMvJayxw79KAXX9GVkKADCXElJrZjXD7Durjj7erfDyP3wN1lZR?=
 =?us-ascii?Q?DJGSgDIlEdVwEuOMEQ7na38QpLsmDeW/7a6Eg3cN+hwr0ul+A7nZ2+ROcVfA?=
 =?us-ascii?Q?7tPUfERJFEImJ2VEyiN/gnEdpCUu6x+fcrOEpDjHAFxL1llPTHG0/F0nC0z3?=
 =?us-ascii?Q?qhabcWT+BRezHxVVJ2PqZf5OQcOW3qUk/sinRQqwu2qbl8zdNoyT5LB/HZm6?=
 =?us-ascii?Q?VaBSqF7YYzs49VWQ5MIzKbgThAwW1w1NwEt0ej45SrsfoCIfHaAnjJMzzATX?=
 =?us-ascii?Q?vSNksgKMOeEEqmEfjjDqdta/OViUmKSvw8Q7+C5fXExOEbS7WQHgsZv4lrz8?=
 =?us-ascii?Q?Hs2wIyFZMJgkm+BDegLy+TYBYVthZGjKI8pxuWiLHAJboAAT0w6lanJClFog?=
 =?us-ascii?Q?zDvK7ympop+KEG0I1O6orCUwx3dqNPudZDKGgyshO0jvxGaPfZoiENp5byyM?=
 =?us-ascii?Q?mFD2KcbS/lyIxBT+zdFJNqRc8rXN5W+TZlvsV3JGZAMHu+OoKcbb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 33102875-61be-48ec-a54c-08df06aa2f7d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:20:12.1357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tvjnyl4yjj5mmqVEuhvBl18eXddvC5wRPJTzOCCQzD7khjkwe4FBEzm8OAGbxxCT1272ul4bY3NcyvISgJ2mJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3211

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
Changes in v2:
  - Return an error if the regular MSI-X helper is called for a
    hardware-owned layout. (Sashiko)

 .../pci/controller/dwc/pcie-designware-ep.c   | 23 +++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 28 +++++++++++++++++--
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 147b043589f0..96726afec564 100644
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
 
@@ -1109,6 +1130,8 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	if (!ep_func || !ep_func->msix_cap)
 		return -EINVAL;
+	if (ep_func->msix_hw_owned)
+		return -EOPNOTSUPP;
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
 	tbl_offset = dw_pcie_ep_readl_dbi(ep, func_no, reg);
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


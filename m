Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021087.outbound.protection.outlook.com [52.101.125.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC22777FC;
	Sat, 20 Jun 2026 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975110; cv=fail; b=uUOC6RU8oiM5wIPIrLl4FDyL0jvwtk/VBUqNqHy0v0wrx4Vr7E7DeQ9eg/zwN9lYw86Fa6K/rgahUZAGLOWpU/3apMl66JbmemKXGF0n0+oR39SAhcR+Rtr8PsJnWFBBzV293j9IQqnlqG5QT/EkNkuY4JAr+AKKnxyAT98Fbys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975110; c=relaxed/simple;
	bh=RwAqHZzUK8bqMLQhAyR8fngGzaSlgyg588UfeNYKRO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oehJ3eakM2BSOLlDOxoba7dLNl6Vvaus+yzj4h0gVMcIoG9bXrsHLd+Y0vype1zYAQGZw6V5SdRmktgFL6hH2MRvf6CeEE7ee6OXD3yXdpDvZjeJP8KC3RLm0ECuBytnsoMn5p00yXfGREtrnjwM7zit4n09t/wJvPKgDt/+Q+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EfRgmvSn; arc=fail smtp.client-ip=52.101.125.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EfRgmvSn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL2OjhVJslhthLmuLuMgodFsF/2rBXmHO5VqIhk0hCsGGc61FYRjAWuuj669/J661RGon3I5dAYd7o28WLWRCdHb2XId4feUJQZAChtkCOojbSyd8FPZk6ntatJ5xW3Bpq1RTR/DxQdlomFgb/4rBFXz10ngjrF/fDL9WkHPKx2aMtA83QRqBY5c69eL7Rvg65Fb1w+fAg7PXL+Hum/YW4O3bAxBRiINmR3S8mm9FBolT/49kwMF6r0PnSd5KzXXdv8dxviLyaI+r0ygxgGReqC9wBPhveUTrVe1L07X1wu9z+ZL58i07uNJtE9eU5sBiMGrYj5bdDFBtO2Wa1u2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVJhlLwRgk+sRAcxmo+ThWXjZpw84B/eeZbKujHBMTc=;
 b=NtI/TbT3HJ4lTqzaGxNGikcn58RBfmS+f5Ocbp+sRXFgR1LYZaGZmInJKUkZNfCWoGgUTlTihitIRqTJ/wc9JAMU0IO13K7/6ZNhDhBpvyYrpXQRQ5shXQSR8WsGs0bJX15abRLyYWA6Xfyg0CVsklQ+BAo7cYWFX59VP0s5qND/vBOc76pqHHgDpIS+H5BTyxrdKiKG/0bz2r+GCoe1odoU6HBMYXfTx5Rl8ogN35X7jE0GbdAvVsUbnK8fS5E44bxWOnwfuTEXEyUIYCDp7EAZ7IBVMUkRLTFVoK4S82sNl/MHGwVEsYnhPvvcDrsRYwobNRxWZ6Au3WD+T29AhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVJhlLwRgk+sRAcxmo+ThWXjZpw84B/eeZbKujHBMTc=;
 b=EfRgmvSnCZgyPzeY6s36sDQGHSt0pvIKEiy/YW94yzoz0al1k3zGT2g4M4L/zPU82pBabldlY5AU+3qBoP+S2RkSmkbt+wzIFTrTiXzhM5DGOY+7bEtVLOoHtav6ZvOFZLKsxMp06FCJAQSMwgCVL6IlGCpOKxbXow0e2w3yRYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:04:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:04:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 5/5] PCI: dwc: Implement endpoint DMA channel delegation
Date: Sun, 21 Jun 2026 02:04:38 +0900
Message-ID: <20260620170438.3756593-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170438.3756593-1-den@valinux.co.jp>
References: <20260620170438.3756593-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e23f3e-e214-4daf-a06a-08deceee0fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10070799003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3QAg/1jb+alBc+fdcQlBbleB7/V6KuXsBfuKrelDvgyJYr2L4AFJoF5gsxSgZ8rVAROlohrvr7DpcqLpm9OdGFLR8XCA5EywYjkOXYP+Q97SW4dxJVGNDlvJmxtHqOQODvE3+OtNev/kCLUpPUBAHvI6Lvddu2mOcUtPBt2KkgVZkl9MhDd8/UjttyuPbqqsp+tbOqEefi/gt86SRBB/SEaSwLjTfhD+f55NtqUiWrq0/QkI4fCiLfLkmIjNZyfiZCJIYXoq3LuevXOttBT7cjkYh5LZx4bY9sCkM0nbI6+Vv1kqOv2YTZhpYtWvsHx6TGSPb+qmpCuGv2vn7h+qTnbLkFi4USa5iO6PrOAAzYBwHcohYwlvesS8DVJlWLp3jRkRS9bzOHMTw1sJfd8OsM4synWpkW3sDjklY/99oM0xFIH/IyfR0sukBvLLHyrOJ3B4an5WemtaBeEegwU6xv7fH1YFZIdx5pPCGzhGqiS2vFkfBkelCagQ/7+Lfpf3t3OfIE8cjRrcOr64qqPVl3GCEuDD8dAM5eTeomjP0FzpSdBE9FhA3zu4XXeQtL8uVX169zPwpTaVw7WeBqSlRKDh9PDUvDSIhqsNIOfg1LMd12OMh1oQVYE0sJrdeBN3Uzmkc2PXrPHsuU48tty+rNopRPriLHVzVz5o2o5VSls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2EosV77GkIlJMaGoKg846esj/An1M1Uhg8CavjzOxpa3IkKs42hKWg5fV9bI?=
 =?us-ascii?Q?CuJcEYSRT2YxFqJdRgYktrAFaALhqfYJEWPUPP19+nDOgz5TNdtTZvgta9F9?=
 =?us-ascii?Q?wkUjAyWxrH449j5k06y5KDlIW2V9FoWHopOOHmk7ui84CpTJ2uTeS0G/vGP7?=
 =?us-ascii?Q?qROYSjwxr4Ze4vYOICi3e6zHXBsa9SaNdpZDIiRTN9JkVE28stWP6sefNuNH?=
 =?us-ascii?Q?BNVoQczCTHM6xen1wsOPPCEQbpxo6tLWaf3ueIZwVH46bc2oSdOfmhMRoQ2j?=
 =?us-ascii?Q?VBvVReBRrvjnJP3KAnfhff+t6uLNg0DGICEbHrzf73RBhCjFu4CAUZ1oJuUA?=
 =?us-ascii?Q?i1gPx32lBL/DCi+ireipiKimA020C1xA4MBlhIKDkvSxJf8DNeFE8GUWs3pU?=
 =?us-ascii?Q?RPXxyUTm9PmOu+1fzoCcjnF/EkbYDk2Ho3r/68KblKPAiU0BSplpEfjcLnPm?=
 =?us-ascii?Q?5P8XWPxNyIhw3aQcBp0eVAR2c42ugh2ei3fJklY1vr1zJGwnZUNFnrIux4Iw?=
 =?us-ascii?Q?H8MZ1s3aAwv0jiE3ySBDvvDFkRoaPewFY1q+1dPx9qIwYIWqesBVX1GZATh7?=
 =?us-ascii?Q?ol9tvrsNAt5jMPwHOzwZx45f8X+/4Evbxpwv5UjbT5TOzu5LWeNisqzGJVKX?=
 =?us-ascii?Q?TuH2Nuu2v4o3J97bPETK4fFxOPqgXoohl0WMtkxsk0eXZA959V1m1oCkqXMN?=
 =?us-ascii?Q?6SMgmD6tiyYEOC3izLT/s6ct/R2Kuf8Z73d/xdUE9VzPmpmLVfCi6dCnJWCw?=
 =?us-ascii?Q?WK8aFpWiCBijCN0o/9TLLZup/wzy/rWe1naxfyaLyEo+9wFqSXyp+ZAlDhIQ?=
 =?us-ascii?Q?7BTKx4rajIDtihCAaCKnQeqCjXFIR/e0q9yb2vBLWQ0J/LpZ6gPkoMY3eqNF?=
 =?us-ascii?Q?IYPNqWEFcaNLSrKDi72ERq1jwA4R4rMtM1mvkq2CTcR0crcWW5aR2SzTCNe7?=
 =?us-ascii?Q?bGJICrdUKuAKtUUHfBz2WBY5zEs2c6cTJEAH7qqL43+aDN05Z3Ps6BGGWTPv?=
 =?us-ascii?Q?kmVXja+pBidNkBGJjOzEOvT0lRkqsUGv7dDF3JN7lJ1UP8k4Frgn/gIRffRF?=
 =?us-ascii?Q?HCNytPdTIeSDLDYzommjxawZHE1qotnd+PlVYn3s3UiD1rUY2QTwM6B6R+9x?=
 =?us-ascii?Q?UpjtwRk7BlRTNCqcHf9kae4WCSX1ubxOTHZzjMvutvpTOX5eX49wulWC4fAR?=
 =?us-ascii?Q?29WOKoAy1HbauhbAa6baSMbe/PjelW5aWy2McJ7kGeX1LoYDsg8A+42hvJJQ?=
 =?us-ascii?Q?E5CtJ2E3+qolDIYJpk42E9UZSSDrGPvweMSEYQ/SijbVWLcwg2SyaeBn16rM?=
 =?us-ascii?Q?KY002xNIrguIYvKYRT1kLygR5ydYfB0rZWK3n1fbdsZN4/Ts2f1M3G3Tc58m?=
 =?us-ascii?Q?1QREtu3RTj7CkylGD2cncBD+BGPeOdYkS2nQaLZiYROaM6LjnpWzSm/EaztS?=
 =?us-ascii?Q?gv3OevTeotCOeTWEVZcYDKgBLK0NoiUBupeX1KdAce4NPVFFAXD5me1oH2kt?=
 =?us-ascii?Q?8bkbSSTquuREt0ipyYQ0pIarmU9u78y0/ioZIxM8/K/xCGFBheATJwy9wyZ/?=
 =?us-ascii?Q?bmjJ0CdRWf8ca+K0v6x+dDimG5QLJE8Do8aeWeSHrNS8R/1WsXzlaMddbiM0?=
 =?us-ascii?Q?MJzYhp9O95kqSKV9gRQJajarUdsXyEF6l/Z2ouysftGEqtBXH/Yrn3L+RpNs?=
 =?us-ascii?Q?KeMV/iJDyTC5LBqWllL0Ld7NQvyKDlqOZlIme2UC/50DpHUIAtzXTNE62bZt?=
 =?us-ascii?Q?gAHA3t4DYN1PdgucIRpC+6XQ8DDbQk59cKhA87peich/NN7P6lJ1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e23f3e-e214-4daf-a06a-08deceee0fb2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:04:59.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WjyGZV4i3t3tPrkbVdnyYC2tBKvd0cRAS4fTJ3XVfo+e0tf1tjcIQ5T09XvVnUJjGUw1myeEHz+D1nkHMBMjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673

Implement the EPC DMA channel delegation operations for DesignWare
endpoint controllers. The DWC backend uses the local DesignWare eDMA
provider to reserve the requested hardware channel and returns it as an
opaque EPC DMA channel handle to generic endpoint functions.

Validate the requested direction and hardware channel against the
linked-list channel counts before delegation.

Limit endpoint DMA resource exposure and channel delegation to PF0.
DWC eDMA/HDMA can generate DMA requests with a programmable function
number, but dw-edma does not program it yet. Reject PF1+ requests so
delegated DMA channels do not issue TLPs with the default requester
function number when the endpoint function is PF1+.

Reject VF requests because the RC-programmable DWC eDMA/HDMA register
window is assigned to a PF BAR only.

Reclaim releases the delegated local channel through the DesignWare eDMA
provider, which returns it to endpoint ownership. Propagate the EPC
quiesce request so bind failure paths can release unexposed reservations
without touching DMA engine state.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch. Implement the DWC backend for EPC DMA channel delegation,
    replacing the v2 DMAengine filter-callback metadata path.

 .../pci/controller/dwc/pcie-designware-ep.c   | 84 +++++++++++++++++--
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 770cd7efe699..ebf3db4386b4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -878,6 +878,26 @@ static int dw_pcie_ep_check_edma_ll_regions(struct dw_edma_region *region,
 	return 0;
 }
 
+static int dw_pcie_ep_check_edma_func(u8 func_no, u8 vfunc_no)
+{
+	/*
+	 * The DWC endpoint databook says it is not possible to assign the
+	 * DMA/HDMA registers to any Virtual Function.
+	 */
+	if (vfunc_no)
+		return -EOPNOTSUPP;
+
+	/*
+	 * To-Do: Supporting PF1+ needs dw-edma core support to carry the
+	 * endpoint function number into channel setup and program the eDMA/HDMA
+	 * requester-ID registers.
+	 */
+	if (func_no)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int
 dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 				   u8 vfunc_no)
@@ -891,12 +911,9 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 	if (!pci->edma_reg_size || !edma->dw)
 		return 0;
 
-	/*
-	 * DWC eDMA/HDMA register windows exposed to the Root Complex are
-	 * assigned to a PF BAR and cannot be assigned to a VF BAR.
-	 */
-	if (vfunc_no)
-		return -EOPNOTSUPP;
+	ret = dw_pcie_ep_check_edma_func(func_no, vfunc_no);
+	if (ret)
+		return ret;
 
 	ret = dw_pcie_ep_check_edma_ll_regions(edma->ll_region_wr,
 					       edma->ll_wr_cnt);
@@ -1043,6 +1060,59 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
+static int dw_pcie_ep_delegate_dma_chan(struct pci_epc *epc, u8 func_no,
+					u8 vfunc_no,
+					enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+					void **data)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_edma_chip *edma = &pci->edma;
+	struct dma_chan *chan;
+	int ret;
+	bool write;
+
+	if (!data)
+		return -EINVAL;
+	*data = NULL;
+
+	ret = dw_pcie_ep_check_edma_func(func_no, vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
+		return -ENODEV;
+
+	switch (dir) {
+	case PCI_EPC_AUX_DMA_EP_TO_RC:
+		if (hw_ch >= edma->ll_wr_cnt)
+			return -EINVAL;
+		write = true;
+		break;
+	case PCI_EPC_AUX_DMA_RC_TO_EP:
+		if (hw_ch >= edma->ll_rd_cnt)
+			return -EINVAL;
+		write = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	chan = dw_edma_request_delegated_chan(edma->dev, write, hw_ch);
+	if (!chan)
+		return -EBUSY;
+
+	*data = chan;
+
+	return 0;
+}
+
+static void dw_pcie_ep_reclaim_dma_chan(struct pci_epc *epc, u8 func_no,
+					u8 vfunc_no, void *data, bool quiesce)
+{
+	dw_edma_release_delegated_chan(data, quiesce);
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -1060,6 +1130,8 @@ static const struct pci_epc_ops epc_ops = {
 	.get_features		= dw_pcie_ep_get_features,
 	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
 	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
+	.delegate_dma_chan	= dw_pcie_ep_delegate_dma_chan,
+	.reclaim_dma_chan	= dw_pcie_ep_reclaim_dma_chan,
 };
 
 /**
-- 
2.51.0


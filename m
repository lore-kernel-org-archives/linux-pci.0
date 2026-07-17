Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020124.outbound.protection.outlook.com [52.101.229.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02055372664;
	Fri, 17 Jul 2026 05:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264815; cv=fail; b=TQJUVbtkNuKXQEhclT3UmRoWu1yMCt1OMlnpBczGJxn3w3DQZwnyNuhTXCpHKOf5b0oYBjosnu0VAmPtk/XwRJ15f2lR0M6Gf0BymRO4M4v4A437EvfGLbPXC3w/miWmRDNKlyZpSEFrzXO5paCBjXGU/dhHun1btBp+O1rY5vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264815; c=relaxed/simple;
	bh=IssKotjfoMFZB11MZIPs7fDPp1QtHSUGoDpk2NO3qBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jIxc5d4DOumRCDc8auXr1Eue1I1bl5tVqapKhYDGXzILQOJPvp5c2o57A8w5DrhxmSlLdAxCMq2n7dUC4YR86XtNbRl/T8CBPGJ1uzaE45iSOysLxKaMm3fjcaQq4OB/+TPf8Ma0bBTzrKp5VMRaPMl+BolX3YXKTHC+xco82NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kOrLSvsy; arc=fail smtp.client-ip=52.101.229.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kOrLSvsy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoiLd+5rHA3xBLQvf6F2WnX1Vu+7qdLe9NF4KfSA9hfPKC5xiZXrjCqdrlmUItVeL6uuf4fboE2UUIc0rEOjuzLtsksTx21o7wUI5obBPbKDEQ3hZYpL+7h8Y1/NS7LyubR5XUbLduS/6SUfH+uGwJ0cdjqnapoa/VtqWPMiLdNArRzTjTWRvvsi1WE87NzsfnrVnmjyvgc3KNMY/RwUZWvzf43zhDWQzO7jA3wk+jVGe3YinUHCcjV5b4lKA2A0jswGnKmAIgyRvq4mnTT8sRWFIHK8X1DRmK2w2u7XloYKz7kvhkUDb5YRNRMfBfYeWYdhKHP5Ck0V6MwN2NpH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afVnmxbRjzzz8GTduBcpv8XnnRBtHGEjeSdSkeifgQQ=;
 b=KKJNrmX4b0iNHBOCA10WI57wXhXlV5J83IX86H7OMfedVyawdrk+6y1C4S5qOeZTd8m7UTtiAJxtWKa2jlSJTTS6tiizE9qQuHjGVi78jdwJebLHqES0KbWm2Z7Iq5uqIViLu/XnnR65bLKNyht1tOpBLWztXi98D2OIwO1d/nLM3aPkT0de/AoGTPGSlyW3dMa9X4U7zyp7ehVNbAaH+fHH9W9obOAXm41pGE+A0FrPCPR8orH01+1+yL/4Bc8d4gdJfPYntKV2dThF2MlWVebUpu2MUNDMWpp77MlJO2Nc/IvtZhmIPTlssM3IN88LHfF6h6x7/9nAy/xXALk3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afVnmxbRjzzz8GTduBcpv8XnnRBtHGEjeSdSkeifgQQ=;
 b=kOrLSvsyFmE0eMeGfFVnrAd4kmWCoU0JopUlaNo7zlVgsLN7b1InA1kCU3gH6HygpJJo6s4XcuNPKrpDnt6z4HBwYKBLI5DsGjKeyvDg2LgRJLhJJrqWQd4Ncx6MaxBKoqBQv5EyOlfpmYPXzZ47Bulq3ss4toXE0TuK/fdSvNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6910.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:06:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:06:44 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 6/6] PCI: dwc: Implement endpoint DMA channel delegation
Date: Fri, 17 Jul 2026 14:06:35 +0900
Message-ID: <20260717050635.2145014-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717050635.2145014-1-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe9c379-b258-4916-fcc9-08dee3c131eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|10070799003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IPHZZaT4esOVB87dOUKO5TZxjJIBfQKnjL/ZTk23j/1jlmFHZI4KwKpHw4GBdXMRfW7CbA7rUHNLD2PuV9rPvDe8O3fkU6/x4LJ4nhmGRYsTIN2hqCz3zSbsslKHj7ljsLRykoz5nH9ajm5svNVYkXKb72a9egacC9zBVohVHdD8e5ygp/MLXdd7wpRgn1m5ZDcg5z2nKHMLPdrZGZwTMuNmKHgF9If1wBfIwT1txPiJH9P9I7gEOBuAmREAzAAF0BHZcJMm+HkuSwM4P/cxeUjPYjgYbVKpytL/IpB/fR3RM9dmPSlVo44+31PCi1QdP7uxG9UQlHq8YRGE+JQvRVMXzBf6U9pm3yhDHDjNmfMugahH+dRObTh35QIELGeiULdfx2DG/RnTO4APOQE0mJ7WhnoU9aSFFbccNIlpfaA1qRN1G7y7twLHg/QW9Ey6gqVHHFD6eGIImMcPwMzEN84s/Homuj3ys8XlTIZsPdCi5N2N7HV6ir2aaglWvxltfoMmmY7ETJc0Lm6PTpBmxeM4KtqSKxWBGwO2yInaRWxD+5OFgqPN4/3Bj/KkM8cXZYbkvASK1Mbha+bkv4noMG7CvkjG9P+na7hV1BJ50mP1+RWRCy0cCqBXqeC0HIyUP8s7HjYepoSZ9shrEq5L/B6WjrsHg9y03Asby7FJOkY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10070799003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dFSd/iB81LcR0yU190p98QS1ltjTT42EC86gMGXkqNgAW0qDlCrPE9L9r3S3?=
 =?us-ascii?Q?r9RpUgTDa6uj8D8ytgXnh3eKFePHJoi+PCiCEccSeZ+1/LOfGEr6FMNlg4hV?=
 =?us-ascii?Q?3YHvvm13TIPRPK6WpBdZ1WnKRyb2NIEqPjGqjuYyPg3qvIOi1K6IROi8DIYS?=
 =?us-ascii?Q?K5WhZMgQue0ElPympQShHTFAH/+pTu5KRK2QNYyxSXTzfBvRwWNltAuhKGTh?=
 =?us-ascii?Q?VtlA3kQzo0Qv+Ttps1LXdM8CZMz60sSe2GhMQJwrgMsrDA+TWl7ltjJmMKAh?=
 =?us-ascii?Q?/1v054Mpuamm4lJudyHcBevaf+cvjqr7IuRT5mdpHDrUZayTzZAmPVV42/N+?=
 =?us-ascii?Q?Lr7vLCqfztV38jJc9svLW/Hr3XcavFtz5IhujI2vxaXe8jQ6ZMyj27+7b4Kg?=
 =?us-ascii?Q?W/NGRPYF0YcBUrXS20g+PLe9CBKF5KGloTHWwAMsOJgbLtrjzSA3LGrFN6gs?=
 =?us-ascii?Q?WyHr5MZ0p3Q6nUGS4/J/GBfh0HJskXIkvr7Qd/QjCUBR5FSPEK72W5iPxDyq?=
 =?us-ascii?Q?kydx2n4/BY7Eei5b6XWDbuLtFetKnma+ueGcZbs9cH3ancQp4rRyY0QtAFHf?=
 =?us-ascii?Q?I0Q2irEVrMbXgwUvmJCfUiM1n34aiDpC/s9UEdWQect2AIZ3dtOFVkFI3Zg3?=
 =?us-ascii?Q?wkJYP9AmrXoI+2Fuuxwj2/ucg448TRrIurVLj8HMZpHxShc6D1hP1Jrr9XFK?=
 =?us-ascii?Q?XKcuhKDzRZJVMf38GOe5d4ODQB2FWrAA7CgEDdcDYYQmEx8cQiTOAvz1wb87?=
 =?us-ascii?Q?ISnz6Cf7ZCG7x227Clx/hjteAFAItgXs+7t8r0TeAB9t2SZYiMA+pzSuKNok?=
 =?us-ascii?Q?blLGp1CcR7SRNS7kAtY6XcbvYyGlL2KWEHEmYCI+DUJkIwxeo+qWiIQsAEQ2?=
 =?us-ascii?Q?MhsYeXTzKT2eGX9ZBY/wj1a3GRlL0bnvM4XSONCgj+pDJl72dOR38kMAe10p?=
 =?us-ascii?Q?vohyazhTFO5CMoTCSt9LjwR4iAZTML9bhMiC2Mr9BEoWYtQKFKU9VEX6Ujhf?=
 =?us-ascii?Q?iZoI4tg6NNteBarDizi5HvhonSSG01fPLBctJqzd0Kp8tAqDsMkI2QKWq/KZ?=
 =?us-ascii?Q?1hTAdNn/OwA3luhNUCYyQrDqNAyhmtJt+0MNnjcJqgnwWrZS2bnQxrFv2JEV?=
 =?us-ascii?Q?geC8Ir18vyhGeZrjUFz83O+6/x74uPqoM8j+FdDouowdvu+crdIunUoWA0tp?=
 =?us-ascii?Q?eBkZMZJiRdEX0femxR0yRNXD6Q7mVhA8blHOdk/xhIhA6NvWX+BN/TDvii7s?=
 =?us-ascii?Q?Z7N3WDWDhh2+16IsIyTp+y+sXu0D+n+9ENZPlE3N9oQQCjRN9fsXbnsNIi7a?=
 =?us-ascii?Q?CvabNLJx9A1xgHr8Ciwaj1YtVjNK+am7MxrY+x/87aL0E1Qt1CtZt3sR9gd2?=
 =?us-ascii?Q?H/IE02/3ZxxY2wBCv75CEwUUDCdODOBCNiJLDeg1+MfgUUJ/yAcNMhGIs5BZ?=
 =?us-ascii?Q?SDlrQKDT53kHq7fIJK9RdbeOf1O7FmLm7Tl2BeutXAlWkW37tzFJp1Umd7rR?=
 =?us-ascii?Q?K22669USO/iTZverj+2Aq1W/6KnDPac44s//STrCvzAe1iE13PGa1lmXI7pe?=
 =?us-ascii?Q?hKxl1wXEfTi8ZW8KRwh0/k1RwlLXr9S6d0FmMLA3A0U8HwkS88H0vfvWg3gf?=
 =?us-ascii?Q?Osgafxg4o/MwrCuOE018F/bx+ONS6PkuDJaELifxsix3TeZw2LmpUTQdu0Dd?=
 =?us-ascii?Q?EQIBc1qf9NdAwwgk1raqrzd7TChAdvYYKoQEHo6TkYnPYRiiZOXTy8QekHM+?=
 =?us-ascii?Q?9+dM8zjQIwKLSo2MBzkwzHZAWt4liYqQZ8LgZukt1z9hehj+3yjG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe9c379-b258-4916-fcc9-08dee3c131eb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:06:44.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXxXk7VciBW+1njaXiyM4hjg6/RgnDuQN/AWEIRKXO5nqX0HZgWeX1TUitBCQkeTv+8NcnFqT+nc6eXBvPUOTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6910

Implement the EPC DMA channel delegation operations for DesignWare
endpoint controllers. The DWC backend uses the local DesignWare eDMA
provider to reserve the requested hardware channel and returns it as an
opaque EPC DMA channel handle to generic endpoint functions.

Validate the requested direction and hardware channel against the
linked-list channel counts before delegation.

DWC eDMA/HDMA generates DMA requests with a programmable requester
function number. For delegated channels, the host-side dw-edma-pcie
instance bound to the exposed DMA function reserves the channel and
programs its own PCI_FUNC() into the per-channel requester field; the
endpoint-side chip func_no does not participate in that handoff.

Reject VF requests because the RC-programmable DWC eDMA/HDMA register
window is assigned to a PF BAR only.

Reclaim releases the delegated local channel through the DesignWare eDMA
provider, which returns it to endpoint ownership. Propagate the EPC
quiesce request so bind failure paths can release unexposed reservations
without touching DMA engine state.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v5:
  - No changes.

 .../pci/controller/dwc/pcie-designware-ep.c   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index ef1e2b6d85cf..13ba3122c9cc 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1045,6 +1045,59 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
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
@@ -1062,6 +1115,8 @@ static const struct pci_epc_ops epc_ops = {
 	.get_features		= dw_pcie_ep_get_features,
 	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
 	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
+	.delegate_dma_chan	= dw_pcie_ep_delegate_dma_chan,
+	.reclaim_dma_chan	= dw_pcie_ep_reclaim_dma_chan,
 };
 
 /**
-- 
2.51.0


Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021078.outbound.protection.outlook.com [40.107.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B13ED3CA;
	Tue,  4 Aug 2026 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814750; cv=fail; b=H23VbmPFEN315VhCC2fRAMmLIe+/anPW9ojbeewN+PNopkQOs1wuMASGjN7DruT01tF5uuOykHSyUlioSjcWH5o9rbWEk4lBhvWZjfzvCk/X1nbvr4lr5LMPa5kse0M/gef0G/h0z9nvFsf6+fMDXoOF52Tg+uMBBs1C16kuQxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814750; c=relaxed/simple;
	bh=gyr4FullsdeIom1tMa5sEV0bUYZRWAqbid6CZMJDzG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DON0b073ikfRMkj/k1cKQSdQ3a3mV22ZzhuVpU9bzWSI49neWBkZ8xRAe1YBpRUTSbb0erdkt5rVoe3dOcAv3yMAm7Mm6kngI0DZ2rtrdZ7x5vvvI8M2whuawimpboTcFsOXiGJCdigit1V4ERUtzDaS9T5mhYY375WLDLeuR7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mMh1RlMs; arc=fail smtp.client-ip=40.107.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mMh1RlMs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYTklIlXBOVwTlEPFH5LIomkUGuVSbO61gkEZOfJ2r+dgQrG3d1HPUuAAcYFZPKqwoQav50VDmHN5v7nezLxdnvfKwb9IiE6SXYIrmsLBfSUMwYIUpZtu22CF+AA29TA/hnEk0zOz6XTaIseO3qBrwfA9qpdQ9MNqD5gHn66CH59gTeawBcrTROgMhMESjlVZdjjNfy5GaFDE8sFFJUTETjnORunHXtcgoLLtu1M0T2aiA8P+Dekz/Hov4CaSfFknU1MzV8mCxflG+z1YvmKAGiFINjt0FB/2hx5/96SgdaWeFHg3Ut9suCh5eV9JzqBpuQ1M5wBW7I2FRjEzPgHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PxYestfz9Q2ZRWymvvfRrRqKAlqtbtbtDZZ9N58PI8=;
 b=xgmmKxdyGvwzwgVsYIzUJjLaMJm1ZrjpB2RpioJjSnlDpSN7RMOstRvuMvcUi/TQwmm2GC4zstMsarWtPFwMXjN2QhskkmF2G5PfM13EUP1J+hH3ho+TJTiLbcWCo/cDyQ9Rkv0PsfL7QICZ3YKtWhm1tbEaVWIxtz3ATzWiGbpueau9NZd8SZm4SVT86fKlaYAIxTs4zQn7n95+UdpZpmRKt+KRRM3tFVyxkj1QqNJ6paxL2jrzOQy3zq7o5SNFP6YRcKWs22eNltIaXZ3qtSwqJHqZh6zA/DJMBlvRL/NrjAjTjeEZZSq8rX/9Fna4U+3Lv+Zjst6nBZNwBT9vFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PxYestfz9Q2ZRWymvvfRrRqKAlqtbtbtDZZ9N58PI8=;
 b=mMh1RlMsAicrVo5ez/VUwsvL8vi7x+I6RFJso5J8mh0Tc/AR/RvuGMK9rDxXWfoMfyhzrGP4OT/6eJbFkZntkTPScYAdiFvIoxMjd+JG7xDpf/OYSRZNxRDt/Cb6RD5VjZnb9gAbikaM6K26jlezkdDOpsiqX9R9Y+StfN1JiT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2080.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:188::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:39:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 03:39:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/6] PCI: dwc: Implement endpoint DMA channel delegation
Date: Tue,  4 Aug 2026 12:38:54 +0900
Message-ID: <20260804033855.2115817-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260804033855.2115817-1-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2080:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cef6d7-c129-449c-33c3-08def1d9eecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|1800799024|376014|366016|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kYeB4sL5JLzPuGl1oyqh+XcYYDJIdPUvyvqGT0Cjg63mAdBsgSNty/UVu5PJVeDDSCVatUK/DoJBoFh30S6P2H67W0IwEakh8gzDlC7mppZJ5WhcEES8yTTnjwkxlNpz3lootPO4ieeOb67EetgWDB31hhEF63CoEzFkO8mMlRD2tZfQtbbqKEiPDFebPGHtCuF/5yNW+cO0wZtimg1dlnEzWYl3GsITD3vFYL2U5S6nwiAAr9ioZm+FnU2TpzyRaZ7R2JfA/W6wSjWY3o2KFvCKmh1NE4kv2Ii0CbLPKxI0aZk7WtICHkGuzqKG66tgg4jtEsynppZ/Z2sZvaeU0zMGRiTSp4GhdFbQnxM32BeanrfsiJuJIDTRTb0BRNQ9caXUngc6s70DL4b+hVyiVEBIykbjlUroaunIcO1Op8Cihi9TK6l+lR4ucdAUiiyfRmfoW66mkN5Iv9g/XlGCw6Zkz/18pAGySurXvrUtCTFO0uWU3I9r0J6QgVuCvxbMpfzKtqr7WwvUgDlDQRaZPZrjB76o2IJ1fKwUl/MbAq0WI9SKnajh/LupvadXm0XW+jPc5EmxxDldnUqgE64HfqrQ4LP/CmFjh0QYDZ8eD3DPJqEEWPT00i3T0s5wZWI8UOt/Vwr1Q6cdly5NoiVxa+vyOzqu7E3rUEH7mPQrFfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(1800799024)(376014)(366016)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n2EWtzOsnmquZoWXtQyFT59P9zGJaIApcngpwxv457beKR34ARLgTfriNSsC?=
 =?us-ascii?Q?O8HkbpMaWLdKnNVYO4DgzuSCx+JFE3b8pvl5IYQmzv9MZWjqzWW2NuEe+EAI?=
 =?us-ascii?Q?WRoIzwk3EYo96E1J8HqFrAIPNch3YRKZVRvYK042EeKEWehlboGb2kLZOg1G?=
 =?us-ascii?Q?VdUAvx2eu4u/zAZlc7CXj8J1J2dpNZXUPn/p4iPjjKujUg5L9WncNg5jWouz?=
 =?us-ascii?Q?WnHIALwvJEaoAIYPyawI+BEVuSHWDZiAH75rFx1gs2ULeGUdvs1zZi20QzHH?=
 =?us-ascii?Q?ESzOvLa6VgGMGoT8K5ENrN8lPe7YtdKTNCSA2BCaS5hrEHcahyvg7tW9LXg8?=
 =?us-ascii?Q?D/36hAfi8UDOajicHc7Gl9HQBR07L6sX/VnduuCJmb3X4Bpxhmx/ECvVSUTZ?=
 =?us-ascii?Q?UwqkGsi9JLnbxGgseFTBSxnAJykpvAsk2Tw9rPYbX/poFuNLygKo6igg5B2z?=
 =?us-ascii?Q?kpHfP75IgDt7to7yykHXaOh/TljSAsr+MIdWQpytMh2668J6/d9tbneL6WgA?=
 =?us-ascii?Q?NAf6SfrqsyM6khzjAy7PEKiZpvMf/cp03s/icCSGiBD7DkiZGKh3jKlHqu/Y?=
 =?us-ascii?Q?GBRCijk3GLukQ8tC2xzhEXZ2p0sTSEg0s7plGxou+snfGiEaTI2XQO/Jp6cq?=
 =?us-ascii?Q?MefT6m9DM9sarYR1ET+JddvNlra8E6yfUwDfOW6cbXP7vq7s4xjHTJ5pIOvr?=
 =?us-ascii?Q?YpOt2xHQ/uRENGMsY4Ww8mURgcHp8YxkDHezGNl1hb0Tl8uZQRpWXFDDB4gd?=
 =?us-ascii?Q?iU16QsRc9GkMjMnYten1pYX3wtC/pCOlXqrLLEaZh6JhqBUCCVAvXNXTHlWr?=
 =?us-ascii?Q?SQJaT6DgNonL4rVYZh4c/6d1SMvwhyqv7MINge+nM6xqjB+hx5fiu7slDGfI?=
 =?us-ascii?Q?Q8RuGXYsK5y8W0TlM81IUTOpOWykM2zdT+r6BhPjuYiiEzXATd3XWFtEK3z6?=
 =?us-ascii?Q?wkNIxCBwZF+r+u7zEfcGnD9eNYyIh5EUS920Xd1CS6v/puASeg22NoJo6AGp?=
 =?us-ascii?Q?yuhx3RNsWCoOTCeGzFlrSTk8iPGAsLCMYLjER1ifluQiVy92G53fkjRXnufz?=
 =?us-ascii?Q?WV6Ehhsv3vkeS/IioyM3tYtkAgx1rmNnI3U+B2Wo3wFE97VDRcIWhk4TVWV4?=
 =?us-ascii?Q?7izzimLaLWHf9q+w8mgFqhIkcPhWm7gcF0kze3OG/KNhcKoja6SCWOy9soDA?=
 =?us-ascii?Q?e/tFjItdVp7p+Yf/OPZy555xyJc3c4jXHq+XleaxvZiltxijyrmLIXvYDBy3?=
 =?us-ascii?Q?e4gS82IbCNnYMnSLoQEi+vNQFgfpauabOHnBC8QvVCAooRvWXiFb3ey4DGkW?=
 =?us-ascii?Q?D7HU/Tw26mmZN5vbz6pd+Zt/y7x/ETYhj9NlLHiw3HYsRzO0NnTWPJh20F8m?=
 =?us-ascii?Q?SZhxVYKuXa/cqNvS6WSTSR/pqbvyXKpUG70QzX44h0I9VDWLdM8m9nRuQIhG?=
 =?us-ascii?Q?cMCyKw1DLlRfWBGuXtAqL3qUQbHRUdJwf9C8hHxkvh3puVs510ailmwrZz/a?=
 =?us-ascii?Q?BOkLvL7QZnETgNr1bmCabN2sUCcX2ccwbIlYoOCq+M0KoTyOvxqVIk1uowCZ?=
 =?us-ascii?Q?EWg0HXQVBLIyQ60Rz05g4V8jKmcDzcoM2eoHvRnF3S5B1Lfrp7Vr7XmpMFn9?=
 =?us-ascii?Q?o+EqeQGJMzzbC2NyH3t0wV7pNg/W0mR5MgZnQDQLYGxVTCUM5hdnMfP6czaX?=
 =?us-ascii?Q?QgA9Q1WFWMDACMW7RGHjf33LOeWWlOH/6OiEswE+aCm9i1TXXR36OYH5yzRJ?=
 =?us-ascii?Q?JPCXmIydUwo9zlWXRUgQewNLPtMH0dr28rWyH9vTuBvgKyq6djxM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cef6d7-c129-449c-33c3-08def1d9eecb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:39:05.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jj63sk04fyNmTc/sVI0vYrpq0KmsDFwFzMwL1nTyTSZEuL2OB6cXXm+RPpyPUGeT+wZjnTJLvjcc3KS891Gtvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2080

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
Changes in v6:
  - Move the shared VF check here to keep the reordered series buildable.
    (Sashiko)

 .../pci/controller/dwc/pcie-designware-ep.c   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7d2794945704..8c1ac9e3c517 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -858,6 +858,18 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 	return NULL;
 }
 
+static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
+{
+	/*
+	 * The DWC endpoint databook says it is not possible to assign the
+	 * DMA/HDMA registers to any Virtual Function.
+	 */
+	if (vfunc_no)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int
 dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 				   u8 vfunc_no)
@@ -933,6 +945,59 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
@@ -950,6 +1015,8 @@ static const struct pci_epc_ops epc_ops = {
 	.get_features		= dw_pcie_ep_get_features,
 	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
 	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
+	.delegate_dma_chan	= dw_pcie_ep_delegate_dma_chan,
+	.reclaim_dma_chan	= dw_pcie_ep_reclaim_dma_chan,
 };
 
 /**
-- 
2.51.0


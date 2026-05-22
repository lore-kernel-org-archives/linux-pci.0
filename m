Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BAE3290AA;
	Fri, 22 May 2026 03:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779421304; cv=fail; b=rgKM0oscN4DG435P0K7BqPXT61dnHbEZI/rPuRsrnVlAlOtAmi0yePhg8QybP8+UbuuxJVeo1ew7N9ZINGD/Rb3YUJd+g90QlDU7YATizHuXvP0hQgxWGqpnPaDAfJ02Z9U1lHZ6zenoZObem2efBoGYfrPrS//NTij1IJ9TvGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779421304; c=relaxed/simple;
	bh=i8LMFaiEyU5MKc8emicnRO60/dngVew+a7BI04rUARA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cl5eFiJbITI//w22HcfZ2+jnoLkECBWPY65msQAdj7R/I90GYqmf+SJI/bzK30Xq5c6s5666GGlinRos478EMU31RB7UvPHnDZ96kyT33E/ST+WTHrNN8LYgv4+HM4G8JssN/S+RQ97Xzgv7L9a08DKH5OAleaKsn4F8IWEJF7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=H1tGG6B5; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H1tGG6B5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLNq+1orfVEQeZjIP0uy5uHg1/gh9W3qLKoP/ik7I7sNBVHXThCp3XrdYn+kmXqa3fRpazJ5ZFbUZE8O7wrBMzkB6378dwGmB6XiodLcPolkQw8LmkxLrdW/3lr3/6UzV0vi0UruEIuG6NRqXmITy8vh+yU9Z973BLS4UOulUdtCVtuTHEFh67+wJg2J4RPTikXC4H7vufw86KQFhXYPJrafjbaMkSaMAd3VYgtzCB+Pqr1Grm8WdI1aV3CjZ8ddgMZAiGiCTBMTBoehSHdWBezMa15Voh7pKDOzVcuaB74sryizQ6GaxRWMRqKDSDlsGL+muOEWc0I5fTLyuD/GMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l8RC9hO25B/WmKiE6+q/ju208mssD5w0C7luUskjxw=;
 b=ivyFwWmgMH/5I/AF8EbUyzFrP8tjMv+jxywvc2Z9RnphOupj1jcuCNpOdVmoUuuIEQHgGlSqMYDq97OJrnAHHN+6CZoM++vSbWF5h3yIfy/+JRMLdgQbdesiGEMeIh+ua065kDcxNLyOxk/QYn8Ukv8E+Sa6/dgTDTUWSimIdoSBRCB7SYkj2vlfU1KhCm2HIin+asS/MvYy+nhIYHG6jePr3wIRkMMBFZXOpojT1EfqJwYPhjAGw5RaCp49nI4yupe53xWv4tBrnLiF1A3xb9d1G79TnwlFtpWoJMR56bqdPHMxWpSQOFUgWkSfvSzGgpAYj7An73KmE5nJr3HGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l8RC9hO25B/WmKiE6+q/ju208mssD5w0C7luUskjxw=;
 b=H1tGG6B57/w6dEcqEVjnHQVPQ76NQMZy+OWoxyEGEsyVTG+9+BRSl/0x8/UeT/xZfTcYCG72/174oBPiQoJMUN/PFgyLSNieKuUZvavxPRT7xqXkugVt140tit69xxkDUSxmylRBkTfs1S4svg450m4KyTMBXdk6R1k4mDblTbYIpc2GlEtkAFO2kr6OVK99zQp25JBcxjpP9hq8WrtXZjz2MD/d7jmU0zR1E92hlS+b7zhWkFDuaA3odUacdwrZa3CEPJKurfIPHRK4BdeO0oo9ugn20Z8aZUdfWDjHUBocdB/kaQL6qHrNR55y8D8Gr5PcgwjiOtkwlPQvmoKw9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DBBPR04MB7881.eurprd04.prod.outlook.com (2603:10a6:10:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 03:41:39 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 03:41:39 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH 2/2] PCI: imx6: Add imx_pcie_perst_found() to inspect the parsed result
Date: Fri, 22 May 2026 11:43:44 +0800
Message-Id: <20260522034344.1147775-3-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260522034344.1147775-1-sherry.sun@oss.nxp.com>
References: <20260522034344.1147775-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DBBPR04MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f87d73-b1a3-4b56-fc8f-08deb7b407de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|11063799006|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	hBkn5ztFrl7SENIFmXshu/XO7OlVMZmss4X9pXBlrpCak9sL+h3nEyPijgrt3g9RRX00Lbr/n4fjUiCd4SX5XOtpVFViFVajhSg6bZoIY7HSisatH6Ws89u7vfahaxv0YlncgUOFv8MAcWnFpLUARdKA04UDTLY0ZjjSCFVz8gzxTFH9GGI29wIc0sP1vaL0j2l2xBtpommHTeKdB1feLp1ySr3I32sXKCLf2GqYgkfl3mSUeHvSTAF5CfclnOigJQBdPdEwSK8Sm+Tu+hhR93c+YYIy+JNl9ohYIekliqcQdsav99Q3LlX/ZnJ3HN4O19G4qi2qLlCE0tJICYUDtdWmJ6SFmlAxkzOrogqQh0qJ+7QSMloDDAQYRW1GiIAgfmnmHRqHuhIxgTBZjKNvTOG2uBsc/wqEW4r+Af995CCvHf26bRh3kPpl84sD5cOXYk4+TogXir2awsJAZhvNrFScmEmzHf8/4TEG6Sex7vdAv2DoICZ8D51L50ljM9aOMHidHlQJXzh5wOTlhxtSMcU/Rw1mwAGEmr44u5+0FwtJj9LIBhdbVNoDMhgmkCM1VgvynleJcib2SL38cdyp4KdHqobco7E/EJNg+3pxb3CKxo/jO1tcoBaircsn3N4ugXtL+VPx658bH3ohOkR6seaBXpDF3e/W7X8k5d/8+9kPJpmaQvEMDdaTQyWK0aFL3VOt4QXW9/JMyyOujDOdufxbNa/GeORcNZlRbuirEP4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(11063799006)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ZiMMBbfLWMCU85mxBO3ZKOBXOxMUGZcGZT4ffVbNi9y72D7a0Bigj+ZrBG2?=
 =?us-ascii?Q?+/J5S/DrkhDyqXhBy12s8/jemTDY845axG8c73T6VqzH3mDqimiXrvnj+jjX?=
 =?us-ascii?Q?UoZyqVrwG5wsPBLCLqdKMYPYalSkJZauL8FQ2WdLO+Clix7V0v+IYjZWy7fS?=
 =?us-ascii?Q?j6XTd2E4sFbv+rT+OWjyXzWCPP1VLRCmSHshAZ0g9p1MxOCkifZMnZGqdur0?=
 =?us-ascii?Q?YWmRf5kOhNGZjtkI9n1KcFCuaQU3zZ0MIF5dLB2vh572AaOkfvq+hox2M6Zr?=
 =?us-ascii?Q?VjIxHkIweVE/b3eyEGsDNttO2HjVFJZHhOp/S5oULORazXE3XBldoqnfHqYR?=
 =?us-ascii?Q?m8hjb2v2jaBJTHCSa719i4Pm3gMJy4t1cooKBz0L7KEy+soI928BJHjP4BOR?=
 =?us-ascii?Q?xge+DcDj2oLblokSkkHdw19nTYK75llBXF4jFXObwLtyX0cp9PCBHJbhyKsO?=
 =?us-ascii?Q?7/8Rl7fqXDvTYTF6JC4kGTNMPaITy7zHdKJaVh+aMH+qsoSVHBc1ntiR2yC4?=
 =?us-ascii?Q?P/dZ5joUshI3tkopzHQDCKL48WClOoSvh92EYo+9JIoQNgB0rJCTmap8Fe4p?=
 =?us-ascii?Q?XQaXHamWk2dtO8K5/c2LmxmM5+GvEPEjAftgn2jQPyk6JLo3xWsMfPoI0IH4?=
 =?us-ascii?Q?IrsqttCLSHucDS8D4hLBH+1wrP5iyLcIo6sJEaiTY1/w8IODZcx6BNpLKLNr?=
 =?us-ascii?Q?UDl50xa6NxBrv8B1s4R1R5omjHcAMIkNRm0BPMnSEn0FLv0d0wEUYMy/rkO8?=
 =?us-ascii?Q?+oAn4AmXQFYLhRBVEgeJBhFXOr8Vyi8dopk78fDxTLDfoQrk2DUB7tDU+KFu?=
 =?us-ascii?Q?9WOr2uJlVEMbOJKUwwg4/v55iLkkPP2dbbDxQQ6yMvcGhtEZBoEnyi/H0KO1?=
 =?us-ascii?Q?+y6w0PjDO1SdkFob0CiDlxRBVVlDS/UeKK2NJf5FWf/NoZOed8I/mD8WIFD6?=
 =?us-ascii?Q?RZ/rLQZY9yXnmcJ7tF7W3xB74rDwiX/5fQF0kWaHKB72EmgYTqmovRpeiJuv?=
 =?us-ascii?Q?jowBt0G72Fr+iZ2V/q7xjULpesuh5xjF+ZhNIMjbkWoPQ8rzU31CX+6APnWG?=
 =?us-ascii?Q?adG6+Rnv+3wCHyCPY5Y9dA19OT7aJ1uBOVCF95kn13eMDoKrcXA5i1NsdtAs?=
 =?us-ascii?Q?CLeZ2OWPoZhfpw+GKJnOxf8v2GNk/8gyoRDMP6iT8SihbetT8SOg726uneU+?=
 =?us-ascii?Q?WSHddcE5KXRtZyz5nLH/rl8wUbZ+jOxf453nsEG+ZV6lmLz4/MaHcKnlv6vg?=
 =?us-ascii?Q?4TyIhMbblpsjJv4ubRFNAZQ/UjW/slXHIQ+Q+nNSAHH/jiFBEBEhz9NxRDMc?=
 =?us-ascii?Q?uF77FyuIHXaUqygjbjtqAImFP8scjMcfcIdn7nUdYY0h9C5biKGzTv9kaFTr?=
 =?us-ascii?Q?v4n3+10wIlSswsnDLqj11+vHpsRPOA30IFO2WMIYbl/pjC3rJHGeew6jyytn?=
 =?us-ascii?Q?K/R1alybQyVvtQ110XBqAX+q+a49Pn1yRkhqAPDr7MCtfrTJQrFCaZfd1Rt+?=
 =?us-ascii?Q?NW7l9RAu9k7YJ3N1vsDjILymfooYpqsqMZqI7bHQuQfW/0RIBR0dNXk/erw1?=
 =?us-ascii?Q?95kQVMBK00PK/2pgl6dUtcZV2gF4YPvvwvRTZRptusGzI4/CqAr91mC47MT3?=
 =?us-ascii?Q?Zw4Q7li8t/2HNjYy/AIlBhZi7sqQrSup/eZ0dW4gFVCZBCz+Y0a5OZHQI43c?=
 =?us-ascii?Q?ALQKG+z9l91pGiYtZjF/RqpHN/Jw0tiPiahVSpIANrPxCNAvTpOFZ1MBGfAQ?=
 =?us-ascii?Q?KrJNsvgLNnDbSqyhaOfRy7poADBdwhleyMmtx8IT6oOZrNttJ8Nu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f87d73-b1a3-4b56-fc8f-08deb7b407de
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 03:41:39.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs0M49QfwcECUWluxFMadc1BxWRGrQdKJBtU20fP0NUBSBYYntNRjnsrXfqaYHEi4MPvRpsB3/O7mCfMNJrdFTmpmYSErPvuuYN4/5PyHiwNYy7dRwtrCsnjamvZo5H9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7881

From: Sherry Sun <sherry.sun@nxp.com>

Since pci_host_common_parse_port() doesn't return failure for "property
not found"(-ENODEV), the caller should inspect the parsed result and
decide whether to fall back to the legacy binding.
Add imx_pcie_perst_found() to inspect the parsed result.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index b137551871fc..34756f28fcc6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1287,6 +1287,18 @@ static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 	}
 }
 
+static bool imx_pcie_perst_found(struct pci_host_bridge *bridge)
+{
+	struct pci_host_port *port;
+
+	list_for_each_entry(port, &bridge->ports, list) {
+		if (!list_empty(&port->perst))
+			return true;
+	}
+
+	return false;
+}
+
 static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1299,15 +1311,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		/* Parse Root Port nodes if present */
 		ret = pci_host_common_parse_ports(dev, bridge);
 		if (ret) {
-			if (ret != -ENODEV) {
-				dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
-				return ret;
-			}
+			dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
+			return ret;
+		}
 
-			/*
-			 * Fall back to legacy binding for DT backwards
-			 * compatibility
-			 */
+		/* Fallback to legacy binding for DT backwards compatibility. */
+		if (!imx_pcie_perst_found(bridge)) {
 			ret = imx_pcie_parse_legacy_binding(imx_pcie);
 			if (ret)
 				return ret;
-- 
2.37.1


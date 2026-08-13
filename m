Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A14C41DDE3;
	Thu, 13 Aug 2026 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603097; cv=fail; b=WRM0GGhCESOglMuHp2WnHDMJ77Ev60vV9tt8JrjtLrft3DfuJQ/kI9pKbH6b2ZNg8ok5dST6E8tI/ALz8JRLREdz2EPlkOvSw1Oy5JEBscj7VlNKwvjYimnMpZpVQgxgBc+PQsvjdgjSJsg6z5m5XAoRLHg/JCn0EOz7H4z7PlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603097; c=relaxed/simple;
	bh=8oUTMIrE32NCNZU1gXxw3RpLZxMk6vumhgi8OTIV7Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ngd6oyywwfjk4HMCEzganUM0SYddgGdMxkMhOTffBSuxVd7xXtYR6aoUR4eE3X2JSppZtgveocZ74+OHUDYQTwufJgp2IfAGcns3//BCvLul4hQ3Qx1goRqBse+B7A3N1Ka7AK0xFHS3t8aVIUUJZ6lSJofa3BcMekleXgS8r0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=v/hkhPMi; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="v/hkhPMi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+426UU8PcdVnMJf176B2OTv9lNFbfmGixBYCIjCRrSJqS0WZ9j7SZW7S2jAlXPahTXr11NN8iLUAdrKmzJkH0szllslxRjg1b/RAOjnxyfxkQvHcAOJHFFr5HOemqv8x3WHJdCG7KW8WojWZBVrQUA3LLxb/kTqrVscNPlfDC4D0QiD+2m+trFuHINoaMs8BX04ictY93pK+37NifS65M6TWrN/dcoTCi4flyco/DAVFgwzzZdDxKOPpeeNu9+1ipByEBYbvUnLpOaOcHu0pdSGvPLNwZxtZrzl8OfeY7we+zMcVAp73yGMlL7DIxVHvGG0wGoPWuAlJQtre9BzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7OagBAmlfh6QHVqNRq3IUBM0itZTkkAJGYLtl/luCs=;
 b=erWrMTsLi9EUjL0dxMjGDnwwhp5Sqf340bu+xMVZD89J09AMCcErLg0s+aaqjKqZm63Ni88i2mThajfU7ij3b5Nih2fxnwSpDo1RzWXLQcu/rrxVjcwZWGe+T+JKQ7oWi0zg0GFQV/WDMwdUGpZ6vQZdr6ACHy9Me/fVHcNqj/ZUK4yh+tA8PBClY7DAHd6VMFinA1l30XDYvey0WioiizmXvRPO+KiMShTOPC3qW8kcPCEGadE1+G+HsaJrhxqgR3wFgXe5gnbogMLnTCP3kWmg5TQH9CW1lqB4eZKp753ffNa/ku+qOqB/pnVYRdp4lFDmwC1vPgmvhsUKeo60kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7OagBAmlfh6QHVqNRq3IUBM0itZTkkAJGYLtl/luCs=;
 b=v/hkhPMidnZy6TdROMYLmWZowU2CVxIkiV+rx2AI3W0BrGytibvK0MGh9BBNtyKPie/oYtGfDRomvvTHOljdFbfpScG712HudNZfeeJU/a+EtMWKPOmgaw7ObL0EuUVfMmubN0/QOM0aJMBDNCG3kFM9j73BHR29US+JjMe7lsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2252.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:38:09 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 06:38:08 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v7 06/10] PCI: dwc: Implement endpoint DMA channel delegation
Date: Thu, 13 Aug 2026 15:37:53 +0900
Message-ID: <20260813063757.3131865-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813063757.3131865-1-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::9) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c21f14-8bdc-4a83-195f-08def905705e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	GJsvd+hOjPTdL8xDASwOTPil/SEhxWdb83QQtHIZxD5hr9eg098HWf3cWVYEnmJWy1fppWc5lXOXk8IULYiJ53K5cPay/cH3dDwmtdnuhh/8nm2PHOwjEIgEt9RATEUmz780xfKq2vWI3j/noCFqudyK95lm+vbqfnmyC15JQeuwzq9IhVZI8EQ0Z/YWRaWEUVer0g56geLJDdRhPEMXRk2u2FP0O3Yc6/XskKf767QHQNnbMPHFWH83y2eXQYYuP6D3Hp1H9kvpcAitAJBPBKmjFcUX1d3oFBcm31yG3OKWetRQt3d0D77U4HiR59+6h+Oj3svb14fACz6Y7Yh5IeSrqUSqaPvz3/3NqGS4a2ADlne23tpxyJlTh+wX7zOcVJ5EsyHXMBAZ32i9TE61qN6aHfw/yPg/svwFAW+/UTMiL4/vB/u0FZhleXMDqH43AYVw7WEGTEOcDHK/HEceluEX8vz6FIL2B5vU7/wtpc6syIVdAtTshU3RTsS1xYfu+V9LBPcTcw9A8iktml2By9pRodX88QaYdzTjVo56KCFi5/CP1kI3+sOXnpDmp1jGH6aes2PlzZlGx7atN1Y/twaaXsiqtlwcpRzhnTNlaNr00Osuwc4YpIs465FODDemchfiFek0ichTRO52L8AF06Nho4fZ6feFHuFP6uH3URVyYMMr0EA5BJtBUWHSFQDFpwFgkEWxkirp7wadG7fwPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMJjTdIgj/8wnubgeGvv0j2hu6sBT/nzsEvemQKTye7yY169MrXI0UktAmPj?=
 =?us-ascii?Q?jeZj1IAK7LMGNDEfE1c4OjW1rm/7L+pAnt26NaLT65mmEo/LNCGUQbdK7RWx?=
 =?us-ascii?Q?GZL4z5XZkgFpc7UJphwJ0D+xO1hkP/tlhlalNcFWnFzztlaiAUwH7v51Nk6m?=
 =?us-ascii?Q?ZXvZV0YwHxwW5V5OlqY45r48zphNCX4QfVUqEEkmwLRjNfxXmNVIAfaI5nek?=
 =?us-ascii?Q?nnPePhYCPF8bZJoMlubSJOhzJwXBD7Ckidr5EgxgD0NdsCeywc0f586Cz3tj?=
 =?us-ascii?Q?f+mGVxVZh72c3V6dBxGXIxTuqedsdKzUo1r73LVCE4GqLDL1n4wDxIVXdFvE?=
 =?us-ascii?Q?gb4Ac8HpaX35zjHtI0VH8JcAnYfdxf+ExtLNu6nafEYtYuZOdpNo7ItyZgmS?=
 =?us-ascii?Q?Tho5YW33A0kDnsROuEMs6TsofCfXz4VhtXga7fDqKQEFcHbzqdI95tAL4Yy/?=
 =?us-ascii?Q?eywxpd5SukRFx+yobOyTk/S8xtBIvl36bR32EPDBETCxE5hhkpV9yP7r1BE2?=
 =?us-ascii?Q?OE7QfEXp4vwhHMD0ydK48Bv47UqRiwOqpS95SWO0nCHRt163s3+xC2elAN+x?=
 =?us-ascii?Q?zHwhjE1M9YarUctbWnvCkp59eqaHP+RO+3Wt6u2uoe4r7gK9Vj1Fq42TJnBP?=
 =?us-ascii?Q?hzYL2A0OlnISb88gyKw8wlciO9bJEcGiFvAeuvyMAjOVqVbITweNcaPoc1f5?=
 =?us-ascii?Q?8Ja5h+N4S9o0gcPbgpiUg3pzayvVYYFOUXdzwCfgHO+/vL9AxriHFD9MLMfB?=
 =?us-ascii?Q?eB9Kl9RhzPsAzs2OPLoimSA5/VMDTqqAZcJQTl+xH4caBxN1rnV97KINgQ1K?=
 =?us-ascii?Q?7IUh911Povy48S7xyagc0smIQIT3OneE8GyFCsIZQXHsgFIRy/5e8QN992Wa?=
 =?us-ascii?Q?CfZl4k3Oihzqwdv4DDMgcCVXgerA1s//htDeM1sZml9tO7PkVgIEhKYZFPY1?=
 =?us-ascii?Q?QbVK+ut3D67nwwTdXUVeny9m+51hmRMf6ygTAsxsCOcgkBCLaDvLBkRm8VMI?=
 =?us-ascii?Q?7QjUwSP07O1IhIsO1wcOf4i9Y6gNx7w1dQug/OfHovyOV4gT67gSSk3AS+B8?=
 =?us-ascii?Q?iV9F303rqRZkXx/uIMA2VQ/PLcLXmAM6P7HrO2v0RnCRflgzZrKafjD7DgW+?=
 =?us-ascii?Q?28Nl5nNAhQ8oJHDwsb6O1SYx5FlXk9bLgwy67z18GNNcvqwfLgnKG8GtbIEG?=
 =?us-ascii?Q?syN6uHyjXH0vIMfKdVQZ3Rcn/crPXHGA1cGzk5mHhx0EjTYgW0UwRkj5qh1K?=
 =?us-ascii?Q?FnykhonK5aK2r/Q2aJFst6bzlimubqs2cX/CnhDvIRQVs2Xf3kF4DyAGzrv2?=
 =?us-ascii?Q?bS1sT0sbsBqaMl8idsGIC37y+hPo+m4vlSl60mNBZfliEYkannwilgupnHGv?=
 =?us-ascii?Q?9BMAwDdyvJ69aZ70u1Fv5yM4+J8NpO0zhNiYUyHC++yPrPDnxU5gxnRYMCbc?=
 =?us-ascii?Q?Dhp/htwsWRMmXgnoE7pSDkRX+xTgaBiUCEGJmZEFs2b+gwJuuFYX2DUmRn7f?=
 =?us-ascii?Q?H/Yu7zjBhEHammLGaU1kqw22WkebxMBCRTqcFa2GIlFcue6BolDs/Dul+MSg?=
 =?us-ascii?Q?RAezYT5fCg/gS8+eHyR6Fy8sT8Ra20175bohEwAt3Rv7wNqF9iH6xphsOVbS?=
 =?us-ascii?Q?k9yRVEliNRPAwGuSpBaNCmXLDT3ggXjdyScGN2tHSUgrOPB539w8G8pXX7wb?=
 =?us-ascii?Q?P5GtLKqmBsj0WKOUfA6hn13iCA/CnbJkbHWs2kH48bE9P6q890MSujW1Eukj?=
 =?us-ascii?Q?hn2j/2VV/0Jp99coQe5sbOOvcieFtVWZ5QqHlgX9/j0r+BiD53sQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c21f14-8bdc-4a83-195f-08def905705e
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:38:08.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVuI86zgxUzPKvpPIXD9gmkAhD7nOIz32hET1C0lIn3f346qJUNFI+hgOOnIrNXUF9B0QZLlUKsPB7xrfWgH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2252

Implement the EPC DMA channel delegation operations for DesignWare
endpoint controllers. Verify that the DMA engine channel reserved by the
endpoint function belongs to the integrated DesignWare eDMA instance,
then hand its interrupt routing to the host.

The DWC eDMA/HDMA engine generates DMA requests with a programmable
requester function number. For delegated channels, the host-side
dw-edma-pcie instance bound to the exposed DMA function programs its own
PCI_FUNC() into the per-channel requester field; the endpoint-side chip
func_no does
not participate in that handoff.

Reject VF requests because the RC-programmable DWC eDMA/HDMA register
window is assigned to a PF BAR only.

Reclaim returns interrupt routing to endpoint ownership. Propagate the
EPC quiesce request so bind failure paths can reclaim unexposed channels
without quiescing the DMA engine.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v7:
  - Delegate the DMA engine channel already reserved by the endpoint
    function, matching the API and helper changes in patches 4 and 5.

 .../pci/controller/dwc/pcie-designware-ep.c   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0b915824963a..a74d3896e436 100644
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
@@ -933,6 +945,34 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
+static int dw_pcie_ep_delegate_dma_chan(struct pci_epc *epc, u8 func_no,
+					u8 vfunc_no, struct dma_chan *chan)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_edma_chip *edma = &pci->edma;
+	int ret;
+
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
+		return -ENODEV;
+
+	if (!chan || chan->device->dev != edma->dev)
+		return -EINVAL;
+
+	return dw_edma_delegate_chan(chan);
+}
+
+static void dw_pcie_ep_reclaim_dma_chan(struct pci_epc *epc, u8 func_no,
+					u8 vfunc_no, struct dma_chan *chan,
+					bool quiesce)
+{
+	dw_edma_reclaim_chan(chan, quiesce);
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -950,6 +990,8 @@ static const struct pci_epc_ops epc_ops = {
 	.get_features		= dw_pcie_ep_get_features,
 	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
 	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
+	.delegate_dma_chan	= dw_pcie_ep_delegate_dma_chan,
+	.reclaim_dma_chan	= dw_pcie_ep_reclaim_dma_chan,
 };
 
 /**
-- 
2.51.0


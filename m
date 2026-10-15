Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E28379EE7;
	Thu, 15 Oct 2026 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035078; cv=fail; b=dyH4oPn4XQHUSI+KoRd0SejaFEpPpf+cf9UkJXCpGoh+CnMh8w6WR39xgm7G6UdffLRz2O8x0/WcawYIfvgZHlGC1NBpnzw9Uck6NPDCIlQzmRhUErbCwMTo2Z6XZMdoMxUGPsg0ZwzOG5TnUq3DY7qd/BQK1u6bvKsup/ye9XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035078; c=relaxed/simple;
	bh=mk2ivV3MZ3BQ83kX69MxsdDZ7AQmnRR4nj+yErxg7sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGzpHkmpTlZlywba3ttCCVBlqh9WN2p21Z8EPLvGjtDO/Mocg+iE+EDdsfJgwv2uaiOSYKgutkRYbq0vGfUxtF2JvBdjVa5nW7PEtqojBuqNaCP2YwGop4b+Gr/XEO2TBe0RGFt/wJL1CUzw0mWDc08cFKzm2fRI/PtqmYlGfBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QeJyi6yq; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QeJyi6yq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qphx30w8OaDCk4VQkSN7rEb/Lvp4smA4nPFyRfn7f5KdQOBtj4OP8X1WLfjyy1/+b6ytrcfSnuw6ZzT+MxdB5DxMXMXS09RCmPO/ia5ko2cMQENn6lUEs5QeR1yhohYtDDqd8zFGyjtQVpNAcMLASbgfVVviJR76oS4DizCdUFCXVZ/rzX/GeH+6NCtV8N+UkhP7Hs2rOgc0cYjN7UPgKbc/oQLUJzXCiC52yr0ZrtwWfNhU/CUHVkSovAuO4xRiC5vg6rK3IShVKtrTsaEjDJquB7fxPoeMjK7aZtkNBAbxdp3zdn8NikCndGUmgufigBTRKXM7TgA4CvVMO8G5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt42/M9oC6OZ4hoTOXGxX3+uO3Ri0HVljxj/IIil768=;
 b=eUbs2H1xYyA1ZepZy/Mnpd+7jHw4LfrN9Cc51bIeRiGVlsik4hMM+MXbCAID4TNSH48brpM7HnL+8iVkMdplyhxQE5mYjsD0l+8ZisHCl+mpgAoZrTy6RBPLqgVw1wQtwzTwr+aCLK+B7k95C9kp4z2/M8VJCOrCQVrYAS7G7sRSSGACI4Xs6YAV0kCrf6/8Rpjh0qd+m7PRumOLPEdJeQZNPJLWJ6i5oEHaml0DjGYw+z4Zud5EszZVn9aVBU0oQFpfpEIHgStlcvKH5q7sa4ZY8DMe/CL7RhgTLTY6PFCmT52Tdzt7lksb7e7BHG5uigC00X4sn/X9Gydum8cZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt42/M9oC6OZ4hoTOXGxX3+uO3Ri0HVljxj/IIil768=;
 b=QeJyi6yqRakr6u41MSVbTj1kZ0IWS5JINEBch8Unn325U+s6lnGqi+FE7Lx3a6R10S/81zQNn6jCgiUn6I/YMc5QlRDTsVblKt4+/lcyTW0GrW/Iv+YCogNqWSqJvYKi7klbqAFoJHdNPaWA7EkiVvTTTjon7racUGe7Di+emiA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:11 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:11 +0000
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
Subject: [PATCH v4 02/18] PCI: dwc: Factor out the PORT_LINK_DEBUG1 link-up check
Date: Thu, 15 Oct 2026 12:30:47 +0900
Message-ID: <20261015033103.3076869-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 98133f5b-f742-4276-57bc-08df2a6cc237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bmTZcn5+4DRuTdTs00T543xrg8SHCBTgtGbLULSyhJKRxtSGIn/AsdMwKKgIxx6NCbHghXNoF+9r/eMsFiV1d7uYA2D10WP0Gb7GRFSFe9YKS7yPgaQCtUS69Jyy3kg6AzT73p+a6bzc3lLYimy3pmHCek37Xcj/Fh0ZWe/pbTh8muKHZkz7xb5RouXSyf69SRGq+8+gVJvP+A7/QmdOTW8sYWG0sx4rGqLc7EZWHYsbWpLtUnv7iAddc2fctG5D6T+B2zkhQQhlNfAVB2judR1ttDnSkmg8NAD6iiZIiufj3R1AGmE8qyq/ykTwU53Eip385Q1wMTa7VXZ2QGPKiLiJXQKD/qoORrVCoD3XFsZWT+83YszMK+mIJcB3HSBGQQExXsu/dZenNL09TQq0wc2f5PgYY+4YEqwzeJI8zH3TmOQC9k25Ves4HeUO/OYFAOjiXSY8Fm9N7i+KDZ9Tco2hnDuFZEuHGA8NtHYoLGllujkrMikHcyTb0BMCtmQMs25qVOi3RhcUCaZmyBsmDRENYOD5xfJTTP/zZ1KGLdYmjyYZz8yK+SZi+DiRZnxxaLewrk1vJiAgp7rUdG0upStFMN/VWMdarCOvBgdmtw8iGlb+fZOtaysXdpSDPZUdp9IuYcI/B6l8Wv8cmDdTl3gDTPkAo4xHVAg0CYYwUi4B0uz2NC4maw5mv5ClWTnF/Vq8OgwD1lo3Z8EGMhZTEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vrDyH/sEksUqAXPAhXSRKKRB5seKTrSYcBOKJN1XLyF+j5+Jz0mKLlqHQ2LW?=
 =?us-ascii?Q?ob9X1OKSIV8gcSUvYtAsl1BRgGCYuaW93EoXtwZ56zIMGzcr5iP6sVINCxSR?=
 =?us-ascii?Q?AjO57QF+oVW2btt1CgQ0N7l54u3kN3Ka6iCvrwpV2nQooSLyVPe0eCL4zRLW?=
 =?us-ascii?Q?PCO6ZCcBG0f6n1yp/OICQZwVeIizKK4Bf0J1WQIMgRRkKrMkxQpsrXZgpvOf?=
 =?us-ascii?Q?4n4md1fQODSOJbw6dDOJ35/2tLWTvHooRiAdr9G6rhPf/B732k2sEswWMkiK?=
 =?us-ascii?Q?tMMpL6cNY+4e+ZXb2CpXERUBKkuLkCfpBSHTyRrpnEf7XlX1SslMJCe4RiIg?=
 =?us-ascii?Q?5tKnavCxwrFtTMedfuBP+gfuQ9AoHnkzZ8OVxbon5UVaKZ04JB0z9juoYXoE?=
 =?us-ascii?Q?al+5Fw/28QTWNSnXqWAtC8YGDqUeFWzgpU1WdvbIK1bFe2Hh7TdTAsvM1AfR?=
 =?us-ascii?Q?kE2a0n3YIgR4enJYhCrbFIKHyeIpyEgap4r4mvbloMjY4hoKwuiEe9ToLv2H?=
 =?us-ascii?Q?6l17OP47Y41puwCxsysqMjKlPl4MzpVJNbrQNvslfs/SJLnaE2l7VZzTstQJ?=
 =?us-ascii?Q?+VE8XE2IbxiKZ5nkNDYl1XumqXXmkQsTi70PpQoE/g/pIJES7tGktK8TJLv/?=
 =?us-ascii?Q?2BW1znk+wFpzYRiecLzlZ8GSPpbHq+9YR8dzcKyn5uLDR5FhtYGJVaU7UlFH?=
 =?us-ascii?Q?S5xW4ugh9rU5JXfBDbWtMf1wKM0FWH70i3W41GT3PTombUengCwe3Xx1YEQ3?=
 =?us-ascii?Q?SeyoEkcAlSyYHsJ3EWTPaWgGlwwatcIY0Bzda7CBUUQWlrkHfGtQKQ5lpMdv?=
 =?us-ascii?Q?T3d/eAHLE+P7WgvRAheUTiXFUEq2BNFaCYmHoUq9/RohF6hxkUgUIOULS/lo?=
 =?us-ascii?Q?574p3EiUcVcp/AIVDjDV/AtQawUmuhAUxVNGXNzZuNK/O+C5WP6OpI8qVwgV?=
 =?us-ascii?Q?LJl2O3pFRBwIi2BnFxLvrJmhqjyAAiZs8CAdH02ik85BCsgFqHWZx5ukFecF?=
 =?us-ascii?Q?f5+ejaaJiOraeVT34dO5pwG0X8IsiAqJypalq2X3QpXRmuAmrB7+sorazpOW?=
 =?us-ascii?Q?zc9yjmjMx8ZFFjFHYrDS24l2O79D3VHsiSizZ/qaqSjK0IUggZFGxbT1dsU0?=
 =?us-ascii?Q?YZabY7fcSDBIEADi0ouMq80mCX7OAQxvHMCYvQ6zMA8neYgKMPR1QpcdrONg?=
 =?us-ascii?Q?618ff5NF+ctebXgkBtzq74ED9r8r04ApTDNqiIOsH5sWDntJxqv+XQg6f9om?=
 =?us-ascii?Q?2+pRxGElPB2WpXdVh7D0kFLsd7biji9rmzprG8CpAy2vIRUi7NqoiXpmoHaG?=
 =?us-ascii?Q?h8jMTpHEA0AXL/WGfUEfB3AznuAw6CZ1wTj/qOfVLXpsByd4y+tj9buwlRYb?=
 =?us-ascii?Q?wFjsv8W2OpannjB3BrsPbFtYqDUvLiNd0Czq1g/TMuuiJcQ5tj6LNL4mw2MF?=
 =?us-ascii?Q?2aPxzizTRGBUAYzWuWNih4C63pi8+bIj79+7yVIEKlmTLvHTX8cRMbT3RI0O?=
 =?us-ascii?Q?NetwnNZ/cZ7uh+F/XkPHEShF2oio27aXujZSU55qWeRR+h1FSS3pi312h4gh?=
 =?us-ascii?Q?FtThh/ioZoaB5M+paG8wpkByHwYUlNIlc0YNfjk5aBaUWYx7qFLLTznEQfAl?=
 =?us-ascii?Q?M1R+5YvxlSVpf0CMo8WW2+LD7rqPF3zoG+IJ6L0hn6gTjEg+PUntCYKX7AYY?=
 =?us-ascii?Q?dMEuph6DxnLcl222FAJa4GoqvR8M4bBBUk7hVyPw1SFxQTUUhtM42xHCJiJK?=
 =?us-ascii?Q?EeSPp7YirpUzsUXs2ZvWCrunYt1MDyig0P+i6RZ/HZof2wfSm5o7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 98133f5b-f742-4276-57bc-08df2a6cc237
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:11.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1byqyc+bFApJfsT+RIc4ByCyV334CRdCRzpB03U8NFlDrLtk47FaKH4qA0sKfbuSmmXDwS7X4y5Slv7hXN1GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

dw_pcie_link_up() reads PORT_LINK_DEBUG1 when the glue driver provides
no .link_up() callback. A callback that needs a platform-specific check
on top of that register would have to duplicate the register read.

Factor the check out into dw_pcie_link_up_debug_check() and export it
for modular glue drivers. pcie-rcar-gen4 will be the first user: its APP
link-up events remain latched after the link goes down, so it has to
combine them with the live PORT_LINK_DEBUG1 state.

No functional change.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 drivers/pci/controller/dwc/pcie-designware.c | 15 +++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c726aa71c830..49a9ba910ba8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -817,17 +817,24 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_wait_for_link);
 
-bool dw_pcie_link_up(struct dw_pcie *pci)
+/* Link state from PORT_LINK_DEBUG1: up and not in training */
+bool dw_pcie_link_up_debug_check(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->ops && pci->ops->link_up)
-		return pci->ops->link_up(pci);
-
 	val = dw_pcie_readl_dbi(pci, PORT_LINK_DEBUG1);
 	return ((val & PORT_LINK_DEBUG1_LINK_UP) &&
 		(!(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING)));
 }
+EXPORT_SYMBOL_GPL(dw_pcie_link_up_debug_check);
+
+bool dw_pcie_link_up(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->link_up)
+		return pci->ops->link_up(pci);
+
+	return dw_pcie_link_up_debug_check(pci);
+}
 EXPORT_SYMBOL_GPL(dw_pcie_link_up);
 
 void dw_pcie_upconfig_setup(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 419932488280..2ce61709b58c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -618,6 +618,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val);
 u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
 void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
+bool dw_pcie_link_up_debug_check(struct dw_pcie *pci);
 bool dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
-- 
2.54.0


Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020121.outbound.protection.outlook.com [52.101.228.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7C3BCD13;
	Tue,  6 Oct 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276421; cv=fail; b=fwU2YjqzdAREByYSZUXnpjbh2GfIxFXjiW18ER0pcFTKpL4SEFXMipDQZyHiQmf16l2pVTbTXEJufQQuzuX74wtr1HSWangQEnG+MfWXzHu5C+gW8+0eSoBEL5A7sN1kq9qHgo52cIUXEIbzcz8w1CXz3kiOUPdfBx+4qrfUEYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276421; c=relaxed/simple;
	bh=+N23SPMh0B/76ZHYbFqcKuZHTqCTG47YVjJYx2yLrEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H1CE8utjOkMkenOrAs/o+X5ENAeAuUKmPXwb5Es3XfHDp4TTleLCRJ/cjsAfuTSpXXzASg4RgxZLMOMqQPPbeBD8lPevlatSp/jo4bD5epPi2fQk4FITgPvaAh1SxQi2+q4fZolSNK/mQ2Ks8oxjInNKpwbKZ03FJeaa7ZgbIpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=G1X26WoO; arc=fail smtp.client-ip=52.101.228.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="G1X26WoO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s13827yUa08KX+NC41nsjBqFVCcOrsd7nZ2lWrRPEmXFCje7mcMk0dQzoxOcIsMawjGOJefmEJzvRV0TQvW3KK2u8WQ6dCG9jqbxXzMrBpYvlLjjmKyuvpL8dCcCBF7mDC0ljr3y2s94LE6/kdCc7+6cjvqseIZEZtrEvp+m1pGfQqhjsCoYhbBYdH3M+daXslaPxSpJaqCqA76Hnu5K2WHnb9BUwGQ/s/gBaUMTEcCCKfcJ8mv91Gz8y3jfIe6Sm1wUH9SPOIq9ta12MI4oHRdVOln0Z6iJVajrV/Z9hsaZYPXeHTkxatJU3SeF3FGb/UatMSpKMhiY2I5GzT3QJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1Zv9QWRLW/1VeTKptBmHlkBuZ2e9i3dMgCvCOIZpvg=;
 b=MR6XiTN3fT9gkqTokoTPW3+5ndKPPzXiuk2ayQwO3X9ngtUqALCXRuJ+NU52onszGBULPRRHHZ8AVGHrdiu3VNhuc+ekAmGAoKkl5P9oFTXpX8qk/cCAiRqlwd5RWOeAEJhGCGaTI+IDPpgnN4oU6WgwCiPfGG6itzp3yDcTDGwg8Z0jon2Cgcv4PPO1ituVTbZwTj/xPtIKbG3CNjWI7RwqnmwBMeilKH/FAh/i96xhZZtVclrjySCmqBlBml1nMqprDmcso4DB7G1MPsM/AfIe3guB8PAylQQpcfXwXX7sXhRZTNLQ8OLD1HoL0pK4x/jMZ633rAOERKmoJDn6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1Zv9QWRLW/1VeTKptBmHlkBuZ2e9i3dMgCvCOIZpvg=;
 b=G1X26WoOrZ8w7lC2PjP9R5F7Fdokvk8TNLpgITPJcxjra9+Ea2W1eLklt7Ow9ZPhNTwdn/PTTN1QGgJZRTbR8XSH7PEphkylzqcS6Jpa09h/nrVj1SnztgO3yfm6qXLyo1d3xgYfrdMB3eQ1kcb7MTrFKQbLqcZ1LBhenycnatA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:48 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:48 +0000
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
Subject: [PATCH v3 03/18] PCI: rcar-gen4: Check live link status in link_up()
Date: Tue,  6 Oct 2026 17:46:23 +0900
Message-ID: <20261006084638.3821710-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: d155b53c-35e0-4f12-c691-08df23865b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	f/Sciz0ajAlitmNoxT020NfE2k+gCC0Z7aY+uL3hDnhNqMGwwJYZeVrOMcGPKldGvllB6F0om0VIv+xzQyfLcvdIMg4soZbJLbAA+3hwNhZN9VQ/W85ECBNeiQxYKWw1MlWfP8K91irhf332cv8IXt8ESo2lIinmtNIM5R/tR3wLp1Nm6ko7jwt+ruHB5g7ryVncG7E/G6XXUbX4IhfN/s731gytg+QD0Rqdyd4vFOY3fl4C7/6ak4UdryuJ2MzPOU49a1kN9+JmiDgv8hHUfget73FhV7BCCMhUP9cHqHlL1bl9DSmu90lRGUKkQrHc9eOwE6X8u1bjm25LqHpZts5WUtoIghC6yJXJPE32mjWbkvBAi8J9XU2CP5hQqRs0/eqkWoHMvaJqpINqFyxCq3HN9CVpc5uF/cm3Q4P+x4K7sVAGKa6o9kwLToP+hQ3mO5p6gmBYprBCIq1AqfCkhwunc2JRxQ4EOtmZC9W3FYTmQ5NrJAglea0xM+r6/jEj2TFBIMXmUt+rZcwz2Huj+nJyV2pHMmDtEget8dnRoIKhHYcwcXATs5nxB0hSlqTi1WAlD+Vug/bYikx8pMFd07eIyoBs1tDvcdmcPlOxugH/QR5xqLJdUc7HkGFRFHkWDRpjFrElEgL/mZCrd/XucLjSdcZLjCG/nDoVKj6sYNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uz0lpdM/vbmfq+l9ZCFyOKJccuELfHhZLn1awy+TYA/cmA1bJM3UTYsioAAF?=
 =?us-ascii?Q?hgeuknqnwYxvF6QaPL0gAWDLK8r+jD0HH8XxxNuwGNXSWG3JJpkrKWtUns/W?=
 =?us-ascii?Q?GXcK57HOxuJehrgX2wml6pm3XgUCV6rvExUhmAg5rQ0vXnndZ/0r4voO83ju?=
 =?us-ascii?Q?fQTie2bCTOv4+59zXlXFPUdxg1KHdcI8+klhXO1App2tgAn7YBdLwC627Kmn?=
 =?us-ascii?Q?itKnCDivnqjJbSBuix+YubvUUGuhAEmTFKp+/CCaEKrksMl4+5YWFrirci8H?=
 =?us-ascii?Q?FWqRW3wNDGebwt7b1OJr3dq/wvUxElwz75DO3AaWFl6FELZMgQUDhW5pIMO8?=
 =?us-ascii?Q?QtE0tRu2SO8oI1jRpEuyifZXDerHMu71P1dfZVz+tn+ViTo4zBk7blbhAvAn?=
 =?us-ascii?Q?dDI7UhvSd6cv0jb6c9Qy/cvgRV4Im5kzg0MgLooKRjfhFkaZiuUrvu7dd1Gl?=
 =?us-ascii?Q?tVUdjqkjJqfXh3I8PBAJ3/MT9rr8ydaT0QA9atiYseTxxHo+GRKAFnXSrUQ3?=
 =?us-ascii?Q?iwbA0xcap3FYEFYWVneQPqooX3FvnX3/v1qccn+oQl5NO0+MfZ9r2dh76Ndt?=
 =?us-ascii?Q?tdikIzvrlu3JCRWVEbIP6xvLxIlaVHjyDe096VhllaLGXp+78q8nikJ8qWM+?=
 =?us-ascii?Q?qgz4IOcMnVS0iJjecJzkTjSZ2En0EP7wOvtXtj6+kogRg5qH/D9q2tHKCuyh?=
 =?us-ascii?Q?OoXPDa+NwXsu8tppcqoH0VvGDDjNR0rrfLa6TVrzSMFZSTY0sDNPMQLHnXH0?=
 =?us-ascii?Q?+8hABPjnMKPE3tcVi4u4RnFlJCBYzsXngg5akezGvf7fRCPe4mqWa589EEC/?=
 =?us-ascii?Q?Kn8TBWmd9v9xvyf09GF81IsK1iEX/9BtMgHEq3cgJos8lSYnzPY7yFJebyHM?=
 =?us-ascii?Q?/JcDksSqb1ylh8SsZRVkAAOoPnRPCdK89IFOLhSNe2A6iW1d/x1FrVSANvhJ?=
 =?us-ascii?Q?BYmSyG76durnwn4PJHDSCZeIX2UTMVHtu4Cs1F/VQcvdMlsHTnBH5TfhVQTe?=
 =?us-ascii?Q?EnoeiWEWf8XIv1J00VR2QnV2QFA3AyO6TQLx+w539Aq/FJj3QCgikeHFBmol?=
 =?us-ascii?Q?vok/VHFv6op09G7Jg1bPg40WUDjncrmZmDbm4kug2Pm6hyb4vCBv1QmvWQFD?=
 =?us-ascii?Q?rXoSf87lfF28OIhG/J5QN3ShCJNKk2UBL8lH8kz2llSCbAH2zi14rIKGA7pN?=
 =?us-ascii?Q?ifo7vugsUqSxRTvUNzb1FI8duexz03FL0VXgWmqA+gk9KXE0f6uJV/vsk+/X?=
 =?us-ascii?Q?jrtIqVPkp1ryBdS2XR7y+rZeLqHCNx4VYCrqecYkmluqMNfO9VH+p44PSiB7?=
 =?us-ascii?Q?26uJaJEYY95/rFyHIQYcV5VdmBmIGnlXf3D8CuzhgiwDHdgnVuP7fp/IzTLk?=
 =?us-ascii?Q?bDidjZi3u4GO0GnHYwi4K+rjTWEI5BogKqlA3WfqaNYVxdwTFMhZHVvaOFLg?=
 =?us-ascii?Q?dXYCmSmITCUkiNTJ8apipnpFuq33fIFpn/Z6rIjcB4JYb45hMEnKFiKcJmGy?=
 =?us-ascii?Q?fxCPbxkZmTmFgWQDPaEfV4TXc47nztXK3H4uRN26JUr8OgLWr64+XEud60X7?=
 =?us-ascii?Q?hnzyjNLKRyF/lp5fCvVvYwxtaplPK9upEKFWeNPlg4PGarBECN+XLRe7c8r+?=
 =?us-ascii?Q?paQDDKinOd0yfFg6IXoHbJND9hFEMk98um/ifjaRd2CmrEuX7pTd3woJS4Bo?=
 =?us-ascii?Q?8ch1z4gdL5tG7uxfZyvQ9YZk2w7wS+AfsUfW/dEqTgKaHaGteQRdVQGUuxcz?=
 =?us-ascii?Q?Yux/yfFfil4XI6209MngNQw3MtP00WE2yjbEt73Pu2JWGa74WHSJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d155b53c-35e0-4f12-c691-08df23865b9d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:48.0735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/WL7rgI5Q1vWl8M0qDbLVXM4NGZP8aB2D5HKmYA+2EdXxQcuBH47jX9i61SgdRMsBN4sS8QFOc+KOP6rdH9JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

rcar_gen4_pcie_link_up() checks link state using SMLH_LINK_UP and
RDLH_LINK_UP in PCIEINTSTS0. However, these bits do not reflect the live
link state. On an R-Car S4, after taking down the endpoint, a link-down
interrupt saw PCIEINTSTS0 = 0x20a000c5 with both bits still set. Even
after resetting the controller with the LTSSM back in Polling, they read
0xa000c5, still set.

As a result, dw_pcie_link_up() keeps reporting the link as up after it
has gone down. That defeats the check in dw_pcie_other_conf_map_bus(),
which is supposed to stop config accesses to downstream devices while
the link is down, so such accesses go out on the dead link and stall the
host. It also makes the callback useless for the link-down recovery
added later, which has to wait for the link to actually come back after
resetting the controller.

Keep the APP link-up event check from Figure 104.5 of the R-Car S4
reference manual, but also require PORT_LINK_DEBUG1 to report the link
up and not in training, through dw_pcie_link_up_debug_check(). The
callback then rejects a downed link even if the APP link-up events
remain latched.

Clear the APP latches before enabling LTSSM to discard events from a
previous start, and only read them in .link_up(). RC startup uses
dw_pcie_wait_for_link() to poll the combined condition.

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car V4H
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Use dw_pcie_link_up_debug_check() from the preceding patch instead
    of open-coding the PORT_LINK_DEBUG1 check. (Marek)
  - Carry Marek's R-b and T-b tags, as the only change is using the new
    helper.

v2: https://lore.kernel.org/r/20260928165230.3397664-3-den@valinux.co.jp/

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fceecbd16355..b101ad7dbc31 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -53,6 +53,9 @@
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
 
+/* PCIe Interrupt Status 0 Clear */
+#define PCIEINTSTS0CLR		0x0340
+
 /* Port Logic Registers 89 */
 #define PRTLGC89		0x0b70
 
@@ -120,8 +123,11 @@ static bool rcar_gen4_pcie_link_up(struct dw_pcie *dw)
 
 	val = readl(rcar->base + PCIEINTSTS0);
 	mask = RDLH_LINK_UP | SMLH_LINK_UP;
+	if ((val & mask) != mask)
+		return false;
 
-	return (val & mask) == mask;
+	/* The APP link-up events remain latched after the link goes down. */
+	return dw_pcie_link_up_debug_check(dw);
 }
 
 /*
@@ -208,6 +214,9 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
+	/* Clear link-up events from the previous start. */
+	writel(RDLH_LINK_UP | SMLH_LINK_UP, rcar->base + PCIEINTSTS0CLR);
+
 	if (rcar->drvdata->ltssm_control) {
 		ret = rcar->drvdata->ltssm_control(rcar, true);
 		if (ret)
-- 
2.51.0


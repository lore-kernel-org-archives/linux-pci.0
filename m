Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749130;
	b=jPsBx4yEVYcgr7X0IBBwCK12MDbwv/br7tSUW+XeEl+V8AdnijaAxGoMIA41kymwFWmi
	 qL66W6XOAtcvmpRxzquphvY6W8if+HjoIHDlbGWNlnBh2Q/U9x5lDQUkf8HrwhSeGXAA1
	 wCFiZe/qZ/zVrFC1+TpuRF+h7wDpXjJlh4LnL7Mo/EWo+DLeNkJMu5jvgG2E6JXcBn69+
	 XmQlsG1s4GK5ro2vvq8nT0j3vdRw3FHjL/ulVJgDkXyFrHZPsIT+PwU+urLW7qsNuNSKY
	 YFoao9gDM6NOPjBRmR0rBpzBAWHXvsrT9vOaqerxOrLBtznLy2Xp085ZulnSFCHeN/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749130;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tF3v4j9o8+2QGYEAmagYSAueCZ3WLPDpJcNvXt/3c50=;
	b=c7TrOPNQBLAm5xubl8p+Taj9crDqnUxAa5xL88YMKJHbQARaVqbDUpFE1JrLOtTFBVhl
	 FSDyy3o8SP518yEPwVF1B9A0sSK+3rXRIzCrHx3/Seg+Xbxwo430JjgjLsqo4prhC1Pkb
	 LrOss373TvsO41sKgTU+i7je3w8//X0+wI2W4wtWIwnMwoJYwzv7yzPLjmz93UsVZhCKw
	 H5MMyKecBJ7dsONuLVaTUJlf5bzelZvjofeNtYcWiQPZfF+Hx3HRu4VcK3TlkIQs+9as8
	 0wMkvzZ6YjF/WYZsRgjMMSSxMzvdMJunLwOCeRERZLM/3iAG8utjOImMO7CJBfaErZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=gkSFBtOT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.135
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD27606A32A;
	Fri, 27 Nov 2026 03:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BD27606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=gkSFBtOT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPGpYH7R4wVQf6uODneVtXdNfyrrQPNGxcwn3oyLenfHC+5NwteUQkuSTAcOKbFwwmD7n6TZNbjlQgPkAFek13nSuk4Z2VN/z1Z2qWv+w6lIGi6nlAeVQCvcC5VgDbR+EOaIRU69+1XfOMMC5X+675EJerAUrw4vA/uO7cXs/WcZeeiHkkpUOHebA9UWT/vJmUcWRsrsZRlYTzWucpyL1I9l24IoMuXTg2nW15yc3ztUoAXetsypIkNArNq3qI3MRx/LppLppY4+8/2ZXElurGGNFm5wmK4RhPg0UMzodIMbRfKPLlXprWtxm+dXGQ/tkSifCjWSfncp3NBxE9HSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF3v4j9o8+2QGYEAmagYSAueCZ3WLPDpJcNvXt/3c50=;
 b=Daqngb88RIfFzudFKMEBx4MWhktb/CiALAScx9NPV9MV8YNljuDgiXkNvNgI5cHo+yYjzOesW0uAOM6PQd8+tlbblMwKMTjmS6rzfONqv3d3HlcLuyot7NJR4HU4BGNisULusi0z5g6R/mhUA+4oglB+7Q/r21slGEoC7BoOkak3L8kffztC86J8Witea96Sb+oFX/kr5ZyXJDWtx3DSd2Ym9M6lvEPnfP2W2WAyYinD6etgOXcZejbsQBEmDsHpIWS/E6FZytKaRzClapbQFLz/maVX7uPc8mDQbMvNN+CERxxVqEo338KvUljWk4F0ae31bNwLd3njq8XGisyboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF3v4j9o8+2QGYEAmagYSAueCZ3WLPDpJcNvXt/3c50=;
 b=gkSFBtOTnBm/hMZ4/rOeGi00jel0hQVOZE1dYT5IgUZFNUIwcLsF/m7jkZrMwM1wzHtrJh1tuiAUuzn2hA8XEjm+h3xDDhiMYsUM7Gq9pjBz+PBLcKGK49/SKgfU9y4il1/FiN7p08ROyleAFzepXBJ2em45WG5xD7jnArZ5m7c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:05 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/17] PCI: dwc: Factor out the PORT_LINK_DEBUG1 link-up check
Date: Fri, 27 Nov 2026 12:11:30 +0900
Message-ID: <20261127031145.2521228-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:405:372::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f3939d-cfe0-488e-9e7a-08df4c3436db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102130727099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	i539GhuND5S5G5Y7Ve8SrJGv+eFl4luPnnQHlgfReYz89gvWC0CRgEK8leH1FuDufrzb71tm4ii4P++UuHFCp8AWStN66KvuLfJGXHelNEeY0aDO4XJZAsWQXLMAjNAvqRGWBOhm0Bxix+Ux21jMLC2w5HYR9hZnHTcV9fRjl/SsHoIUWrvr+FSnrjJh9/oxOz8R/JNQ+PINQ+Jxgws1Usxx1xTO/VqxUnQYG1eHRCHnXTbNYehBRarxt6nyYWZ7kgGhpQzTnLLfpl9MM3WJmGDHESNbZOYN17fQTvtR+PI6LMxOrXqyTMNWZo2kmIfqEPUhhXQBKt9iSrfN/VbAP6DQYA9oc0NgdKLr2yG5yqi8juyCVIOdeDZIllXwYQOriknHfikj38/TDRIoWpfcl31QXEj3yQ+PqpNOqMoujx+W3i2yf0Q/9R8EUkyZcXY767tJhLty+YjbA4oBsTwhNGMoOy86v1iZpdhnXsmbGXqgLWWtwDmzkVvl3KWfE064RyHMmsCf0NUgbZ0fIcXUjC9fbl7MpApEIbRVKOw7kZtpZf7M3QK9zbt9tyud2gC90lABmABwpNPmulC7NecoHZlaVCwaSiBQAP2ubHSm4tKbS+6wXpu+yRplfqWoZGW6Zi2+8I6jM1mFkMtFvczMucTksLfFCkIwLh39Y6I2IdeC1szF1IwsVJdFUrxTJYB08uQnhibueFynQqRMLPjMag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102130727099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yDD3Qj6kYqfi/VU/FP8+v/WJLIUsJPe6yhPa3SEdHv7AUmhDrepyap8OXiu2?=
 =?us-ascii?Q?kOLyF15134YxBY7JzszdOFhoGv+owXo02Z/3BAeeJRrJNAdoCQ4vMPW6sU36?=
 =?us-ascii?Q?s5PpZjR63mELaLGCWq7hEZ+5D3IK8taxdqh3IJxLVKjSxVuOFGsJcmtCth/1?=
 =?us-ascii?Q?JoPyDEaq3RshNCgQEx0aiTH8P+GzjQjf1/j5+tUyqAgtI2keTo12NoU/AJwm?=
 =?us-ascii?Q?SyHkTVZxtDXMCbZfP9wW8KEbDl1jLTL7uy43rdAJFnY0e7vdAaZRKT3sUvhB?=
 =?us-ascii?Q?2Cr8aYpFozuf02mlgaXbiSY8Fmacn57enjAFlCXEQd83pCW6aka213y5MiKA?=
 =?us-ascii?Q?FxqhwU/VmGop1VBRZzcFhruiWtHTcODgklnD/VdcvSJPRiyHr/BoXUYPl8LT?=
 =?us-ascii?Q?80lhrOi18iP4/mhzti/qjBJvDF63RSfY/Zd3J7ZKGeVv+7Xh4e8gG1GHIGJk?=
 =?us-ascii?Q?vG8tfhznp0BGBrTpzqvCBe/ItKqhKZKNl5pZo11e50lKMXlVqKpr18D2DVi9?=
 =?us-ascii?Q?q3w0tmd2IVXRKFQ2Y4w6ZGAKF0WpPJstaqM7vr7RASLb+qdSr+LH32rj3WZu?=
 =?us-ascii?Q?JcsSjxultslP1yVAdo368l7QpsDbWtm+0zlYVIhILJE6Wgn1Ef1PzWe7rPcf?=
 =?us-ascii?Q?6fq1M+xEMUgNP4q+9ML17uUBuwBGRPy+lSEPXvwlpGlflyZM+ozCEUy6ANq6?=
 =?us-ascii?Q?hzCAA25SFhd5T0+sm5OrhLoAM7LsNQsPXr9lygGRCz923PujdINyPN43aENz?=
 =?us-ascii?Q?eCC+iA+bOafosvjJRFonvwr/4smgIpsptbWumXq2nUKp4wT2AGjfSxADWEdb?=
 =?us-ascii?Q?FtYHZTyDcmmy2WT4jJx6CsyX62/DK20MMnyyaaUz5+1ee0sPZYjawULvazMa?=
 =?us-ascii?Q?DVF27I2PXYgTBsJfbET4HzDJ/8+58ZcP4gyJl7ZO1Xm4OGI/YTDsK3tsxlWw?=
 =?us-ascii?Q?iKFDil1PuZXjrruunlVdAZs+lyF/In9sglXfyUJCL0RLmH60EoCdLHdkHa5l?=
 =?us-ascii?Q?pUXvsyVp/LqZXyT6Ir3Apai1qUJ1ZcjMskoQG/McAU8qaSG10I7pawL0ORMv?=
 =?us-ascii?Q?PeWhO5LIWe4X/KixukJ+nJ1ZiSJyI+1sUYmuepIRIB4r62DQayGB6uAIVB6v?=
 =?us-ascii?Q?WGcI+mzrtz665yFj/IxxumhmuOSo79G+MMBaIuBLEcm7sZ9+LClqfJZSBqWP?=
 =?us-ascii?Q?nXGJ7/Inr+n6h36/ey3eAUOJgdOBgB27hBySvk5T4OizkU10tFdIQL0UVMfa?=
 =?us-ascii?Q?k7MbhUP9aulVWSgXLaZgIF0HqloZivfgn+ufIwJnP96DpKlHGrdtkrAYOxOG?=
 =?us-ascii?Q?AZmdG6StimFmmRMkc7IhUbQe8D/fSozkM1Qo7oaL8G2TkZxlvjqVHrpiIx9b?=
 =?us-ascii?Q?in94iocovTmAATCLudwXE1azi9YfWtFG1/XzUuY3lUtOzFsb2fvg90aWbfF8?=
 =?us-ascii?Q?YfQ3kLmksjRcUDO6F4OSOJqmzYLi5fUnRDspg6hDDPlI87JL1MKLgytFg3ss?=
 =?us-ascii?Q?/i1VErz7P6Xu04obDPYL3fz+lMa37BtPIeillD9M3AUqdUjnhrKubF/2NQ+Q?=
 =?us-ascii?Q?oEKfmnWUTP9egvYbuYmwKpyK09Wj3mnLCeceNrbxtVuqGZZE4IPaV3xU0zrk?=
 =?us-ascii?Q?qdOnUVVDKTUuFkfefL6bkS2aEfH6YR2xciEWj6j4IdNspeehBVXmBlpBH32v?=
 =?us-ascii?Q?b8bTVy+L4TbgTaU0vJc/iYtlneQXWWRndr+fMKX1s85Wvkho0MV6aoIuv4VK?=
 =?us-ascii?Q?cqdgWpzDbxZreujO4bAyAqLBu9Wc86HPsKUnh4YtkFTpbO3fgwFy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f3939d-cfe0-488e-9e7a-08df4c3436db
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:05.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWd49n036DrzPVTr6ecMAhVLNgbOmc0uKg/AUCx3G0g5hjnehmqPHg79eobQZVbOKEE6ck57Hi2iFydDiydBoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

dw_pcie_link_up() reads PORT_LINK_DEBUG1 when the glue driver provides
no .link_up() callback. A callback that needs a platform-specific check
on top of that register would have to duplicate the register read.

Factor the check out into dw_pcie_link_up_debug_check() and export it
for modular glue drivers. pcie-rcar-gen4 will be the first user: its APP
link-up events remain latched after the link goes down, so it has to
combine them with the live PORT_LINK_DEBUG1 state.

No functional change.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Shawn Lin <Shawn.lin@rock-chips.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - None.

 drivers/pci/controller/dwc/pcie-designware.c | 15 +++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 12f102f48d5d..0f6b896b3b73 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -819,17 +819,24 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
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
index 6d788aa00011..f665643fb3ed 100644
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


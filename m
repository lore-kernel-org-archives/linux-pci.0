Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021116.outbound.protection.outlook.com [40.107.74.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E84EFFC1;
	Mon, 28 Sep 2026 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614389; cv=fail; b=CcYKRmmX104Ih5AJ2s9K2t+bGZIu6NuLiZV0durnUOHvgjDBmBKPBL0LF1cO8ownBIw2fQPYKLi1gFNgWAvOLgEObM7d38xscfGafDom6MZUhNuhb18+1IokaVfFO6/BSHGDBIRxau2yrBSvB5dJLLeyIJeeOzxabWuiSG/zBno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614389; c=relaxed/simple;
	bh=7oJ4HPryBK8FOJu1efpQLT2AGBZ30XPFYoPtflRU5Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsmcQUt3gfv79iNlw0qgUC9ALazoywkx/bik3XgN1Ioit95r0AYhBwKWojcjHkvlRuz1QfVMCnaLXodUgqTqp9kIpBRongT/9q7QEFfn9heewKRovZe9WTMK5dPxIiYDZHCMGjvhaNqGUnhjfvnbTUA/ZpqDcu+TgP64tRPS5WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tlgb+ONq; arc=fail smtp.client-ip=40.107.74.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tlgb+ONq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EldyoVOm1Lj17aQQ2e7qSiZzwMd21LY7hp4Uahsi9ojioONNEc3kL7JmpqubSEZ0wXXtfevL9lKwxEo/dFeQ/lBa6aoYvF/Ot3Coc9ZPVSNGr2YwAJlEEsEGd/ZUL5E6P53F3EGBEMcGvCKT2iXV1zB6g/4jFjWGi3uQa782QnNtkK72K3u4yoH/RJmLzhaURw32V9Poj2WggJnJg+oL9RgQ/p2pNxJbY94r4FDlH9mY1Dps0ZIlklcGduBzlsKakbZ7O1vBycDwf9UtPpyx8t5AT+orAakpEwLOKTYIpclRsF8JW5kqBzPmqooiXqihXUkXYgpyO7I3FF10HAtEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gGWBcUlBQYXI5xNEDsOdVTSHCmFpgRqkVwPWQ8IESM=;
 b=KyEMABBena2sfdMq86Qqbywi+mRju5sECVOqvGJ1qqICaIBpGSOTm22zQgxwPLwPT++SITvvFIveFB47fZOPdLen+/+LAdOyWe1ZIG36ocdAw2qEiEw2tKWrCtKwdW/aj93UmmmRoZmaUGUruH/Ql4N47CHII5dhKokJfmTx/U6erFouYhgrSo2v0XpFNS3F/RqmldFKNp0E12bJawmAdxbUJ5fZ9Yr8hVQOSj+XGcTI9/aMk3UTlkaPdWhyFMkmx6LQRiNMWyzEwazCRwiwQHLThMxgdND9K4eCHAdT95bJmhPHbijirDhrX6wDIbsSGagnYQFf863+2MZ5E8B6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gGWBcUlBQYXI5xNEDsOdVTSHCmFpgRqkVwPWQ8IESM=;
 b=tlgb+ONq23bM2agqm0+OwlvXqnr+OcdlPnaioCPVKmqKQfZI/tJBGkuLyEHOgMl1Qk9VL577mzB6q92GVDBcEMTmZ5RUrDGzXn15dgkoGCttvmE8gMYJnQq77WNv6qYxzTh91tCHIsFsSOygyOiZ2gWh5EfN75GXpSBpOVwXzSI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:01 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: [PATCH v2 02/15] PCI: rcar-gen4: Check live link status in link_up()
Date: Tue, 29 Sep 2026 01:52:17 +0900
Message-ID: <20260928165230.3397664-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f00dfc-bd0b-4a9e-8442-08df1d80f50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aHGHQuciy8h2fpCM9MzkIRnbYiqfBk+rp7TsepA0APh7VRfLn5cQHSb1MHQjsUpyKagC+zVpe3/3QcimR9/b1Ho9FOqeCgeVfOcY3i81BWRzfbxgAX6GNYrRd6R5W8AjYBPTz6XtqgANI9Qi7Fet8qoIqlhGiRzUxRY+NKDMAuUzH2FWWk5bj1wjB2u/yl/Mfou5039efnjJt1TyNmnrzgYUdUnbgXAMk84qSGq6bM93PieDIkpLsy9hoIblxtYyxdAkrS+HmZKkuAmaE909FF0QnQ2LdScg49zunSm28MVKbCiMvRNzNc8R/fvAR1CerK1tXWDHpFJLptZ/xNOZTi4FpgtnxQCyAWyPh4ml8yegBRtEVs3deRSaEPpS6kLaR5W+3n7CQVIV9cXbrvggFr7U5aJKc2gfaBHjtgmjJUEmLPzSbMbf6y7ZR2Jc7RLs5PDxtqbbh2sglUgkcgrPr3SiyeqpyYJIMJvG/zcH9vgxJjN1Do714t1hkf8SFkeWgvd6Nj8R+XcBGOTHlPGXtKK5DgNyVm85OJR+rV1L5CGwUpd3KMC4gvDVGMHXglxi58Qao75OdNAXJpqaH3WAVBCtzDTJUoihZ1tjyAlxGqZuEDXkT9XzvvD0W+ZIhe1jNRA7tLttYS+5Xstbrzrh5WdPTnSS0YJ2aVLLpo9O7M7tR0RIxnCjd32Y4rPOU48vQKKXf7anUX54+T9iMZZEyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nQovV+WU1tBpgZpE6NAvE/mb2GVks+5pl0xzFy8yX1cVknFDFQdWyXEWoBR?=
 =?us-ascii?Q?ORxeUefHQMfx4SwZSmTDqhbY0Bn07G2KNUZ1hm655R8XDyuos5ZqjrvcrGOZ?=
 =?us-ascii?Q?5nRVQhKinp3Gu0BP1Wy27bqGhZTSZ7kqSS0F/Ch1DGPq3hx42rcjcmsIS2rw?=
 =?us-ascii?Q?2OJnxescW10aZI5/DSQoBQJjJKHc5I7oBqWHUBTN8J2h8iQIIsFy6pWO+VGm?=
 =?us-ascii?Q?nd+LQzv3Cl/QCJKljqmsleLd9jRcz4720hv5afitDhggShBIaKnWRbSw0mua?=
 =?us-ascii?Q?21/bC7aNHU7mb3QOgfpBb8VAzz931V1dAm3hwHURKZg5VHB8HbuF4UXIxYUE?=
 =?us-ascii?Q?cwIXvsP5bXmcwhFKvRWNFJVNK+tDIvRHCJ9rdKpQ9FEK3in34VFWO0Jq3Z2z?=
 =?us-ascii?Q?wmzW6HyNxhrI0QXSM4Gb4tGCGEkddBLauQIDrVEyvqIehbDm6OschUEEXi/m?=
 =?us-ascii?Q?j9C6pOoxJ/H3b/RIqy21B1YQRHlPWONJZziZrtvWA6AV+dDLgZReUZgCn0Tb?=
 =?us-ascii?Q?iidWEu1eSQa39rur5bynH22n3FpH00UOCMEoBR9HnBRf8naSHx+9IbdZ44/H?=
 =?us-ascii?Q?MOD1LtO71mhDVLphRdmbnaJr3wQbhPCHG4ry3qlsbUjFPHIUmFyyGPIjqrlA?=
 =?us-ascii?Q?yEVZGm9GsmLZTOwdDvQNtx5UvxxUbVUmcOPX5bFcIQROEkPIJiadugSJviPu?=
 =?us-ascii?Q?C1PIrkfZ9fqn+ypHUEtVK7djMyk5NZTFyoi+UV3pXLBbUF5OBTSQW00hqQyP?=
 =?us-ascii?Q?MMs1KZ8+D0S3KVuREs/oApaco/jx8Zt60JwObER8BbzAv38uaAnSlkaG/q9H?=
 =?us-ascii?Q?91FZgRuepDuIk6A8K3LjuzyklkAYorinkEPKNPbcqEmzzgEpfbrtLnGNaAct?=
 =?us-ascii?Q?XUkWqjruDBPxtZhQ31MlA2ifLcY6LJtX2NhbnkSMsm3PWV2nLgzHvA5lzIRX?=
 =?us-ascii?Q?/Jw+EE+jv2tdLZ2VBPtG7omfsOyPwN83IntdXim/IvWIN6QrztUUxaoFSIRO?=
 =?us-ascii?Q?4ptOCcUXfwClvhvwefOHSdDPFSeVBr/exeb79CtaDcDv4mW9IjqRfmzE0XAw?=
 =?us-ascii?Q?hi1+4gacTI1X1NCPCb8hkO0sQ8tsSXlhcYbIqEKe+jU0NRfg54W50wgHAmWi?=
 =?us-ascii?Q?lFGS9O9cokdEtfPt5XtO9hFJGkIg8g6N7zjbgEsm5j0CXrrw/+Iz82h0aJdx?=
 =?us-ascii?Q?NBnvB2bgYtyZh/QAyCOpgh+/xlt81UFBjMt7jqgY/UP3BGeIEYSo6m5EiXKT?=
 =?us-ascii?Q?J/N/RaUU7ki45Qi0pNhq5J+ThLwgT1YWfatXP2YSPoVhFjvU9scXEGaxer6H?=
 =?us-ascii?Q?YEYcHLUHa2x7kYsy0WXWp6oJpEnV6t8MjMVFEYDfecMAKU5jbWuqZV96KI97?=
 =?us-ascii?Q?kou+C66wnMK9ZfKcFvuQV4+rwz9CGYOBQ+72IQTSfwQiuqqB/0T73am8o7CM?=
 =?us-ascii?Q?A1Wq6XQBEalbyKn3n3Vqg+iP5PChJuyrX8cuOdDrCGMgWYqTLrRsHwpxONFR?=
 =?us-ascii?Q?raq2/X8zUeXFsOKDTHXLLeZIgnLFZwi8JUYgZXdIK27cF4GZ/qUXfZrhUJI+?=
 =?us-ascii?Q?8tlAU+UJOv6ERqF32fKMFhAfSglVLEIB7X9N8q+RsLzgPhEw05OtLM+f2pOb?=
 =?us-ascii?Q?hwJ2IwDIYBYL+nOFZel+4jpXd4f7aB8xAC6kDGIKhRlKevpj1YVTKReD4DHF?=
 =?us-ascii?Q?cUSOivdlAgD9ZVI7jnmkQCfU63HwTArjJaCtjMCUb9Zd344zoC4eYcDiHPJD?=
 =?us-ascii?Q?ri3Gdh6+VYp1IiAd1mVXz1Fu7pGylR5k9DqEJdW4q/A4I3pWO6f2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f00dfc-bd0b-4a9e-8442-08df1d80f50f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:01.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1/tfxrTrJOcjXgAzbH9QG/DZxgPs/0eWhyeaDrvjrDHUC4EKw+2X/W8x48e/kH7UBPkqIx0CQnNTyYLYcRUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

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
reference manual, but also require PORT_DEBUG1 to report the link up and
not in training. The callback then rejects a downed link even if the APP
link-up events remain latched.

Clear the APP latches before enabling LTSSM to discard events from a
previous start, and only read them in .link_up(). RC startup uses
dw_pcie_wait_for_link() to poll the combined condition.

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Keep the APP link-up event check in .link_up() and combine it with
    the PORT_DEBUG1 check, reusing the DWC core's polling. (Marek)
  - Clear the APP link-up latches before enabling LTSSM and leave them
    latched across .link_up() calls. (Marek)

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 21c3dd9b8891..4dabcda051a5 100644
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
 
@@ -120,8 +123,13 @@ static bool rcar_gen4_pcie_link_up(struct dw_pcie *dw)
 
 	val = readl(rcar->base + PCIEINTSTS0);
 	mask = RDLH_LINK_UP | SMLH_LINK_UP;
+	if ((val & mask) != mask)
+		return false;
 
-	return (val & mask) == mask;
+	/* The APP link-up events remain latched after the link goes down. */
+	val = dw_pcie_readl_dbi(dw, PCIE_PORT_DEBUG1);
+	return (val & PCIE_PORT_DEBUG1_LINK_UP) &&
+	       !(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING);
 }
 
 /*
@@ -208,6 +216,9 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
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


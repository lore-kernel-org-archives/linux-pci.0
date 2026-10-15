Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D33806CE;
	Thu, 15 Oct 2026 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035080; cv=fail; b=hrE9N8b53Ez2TfrL9mWAgXpEEgben1bJ5GkNs1yIsLoBKalKKyqTytwpVF+NfapiEW1Pp06rJVVGawOnRKyRbmIPrq1qnhAkakrTzekRFh1yOFNSVH+vaEF4gbZXDS1aZT20h7raep6k/9OmGr8VuadMO87ijmG15Z69EuN+7Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035080; c=relaxed/simple;
	bh=H4m9C1DHOvSInAOg/gBDvW7JqdI0zQ8UEDCb+6vS0Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=STvjwjGKv4qWC13O/26Gxuc1sR2LFc2e3gtu0rKO35tALaqL1dmm+ikhZYTs0xv86DXtNE90Ml6MhSCKiiNkjnrgLxdJiMpQBy/phDSMsp0stdtLm1tDDxuK8hBlv312se0c3rSioo/3aXA8kb7UsCpFpE6NGe3K+okpCX2JuuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AHiidKYz; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AHiidKYz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6YSRc1FeS2n6eVf4XQQquFKKUmXeUsDLb7owpQWXqDOnNNkEuwll8208JJK323QRDe+wJqmCQCN+NMizU4jWn+LvTkkZmTi91+SuP/0pZEY9EysyZgUn72V1D3QAvffuJQEh7ppuMjgB3jF7WgZaEo5zRKCNVG1KevDTbnoQxTgIy8qZCYtxQ3Yqum3KdN5nT8CdZk0T5yJtxc3y4SfuMnQCuUIosYzdFfE4Tx2g1lSrbxsrROeUzRIQ+cUQoAMEXrhfbXU7mz5nVNGJu3RzkiXqaz4futUhu4ZWQNbazy7UOOnM+10l/Aada3xjZWC1XRvxZuki93tr0TsOuNnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvnMUhfWMYq3mjz7vZNf+fLI8LIO2XMXBtSYEMU3K/Q=;
 b=PQDcumJvCcjqRHXx+w4cApf+DqlmXJN6NEpfASZq2w0cQmaiE3atJQqnszP/5rfpGqFHmsGmy1q8WDRZWWTF6+XlPIdjBKbZ1U1yS60QsRp+TNzjrLFsDcqx6dxpdXV1oojtor3N48ycwJLcCsPpzjAE+4IPnuAkOOMurTQRNm3xJyghaBzXfBVD7hg0/dVw4wSgNZyoSgRJyCqRWiDaBAuR3iXVdkOgfvel/hORrQm+wjW/twqAs0TDDf7Hd+3sJS4x4gnK0pGcEqEzUBb8mcX4jWsGOeaxphazBQg6BwMjRuk9lguwMoI3TVkcx5T1zcKxuRk6IRALHfL8LTvB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvnMUhfWMYq3mjz7vZNf+fLI8LIO2XMXBtSYEMU3K/Q=;
 b=AHiidKYzhp+ypVt1tnqCVjJGg8hmtRDWMmoZ9NR+Xg0C0ApHDB5Mc61fZvh5TaUt52VzPBdA/RkKbmEnlDjAGUqWkHModY3D8cIWHVstsrHOO0palz9nJF8CTXdeD89adGikm04UENShrY4wwrr7W9CdGjeP7JZlArJJX77HShc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:12 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:12 +0000
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
Subject: [PATCH v4 03/18] PCI: rcar-gen4: Check live link status in link_up()
Date: Thu, 15 Oct 2026 12:30:48 +0900
Message-ID: <20261015033103.3076869-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0173.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c11a2d-2f11-41e2-9b02-08df2a6cc2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jdzWANcfE5XMAfN/YPTaRnd2oazQNbC9Y51iQlROm2DY8R/exw1PIRqj8YPXI9pv8FvbqX6SlCLiuPTL6X73M50UMKC0fUhBZqwaZafKST6im/STt95Awm0GAWyuU339ECICXcTVC+SNUIr+ws0EjCUzi7Fg9IP3ikvAbFQtJb5e13plU0EREFo3xxdVgJqZfY8BSH98CZRWoS6qSm6EQZcv/CjZsy4Pyeih1/qYHZP+8HKIsDYBP6IVhl7PwD0ybqEpI+ny8k7m1OEjax3KN6IcpvHA0+D9eBcslP8m78MnyiPnfvvjkpMbeBeC5J60bUJPYkOtuuyFLp/iS9O14Za5ysSTN15ZYV5nC5qCTVjkG7G/wNtj/77dI1Ai74IIw2DEGpsjZLGm5DooG8iXz92t5qp8RPJUeYKhdTyNgeWuxikVd/5I8ODBt17R0+ojMTgdwbrPbJ3UQd8wB8+yyADfKZAHSP+7hu814Oa/4/XZBrTvBx48WKTNzIPw2ICrOEt9bljDxkS21gdSvdMVINir/bOjIVrm/Y2IXJ8h7p3hzpTgipyr/wiB3UvYlJFtGPg+P1bXOZp+cqCkoZJdT3fmXSp0DHmg12gutBnEqzS721VIGUPrTSnuccvg9hNAHg/PYetvlkPwFI4ZSF6UL38RG3/A7r/1BD6okcTDx+mI3oc6TKS7MBItnUpxpEGQDSt3oiZcz8tNEdQJkzFneA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mpUD5fBK68QCR+fgt8sXsF/veh7bnNp6k7tvQm/ycvKyS/GmDNNRWlIjD3QC?=
 =?us-ascii?Q?sfRVrDAWaeAmrl4rC3+jY7YvHq0dfBExTqL+FW/zYMCRH9xUYJENZjWRFQn7?=
 =?us-ascii?Q?MNvE6lNc3LazvMw2qFkGAKD5ivyoZvvDY/s3CMrSN0edSEWlwwNHIQXFA9wA?=
 =?us-ascii?Q?GT8B8cf9pktnIaLp+WAM42DFOSjQyVov0KzvLG1MkfNYZz7IVltMbQWNPjVO?=
 =?us-ascii?Q?i2IG/o1Z7W1OFFLxEHdh7WYlLIbljafRwd1S4Kidj3Z4Oo7vjQ41/lg+k6ke?=
 =?us-ascii?Q?rZQPDGEFR9cZ0bMRySztzTPsotCWcTNFKlZtzqFPxZbVHEH7YlHGDiCkCaJ/?=
 =?us-ascii?Q?DI396RmtVdiDOt62KL5zARAAGJQiRrXqW0zTHzjdiX3XmDoDraz3tRcjGWM8?=
 =?us-ascii?Q?oAZQLy/hlPNHuZDSjPmbrK8AU1yarpkIR8wPgQk9ieXWEgoZx3gbyxoQI17V?=
 =?us-ascii?Q?lnQ9EmLrEMXSU8WpaIxpc+QWQ3fPtx3eVGWU0y/BwQ7Da2oDOPJ+77xfvB9q?=
 =?us-ascii?Q?SyrvUCGqS0YjASSMUOMH1s9WjBZjjoJTFGIc7P+TR6Y+MSWJ2JETW8KJ8swb?=
 =?us-ascii?Q?8w4o520bc+QzKXRkv8tlhPOiJrzj5PoRawmMQh+M8lobiUIRo+oDB8kTOaQI?=
 =?us-ascii?Q?uFtYsgUDzo/AwXcyqUQIVHLedfcPQfkVzkFPeExa1YbDQwdbA97lQmdZ6VxB?=
 =?us-ascii?Q?Cr7e1HKtgiZHdn7kUVYmzJyborWZIz9Um7RKePJRgzpAzCnyvY8X8Xgc3085?=
 =?us-ascii?Q?OtpG6b2poe1Cf+WdkFnyXRLHaxV054bbXlYiMxdyaYJBIqM7fPCRlhJoabaU?=
 =?us-ascii?Q?VwiDzaPoOJGQflfgsmsAtiYRvWofRUfphWJT2ifVIs3VsWaWsDu2tOOvraeI?=
 =?us-ascii?Q?7r1849mlVDKK4bwc2OwGGlplAUkv2BglVlgrgvi1iAucY+E2FR0eCAw9w6MF?=
 =?us-ascii?Q?SfkyOZENt02OloWHjoBPlfnWQGOze1l8Hc3hUZqmLYhwGvSwOvVSZKxk/JSA?=
 =?us-ascii?Q?5JEqMs7FGexQleRbwg7ZteRoBjLF1rgqthvfsgQXM/QOpaPdUwQOUYcRMWbV?=
 =?us-ascii?Q?Z5vnl6V7HE3xCvcCdwzGndmBQQXYnArAwup46wW2DKwC8I5hUn9tPqW+sAVt?=
 =?us-ascii?Q?xTp/XqUV9Bsc5e9C71o4GZr1cAs4YRCKdpeoo83q8guu2t0oMccWCXOBOOkI?=
 =?us-ascii?Q?vI8bw32gkbjhbTyHJh4NxpV1iWJqcpfqGBucmx1F5spP9Bd4hDIxDywtcSUG?=
 =?us-ascii?Q?rU0iSfmgP6JQ57eFgMt3o55RG4g9RkcszRSLXQLY3p0ZAJjcWM+264RKG7TS?=
 =?us-ascii?Q?1q3yIMQWwUjtKH7TB8Hb6WgYe9x7t9TLjJskMIMVl86rr/1Davp3bVkepPMv?=
 =?us-ascii?Q?5a8bpOQu0HnpLUfl6c9w062aFXxpY++XsDxiLDMOCFQTpHIrKkDcvTAyJbdn?=
 =?us-ascii?Q?096S5kxxCaqwlM6KZI6TV77DKNu26Kxl1PQRDZjlAdWaOb6LsQ6/jvux3Iwy?=
 =?us-ascii?Q?GY2aL3sPF4zyHjIhUoy27waKVSlkmlV132JtyALBunW1XbJF98zV607D+j4v?=
 =?us-ascii?Q?iCWNwDH0QGJV3XtGqDQk76J8JdqxOorZe+AA3G8l3q4UmZkchm5J5P1Kinwi?=
 =?us-ascii?Q?wSeifUL3U/iNCzjQJk29OSpNojAk7lgMK+zNIxIj5tou3i/b16xTwXjIebFK?=
 =?us-ascii?Q?UZQN37fy0d182oxUdu4L22/+BXCkMgIaOBcYLIu5hGNv5i21KcxXLvcUaNHX?=
 =?us-ascii?Q?cAmX/BfWt+w5n4R1+ianKsga3FzGHRsvXAHVPqJ00iILgQsABCwx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c11a2d-2f11-41e2-9b02-08df2a6cc2c9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:12.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTJaLIQD+i0hqsiRUoUSYL/WhRexit6DKzVh+gfhVA6DIcyBIt52LPfA1czCFxuao+xbvcZ6qotVSu30Rj5bQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

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
Changes since v3:
  - No changes.

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
2.54.0


Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8A8C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 20:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98256208AE
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 20:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="clEwHx/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98256208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeJBDgp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:36:45 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:43648
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbeJBDgp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 23:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymB5PaIzpYK0nwzhnzpVodOjLoOtudQBTHMNfisUjmU=;
 b=clEwHx/RA0ATO3RUYi8Wrgk3XvseShlykPp9H1bGjsOKzkSWxgCChppKYiwkt+O669xsN5HGwl15voq3ct+xY/mrc1JVATmNMZEk+16KDiyUaSXUebF0WkzTIsp6/IRjpfRQjSPxrjT8cN54rB/yTVbvB1WxdwsF80HP1dxoqbU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 1 Oct 2018 20:56:39 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH 3/3] ARM: dts: imx6sx: Add DISPLAY power domain support
Date:   Mon,  1 Oct 2018 23:56:18 +0300
Message-Id: <a55920b698eaf64809440613315f3182374282e6.1538426534.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538426534.git.leonard.crestez@nxp.com>
References: <cover.1538426534.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0058.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::47)
 To VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d730324-33e9-4bec-505b-08d627e06381
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4303;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;3:BaB2J8eLOxggXcJya6sYLTgGCYIHuMQrfCswXswU9K5wob31zp44qYybhHqGPZMwNnuD4AqF9cZEoS5GKZX0iJKZ8I597hVi38F5SR/ZsqLQdiMNRTenT66yE5Slj8n8csPNSzADZSFGEng5jao4I1pnFouLyJgvr3QTNMKWR69pi5pTPXhGsK/Kz/6LHC2HniWwCdcsO7Y5Vta6Qd2qmjkCsj7o/P7YE9lllcHNIDDlc9NDwlZi2dR+E8uAoVYX;25:Thrr0QJqDanckXaqm7pqOWhFplWBgL6JYuyxSX2hZ1/Jzvm/YpEIicINs9st0CAZjb7ZgYkWVS7h3Kg0iuuyercDRyLUOLHEw/dvvvwZvA/JSrbllQDrovQJ1CWiaRoo62eDeTMX46ls98YO6uU5ZMEdEaDKUZi9v2HLHh03mlCA+DqEvK0SZUn2eMhpbzO0Wp4gYUoxFXE/4tMGlzKGrEPWIm+3y+SlSqvk+LOiAfp1635XVwrUsWXvXDzucDO+wPbldLxQwfCnP6I2tDfUgWEY1I3h7x8Gu7zWpa1VqV7E73Ty5xxcnhTg5azlD3uxdh27Ny8qw/Zu0a3APf18WA==;31:G6RNKzmvq1BiYDgAQ3D3DmNgWz3zal0kq3w8R4Zqxzn6OO16TB3HtUuxt/a6bNyL/Hv8vDu1Ze3uvFPPbWc78eeCB9J0zt5szjZvHPkmMIxlUuw+q6wCThbNWYHJwWtsdX30rvqHyBJd2Zd54mzmiSNm+SpwE1ulgwl5y6N7MV/lEkLfVYHWN8GzVzLtwLMTitSCt5flambE69fsxhFiKSFfAwuB8hIshBWvmYNdMiY=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4303:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;20:sXIt6zJ0UmqZxBbOJ9cn+prkgButbhczs/OONwX5yaX/oHTUjzCedzFqLhFKe3aCIEvcDcCD0hD1dB8qYnS4YH1MEpxHsWTOFJmh9HVt8wB79D5FZQltA/D4Syzm1vXoMGROQ96b3t6CZRTD8LB6O/GBTd04V1u5u9j3V+zlm6Vc7tw3FJeTRbFRwHkoy32b3y8c03PXwQhP9CN6/nMEC2qfENqwoNaLa0h0vuMFVu1LJ08WESVCe0FIG8zVQ4f56CeHZIwA6Ze1ufdbgZ05+4g6fFvco0HYytOXLtgdjVm4IJhl1du6hHnMdDLuewGk3Ulk1bDfy8IpotkZ0RNTmS4LXLzA0u7kAzKhg7sruw6xBt9eQQaabG5/Fp8A1T+D48SGQkRI/6PtvegDhLJfkZPSUAKaNWfC8IkEYuQAyM5t/Vs4RZV02dzRk+wGrXUflhtYWCjZ6TzVbaCvjFOcFj0NHZUMLmJj09oYnS8VYiwxMWuRnXLkd2GtT5JO/2hf;4:pAHT7nuzttfrzKHOEen09rhG38Dg6I/JfnNDR5JnzoaB/W+GN2+8/irMKZqG+XytmyTwjiD4GXABFUvMll6zHzl0radof8F+AFK5hWKysnbcGP3r+XV0F3Dk9Uz3qWTkjnJU39hnIHG5QtU1Hii0KPBwJHdfx3C3oV+VLS9cTmnRIKcxMqmIoKvHJBexJt/eUr25Crtnbe7w97r7qdvfaj+iCaKZR4ANKEDORHNvhIAkbwyjhdLyFPkXtazxC3izk5J2j5f0oe/LURYd/+K5SY5N9g9v1MeyawAowF1jFSaIW84s3UnWnoSqDWYX7ztqoXppWlyDakR2qPUuDrQPYlejedepWRjA6qIcXiNXt7I9SQwlB7LjgS1axXscVWA4
X-Microsoft-Antispam-PRVS: <VI1PR04MB43035BD30100D7CB41818B9FEEEF0@VI1PR04MB4303.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040)(17755550239193)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4303;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4303;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(5660300001)(6506007)(386003)(316002)(3846002)(16586007)(6512007)(36756003)(6116002)(53936002)(54906003)(110136005)(86362001)(52116002)(51416003)(76176011)(6486002)(44832011)(11346002)(476003)(118296001)(2616005)(6666003)(956004)(2906002)(50226002)(68736007)(8936002)(81156014)(446003)(81166006)(8676002)(486006)(97736004)(105586002)(106356001)(478600001)(25786009)(48376002)(4326008)(16526019)(186003)(69590400006)(26005)(7416002)(305945005)(14444005)(7736002)(47776003)(50466002)(66066001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4303;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4303;23:JIB9MITefDIOAcV8yJOTs6TaYeblI7cibgLeofd7D?=
 =?us-ascii?Q?rT+9qisZBrkpgVDfof3hgVh/Zf3wbduIZO9NlOzmee+SC92yZFfjN7+XP8v/?=
 =?us-ascii?Q?JhUEeMPYg1KLbTit27lFHMeDJvp5rR1DGqUYiq6kW3/0Oz45y2NdKKz4qQU/?=
 =?us-ascii?Q?ZxJD7DBFrufstBsJAUmw1ICdS/Ai1Rbroas1cjuMHETG5AFDCcwYgewDi/Es?=
 =?us-ascii?Q?VzY6tRMnzmQ74Yd7lJUCTcntdXDj5NVYmb+g2aejMfTpNd3XmlxaZoY1UofR?=
 =?us-ascii?Q?AdE6hWivTgZa8aR3zWtl1i8D0i3Yojwl4P/JmdiWrNNoSqu3O4coQts+B5sT?=
 =?us-ascii?Q?lUCHFKBTDVEkJV36qLfphlIEiScugeMnV2WMh867DrSNQzWb9/a8N7CLaKSL?=
 =?us-ascii?Q?KJnK+aVUL6VV9y4oaldFkLY6X/J9IKKWLK4r+PCfg3c1h0/30W8xACZWVCSO?=
 =?us-ascii?Q?zijFdmCnMsFKZVL9+u6VpOP4DpqC6K9EOO5NojJWSA871SXNlWkwWk6esOWR?=
 =?us-ascii?Q?AJP186coU7YJ5qO2rKe1WJjqGKUIi35UOyY+33hxotAtbRDLZT6IPkAnRp9B?=
 =?us-ascii?Q?T2rdPvEKOk1GcBUMEoXW2nWsdCMhXWJQHpPdXz3wyEpZ9nnwCJ8NPSs1H/Id?=
 =?us-ascii?Q?hDOVl18hVMv8L+hP8r2NS+IOznetHzP7LTpOY02PE9Xfjy05ijR42A8fGSvX?=
 =?us-ascii?Q?5tuvENucC1a9VjvpKNo6VGx0JPz+87XkWyZfzztbcBvTPuCST/Z6A6RzDhw8?=
 =?us-ascii?Q?UxPZVP0+OuLYuXXYE9CnXNnCw6d3eDOLiONc8Cf6WkD+3Q2GTeyw9eOw9ahD?=
 =?us-ascii?Q?kF137TpnqQ5VjFDzJgyO4GYbLNYOK22DRoaT/r8pfjxMraX9SpWHx489J9OG?=
 =?us-ascii?Q?phn+gteWhWgzSGMenR7JKMESMHQ+iiXH0WrNlaFKtyx/dQLfXJnXE4ujBkFH?=
 =?us-ascii?Q?H2OcnS9fpI/gb63d4Tre5NgMPg4X1SXnTGUfCRlGhXrDslZSZ6LFPYvU/YNN?=
 =?us-ascii?Q?JfrvtWnX/eJ9f8Rsjx5hoM+jvWX2y15OmFAeIu2moCZaWmr4uA+usx+yb4T6?=
 =?us-ascii?Q?zO4njjg0IScU3hicQsWXj7FdfvRWpwULo5/1UOH0lUnh7oQ6pBh/ugFbfiuz?=
 =?us-ascii?Q?Qzprl7hfEVZiSB9lxtOJhEWbDfVy8Md7gFz4PeyoCxC9F88mUDfkbe/UKZvM?=
 =?us-ascii?Q?pTm/vWeBgV2GePPb6ylc58jjpvnZ2Qc8SwqR3lJN4uW9PNxoKNbgFiEuBy1j?=
 =?us-ascii?Q?zKlS2tBjH0sAGPmTjxL/IgEV8zjlEUavQi83Uu4QsNoR5o0Ec3M/T6HTtZwp?=
 =?us-ascii?Q?8IGTme4V3kD+KqL5BwGieYTum7BirMBHNpGIfwR8JvN?=
X-Microsoft-Antispam-Message-Info: tbRyyntF8oL8JicH5Qw+LjVj8AV0XNutwqdscg3ACihSY/nd9TX3oNitCPw6g7z5Bj+PeHEfdT01DkS1jqhymrg7C2Uh1OayH4L8kARNh+9PSX0+BLO8PWGLEFSfmMXfnPRNis0v0qYUUx9TorbSEIFJ1bCqeCTdym/aKd5hYfuSNB4pWSPauN7qsgD0ks8WTTbQImwpUXVpkoI1M3ipkUtjDlmEq59OHRvx3wavkBk4ArjauL4jAEuWa0rdjRZyvdYfb5OagWk2T6OQ0NPYEjuEhM2W5FL7dz3lUCDWvKViUk16f4hWoxJccHuZ3+RmwgdXKA/dfv4qUdO8ruwCDmi88LBJR4Hc9bpJeg7cNlQ=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;6:FCSs6itT49M28i8I6/i+rIIsyO5r0Y1oRHE42KmFumvdWJkgVSReXdhGDckaVyQLPR/JSGQkqoCvLMTKg5+MLPV0lOKz7LRGgerix+p09jkWR3uCngdiPjVtQOKPAJHB4eu4pUdOIGrdaQ7zoXLtXnE+yk/Yza3OCfsmvawBndZLKqg2ILRN/nLuOsva/AEnR3/EdW5b1psR4UtaBxa24XAEhYQRILLV3ER7pVpKNKSgIdm9NGY3fbNzM+82D7gtDohmXfEiLWZYT2TzeASiMmTk1DD1oMVROQVUT6rS1ywnlrafsP+tSCR+RL0gDvmXn7rzL1NJ3r3FmUzYg7+wHt8Bi3PeyEGmSbBlR2dXBxMo7RD424CJIbKBKS5ZG9ic/2NtegjVDLUTSHI9FOfJKX+MsPVOBKXhZZTk/Bc52AQswVbPiS64OrQpwI4tPxvAO8LMoD339Jx7iSx/4RPSkw==;5:BfNZ9MD7NCGQt/Xew64TxoE2LYoSZ3aicGCOWJ+vt6XBSz9nMHknW65QRRy7xXYuTc9ytntpduZbelZ98EqU+xzFtt1Q3NcEzfJwmhK3HgOQfw2MnECGJPZHsggxqXenRHVoYP6v/0eHGHM0Yb7at9/4y0aHxoV1TfJaQ6gA4Jk=;7:UzyxbruAuy061QrSGbTYbcrP/TzCzQU8aqbSzX0Ygcnl7AVKWz+AVCeiC4v70Cxs7/eIzki6K7dpwTwYfDZU25cL5fgP9mmu5JQyApIVfRjY36LLIGMEYAFej6kfHDZHcnH2JMOQ8TkGSp0yCe7I15TKVC8KsrtDREzfRL/D5nqvmR5mtUuJXZ6yxsrT3HIiYtEXBMOTDQ6WDWVPYsa2wAB/VohdZAnpdAvDJ2318dUncweZSPpfZkjaUOAsUWwC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 20:56:39.9611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d730324-33e9-4bec-505b-08d627e06381
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4303
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This was implemented in the driver but not actually defined and
referenced in dts. This makes it always on.

From reference manual in section "10.4.1.4.1 Power Distribution":

"Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,
PCIe, DCIC, and LDB. It is supplied by internal regulator."

The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
actually inside the DISPLAY domain. Handle this by adding the pcie node
in both power domains.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 844caa39364f..054d812bcdbc 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -778,10 +778,22 @@
 						#power-domain-cells = <0>;
 						power-supply = <&reg_soc>;
 						clocks = <&clks IMX6SX_CLK_GPU>;
 					};
 
+					pd_disp: power-domain@2 {
+						reg = <2>;
+						#power-domain-cells = <0>;
+						clocks = <&clks IMX6SX_CLK_PXP_AXI>,
+							 <&clks IMX6SX_CLK_DISPLAY_AXI>,
+							 <&clks IMX6SX_CLK_LCDIF1_PIX>,
+							 <&clks IMX6SX_CLK_LCDIF_APB>,
+							 <&clks IMX6SX_CLK_LCDIF2_PIX>,
+							 <&clks IMX6SX_CLK_CSI>,
+							 <&clks IMX6SX_CLK_VADC>;
+					};
+
 					pd_pci: power-domain@3 {
 						reg = <3>;
 						#power-domain-cells = <0>;
 						power-supply = <&reg_pcie>;
 					};
@@ -1196,10 +1208,11 @@
 					reg = <0x02218000 0x4000>;
 					interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_PXP_AXI>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names = "pxp-axi", "disp-axi";
+					power-domains = <&pd_disp>;
 					status = "disabled";
 				};
 
 				csi2: csi@221c000 {
 					reg = <0x0221c000 0x4000>;
@@ -1217,10 +1230,11 @@
 					interrupts = <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
 					clocks = <&clks IMX6SX_CLK_LCDIF1_PIX>,
 						 <&clks IMX6SX_CLK_LCDIF_APB>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names = "pix", "axi", "disp_axi";
+					power-domains = <&pd_disp>;
 					status = "disabled";
 				};
 
 				lcdif2: lcdif@2224000 {
 					compatible = "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
@@ -1228,19 +1242,21 @@
 					interrupts = <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>;
 					clocks = <&clks IMX6SX_CLK_LCDIF2_PIX>,
 						 <&clks IMX6SX_CLK_LCDIF_APB>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names = "pix", "axi", "disp_axi";
+					power-domains = <&pd_disp>;
 					status = "disabled";
 				};
 
 				vadc: vadc@2228000 {
 					reg = <0x02228000 0x4000>, <0x0222c000 0x4000>;
 					reg-names = "vadc-vafe", "vadc-vdec";
 					clocks = <&clks IMX6SX_CLK_VADC>,
 						 <&clks IMX6SX_CLK_CSI>;
 					clock-names = "vadc", "csi";
+					power-domains = <&pd_disp>;
 					status = "disabled";
 				};
 			};
 
 			adc1: adc@2280000 {
@@ -1361,10 +1377,11 @@
 			clocks = <&clks IMX6SX_CLK_PCIE_AXI>,
 				 <&clks IMX6SX_CLK_LVDS1_OUT>,
 				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
 				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
-			power-domains = <&pd_pci>;
+			power-domains = <&pd_disp>, <&pd_pci>;
+			power-domain-names = "pcie", "pcie_phy";
 			status = "disabled";
 		};
 	};
 };
-- 
2.17.1


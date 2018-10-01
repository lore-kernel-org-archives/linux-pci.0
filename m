Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0315BC00449
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2732146D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HYKCGtAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2732146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJBCdq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:33:46 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:27854
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbeJBCdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 22:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE02T3NF0OMwiCd3gGCJzQo6so1FKO2ay4f+uK6vp90=;
 b=HYKCGtAmwW93lyQFz3aR2jxTbQKxMWjuEYPZlszoHwebAd+9gp2wZiFbye5muut1ZTfMRME/8nebYFl35hM3gTrDpsNgTTM5QiHv1uFBsHTeVY/+eKfabfOFtiur7rqFsYYxl2Zv/osmYuRbHxD1tjhCP+1ePXl9idYNtqdJV8Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 1 Oct 2018 19:54:12 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] PCI: imx: Add PME_Turn_Off support
Date:   Mon,  1 Oct 2018 22:53:48 +0300
Message-Id: <1cf53d188657bba7df06ad417eb2a65160238196.1538423063.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538423063.git.leonard.crestez@nxp.com>
References: <cover.1538423063.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::23) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 385222db-8617-4c5c-67de-08d627d7a943
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:kMwniy2bcErImPN5gz2iQMQoMgSxex9vdvZcIbbV0/co9cGyaeJMvg68mV3Yy3iJ6KbSnw6JcjC5vQPcMA/3P9Zd657EzECM939zjMov3g4isHSQ3coQjxYrXk/6Z58iTOpIIpb0IjJG7hwcfafzC45oEu8nF9X1l476mRJr/N0j4iXR1tt2NkxLb1WpTSngJJNzzm3mngJrRHGMIzMm+xImWUoe46IZutpTb9EoCTBbybPHBslWtVNXjKrJ1HxI;25:qFB/tQoEkDdrZ4yyoSfDp1vaFXmnnSdDMUmgAt5/AchE6y6kriPm/1X75ljFe6sc3HJ0nm9194N8HhvgqPy5XAncP6JSrZhZCUzHiok3kz9zY4WmIV/GRIUS2i2IKLSARXhV3u8zOHLrajRltYZ6U5D0EnArh4jgJyKfJtA+e4u7XcZyCwtvU/BxMmrUor+K9vYoamPRA5Hd3SsS3xQmlGAZktVdW+fQJ94QcFsAm1b1Xqpnxs03vdsnzN1+8/kZ5sI8kuYEKt0He1YlmJLyB7e1JltSalhf0kuubzwF+sxQfhPowKabnWTQCUsuJ+d4D2lZSTIxRm8jw5rlk22anA==;31:yNwHAxHrxs/VS/ZSjttTivxhFl7nf22tg1gOTzPAOkVPcqUDeg5sOMDci0ZjhWm3gF8joG5AGne+BoiANuw4UQ5mPh/OXCW2kXNY7aI62jL27SVkMQZF+aXuND6aiMs2ID7SCU+YtS79XR7Vu5APC1n/RrGAn24lF+2ithtsdcGPfMfR1NoDPpxbfnIfiQIDL556kAFAgw6IuqwcoC8iAaWKcOfH23qme6U8nYuckP4=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:gkTBm1PycUGQNAZE6B6g4OQjr+KO8B3JKUzJ/It1K2leqnJy5VfZwDmjfmr73BBXzics9RK/GI3b1nJzqlSNdmfhklswKeucvenS4nxTGUq3Bup0I2mbcaDDJ9qRQbLlBIxhOvNvvWP5UJUwhpOGoege9BvHYZHe7YYC9QMYXWghd0iViDDJutNqPkWgdSFLzp3onw+6pbLTXWUDFhvjUrrslTs9427EUi6c2VhzyeeKvpp5UXB4MRcdfQK9hDeGw/oLEBmKMvyNWkSwwlnt1Ss7prcDKwAKf6jk1CWpC/rzRyYUOQ8hIMZbVlAF7uuEZ+284v6UtYBaraNMVraeFaF4qUZ7voYz0LK0qEQydSrX0eHauemmUEb0jWvdrQU44y9LH/lMhtkRIKp9ezN1JZmnkiL5HnPubBwDxlfJBVU4Dkiqxq7JQRmBDazSlpvNU8fAWHozAWxqn337rPPf4ZBDBA7S5xZo67tCN4qJT60nyegp16xTG7t/hkshAXhK;4:JcofM1w2zG+a+ruez0XErVIRFidEIWRjREfatCZDSboOXW1TWXEuOKiFe/s1q4N5iCwsUhRB08BWYkskAlCzX/3IBtzduG3+L7ASDWr4Jm6W8Nzj5qYGsTeRmSSBVhdo83BBZSdsylNGBFRxDhxVKgg4wPZgHWYe4weB6/T4xSSvLZCMHm4G0NMcmcLcbO2y09vJBBzPW6s+l1zbDvLXfpmQYv1xEDxXd6K+ZCP5Q3VtOxrIx8tPXum47nMn0KigH+3UFip00bZqqJOEvK4Kyc/8kWLfgRli9pFhy3M/RIUPoYkZeNhp1f3cY4xohJ8C
X-Microsoft-Antispam-PRVS: <AM6PR04MB4293125922936F9B2D680501EEEF0@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(6486002)(7416002)(110136005)(54906003)(118296001)(6116002)(53936002)(6506007)(386003)(3846002)(11346002)(478600001)(105586002)(16586007)(7736002)(50466002)(6512007)(66066001)(47776003)(25786009)(956004)(486006)(305945005)(476003)(48376002)(26005)(2616005)(51416003)(52116002)(106356001)(6666003)(2906002)(39060400002)(97736004)(16526019)(186003)(14444005)(76176011)(446003)(44832011)(86362001)(5660300001)(50226002)(68736007)(69590400006)(8936002)(81166006)(81156014)(36756003)(8676002)(4326008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:Xth8zTxM+7cihlgt7cNZhiqR9uXoQkBpuYdPcO6kn?=
 =?us-ascii?Q?MVMPep9Mnc9+QussgVgVc5TWG+vHQAvsJGBx/yt+F0G2U2nvAK29tOebrtg+?=
 =?us-ascii?Q?wruvYp4QGmTDfr8CNfcjyORup26pXZf2bfZCUkxQ++255W4mdYS7K0Xvw5Kd?=
 =?us-ascii?Q?j8Hx5ukf39ss1/w7OWsj/VJYGg6+nB8vJBmO1w/LkHdiO5iVwKDtv92I1b4D?=
 =?us-ascii?Q?MW3F9gVZAGn7qYJZkRTSSTO9V0yKBG4vEgbB0RhAWOrOjQhNqRq0oZtSYvFm?=
 =?us-ascii?Q?5YYLnSILPQuntBjS/A5WD5MlnZAbQufHoZsXYnV6mXpYroKnbQ+QC2HO2cLO?=
 =?us-ascii?Q?eC2S+Zc4eIFXi7NWEscGqodAEg5EcVfRX8RnRy1UNsrALtZxVOlgumr75pFk?=
 =?us-ascii?Q?rnyk9azeNAe2jAl0wsImefW2D2EQej50iwogTjg6fgUmE88Z1s5W9daHMUaQ?=
 =?us-ascii?Q?91OpO7OOs/MDjvf8Qj36gAmvLICqCXd2xY9j4PK3Wb9Io5gPpQFWGnn3t1wA?=
 =?us-ascii?Q?+FEUCry0L+qbplEmT7HX28sBxQgefZC9qOXyJ1aPLziazQLO5AFME5wNyTQf?=
 =?us-ascii?Q?KLoqTl653PWz+yqlFiD7t6dhZagP+YTzmkMsOSy2cEvHdKNqla2qfnLdXYDE?=
 =?us-ascii?Q?XM7ztWnC69wQdfsOaTVg1knlOjhuB8cmtLft6jZMBgFmTaR3zzErzpEawwJB?=
 =?us-ascii?Q?TtsFK6Bxc3Di1T7wT1diAFKUANzFz5xDQnsv3cHScWHMQeWpgSlFPQUwQJOw?=
 =?us-ascii?Q?wW1Szh0BApkLygmchmxNlXuu79dSXSCjDxe6N4kOVZO5QVwXcp+Ldt1QgnUw?=
 =?us-ascii?Q?W7mx5SuffB89WyTagIBYCioNJXqBVBpcjIsebhRcKvISACWP6XsNopndKdGd?=
 =?us-ascii?Q?0wQy4PdXL5g0+XRB1O+X3xhsFaSQPK388JQW59ECucRy9RZNQ60tqjxDw9NY?=
 =?us-ascii?Q?QywhkGbIJ93kCM+PTO4RpEbbane5rByURYl2cnxo0ELIrh9hYcZ1hFZpIKA9?=
 =?us-ascii?Q?T+9OaloxlzJHtZhSmpILrWmEMayjvYamLuUGLt4zDEVQHBW6qVfBG6MrUYKT?=
 =?us-ascii?Q?HUWSlkVhys242tqzh2B6T/FvzCtUU3EV3rGoMhxVpWs8QPxs7Yqnkb6M8t3/?=
 =?us-ascii?Q?anVY1o5+LhIZCT4ZOfOuq3SMAJbG8y/NmPNLxGFCuuz20GCHOdqxVwDbgYpq?=
 =?us-ascii?Q?IjKd/RoMXlGs3uY9n42PefUFUBA4Op8kd6YYLgJ3rTVJ2soOGmBcqqEE47ea?=
 =?us-ascii?Q?WUUBSQzAkFtD880sLAWJVOb+HJ7FDCEDRLLwURB4MTYEyZiVWmVDI0CohHnN?=
 =?us-ascii?Q?K444rmt0HbbgxRaCk8jgQU47rEIoUAA3cPMB4YYHae+fWtsqoDKCE0KFwdYy?=
 =?us-ascii?Q?msu0Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: u3U6S42CjcA2mWXuxf7Gc+en/ILUlQQLsHe5JNAlRa+LUMMq7BDXLz0j8LTqoLCgl9/KjBwzt92q76sI9PnIIFKCg2sfCjUsuziUUBenm2mhefe0W7wCpbZiScSzTPNe8Ix1pkO6zFABT/r1s09lFXfU+uvMyfoGWdOSuxfnlzvkn2V85nbTEg2NVHh1rXywRGD04FWAVNskm9H/lZdPkNJBrTtCepQZNOEWVDGhALt9PcZCOiiLhexY1k30NujqecbHsJ7caHBbjaDlszNc7PuSyZ6OfRbNhp97+lKgnMJRjSq73doYScC0wmrG1ORz6J9lQu7l9nVh9loiuGJIZa4jplrkaVDMfrEl4tY1iPo=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:/WeSOAeTq9AZnUPd3tbyFdTDZAfHbqsQjICbM+7iv5t9dMvFjd0SukS2EAtKxoxqIx/8yRSIdbjQ6n66hOJmEPHxqA6PYQ4zVd/+oWMiL34QMrO3kNM5RHhVdal8qpCbnSQ0AcUGHzOBahiNsqK4+hECG6bljzNIo2DcTasPeI/F743BZkeWjFMh00V+3sy+VZvzIs119AN+o2EoiyOM5ZbRraQwl/nFyHE9+j8DiUD4vwVAgwiMk4/umdVc96tTaCbUoV0EWIdmcJydkkJX6/GS8OmCqjEc0Xr4mwXtk2oS5d3x+nsu/i8jUVJtuV21VsKrthUpYuBJ9JpB8SeP0G5eoscmQk5fG8JsBXRw0aaF1khEfLMzdlr7TVRh2VZaaLTDNZGz/nDF3kFboGv+OAdpdz045X019df2nqvjwkir4xs9ZEC//g9+af3Fjknv3FyTU1eSvE/yPIwhK6fszw==;5:+qZE2b0IGpKUqRefMhl2GRDInZxCPlooMi9tIXqFJgtp3xqW/XGsCe8/bAyR5jnzwT2pXyZJ5pPiLX4C33jxtgvKfq202/XloU5hZjh9lKmCu24wWexaG6uiY6E+268Z7FvXlQOdNE0nChGrLKVN2x2Hy6nTVv87TbFT7Qz/UIA=;7:Pid6INE0105bQlgbiAaUDU4npHp/Xxq+5Ob6ERlmLN2WWQtNGqteNhkGGdfLe+qU5OrjJRauSB+PnaU9PercD1M9OdvBgOuEbAJ+ZO9nY0KcVXaUL0Ic7OaujPVx/cBVfTpCphqVqj0fDAfOkSrwz4h2Yh+HLszJAEqVv0fqjt0bNjCfpVI8znb85JNdaHMlfEOpWXRBNGel+QIW0XiDFhmG5FTzlme/p78qHvtKFdIkOa19qReNoG9dSoPrHcbM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 19:54:12.1816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385222db-8617-4c5c-67de-08d627d7a943
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the root complex suspends it must send a PME_Turn_Off TLP.
Implement this by asserting the "turnoff" reset.

On imx7d this is functionality is part of the SRC and exposed through
the linux reset-controller subsystem. On imx6 equivalent bits are in the
IOMUXC GPR area which the imx6-pcie driver accesses directly.

This is only for imx7d right now but it's deliberately implemented as an
optional reset, ignoring the chip variant:
* Older dtbs won't have this reset so it will be ignored.
* Future chips might also expose this as a reset controller.

For example imx8m (not yet supported) has the exact same
PCIE_CTRL_APPS_TURNOFF bit in the same location.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6ba16fd1373c..13cb1a200442 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -50,10 +50,11 @@ struct imx6_pcie {
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct regmap		*iomuxc_gpr;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
+	struct reset_control	*turnoff_reset;
 	enum imx6_pcie_variants variant;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
@@ -812,10 +813,16 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 	default:
 		dev_err(dev, "ltssm_disable not supported\n");
 	}
 }
 
+static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
+{
+	reset_control_assert(imx6_pcie->turnoff_reset);
+	reset_control_deassert(imx6_pcie->turnoff_reset);
+}
+
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	clk_disable_unprepare(imx6_pcie->pcie);
 	clk_disable_unprepare(imx6_pcie->pcie_phy);
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
@@ -832,10 +839,11 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
 	if (imx6_pcie->variant != IMX7D)
 		return 0;
 
+	imx6_pcie_pm_turnoff(imx6_pcie);
 	imx6_pcie_clk_disable(imx6_pcie);
 	imx6_pcie_ltssm_disable(dev);
 
 	return 0;
 }
@@ -959,10 +967,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		break;
 	default:
 		break;
 	}
 
+	/* Grab turnoff reset */
+	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
+	if (IS_ERR(imx6_pcie->turnoff_reset)) {
+		dev_err(dev, "Failed to get TURNOFF reset control\n");
+		return PTR_ERR(imx6_pcie->turnoff_reset);
+	}
+
 	/* Grab GPR config register range */
 	imx6_pcie->iomuxc_gpr =
 		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
 	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
 		dev_err(dev, "unable to find iomuxc registers\n");
-- 
2.17.1


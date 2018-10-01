Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DB5C00449
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488AB2146D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 20:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jfxJc2Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488AB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeJBDg1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:36:27 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:43648
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeJBDg0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 23:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5Z5lfXTiW+4bRSBkYYtMeRmSqfTS2wgVljtRSIrkXM=;
 b=jfxJc2Q/Xk6W8mP98DiqjD20mW9tWKoKZFDHRiMsED4XQmnUBw2iYmM6t7HTYd3Gn4dhzqJtpswcx1NVyIkeOJ/C6QOe6ffgMQ8zfw/E+81mdxSycJKjSB9Hl8+8cwB4frjB42NG1P4ghz1O1/QlQoNK+I1AlwmcbToWQWdWXno=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 1 Oct 2018 20:56:37 +0000
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
Subject: [PATCH 2/3] PCI: imx: Add multi-pd support
Date:   Mon,  1 Oct 2018 23:56:17 +0300
Message-Id: <5832128f3b1822839a0f0bbd1cf8313cf586f15f.1538426534.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538426534.git.leonard.crestez@nxp.com>
References: <cover.1538426534.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0058.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::47)
 To VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a93b8d0-e616-4c42-d2df-08d627e06260
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4303;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;3:tyXX+EsrMnJ0ahPAr7D69lhlvSDXVmfSMunP3XpTnAQkPVRWhMSyDb3/27QPC57bwM+mSo9i4zQBsUCafbA5lWmqb4yrFYsywlmIrVeuSUvUOS58/54U3qDgj490Ob4HTJzjAQ7XzRtM9tBxCI+wTOa4TPkrIBzRCJasWtAUF4mLID0f/Jb+RP+np9l35+ZCrJXzx97ldvPDGRI/t1aR18QROfaU4TUmPU2H5zOklPBMOgwK2aYtsOwVEc2ADETA;25:uGAnbwIlxDCsuRnTv/DT8dxq7gzM8M5CdLX54ORt3/IXToLklaqKZ6tx+jvEBeH7gm7ATO8Mb3L5pbclup5T2WhzX1onvsz1/4AuDfl/9lmqttOh/1lWkrQoXa/DYrCvbQNsT/iU0SPSDIWc9Xp1LIHHPd3ig7rnO0xUMbEibSFqUWbjD9hXDszK2m193mSLStzBvEyYc/GbV1MSI3He8obsSXkE+omGw7rSprvXU53nRJilqiPkNDlrx7WwxudqoeUYVISUoZTBpUPbUGgMhWJodiBmL8y4ax+jQwKzxG3aPYsaPlPaYYxcqOSPQLX9BlZaMPFrfwbkqmdbLiSciA==;31:RZ/cArnFMVi31xZIc8IcHyTioG0bxOmMWkw6Zm/95/KK2WjvWcX6lPr0omOLBAtwYIEcAwz2B+LuRMDmG3AYkPGKxkJfGj6kJcLp73KdiMaI3RlFuJzvB1ErhSlIu8giw4RZqq/meXI779YTkZr1cDaVfsCIkjvVgyA4VQM/XNY12y17Ox8EGUjDNE/2YhabS09UmQGhXgh8EB+AbUJzP74ty923LurY3cFjZfXTF24=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4303:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;20:HCP9wws8uvYRG1rMEi6Lu5SIRrd5GWrGK8NqObo7Iy3L1w24GoSmYZHkZKzg98T5L/qfBv8KIkWdQx0HOn2fpmUHs/DPtoLFOdx0yTZP/NWBjRjyr2PheEsUbPcmJuoF/Y007mu/0qxG3pj6TvsegQtU5lm8evRYW+A3X1KMqTU0VOYZLdVxTVYpzkO26awo2lzpphlGy7niSb0tFdPVIlyAYNU4lZpbcnUCBfP5ZiKCQgqvGvUIK5ZlH6JLsxa5Y3LzzxG9yNDVKTm4igqjLKk/QNqs23u8NJS6gfHvYDsh9FT+hhLjUslFAxgxot0QZS24qoHEKXAhTVsMhm4yED4QExfmO5kGxa3h3YtXME7HdntY8FElSh4voZQ+ZMWBOiuNvYkyulhbr/hy8XJcriSy4DPJQ5kpfEj5Wh2U/ICjKi6qS7wOn+zPyaTy07ue7FLfsGBMTLEEhqNiah1EngLGg60WLWmUMg/IxGUi62ugQhTinSPJUDyf3thTLyy7;4:FonEqQ5XV7EMn/sPrGOrVPH0CO1fgDx4Uk6wrSnkXZ5IHjuwujI5b6OfQvG8jPJ4Nrgzebhx28L/WqSehkl4YAZ5Ga8XyfD1LWdk8rd8oCCJYfVXYDWgDt8Y9JiW3vLbsg26NnRY2Noy/4hF34WvP1tZ0Wo8mypyqImiN/wNzVS756U9yCi9ben/5RfszGbHrhW86tl+BO4vsEeDVHyQ2BDNaP8nobMHV+VJeISB8akeNGZNpNdGB0kTAr7Bvbh0A/N582gO5f5uyhmVXirq7XJTMk5q1IWMCVpHhN/a/Rc8VbMNOWVpltQ4iInEgPAOgiM4v18j/aJ8soAIE0Ii99UHZOJKgWp/z9nKU2xBnZ4=
X-Microsoft-Antispam-PRVS: <VI1PR04MB4303ED36A43C1C5E810B950CEEEF0@VI1PR04MB4303.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4303;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4303;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(5660300001)(6506007)(386003)(316002)(3846002)(16586007)(6512007)(36756003)(6116002)(53936002)(54906003)(110136005)(86362001)(52116002)(51416003)(76176011)(6486002)(44832011)(11346002)(476003)(118296001)(2616005)(6666003)(956004)(2906002)(50226002)(68736007)(8936002)(81156014)(446003)(81166006)(8676002)(486006)(97736004)(105586002)(106356001)(478600001)(25786009)(966005)(48376002)(4326008)(16526019)(186003)(69590400006)(26005)(7416002)(305945005)(6306002)(14444005)(7736002)(47776003)(50466002)(5024004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4303;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4303;23:w6apis3duD/20pJX84fjlpO5ybFTd56Lijp/Wz7uC?=
 =?us-ascii?Q?vUex+K6hwaqTAg3XGGhfeqo97ukKafLcaixHdgqvPM0kFm4sEPcWRsBc41Ev?=
 =?us-ascii?Q?41fEeIiGsIwtEAjdQtLxahCpWLZ7nE/wZCpt5asKawuuF235f5QI9IxuFxAJ?=
 =?us-ascii?Q?NnMQ+ARxviPLWV3W97seThn253KqKI1PgJo2dQpZrUt0jub93BzLYpFLCctF?=
 =?us-ascii?Q?hMaXZe4XNx25dDFo5d+mDLeh6w9b5+CCwqqUBc6dVg4xKl7MjiSoS2k4I4/b?=
 =?us-ascii?Q?MBGbwBYuZ70OK8ilgg5R/6zOn/lRPzZX+/skU0HQ1VTTS1XAbueSW7VNi5K1?=
 =?us-ascii?Q?RbwcSYmLNc4Mo38lav/uXfxOTCla3qtYkU8sFfKU0Pq1W6k4Yt2+/8aCIG2W?=
 =?us-ascii?Q?03ooFFbrfSUj2sTnQOVnubwZ/Y29mLQKwG8f0GWVw7QubLmMC/k3vgB94J1h?=
 =?us-ascii?Q?dlAY8nwpSQUT4RApqeJULzQNoSOY3fnZSb80Ye3ADX3dJWBw0J5oGqAEyjzb?=
 =?us-ascii?Q?Ltw3vJURtbvyAabbZX6cAc81d7K64RPGP94dc4ZXJzIqqoq2VmNAClIkHCXZ?=
 =?us-ascii?Q?jniEHRsaa+objPNma7KJ2e0qQUeDbGqCvw131eubbTMk9FDDOir/L1ShbuAM?=
 =?us-ascii?Q?IHReIM2xymLmJ0Ts9Z6YFz7/xdCPTxfUYZSvJPfOuFK69wWrTwxm3gMcKycH?=
 =?us-ascii?Q?ojWgSFLBxo04vS7J3RJRYxRwJHTT//hn5wWYaHoP8+ztLk15c3dWtn6ExN7k?=
 =?us-ascii?Q?KGmF5O5JRdiHRL5z7IOjRXqye92B6JJhaJZ0JvhDtlOh3FJnwGChaGdYkMDg?=
 =?us-ascii?Q?cr4C39ucEPd1bi9HTLPyRrsNWiH6hn4ypKmnZrziD8jOMb/UK3bRDvQurWk8?=
 =?us-ascii?Q?EVZlstnjCZIgSlv9gwXcV39Z4CkLkXFvsIPlR0tBANhf5HgpFz2nePDuZLdz?=
 =?us-ascii?Q?5kv5pC3+BWGmXKyaNUJ8HFqLx5CDOPMmci6d/lPkRNyTDvGWEHYJJcAg+vYx?=
 =?us-ascii?Q?vcmgsQhH/dNhn22CE5uraQGAfAhHU1oPBUY3Ol6GOYgbPSdhtrIuqY8nQndq?=
 =?us-ascii?Q?5JYocfpsO7doMxVHs5vMVXinyAXcV07EEapqnOwL1ttNqic+LfaE9ZIoYVpG?=
 =?us-ascii?Q?V8fzaaaFsFKcNkCKqLzZ0HcWFmMQE6O/a+6VivAAL+LIejTVZDmcif4DNtAa?=
 =?us-ascii?Q?FibATS7+e/EH00upqICc24zQVj0R0SVK0mcZruzWhMLj88X3gtboyZDrzH5n?=
 =?us-ascii?Q?qSgXp8URHmzR/0vb5vmszkgWovEt0Wjlw3VACGXOq4lqMk4llc4LwFWXiEgs?=
 =?us-ascii?Q?9qL+KM3Wi/qAjspyiuam8fw57+0gJcnKGc6XkYuXLp+KV/P8tiLGYM2JtcKF?=
 =?us-ascii?Q?oLLpUuuPhe38arMcYHdrFIMRuU=3D?=
X-Microsoft-Antispam-Message-Info: YCw2Vq2pWH9/ZqtyKZssFh/Q9lKvlFXlQL/y+ieY0Q27zcFYdNfdGpUXfcOFEW6Gr8G+L4B41jRKlGlceW3rE/y17N6xXGVyl0sM71bvmicVzdjgRyEzcx69vG0RLBCqrNFunBjoRFsSOGmRnBN1Cr6d0YO0qD+HSKy1H0t7bn5k+9ylSo6UkHNibc/1wU760SApNG8y6lVXYGduYnH+U0ytjfzr71B/0MJmOWEHK5gCa25VxCrjN+In2Ps+87H9KPdGqCHzi/rh53YwYrIL3V2te4W8MOC6U17NqSRp82zvdr/gzQmsShQcnFLacZQRM+03YmnzBtFXOpMvX4/8ICIbSazsX2IZUJ2Fqc7F2kI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;6:Ts2rnrA/aNRt3SrtaddJJrgcMCMoAvuxBEKdRtX6nCBTKiUimAPyceoz5+dUKoVBs+u7Wsit3mjWsaaV9BldcavIVozxT+aLlAflL3HFDJ6Og2WPVkiOVKunxFc7xQG1tP+CUPanisMD/WQlesFqdFOKFa2HExbzob28KdurLUYRXS+xvxv9VRU0juhmpWZeK6MxVx9KOjfpZOW8Qdzl8G/DYE/y7MxwJZstYChkzMpNtAMTnQx4pSlLcXbO86Q+P1applbi8zEXKQTq8eUkSBNZBG6PLmWyPsb639jpEDkK5nAHkyPB9NkWoBD9YFwemBCju3Px6kwDxcqeuoBObNy4DNUGWj69F6wKPFEB+1FaFkbVhDyZ3ihvDrfZTK87feSGdZKUewItEDgwNyRARYEy8qIuPOF0tQmBWh+3mvov3oXtjqr/vd2V6N5ogtyd35gilOHjasBr+K4RLgy2RA==;5:0NMVEFoizBhVOeGmXks00GQieKpiR6JkDcHgaH0ivThjKx3EBDMDmGUn+7NcOjANMZAJdI1bmGTYm0hoRyLv2qicxe1gYx5T6V4sBIVXzl3ylVdG67boOrb9gRJ8Em0j/sNas+bEPASMc9hlOf2yAvizbgp/j84qXbtiWFlKwWI=;7:OzCcenY90gUkR64Qe1IwedMyecSzSyG3tXwKajce6ESNDH6e174nxCIzy02iQOODZDpqLCxh7GftBwgq9nkzuzYEjGEY1VZJRkJR1mP8oSlVZbLLC0eBERxE5BF6OaxT9hcjZ/E9w89QmtBvS6vz6E3QY/bQysZLFzaBKIL4th+F2l+4MrgZAVVfigxLeyaLb4fp24qaDgreUo0mtyuPLWSPYVB2K2f3FSB8ALj6SZzuNG9ty9vA4sxpz1A5/d+8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 20:56:37.9298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a93b8d0-e616-4c42-d2df-08d627e06260
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4303
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some chips the PCIE and PCIE_PHY blocks are in separate power domains
which can be power-gated independently. The driver needs to handle this
by keeping both domain active.

This is intended for imx6sx where PCIE is in DISPMIX and PCIE_PHY in
it's own domain. Defining the DISPMIX domain requires a way for pcie to
keep it active or it will break when displays are off.

The power-domains on imx6sx are meant to look like this:
	power-domains = <&pd_disp>, <&pd_pci>;
	power-domain-names = "pcie", "pcie_phy";

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

---
 drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

Previously sent as RFC: https://lkml.org/lkml/2018/7/24/849

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d13dae50dc99..6ba16fd1373c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -25,10 +25,12 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 
 #include "pcie-designware.h"
 
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
@@ -56,10 +58,15 @@ struct imx6_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+
+	/* power domain for pcie itself (dispmix) */
+	struct device		*pd_pcie;
+	/* power domain for pcie phy */
+	struct device		*pd_pcie_phy;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
 #define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
 #define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
@@ -289,10 +296,47 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 	}
 
 	return 1;
 }
 
+static int imx6_pcie_attach_pd(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct device_link *link;
+
+	/* Do nothing when in a single power domain */
+	if (dev->pm_domain)
+		return 0;
+
+	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
+	if (IS_ERR(imx6_pcie->pd_pcie))
+		return PTR_ERR(imx6_pcie->pd_pcie);
+	link = device_link_add(dev, imx6_pcie->pd_pcie,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+	if (IS_ERR(link)) {
+		dev_err(dev, "Failed to add device_link to pcie pd: %ld\n", PTR_ERR(link));
+		return PTR_ERR(link);
+	}
+
+	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
+	if (IS_ERR(imx6_pcie->pd_pcie_phy))
+		return PTR_ERR(imx6_pcie->pd_pcie_phy);
+
+	device_link_add(dev, imx6_pcie->pd_pcie_phy,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+	if (IS_ERR(link)) {
+		dev_err(dev, "Failed to add device_link to pcie_phy pd: %ld\n", PTR_ERR(link));
+		return PTR_ERR(link);
+	}
+
+	return 0;
+}
+
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct device *dev = imx6_pcie->pci->dev;
 
 	switch (imx6_pcie->variant) {
@@ -959,10 +1003,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->vpcie = NULL;
 	}
 
 	platform_set_drvdata(pdev, imx6_pcie);
 
+	ret = imx6_pcie_attach_pd(dev);
+	if (ret)
+		return ret;
+
 	ret = imx6_add_pcie_port(imx6_pcie, pdev);
 	if (ret < 0)
 		return ret;
 
 	return 0;
-- 
2.17.1


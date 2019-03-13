Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0986C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 09:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE762183F
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 09:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZXJdCtFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfCMJPj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:15:39 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:17153
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbfCMJPh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 05:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjoR10OzIhk7mswNnrnYUQodg1g20vpteXO2Ew50RIQ=;
 b=ZXJdCtFitXgInlFPPoy9aPrnTWWLVAzeUiDmUWzgOMH0XUzTBk6m9ykqP/clSNwOWz/Tw9ab1seGWdQMD0yWIWUxKq+yI6phHUzXKWuR2YEK1unLw59MfpH50QWrz/hZfOaUf5pJOTL9AryaQR2ko2HUHDVX/m0xKNRGlamf3+g=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3732.eurprd04.prod.outlook.com (52.133.38.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Wed, 13 Mar 2019 09:15:31 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::c9e:21a8:3eae:bdeb]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::c9e:21a8:3eae:bdeb%3]) with mapi id 15.20.1709.011; Wed, 13 Mar 2019
 09:15:31 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RFC 2/2] PCI: imx6: Add support for i.MX8QM/QXP PCIe
Thread-Topic: [RFC 2/2] PCI: imx6: Add support for i.MX8QM/QXP PCIe
Thread-Index: AQHU2X1O5tXI+QNdtk+AGc08yLg3pA==
Date:   Wed, 13 Mar 2019 09:15:31 +0000
Message-ID: <1552467452-538-2-git-send-email-hongxing.zhu@nxp.com>
References: <1552467452-538-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1552467452-538-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To AM0PR0402MB3570.eurprd04.prod.outlook.com
 (2603:10a6:208:1c::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b48a7f45-04c7-4871-1aca-08d6a79470c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3732;
x-ms-traffictypediagnostic: AM0PR0402MB3732:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR0402MB3732;23:X/lkRLY3RRu3F5ZRTS7KRC/M2bVGtotrec8hi?=
 =?iso-8859-1?Q?8MXMlpQHpf5DbaPGTvCnr2r7iCH7qRrsPRCUN4Pe5crVCttZppps8qPfMb?=
 =?iso-8859-1?Q?2PTEQxjpUtMg7gZ/NVN8CmegciU0jrGDBpnA8XjGTnH1aTLuqlufkb2kD/?=
 =?iso-8859-1?Q?mXNLvm22h1SI/mhY21UmfeHZ5b1GqgEDe4tL2poSSsCHjdRZ5JdtsZZpA9?=
 =?iso-8859-1?Q?LuTe0xd1ytRTxQUtpr6QTBAwTpn7kqTAaWsYkbeGgEjvTyAqEvEu9hZHwf?=
 =?iso-8859-1?Q?lQi7pG21O56t9thQVpqGJc5DV1Gp4+wDyu/p4UQnI2EMhTPQxtF2tQ6KPb?=
 =?iso-8859-1?Q?nPTS1P9/C2kWETEv0MesA2Rbug2Qy+h1ibDVH6wNwfVoZKEjB5oj6ljmc3?=
 =?iso-8859-1?Q?84Asih2rwYYYrn8yfELZ0tnYTGS/t/g718DB/3eQvz/r5cRztifXTC9uwL?=
 =?iso-8859-1?Q?QpbM0G6K3ldu6jJNKm617jqTiYGikW3s4blNmUVoc6gnR8BxxstWwAWfQP?=
 =?iso-8859-1?Q?KxeJYl4EUFA0im/63fKjiL1pSfC0rRiewaqFWb/tpuv1trqeKAuDJf2cxI?=
 =?iso-8859-1?Q?D+zOjfLrL2EzxrZyu1GATOz6mclIrI0f6LfpEl3wZeJ9WoLWHsDDG6R6ge?=
 =?iso-8859-1?Q?Le3gSBUjHdfv2GEB8W25hULSRTgS5RY7wJH2dyjZpH0kqhJO1WM44zGj9i?=
 =?iso-8859-1?Q?ElTwZYuQ6gB7Ix+9qWIm+OIeSzuoE54tkXJLBMYA+c+cOuEmATRESnv7xT?=
 =?iso-8859-1?Q?uc/1VxBs334M292+UCVwVsNo5zWbDbobsnPOH+VkOPwRR+p0gyKlMeoSRd?=
 =?iso-8859-1?Q?6gXm5abuT0tQHue2Ipqw+ojghiSRqdqwkg/trdHKfSPsSVICaXTiNmcAYI?=
 =?iso-8859-1?Q?4/pflgg+eRxYRJmaLORTTHGvO2G0pBDm32Um6WixWqCnzItng0dj63NkXC?=
 =?iso-8859-1?Q?rSYYbIQ3c2M3xs3VAP3oLDjG0C+ouLKJ1xJg5oddu2+F8cwVf7DZHGNEnV?=
 =?iso-8859-1?Q?uWB/b4S/DtygDWe49GBOeq5VA9rA/Ln+3S6UgEHyZ3Y4aHjVpHvWrO1qHZ?=
 =?iso-8859-1?Q?11YGM8HR1mbWT0BSEom18QwlV1ZPMdhVy24ZmanIhyUOHjTIxxXF75Psd6?=
 =?iso-8859-1?Q?LEHdr4I9Cw+MbFYSQv8Sk7IYwwJvfNCsgBTNDBq7UwS34nC+vY8gr8bWGs?=
 =?iso-8859-1?Q?iatsix1+XouzwUIjFXWRExw+szp+q2hoCrrKd017NS+tLN3e2owqhgkdXV?=
 =?iso-8859-1?Q?jd5FFFSAO8z0ecvqSPmvLAuOw4J08ob4YGTG5Ue+7Z894xT6Ip2jDSxJqw?=
 =?iso-8859-1?Q?u9Hnwk1lP3t3nY+mpgtjSMIwZXHzATVjPSEwjvchgAm+RGpP55C5Fcaf6/?=
 =?iso-8859-1?Q?amNxM/KX819jrNrQ9J5S4JZhYE+Eaf+FRwdck/3AmHYiQinRvcM5/Yrg3p?=
 =?iso-8859-1?Q?mHu6SUGW9zsouC6WQxCPef/eUPIYWWX/ZQqU+?=
x-microsoft-antispam-prvs: <AM0PR0402MB3732BE25227205FE183FBE358C4A0@AM0PR0402MB3732.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(5660300002)(52116002)(30864003)(102836004)(110136005)(4326008)(81166006)(81156014)(2201001)(8936002)(316002)(54906003)(86362001)(76176011)(53936002)(53946003)(25786009)(6512007)(68736007)(6506007)(2501003)(3846002)(14454004)(6116002)(8676002)(386003)(478600001)(11346002)(99286004)(446003)(97736004)(2616005)(26005)(6436002)(186003)(71190400001)(476003)(6486002)(71200400001)(2906002)(106356001)(14444005)(305945005)(5024004)(36756003)(256004)(7736002)(66066001)(105586002)(486006)(50226002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3732;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jZGCwHckWLH8sFzuIfAUnYGLxdL2qbO5IPkVX9YAItCcxLHnAlIpEWGtOOL0ZrYhw5q78KGx+/QpV2+9F0d/Kz543t8aAzSp36LrktX7IrxD107n5UpQC7rjArZIHQmX6ZpC8qQOIti12uLhzHfdXeSmhO1DEtjTw9ErqD57gvS4aQg+7/ZNmBYuO08cv7juEu+Qco8I4N6elz9S4Ky2N73d2Al0fGF2k8ViuN13+3SVQoZqT2CoBRf4Yg7d/UniF9B3pYfKp/uT4HEDch1v5b6DUe+/oLA2pXdQto0Z7aICd1BK7k1ab3fuzZSmAjh686sGDq4IMn9k3W0ZEZMTFM3vV1dz3uAVp80UzFzkZV7sxf6oRdtladzba8OmsS6FFPk8P7fwE3W2SzWKIDmxSdacQPWnQ+TOvCodaSbldaQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48a7f45-04c7-4871-1aca-08d6a79470c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 09:15:31.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3732
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add codes needed to support i.MX8QM/QXP PCIe.
- HSIO(High Speed IO) subsystem is new defined on i.MX8QM/QXP.
  The PCIe and SATA modules are contained in the HSIO subsystem. There
  are two PCIe, one SATA controllers and three mixed lane PHYs on
  i.MX8QM. There are three use cases of the HSIO subsystem on i.MX8QM.
  1. PCIea 2 lanes and one SATA AHCI port.
  2. PCIea 1 lane, PCIeb 1 lane and one SATA AHCI port.
  3. PCIea 2 lanes, PCIeb 1 lane.
  i.MX8QXP only has PCIeb controller and one lane PHY.
- The HSIO address map as viewed from system level is as shown below.
  address [31:24]    Local address    Target    Address Size
  5F                 0                HSIO      16MB
  60-6F              40-4F            HSIO      256MB
  70-7F              80-8F            HSIO      256MB
  So, the cpu_addr_fixup is required to enable i.MX8QM/QXP PCIe.
- Both external OSC and internal PLL can be used as PCIe reference
  clock.
- clock request GPIO for controlling the PCI reference clock request
  signal. And should be configure OD when L1SS maybe enabled later.
- One more power domain HSIO_GPIO and clock PCIE_PER are required by
  i.MX8QM/QXP PCIe.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 392 ++++++++++++++++++++++++++++++=
+++-
 1 file changed, 387 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index aaa9489..aacefb6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -39,6 +39,7 @@
 #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
 #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
+#define IMX8_HSIO_PCIEB_BASE_ADDR		0x5f010000
=20
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
=20
@@ -48,10 +49,13 @@ enum imx6_pcie_variants {
 	IMX6QP,
 	IMX7D,
 	IMX8MQ,
+	IMX8QM,
+	IMX8QXP,
 };
=20
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
+#define IMX6_PCIE_FLAG_IMX6_CPU_ADDR_FIXUP	BIT(2)
=20
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
@@ -60,10 +64,12 @@ struct imx6_pcie_drvdata {
=20
 struct imx6_pcie {
 	struct dw_pcie		*pci;
+	int			clkreq_gpio;
 	int			reset_gpio;
 	bool			gpio_active_high;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
+	struct clk		*pcie_per;
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct clk		*pcie_aux;
@@ -77,6 +83,9 @@ struct imx6_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
+	u32			hsio_cfg;
+	u32			ext_osc;
+	u32			local_addr;
 	int			link_gen;
 	struct regulator	*vpcie;
 	void __iomem		*phy_base;
@@ -85,6 +94,8 @@ struct imx6_pcie {
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
 	struct device		*pd_pcie_phy;
+	/* power domain for hsio gpio used by pcie */
+	struct device		*pd_hsio_gpio;
 	const struct imx6_pcie_drvdata *drvdata;
 };
=20
@@ -92,6 +103,7 @@ struct imx6_pcie {
 #define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
 #define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
+#define L2_ENTRY_WAIT_MAX_RETRIES	10000
=20
 /* PCIe Root Complex registers (memory-mapped) */
 #define PCIE_RC_IMX6_MSI_CAP			0x50
@@ -157,6 +169,43 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
=20
+/* iMX8 HSIO registers */
+#define IMX8QM_CSR_PHYX2_OFFSET			0x00000
+#define IMX8QM_CSR_PHYX1_OFFSET			0x10000
+#define IMX8QM_CSR_PHYX_STTS0_OFFSET		0x4
+#define IMX8QM_CSR_PCIEA_OFFSET			0x20000
+#define IMX8QM_CSR_PCIEB_OFFSET			0x30000
+#define IMX8QM_CSR_PCIE_CTRL1_OFFSET		0x4
+#define IMX8QM_CSR_PCIE_CTRL2_OFFSET		0x8
+#define IMX8QM_CSR_PCIE_STTS0_OFFSET		0xC
+#define IMX8QM_CSR_MISC_OFFSET			0x50000
+
+#define IMX8QM_CTRL_LTSSM_ENABLE		BIT(4)
+#define IMX8QM_CTRL_READY_ENTR_L23		BIT(5)
+#define IMX8QM_CTRL_PM_XMT_TURNOFF		BIT(9)
+#define IMX8QM_CTRL_BUTTON_RST_N		BIT(21)
+#define IMX8QM_CTRL_PERST_N			BIT(22)
+#define IMX8QM_CTRL_POWER_UP_RST_N		BIT(23)
+
+#define IMX8QM_CTRL_STTS0_PM_LINKST_IN_L2	BIT(13)
+#define IMX8QM_CTRL_STTS0_PM_REQ_CORE_RST	BIT(19)
+#define IMX8QM_STTS0_LANE0_TX_PLL_LOCK		BIT(4)
+#define IMX8QM_STTS0_LANE1_TX_PLL_LOCK		BIT(12)
+
+#define IMX8QM_PCIE_TYPE_MASK			GENMASK(27, 24)
+
+#define IMX8QM_PHYX2_CTRL0_APB_MASK		GENMASK(1, 0)
+#define IMX8QM_PHY_APB_RSTN_0			BIT(0)
+#define IMX8QM_PHY_APB_RSTN_1			BIT(1)
+
+#define IMX8QM_MISC_IOB_RXENA			BIT(0)
+#define IMX8QM_MISC_IOB_TXENA			BIT(1)
+#define IMX8QM_CSR_MISC_IOB_A_0_TXOE		BIT(2)
+#define IMX8QM_CSR_MISC_IOB_A_0_M1M0_MASK	GENMASK(4, 3)
+#define IMX8QM_CSR_MISC_IOB_A_0_M1M0_2		BIT(4)
+#define IMX8QM_MISC_PHYX1_EPCS_SEL		BIT(12)
+#define IMX8QM_MISC_PCIE_AB_SELECT		BIT(13)
+
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 {
 	struct dw_pcie *pci =3D imx6_pcie->pci;
@@ -373,14 +422,65 @@ static int imx6_pcie_attach_pd(struct device *dev)
 		return PTR_ERR(link);
 	}
=20
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX8QM:
+	case IMX8QXP:
+		imx6_pcie->pd_hsio_gpio =3D dev_pm_domain_attach_by_name(dev,
+				"hsio_gpio");
+		if (IS_ERR(imx6_pcie->pd_hsio_gpio))
+			return PTR_ERR(imx6_pcie->pd_hsio_gpio);
+
+		link =3D device_link_add(dev, imx6_pcie->pd_hsio_gpio,
+				DL_FLAG_STATELESS |
+				DL_FLAG_PM_RUNTIME |
+				DL_FLAG_RPM_ACTIVE);
+		if (!link) {
+			dev_err(dev, "Failed to add device_link to gpio pd.\n");
+			return -EINVAL;
+		}
+
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
=20
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
+	u32 addr;
+	int i;
 	struct device *dev =3D imx6_pcie->pci->dev;
=20
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8QXP:
+		addr =3D IMX8QM_CSR_PCIEB_OFFSET + IMX8QM_CSR_PCIE_CTRL2_OFFSET;
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
+				IMX8QM_CTRL_BUTTON_RST_N,
+				IMX8QM_CTRL_BUTTON_RST_N);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
+				IMX8QM_CTRL_PERST_N,
+				IMX8QM_CTRL_PERST_N);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
+				IMX8QM_CTRL_POWER_UP_RST_N,
+				IMX8QM_CTRL_POWER_UP_RST_N);
+		break;
+	case IMX8QM:
+		for (i =3D 0; i <=3D imx6_pcie->controller_id; i++) {
+			addr =3D IMX8QM_CSR_PCIEA_OFFSET + i * SZ_64K;
+			addr +=3D IMX8QM_CSR_PCIE_CTRL2_OFFSET;
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
+					IMX8QM_CTRL_BUTTON_RST_N,
+					IMX8QM_CTRL_BUTTON_RST_N);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
+					IMX8QM_CTRL_PERST_N,
+					IMX8QM_CTRL_PERST_N);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
+					IMX8QM_CTRL_POWER_UP_RST_N,
+					IMX8QM_CTRL_POWER_UP_RST_N);
+		}
+		break;
 	case IMX7D:
 	case IMX8MQ:
 		reset_control_assert(imx6_pcie->pciephy_reset);
@@ -477,6 +577,21 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *=
imx6_pcie)
 				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
 				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
 		break;
+	case IMX8QXP:
+	case IMX8QM:
+		ret =3D clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
+		if (ret) {
+			dev_err(dev, "unable to enable pcie_axi clock\n");
+			break;
+		}
+		ret =3D clk_prepare_enable(imx6_pcie->pcie_per);
+		if (ret) {
+			dev_err(dev, "unable to enable pcie_per clock\n");
+			clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
+			break;
+		}
+
+		break;
 	}
=20
 	return ret;
@@ -501,6 +616,63 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct im=
x6_pcie *imx6_pcie)
 	dev_err(dev, "PCIe PLL lock timeout\n");
 }
=20
+static int imx8_hsio_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pci=
e)
+{
+	u32 retries, addr, val, lock =3D 0;
+	int ret;
+	struct dw_pcie *pci =3D imx6_pcie->pci;
+	struct device *dev =3D pci->dev;
+
+	addr =3D IMX8QM_CSR_PCIEA_OFFSET + imx6_pcie->controller_id * SZ_64K;
+	addr +=3D IMX8QM_CSR_PCIE_STTS0_OFFSET;
+	for (retries =3D 0; retries < PHY_PLL_LOCK_WAIT_MAX_RETRIES; retries++) {
+		regmap_read(imx6_pcie->iomuxc_gpr, addr, &val);
+		if ((val & IMX8QM_CTRL_STTS0_PM_REQ_CORE_RST) =3D=3D 0)
+			break;
+		udelay(1);
+	}
+
+	if ((val & IMX8QM_CTRL_STTS0_PM_REQ_CORE_RST) !=3D 0) {
+		dev_err(dev, "ERROR: PM_REQ_CORE_RST is still set.\n");
+		return -ENODEV;
+	}
+
+	addr =3D IMX8QM_CSR_PHYX2_OFFSET + imx6_pcie->controller_id * SZ_64K;
+	addr +=3D IMX8QM_CSR_PHYX_STTS0_OFFSET;
+	for (retries =3D 0; retries < PHY_PLL_LOCK_WAIT_MAX_RETRIES; retries++) {
+		regmap_read(imx6_pcie->iomuxc_gpr, addr, &val);
+		if (imx6_pcie->hsio_cfg =3D=3D 2) {
+			if (imx6_pcie->controller_id =3D=3D 0)
+				lock =3D IMX8QM_STTS0_LANE0_TX_PLL_LOCK;
+			else
+				lock =3D IMX8QM_STTS0_LANE1_TX_PLL_LOCK;
+		} else if (imx6_pcie->hsio_cfg =3D=3D 3) {
+			lock =3D IMX8QM_STTS0_LANE0_TX_PLL_LOCK;
+			if (imx6_pcie->controller_id =3D=3D 0)
+				lock |=3D IMX8QM_STTS0_LANE1_TX_PLL_LOCK;
+		} else if (imx6_pcie->hsio_cfg =3D=3D 1) {
+			lock =3D IMX8QM_STTS0_LANE0_TX_PLL_LOCK;
+			lock |=3D IMX8QM_STTS0_LANE1_TX_PLL_LOCK;
+		} else {
+			dev_err(dev, "ERROR: illegal hsio_cfg value.\n");
+			return -EINVAL;
+		}
+		val &=3D lock;
+		if (val =3D=3D lock)
+			break;
+		udelay(10);
+	}
+
+	if (retries >=3D PHY_PLL_LOCK_WAIT_MAX_RETRIES) {
+		dev_info(dev, "pcie phy pll can't be locked.\n");
+		ret =3D -ENODEV;
+	} else {
+		dev_info(dev, "pcie phy pll is locked.\n");
+	}
+
+	return ret;
+}
+
 static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci =3D imx6_pcie->pci;
@@ -553,6 +725,11 @@ static void imx6_pcie_deassert_core_reset(struct imx6_=
pcie *imx6_pcie)
 	}
=20
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8QXP:
+	case IMX8QM:
+		/* wait for phy pll lock firstly. */
+		imx8_hsio_pcie_wait_for_phy_pll_lock(imx6_pcie);
+		break;
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
@@ -613,25 +790,114 @@ static void imx6_pcie_deassert_core_reset(struct imx=
6_pcie *imx6_pcie)
=20
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 {
-	unsigned int mask, val;
-
-	if (imx6_pcie->drvdata->variant =3D=3D IMX8MQ &&
+	unsigned int offset, mask, val;
+
+	if (imx6_pcie->drvdata->variant =3D=3D IMX8QM ||
+	    imx6_pcie->drvdata->variant =3D=3D IMX8QXP) {
+		offset =3D IMX8QM_CSR_PCIEA_OFFSET +
+			imx6_pcie->controller_id * SZ_64K;
+		mask   =3D IMX8QM_PCIE_TYPE_MASK;
+		val    =3D FIELD_PREP(IMX8QM_PCIE_TYPE_MASK,
+				    PCI_EXP_TYPE_ROOT_PORT);
+	} else if (imx6_pcie->drvdata->variant =3D=3D IMX8MQ &&
 	    imx6_pcie->controller_id =3D=3D 1) {
+		offset =3D IOMUXC_GPR12;
 		mask   =3D IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
 		val    =3D FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 				    PCI_EXP_TYPE_ROOT_PORT);
 	} else {
+		offset =3D IOMUXC_GPR12;
 		mask =3D IMX6Q_GPR12_DEVICE_TYPE;
 		val  =3D FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
 				  PCI_EXP_TYPE_ROOT_PORT);
 	}
=20
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, offset, mask, val);
 }
=20
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8QXP:
+	case IMX8QM:
+		if (imx6_pcie->hsio_cfg =3D=3D 1) {
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_PHYX2_OFFSET,
+				IMX8QM_PHYX2_CTRL0_APB_MASK,
+				IMX8QM_PHY_APB_RSTN_0 |
+				IMX8QM_PHY_APB_RSTN_1);
+
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_MISC_PHYX1_EPCS_SEL,
+				IMX8QM_MISC_PHYX1_EPCS_SEL);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_MISC_PCIE_AB_SELECT,
+				0);
+		} else if (imx6_pcie->hsio_cfg =3D=3D 2) {
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_PHYX2_OFFSET,
+				IMX8QM_PHYX2_CTRL0_APB_MASK,
+				IMX8QM_PHY_APB_RSTN_0 |
+				IMX8QM_PHY_APB_RSTN_1);
+
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_MISC_PHYX1_EPCS_SEL,
+				IMX8QM_MISC_PHYX1_EPCS_SEL);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_MISC_PCIE_AB_SELECT,
+				IMX8QM_MISC_PCIE_AB_SELECT);
+		} else if (imx6_pcie->hsio_cfg =3D=3D 3) {
+			if (imx6_pcie->controller_id)
+				regmap_update_bits(imx6_pcie->iomuxc_gpr,
+					IMX8QM_CSR_PHYX1_OFFSET,
+					IMX8QM_PHY_APB_RSTN_0,
+					IMX8QM_PHY_APB_RSTN_0);
+			else
+				regmap_update_bits(imx6_pcie->iomuxc_gpr,
+					IMX8QM_CSR_PHYX2_OFFSET,
+					IMX8QM_PHYX2_CTRL0_APB_MASK,
+					IMX8QM_PHY_APB_RSTN_0 |
+					IMX8QM_PHY_APB_RSTN_1);
+
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_MISC_PHYX1_EPCS_SEL, 0);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_MISC_PCIE_AB_SELECT,
+				IMX8QM_MISC_PCIE_AB_SELECT);
+		}
+
+		if (imx6_pcie->ext_osc) {
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_MISC_IOB_RXENA,
+				IMX8QM_MISC_IOB_RXENA);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_MISC_IOB_TXENA, 0);
+		} else {
+			/* Try to used the internal pll as ref clk */
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_MISC_IOB_RXENA, 0);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_MISC_IOB_TXENA,
+				IMX8QM_MISC_IOB_TXENA);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IMX8QM_CSR_MISC_OFFSET,
+				IMX8QM_CSR_MISC_IOB_A_0_TXOE |
+				IMX8QM_CSR_MISC_IOB_A_0_M1M0_MASK,
+				IMX8QM_CSR_MISC_IOB_A_0_TXOE |
+				IMX8QM_CSR_MISC_IOB_A_0_M1M0_2);
+		}
+
+		break;
 	case IMX8MQ:
 		/*
 		 * TODO: Currently this code assumes external
@@ -763,6 +1029,7 @@ static int imx6_pcie_wait_for_speed_change(struct imx6=
_pcie *imx6_pcie)
=20
 static void imx6_pcie_ltssm_enable(struct device *dev)
 {
+	u32 val;
 	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
=20
 	switch (imx6_pcie->drvdata->variant) {
@@ -777,6 +1044,15 @@ static void imx6_pcie_ltssm_enable(struct device *dev=
)
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
+	case IMX8QXP:
+	case IMX8QM:
+		val =3D IMX8QM_CSR_PCIEA_OFFSET +
+			imx6_pcie->controller_id * SZ_64K;
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				val + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
+				IMX8QM_CTRL_LTSSM_ENABLE,
+				IMX8QM_CTRL_LTSSM_ENABLE);
+		break;
 	}
 }
=20
@@ -908,13 +1184,25 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6=
_pcie,
 	return 0;
 }
=20
+static u64 imx6_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
+{
+	struct pcie_port *pp =3D &pcie->pp;
+	struct imx6_pcie *imx6_pcie =3D to_imx6_pcie(pcie);
+
+	if (imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_CPU_ADDR_FIXUP)
+		return (cpu_addr + imx6_pcie->local_addr - pp->mem_base);
+	else
+		return cpu_addr;
+}
+
 static const struct dw_pcie_ops dw_pcie_ops =3D {
-	/* No special ops needed, but pcie-designware still expects this struct *=
/
+	.cpu_addr_fixup =3D imx6_pcie_cpu_addr_fixup,
 };
=20
 #ifdef CONFIG_PM_SLEEP
 static void imx6_pcie_ltssm_disable(struct device *dev)
 {
+	u32 val;
 	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
=20
 	switch (imx6_pcie->drvdata->variant) {
@@ -926,6 +1214,17 @@ static void imx6_pcie_ltssm_disable(struct device *de=
v)
 	case IMX7D:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
+	case IMX8QXP:
+	case IMX8QM:
+		val =3D IMX8QM_CSR_PCIEA_OFFSET +
+			imx6_pcie->controller_id * SZ_64K;
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				val + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
+				IMX8QM_CTRL_LTSSM_ENABLE, 0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				val + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
+				IMX8QM_CTRL_READY_ENTR_L23, 0);
+		break;
 	default:
 		dev_err(dev, "ltssm_disable not supported\n");
 	}
@@ -933,6 +1232,8 @@ static void imx6_pcie_ltssm_disable(struct device *dev=
)
=20
 static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 {
+	int i;
+	u32 addr, val;
 	struct device *dev =3D imx6_pcie->pci->dev;
=20
 	/* Some variants have a turnoff reset in DT */
@@ -951,6 +1252,34 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *im=
x6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
 		break;
+	case IMX8QXP:
+	case IMX8QM:
+		addr =3D IMX8QM_CSR_PCIEA_OFFSET +
+			imx6_pcie->controller_id * SZ_64K;
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				addr + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
+				IMX8QM_CTRL_PM_XMT_TURNOFF,
+				IMX8QM_CTRL_PM_XMT_TURNOFF);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				addr + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
+				IMX8QM_CTRL_PM_XMT_TURNOFF, 0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				addr + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
+				IMX8QM_CTRL_READY_ENTR_L23,
+				IMX8QM_CTRL_READY_ENTR_L23);
+		/* check the L2 is entered or not. */
+		for (i =3D 0; i < L2_ENTRY_WAIT_MAX_RETRIES; i++) {
+			regmap_read(imx6_pcie->iomuxc_gpr,
+					addr + IMX8QM_CSR_PCIE_STTS0_OFFSET,
+					&val);
+			if (val & IMX8QM_CTRL_STTS0_PM_LINKST_IN_L2)
+				break;
+			udelay(10);
+		}
+		if ((val & IMX8QM_CTRL_STTS0_PM_LINKST_IN_L2) =3D=3D 0)
+			dev_err(dev, "PCIE%d can't enter into L2.\n",
+					imx6_pcie->controller_id);
+		break;
 	default:
 		dev_err(dev, "PME_Turn_Off not implemented\n");
 		return;
@@ -985,6 +1314,11 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *i=
mx6_pcie)
 	case IMX8MQ:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
+	case IMX8QXP:
+	case IMX8QM:
+		clk_disable_unprepare(imx6_pcie->pcie_per);
+		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
+		break;
 	default:
 		break;
 	}
@@ -1084,7 +1418,26 @@ static int imx6_pcie_probe(struct platform_device *p=
dev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
=20
+	if (of_property_read_u32(node, "hsio-cfg", &imx6_pcie->hsio_cfg))
+		imx6_pcie->hsio_cfg =3D 0;
+	if (of_property_read_u32(node, "ext_osc", &imx6_pcie->ext_osc) < 0)
+		imx6_pcie->ext_osc =3D 0;
+	if (of_property_read_u32(node, "local-addr", &imx6_pcie->local_addr))
+		imx6_pcie->local_addr =3D 0;
+
 	/* Fetch GPIOs */
+	imx6_pcie->clkreq_gpio =3D of_get_named_gpio(node, "clkreq-gpio", 0);
+	if (gpio_is_valid(imx6_pcie->clkreq_gpio)) {
+		ret =3D devm_gpio_request_one(&pdev->dev, imx6_pcie->clkreq_gpio,
+					    GPIOF_OUT_INIT_LOW, "PCIe CLKREQ");
+		if (ret) {
+			dev_err(&pdev->dev, "unable to get clkreq gpio\n");
+			return ret;
+		}
+	} else if (imx6_pcie->clkreq_gpio =3D=3D -EPROBE_DEFER) {
+		return imx6_pcie->clkreq_gpio;
+	}
+
 	imx6_pcie->reset_gpio =3D of_get_named_gpio(node, "reset-gpio", 0);
 	imx6_pcie->gpio_active_high =3D of_property_read_bool(node,
 						"reset-gpio-active-high");
@@ -1155,6 +1508,25 @@ static int imx6_pcie_probe(struct platform_device *p=
dev)
 			return PTR_ERR(imx6_pcie->pcie_aux);
 		}
 		break;
+	case IMX8QM:
+	case IMX8QXP:
+		if (dbi_base->start =3D=3D IMX8_HSIO_PCIEB_BASE_ADDR)
+			imx6_pcie->controller_id =3D 1;
+
+		imx6_pcie->pcie_per =3D devm_clk_get(dev, "pcie_per");
+		if (IS_ERR(imx6_pcie->pcie_per)) {
+			dev_err(dev, "pcie_per clock source missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_per);
+		}
+
+		imx6_pcie->pcie_inbound_axi =3D devm_clk_get(&pdev->dev,
+				"pcie_inbound_axi");
+		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
+			dev_err(&pdev->dev,
+				"pcie clock source missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
+		}
+		break;
 	default:
 		break;
 	}
@@ -1259,6 +1631,14 @@ static const struct imx6_pcie_drvdata drvdata[] =3D =
{
 	[IMX8MQ] =3D {
 		.variant =3D IMX8MQ,
 	},
+	[IMX8QM] =3D {
+		.variant =3D IMX8QM,
+		.flags =3D IMX6_PCIE_FLAG_IMX6_CPU_ADDR_FIXUP,
+	},
+	[IMX8QXP] =3D {
+		.variant =3D IMX8QXP,
+		.flags =3D IMX6_PCIE_FLAG_IMX6_CPU_ADDR_FIXUP,
+	},
 };
=20
 static const struct of_device_id imx6_pcie_of_match[] =3D {
@@ -1267,6 +1647,8 @@ static const struct of_device_id imx6_pcie_of_match[]=
 =3D {
 	{ .compatible =3D "fsl,imx6qp-pcie", .data =3D &drvdata[IMX6QP], },
 	{ .compatible =3D "fsl,imx7d-pcie",  .data =3D &drvdata[IMX7D],  },
 	{ .compatible =3D "fsl,imx8mq-pcie", .data =3D &drvdata[IMX8MQ], } ,
+	{ .compatible =3D "fsl,imx8qm-pcie", .data =3D &drvdata[IMX8QM], },
+	{ .compatible =3D "fsl,imx8qxp-pcie", .data =3D &drvdata[IMX8QXP], },
 	{},
 };
=20
--=20
2.7.4


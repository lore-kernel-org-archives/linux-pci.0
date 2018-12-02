Return-Path: <SRS0=dd4N=OL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2224C04EB8
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 13:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E01F2082F
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 13:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yBovSEQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E01F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbeLBNdf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:33:35 -0500
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:1664
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbeLBNde (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Dec 2018 08:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b15J7avgRrNBKp1ifLyguwMgpG7iMhmO1jPjYE/0J0o=;
 b=yBovSEQhtVkK6jxQo7ySI6MO8xTYLt45AV3ggXluCMk5wEcMwxjyIufaSdSndNJM64RWFAfp7wAlGZLITnLTPwYXopNDVeh79HuouQ7aSE34ES5yb4OMCZIeiDWzN1p8mNJ3ctc7+IoRF/ERltY3Tng/UzqZu6xmTmejkbltktA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4999.eurprd04.prod.outlook.com (20.177.33.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Sun, 2 Dec 2018 13:32:55 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%5]) with mapi id 15.20.1382.020; Sun, 2 Dec 2018
 13:32:55 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>
CC:     Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 2/2] PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451
Thread-Topic: [PATCH 2/2] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Index: AQHUikOCDYPDw2LXJ0Kq5ypA4v3+CA==
Date:   Sun, 2 Dec 2018 13:32:45 +0000
Message-ID: <20181202133303.33988-3-Zhiqiang.Hou@nxp.com>
References: <20181202133303.33988-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181202133303.33988-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4999;6:hQ+3CBz+tfD/HHDwWeCpWIhmCikzSjvP22jidh2sB3y/BU2pkPedBO4fIO263Rq0mxxKxiJtvenjXwlJNMKp/w6e95SlHf3E4ECb40K0LNB59txNLnid8G4rJHC3Xzn/mv823hFYFC+79IkP1x3ZHV2BGK8Rbwi/jyIONe9hLg2GH63VPNRLToN2Z3WptcOcHzpYBdBGS5GoI80RJGGSOVjFYzxjWsMA3NLs3Fy3EW/0CaFGfeI3cGr/xobl9eZhCYg2eUPFHH/fu796WjnVopYVCgJNnq5GGd6WWIorJKLSHzzgn8PHK3/su+nowas12Pp4BLY8/04zdZQXGbDiUVJNrvdBtXOGBK0DK0K7P9PnM5EK+uoqkeHMaLLYUnwrs8HLNiR7chGr37rdgIFuL9oU+3MCBlsdF/hHIH4DiB9k9odKHDxQN5K7M5vcNsteIj2X4ytxA8fVSw7CUVPSmg==;5:asJQHPzi3tHb8BTSAMnuxaqrTMrmjROa7o/Fx+0tufINHBiP66d6CGHMzsLdtKiJ2zYtAWmpB4LtFYGpWVuOy674PWiIxH9+jq4o99roNz9pzCzrgqdGI19mLwCtw4srxMlZzQVdKg3LMeHv8euQGAa7/iSC88uptbKidYMGK4w=;7:Ie550BZ5UVgceyMtByQ1RpKHHF5rZuQkSzDVW94oR3TE/+CCCO4uo6e7TIL87N8xB8GSoKxOGNwodFJan07yEe8wG/DYVG1wfA/vO/ZioiVUIGT0lwRYcUeRvGZGIhqdqVvd/uoCL0KOBKdu1kpZ9A==
x-ms-office365-filtering-correlation-id: 8597b970-01d0-44f0-e232-08d6585aa4e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4999;
x-ms-traffictypediagnostic: AM6PR04MB4999:
x-microsoft-antispam-prvs: <AM6PR04MB499955778E82BFD3A7C80D8584AD0@AM6PR04MB4999.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501489)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4999;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4999;
x-forefront-prvs: 087474FBFA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(256004)(99286004)(14444005)(186003)(52116002)(53936002)(36756003)(4326008)(76176011)(25786009)(446003)(66066001)(6436002)(2201001)(575784001)(6486002)(486006)(5660300001)(11346002)(478600001)(86362001)(14454004)(476003)(2616005)(26005)(6512007)(2501003)(106356001)(105586002)(2906002)(1076002)(8936002)(7736002)(81166006)(81156014)(110136005)(6116002)(3846002)(8676002)(71190400001)(71200400001)(6666004)(102836004)(386003)(6506007)(97736004)(54906003)(305945005)(68736007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4999;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F8IFKi6dfeDtePsGwhKf1vmHdddUw2QAJYe+4D4K0ggGDqDHnt5TVq8PJhImOMGn9k5FZBu/cDgvgGYkl+p9sto2GHyfsJ7/ZeDyKe5fQ2UPJG7/6uveVA7iCpvQ/L0ysFMX5aNVCLiQJMiaOUbB8Xvz1QaDY7wHWU+BZqOpvXOr3BzIAkinV6Vcm7APj/DFE5T1rMiZDt0gxiOkH47uf5aW/+5bzgNKNu3hAhViwVUd5fV6pxyV9iFIEgaOCyYH0lzax5WzjwAlCvn/n1JoUNCmXsSxOeIOQ37mONzdXA/GKfbGSHJijTyT7xCv+kU/wgT1aSQHcJyJMmO/B6eOcXQxWYgn1ZGoFIOJl6kbiCA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8597b970-01d0-44f0-e232-08d6585aa4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2018 13:32:45.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4999
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

When LX2 PCIe controller is sending multiple split completions and
ACK latency expires indicating that ACK should be send at priority.
But because of large number of split completions and FC update DLLP,
the controller does not give priority to ACK transmission. This
results into ACK latency timer timeout error at the link partner and
the pending TLPs are replayed by the link partner again.

Workaround:
1. Reduce the ACK latency timeout value to a very small value.
2. Restrict the number of completions from the LX2 PCIe controller
   to 1, by changing the Max Read Request Size (MRRS) of link partner
   to the same value as Max Packet size (MPS).

This patch implemented part 1, the part 2 can be set by kernel parameter
'pci=3Dpcie_bus_perf'

This ERRATA is only for LX2160A Rev1.0, and it will be fixed
in Rev2.0.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../pci/controller/mobiveil/pci-layerscape-gen4.c  | 14 ++++++++++++++
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/driver=
s/pci/controller/mobiveil/pci-layerscape-gen4.c
index 1fe56532b288..ef43033e1c2a 100644
--- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
@@ -220,6 +220,18 @@ static const struct mobiveil_pab_ops ls_pcie_g4_pab_op=
s =3D {
 	.link_up =3D ls_pcie_g4_link_up,
 };
=20
+static void workaround_A011451(struct ls_pcie_g4 *pcie)
+{
+	struct mobiveil_pcie *mv_pci =3D pcie->pci;
+	u32 val;
+
+	/* Set ACK latency timeout */
+	val =3D csr_readl(mv_pci, GPEX_ACK_REPLAY_TO);
+	val &=3D ~(ACK_LAT_TO_VAL_MASK << ACK_LAT_TO_VAL_SHIFT);
+	val |=3D (4 << ACK_LAT_TO_VAL_SHIFT);
+	csr_writel(mv_pci, val, GPEX_ACK_REPLAY_TO);
+}
+
 static int __init ls_pcie_g4_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -259,6 +271,8 @@ static int __init ls_pcie_g4_probe(struct platform_devi=
ce *pdev)
 	if (!ls_pcie_g4_is_bridge(pcie))
 		return -ENODEV;
=20
+	workaround_A011451(pcie);
+
 	return 0;
 }
=20
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index ef93b41f4419..c75b7c304c46 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -85,6 +85,10 @@
 #define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
 #define PAB_INTP_AXI_PIO_CLASS		0x474
=20
+#define GPEX_ACK_REPLAY_TO		0x438
+#define  ACK_LAT_TO_VAL_MASK		0x1fff
+#define  ACK_LAT_TO_VAL_SHIFT		0
+
 #define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
 #define  AMAP_CTRL_EN_SHIFT		0
 #define  AMAP_CTRL_TYPE_SHIFT		1
--=20
2.17.1


Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8E2C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F7E208E4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c7yrVRe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfCKJdh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:33:37 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:62912
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbfCKJdh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLvJkSyJEgQwdB3bjsAFqxbk/Ck/q1vQGqz79i97C7Q=;
 b=c7yrVRe3m5e9MeLrLJ/e2wNUdl7skodIu5GebepqZff7pZctcHlwEyig3Sh2LjXLNqFFybojpqUyvauRdp5wUDtMoCu424Ijgpyf/CqWI6HxOCG0yNv1KuQBIMuLGykpg3pfhYDU6Ox2NpP5aSpKtu2xT46p1N7HtpdAswPLOTE=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6150.eurprd04.prod.outlook.com (20.179.6.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:33:32 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:33:32 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv4 26/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Topic: [PATCHv4 26/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Index: AQHU1+1+Au0UBiXI7EyjDN9yTIIANA==
Date:   Mon, 11 Mar 2019 09:33:32 +0000
Message-ID: <20190311093130.7209-27-Zhiqiang.Hou@nxp.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:2e::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73ffcf20-f27f-4173-ee58-08d6a604a04b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6150;
x-ms-traffictypediagnostic: AM6PR04MB6150:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6150;23:EY5sy2vPsIXwcr4DE9RBaBbB3PSk0tGRCBxjTOd?=
 =?iso-8859-1?Q?UOdG9JzMkrfdWPLwB6oYOBBHrU48fJcZfzybIqxb2TpiZ5NcpUsOQMGr4J?=
 =?iso-8859-1?Q?rcAMvYpyjXkyhcSYZgEa7Zk4mvB/kVvLGevm7f+6HXHqYbAUW46UbmsNwE?=
 =?iso-8859-1?Q?Fq6u/LQ/MKdUuVyfyXvxac9MnSn5FVF0KfPkb5GR+j+1XCQOOP1Bf/O87l?=
 =?iso-8859-1?Q?iiKXdE22JUi6fPly0+BZ1qAemzjWBdborBedQ7RkXIOnFI1SvNiXOMwz/W?=
 =?iso-8859-1?Q?OpSTQ0GG4WfBo5jRSy+K8CivnnOg90lgceK2FZtTLeXH5kQzCH0OVRGMye?=
 =?iso-8859-1?Q?29kb2KqAO779yk7bpH4TPZSmXZiGvMK2DPF2Yl3mdB+i00us27wF7fLbwE?=
 =?iso-8859-1?Q?WadEzlHtBeNFwXZvEpismVKpReieJvG7Ng1fuQXsOl5aUN36w7DRcahUnj?=
 =?iso-8859-1?Q?w1b4oBci5zpn219zX5guIK8tAX5EUVEiHZ4y05SDWpERJeo8+VDKx5S8gc?=
 =?iso-8859-1?Q?NoxbHX8qiyrIEAv4w0NAnKiooASFwsojtr8hY7Lhy4JMRkjSn49ImOWnHp?=
 =?iso-8859-1?Q?VsTglVNgwEhUCQmWpG81Kt+ICDwJknbBzveFXdTFyog5RfHH0rEElYz5Fr?=
 =?iso-8859-1?Q?Yw4ZazpSGfDkmNo9iS3hutYimHsHwfXjKEbBLa84bfQ3ad2fpnFPtWQZp+?=
 =?iso-8859-1?Q?ayZQ3iRHmH6GqdgmCJ/uODTfQhh+8XuD2wPKzxzujGXb9LIHeIWG+LvOs+?=
 =?iso-8859-1?Q?8pUV9bSuCP7OT4jVP3y2oHhsovs+S9MC7txvSIRdiA9y739D9PazcvPeOo?=
 =?iso-8859-1?Q?0wfgkDEE9gXmxs+GaooJkR645rddmJg5zSoKhZHdC0Y9jqYOwJETyZZJv+?=
 =?iso-8859-1?Q?X5i39oGuTAQmS9sZysW7yQUrM6nYv3aQ4HNl6fhNWXDQ9P2loUY6tpfSRe?=
 =?iso-8859-1?Q?tUCJLfbgLfNzl8KxDJMuPRf4a9uE3t+sHgB/SreHjk8R9CsA+rFcB1nx+M?=
 =?iso-8859-1?Q?GQ5UjN7qIjapj5boF9B6+qMlysdyVgobqyeDlx/9C6WbWXeRPJ4oxE+/MZ?=
 =?iso-8859-1?Q?kEYYk6QjsT1JwTAZN0NN99Vle+p/ZTjo0n/cXxCTIy8QSVEqfK6nlVpSwk?=
 =?iso-8859-1?Q?73FmMHsG44e4w9mG5vol2GUSLvb9CBY6ZJm16rwEWh64DxdGvo4+lu+c/F?=
 =?iso-8859-1?Q?iXVJkWX/3ao9yv8p0Jd+Ble+PezAK+TzI9PNt7VAARVJalDkQ37d7+LodQ?=
 =?iso-8859-1?Q?L2FhUm/BT56Jtw5YVMAetsLgSXtneSe/HtC6pit1g3I0dlub5Q2kO03ogn?=
 =?iso-8859-1?Q?8/SdGaHQx8PA/gphSQ+hINp2SX8m/ucztuu7LqAmlbrim9KMn5SYgAHtNw?=
 =?iso-8859-1?Q?if3uwXOI=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB61501FFD701C5FFA1C6502CE84480@AM6PR04MB6150.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(86362001)(54906003)(110136005)(6506007)(386003)(52116002)(99286004)(102836004)(316002)(4326008)(2201001)(50226002)(2501003)(97736004)(2906002)(66066001)(186003)(26005)(5660300002)(11346002)(76176011)(446003)(6486002)(36756003)(6436002)(25786009)(81166006)(81156014)(8676002)(478600001)(476003)(1076003)(7416002)(105586002)(305945005)(2616005)(71190400001)(71200400001)(3846002)(68736007)(6512007)(6116002)(8936002)(53936002)(7736002)(486006)(14454004)(14444005)(256004)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6150;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z0mPmf/7BZeKeIeeFBrej/Qv2bDJso0awLKYaIk/boeAT8hyEIkeRAG0iegwoorjRYaN19MZ3dtLd59h4vytHTyH7nQLd8SqIUWZlbZkXDdUFjfN0ICoVNvfH9QrLK8F8tjyG0Yi4xvSIqByYOQEsuhgQ/Kd6vHIu2qcPUhK4rLwgAbAfVU7Z/GKVqkkjqjNvoxJJtyALHyl6bdN+8FPauOeYclXP9r5XpFbM1TG0xf61ob69GZJs9nYCqYYZVo0NBuu5P7pgXrn6BWSC2GREp3bXsQ455pO8pWe7HU8mbQRBQ07DflaTLhL54DJiUvaSzwxtbh5nboXrMvnr3zAm9E/yU2GYrlu02L9TfYxPRCGadNl6RJxg73cSE3yoluLHSuyzBjdGVQ5ChdvDHuwi6CQhPuMp/mSgh6Rynw1mDo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ffcf20-f27f-4173-ee58-08d6a604a04b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:33:32.2757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6150
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
V4:
 - no change

 .../pci/controller/mobiveil/pci-layerscape-gen4.c | 15 +++++++++++++++
 drivers/pci/controller/mobiveil/pcie-mobiveil.h   |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/driver=
s/pci/controller/mobiveil/pci-layerscape-gen4.c
index d2c5dbbd5e3c..20ce146788ca 100644
--- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
@@ -82,12 +82,27 @@ static bool ls_pcie_g4_is_bridge(struct ls_pcie_g4 *pci=
e)
 	return header_type =3D=3D PCI_HEADER_TYPE_BRIDGE;
 }
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
 static int ls_pcie_g4_host_init(struct mobiveil_pcie *pci)
 {
 	struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(pci);
=20
 	pcie->rev =3D csr_readb(pci, PCI_REVISION_ID);
=20
+	if (pcie->rev =3D=3D REV_1_0)
+		workaround_A011451(pcie);
+
 	return 0;
 }
=20
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index ab43de5e4b2b..f0e2e4ae09b5 100644
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


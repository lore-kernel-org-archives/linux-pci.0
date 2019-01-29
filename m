Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B20C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5792C2177E
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EVKh2v/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfA2ILM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:11:12 -0500
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:19280
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728220AbfA2ILL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/jjkrCHhuec9NM0rI88O/LrQCzFWBoyVFRHSStuy4E=;
 b=EVKh2v/LYfqeOgO+Lxoft7TLTCTM0LSjBsQchepmls58oejQM8Rd/zHAT5MGAeNi0eeyKLdnVwuhtFzZ6+AzSQUqmH+PSg6QGxztoV44fC1ft4w/qRQ2jHOZ/PdCW5Z3RCYm0VRNQ8fszpnXh+mMQHcO/pIV4gMqPmTiaYDezfA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6117.eurprd04.prod.outlook.com (20.179.7.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 08:11:08 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:11:07 +0000
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
Subject: [PATCHv3 25/27] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Topic: [PATCHv3 25/27] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Index: AQHUt6ovZBcKHJqyUUSJmvZsRQEfig==
Date:   Tue, 29 Jan 2019 08:11:07 +0000
Message-ID: <20190129080926.36773-26-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6117;6:S1JE+/Qpazn8YUf5A+0gThHItz86v9boFXdDAE1iNxZWSJRhaKRcxt1GyuLo3ho729N/c14QpjuBw//DjOYOB3TXo5Lj/eqe8jl0me8w//vO6VyL8hsYNjbawjDe/gyZPAmeq3kXjuq8X9nehQ4zmvsT3r19qOdbj018HYjaBG/XhPdRd9xLqjIqlht+NeO52s+GUo4bEupXm/6z0a69QHFlW64PjXiCi8optp6KNR251viBI4F5PnMZfzZUCuhwv+aGhGQPWkqYNZiJ7/V92oH8N6ipVY9DLOBG8AKNstx7n6wjdVwSS+/OpdLBwx7XyyMgYds5d5zPUe3mVe9C+urPWWIaBQf9SMdInx3UCAp/50PVe6Iz1tKr/++UhOOcncM+Pfz/TiMMdZRGNvaNnRKwkIUxkNwwk04wEpZS+YZXytk32zcpb0QZool8SprRwHEQfuEvpPzWsj8PpO3KJA==;5:clXBePbj38cXucrlsfBjmIRn6hESm/QTTJ35piZgkXTBYTwW101RyUdrQDRR9HUNOM6Vvf7ivO+ixy3hHGZBCEKlVGcL0KpBQj8Zhtx7kPo7RmQbkd3glL2Eb8681M+Ynuhmy7lHmrYi6o6Ih+33wRyixp6i63kKo4Za40+dZ+F4hPrWHMVTUvEL4ezh4GAqDPYLudI3xJs8uh0bYt327Q==;7:57CG0tlIQXNeX8xuxP7NsjEmDN0m39SD2NpKgn9XCcgSD0udZo0h41DNxRSlKo2kEjQVMgXmv87fuD1dnMRV6ivArCbDfaqWRBwHcSCzy1K2yi+2m7gaGJfOKcfIsvJZvT2aaLrTppBY6hj/1e3pKw==
x-ms-office365-filtering-correlation-id: e4de1717-07a3-43d8-5700-08d685c15242
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6117;
x-ms-traffictypediagnostic: AM6PR04MB6117:
x-microsoft-antispam-prvs: <AM6PR04MB61175592250366454733249E84970@AM6PR04MB6117.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(3846002)(966005)(6116002)(486006)(81166006)(81156014)(8676002)(7416002)(106356001)(14454004)(478600001)(386003)(446003)(11346002)(186003)(102836004)(476003)(6506007)(8936002)(50226002)(105586002)(68736007)(71190400001)(2906002)(2616005)(71200400001)(36756003)(2501003)(66066001)(97736004)(26005)(4326008)(25786009)(6436002)(6486002)(53936002)(6512007)(256004)(54906003)(7736002)(14444005)(99286004)(305945005)(76176011)(2201001)(110136005)(1076003)(316002)(86362001)(52116002)(6306002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6117;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mduQQ23cZXmf+p6Y8Wc+mVRhUwakN1oe8uP5d9zj5tvL9UaEIQSyiVrCQMuTb8t6rMMiGIv20oU29KucaKUGMb0MpGiqtagCI+PLIwVx94w/sxfIZJpyqznqVAzBaY5s2gGJT9/KAae1oFyKcTzgDC56RB8Z9iV3WwusK/yEicA4hPczNSUyiKWu2xh4xRjfEAaz219L3NXLOhHGFIDykWzye/8N84/VikEVblbybQXxQKBCiQdL5JHy+CyxRnquFonSWQgxB+eJahjJnI8YMc7MmIXVTYNVhYpMkrXKiH1qUNOIx+uIiUUqBHHwN0vXNvQxugNC9BWeH5XBnXGIjbL6zl/KVUtMz0Cx+DYtb3ewfMsoH4pi/3HlF1U+761ScO60iCXL6EKn4efcFVMzvffOzupOP3S1/7V1WJFUnH8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4de1717-07a3-43d8-5700-08d685c15242
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:11:01.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6117
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
V3:
 - Integrated without change from http://patchwork.ozlabs.org/patch/1006796=
/

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


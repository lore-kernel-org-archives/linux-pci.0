Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB13FC46465
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F902086B
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JZb8yrFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F902086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbeKGPEJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:04:09 -0500
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:59840
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727296AbeKGPEJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 10:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JudRkV0AoD/wTGtr+Q2wcLnmRMhJbzC8JB0Pl3GHJ4k=;
 b=JZb8yrFcy+quwQFXYbWLuGLkd8r1+vntVpriccuq68+46I8NjByxGz9rlNasC/EJbxUHWv0bjF656ZXsMAOEilYQIw5WfeWaqugPBW1yXq/HWWctlzLBPlJ4oMBzkgU1sD9FVStTY3mIeet8jpqeb5NFob8bZ5If9YwGXtO2CQ8=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4152.eurprd04.prod.outlook.com (52.135.168.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 05:35:18 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 05:35:18 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
CC:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv3 1/4] dt-bindings: pci: layerscape-pci: add compatible
 strings "fsl,ls1043a-pcie"
Thread-Topic: [PATCHv3 1/4] dt-bindings: pci: layerscape-pci: add compatible
 strings "fsl,ls1043a-pcie"
Thread-Index: AQHUdluqk02Hu12K1UGJ7GL7WcIa9A==
Date:   Wed, 7 Nov 2018 05:35:17 +0000
Message-ID: <20181107053500.13575-2-Zhiqiang.Hou@nxp.com>
References: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0034.apcprd03.prod.outlook.com
 (2603:1096:203:2f::22) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4152;6:TLB+cX9IbpXzWumOFXrLnT5ee44kBoUGtuzoWTVJaiQ0cGXJw5ec0gRpWXEI2hX5Q6sN/KB9c6wC9mebc3cn7s7XrHNo1lrEfSsGkHeIrjbZqB/ox/n/TsMpwrN04vLJlg4W+YQR4NyPNr/JbmpRnmvJ/L9P7Wu07GX1PPVqgfn82FIWFg9bGl589Ki8tcfJvSLAwysOe/q5T4C5ODRSA31J45Sm31UkIdl5iChvf5ovrdOOmbD8tBKrwvJPfZoYuNM6wprFwjms9ZTsBhvardiqusyEUW/j1SwT0etUAxaXKrYmTQPp3+QQ90YK8dI6D2tWiDEyh7HEUbNypps3Jshu6HK1Gg6pyjEwe0t8x+QgSbPMCQYcb7KqEKRhGOWlLPEPbK4sTm45q6h3g89aAeF/yIENqRZgl+jj3Kd+clZU1AdgC9Vxzla43MB7UEY4MPmoOq70J+nHHAzVxiFMGw==;5:Tb8EZeoZ4akE75QbGrrJ4P1arNLjGgADIzpBwuZk+9wIcGak3uE0ERxpTg/34/LfLjCa0ZEPxuFt/T2tc506H/keVVCBDXyu4yp2TiRy2UD9Mdb6wQKG1zruuujvz/ru3f28t847fJwZXN3Nkstxp44oqIWZvSl12L61+8S4nto=;7:57npk+qs/BXGl/w51RA0S7qRQBhRN12n/JQ1vler5UmxnbyioA1pIrG/a41aLE9ephmi6xxDBTtE7o7Ok/ieEMqfo6CtZBS0GajzQfksy5Cb96BUYzI3TnZt1j+GxQpGNJvjuHvwN1n5roUo368+sA==
x-ms-office365-filtering-correlation-id: 1d07a333-8cc0-4128-83b2-08d64472ccc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4152;
x-ms-traffictypediagnostic: AM6PR04MB4152:
x-microsoft-antispam-prvs: <AM6PR04MB415241202BE62D645FBBFB2784C40@AM6PR04MB4152.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4152;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4152;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(81166006)(106356001)(81156014)(2616005)(76176011)(6636002)(6486002)(105586002)(14454004)(2501003)(476003)(68736007)(8676002)(6512007)(8936002)(478600001)(53936002)(6436002)(52116002)(256004)(97736004)(4326008)(71200400001)(71190400001)(66066001)(99286004)(575784001)(486006)(86362001)(6506007)(386003)(446003)(186003)(102836004)(5660300001)(26005)(2201001)(11346002)(305945005)(316002)(3846002)(110136005)(36756003)(1076002)(2906002)(7736002)(6116002)(2900100001)(25786009)(921003)(142933001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4152;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b4gf+C1E9yz1qrwWHa+22h7jAK5IVtDAXwh3xwDpO2AQ0d6FWqzu4vWx34z31mLxXHEEu9xEEhlCSCGVEo/gvCS6PW/qgXDpcxltqqbR5h3md58Tkg5x6ckmESygLr9or4iE2Q/eUZhHAINbw/7BEeaVJxCNwDfL1LkMUToJU3xZWxLbLzoF+mQSlcXPlaSmAQ64L/xcPu1s/KDH7jc6xxMCVjjY+b/gekwI52/coQpShPRJfmpAY+YN7eJBqPLk3sH5cRiCy15NqlvazQ6cDk2AQTHBAa88b7O6D6E9eQU6roKnjaf1mN0/nQT3qqb2bqskATp+ax2g6VcITI7yNxHoPorba1+46HaFqRcIAxc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d07a333-8cc0-4128-83b2-08d64472ccc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 05:35:18.0603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4152
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The PCIe compatible string for LS1043A was lost, so add it.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V3:
 - no change

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Doc=
umentation/devicetree/bindings/pci/layerscape-pci.txt
index 66df1e81e0b8..5eb1c202932f 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -18,6 +18,7 @@ Required properties:
         "fsl,ls2088a-pcie"
         "fsl,ls1088a-pcie"
         "fsl,ls1046a-pcie"
+        "fsl,ls1043a-pcie"
         "fsl,ls1012a-pcie"
 - reg: base addresses and lengths of the PCIe controller register blocks.
 - interrupts: A list of interrupt outputs of the controller. Must contain =
an
--=20
2.17.1


Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDBEC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6FF2085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IHyprFuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6FF2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbeKFWpI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:08 -0500
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:39970
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388254AbeKFWpH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZS2hRXJJlt/QVQw1liM73vw+1a0UDYm2S5hjWyMQFts=;
 b=IHyprFuhLes4pR+MiVlSYWCjv77y3iuygokt216Aj85MO2eJctc0hvfdPAL5SGx3VPwXW3xqIjtr71zXKURMPOGvS7jW4J2wIWwIYZWuIkBzBufOZ5txKV07ilEGGclBJVz84LuTwl1E5NWJlXJyXc5eqUljOOeKycMujhHnYXQ=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB2119.eurprd04.prod.outlook.com (10.166.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Tue, 6 Nov 2018 13:19:51 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:19:51 +0000
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 07/23] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Topic: [PATCH 07/23] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
Thread-Index: AQHUddNmDCFLeVfDxUWJtUrD4ryopA==
Date:   Tue, 6 Nov 2018 13:19:51 +0000
Message-ID: <20181106131807.29951-8-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:2e::20) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB2119;6:TwzdiO+IU9aArC5e7x/NeFhZEwVJfy934UxqDcVh8BlfWr/VYIMYn5NkWdr2bR6Wahl8A7qnYmFAigHX2xGuM7KiUOTQngx7y7VyE0XCuNSl1CZajpgj26/F3OnyGIjcAC2CMg40+VXnw23G7gmQf4AiEf2ZT6HFUw/jYMjVdFCyrXvTxGzginD7veAw/IdcL/GS/f18oYvpchotXiERFOqNDNPfGxVi3XSNhmNLs8RGUKxUU6BNn9C5EnO7yjr5YI79QreFALJzZvUC1dldMbXlyKUnrh1ydT79fUcNx05J+KAQrMuZf/RzyQfjvo/7pIB+8pF30iMJpE9PCS1SkEvV+AgR8uojuU3m/7Vg3fn3tvJBos1h9kuvsplKQKCCboDJyF8KSeaP1dmgTrmSMfoRM1SHyEMOP6bsBCeET+BQ7hMea9rUIKaEBXjK7wz3Hw6a/hp0e9nhVilIaTHcJg==;5:IjDjfuVgo8kYNDldW/D5aY8x52HRZJB2NNZGnXVRie1p7oSVM/AV1lRlcRyp5DLYY28llog13XL/ifQ5ZAcFL0o8H0Oy1FW2Iy8FrZhgj5fVxECAudlMJ1WNda6/yPhGy2iW0sCXmhiqVgOj7kSiCW4nqSQJ/TVpV4M/rORMLbE=;7:MUr1uy2Xc46rxgtKe6jVg6YG0fGTvMWIjXRwtrMQMYRJs+GOPaxc6x8kAd8RU0vhCGhZ3gqG1fDm6Ur9IMjTkonHYPDEYrIARPOSl0yOU58GWjKJndrLD+XsOr45VTdTTWfpEiEse26qAFiI0VDKmg==
x-ms-office365-filtering-correlation-id: 291cf0d2-e04b-42c9-256f-08d643ea8847
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB2119;
x-ms-traffictypediagnostic: DB5PR04MB2119:
x-microsoft-antispam-prvs: <DB5PR04MB2119B379BB8B4BC205A22FC484CB0@DB5PR04MB2119.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231382)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB2119;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB2119;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(81156014)(99286004)(2201001)(8936002)(86362001)(6486002)(68736007)(6436002)(5660300001)(478600001)(53936002)(6512007)(4326008)(25786009)(36756003)(14454004)(54906003)(186003)(316002)(110136005)(2906002)(2900100001)(1076002)(3846002)(6116002)(81166006)(8676002)(7416002)(256004)(446003)(11346002)(486006)(476003)(2616005)(7736002)(305945005)(71190400001)(71200400001)(66066001)(97736004)(76176011)(52116002)(102836004)(106356001)(26005)(2501003)(105586002)(386003)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB2119;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f/NXZwHG+kQfDwzZmcI2fbnC1cJroM89gRPyo6DOykKRMGMD1c6XrGZuLI1VumAREHlOsyvSKhTrhw8Wkh4TRuM1Hgtfh380Imx8eme+BxXJFXrePjSiJfjjPnVt7J/MC2KmaHtAffVn9KGAEa4Z1nq0AvGGrUiTHi1IbaYs1Bz+UtaxXLmMvo6PsDuCPJkOwQ46m7+7wFZNpE6fKvpWt1witWACHmAwvl3l8DAzzgJ2q/fy36NuGaJZqnT3dsiaVS2y9lvnIzkAA6q4IE6fW6cxvgkOUbKPs/RVbHI7U+HVegsr9LSF5JJi3Jadi/FJSh2lZj+v3/mbq1KOCZe0zzoDkt4fJ8loKVDMBLlk1Sw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291cf0d2-e04b-42c9-256f-08d643ea8847
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:19:51.3130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB2119
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As the .map_bus() use the WIN_NUM_0 for CFG transactions,
it's better passing WIN_NUM_0 explicitly when initialize
the CFG outbound window.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index b2cc9c097fc9..df71c11b4810 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -612,9 +612,8 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	 */
=20
 	/* config outbound translation window */
-	program_ob_windows(pcie, pcie->ob_wins_configured,
-			   pcie->ob_io_res->start, 0, CFG_WINDOW_TYPE,
-			   resource_size(pcie->ob_io_res));
+	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
+			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
=20
 	/* memory inbound translation window */
 	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
--=20
2.17.1


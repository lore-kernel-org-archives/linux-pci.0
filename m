Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6033FC43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2017320671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jrLAHKY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2017320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeKTTyG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:54:06 -0500
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:41201
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727665AbeKTTyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=207bZctsaspP2NcQBvDjBhbfvMsfFNtrs/iINaCGaMc=;
 b=jrLAHKY6H7hivNWTzOmh/DQ22MJ8Os1iCgfyKy83bVvEXrt6blLvrkaTET1A56rDiILFfbAtr/4/H1+Wjc3J0aoyp6Go1Iy1Rysw3qYhsKJx73QPmVfej19D+X266ISOdv5yyN8os17HY3W7Uk9FxLQmjEeN5naMOFVyWMC9rD4=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5269.eurprd04.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:25:54 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:25:54 +0000
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
Subject: [PATCHv2 03/25] PCI: mobiveil: correct the returned error number
Thread-Topic: [PATCHv2 03/25] PCI: mobiveil: correct the returned error number
Thread-Index: AQHUgLMJImnOqCelXkOVBM9i5/Oj3Q==
Date:   Tue, 20 Nov 2018 09:25:54 +0000
Message-ID: <20181120092615.11680-4-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5269;6:qlAiHWuQYcTNZQazPCgENJqv+V4NN6NyzKaTq5hvUC0H38UnrDCxi4TA2MaFtRTrPt40AgCsbXUaZbHw7gtzoEF44VUvg3qsTSBlN1fr6P8OH6i+V0FfFXgWwnZl8kVw4M8h9kwi2SKhRoDRNg76q8RpPOexB4QPsm71Y2uFrvvQEZEPmqic2oGkFOMW7SmQsDay5qtTKMFyiKCuEHU+rpzIk2MSeN4Rqjp2/ZWSYT6gftVorx7p6gLchAuPEywtgEd+WF9gRQrgwQpYwSjkH++vW5N1dtOt2q82G7oPqFeIyuq3GFGXUvcqH7xUs4xWAG8LJrPJF8IlHUXeKVhWbLNaI/GsuYwQD7A7sPCiB3hxv6MOSPjqnCoIkx7dhskBWb8YC1n4gf79KhTER1BJraDUpDnr9O70xQm48aa5BK7zpQlO5tkle62p+HmOqukT9okVNd6KKQZ957WWyXsL2w==;5:AsHGVrufRGBsCS3LATUSy0mdH/E6gunlZZWoZlF1l6mGiJq29GFeOyp9sudI+j0vCObUKx1qmUM7eZo/BAvR/soYQXdWFlGs+8bNCBV+StxH/Ldf8dLmNzj53WADAg1XzuDnk+y7XcOB5EMmlPIqb1n84/bObuZaC/jLHRYTa14=;7:avWUYj15j3SxjRSsiac3h1UZncAPo/a+R1DoBAtUc5VBU81NCeXZPa5jWbJrfrqozqGBeQCxzJEJdSPu+bPvdomhq4Zt4WhJwB4nt+YC9/6Rarck0NzWeDfcSlulv0oWdl/SIHXNWG/+9Vp3UDvm6A==
x-ms-office365-filtering-correlation-id: de4b0381-89a7-4104-fd0f-08d64eca2b6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5269;
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB526984028995EF7E75E5DDC384D90@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5269;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5269;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(5660300001)(7416002)(68736007)(2906002)(4326008)(8936002)(14454004)(256004)(54906003)(14444005)(53936002)(6436002)(71200400001)(110136005)(71190400001)(6512007)(316002)(2616005)(476003)(446003)(11346002)(486006)(25786009)(2501003)(2201001)(86362001)(52116002)(76176011)(6506007)(102836004)(386003)(186003)(106356001)(26005)(2900100001)(81156014)(81166006)(105586002)(6486002)(8676002)(99286004)(66066001)(6116002)(3846002)(1076002)(478600001)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5269;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sq5Z7lWZsFrPH929iThi+4e/pmT0wd2B/6AxcQTnRjpkP9z54a/Zwwu5u9GTsSvApQOZ/KuuI+wxLZeaXTuLT6Uwi48b9HJ3PkYmEVjx388XItORKI31XDcE9C2MWFjGDIEzK1HpBmEARqY25tm0NNxs+tQp3jgX04lsdOttfRzgcY78TZD6FAmjOOn9+BwvZyFEBvYQ+cvyUYYV55k1V6Ifo4BHUuAgVgRZ/RyrX3aA45D9z/JQnpNCiNjbIkJ5Mx4WzCxAtGl24Warq56WE++i9NXtrmt16TDY/DJMCC3+Bw8DrCaCv184Ny2mZv4/t+dB7cmwyUA7nrvLFEXIB+HX136g14+KZexG4geIW7c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4b0381-89a7-4104-fd0f-08d64eca2b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:25:54.1281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch corrected the returned error number by convention,
and removed a unnecessary error check.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index b87471f08a40..563210e731d3 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -819,7 +819,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobivei=
l_pcie *pcie)
=20
 	if (!pcie->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
=20
 	raw_spin_lock_init(&pcie->intx_mask_lock);
@@ -845,11 +845,9 @@ static int mobiveil_pcie_probe(struct platform_device =
*pdev)
 	/* allocate the PCIe port */
 	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
-		return -ENODEV;
+		return -ENOMEM;
=20
 	pcie =3D pci_host_bridge_priv(bridge);
-	if (!pcie)
-		return -ENOMEM;
=20
 	pcie->pdev =3D pdev;
=20
@@ -866,7 +864,7 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 						    &pcie->resources, &iobase);
 	if (ret) {
 		dev_err(dev, "Getting bridge resources failed\n");
-		return -ENOMEM;
+		return ret;
 	}
=20
 	/*
--=20
2.17.1


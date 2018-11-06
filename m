Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556A8C46465
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3C32085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nx7neKGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3C32085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbeKFWpc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:32 -0500
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:53248
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387930AbeKFWpb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLCzTSVXqk69mjV2G0uMjdSuJB0D7mj0QkDfLtG61lc=;
 b=nx7neKGs2mMSe4Uym3gizNi4EEC9paTqqDbAMph9jLd6JUhxesErw2seBa7Cvw6jM3JL8hoP1njqtkA+EKg97VeCyFuvvslnE9RIP0uweL9u+3PRbrBegyWMRSoV9x507NCyh8lNKbe44n+LyonwoLYjfMJXDmasf0s4xVRcj4c=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:20:17 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:20:17 +0000
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
Subject: [PATCH 11/23] PCI: mobiveil: only fixup the Class Code field
Thread-Topic: [PATCH 11/23] PCI: mobiveil: only fixup the Class Code field
Thread-Index: AQHUddN1NZze+4D3a0WmVRogFB+YMw==
Date:   Tue, 6 Nov 2018 13:20:16 +0000
Message-ID: <20181106131807.29951-12-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:M7txVNWWM/xN+eQBg3HFXyYnHcV3le7ItrSVU4pgZrDDeSL5x4qCo9ANJUqsPzAAv+v31q5OcSHjmw0JUVtzjdyB0nLofc+bYzDd65z3bIXlAnOFiXkyG94filzcBJQ1tVG5vmja9FNkciHV8E5XKLq55ScaDaFaeK2yvoEnBBq/EG7g88Mb3gVeqp0XTKFyWiJwU1ohJ9/uHlQmCvGgFOUknXkvhSFDn8srBjjk62kdJddvPz5uUMWGbFEhfIGTsfbTl81oCedVSnbpfocHEE5ozWyq9SSSlDk2VIPj0E7eXcUmxbCih1l1kf/q+Hkp+rFGFfe7VMEYZh72PdA55YllWHSpcQHuJ1C3t4aW1nsyh5MwsO7ooRqcNrTwHg1m4Rbb1UIPrPaIPKdAkTrRLV2SWBYfeU20CsJl/ODbHNcQAs9i0knlWeZvCt9GwU4FHhb4N9MIt6VyBwdzbZxzpg==;5:DGTZyReU+cZAnoZ9cUR734rNtYRr7753my6xe/C5qQhTWb6SkuZ561vJrK/AwCK8fP6s4WydJovEaNQNidJsG0c/zukomzCTdn7i8QJOIArXpIhxrw+ADofSx4YTEmxUxKz+OKh37UKrgHcnkR3x0q+qr1B1j9PIELr7UGUkANc=;7:VCMmf2c9wG3mVqk3t36eVMgmaYw5a1EKJ++hUnElrq1DiSoAyyRNCZC1X4CVIUlxt4pLSBNDr9xIdFgoH/d5lGr0GoVntnyueQo5k4+ugV1be/p3sLlPsyL4MaPw+/rZRDOYD06RFMtCK/NHtmNaVg==
x-ms-office365-filtering-correlation-id: 80a4a48f-863a-423a-2beb-08d643ea9798
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB1414929FC8D0E760031535E984CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CNsQ/t8Sk6vuQS0PzBsvjhB77nUE1qe76sEwgzeuQO7iiNnUaTN6vPh7D5VnPmjp+2sYjvIZejUcJBPN+Z4WegnRn1x7XSVAu83oqMv/voNvYhWpw1v1PnC96nUmpp4yiG0YQfEhk0x5VtmCsqR7NWQyhHnEORffGngNVOGbMyuEAxqFqDoNWSmSMxTnmkiBzBkICmz6tR1j+BFLDXjAvli28hxgyp/m6vCdz7pQ3173G8C5KArB5YqHN/fOMuUR9hCpHpp+OVPHQ+gLkmAYt5bA9o8Bg2PLZLkWGFZlIH+/1sUsf0EvjE86NBYMv3fFf43A/iaPq4v9ggxyAGMdn+wutYDhBfW/Tzb5qEQNz1Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a4a48f-863a-423a-2beb-08d643ea9798
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:20:16.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Fixup the Class Code to PCI bridge, do not change the Revision ID.
And move the fixup to *_host_init function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 884c9f95374d..8e3630359597 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -652,6 +652,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
ie)
 				   type, resource_size(win->res));
 	}
=20
+	/* fixup for PCIe class register */
+	value =3D csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
+	value &=3D 0xff;
+	value |=3D (PCI_CLASS_BRIDGE_PCI << 16);
+	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
+
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
=20
@@ -895,9 +901,6 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 		goto error;
 	}
=20
-	/* fixup for PCIe class register */
-	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
-
 	/* initialize the IRQ domains */
 	ret =3D mobiveil_pcie_init_irq_domain(pcie);
 	if (ret) {
--=20
2.17.1


Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC33C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A87E2085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="u3bzRr1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A87E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbeKFWom (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:44:42 -0500
Received: from mail-ve1eur01on0042.outbound.protection.outlook.com ([104.47.1.42]:6144
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388144AbeKFWol (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AC3UUG1F1PvvLngn7cYEsiSg64fPhRxYE3u5taIiX0=;
 b=u3bzRr1hhrhTHqw1BNhXj51o1rQaVjRvSO1GOnaRepJXtYW1Tjq3jbs1zJ2Z3iJLbOjHpx109quiZ1eFq28o0nIElvaVa2fqty8LuAn9pR+PisqWVToLz6Wb4GX+bBHnKSQoTfMLlXTSq4F9JElO0fp0hLtjLhOV+AKi9rTc9qU=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0984.eurprd04.prod.outlook.com (10.161.196.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 13:19:25 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:19:25 +0000
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
Subject: [PATCH 03/23] PCI: mobiveil: correct the returned error number
Thread-Topic: [PATCH 03/23] PCI: mobiveil: correct the returned error number
Thread-Index: AQHUddNWBw9Y+2zWwUWykmDsJwZN2g==
Date:   Tue, 6 Nov 2018 13:19:25 +0000
Message-ID: <20181106131807.29951-4-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0984;6:8QcC08GxecpxAHu+xkULTEFr2LgMh6/h/glf029Y9w5hJ5nzUTfYSdTPjBkNT7ebH5jk7K5qaufiuvSmC6+lhnJNxvQZzOkUzOX4wEaCYOvnp1aHmX/yXmdh5b5j8pjbsMCdMtXv1jJtLn+M30XZEz2DAzIZvo5p+1StykvPKS9pP8TejP3wE6dJnnLhRBrRR1lgtcZmJ2DClJD/oEIbMaQ3Wo7HYMLvFGwP44LpAOhTkUONoTLeAMdr10Ze1CdhGfKAq3mb2V+xfDzX/lX/bUOve55U1u6S/rHwFuG/ekDlWGfW17l2L0ZHXuyk0HqExp2ipycvBYLrEGKxOWRF23/sLec+TGAQ3xG8RXRy57k3vK4cwoKOl1d2gsPcSWnHodw6DjOqJ069kATMMOQ+jrWpLMiBXcg1Nmp7W3aJz9ZGxl81rKjKtCabsph5lcH+hvmkPXgYnyiXM4AKH6FxJQ==;5:l46jzSUURO7wuA8VmPerwbVZ9otX7BDzPzT8Iii5WsSRKpDNy6/irKlpYgo1CU+jceipj2Gt4ZS6skAymI83Nre5v1so+z/y0s3qC8DOZskAM3Pi0Z7/dct77EX6Kln6f52fkXweJSTtefvZMWw1kSou/c+dRpOQmJiOGW8a6No=;7:6xK8d2lK8tecnTfpW309Xiyu7GBtryU0K7fwGpNLQwLfAQlqfgz7ETaPqdNBKBJgk81ZDcPBS4wMuuwnJmNt+0WpAyPmv6+NoPHqrC0nJPxYBgyQZYGZcyZny+kXV+WXmcnsNRVYMmLAhiGZhdc1JQ==
x-ms-office365-filtering-correlation-id: b37e4529-cc03-4fc3-f2a7-08d643ea78c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0984;
x-ms-traffictypediagnostic: DB5PR04MB0984:
x-microsoft-antispam-prvs: <DB5PR04MB0984F2D4BA1B4C46D1BE9B6C84CB0@DB5PR04MB0984.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0984;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0984;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(68736007)(486006)(386003)(8936002)(3846002)(99286004)(71190400001)(81156014)(71200400001)(81166006)(53936002)(8676002)(105586002)(110136005)(54906003)(5660300001)(2616005)(446003)(11346002)(66066001)(97736004)(305945005)(7416002)(476003)(2900100001)(7736002)(106356001)(14444005)(2201001)(4326008)(2501003)(25786009)(1076002)(186003)(6486002)(26005)(2906002)(256004)(6512007)(36756003)(6116002)(6436002)(316002)(102836004)(52116002)(6506007)(86362001)(14454004)(76176011)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0984;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dEJput1Ah59F2ebPX/TXauTSIxY1T3eUulFDh1zXL4Hcry5y7qWR2Ts7VAVSIYcww1O5qcGi3so4ddENNU/de0zHUcEzga/NhAa1N042gtfoGaTRiAjpE6ecIQJ/iih8Zfr0h+N1wJdWg8KNiIr/Gu7u1uqFv4dsy4wNBBMGulJ1pRKmgGF3xX062RYWzx3R5K+CmpwyFM3gRQF/gKiGVX9h7V03E7UEI2JTrgi6ytxGPb8tQ5CvUVjgWVTxLM8UL196jxAkA5uuI9TZ6g+7UCxBv74fQOkE42g0iNaNRiHQ0jEVBwlMEWEtScUqM9dbeirQeq/BVDxVYvJ1mwbFYOQgQacG4HyS/g+/FqA7GP4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37e4529-cc03-4fc3-f2a7-08d643ea78c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:19:25.3020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0984
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch corrected the returned error number by convention,
and removed a unnecessary error check.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
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


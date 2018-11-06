Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B164FC46464
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EA02085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wCS+rVF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EA02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbeKFWpp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:45 -0500
Received: from mail-he1eur01on0055.outbound.protection.outlook.com ([104.47.0.55]:40139
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730570AbeKFWpo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TSZL6OvmPW9vGjNi5uKl2hki+nFAPJvHeqAas4f4Xc=;
 b=wCS+rVF/Jn8FLWxpXscdVCMksZxSpGSUhpUYcYS1QoSKyCBGALTKPueKfJiIf/75ejh1d/hrTr9tBEYJt4XVc7yY8XoeS6la7p0Lc76pv4dypcW4a1C5wCv7n91JWbiVwpGzjeOBrQFi14rhFGils/dc8aaVXDAnXAkaoEceBbc=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:20:29 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:20:29 +0000
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
Subject: [PATCH 13/23] PCI: mobiveil: move irq chained handler setup out of DT
 parse
Thread-Topic: [PATCH 13/23] PCI: mobiveil: move irq chained handler setup out
 of DT parse
Thread-Index: AQHUddN8oajHesmzXUW49s2raTQqMw==
Date:   Tue, 6 Nov 2018 13:20:29 +0000
Message-ID: <20181106131807.29951-14-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:A55z3VFNF3061oE96Xpk1luoAJ7wSfXXUEzVGe4Z96T9Kh+kDOvO65kFg+c37acpBrEP+XG6DlHuWong0cFiUsvRqVbTE/H6xgCqn0HmYWmwUA4QMfv/SCNiTf9rdiJc6qUmNjEmBF3EbmXiso2og4dAcBNv/nxWldf65HSjB9rHAjkqYAJ/j7uURMVHl153QMAYNZ92Ltehv8IobAN0n+CBglxTTVE4ByA2K0TH6UsxjNsjggmg8s9tGUJgo02CRSQkQGisb4Aq7WPQVD5vnPUM/dCR+54fzV0OHyMn1YImYb/ahYCb2bC0BNvElWnUfQQTHb9NdHaRyzu8kpc9zJRjG4gOfv4mcPWBO8uV5gvzNeOyQAf1AVfAMOIjsd+MHiIyBHjDNGdnhYa8RcSwnuHsb85w1ZxRYsNtZ1bjkRlOePucFNfqvyYuxCF4oFLLnmaBhMLhCghsRqAvWilDHA==;5:sFJveMbMpoWmXRV2v5dPFdFje4Te9FOKvTUb+VWTLjE2ZP5Zz7qDflWVgx61dE0AvNlLMLHUnQnptHR2pFDX/7rqKOq4PW/YBAY2vAjA+6dJZO5y812+AN1Suf2U9Xp01spMFYgrplm2PvfMrAGBPK/xThYY4i7Uw8ACpbJ5P3U=;7:shnE4j0FpLXc7COc0P0BNp0WV6CIZVqlBVTQtd+tQL0tuslSU2B3PS6lYplCQZZiNEgP1nhaTRroNfDMSZjC/iyDAVUXiaCEt7TLmjdUTCsPmv4K/YsQd/sK3X+NQSOykcxRsK7+9YDJSfHDm/NbiA==
x-ms-office365-filtering-correlation-id: 0b05c0ad-4811-4a71-95c6-08d643ea9f24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB14146536EAFC393E90CC7B5D84CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(14444005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JrxkO0GVflfjavCvn6aCdne4M57oQyHf2GrOtSZrIUDSWkEL3qX0vXz7ytvXvZPdhsSalIJQKhvO5YNtN7dquWBXBsX27iVFyiOouXbBGC2U/0A3NUe/YX9rpwMt3Nzhc9Fs0vhmD33SZM0BWZuYN6SfX2VAMGDwCgzLAbQkh4o4gBFdZ7TzRyTip6u0ZNahbVs1hf/AndzUdzUULg4bbcGkCv69Vel6CPCb6+jHR+lPx6UUVQ59rjqtSdWYTR+EzZ1YuvHDmY8voE8ljF/4upW/7qnSBwL5MrAuTZou2DghMxLlb7QkNJEj2++Q+Ak5Ccs4gPvglFKCvpnAnsBZ6/1us9e8u3jYRz6DHKJ3T44=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b05c0ad-4811-4a71-95c6-08d643ea9f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:20:29.6351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Move irq_set_chained_handler_and_data() out of DT parse function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 4b21b8549664..3da924bb6b3c 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -460,8 +460,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie =
*pcie)
 		return -ENODEV;
 	}
=20
-	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
-
 	return 0;
 }
=20
@@ -901,6 +899,8 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 		goto error;
 	}
=20
+	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
+
 	ret =3D devm_request_pci_bus_resources(dev, &pcie->resources);
 	if (ret)
 		goto error;
--=20
2.17.1


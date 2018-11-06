Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFF8C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44AC20869
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VlyJO1nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44AC20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbeKFWpi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:38 -0500
Received: from mail-he1eur01on0088.outbound.protection.outlook.com ([104.47.0.88]:31635
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729728AbeKFWph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu0Gn1s/q0UKMAa9copK/c+XN2Y+zhvBH+DX2EtU8CI=;
 b=VlyJO1nw202UHTt4Wy7eFlWvmNlz4kigHiTJJWIOPYpLQeyJxBD0Au24QBOnpT8AGrsc6skCEOO7GyvigiY3uHY3BxhJEp8RfUqdOAVp3M7Pw/sIeQDLDNPD1WdF5OablJZ7YljsApBL1FYCzJzss2DpBam3XOyk/mTlO66I68E=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:20:23 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:20:22 +0000
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
Subject: [PATCH 12/23] PCI: mobiveil: move out the link up waiting from
 mobiveil_host_init
Thread-Topic: [PATCH 12/23] PCI: mobiveil: move out the link up waiting from
 mobiveil_host_init
Thread-Index: AQHUddN4KxeZ6jJ77ka31NmPNJmtWQ==
Date:   Tue, 6 Nov 2018 13:20:22 +0000
Message-ID: <20181106131807.29951-13-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:fklJxJof4i7LYB86SkTDVhI5hTKIkKft0Rhe9E6YdwIvGfPdtESAjCo3iGs/QMkrZ3ofnGfZ6ExhTL+dyOoUXtXFhJzKknvSgoFyWP+/uJ0g+R1ah/3McILyzk4Xh212mMd+jG27aYREa4QzDPZOkeHDAO+1fyeG19/UDrBM6e++uXyv92l90eKYxVG+W/vg8QbcEc6nO1kKKGi0Q4q2qGfEOA28B7ceIAoHGwdDtvqE3ss824pN/qLLAaTYBu5CBqSaZeVmo+20VcDJ4EXqb4Wbng9R7iiY5sBY3e5IkFRjVeL3q8sCgkQSoBL4ngROfDnZyBShy3ZPQ8lISp/lGZX6SmLEflYpjU2EBJ/S827X0/0Ms7f9nQqx/NSp6b9+HPDSwqta3zcHnVEmnuhlHZJgS2vs640O6LEYYqtkTwx/XzF+z2iD0HBAOP6OoMUCVAoAHIlEUECBvzckujnxZw==;5:1l6x5fBlrk9BlV+kqyMkGOnJqLBYVAPYPXtSg0D5ozFgz4aP44jsVFgJ8BVJNDOouAKjJnCzbvvgLHgwbVNe0seyW14XjFYBlZ5dO+BwwUhWKeGJK/i0xZ15XoAOlJXkBofXl1H72vZ6NnN3dBWWqBBPVbwqRQ5EFrcRY6RmGkQ=;7:28zHLv9vp6pyegzl+Ck7EGtlC8vrCbW37aA174siv9rw2O16T4KuJDzNNBgaGQGKxY0DOW5qh2uUprSZQ9oooHTtLvD7hMJx3pWBjU5T0hFvoikd+UCQ6Mp/bSZ9/qC+bqZRHXHL+iRuhq+xiMm3gA==
x-ms-office365-filtering-correlation-id: 429190ff-f254-4a95-1f0b-08d643ea9b39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB1414F5A6C51F3C422A16A4B084CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z/wVW3/SSemqjo1uJ1akycQ5LuAw1fmECtu8TCeo0ruS1O5grbtEnL98IsVeKOlm2Be7fE9xHdPEWJ5/fVTqSQdiNlHjAc/hj6B4c/ACul0bKpm1tg0rMkuP11+osknJP0xMSwvqbpMQn6o4WKgrh5fYvljVE7Rj+7Q2lD9xnlUesAUs2NURxDRN/XKxvyUNQPEFxSF5GBl3zCEck8+dR27yuLmS+Lac8Oo27PQEoC8L6KYTmT+80qlG3aWmQ4CoY3Z5RT2Ksfw7UGJpjAStdTg1e7IE1GR76zCY5fScwFx8gptTsGDKlBS9vU8EMktRa14ktwgAGdCcPA7OZOiTU63Veq/0aNgakftFKBvYmxw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429190ff-f254-4a95-1f0b-08d643ea9b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:20:22.8266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Host initial sequence does not depend on PCIe link up, so move it
to the place just before the enumeration.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 8e3630359597..4b21b8549664 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -581,15 +581,8 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_p=
cie *pcie)
 static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
 	u32 value, pab_ctrl, type;
-	int err;
 	struct resource_entry *win;
=20
-	err =3D mobiveil_bringup_link(pcie);
-	if (err) {
-		dev_info(&pcie->pdev->dev, "link bring-up failed\n");
-		return err;
-	}
-
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
@@ -661,7 +654,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
=20
-	return err;
+	return 0;
 }
=20
 static void mobiveil_mask_intx_irq(struct irq_data *data)
@@ -921,6 +914,12 @@ static int mobiveil_pcie_probe(struct platform_device =
*pdev)
 	bridge->map_irq =3D of_irq_parse_and_map_pci;
 	bridge->swizzle_irq =3D pci_common_swizzle;
=20
+	ret =3D mobiveil_bringup_link(pcie);
+	if (ret) {
+		dev_info(dev, "link bring-up failed\n");
+		goto error;
+	}
+
 	/* setup the kernel resources for the newly added PCIe root bus */
 	ret =3D pci_scan_root_bus_bridge(bridge);
 	if (ret)
--=20
2.17.1


Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFB1C43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D8F20671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tkR+qVte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D8F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeKTTzf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:55:35 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:64008
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727601AbeKTTze (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/USPXyQcrsZGKosk4JU+LBbEUGh9CpRDV/DPjJVrauk=;
 b=tkR+qVte1Ht2aYFRtCSgtNP2zCIvdAWGFPKcVGfmFJaLr+WUPetrQiOUlRaLeXBhNM39xrujguRD9CDCDM1C9EklDlESolwZmbL6JS5yjvWuWykClSSXAqCcrU+9HAfkT4G1/xapUMGKy1JE+LFg/ZXYoMHJFkq/uTY0cYQhkYk=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5269.eurprd04.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:27:21 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:27:21 +0000
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
Subject: [PATCHv2 17/25] PCI: mobiveil: fix the checking of valid device
Thread-Topic: [PATCHv2 17/25] PCI: mobiveil: fix the checking of valid device
Thread-Index: AQHUgLM9PQwv8Z1F2kGXCcsoQ8hriA==
Date:   Tue, 20 Nov 2018 09:27:21 +0000
Message-ID: <20181120092615.11680-18-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5269;6:a5LCI9VhBmjD5Li+tOt4SLl7ROGn7ZFXJl6tNd0ywnB3PObMRqfqYCIqUv5m8jNF29DyO9HcKW8BwlfxtdjB2hwDpTtD1HqgDq+tYwuJt8BtH8tlzqYa1PH4/oSPdmoHn4Za16lADYVqlegUD10Ok4OjrrEUK2jk4kmMYRaNtlirVcpL0XcW9bsHVUI/cIkv2cLoKfeAKBItqqCtVVTZPET7Z/2/R79wb0P0R6GtGRtgDv2XMhdKQ+1Lmsbfm96Kef3da/LyG/DkX7Q1bk8buxbmqs8YoayVX7Awdf+JgnTzvKikDqYY3y0f4YfXLMIV9aXzEmvTQ1tDjQeXUq+D2rkT/qErLofhQ9xMys3N4KEs4EGui1gzXLeiTnm7NzBUtwRexkSFMqd9D3yewDSzAmSvzLZBNRimywrrnsmJxOpjkRJRhA399TIHPDf0YZu371v47GGYgkR+jluGIYL3Hw==;5:8jXHTxQsmlof0O3KNYXZRTIIAGk0ZXFTczB0HEzhPgHEXXxKWfmSZtYHrgEjno6oRtPTyvOdcF34xFQzHyWcZl+yx8rahaW7ION4YxoNJXnXvkytCIwsm63FKlBG8vfebN+EDZ/WuwIbgDLhx2Nk9WycKBWiWbdXn8uOdoKHk/g=;7:RRZSsZL9rxWFWUsCa+iR9e9g2WOyCp9i78DAkDCdHNqUemujZ+jgU8JLVPFMMRkBhyzZnH8yVzl4eOz8TCOusDjNgGPW4Nt29OB9EyQ6H5flrCLZ0yWwKG0UpjqfijLpzmawKNJ6VEnaLvfB3Xw4+Q==
x-ms-office365-filtering-correlation-id: 45f2c008-aebc-456f-6cfa-08d64eca5f71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5269;
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB5269144FCA24FF0D506E704384D90@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5269;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5269;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(5660300001)(7416002)(68736007)(2906002)(4326008)(8936002)(14454004)(5024004)(256004)(54906003)(14444005)(53936002)(6436002)(71200400001)(110136005)(71190400001)(6512007)(316002)(2616005)(476003)(446003)(11346002)(486006)(25786009)(2501003)(2201001)(86362001)(52116002)(76176011)(6506007)(102836004)(386003)(186003)(106356001)(26005)(2900100001)(81156014)(81166006)(105586002)(6486002)(8676002)(99286004)(66066001)(6116002)(3846002)(1076002)(478600001)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5269;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZUmOg5um4tPiaNj5sE7xYQXZ2VgEdrAm1SS1W+Cv6Akk51DJzZ+DNui/4THlnvXvUHGrgP4inYbW/vfPcduepgInActlNW6E2KolnjyrcJprOXkcBhpXdkmciw5eHoau+8i3FHNhj5QEDxZ4V7q7CN5haSi3r8lpB07Ndzd30/JciKEmpv5W3EWR0yFFBPacNhRzZcXH7ND+q1i3gC8S+Jco460Inp2Q6XGypWVbVtGuACkoVW1MuWZQqp0fuLVeeIroxdXqv46qhWEsV/Ecs9RRe1ycmTFTUU+QAy0RO0Shr5godZpz77J7A2Y+d1Kad+IElecpRPWvd7zd2szVoi2dEWziL/NKn7DNhUQyX18=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f2c008-aebc-456f-6cfa-08d64eca5f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:27:21.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Avoid to issue CFG transactions to link partner when the PCIe
link is not up. And allow CFG transactions to all functions of
Endpoint implemented multiple functions.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - New patch

 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index dc5324d94466..1ae82e790562 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *b=
us, unsigned int devfn)
 {
 	struct mobiveil_pcie *pcie =3D bus->sysdata;
=20
+	/* If there is no link, then there is no device */
+	if (bus->number > pcie->rp.root_bus_nr && !mobiveil_pcie_link_up(pcie))
+		return false;
+
 	/* Only one device down on each root port */
 	if ((bus->number =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
 		return false;
@@ -37,7 +41,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bu=
s, unsigned int devfn)
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
+	if ((bus->primary =3D=3D pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))
 		return false;
=20
 	return true;
--=20
2.17.1


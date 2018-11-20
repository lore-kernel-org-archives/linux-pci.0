Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7225EC43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED8420671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DrviNT9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED8420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeKTTyZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:54:25 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:52352
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727547AbeKTTyY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4Zo4Mj6JXKZ4oucpy8J0Wxt3IRTZqgIbMtmIickVkI=;
 b=DrviNT9aw3k3CBi04vLHaBOxxOXsImqhuA7HkHytTJyWugyJw8ZHs27kjfB4nBVVOQOszcLDqa53sqW3DLYvjsGZqr42CaSv89qNcRrzyp/cPvMXNZXFcdPHRtqSkXAucU4fkffwqe5/ksBJ33yg18KJ9i+xbprM5iIWk2Ji/XU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4775.eurprd04.prod.outlook.com (20.177.32.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:26:13 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:26:13 +0000
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
Subject: [PATCHv2 06/25] PCI: mobiveil: replace the resource list iteration
 function
Thread-Topic: [PATCHv2 06/25] PCI: mobiveil: replace the resource list
 iteration function
Thread-Index: AQHUgLMUKfnITgMTzECPBg3sVfbaQw==
Date:   Tue, 20 Nov 2018 09:26:12 +0000
Message-ID: <20181120092615.11680-7-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4775;6:bkXKpfWQPBS9BrrzC6Wb7qzzj0Vy8abFMbNUEWX6r+vlbitkhonmUb6xlCWAM8RCCOLfkpc9oPkjK79y40re8iYjFxC/C1Acmq3PgzhrZ47+OV1iIMAQW0JQ5Wmq7+14GiZZfHZw3R/V+XnXU7Jr1O46BxCYpziP0Vu7ucDjT8PXcabLWgwG8899m6jqugGlzzs3aSL8AHa/rqTP2j1GfdCZ3T6JgnGQTDoJYy+ORvjAzS++3e1l+T/Beq4GmY44Zd8SIHU5WrSMTGaSUr8daf5dpiUxqgYHXFU45e44VKA5LS5fQ+nW+xjta5HcddUqmLytFXaEVd4ipuk+tz5ydZ/H/ZRCK586tzT65BHzt528xFOmBYw2yXpFQsGBEb46BeotsatXSlIX+DJSe/3VkjsxLQ0QLYmyMqT6h5mUUNMw3wShW+F+dhaQixKgRyqezR9moW6cR0S2OV31R+2/hg==;5:0JADgLybGjGcqk+VXS1yS7URPiGoANtAqWgZOSB0+7re01bzcyEqMz8ZJwQB56muYRyGP/brIXwXcxvLuWQ2SHDLVH81FDsF+Xti5JB875NP8s9vD+BJV/N10r4ITa0kAqA7q2Y9NWfO1m2iiD/oHzjXnz2YjcUXyDSGeMj+BIw=;7:0MhbixpxdCAAZ31xl65wN94JAzc0L7gk/TmUwx6nxaazvFw/ud4kzowndtlrrqGbw+QkBWsh1jEva4EbZs8AQLJDsw3sI4wpEL8JAhcLP3k2KYnxZIRdZkPnc4jNAAejL0Twdmg8Xc0496UilqREAw==
x-ms-office365-filtering-correlation-id: bb71b786-3f35-4e85-3425-08d64eca3685
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4775;
x-ms-traffictypediagnostic: AM6PR04MB4775:
x-microsoft-antispam-prvs: <AM6PR04MB47759BFD21169FE430AA7C7584D90@AM6PR04MB4775.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4775;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4775;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(66066001)(1076002)(2900100001)(68736007)(8676002)(6486002)(5660300001)(8936002)(6116002)(3846002)(2501003)(97736004)(81166006)(26005)(186003)(81156014)(105586002)(7416002)(102836004)(2906002)(386003)(6506007)(7736002)(305945005)(106356001)(6512007)(76176011)(36756003)(4326008)(99286004)(52116002)(14444005)(25786009)(110136005)(54906003)(2616005)(86362001)(53936002)(446003)(11346002)(256004)(2201001)(6436002)(486006)(71190400001)(71200400001)(478600001)(316002)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4775;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: h9Tjj4Deu2/YjB3jQvVjaxm8aB7rSeezgxy5K07oDbTGSNJ/GMMvxSqgz1zCnDCC2kcvwUE6mpC7mEDBl8O6LF+eJljjpry0UatucgWWRYYAQxioad6QW1YejcD3wz8tL2eowqUSadkPMWK9HSfxQk0pC7yu67yxX+2wdxbcBa8bbLzSqn2x4v5yBOB9dRmF/Y+WxFhk9RmnzLlmOOoSPealkwe5daJ+Y1qlboypkPL3QViFh3uEr7Kbgym4Cdm81DfqOsfnQwaRDS+LNwziZaFPHNAIZJE9SBlAKiOiTyJ/WUZ5xQ0nNAbh2/bcPmA/viyx2cuhMb01PI98lZfN+xwaE2y/xHOQhNbERhumTy0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb71b786-3f35-4e85-3425-08d64eca3685
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:26:12.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4775
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As it won't delete any node in this iteration, replaced
the function resource_list_for_each_entry_safe() with
the resource_list_for_each_entry().

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 8ff873023b5f..b2cc9c097fc9 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -569,7 +569,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 {
 	u32 value, pab_ctrl, type;
 	int err;
-	struct resource_entry *win, *tmp;
+	struct resource_entry *win;
=20
 	err =3D mobiveil_bringup_link(pcie);
 	if (err) {
@@ -620,7 +620,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
=20
 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
+	resource_list_for_each_entry(win, &pcie->resources) {
 		if (resource_type(win->res) =3D=3D IORESOURCE_MEM)
 			type =3D MEM_WINDOW_TYPE;
 		else if (resource_type(win->res) =3D=3D IORESOURCE_IO)
--=20
2.17.1


Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CEFC43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8407420671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GzubTKzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8407420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeKTTzO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:55:14 -0500
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:17696
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbeKTTzO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1T5BV36agyfCDR1ehoCpE1ivcDfB/dlzT8GWZ0qN8c=;
 b=GzubTKznkLxED5rys5q34lkoCZAOPyuNae6bRSAZxQ7+XkpUCw3GXZEUF4m+DIpb2ceIeVaaawhzS4L158Y0RicfMB+8CXjERFiPgPFV3RG3rS8gBqEqfaKbGt1mb7kHAsfTsZtX5zEXsQ3OqbVui7Q2uQ4rTvdK8SRmjEkKmn4=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5269.eurprd04.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:27:02 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:27:02 +0000
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
Subject: [PATCHv2 14/25] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Topic: [PATCHv2 14/25] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
Thread-Index: AQHUgLMx5aBe4vIHuE218OKNVbDjcA==
Date:   Tue, 20 Nov 2018 09:27:02 +0000
Message-ID: <20181120092615.11680-15-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5269;6:c3uK7t9w3TqvO0zsskYV0oQPF1Ecw0nfX2+d10VrfQMASQM8OPAmxj4fTTAZ2CEAf9QqNi7TQu4aeHoSHUAFGt8qIMFBl2kHnXOB6gM9bv5q20yltbp7IWWsatAiAXH0QREuH0M7usMjmzFiq9/HOEliO772KHxbhKHGTGNPJCaWGML9NCwcjFA9Odjw2Sd2L0xVRNoSNr2OwH5mQm9KQnTV49a9iawg3+8fPI3RMYjiPyPiNDkLVvXQv/4P2cEcx1JSbaFTuoqTamyMru9Il3Z8hgz8ZPZPIEiIJxQKn2gem4hQ28eXe7Dyz9jl+++Uofsod1uEq30GJXSO/4duTlwV6luAgkj7pMKOKZDslpEj10sVRD954tEQBVxZW5UpdUPUYZl2JRkhv4jKfoDAH9KgKiL7jXdbqeWUsd3FRPQ4cT4qAylS6XJBkzjeHo9z7ZMHNT/r9elXaVUzbHnXpg==;5:95pdw1nEMrkHMggTIubzcrzZzhmtrirJQzBFc1bGD7nc3TEUmufrh8JjWWlHezVC0EM+II++pGzMNKiwf6plUPUb3Z70Mzmc4gbGTNCZqVfr2F1ExsHxDL+OybJG5lPpjRxFCRzO83otCD3Wbzfpy+3OtLj9MFXotp8ksjP+qKE=;7:p6oJn3UI2DFD3+ZnOCfC9H0PjoxGNFhK3Yge54ab1ehF1YeyVOES1cmfx1E5VCV9/qobMazFqtXMiYXJYTBaWHbBQtYNgwL5NcNpza0U0/qE4tzUb/Ewoih+fM6lG3x5bu+TvN2E8oaxzABGLGo58A==
x-ms-office365-filtering-correlation-id: 012d7905-628b-4b01-d5f6-08d64eca543a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5269;
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB52690C850FB2598874B2A3F984D90@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5269;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5269;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(5660300001)(7416002)(68736007)(2906002)(4326008)(8936002)(14454004)(256004)(54906003)(53936002)(6436002)(71200400001)(110136005)(71190400001)(6512007)(316002)(2616005)(476003)(446003)(11346002)(486006)(25786009)(2501003)(2201001)(86362001)(52116002)(76176011)(6506007)(102836004)(386003)(186003)(106356001)(26005)(2900100001)(81156014)(81166006)(105586002)(6486002)(8676002)(99286004)(66066001)(6116002)(3846002)(1076002)(478600001)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5269;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8m6dpeExL1rjbYbxZ+ibatZBdkhFmhp8qsU8j4/FqojzI2DOwBHBlgrCXnwALaSe3ypLeOpX/ubaJWX+eRoLTmV5vjtUEtv7CktRPDgqgq3mOSiKUznjXkjkxzHXnQGtYFM5Cw6+pNBXN458TywTZ72v6KTzbBHndkD9Np+1GGMao4Xu1+I7CORk5E2VvoobGlWmskEO1+4+PHcClave0IItaJ9Sn5WPvDLMYz0jWEkHAkhs5G0dsGmaLxP/QLWNEKotOyzgu+lFFpfWmcqAoeJDXmIybGqafvqC7unKPZEB5V2s9Go+WCZ75KMJ14DdGwBtuiDE+e0qrMg6T/4p/mvYfejmcds/LqF3oNb0EYk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012d7905-628b-4b01-d5f6-08d64eca543a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:27:02.7225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The reset value is all zero, so set a workable value for Primary,
Secondary and Subordinate bus numbers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index db7ecb021c63..9210165fe8c0 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -582,6 +582,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
ie)
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
=20
+	/* setup bus numbers */
+	value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
+	value &=3D 0xff000000;
+	value |=3D 0x00ff0100;
+	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
--=20
2.17.1


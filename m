Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC9C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB462177E
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iz/OJiAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfA2IJ5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:09:57 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:64890
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727935AbfA2IJy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2KL3lq8cGHB4T0MlDA0MHl8UFeRA6CA9YVP1gwvvPQ=;
 b=Iz/OJiAeo9XHcQ+Wm5Q5T7mkmWQFEaWEDIKr6TlfecIsG+FcWN4SZF+xvkLzpoq/P3Ek0igXwsMnj0yiYWT4HsHyqr+0XimceUW2l5JoHLHt8/FUxDatjpvvZworApM9DceTkxHgPQa04j3aDhZjpsszolNpcMjqos5vfEt6/GU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4728.eurprd04.prod.outlook.com (20.177.32.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:09:51 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:51 +0000
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
Subject: [PATCHv3 13/27] PCI: mobiveil: move irq chained handler setup out of
 DT parse
Thread-Topic: [PATCHv3 13/27] PCI: mobiveil: move irq chained handler setup
 out of DT parse
Thread-Index: AQHUt6oCmQwmtRffokSeu3VU1YDeTA==
Date:   Tue, 29 Jan 2019 08:09:51 +0000
Message-ID: <20190129080926.36773-14-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4728;6:gUIOfcDRmx16FWpqG3GQKaSbvlKTixoCAX1DIh7qV40LeukJWSo6h7m52ET5dnj0aI6CDhHN6NEcr+L9WTsxTpLa9QSc5MTZPTjb0qDMp3ZsvZsHSj2TvlJjOuXar5a6QgIYQRKK69jA3og6YgracqiXc5o618PUNezp8TDDs1FneyNXzT/tIpBJ0OIOa0e5VUPseekaM/QSkwklTydUEg0p2VrLz2Pvn+Ou2yPd9HHXnS3h4mU47GeS45/RsRjVNQZDGw+XABxc19kapE54+BaNca37KgGRq6M5dJ9cx7u7MmcCw/nOF95VEW+LZ68wzLu1xfVEW44DKYzIHfPnahq0aOT+MZno0nJRSqoG1RNduV9gqA+0v5NpnId1rK7FGD3AEIUhv1CNdSaBGPK0BZ641SErh5+mOZ33ELW/+sZ5YuuHOZqQQ8TdrLyUXaC7FlBsemTsmziAPtb0JPxBwA==;5:cJ7wxmKRJQXzCp08KA8kMxVBLkULuYd4RKSqhG29NSnoKwVbHqmgs9UMIz4ykYlW7ali91XWFIyIaKqZfIwxH1JlzvWMH3eH3BY98lT8p/z4+u21CjHdwmqf4Qm3eXCwqHhUUDJumEf4yTX5Cw7q2CA14Dh5FZBMhzWYetva/JFgkOs993MknKpa/uWkHkCvzbXdznYqO1EglaMpC+GHCA==;7:NOgXrtwQeXiPEIydphQAPbHaZiwkzkqcaJrkvveQB4TT/J5cuAr/FkEgbf+JhNGbLE1BelMBDksBIiGdaRx0+/zuhVoBo8GoA7Z/gC9a9EYMDxh89uE7PVVH9XvwQvzFvZBrL2f0moJD4tMTC+CZwQ==
x-ms-office365-filtering-correlation-id: c6b9869e-4f86-4bdb-be48-08d685c12493
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4728;
x-ms-traffictypediagnostic: AM6PR04MB4728:
x-microsoft-antispam-prvs: <AM6PR04MB4728D3C131232C75C619E7F384970@AM6PR04MB4728.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(3846002)(7416002)(4744005)(71190400001)(71200400001)(2201001)(36756003)(4326008)(316002)(6512007)(105586002)(53936002)(6116002)(6436002)(106356001)(6486002)(86362001)(1076003)(97736004)(81166006)(81156014)(476003)(2616005)(486006)(256004)(52116002)(446003)(68736007)(50226002)(478600001)(2501003)(14444005)(8936002)(8676002)(66066001)(6506007)(386003)(2906002)(11346002)(102836004)(110136005)(26005)(54906003)(76176011)(305945005)(186003)(7736002)(99286004)(25786009)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4728;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2MA8twzhiBzrqPy0ccMMQ/aDrp3qtEXfNvGKnWZxIxL6VPAUoVf7ILnGq91pASaAbWS80SmXL6UUbLHK4VUGwc824vgk0gpkqG/kPhsISxIQfE7rx+jYSsCVpfuK7fw8K0URpKtFxk2CU+YsjSsBv5Li21RU15cNJIk/laWxtwhZgnTXSrW8ZJz2CfSmf3nAmzymqs+OSboE8wJyVcUl8FiEVvh1JQSc78PwboMjNHeXluKazi2gY+8nAbB3dfZazoqT6s/TofXzLdTFZuF8I9BtpF+hr7i5bQGf867V1my38KwShnoJMv/1VehddUzKJ593OR7qXAfNuBWetutgsnZLqJ8noryxDvVFuch+F94G2qcRVfNnP6i3BTDOlYiheNJkp4N1QbT9PBMStVriC0z42wX4uWCLOKAmrzVfnco=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b9869e-4f86-4bdb-be48-08d685c12493
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:45.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4728
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Move irq_set_chained_handler_and_data() out of DT parse function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index c2848c22b466..db7ecb021c63 100644
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
@@ -902,6 +900,8 @@ static int mobiveil_pcie_probe(struct platform_device *=
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


Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BCDC282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2051214DA
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JXaRVGLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfA2IJs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:09:48 -0500
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:9047
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727861AbfA2IJs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uyK4TrdUSj9Cy+7nKGI6e2C6Ce5gy/FX6AJ6kLBnHY=;
 b=JXaRVGLhDadotn3NR20IiFb4q0i2kK7fvEhFHz+9PMuRBZJ1PomEAj0HI/T9DXGSkZvmVl8ydjdOpAr/mHu0U+Rda6nqxamW9G6j5XmTC4+9ksuRA+POfuTykzqOTamZGwrEkBcc5/jhtzZkPlHFconMKARTRg+lczS21j+TGXQ=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4774.eurprd04.prod.outlook.com (20.177.32.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:09:45 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:45 +0000
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
Subject: [PATCHv3 12/27] PCI: mobiveil: move out the link up waiting from
 mobiveil_host_init
Thread-Topic: [PATCHv3 12/27] PCI: mobiveil: move out the link up waiting from
 mobiveil_host_init
Thread-Index: AQHUt6n+j43p+JYnPUOWEcDY2fU1ew==
Date:   Tue, 29 Jan 2019 08:09:44 +0000
Message-ID: <20190129080926.36773-13-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4774;6:NHsDsCKkKAjC617WeqDwkFwc2xrj9WkFxZjz2FLhA/av7Ub4jljfKGQQGfpNcmuv+kLqIXz2MPyPn9r/VT3P2ieOjrDaKcHBHQYOgF/PVMz1vIJbbr3S7OK48E0BfrTK7rogtT4HwsCirCw6Jl3TDm8jFqdzEdF6LA+2LAXfuZaslXC3aFqI+i+dXb+ahIbMUNjiAxvZvtx3wUa2eGDOtxsYPj0jorrPE2hmi20RFk0Q/OHq5VabGh+PoJP9IVNORl7ERq9k5YasExABePMq4crhXnFvg1rPkt/6flHIj/+H+YemqmYb4oIopbbKKwqURw1kmnt4xyVKDgnvGJaAaRiqStqHZABO//0md7kZqSyMpnxYERV9KDFDEK/BYYAAG4YeE2O+fvVa55Wz68PbnfGFHwK5qVE4AR6n57VehR9F3UhUIDCbD8h5TiTNCxzEuIz5nw6M0xd4P9dQ59oK5w==;5:Koca4w0rV2ht3geZsPHyuOhUH4Qb+8ANK8Kd5rRkp8ZFr2gDi/x14QZaFdNGFTzwKFmkny/5Dn/z4acqK3qzgYmFW72STeo1MKyd5QmAz8NnlPabuxrTwZRZPm3aiavy+laG305k4GOvHHiSdhX8hsjOdOvCczZP1KugP049bIlVO9/I/jotiU47oNdkbQz6g57uU2QxuaB+pFCMDVVHMA==;7:d2lEE3I1uI9szJuhrwof7h2D88SG9FPT1XPwjl+dln02/KrphiPX2jPZKBA7m0T7rgy4OxQ0fJ3XAAk1DdsX/3BUEm55TI6Gzxg4ZpF8ZVPlqC3f4+0+9CRBqBMoZA/rDtARHZ+9W9OWH+RoPD59xg==
x-ms-office365-filtering-correlation-id: 754c54ea-2b92-498a-0e47-08d685c120da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4774;
x-ms-traffictypediagnostic: AM6PR04MB4774:
x-microsoft-antispam-prvs: <AM6PR04MB47746A541F2C69CB48C2665A84970@AM6PR04MB4774.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(189003)(199004)(86362001)(2201001)(102836004)(4326008)(305945005)(186003)(478600001)(26005)(7736002)(386003)(76176011)(71200400001)(14454004)(25786009)(6506007)(446003)(53936002)(71190400001)(52116002)(1076003)(256004)(11346002)(7416002)(68736007)(81166006)(81156014)(8936002)(316002)(486006)(6436002)(2616005)(8676002)(110136005)(54906003)(3846002)(2501003)(6116002)(99286004)(2906002)(476003)(105586002)(97736004)(36756003)(50226002)(66066001)(6512007)(106356001)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4774;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qb09VSPnUzl7Gy7CHHdnswQFoyEWYtEPc5VI/zSDoKqRijxH4sAI9FGb14dGT9N+WUk0qyZAbUpVMA3QOMjKpPeDM6dotk0vq2iQhSvQafyF1D3yZMPj4bdjs5Su4tu7gdZENTYhSAPG5cC8ibRlPz3+wg/QUEXtsWHLArO+9LLwi5ytwb0fFetbivMePr4hJJJUo53tvaeyrvb5IonpBYOeuXQxs3QZICxTPO7QXXRFsTA/NucEIAVhEyqukKfLgfcP3vI8a/25FI+gSFOsqbPu9KFybSXmIZPP5tYDyF9Y9jjN0y+8rDAtkabNkoVIule5U33BYbg0VywSVeP0nMjxT4AmFUC9+jPb72VRVXX75N4MCqFXKByNsNHed1pcc0wdKUQ7XoR06ijlU98gDFYUC5E/dGGXqNS9b1DDWOE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754c54ea-2b92-498a-0e47-08d685c120da
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:38.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4774
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Host initial sequence does not depend on PCIe link up, so move it
to the place just before the enumeration.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 8eee1ab7ee24..c2848c22b466 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -582,15 +582,8 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_p=
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
@@ -662,7 +655,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
=20
-	return err;
+	return 0;
 }
=20
 static void mobiveil_mask_intx_irq(struct irq_data *data)
@@ -922,6 +915,12 @@ static int mobiveil_pcie_probe(struct platform_device =
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


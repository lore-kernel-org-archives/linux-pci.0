Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236B9C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C49217D9
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XyPiFQs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeLREUO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:20:14 -0500
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:52896
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbeLREUO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 23:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaarYOSHenwYGQmPvPX8P11jD19ca6sC4p7nSzWqk2A=;
 b=XyPiFQs7f8p/55D6Xx4RolH4g797ajW8gOtHbZGoA7QyCFWmNTiNFHFe0jnk12IO2KGLLmFhKY4khsrqPdu0BReFkMOMnBqrC0kKU+63syP4UP+vrwwHJTO6fSAmYpKlrspX0BiWILUPBoQ+D2jZ2UbL602caLEqKInmBY6VRlw=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4102.eurprd04.prod.outlook.com (52.135.167.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 04:19:37 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 04:19:37 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv3 3/5] PCI: dwc: fix potential memory leak
Thread-Topic: [PATCHv3 3/5] PCI: dwc: fix potential memory leak
Thread-Index: AQHUlojjRQR4wIQbqU6X3IfQXDLFig==
Date:   Tue, 18 Dec 2018 04:19:37 +0000
Message-ID: <20181218041956.41809-4-Zhiqiang.Hou@nxp.com>
References: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4102;6:cq/frfSD6DmuOpgYEuTf/AmrniiqYJIRAUnjbibIezhWi2L57jbXQOHbtj2402lDUrNW077LCmwEVv6+MlbONMaxEqzVsCogoObzfk940zJgpwJFvSafKxZC4O+3yA3i7YYhGyPzN5kQF8xwLHG6mFLLCKXay1QCSzZY9hEOfCBvEoBWQjA/e4YV3iADzDOYVdAdoeUuwsxUN9o2T3/wK9ecEdrywf4d1NyT6a7oDSw3G9Z0nZx0xq+ULgQFXoueF2TwOAgePoKtn+rDrftc8diym2xs1KyYvuYPSLb4u0umne+oQfhd/cvUxIy1X/aUgbosLgKNQx2GMKFOI819Luy4rNT1/eFoZRyTpsewSv5fOq3d6DL63m9mM803w3AB067qdzM6jBTVhqB/5JwpnzkkIN92w2DpiXV7dMMtjKifvxbul9DHE34kkDQT7e3lxGtVxAu8T2S8QRbzMRWmpA==;5:/iQcj46gWPgFhsohePq2o+2fA+3EjDHL5Afm41IyqBW694OUfyM1wUKBrg3i9LUJb0uIoNIGUfWhW7FtrqEXQyXVkXQhn57Qv6pwws8YvdUz/j1oY50qScCoK/CozEjsyDlHY3Fp4mCubYjLeITJ7zmNuuKdCALP/GHcMYO03IU=;7:r1w+ZeZRTIDGlqpwWWpk0gZ920Nhy2htH3YHvcFebXt50aV29rik8eEgId5ToyaEkzQ8+jBFuLyL7tylfjaa23wU06vwh5cVlm20wCM58ka//Vcy0GqV0tWgedHvy/0Yb7dNntDzbxkGAmdQCkm2yg==
x-ms-office365-filtering-correlation-id: f9f2d90d-d222-4485-5bf2-08d664a005cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4102;
x-ms-traffictypediagnostic: AM6PR04MB4102:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-prvs: <AM6PR04MB4102F79D75D049494C9FCB3984BD0@AM6PR04MB4102.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4102;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4102;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(52116002)(7736002)(97736004)(7416002)(68736007)(25786009)(4326008)(36756003)(316002)(106356001)(102836004)(6636002)(105586002)(99286004)(2616005)(71200400001)(486006)(305945005)(11346002)(186003)(6506007)(386003)(110136005)(54906003)(76176011)(6486002)(1076003)(5660300001)(71190400001)(446003)(476003)(26005)(2501003)(2906002)(2201001)(86362001)(6436002)(256004)(14444005)(3846002)(6116002)(39060400002)(81166006)(66066001)(8936002)(81156014)(8676002)(478600001)(6512007)(53936002)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4102;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zzm4wtj58tPQ01iUbw+h6eXAuL9/VKzlQs0UPha0ybXfMv0puZz66vGvc0cXw6S3X11zcn9HyvSGOMYAEhDcCPwT/dLhGl/ryE2hOe8t9EzbVGi2WjioiCEeMgLNQSrD4NmDe7MRovJ1wnHEg30Np/19DFCxaOw88L2vHkukxQAY5ujSv4SlGKsd1WhDLxpnL8IJiFDY1+EXF9Pxf1nlwTgPaJC85mDgEzKcTM3epO4ULtl/tV5oeQwGNDA5BDkp6spwhSlninxitE7+9O00GwpP+etuShTDORq0cNWzunMJknmFZ5vwSsp8BrseR9jC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f2d90d-d222-4485-5bf2-08d664a005cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 04:19:37.8585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4102
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

To avoid memory leak on error return of the adjacent function
devm_of_pci_get_host_bridge_resources(), change to use
devm_pci_alloc_host_bridge() to allocate host bridge structure,
then it will be managed automatically.

Fixes: 295aeb98a322 ("PCI: designware: Convert PCI scan API to
pci_scan_root_bus_bridge()")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Changed to use devm_* to allocate host bridge.=20
 - Added Fixes info.

 .../pci/controller/dwc/pcie-designware-host.c | 28 ++++++++-----------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 29a05759a294..33b5a3815d24 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -346,7 +346,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "Missing *config* reg space\n");
 	}
=20
-	bridge =3D pci_alloc_host_bridge(0);
+	bridge =3D devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
=20
@@ -357,7 +357,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
=20
 	ret =3D devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
-		goto error;
+		return ret;
=20
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
@@ -401,8 +401,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						resource_size(pp->cfg));
 		if (!pci->dbi_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret =3D -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
=20
@@ -413,8 +412,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					pp->cfg0_base, pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
 			dev_err(dev, "Error with ioremap in function\n");
-			ret =3D -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
=20
@@ -424,8 +422,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret =3D -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
=20
@@ -448,14 +445,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			    pp->num_vectors =3D=3D 0) {
 				dev_err(dev,
 					"Invalid number of vectors\n");
-				goto error;
+				return -EINVAL;
 			}
 		}
=20
 		if (!pp->ops->msi_host_init) {
 			ret =3D dw_pcie_allocate_domains(pp);
 			if (ret)
-				goto error;
+				return ret;
=20
 			if (pp->msi_irq)
 				irq_set_chained_handler_and_data(pp->msi_irq,
@@ -464,14 +461,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		} else {
 			ret =3D pp->ops->msi_host_init(pp);
 			if (ret < 0)
-				goto error;
+				return ret;
 		}
 	}
=20
 	if (pp->ops->host_init) {
 		ret =3D pp->ops->host_init(pp);
 		if (ret)
-			goto error;
+			return ret;
 	}
=20
 	pp->root_bus_nr =3D pp->busn->start;
@@ -485,7 +482,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
=20
 	ret =3D pci_scan_root_bus_bridge(bridge);
 	if (ret)
-		goto error;
+		return ret;
=20
 	bus =3D bridge->bus;
=20
@@ -499,11 +496,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pcie_bus_configure_settings(child);
=20
 	pci_bus_add_devices(bus);
-	return 0;
=20
-error:
-	pci_free_host_bridge(bridge);
-	return ret;
+	return 0;
 }
=20
 static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus=
,
--=20
2.17.1


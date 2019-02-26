Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C71EC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F93217F5
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="jwo5Pdbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfBZL6a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:58:30 -0500
Received: from mail-eopbgr710071.outbound.protection.outlook.com ([40.107.71.71]:44896
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbfBZL6a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 06:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCIAgyc0dyZXGWnEL+YP+rbIulW9e2ZVM0504mRNcjk=;
 b=jwo5PdbcESNEStlwO4OnsaqD8HkF5xP9VzLBYtSQkfrcHKow0fomIT/HUdYpC2rB37H8iLd3ph/VL9aTU88aGjkhB4PiaoRreLHYGr5MDGmLENkjkMxN4NR6U3ZOMSa0zwwcDg1JP3ANliyHzw2f2tprEu+NLGi7P3pA59yX2ac=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3989.namprd03.prod.outlook.com (20.177.126.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 11:58:26 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:58:26 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/5] PCI: dwc: use devm_pci_alloc_host_bridge() to simplify
 the code
Thread-Topic: [PATCH 4/5] PCI: dwc: use devm_pci_alloc_host_bridge() to
 simplify the code
Thread-Index: AQHUzcqUjIgD4+38S0qkh/9pYJbfpg==
Date:   Tue, 26 Feb 2019 11:58:26 +0000
Message-ID: <20190226195127.72dd45e0@xhacker.debian>
References: <20190226194806.34fc23b5@xhacker.debian>
In-Reply-To: <20190226194806.34fc23b5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:404:56::36) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d1780f7-b5fe-43e5-5e9a-08d69be1b730
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3989;
x-ms-traffictypediagnostic: BYAPR03MB3989:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB3989;23:Ql5tN9+MGTHqOPqyzLsb92BXHVjKS/tfVWbOTu/eA?=
 =?us-ascii?Q?Q1vvdjGqyfPzLWxQZc7I8dGxpT73FmoWDzT1EPNNcILJkn7dYpXcPX+FSBzl?=
 =?us-ascii?Q?d7HdFrLg7OwD9lSrDSZwPfZP7kYDHvq6Ogf46ATNwZtVHjIFNs++Lh+qkW77?=
 =?us-ascii?Q?GMfQlcG8EYeJeaXEbCtCOfEtdr+XHfQ3XNoF+AYsQ1YhudH/sNrAakp/j0HY?=
 =?us-ascii?Q?8Zl8EGA06SqktQG7Ov+MjyQiX2RfA76/y5UUwBH55cP19mdOIqX6U7lw5o72?=
 =?us-ascii?Q?7oOS9TamFagqmfteHwrwikilH4LjBdb+uAb4ozv9j6TJjylN6x0LHZ3UgpBX?=
 =?us-ascii?Q?DBBmWsKWRpvfaaSoqC92SOglppmjPXdb+/tHYkQw7FrisYJbPbk0F9SCQMHq?=
 =?us-ascii?Q?oOL6izJ6+jgo+v0SraN2Lv9kw11FHprJU/DR9GbXdSxYph8E0IYkXfnv43vh?=
 =?us-ascii?Q?OhknRPVz+0KYi91RFAXuWV4ulC4plv4qBWb2J0A4ItcvcTCXcIOgRHyFWHVd?=
 =?us-ascii?Q?AmuCJ3ZotmiljNP61iEAPPXci4c8AwX8g1kbfdwWr1L6RHCbsHEmqrnbKvUl?=
 =?us-ascii?Q?YDe3bd9W1zI38ajaGzyjrEJFlit1/oNAPe068Nj5FQQv4O9CH8ACxVXmLuTH?=
 =?us-ascii?Q?1l4jEsme1KAPgdxzRmClA2fFFOi4PIj0Hc+AOnv2h6O+e9v+GBhWAshw4yvH?=
 =?us-ascii?Q?SYAire0xDy5Ts23hnqogOjaft38/P99lice7XLmfQaWo2WWF8Kg1TYdkEWZP?=
 =?us-ascii?Q?/vSUKx2yG64naLtOvMWQjfzsYNO7pvByh1OPS83FHycK4VFmgMCBxRE5Us0A?=
 =?us-ascii?Q?zoR5nTbgx595kAfUrzoVONHjpnp0x0Ke9mPNhsKYcIZJ0WJQglcuKluQ2y1+?=
 =?us-ascii?Q?nXr8McZ1W+Fbe67cqFR6VtLRFhSqOKI3xLiL0WDfg3/eecv3AqfNeHZbCjkF?=
 =?us-ascii?Q?nij5sdpQ837RMH2bpKQ2+XsQKA+TcmpADkQtrbNHnExrqDrhzBbL5zLNJoBe?=
 =?us-ascii?Q?OkeRFDa5SYALcNu7Yni7i2FrwJ40xDssTctuqWb2kixORyODh0CxsLLNcCYJ?=
 =?us-ascii?Q?t4ot0qnCMrORJj6WRFVA8jdkOaxwk77igI0/FLUy9F9EqIZrn00ZO/pma7j0?=
 =?us-ascii?Q?Bay7IXetOssG+4zjHYJ0NDHMftMVJ+15fNjwyftBgv5KWDoWiBE2mhM9m1za?=
 =?us-ascii?Q?JNDhIu45ZteM29oWNynuaAXW/gwAhFEOFHnwypZgVXBAH9OhYPxVWJWqoZNR?=
 =?us-ascii?Q?ar2ubdA3D/vJqrDu8w=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB398970A6A7AEE82FD25ED766ED7B0@BYAPR03MB3989.namprd03.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(1076003)(72206003)(26005)(6436002)(6486002)(316002)(2501003)(52116002)(6116002)(3846002)(486006)(25786009)(102836004)(76176011)(186003)(476003)(2906002)(11346002)(5660300002)(105586002)(446003)(256004)(14444005)(106356001)(6512007)(9686003)(68736007)(71200400001)(71190400001)(7736002)(305945005)(86362001)(8936002)(2201001)(478600001)(81156014)(81166006)(50226002)(8676002)(99286004)(6506007)(66066001)(110136005)(386003)(53936002)(14454004)(97736004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3989;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CDF2Eb3t5XEfjMfBj38gDfJwblxdU6dA3ZynGw+181JZ/92Y1+lAGJULyrN2IrceuYfAeRdVr0aabkdsTWk9KezZF3susuMA8AqU5fKkxNdJ6Ik/+FRT+jJalTzvPRaHwC6AYYoRPoU4G9Pc5N5DbthEePR6SG+uLjRp0fdi8vffIZZNcEau8Tx47tIuTSQoZh2FpzB5R2ro0L8hL+VE6xOMK3+v53RR98w7Iw/nnGxVUY9rlmtirTixhRXE4xe/kJ5OlPoaF9NeghgwGpirShl5nS0k1Q0pZhOcOUxR3TIbb1QDscyqN8QAUNnwnOY7Kj34nAbntM5d6qaT9SwBYrcw1WOw0yvuzFaX2qiiH/K/do96LJcWJheG1MmCc7tVU4oVShyV4MZENAQtnTyl6vIa1qhrpJbBAOwarpzXHqo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8F88C8FB909F3439873255CBA026ACF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1780f7-b5fe-43e5-5e9a-08d69be1b730
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:58:23.8473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3989
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use devm_pci_alloc_host_bridge() to simplify the error code path.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 66569d0f3ab9..4831c12fee93 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -357,7 +357,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "Missing *config* reg space\n");
 	}
=20
-	bridge =3D pci_alloc_host_bridge(0);
+	bridge =3D devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
=20
@@ -368,7 +368,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
=20
 	ret =3D devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
-		goto error;
+		return ret;
=20
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
@@ -412,8 +412,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						resource_size(pp->cfg));
 		if (!pci->dbi_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret =3D -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
=20
@@ -424,8 +423,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					pp->cfg0_base, pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
 			dev_err(dev, "Error with ioremap in function\n");
-			ret =3D -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
=20
@@ -435,8 +433,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret =3D -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
=20
@@ -459,14 +456,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
@@ -475,7 +472,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		} else {
 			ret =3D pp->ops->msi_host_init(pp);
 			if (ret < 0)
-				goto error;
+				return ret;
 		}
 	}
=20
@@ -515,8 +512,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 err_free_msi:
 	if (IS_ENABLED(CONFIG_PCI_MSI) && !pp->ops->msi_host_init)
 		dw_pcie_free_msi(pp);
-error:
-	pci_free_host_bridge(bridge);
 	return ret;
 }
=20
--=20
2.20.1


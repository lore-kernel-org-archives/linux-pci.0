Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB43DC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6D520842
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="WjaFSOTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfCAFGG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:06:06 -0500
Received: from mail-eopbgr800040.outbound.protection.outlook.com ([40.107.80.40]:51183
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfCAFGG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 00:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCIAgyc0dyZXGWnEL+YP+rbIulW9e2ZVM0504mRNcjk=;
 b=WjaFSOTTXdm61wKhPwECiT37dHnQ8eMDOQyIFNIcniUmUvTkZw6mazklxSZOabaCQ6xv9XCXOBZdtyzQMEIEEJBncndqAquEvxAHCY4lzdxKzVj5LDugIp0RXe8oYbZTEJY3eufGfJT45dSM+SUl/RXJc0kaUNIYSES7OUHLN5k=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4533.namprd03.prod.outlook.com (20.178.50.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 05:06:04 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 05:06:04 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 4/5] PCI: dwc: Use devm_pci_alloc_host_bridge() to simplify
 the code
Thread-Topic: [PATCH v2 4/5] PCI: dwc: Use devm_pci_alloc_host_bridge() to
 simplify the code
Thread-Index: AQHUz+x4rd+EJMsrS0mSjARO970vsA==
Date:   Fri, 1 Mar 2019 05:06:04 +0000
Message-ID: <20190301125901.5ee7730c@xhacker.debian>
References: <20190301125510.4e2ee985@xhacker.debian>
In-Reply-To: <20190301125510.4e2ee985@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:404:10a::31) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9c2177d-ec54-49c0-fc5c-08d69e039ad1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4533;
x-ms-traffictypediagnostic: BYAPR03MB4533:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB4533;23:McDMIRp70j32p0k+s3Z6YZb8KgIQJPMgY+DypZ8LJ?=
 =?us-ascii?Q?1ZMjVdxDsJiregkQz1vWntJEgI2ifMZdp95Gz+G47OWcT/77L1Ty1H06Z0yX?=
 =?us-ascii?Q?Bx/Lc9dgLytE7msM3lGj7qIgpbiPyauldxjlIDChNxRdhjfX9kDKaFkp2XWV?=
 =?us-ascii?Q?964YksfwV2f1D4mJWVZbVSeeB7U1EvvhNb8zd3YtX7/kXsAyvNP9Uodzgfsf?=
 =?us-ascii?Q?DU8PJ2uisH8J1hdlD5Vwci4QbvmohTAJb1jpNWD5fshcOWpKNdS9O0ZCPPpp?=
 =?us-ascii?Q?xZ/QGw3vxypgN3klIteXRMJCFcF1gC9cNzBPRXrdPDUAmfh1KO4HXVQ/8mCP?=
 =?us-ascii?Q?RWu4GFNvf8ft/bPjWugXXsIcPqknv3cx/Yx0Uscdz0DcJbKDqoRyCOcmmali?=
 =?us-ascii?Q?7sN54UccEii/Ym01muckRvBRN0mARXonwyS76Dcl5gpAbJhWlNuTb6d5ntBK?=
 =?us-ascii?Q?dzuKPN79qzgm1CzKa7qM60EqBhnUdQk/9OBBbw/+3Qx0dvdNXiehs+TBiZnr?=
 =?us-ascii?Q?tQiHP6hsnWkaD/tlPdtkNDIs1B2CZRMk93RSWA+r/T/K1M24aN14YL2WItDv?=
 =?us-ascii?Q?Elo6f+G5eOeafqPu4iXcfHhrcE3O5MD1OC8flehCP9hYZn6a7taG+sysgPP+?=
 =?us-ascii?Q?T1+oQ5Ulws9w0hNDVxGsAW19SbLXwT2kYVYOXtYLcxNulYi/JBhDZTc2GWOX?=
 =?us-ascii?Q?rjT46ryT077tqEG1NcpSTalyJpdM6UzRx4g6oIOxYhDNT/L1l3z2/i1rOdwi?=
 =?us-ascii?Q?SN1VSOPi7J9EClZ5HRZ9Unyw3ihpweIi1Qg58aVewhx5+XSPg3cd2rApFWlU?=
 =?us-ascii?Q?EWx4kcQUeQD2vrElUAeU8JJL9M4jMZS1pbLt5kVHaIlvHHVncv9107BDIycL?=
 =?us-ascii?Q?2bPPRkXO+JzGJZ+5T9nEVVmVs4gEnNQgxbZuEISMp16W5fYXwEBgxcllGCLT?=
 =?us-ascii?Q?MVuce4Zgq1Jo022NjvKWr+Ok1qL8jSphc4QF28FrPvzjiGC1qSeAKyx4Nx+c?=
 =?us-ascii?Q?aZ4qX9LncrE4Xo34ryC8cMAb5hQoRdeVMlwxG6ITKT7itC3P+rADJHKaW5Fl?=
 =?us-ascii?Q?sGsBHjOgPY/cJ7N+embdpvPOYEcpsxwsba8sPxC3OmGHCtRFR7Cdk3vFIDAf?=
 =?us-ascii?Q?bFhcAbXlh5xk6R3AwtTY46S8CKGCLE0Rhl1V0/OxFSibXxYQq54hN0ynNFOi?=
 =?us-ascii?Q?ef4DkT1yHi+JJGwuN4PcqADxpBjVdDZJTB3R5d5Pr8+WAGTdagOL8fUxpzUa?=
 =?us-ascii?Q?ZfuOqIBDl9+nIyJXTk=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB45332558A22AF87A393C457FED760@BYAPR03MB4533.namprd03.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(86362001)(316002)(11346002)(97736004)(6486002)(76176011)(66066001)(25786009)(4326008)(68736007)(102836004)(50226002)(5660300002)(476003)(6436002)(2906002)(54906003)(1076003)(9686003)(106356001)(7736002)(386003)(8936002)(3846002)(14454004)(71200400001)(478600001)(71190400001)(186003)(81166006)(81156014)(6116002)(72206003)(256004)(446003)(305945005)(52116002)(53936002)(110136005)(26005)(14444005)(8676002)(99286004)(486006)(6506007)(6512007)(105586002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4533;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4GRaJSnkEqVifUyv51EcpeU9WcRoz4xph7BBlVcu9lOl/ySbN/4llfjBg2LthhjEV8cqRwtS57YYe5EatNfBvWUaZbh99qMvZtMVhC4lQilsYNj8/WLFax09SeL+MkhrixMujiyPJ+TlejWhVil9f+xahYeR3KOg2P6aLk7RVOlIhUhjRQo/sAvjBPPMkJDtVtSd3vpLCCP9JHmva55ugKX790D+uFG1RNfgtOgO0bA3s6Zt+QboC+JppaMvjT7nefXiF8cQL9OfXUcJ7e2Dzm31H5indbL31ScMQcWPL4tA77wxJHk29ipJjhomRA0FWtoI3wFrZyCNVQppvL28RyisIeMhZDUsmbY+cIoerUpI1AZoeg0yYe1MCq9OfJyuRsAf/ZWVg/TS02TLKqw/phrNDnV8LvSvhLhC62gSs9U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6EF85607DCB3D841953513D440F871F8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c2177d-ec54-49c0-fc5c-08d69e039ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 05:06:04.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4533
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


Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47E0C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECFD2063F
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="JiIs3T9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfCRJ5d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:57:33 -0400
Received: from mail-eopbgr760080.outbound.protection.outlook.com ([40.107.76.80]:63752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbfCRJ5d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 05:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfZNa/BIRYhv/l35s63hd8lYRfM5oD9vfKkc+5UeD4k=;
 b=JiIs3T9Kj+ApW1ZflERY+FI5N7VOHYfDGsMzP3M7J0fZhnpGAd7Nxw4BLWFB21G8PKeJN3kaQxZdo+ZAjBJTIeWFkHyLnjQIKhuay9Z6Y2Cr2n1fFN1vfMozHAi72uXHVDW3LIvDVLAcy/QJuN8A1st2TpyRjFDRI4L75cuOaIw=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3512.namprd03.prod.outlook.com (52.135.213.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 09:57:29 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 09:57:29 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 4/5] PCI: dwc: Use devm_pci_alloc_host_bridge() to simplify
 the code
Thread-Topic: [PATCH v3 4/5] PCI: dwc: Use devm_pci_alloc_host_bridge() to
 simplify the code
Thread-Index: AQHU3XD/ghaIsUq3jEigJqiYRMMPzA==
Date:   Mon, 18 Mar 2019 09:57:28 +0000
Message-ID: <20190318175005.7bfaec27@xhacker.debian>
References: <20190318174415.74fd25a5@xhacker.debian>
In-Reply-To: <20190318174415.74fd25a5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:404:15::13) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7655bff-c393-486c-096a-08d6ab882197
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3512;
x-ms-traffictypediagnostic: BYAPR03MB3512:
x-microsoft-antispam-prvs: <BYAPR03MB3512BBAD81520AFD755E5A4FED470@BYAPR03MB3512.namprd03.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39850400004)(199004)(189003)(6506007)(386003)(102836004)(6346003)(26005)(76176011)(54906003)(52116002)(99286004)(86362001)(316002)(53936002)(6436002)(9686003)(6512007)(110136005)(5660300002)(66066001)(14444005)(256004)(1076003)(71200400001)(71190400001)(81156014)(6486002)(105586002)(106356001)(8676002)(81166006)(3846002)(6116002)(446003)(97736004)(11346002)(2906002)(4326008)(186003)(25786009)(7736002)(305945005)(72206003)(478600001)(68736007)(8936002)(14454004)(486006)(476003)(50226002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3512;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u7Ca3+VTu+mxCuRkfcl5eT7HwmQ8ocjzxelESWSufor4akKaKswSQ8IXHd00zUqtm/HYX98BzRUo15HfqBB0GXvU1lryXghJnDLxNTy4USbdQ04FJPT9W1SkwIEpiN/xQ7jWzUjGVvh7dY4c25DXLhGGyAbYFaoCyuwW/4C+dsocC8wP+x5nDqQdTbHGPSAlnrPgmx/dujCy3Hkx1WiAKOdx8LcNvhNAvrbbmXChBR+ZQiUsf1HPMCaqcrwjI0sy8yZqByCfkYYEwCfBVMiJOmuR8H/uOKHBvy+E/+88rRFL4Ss0XePSUbZhwr6I0Y/MS3/oAMMxCzKrdCOLZdV5Jjhe4Z49fZIqQuR4X0H23t0KXHFo1OXPsxORafUwy81E0anMKAYg5L7vFnOQhYoDDBGBBkULVx41heVhXuo0sEU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <029917FE50189E4AA5B5516964D21C93@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7655bff-c393-486c-096a-08d6ab882197
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 09:57:28.8583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3512
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use devm_pci_alloc_host_bridge() to simplify the error code path.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 585080699675..68a9dac23b1b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -358,7 +358,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "Missing *config* reg space\n");
 	}
=20
-	bridge =3D pci_alloc_host_bridge(0);
+	bridge =3D devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
=20
@@ -369,7 +369,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
=20
 	ret =3D devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
-		goto error;
+		return ret;
=20
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
@@ -413,8 +413,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						resource_size(pp->cfg));
 		if (!pci->dbi_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret =3D -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
=20
@@ -425,8 +424,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					pp->cfg0_base, pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
 			dev_err(dev, "Error with ioremap in function\n");
-			ret =3D -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
=20
@@ -436,8 +434,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret =3D -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
=20
@@ -460,14 +457,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
@@ -476,7 +473,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		} else {
 			ret =3D pp->ops->msi_host_init(pp);
 			if (ret < 0)
-				goto error;
+				return ret;
 		}
 	}
=20
@@ -517,8 +514,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled() &&
 			!pp->ops->msi_host_init)
 		dw_pcie_free_msi(pp);
-error:
-	pci_free_host_bridge(bridge);
 	return ret;
 }
=20
--=20
2.20.1


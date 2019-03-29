Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4598C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B712075E
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="XnNc5RhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfC2L64 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:58:56 -0400
Received: from mail-eopbgr790058.outbound.protection.outlook.com ([40.107.79.58]:33702
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729406AbfC2L64 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 07:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v47moEqUBbS6CG9iXSUFR2k+rZtFMLmVbAjCEzZ3P0=;
 b=XnNc5RhCrInW3ZMz6m4s9iYn7y5Ghraj+Wo6fwQ0AZPVkZYnJ4ALD8tJNkPQaiP9/cyTB4gEpDJ0SLfNmiK/7sQP6KrBRbGzV9VI/o010WdOYcgdPEr9BToDXxDkGhTmKIzEXbIzMtTfSeKnTj0p2g+mXjm1gshP1AgEH9fbH/Q=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4677.namprd03.prod.outlook.com (20.179.91.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 11:58:53 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 11:58:53 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 4/5] PCI: dwc: Use devm_pci_alloc_host_bridge() to simplify
 the code
Thread-Topic: [PATCH v4 4/5] PCI: dwc: Use devm_pci_alloc_host_bridge() to
 simplify the code
Thread-Index: AQHU5ibHIJJqTWvLzUuMnrUhdu3x1g==
Date:   Fri, 29 Mar 2019 11:58:53 +0000
Message-ID: <20190329195112.11abef0d@xhacker.debian>
References: <20190329194750.265f6df6@xhacker.debian>
In-Reply-To: <20190329194750.265f6df6@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:404:ce::21) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9e84a40-cc01-4cab-9ab4-08d6b43de9e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4677;
x-ms-traffictypediagnostic: BYAPR03MB4677:
x-microsoft-antispam-prvs: <BYAPR03MB467749D8CB51266D69E4166CED5A0@BYAPR03MB4677.namprd03.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(110136005)(53936002)(54906003)(478600001)(97736004)(106356001)(446003)(316002)(105586002)(86362001)(102836004)(7736002)(476003)(9686003)(66066001)(305945005)(11346002)(256004)(14444005)(71200400001)(3846002)(72206003)(71190400001)(8676002)(50226002)(6116002)(4326008)(25786009)(8936002)(2906002)(6512007)(14454004)(486006)(6436002)(1076003)(81166006)(81156014)(186003)(68736007)(52116002)(26005)(76176011)(99286004)(5660300002)(6506007)(6486002)(386003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4677;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BZ7niUt8SEoFU8W60tVSqmrLEmH2543h/NThyXb+kNf3Jxi6eITEZAfbuaDfYxrwng71sgpKPfeIIQ8Bl4B6rB8035kVGrxbdbNGF/nONKgFlpEDjfURlKrbJmjTYI7d4yK3Qgf1bE4hmOwv8zIZmOUQd71EvSQ0Cq7jpMk2bWwA6YRiNFsW//ToE3CbxvocEn7zzEZ6D2GVUAfc/pKS06qnFwutBjOCa17lXUJUxLoFyYs45KI0S7stl4RrEZqoBzMJwT1EWFi5O8sVt+XgUV9xMNpu4Q+WSq0DGckX7tTxIcYKU5c83nqSDnhmImxsOejH0uZYlsJAkv4fJUV9R2MB6e3U1s9f2CH7Fkc+SzLRuLzQ31ywZWfncFOb6Uk3ESu2J9EM+m853pFbuSKWy/XB+7TAuXgGyf5O8pJEZ2Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2856F75F34FEC4E843E0D69B62D1068@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e84a40-cc01-4cab-9ab4-08d6b43de9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:58:53.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4677
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
index acc9be5cf34a..dcc7405aff9a 100644
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
@@ -516,8 +513,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 err_free_msi:
 	if (pci_msi_enabled() && !pp->ops->msi_host_init)
 		dw_pcie_free_msi(pp);
-error:
-	pci_free_host_bridge(bridge);
 	return ret;
 }
=20
--=20
2.20.1


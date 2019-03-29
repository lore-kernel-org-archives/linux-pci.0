Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31939C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C882075E
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="uqWpgKAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfC2L56 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:57:58 -0400
Received: from mail-eopbgr790084.outbound.protection.outlook.com ([40.107.79.84]:23352
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729453AbfC2L56 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 07:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b37RT4uKXDdbkxNeUhAAhSpdbcyTyUQD7FOeyCs8KSw=;
 b=uqWpgKAfCHU3XjcU11CDcG7d9IZMHMS2Eh08QDv/bhdnPxoZt3ye5cUFYVsaYnMhi+CXBMAPhiysuLYqhK6+75NX5PyOrutztOuHRKxg9DpJUcnmE4IWC6H1YOmejtl3+giSOWyxibbZfhp3JnePexY6K+oxuNgnyB3UAfLmoUQ=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4677.namprd03.prod.outlook.com (20.179.91.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 11:57:54 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 11:57:54 +0000
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
Subject: [PATCH v4 3/5] PCI: dwc: Free MSI in the error code path of
 dw_pcie_host_init()
Thread-Topic: [PATCH v4 3/5] PCI: dwc: Free MSI in the error code path of
 dw_pcie_host_init()
Thread-Index: AQHU5iakPXqGrGU6TUeWd4NIoGI2eA==
Date:   Fri, 29 Mar 2019 11:57:54 +0000
Message-ID: <20190329195014.54e54c45@xhacker.debian>
References: <20190329194750.265f6df6@xhacker.debian>
In-Reply-To: <20190329194750.265f6df6@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR01CA0003.jpnprd01.prod.outlook.com
 (2603:1096:404:a::15) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60148251-00ad-4915-5425-08d6b43dc6f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4677;
x-ms-traffictypediagnostic: BYAPR03MB4677:
x-microsoft-antispam-prvs: <BYAPR03MB4677883E06035160ADBC7987ED5A0@BYAPR03MB4677.namprd03.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(110136005)(53936002)(54906003)(478600001)(97736004)(106356001)(446003)(316002)(105586002)(86362001)(102836004)(7736002)(476003)(9686003)(66066001)(305945005)(11346002)(256004)(71200400001)(3846002)(72206003)(71190400001)(8676002)(50226002)(6116002)(4326008)(25786009)(8936002)(2906002)(6512007)(14454004)(486006)(6436002)(1076003)(81166006)(81156014)(186003)(68736007)(52116002)(26005)(76176011)(99286004)(5660300002)(6506007)(6486002)(386003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4677;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XpEU/8iu7x6u9BEOAQxuLy0ANXGqqMmF2KGS/9hlc/aiWj8JCRi3adUUiwxgU9AiOwEJObwsTZxXowHOyTZWCLOASbVvi9A8u3uv2zW1qxI2Xacc+za5DgOk0RCcGSXtR2P40UDg18LhJAAyEWTUtgADTymTRUOkdgE1rnNjiN7YKquePSthJ2qZ7MbLcSgUo2Pjwr4PXPgBFZxYhZfgcaNUfek9f8/D4YJKa/Bg64KbEspxTpOLWebJlUoGNBlGUS1nJDFIOuoDW1iSIgChtnrVEk+76qo5MsHSSdenmgfFvRuIzpe3k4Jicx3GAlqmiMNoeKnmFa4Bna7eFzJ/0gNB8Ckw1/8Hun9AxPbvMOK2oYEmxp+D3DO9Fptj08JUqmb4OrQjw2EijJlwYmF2/l4xN/dfYLam4ZNsFBXBZoA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CF048EA27826E449B67FB5B91E2B4A7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60148251-00ad-4915-5425-08d6b43dc6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:57:54.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4677
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If we ever did some msi related initializations, we need to call
dw_pcie_free_msi() in the error code path.

We also remove the IS_ENABLED(CONFIG_PCI_MSI) check for MSI init,
because pci_msi_enabled() already has a stub for !CONFIG_PCI_MSI.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index a71b874ae3c0..acc9be5cf34a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -445,7 +445,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		pci->num_viewport =3D 2;
=20
-	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()) {
+	if (pci_msi_enabled()) {
 		/*
 		 * If a specific SoC driver needs to change the
 		 * default number of vectors, it needs to implement
@@ -483,7 +483,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->host_init) {
 		ret =3D pp->ops->host_init(pp);
 		if (ret)
-			goto error;
+			goto err_free_msi;
 	}
=20
 	pp->root_bus_nr =3D pp->busn->start;
@@ -497,7 +497,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
=20
 	ret =3D pci_scan_root_bus_bridge(bridge);
 	if (ret)
-		goto error;
+		goto err_free_msi;
=20
 	bus =3D bridge->bus;
=20
@@ -513,6 +513,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pci_bus_add_devices(bus);
 	return 0;
=20
+err_free_msi:
+	if (pci_msi_enabled() && !pp->ops->msi_host_init)
+		dw_pcie_free_msi(pp);
 error:
 	pci_free_host_bridge(bridge);
 	return ret;
--=20
2.20.1


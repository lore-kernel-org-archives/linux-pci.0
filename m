Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E19C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93AF2063F
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="BaprT3uQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfCRJ6S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:58:18 -0400
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:35359
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727193AbfCRJ6S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 05:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EQqX9ME+mxb3YmCx3NnvilWTazcKxTSTu4S7WoOB6M=;
 b=BaprT3uQSYr6N/Dp5mMovqB38SgX2ojNOo5POFHqVnDsfvOaSuNGlKY8wqPsImOP6Dsp2h/aM1PbkZ/HJhv3/En8Ms2iHZmpCfgtBl/KIDO+nhyDFe0zpv0NJbrHjFikzvgYzs3wzkkPAiuAeS9yta4Q+nBcVaRmQwrf4yhRLws=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3512.namprd03.prod.outlook.com (52.135.213.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 09:58:15 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 09:58:15 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 5/5] PCI: dwc: Save root bus for driver remove
Thread-Topic: [PATCH v3 5/5] PCI: dwc: Save root bus for driver remove
Thread-Index: AQHU3XEaIjuV04Qzc028Roxs68+AUw==
Date:   Mon, 18 Mar 2019 09:58:15 +0000
Message-ID: <20190318175051.5430be17@xhacker.debian>
References: <20190318174415.74fd25a5@xhacker.debian>
In-Reply-To: <20190318174415.74fd25a5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYCPR01CA0089.jpnprd01.prod.outlook.com
 (2603:1096:405:3::29) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8c1895e-bbf6-447a-50df-08d6ab883d38
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3512;
x-ms-traffictypediagnostic: BYAPR03MB3512:
x-microsoft-antispam-prvs: <BYAPR03MB3512C9D1AF6F33B30002A9B1ED470@BYAPR03MB3512.namprd03.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39850400004)(199004)(189003)(6506007)(386003)(102836004)(6346003)(26005)(76176011)(54906003)(52116002)(99286004)(86362001)(316002)(53936002)(6436002)(9686003)(6512007)(110136005)(5660300002)(66066001)(256004)(1076003)(71200400001)(71190400001)(81156014)(6486002)(105586002)(106356001)(8676002)(81166006)(3846002)(6116002)(446003)(97736004)(11346002)(2906002)(4326008)(186003)(25786009)(7736002)(305945005)(72206003)(478600001)(68736007)(8936002)(14454004)(486006)(476003)(50226002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3512;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iURua1eFaXMYR1Q8DEr+I6K9AnTjkDIYzQIM6+yBNswGnhOTG7xKnb3Kh+9ZKQ4iKw8UMV6kiaP6Eqez7iKZL9zHeVWjSp63RvTYA0qGGpi23KZJen799/eZbJAYIWXd6+rDZcG6AKNuL/Gl+P1WNPi1U5KTF0vZIAyH8jKsrQXT+CtTEyXqtMjOEGszVDGMiwX8L3pS1KciWmyprSHhSG5egs8FdV5eFBP5yWEjwwAaKAaXaHnItpSxDxARvwnDWSDDVeQj2JpjfIyOj4MvPpn42CTjDBs41OaFztBObrcW36/ygj9eOKgzS8CByMp4pclDTFPJ/TcFdB0/mFPF+B7D/SZQ0FUX3B5wk1h7cAn/HdtcNA705CQkY5y18wn2Xrl4EgufzEFV7fcfx5kM5gwWXsUpq+WLDKN3bfrUXSE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08929240328F81479A90EC463E20D17E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c1895e-bbf6-447a-50df-08d6ab883d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 09:58:15.1897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3512
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently dwc host doesn't support the remove, but nothing prevent us
from supporting it. Save the root bus for clean up work in driver
remove code path.

After this patch, the dwc host users could implement its remove as:

static int foo_pcie_remove(struct platform_device *pdev)
{
	...
	pci_stop_root_bus(pp->root_bus);
	pci_remove_root_bus(pp->root_bus);
	dw_pcie_free_msi(pp);
	...
}

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 68a9dac23b1b..7e9dad7ba056 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -341,7 +341,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct device_node *np =3D dev->of_node;
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct resource_entry *win, *tmp;
-	struct pci_bus *bus, *child;
+	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
 	int ret;
@@ -496,18 +496,18 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		goto err_free_msi;
=20
-	bus =3D bridge->bus;
+	pp->root_bus =3D bridge->bus;
=20
 	if (pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
=20
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
+	pci_bus_size_bridges(pp->root_bus);
+	pci_bus_assign_resources(pp->root_bus);
=20
-	list_for_each_entry(child, &bus->children, node)
+	list_for_each_entry(child, &pp->root_bus->children, node)
 		pcie_bus_configure_settings(child);
=20
-	pci_bus_add_devices(bus);
+	pci_bus_add_devices(pp->root_bus);
 	return 0;
=20
 err_free_msi:
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index 6fb0a1879932..adff0c713665 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -182,6 +182,7 @@ struct pcie_port {
 	struct page		*msi_page;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
+	struct pci_bus		*root_bus;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
--=20
2.20.1


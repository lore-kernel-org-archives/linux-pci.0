Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EE6C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF6B2075E
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="P8fQvyM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfC2L7a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:59:30 -0400
Received: from mail-eopbgr790082.outbound.protection.outlook.com ([40.107.79.82]:9959
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729463AbfC2L73 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 07:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O3L1y6KM2Q6b0qVANwO0U4VBo4CWXvYKbt3CGrUo3E=;
 b=P8fQvyM7fmLqsDuCx/eTDizZquxrtknLoGA/dIKh+G+20V6lavAupqT8PwUoW0NZfbyfkfa/7lWfxtbVPDkSJ4cB0PxbU6QIz4R0wxKL8eXCixiktr3ISV46JR4DlQi4iB2sMuf7J54kxFlgEbsukUMivHTpfvVRPFZwmBWj/V8=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4677.namprd03.prod.outlook.com (20.179.91.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 11:59:26 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 11:59:26 +0000
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
Subject: [PATCH v4 5/5] PCI: dwc: Save root bus for driver remove
Thread-Topic: [PATCH v4 5/5] PCI: dwc: Save root bus for driver remove
Thread-Index: AQHU5ibbnD0hZoEW0kmtfkvI6C/+vA==
Date:   Fri, 29 Mar 2019 11:59:26 +0000
Message-ID: <20190329195146.3b15dcac@xhacker.debian>
References: <20190329194750.265f6df6@xhacker.debian>
In-Reply-To: <20190329194750.265f6df6@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYXPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:403:a::17) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf96f3e6-aa27-430c-3406-08d6b43dfdb4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4677;
x-ms-traffictypediagnostic: BYAPR03MB4677:
x-microsoft-antispam-prvs: <BYAPR03MB46779508F6F375457010D9FEED5A0@BYAPR03MB4677.namprd03.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(110136005)(53936002)(54906003)(478600001)(97736004)(106356001)(446003)(316002)(105586002)(86362001)(102836004)(7736002)(476003)(9686003)(66066001)(305945005)(11346002)(256004)(71200400001)(3846002)(72206003)(71190400001)(8676002)(50226002)(6116002)(4326008)(25786009)(8936002)(2906002)(6512007)(14454004)(486006)(6436002)(1076003)(81166006)(81156014)(186003)(68736007)(52116002)(26005)(76176011)(99286004)(5660300002)(6506007)(6486002)(386003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4677;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KLYrOAccSPqrNfrLuFOq0SU49FcPJgz1IkfyTu18TBXBuSopBujyK1MTyZ+YvF6g7kraDgnfp6cAedVDsAWB3JRYPK+red3IZtLgodKtGIGm8pR63Uxx4k5bO6ghelncX446jV63fMNJ64lXTa1yVbmfkalzABSaAPLc2UjUMLHBA4lS4S3pKe8QMZ+ug00LNJZ4Qvq4+TmvGDtIZxKCdzGiy0caw65H+BoVuwMyVDdD/qKtQfXeDTUk9mrTI3iO0UKViyXd3EFPHkSvI2eAsxGS+n7sbEhCXGsl4S/l4zK4Le8h0ZaC++tHOxJcd54Bv/JX16TaoqrIX8Jm8ZPUVuOSzHXA1UE215R/bSHC3j8WnRaOAcCrEUFQfu6YVGZrOTZGYnHUOsNc7JTWnbkwuL5kVMwwUsfQVOF13g3RtgQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41385B38B83CC14EA7F859BE693DD822@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf96f3e6-aa27-430c-3406-08d6b43dfdb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:59:26.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4677
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
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index dcc7405aff9a..3e4169e738a5 100644
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


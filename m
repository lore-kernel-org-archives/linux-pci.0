Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA68C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72DC21738
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Pu4GGN3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCRJyi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:54:38 -0400
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:19523
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbfCRJyh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 05:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Isj1DBcl8+ro68MJQCtUVGEyy5WmT9Mr4dwWnY7EqcI=;
 b=Pu4GGN3PifjZZlUL6WTwci/fpCwnMfwTmaw3olgBpIoMdpHouG3kB055XCDAyJjYypwO5CekvxjxxvKJySEsp7mlD271cF27OC6OE31vgCHvdwtJMm203FjrNjw9fPk+AMkAubxOumVvLcje6IFO/ws0O1UpRqVdL2ZkaNms3lg=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3928.namprd03.prod.outlook.com (20.177.124.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 09:54:35 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 09:54:35 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/5] PCI: dwc: Free the page for MSI IRQ in
 dw_pcie_free_msi()
Thread-Topic: [PATCH v3 2/5] PCI: dwc: Free the page for MSI IRQ in
 dw_pcie_free_msi()
Thread-Index: AQHU3XCXLFkjRFjYXE6Zgkga34dsXA==
Date:   Mon, 18 Mar 2019 09:54:35 +0000
Message-ID: <20190318174711.4b7e556a@xhacker.debian>
References: <20190318174415.74fd25a5@xhacker.debian>
In-Reply-To: <20190318174415.74fd25a5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR06CA0036.apcprd06.prod.outlook.com
 (2603:1096:404:2e::24) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eac676f7-6dba-449d-6b63-08d6ab87ba01
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3928;
x-ms-traffictypediagnostic: BYAPR03MB3928:
x-microsoft-antispam-prvs: <BYAPR03MB3928BA455DF1998C565FB686ED470@BYAPR03MB3928.namprd03.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(476003)(11346002)(97736004)(6436002)(3846002)(6116002)(6486002)(71200400001)(71190400001)(256004)(486006)(446003)(26005)(8676002)(5660300002)(68736007)(7736002)(86362001)(102836004)(4326008)(316002)(110136005)(2906002)(99286004)(54906003)(105586002)(25786009)(6506007)(386003)(52116002)(76176011)(81166006)(81156014)(186003)(106356001)(14454004)(53936002)(6512007)(9686003)(50226002)(72206003)(66066001)(8936002)(478600001)(1076003)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3928;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ig23TILqcWMGEjo2l+xtqMLrwtl3hjqUhZfZfalMcGzf2DRjcAWkAacQHZ8V+xc3x0lUoXPYnZbk8AA5J5IIisl1CbXQfZNRKX9m3ore3lxvv7VmrQCwdcMAbrDXyt42rsRL+zRnMeLNiWzJosubJDbV0jvXdjZJ7adlGoi8LZkbloBkvoI/h/Mc7S8qU0KQSonSS7li3dmlNRXHd5TrHVQpCsRYr947WZ1xlZYsavwnsNISn6jRUB9DxefsYLuOM3Qn40qlFrRR2Ub+/u/Corpfqi+QvIeMuQiDkjuWmuNe/6ALsHhqOT8wZUNd6lkKk65rJ1OszJofWrT+qQY45yK4oZWy7nCSbvl3uP94/WseNaSJ1m+Sxhdncx+JuzbppTYeLX6SI2lspUJrHn+aWku6KTbzNOUX7u/wM6ovDDU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81A4B6EE3748A14588AFA809EC746986@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac676f7-6dba-449d-6b63-08d6ab87ba01
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 09:54:35.0714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3928
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To avoid memory leak, we need to free the page for MSI in
dw_pcie_free_msi().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++++----
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 1040939f45b4..a71b874ae3c0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -305,20 +305,24 @@ void dw_pcie_free_msi(struct pcie_port *pp)
=20
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
+
+	if (pp->msi_page)
+		__free_page(pp->msi_page);
 }
=20
 void dw_pcie_msi_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
 	struct device *dev =3D pci->dev;
-	struct page *page;
 	u64 msi_target;
=20
-	page =3D alloc_page(GFP_KERNEL);
-	pp->msi_data =3D dma_map_page(dev, page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
+	pp->msi_page =3D alloc_page(GFP_KERNEL);
+	pp->msi_data =3D dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
+				    DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, pp->msi_data)) {
 		dev_err(dev, "Failed to map MSI data\n");
-		__free_page(page);
+		__free_page(pp->msi_page);
+		pp->msi_page =3D NULL;
 		return;
 	}
 	msi_target =3D (u64)pp->msi_data;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index 377f4c0b52da..6fb0a1879932 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -179,6 +179,7 @@ struct pcie_port {
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
+	struct page		*msi_page;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
 	raw_spinlock_t		lock;
--=20
2.20.1


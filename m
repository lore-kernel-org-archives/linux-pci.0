Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0F8C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831152075E
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="lBsKfENC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfC2L5U (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:57:20 -0400
Received: from mail-eopbgr790079.outbound.protection.outlook.com ([40.107.79.79]:5884
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729469AbfC2L5U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 07:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvDpzMGyizyHrjiB0dVAXTb1Ho3YNcs21pjZeXB9wjk=;
 b=lBsKfENCCVCTL2BIua7YOQQS/ax79sNf4m7D9Hl65okWDgza61cTyBKzGHiFdcmxEBBH74BAglUogwD184atBJZUlkyjDgaU8bd0gh/mA66DNB1EkKm/6z3cf4Ap80mxR7zg6UgNOhNnm+D+tajluAaVYSvADZlSCayS23ocN2I=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4677.namprd03.prod.outlook.com (20.179.91.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 11:57:17 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 11:57:17 +0000
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
Subject: [PATCH v4 2/5] PCI: dwc: Free the page for MSI IRQ in
 dw_pcie_free_msi()
Thread-Topic: [PATCH v4 2/5] PCI: dwc: Free the page for MSI IRQ in
 dw_pcie_free_msi()
Thread-Index: AQHU5iaOgs5m4jcCLEKOwYgOAI2HSQ==
Date:   Fri, 29 Mar 2019 11:57:17 +0000
Message-ID: <20190329194934.6be48292@xhacker.debian>
References: <20190329194750.265f6df6@xhacker.debian>
In-Reply-To: <20190329194750.265f6df6@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::20) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d414ebf8-a007-4070-f133-08d6b43db0c4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4677;
x-ms-traffictypediagnostic: BYAPR03MB4677:
x-microsoft-antispam-prvs: <BYAPR03MB467730024D65E12F378355E4ED5A0@BYAPR03MB4677.namprd03.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(110136005)(53936002)(54906003)(478600001)(97736004)(106356001)(446003)(316002)(105586002)(86362001)(102836004)(7736002)(476003)(9686003)(66066001)(305945005)(11346002)(256004)(71200400001)(3846002)(72206003)(71190400001)(8676002)(50226002)(6116002)(4326008)(25786009)(8936002)(2906002)(6512007)(14454004)(486006)(6436002)(1076003)(81166006)(81156014)(186003)(68736007)(52116002)(26005)(76176011)(99286004)(5660300002)(6506007)(6486002)(386003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4677;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qL8/S+G7thLsFOHYWaWKJyCC+SE7awYRREe3BJSDxYzCJLvIvrHVVrLNqe4G1Uoe9nuX5ttDaYvvoqBTww7R4aatkoUNSKb1kAWoKRJ2zdS9y0ltRX77BE2bfm1NDrNlLuRmwBRrE4c3V4CQeFGDcTERNp/cimh00WGhS8K4wMWjl9Sc/x/Q+g7bEkCWuPRqd9NAfMJnvscDCIX2wFB3UkiZLHyke4FGzFUnt2rPH3SmSpZ+PWHrg9GW2M31vMCqnBTigtVmVH2/7PKvY76YoIyMg5QsmZP1PFHHHMaSwU7XonHkBAP8qdXKayID74l8RylON4Jteyzlt7u2rkocdxa4cSxGPR+oCSFCd+CbSHePwVKq7ieIQ6HA5AkYVfjk5Z3mn2pmeohVul/5GKWP/GvbFkrJUHZ6NWA4slnkwRM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D3C0C9B4EF25A44AD8A1CEF9428E6DF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d414ebf8-a007-4070-f133-08d6b43db0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:57:17.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4677
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To avoid memory leak, we need to free the page for MSI in
dw_pcie_free_msi().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
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


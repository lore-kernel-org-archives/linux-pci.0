Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB630C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982C12183E
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="h6XmSVxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfC2L43 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:56:29 -0400
Received: from mail-eopbgr790085.outbound.protection.outlook.com ([40.107.79.85]:64880
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728800AbfC2L43 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 07:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlDmh5ePIbNZPBL+IgT3EwX/R9HbEjvFeuVZYROQgJE=;
 b=h6XmSVxszykdBJ+JfmfukYwBZ24lsH5FeR8ugpop7r3XzvtUSkJLJxlFiACf8SzFuzBDjkQ0K49vKp6D8HfEf0D9v2LdiZNxzZCMysTc2byoXv1Rj0nIt32+Fq6FobgbBGwCfm7TDjbI4dcLRFL14yx5zn7Ra8W6dVWm0rsiFIc=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4677.namprd03.prod.outlook.com (20.179.91.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 11:56:25 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 11:56:25 +0000
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
Subject: [PATCH v4 1/5] PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is invalid
Thread-Topic: [PATCH v4 1/5] PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is
 invalid
Thread-Index: AQHU5iZvopL5sPWtxEGid/mM16nAoQ==
Date:   Fri, 29 Mar 2019 11:56:25 +0000
Message-ID: <20190329194844.5c2cde53@xhacker.debian>
References: <20190329194750.265f6df6@xhacker.debian>
In-Reply-To: <20190329194750.265f6df6@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR06CA0041.apcprd06.prod.outlook.com
 (2603:1096:404:2e::29) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6de72837-0dc9-414c-577c-08d6b43d9181
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4677;
x-ms-traffictypediagnostic: BYAPR03MB4677:
x-microsoft-antispam-prvs: <BYAPR03MB46773ED7D30ACE663F6FFB54ED5A0@BYAPR03MB4677.namprd03.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(2906002)(6512007)(8676002)(71190400001)(50226002)(6116002)(71200400001)(3846002)(72206003)(25786009)(8936002)(4326008)(14454004)(26005)(52116002)(68736007)(186003)(6486002)(5660300002)(6506007)(386003)(99286004)(76176011)(4744005)(486006)(6436002)(1076003)(81166006)(81156014)(86362001)(105586002)(7736002)(102836004)(316002)(97736004)(54906003)(478600001)(53936002)(110136005)(446003)(106356001)(256004)(11346002)(305945005)(9686003)(66066001)(476003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4677;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OZTam+kA8UStMH8kLvPdz3/6/QxYEULWQv0Rj1z04h/KD6XcGiT2JjjN+byw+WOrlo89RhpHQAP1lpEfF/cI2xqxgvaQcOdByTO7VqXxHpINOkpEET5Gck3QiFE2GUy46bovIAuT3QOAr2vWnbDtepLKWNCVHqWdpM2dTOz1Iz9HUJgwYZSBFk6I0XnyQam60eDRTsZxkoS6Za7eC0R7ooCI1YbwlghR+QdESE6Dk4tYDVyuro6BwLt1UQAboIRa6FfnWReyreqjZp8ZwRcNKGVzM/5F50/Icym5sGVzYT8qUlH+GQ8wM6loBJ3APBhUx+ZfYMDmmmySeG5w2SVP3SyDx017R00oA98Cj+ql+uukP6r/VCqN3omdo+jSVcm9Gv+D6R6GKvxHFK/w7O+zkQp+2pdc6Xg+smVgDEIKW4w=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64DB777E6D204746B4BB504FAE94DB0A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de72837-0dc9-414c-577c-08d6b43d9181
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:56:25.0404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4677
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We should check msi_irq before calling irq_set_chained_handler() and
irq_set_handler_data().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 25087d3c9a82..1040939f45b4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -298,8 +298,10 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
=20
 void dw_pcie_free_msi(struct pcie_port *pp)
 {
-	irq_set_chained_handler(pp->msi_irq, NULL);
-	irq_set_handler_data(pp->msi_irq, NULL);
+	if (pp->msi_irq) {
+		irq_set_chained_handler(pp->msi_irq, NULL);
+		irq_set_handler_data(pp->msi_irq, NULL);
+	}
=20
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
--=20
2.20.1


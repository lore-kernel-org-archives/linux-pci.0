Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F0AC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6AF2083D
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="jdWfvxfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCRJyB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:54:01 -0400
Received: from mail-eopbgr730075.outbound.protection.outlook.com ([40.107.73.75]:17376
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727169AbfCRJyA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 05:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlDmh5ePIbNZPBL+IgT3EwX/R9HbEjvFeuVZYROQgJE=;
 b=jdWfvxfxwWGgWZVZYG1dQTRImFg2AgmMMNwF6CukXbLm79s+tc+OleVDSyIrFiMwCFaWvCTwu67QM1jZF10hnuF4u6ymRFErzHWCWuofKEPKZ7x1K5OdoyIMccdTTzw8vdKwTf5BQjo5uYyKaXsWK0nBYFuU0koSnKEKSoInyK4=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3928.namprd03.prod.outlook.com (20.177.124.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 09:53:58 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 09:53:58 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/5] PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is invalid
Thread-Topic: [PATCH v3 1/5] PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is
 invalid
Thread-Index: AQHU3XCBU3uwzE9WGUSd1tZpXYixvQ==
Date:   Mon, 18 Mar 2019 09:53:58 +0000
Message-ID: <20190318174633.0c274139@xhacker.debian>
References: <20190318174415.74fd25a5@xhacker.debian>
In-Reply-To: <20190318174415.74fd25a5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:404:ce::21) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 229742a1-4efe-48ea-3b04-08d6ab87a404
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3928;
x-ms-traffictypediagnostic: BYAPR03MB3928:
x-microsoft-antispam-prvs: <BYAPR03MB39288A2B74BD3056722EE7FDED470@BYAPR03MB3928.namprd03.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(476003)(11346002)(97736004)(6436002)(3846002)(6116002)(6486002)(71200400001)(71190400001)(256004)(486006)(446003)(26005)(8676002)(5660300002)(68736007)(7736002)(86362001)(102836004)(4326008)(316002)(110136005)(2906002)(99286004)(54906003)(105586002)(25786009)(6506007)(386003)(52116002)(76176011)(81166006)(81156014)(186003)(106356001)(14454004)(53936002)(6512007)(9686003)(50226002)(72206003)(66066001)(8936002)(478600001)(4744005)(1076003)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3928;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ccpHDM39++MylEVwt8a6f0aKg00R4KN4/syV5OD+UUPHsDqk41z4J29BWvCqKTHoIiUh8LH5L+Q8uC+d+WB5EEz/Ok4/FFpPWSi/h5H+rh1hGwpQ3le9Mgf/IXW/qOxrAyXe/zQgb+ogEJbaH6xBiTOtkpvaI1GxphgxLqxlCSKSdy4Vi8teH+y48ysEZF9ZsAl56s8MPg3tgVxpMJx1KW6X5d5ZE7Mcs8uE1NYfis0Q0GaXcP94l+gxc2iGEzgpa4qqdOZgzCz5SCnZzcf2Ernr2KI83f/tWrXwHircz3kvV6zeSjZDBiBcCXcgNs0EreVw6UbIW+Gurhn8ZMvI7gr+QRDq4Fl8FK8EA6cPoOGFpS1APfOS6BtPGEuDKToEbWhRG+dMWTa10vL0XlpPJBTRJ7lFwhSCS3y5TsLfQEw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53329CAEE770B34EBA1A7B7036C3A00F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229742a1-4efe-48ea-3b04-08d6ab87a404
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 09:53:58.2851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3928
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


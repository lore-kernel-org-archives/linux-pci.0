Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA877C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8D121848
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="sxlw/3p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfBZL4U (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:56:20 -0500
Received: from mail-eopbgr750074.outbound.protection.outlook.com ([40.107.75.74]:48746
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfBZL4T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 06:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M48mEhrYZsVYb+OMxFVes8aHZ7bPq2vlD5rD5ZjYUUQ=;
 b=sxlw/3p0FasnpSOlxxGYsHc8vSGTnXNjpsQ+9mdlN6fLbnM2oFodxigBhboCwDBHPGF1jW7MrCU0KwaQplvVo0RmuDl3wu8rOY51SMtTCKcbAHsaBF0Rqnf+KiT17nTgCE9JEMWNxrtXNDcCmX/lNATNsaAPDKmpcPV3yThNeB8=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4423.namprd03.prod.outlook.com (20.178.49.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 26 Feb 2019 11:56:15 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:56:15 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/5] PCI: dwc: fix dw_pcie_free_msi() if msi_irq is invalid
Thread-Topic: [PATCH 1/5] PCI: dwc: fix dw_pcie_free_msi() if msi_irq is
 invalid
Thread-Index: AQHUzcpGhI7fWXBN+EyRjGP8KV1eAw==
Date:   Tue, 26 Feb 2019 11:56:15 +0000
Message-ID: <20190226194909.0e0c4758@xhacker.debian>
References: <20190226194806.34fc23b5@xhacker.debian>
In-Reply-To: <20190226194806.34fc23b5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYAPR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::17) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de77967d-e309-401f-cd2a-08d69be168f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4423;
x-ms-traffictypediagnostic: BYAPR03MB4423:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB4423;23:Eb0Rxyb7tnesu+P6rXlOCLbepki1T2I+SrXun5MOL?=
 =?us-ascii?Q?uTC3LRUPMQPdyXI5fCzBr0JDvQkbW7+o731wmxcoLkRlrzJJpUBzblLsWZGi?=
 =?us-ascii?Q?ttJEBIIICpHkEeNqFhCwsZEvPoCbKYMqa/+SSXzFCCNAC/Do/5aPXuDNOU9h?=
 =?us-ascii?Q?BLCCREnLHNAZ/uaipS3n6Db416QbtMX59uEBEbvu7WmqOfWBs/og74iNzxOv?=
 =?us-ascii?Q?ISimNN1rD8gLiTer2SxJoCR0b6FGnLvEzgCvmVWEHd+QgG63+0X6HBuN7mLa?=
 =?us-ascii?Q?ELGAEefdVvFiU1cfqfYbrZvdSBX8OCBTXbOqWZLyuScBOIguf3lLYiWY1jvv?=
 =?us-ascii?Q?xO9japbSpMGHHoo3/nsN9oyxNEI1kZo8TxKl9bR+5Kx5XDAl5TDeoxSx0ga3?=
 =?us-ascii?Q?mkBA47FsmbmWCgT9F+VUiVEdUYSY21ywevX6nkOFfFZPbFHBVqNzVVEJdWcy?=
 =?us-ascii?Q?ygVZRv7QY/nmzLpgsoL/RXurLNBfkh68N/M7x5hI+XqLyFmK4P4GL063fpMB?=
 =?us-ascii?Q?Vc1Vvds4NfbUK/lkTOCLr7n2qDmRKsnBpXnYNLqK7WGYmy5cnfp0WvCfzDsK?=
 =?us-ascii?Q?yV5mBcHW0mbocsy2r/7WPRogasjT1t8NgPjdJhEBvShJ87GXcLWFRY2+9LJe?=
 =?us-ascii?Q?sR8b2oDxVg6xaleimXpSmRHmoefpGkq+UXKPibPuy1nqJd6Y3bT8JPKxQyoo?=
 =?us-ascii?Q?rMjcz8T/dWrGW6KeCti8j8TflHFOXMGFqpg3shg0QyHay0kes0Op7JTaII+C?=
 =?us-ascii?Q?yIfpUfgYd8riXELfIHbRNhsLISZqrX34qWZ5wWu01xsX83m9HIy1bOV/WG9z?=
 =?us-ascii?Q?2gQxitpKTa8D3LSZFPmzA1H4zQzzW8Nyu9wHquUHjdunSFNmmFgADp11CwQf?=
 =?us-ascii?Q?4nfyWdzUZl2OjTa9Zt1uboZQK3VH5adCALNcEcmpn2lTaJ5PCqrH/1r0sR2/?=
 =?us-ascii?Q?1K6JhXje5YA7pxfi+oKuo/68OeNFswJOZ74MO1FrNBt82IWXjWx+Eeg5qZE1?=
 =?us-ascii?Q?FnDyY8kDFccUrKHGvxpiMF495wFwOI37kohqgHP/16lEzXjq713xhsLo3YLX?=
 =?us-ascii?Q?r2X7HcpIc7pQ4GXGIgGHoN31AZa+as3V8rLnPpzzOC7bvYz3Cg4noBRuOCOJ?=
 =?us-ascii?Q?XdTSUmdJor9gyTyyc0Hed+XsAvv0uIF3htA3sGlh7lunmJ+239pnMhrnJP42?=
 =?us-ascii?Q?Kjo/F3EkVLLuHq1k9fiTmDZqHMuMbLswBWfHZ/SdiY2EFqmIuva2mdjGC7Bz?=
 =?us-ascii?Q?LUFqAlGH5+BhYpYZ94=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB44235B15D981A483783BC2C7ED7B0@BYAPR03MB4423.namprd03.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(81166006)(106356001)(50226002)(6506007)(81156014)(6116002)(386003)(102836004)(305945005)(26005)(7736002)(97736004)(99286004)(3846002)(8676002)(76176011)(52116002)(68736007)(478600001)(2906002)(8936002)(72206003)(105586002)(110136005)(25786009)(316002)(66066001)(9686003)(6436002)(86362001)(486006)(2201001)(6512007)(2501003)(5660300002)(476003)(53936002)(256004)(6486002)(14454004)(186003)(4744005)(1076003)(71200400001)(71190400001)(11346002)(446003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4423;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g4206jVa/1oP3Eo8XBPkfW4pHPH2T2A2dPuq2UiCjK5wjBurZ0NEtmxvFKh6EjBF+T13ZA06ZDcAxuhykMw1cczFwpGjcV7Tubhs0Oo2oMjZq0ElJ+KqAmL7YTioVNOdwhBJ38zUjYnjMcnLQ6p2T6hbiskI9bYDf4msmqDZaQVfq2ZpohJzbd/96tOxBKcrmwR9BoPVz9+EbSL01LnUuNu/l5GKhhz34tSBz/XJwImMuLfNRy+YFTTMMJJRhuTAJLJdWYvY6t0Dpml+VIOuOxhHrl2M9yHuSNBHxftlKD1sttXFHuQTMbnVojeiaBXFd8NrsijLhKy5Xy5cSjkkxlsTAh6kIWL/vayAkWPs3BWK4tfkFZbTt4rqW+8rGw6G0bG7iN9gwHkB/r+fqDjMEeW8BP6QWsDiSG95fIh4qzQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F80E6339A3181349AE350F5D27DAE035@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de77967d-e309-401f-cd2a-08d69be168f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:56:12.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4423
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

we should check msi_irq before calling irq_set_chained_handler() and
irq_set_handler_data().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 0c18ab63811f..a94d3530b694 100644
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


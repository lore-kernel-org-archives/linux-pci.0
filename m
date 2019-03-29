Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD635C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836852183E
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 11:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ENoHtJRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfC2Lzm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:55:42 -0400
Received: from mail-eopbgr720048.outbound.protection.outlook.com ([40.107.72.48]:53387
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728800AbfC2Lzl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 07:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mculs6FQWyHu+mW8AEcLLHrkAvpleisOaFHuwIjCrWo=;
 b=ENoHtJRS+WIjdYClyXmd25Br7TEnphCKkijgBTCyTfSBUkefngJatwsXCSRqgjX2181H8UZIj+Yr/x5ANXKUz2jslNWzhwHF6s/GutokC9uEa1LfIIfmXSGMna5fo2K5zQoUl2opd0HvHz6TAcJNwjQYuHLybcjIbtETSjrZQy0=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4616.namprd03.prod.outlook.com (20.179.90.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Fri, 29 Mar 2019 11:55:36 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 11:55:36 +0000
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
Subject: [PATCH v4 0/5] PCI: dwc: Support remove
Thread-Topic: [PATCH v4 0/5] PCI: dwc: Support remove
Thread-Index: AQHU5iZSipgXo/rRD0+KpsQPsTkaXg==
Date:   Fri, 29 Mar 2019 11:55:36 +0000
Message-ID: <20190329194750.265f6df6@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:405:4::16) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a262b79c-8202-46b8-51d4-08d6b43d7439
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4616;
x-ms-traffictypediagnostic: BYAPR03MB4616:
x-microsoft-antispam-prvs: <BYAPR03MB4616B124083833F098D68782ED5A0@BYAPR03MB4616.namprd03.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39850400004)(346002)(136003)(376002)(189003)(199004)(105586002)(6506007)(386003)(102836004)(8936002)(486006)(3846002)(52116002)(305945005)(478600001)(6116002)(50226002)(86362001)(4744005)(5660300002)(8676002)(110136005)(316002)(81166006)(6436002)(68736007)(81156014)(1076003)(26005)(14454004)(186003)(6486002)(72206003)(256004)(106356001)(54906003)(99286004)(9686003)(53936002)(2906002)(4326008)(476003)(25786009)(6512007)(66066001)(97736004)(71190400001)(71200400001)(7736002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4616;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CTLCkCScddFYOT5V49o9txc2VWm/iI8uVNlyemc9XSPejF6I9qUcbPcVmoiuyhy2sgB5jg9jqPGK8XsBLMNneds1m88KfHgnzKkCy5u6DYIw1jYXsrYOqn/QswB4LP5pqJt2BXBOnXqH5AVjnUjGHFUo5zYRR0hvxzxHs7mYfmVowgTyJMoNd7WgoNxKq3Nop7gSpARBjqOy3by/aWckhIVFn65DKbHBwx0TR4Q3ZQseV9gkkzqGMAg2gGirtIZcUU0aierJhnLxPeZdTnOlr5Ed+mejnVbrFXKWZb3SsfaDM6UJ4Lgviv+liR6fkluST0ye16ZFn/V5RnGY1jj9yOPFq9v6CIj0in3+jrXD8L/CQffpmnnyjNSOtlZlBT87hFZlS0Ot5j15wFYKfVFgeBuMbyJTPaXKIZjvKFRmt8k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <458082B79BCE304CA8FAC8FE862348E7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a262b79c-8202-46b8-51d4-08d6b43d7439
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:55:36.1336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4616
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the PCI dwc host users don't support the remove, but nothing
prevent us from supporting it. To achieve this goal, we need to ensure
we can do necessary clean up work.

Changes since v3:
  - add Gustavo's ACK to patch2, patch5
  - remove IS_ENABLED(CONFIG_PCI_MSI) check

Changes since v2:
  - address all Gustavo's comments
  - add Gustavo's ACK to patch1, patch3, patch4

Changes since v1:
  - address Bjorn's comments, I.E Capitalize, s/irq/IRQ/, s/msi/MSI/


Jisheng Zhang (5):
  PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is invalid
  PCI: dwc: Free the page for MSI IRQ in dw_pcie_free_msi()
  PCI: dwc: Free MSI in the error code path of dw_pcie_host_init()
  PCI: dwc: Use devm_pci_alloc_host_bridge() to simplify the code
  PCI: dwc: Save root bus for driver remove

 .../pci/controller/dwc/pcie-designware-host.c | 60 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +
 2 files changed, 34 insertions(+), 28 deletions(-)

--=20
2.20.1


Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843CDC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510992083D
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="j7DmoFmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCRJxT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:53:19 -0400
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:30368
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbfCRJxT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 05:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgXW6R6ZYto+zjrZzvVxw87aXRyQvwcGFg09aq9EKkQ=;
 b=j7DmoFmRhoqK5+25s/CWWuct5/jt5sc2JxAPmRnDOEliMemmxUl5maB/BHefc+iABi6Uuama09/AWuLTBNnMVV/iTJEtQ1nNsfXCXZFO2oLKdKh9OIgmx9C1+D6vmAWe3SLyL+SvGYUk1jD1VE0tan7LLE8isJT72yXnKwrzIR8=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3928.namprd03.prod.outlook.com (20.177.124.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 09:53:10 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 09:53:10 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/5] PCI: dwc: Support remove
Thread-Topic: [PATCH v3 0/5] PCI: dwc: Support remove
Thread-Index: AQHU3XBkYEd/0BSihUOeRk7wuVv8zA==
Date:   Mon, 18 Mar 2019 09:53:09 +0000
Message-ID: <20190318174415.74fd25a5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR01CA0057.jpnprd01.prod.outlook.com
 (2603:1096:404:10a::21) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b4c5f87-78af-468f-aeff-08d6ab878732
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3928;
x-ms-traffictypediagnostic: BYAPR03MB3928:
x-microsoft-antispam-prvs: <BYAPR03MB39280900C1D4DD16A42AB4D8ED470@BYAPR03MB3928.namprd03.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(476003)(97736004)(6436002)(3846002)(6116002)(6486002)(71200400001)(71190400001)(256004)(486006)(26005)(8676002)(5660300002)(68736007)(7736002)(86362001)(102836004)(4326008)(316002)(110136005)(2906002)(99286004)(54906003)(105586002)(25786009)(6506007)(386003)(52116002)(81166006)(81156014)(186003)(106356001)(14454004)(53936002)(6512007)(9686003)(50226002)(72206003)(66066001)(8936002)(478600001)(4744005)(1076003)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3928;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZxduKIL7/i+JQYdisj9XXGjLpcM+de+g3pVQ0Ai/+B62iPCoShLgdOn06FI5bxRbDkz1GnRgsREQmuWCVPrW0e9d8kDbszVpSVbzDom8QK1k8JdR9Sic4BDSldxnxbNxcfAtcIY3fujpzrQkZOsF8fDWZdDPUmc70LDzY3D0gG7tb5bBnDSQb0aats75oE2gJBq0HBgGi5MRrrzfV+1vrVEmIbhNCmTd+thRtfSDfcoq9+RwwyYVk2/yIxclq4eWLVx4w2YuUDIHRmiCetdcvmHoelUXAzjkimLCZjgiq+As6yBWpBphmHTCd/Tcg+WgfZ19I8l0BrmKQQgHONDA8Sv1kJfpOy/gQignxOyZgU72Vym/h0AW0q06px52Xgi1mxZ/QN23LqBRPnbTxkHSs54OsKh9+loYutma0HeFGrE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9CB828CC152A354AA7DCD91EE7F43EF6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4c5f87-78af-468f-aeff-08d6ab878732
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 09:53:09.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3928
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the PCI dwc host users don't support the remove, but nothing
prevent us from supporting it. To achieve this goal, we need to ensure
we can do necessary clean up work.

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

 .../pci/controller/dwc/pcie-designware-host.c | 59 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +
 2 files changed, 34 insertions(+), 27 deletions(-)

--=20
2.20.1


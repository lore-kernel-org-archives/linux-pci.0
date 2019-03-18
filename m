Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA9C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7A22075C
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="MUTIQzTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCRJ4X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:56:23 -0400
Received: from mail-eopbgr730047.outbound.protection.outlook.com ([40.107.73.47]:28928
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbfCRJ4W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 05:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhvE0+1qXeAFOcQksGpZl2UoMr49mpT1gKdIfBx/6N4=;
 b=MUTIQzTX6IigVX9EyPk489TGr6ts9OoXdxSEYhx+4ckEmc9OLtIWDkQUQF0rNNE//gyF91mTCcH7Df/HhHEcq35+kvALNy6rw/PB3GM2uTrB5StOhgAzEUUYf7Ito+2LQRVkXXwcw4P9ljUMiidTi3bGHt3zkOqSyg6Y3P4tA6Y=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3928.namprd03.prod.outlook.com (20.177.124.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 09:56:05 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 09:56:05 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 3/5] PCI: dwc: Free MSI in the error code path of
 dw_pcie_host_init()
Thread-Topic: [PATCH v3 3/5] PCI: dwc: Free MSI in the error code path of
 dw_pcie_host_init()
Thread-Index: AQHU3XDNPtxLI80dvkeT0+gZl/Yu8A==
Date:   Mon, 18 Mar 2019 09:56:05 +0000
Message-ID: <20190318174841.522fb6fd@xhacker.debian>
References: <20190318174415.74fd25a5@xhacker.debian>
In-Reply-To: <20190318174415.74fd25a5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYAPR01CA0211.jpnprd01.prod.outlook.com
 (2603:1096:404:29::31) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f371ff8-3ea1-4e7a-fdc3-08d6ab87efd7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3928;
x-ms-traffictypediagnostic: BYAPR03MB3928:
x-microsoft-antispam-prvs: <BYAPR03MB3928AF60792DB63973D12AE5ED470@BYAPR03MB3928.namprd03.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(476003)(11346002)(97736004)(6436002)(3846002)(6116002)(6486002)(71200400001)(71190400001)(256004)(486006)(446003)(26005)(8676002)(5660300002)(68736007)(7736002)(86362001)(102836004)(4326008)(316002)(110136005)(2906002)(99286004)(54906003)(105586002)(25786009)(6506007)(386003)(52116002)(76176011)(81166006)(81156014)(186003)(106356001)(14454004)(53936002)(6512007)(9686003)(50226002)(72206003)(66066001)(8936002)(478600001)(1076003)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3928;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SKykdF2ZdTcVp+fZ2kSFJgpjY+kIfFD8QWg6vu5hduKcwZ6Pf2MYAClJaTDMpbR25NPm8gvkYMA/HdEzhLVDkQz20QCih5H9kJAiYub2IPfJgfjYO4UGIQHbmaGu/BqIUoZDt/P7V7FYOYsAwmIn4iuAW/01vPb6kXbhJv6HgCVIj4aG3UWU5BTqpaSSnoqyR/7q4Nt1mQVk4MHEAvfHk67DZLoxcyPiRXztTwf4XeWsuFd/KaWvnOtx0zgl0xeZxHGkJUdgL/KZK+4SO/fPLvatb9Q/nj/HBPyK2Uwi3G5kkMYiDSMGbHJxJvOXoQAEzOLpCmIpoicdCe5YjlNUosVkCvujOwx5j15mqNkXQ2N+xML8/olw7ZtiCoq560HTl1lk5tf7OLM9jszyJOSv6i9sYFm1YHUHD6w7QD4Q8Q0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29FD94CCD3AE3D40893E8C601FCF84CA@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f371ff8-3ea1-4e7a-fdc3-08d6ab87efd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 09:56:05.4850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3928
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If we ever did some msi related initializations, we need to call
dw_pcie_free_msi() in the error code path.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index a71b874ae3c0..585080699675 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
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
@@ -513,6 +513,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pci_bus_add_devices(bus);
 	return 0;
=20
+err_free_msi:
+	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled() &&
+			!pp->ops->msi_host_init)
+		dw_pcie_free_msi(pp);
 error:
 	pci_free_host_bridge(bridge);
 	return ret;
--=20
2.20.1


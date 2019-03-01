Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF504C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B589420842
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="do+JHVPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfCAFFY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:05:24 -0500
Received: from mail-eopbgr790041.outbound.protection.outlook.com ([40.107.79.41]:37686
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfCAFFX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 00:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJrOO+e+wRNyb6fWknZF9YnjlA9kz18HJH8vJFqfQVI=;
 b=do+JHVPxgugmat615Pj/NsozsHZGCIGBjUq7GpG3OvscFA1FZM33cpV9MscEseRnT9oiqaDVVtMChvDD5hPQr/NzLMY2iQwRkuTvj3tNOnLB/GyI53gEIlzPOQ3i+64WHwUrfffW18fmhA9omkQgJlCyMEWgkbZy7ijbMNc6cNs=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3510.namprd03.prod.outlook.com (52.135.213.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Fri, 1 Mar 2019 05:05:21 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 05:05:21 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 3/5] PCI: dwc: Free MSI in the error code path of
 dw_pcie_host_init()
Thread-Topic: [PATCH v2 3/5] PCI: dwc: Free MSI in the error code path of
 dw_pcie_host_init()
Thread-Index: AQHUz+xey3xJKe30LkiEAqIClgwSXQ==
Date:   Fri, 1 Mar 2019 05:05:20 +0000
Message-ID: <20190301125818.1b0d7e08@xhacker.debian>
References: <20190301125510.4e2ee985@xhacker.debian>
In-Reply-To: <20190301125510.4e2ee985@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:404:56::26) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74d5ada2-0f29-40f7-fe43-08d69e0380f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3510;
x-ms-traffictypediagnostic: BYAPR03MB3510:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB3510;23:9Dyg8rNs6gHVJNy9htt6unZPe8lqJZRxu5+iL0X16?=
 =?us-ascii?Q?k41rmDo8iVwerxf/HV4jhZtEENdLxrNVSbdNEzRmI1NmaKjEimNuPV8NaPVs?=
 =?us-ascii?Q?GX/fa9L1FODxE/2Qgz9Yt4EmW8+EWKDg8y5Uxnhy2gVZNXHG9xJAkI8ugSMh?=
 =?us-ascii?Q?QjqgWdfBt0FWubanZa/SoDIxJf5+qL1Dp19UGCyNHQFAt7lB0zsBjVYA2XxF?=
 =?us-ascii?Q?ImscuT5tJs13M3Qk2h+QTOTPgkW8sVhXRX8VVcqGo9SAUZBn+XPkkWEvbAog?=
 =?us-ascii?Q?zxC1480fk+8U7QRjeqVoi2Gy8MM1GBhBsLWJULXmXejf5AJC7RC+jqrg67Kb?=
 =?us-ascii?Q?eN5Bi6N84eCFIhyjX8UE68kH0GhESNRzVLsXHNl8b8SeIRRSZnv/CR+AoAd5?=
 =?us-ascii?Q?OHz6uMSQZUJu+MmQYtfuUqv5XgGmJ+/HiNb0gTRHjphoLkMaqqy/SFa5OhUU?=
 =?us-ascii?Q?TsdEFwbioaBDVl9+6IcMpImJwyqklvf1MC0vjg8Tj73QKPj0H8wEPvXFyGAn?=
 =?us-ascii?Q?twkPvs1wj59lWqygQDoUhqqAq9lbkcYMPkISMC+N9gMQFtn848BBldjtz8mW?=
 =?us-ascii?Q?cTy21WqTgtQeu9DF09NBDU9COV7V1RARglrjeHWdusuv3y6N1iScEW/7c5Cu?=
 =?us-ascii?Q?mhFFXD3ysKgCPAesCZrAzA6HpfmcCIn+ZvAjxRh6qXpmUDsqCYmKPjrvsAEr?=
 =?us-ascii?Q?VkeBl79Ns0HWd32z4tTF7FwwlPyt9hKj1SkUyVi+Xstuf9LK2BFuy9+oP/WO?=
 =?us-ascii?Q?XjR8G7evlxwzjPgUDn8tf5WiGJFUm4/trKN0hSZOiYYDQTyhBFaeAY/FMozI?=
 =?us-ascii?Q?EzLljDIgdxHzse2iOj1+/9qX/JkXrUmF+iWEbG1T/vvU2wmCf7N9POd94NBZ?=
 =?us-ascii?Q?yXIlk6UKo9g8Yu9W01G1BkqIHAJyO7Vqi+1uAsbEjNvIWCuJ8Ny0JFLe65Pt?=
 =?us-ascii?Q?dYRnD4X8e6srOJVpyK071rziCGB52h+ciMJf0EcULegw6GVSaz5MLzq9sZDj?=
 =?us-ascii?Q?GaYdvU8o/F16T1d7cv+adWQqCE9MWVhnRaizxe4uiEDDaxfoQGD2B7soCicd?=
 =?us-ascii?Q?CXyZx7Z/QC2Ub61EqVVsONJeIOHa90GCsQ9pDXd418b6E5cV+ESTmnop85Kj?=
 =?us-ascii?Q?/WK9Q/5mzyrIOHJnLNMIekhbgJLYjXSPGJt8/vrtcVg2rsUMgEbqI93oZKX4?=
 =?us-ascii?Q?GTBwmcgu8RcW9icRNaGTV882JFj7f99att/BQv/6M0EnLQvlHtjKjK9Ew=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB3510463A71A3DD99C04843E1ED760@BYAPR03MB3510.namprd03.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(446003)(11346002)(316002)(476003)(106356001)(110136005)(8936002)(486006)(186003)(50226002)(105586002)(68736007)(1076003)(54906003)(5660300002)(97736004)(52116002)(72206003)(2906002)(9686003)(478600001)(71200400001)(53936002)(99286004)(6436002)(66066001)(71190400001)(6486002)(6512007)(305945005)(256004)(81156014)(102836004)(25786009)(4326008)(6506007)(386003)(26005)(8676002)(76176011)(81166006)(6116002)(7736002)(86362001)(14454004)(3846002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3510;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RflPe6R4yhXnjvwARQlybs+4aP0nHDzyDksmCp7yFBMD/J/fqvP8VGoeMu2Bgh+9V8rH4UVtSilaLUYNsNaZ/DfE14J7a/mfbwbWI4HWK0GK81YwtbPr14+JRwKbubw8Xfb4WIVM9Bh7vtQAhPZoG1Uxpw4hm7c6OBTUZbLQLr68cjr1TxfeijJxUJtkREdVKBx9Gb1qyN5LUaICYhlcTUXBENjoiwzl49V7PmL17EkNXWwfRQFQHjRwUAh67+QtfouUtNo6Iqq9TMxAKcYjwxsMIL4f3aaZwd0/E5KKRL7IsHGDS2SF0XNGGQorAdzZDZkf0unLwA2+4P2EsSyTZEU9LztYukas1vV0bpSmLNv2EgoXJg2CB8yBe3CHLKJmf0OmsSxsS3RBij0AR+Xyct5kgXRPB51zR69tXSol+sE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34CAC799F8F9A74BB70EC454E2DAFB71@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d5ada2-0f29-40f7-fe43-08d69e0380f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 05:05:20.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3510
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If we ever did some msi related initializations, we need to call
dw_pcie_free_msi() in the error code path.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index abe3ff5f0867..66569d0f3ab9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -482,7 +482,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->host_init) {
 		ret =3D pp->ops->host_init(pp);
 		if (ret)
-			goto error;
+			goto err_free_msi;
 	}
=20
 	pp->root_bus_nr =3D pp->busn->start;
@@ -496,7 +496,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
=20
 	ret =3D pci_scan_root_bus_bridge(bridge);
 	if (ret)
-		goto error;
+		goto err_free_msi;
=20
 	bus =3D bridge->bus;
=20
@@ -512,6 +512,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pci_bus_add_devices(bus);
 	return 0;
=20
+err_free_msi:
+	if (IS_ENABLED(CONFIG_PCI_MSI) && !pp->ops->msi_host_init)
+		dw_pcie_free_msi(pp);
 error:
 	pci_free_host_bridge(bridge);
 	return ret;
--=20
2.20.1


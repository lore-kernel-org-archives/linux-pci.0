Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29908C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22FD20842
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="qjZrbe7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725290AbfCAFGs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:06:48 -0500
Received: from mail-eopbgr700053.outbound.protection.outlook.com ([40.107.70.53]:42861
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbfCAFGr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 00:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDfJa/5peeKUsjb5cZhVZj4vd75dEAlF9WieijY3ECo=;
 b=qjZrbe7GQI+ulV5kBg66rqrMTSVEgV6KQCQB3n7BXT8tNE7VSMf5ZUoKVHfG0nmU140qH4IACwqE9QVvdbK2UovXYinnpTwCPT75UWii1l4+FloH0lXa1k21UlXmmXTJL04v1brtgDDlxnBEOb5BWli2AAzmM41tL7SGG0wvrsY=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4533.namprd03.prod.outlook.com (20.178.50.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 05:06:46 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 05:06:46 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 5/5] PCI: dwc: Save root bus for driver remove
Thread-Topic: [PATCH v2 5/5] PCI: dwc: Save root bus for driver remove
Thread-Index: AQHUz+yR42j7VtHHRUKR9O0ghfmT2Q==
Date:   Fri, 1 Mar 2019 05:06:45 +0000
Message-ID: <20190301125943.47adae82@xhacker.debian>
References: <20190301125510.4e2ee985@xhacker.debian>
In-Reply-To: <20190301125510.4e2ee985@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:404:a6::31) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60b36bb6-96a3-4d3e-4395-08d69e03b399
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4533;
x-ms-traffictypediagnostic: BYAPR03MB4533:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB4533;23:LqzZwPSNONsoLhj8Ydd5HsuLe/VYCapLCZrF0Fsa+?=
 =?us-ascii?Q?S9Yp5IgPasONFkS5w/1urfU+mK4Z0bxoJAmxKEsyLBOJv3e+ejPqBTga339b?=
 =?us-ascii?Q?kssiwMRmmhRZ8VSY3SLnonNCA7QGJJKsP38PCWdcJ90Rb0iS6i+4TsXhNqdO?=
 =?us-ascii?Q?QMuoUu7fu6NWXrc7919tnW3ME8pkJZV8NzRqrpGMLPAgFpvkPLF323XBcZTi?=
 =?us-ascii?Q?UshnHyL4b3bzLnE0l6UXjbVr9z5woSPZNfHDAuFHgXIDNQGQ4oDsNewBVGVX?=
 =?us-ascii?Q?9UZ5jRchfgKzp6vtIKPVNCb2sY6qtJea/dyRmK85HWxGFi+0VNC8ZiTtx+45?=
 =?us-ascii?Q?/OUBSaL3fOAYk0GTCAfdPBEWDIXCr0S7hTTKkcvfwDwyHEJxFMrsJZidVD2W?=
 =?us-ascii?Q?pZDMYxh3Y4buOWE5LlHuHqcD9+N7tHyZauOx+92QHas/y4TgFht1Pkr5lJQ+?=
 =?us-ascii?Q?pgAEhsvuUmXfkDYi1KxqSGkImahYjbM88g5lugg7Nn2gInT5E61CFQD16QlB?=
 =?us-ascii?Q?nLYyRNFbCzaEfVbcePvZ+Lx9lK0Ri0FPeP8S+Xa+K3msBpNMZ2ei8Zqac9qS?=
 =?us-ascii?Q?O6Z50geuw7qF1jjP9iqyTpgGaZox/E295tZ/AJpORv6U2ECa8arauCYIp01m?=
 =?us-ascii?Q?eGJgVjxdCDgFxET17qNkSoXv3kvHll2XF6sPQluNsvV5jyo5wVJtiMjv4vcM?=
 =?us-ascii?Q?Jl0DFLqJIbupKbhRIuqm4K01RXhHqhKssCWM/O1+z50GgMpCCTgh9Sk584Gz?=
 =?us-ascii?Q?wsAFQsXiQlLl+V/py8Mt6O07x01WNAr4TQVd0tPHQdeR5UXgPFfMiuX/sYk5?=
 =?us-ascii?Q?p0LK3SUfucRgCpSAr0CcTVFs0kQZOEh4pgvjAUshlxf0wNzO+HrWvgKKjLlt?=
 =?us-ascii?Q?3lAaREI60HrrjYTGdrymf3EIR04rPNe5jJbaH3qRPNwHLQUDKcsEq5hGXW3T?=
 =?us-ascii?Q?LJ88uPg5Laa5ZGG1hbAj/tYtfC/z+WVWGJLzkTJSom3nK4k1k+3ujkLEuyvt?=
 =?us-ascii?Q?JySZcjZULUHJKKoSOX5Sink21xZ1xIb0PCT0OSNc+cMkXCUoCqVixpgG8Moi?=
 =?us-ascii?Q?sQvIRhvM9aTn3b87OhavqHmE1lbVLEqLgkm5C1LiIflzd8ZHptq5AS2UlXGr?=
 =?us-ascii?Q?Qtz7cwh+Mu6bBX+VHf+O2+e/cHyX2px1rvjK2oMpw0Y/rCRMX7eSDe4dmD3n?=
 =?us-ascii?Q?larGQB/b7Of/Qepgv5C7rcF58T/oz6g0VV5Ii8kYWAyeVOsOcDdXEtoBg=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB4533B74E459AAC8E3BA8F32CED760@BYAPR03MB4533.namprd03.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(86362001)(316002)(11346002)(97736004)(6486002)(76176011)(66066001)(25786009)(4326008)(68736007)(102836004)(50226002)(5660300002)(476003)(6436002)(2906002)(54906003)(1076003)(9686003)(106356001)(7736002)(386003)(8936002)(3846002)(14454004)(71200400001)(478600001)(71190400001)(186003)(81166006)(81156014)(6116002)(72206003)(256004)(446003)(305945005)(52116002)(53936002)(110136005)(26005)(8676002)(99286004)(486006)(6506007)(6512007)(105586002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4533;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X5rcuTo5Kb130uKY7QkJ7wKqSiZ0U5G+VoIz+Vl2Wnp2vK2DlF5Er5LjiTn09zKfY1yiGlhRJ0R4qxrWZqVky3FAqlh/KbTqvC4MH6dSOd/YQWStTWUh/C5zsVZqkdy3kSbhSQ6UeIhivwgSTENQrxJmLJRBQz/eie5NBdRmrX4a2l3dcWvG9BXlIt+4CLZnaae5RRe4q0cJmCj7QsKFyKAJw9R9II/nrKNghBFxCu8wHsDtt3dg1UeSIGeu0gtr1ov7Za3gHWN1jz5O9hnjvTkFnzp1+5INP6LAXyiJF3aFQyNGq8LIfgjjWFZBhxjSOIsPWkzuv1GAIZsjcQ6YVtuJrxg2vbqslM4afNRDzcM56PakF4YDTO8vYINlDHABQ4m9C9LbSD9YtVw5us39JMXHbDNw0TUqANOmiJ1CwhU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50863B334B294B4CA01863E2F6F8572D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b36bb6-96a3-4d3e-4395-08d69e03b399
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 05:06:45.8022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4533
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
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 4831c12fee93..ca45a4471ca0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -496,6 +496,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		goto err_free_msi;
=20
 	bus =3D bridge->bus;
+	pp->root_bus =3D bus;
=20
 	if (pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index 3be7ca9f1fc3..cd92ded606c6 100644
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


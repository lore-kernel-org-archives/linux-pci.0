Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96B0C10F0B
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE5221852
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="VqAKyExi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfBZL5t (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:57:49 -0500
Received: from mail-eopbgr810053.outbound.protection.outlook.com ([40.107.81.53]:62622
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbfBZL5s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 06:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJrOO+e+wRNyb6fWknZF9YnjlA9kz18HJH8vJFqfQVI=;
 b=VqAKyExiMBdAXVl6fpTcd11YeEnOVizY6KY5SiJIF+uG5QheEm5zgBJ7q2TkCk06m9e4YgOxZpJ3Q5y4toPJeZ71QiYNBE4Fryjn2lKheSwut0szKWYyGnDLF1+7M6o79QmL7s6yQ+LDdjxCczYYRgIzKMn2N0vOWu6ZGatCsPw=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4423.namprd03.prod.outlook.com (20.178.49.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 26 Feb 2019 11:57:45 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:57:45 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/5] PCI: dwc: free msi in the error code path of
 dw_pcie_host_init()
Thread-Topic: [PATCH 3/5] PCI: dwc: free msi in the error code path of
 dw_pcie_host_init()
Thread-Index: AQHUzcp83KiWlVgU90+UWqSw15+DcA==
Date:   Tue, 26 Feb 2019 11:57:45 +0000
Message-ID: <20190226195047.26eab4c0@xhacker.debian>
References: <20190226194806.34fc23b5@xhacker.debian>
In-Reply-To: <20190226194806.34fc23b5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYAPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::16) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 883016ce-b27d-4db5-ed40-08d69be19e8e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4423;
x-ms-traffictypediagnostic: BYAPR03MB4423:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB4423;23:hyslu3gfMVbXDVksG5nDfjdpiTiebCREWxm4jn9wH?=
 =?us-ascii?Q?81nsEmBidNAjCzOMuJmnbMCSMp5xI967bMhJOa3qYlLRylljJaasXnRrQqCO?=
 =?us-ascii?Q?4NJCcAhmvyO8gFrA1boj4cRnq++/H5FdmpHdBAf6T7NN1yAtPyeqFlQWq6Wg?=
 =?us-ascii?Q?uOrJW4/juL+0MDb0czSUOU6+amo9ZfmekHUMhvbfMNoUfgyWOwvvw37r3e9c?=
 =?us-ascii?Q?pRRmu7ykytheJGtIaLdWi2rZ1uL86dje8O0X8wDI2ZDH/aeHDZLCcG/KPYTB?=
 =?us-ascii?Q?oY5Ld66605rmUHyedPDCIGYZS2oMSjNrivpI5j7pUzX8nB/Qcok7oBhtLWb9?=
 =?us-ascii?Q?FF/fPv7M/20gNWJnOjcu4PEw8wDUJ5uEBwlnqT64+SLxZuKdarUx9ofLfmbF?=
 =?us-ascii?Q?RqnbqNYZT8r1ZbNuZQlPi90VSPMnUPHG8ZcADmUeuDZvgKXYb93IG3XTNJKU?=
 =?us-ascii?Q?WSY3iw4+o6PIacGy3Qz/GABxwGKT/7FU9Za+RqUj4c93yWazP6V6yeNFdoHN?=
 =?us-ascii?Q?yjCLnoZewwkrxwgV1SGj1AGgAsktLxpYPtN8yibVFBHkhDAWsXo1nwvYaKef?=
 =?us-ascii?Q?1ec9qaOI3Q2Y8FUvjmwLQa0Re1tuSiwSxXywrRE4KOa7sEK539T4H7uH6UpY?=
 =?us-ascii?Q?hMCIIS7Fk6s1RTj6gvj3kkQhZCz5BisPFD+Cr52rNHm1YFojoyBC7MYtzP8Q?=
 =?us-ascii?Q?WMfZSzBzBETWpUPwY5BZ0oSfzHDkXcUQh0wHaagLxr45HBkzKy4xVePh2y7P?=
 =?us-ascii?Q?rP8dRAyGibumL1i1KlM6RuvI3OpvVOJinE0oTukWqNGH0Vq8EoZVX5/wloCV?=
 =?us-ascii?Q?GokS5cT3gkSMFf7v1q0DwQGehwboDoC13zHcAnXolHBVi8juBjluG3r3WAAw?=
 =?us-ascii?Q?+eFcby2RYOuAOizSVPII0q0zR+XFIiuvnruDoik4uE9qcT6dI/zBTapdf22b?=
 =?us-ascii?Q?hOjypn3fqPF6SeNzBBLOKGUqWmyPDd+i61LhIZ3cyQvoBj1GNAyETHKh2N6L?=
 =?us-ascii?Q?9kud/bZJueyYpHXWV36dD+EplHfm7LH6S61tIyd+hAb7wFY3rH28JvVA2vPY?=
 =?us-ascii?Q?XImNcEprXf70HReX8/f+eZZJOEmb1XMSX3PWs8yASz8dmemNTRZ7dB6yjx/Q?=
 =?us-ascii?Q?U/nhNBzhvKsh3Ea3p4nUxyFUgBpAQ99WcFllF6iHV6h5L1yF/w+aoBEd6SqY?=
 =?us-ascii?Q?NJb0yRTQ8Uzli+xN0B94ciqtLzZkZSmpqM7/BbtSkhKlksPj5uCHrUw9g=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB4423F6D77DD47424C49981F0ED7B0@BYAPR03MB4423.namprd03.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(81166006)(106356001)(50226002)(6506007)(81156014)(6116002)(386003)(102836004)(305945005)(26005)(7736002)(97736004)(99286004)(3846002)(8676002)(76176011)(52116002)(68736007)(478600001)(2906002)(8936002)(72206003)(105586002)(110136005)(25786009)(316002)(66066001)(9686003)(6436002)(86362001)(486006)(2201001)(6512007)(2501003)(5660300002)(476003)(53936002)(256004)(6486002)(14454004)(186003)(1076003)(71200400001)(71190400001)(11346002)(446003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4423;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +DTF6V5Zpo4HQIE4kUYRoB38U/1bANvh3BF1OsFV9zH0BnkZR+Cn/VA6eSYqouTDrwNjfGNdLis79X80hgv6YOrPvgGEbUxywsXe9eH59NTzP5JJTJvyZxlNctYdbfH02+1VSGoWXXZXTqX2bb6h7DYLH67az6KpYFNJzKKPPwoiFUCwQBMFCVDo04+a9k+W3xqCZkx7By7YaosMojqO5/wfKW8hhndt/ZTrcj1ymKVXHfTEXaRa1a0DNhwKzxZb+A/zJ5AgD/cz7Bm5lk7KWhmAp0hNqeJlY9jCshWzwYrUQlOBQd6JazIJw38TVX58/25G+lf4o5kCoTJLGjuDnksAxm+YF9/lDb0tX0NQT1kmaOyXi3lAOMMA7q40kdcltUgdWFbEdhntNXaZgDKEnvA6UKO8tPup7yTdXtYazD8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE9F9EF101E8554792AE02D4E58DB253@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883016ce-b27d-4db5-ed40-08d69be19e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:57:42.9623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4423
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


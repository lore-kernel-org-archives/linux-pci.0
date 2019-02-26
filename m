Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C129AC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84371217F5
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="xQ4qJYt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfBZL7T (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:59:19 -0500
Received: from mail-eopbgr710057.outbound.protection.outlook.com ([40.107.71.57]:46720
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726478AbfBZL7T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 06:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDfJa/5peeKUsjb5cZhVZj4vd75dEAlF9WieijY3ECo=;
 b=xQ4qJYt4HQeiGd7lOeC6um69IPp2lrAx/l3bGYFGzZ+tKe6D7x2iP4nKUFG8sTjWV2VFxh1MzlLTzD/lv9qWGf0i+iMyYrQkmDsfLF4DU6f+3MjodGo5rscxM0nrHElMiwkEgub+s8UA8WuQPKv/7zi9Sua1kp/+C83cXgReeAs=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3989.namprd03.prod.outlook.com (20.177.126.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 11:59:17 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:59:17 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 5/5] PCI: dwc: save root bus for driver remove
Thread-Topic: [PATCH 5/5] PCI: dwc: save root bus for driver remove
Thread-Index: AQHUzcqyCHKOtYOyCkSTO+UrI8JSHA==
Date:   Tue, 26 Feb 2019 11:59:16 +0000
Message-ID: <20190226195211.7ac4926e@xhacker.debian>
References: <20190226194806.34fc23b5@xhacker.debian>
In-Reply-To: <20190226194806.34fc23b5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYAPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:404:28::33) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce042779-c1fc-4253-cb62-08d69be1d522
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3989;
x-ms-traffictypediagnostic: BYAPR03MB3989:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB3989;23:oTiW0FNun+NO3PDOujGHNTeElKmtUGXwXmHSN7HLw?=
 =?us-ascii?Q?GJWXEKOyCihK62q10JL7D+5R6TM11oUk3p2ucRWa2lvMcX7e+b54JAEWS2rj?=
 =?us-ascii?Q?x4mgBy2vXgYrRLZiE50FzYvoo1wsccZ/UGlMG01Fk3c6pLq8gR6pAQklT1Nb?=
 =?us-ascii?Q?26AOaiSTXSU3mwekJu3IHFjNWviAVeo8VWxr6/EKi+Bqnq6B0v7ZIaLJoP0D?=
 =?us-ascii?Q?8GohvhOY4L49hKRP+smjvVxe1GiSL40p4XfGWaT4xZG22hU8tG+7maWdMw2L?=
 =?us-ascii?Q?6qUed9Cg6JAK3l6u9XiDFk65F5dVnjbdPZ53TZ0lEljzUDulPDHdfQgHLOio?=
 =?us-ascii?Q?FqcglHt+5ruuoCRo7Zdlgn7fj+6SHT4t7aWWQqtXkLdkg5kT0jnrda8t+YuN?=
 =?us-ascii?Q?qQ67NKXyp/vdUYY52Rik8UtZlRJ4XH4UYPu2aL5/xoIq/GOZU2KVZ5bZ0TjT?=
 =?us-ascii?Q?esHj5oFVmGHmFA0zfn62bTnk+CMAeWszpP0R3RhViu0d7cSI3b3esp1KO5Wf?=
 =?us-ascii?Q?taEk7hCn3KJqAw13GamevZu2/rsfzrOzX/GndbVhmPa7oBHTEWyH4cufiAz4?=
 =?us-ascii?Q?LqW4apfM9PK2orGOS0W3DJBjuMzh8llhWMU3QQgRjW8TUcozJjJay0dACEG2?=
 =?us-ascii?Q?bMqMzgj1MzSI4uIgT0j7DRasQWt2lBPBurU7D+mpmAPUCCabW2XZ39ZkRIXo?=
 =?us-ascii?Q?VOBG5ns0n4qx0uC1K5WIMOh9kKxGGG9a32cxD94Th4kZUMZ3v3L88gVNosDs?=
 =?us-ascii?Q?HAZgoQeKrQ0jKLLLlBGobRib45sDC485iT7V2umWIoSYmNdGG8m8gOE5rbjF?=
 =?us-ascii?Q?ijbbtNa17ueEbDTLFEvCXIsHapFltQ6gbBkBupLyvRgB9Wz8Ja4ON+6gK62n?=
 =?us-ascii?Q?UlHPvZ+0y9xupxn+UrJQECN7tha0fR+WAuT7Yv/4Qs9l9O+tZOJh5AJJ/0Qo?=
 =?us-ascii?Q?A+6K9CqmQUqXpKkhSG4uUKm97Jn6qK/N9gU2t9ePAgMERcQgoyl7fyEMW1+B?=
 =?us-ascii?Q?KvMV9hQU9vZCMi0lri2yerCcmIb41VYLlzMCzirGmvgBQ+I1OhTwx3shj8i5?=
 =?us-ascii?Q?zmF3N+a3ogNx/eeFWojw1gYKUC3xQHqGdr4uricClAQVdWamriqtxMEVEM6a?=
 =?us-ascii?Q?B3DI9lqBbyCsKYgSAwP565uyZmn6gyMIeKclNrtW/CGjOXPZMAqdQFCr51Q6?=
 =?us-ascii?Q?pPfKBsMlqt4qig/TP3uYTRMZAFaWdUoEYGLP83vMA6EpgiX8Xcn5PO1TQ=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB39890D9E7EC0D75682DA723EED7B0@BYAPR03MB3989.namprd03.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(1076003)(72206003)(26005)(6436002)(6486002)(316002)(2501003)(52116002)(6116002)(3846002)(486006)(25786009)(102836004)(76176011)(186003)(476003)(2906002)(11346002)(5660300002)(105586002)(446003)(256004)(106356001)(6512007)(9686003)(68736007)(71200400001)(71190400001)(7736002)(305945005)(86362001)(8936002)(2201001)(478600001)(81156014)(81166006)(50226002)(8676002)(99286004)(6506007)(66066001)(110136005)(386003)(53936002)(14454004)(97736004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3989;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NfK6GxQXBzNQQrVYGuQDC+SdunPlFnf9Y7Bju7gw84aQYGfVI0lql7WLvqyDbuudgrYUfrPKe9N/kJC/DhAQzBEubpIpBv54M6H2DYXPVgjP5SCWQfqAwYs0nMdkWPWtl1W+Di+7fkjoa4eXgb/qqyYVtQMDcnfX0lv6UnF6Tdj2OGTZSPYsR4IHWfH5vZVATGDhLUoOu2oHlJJ9vfGHEONopJLXcilx8XmBbkYl+6BhAIzFhF4pPKk2/25ONYRYk5nrHwZOA2NTalBBft6tM8K4dBbadHv4IVN0FxBY0H8mlB4YyuNzZzaJHCNqQtgSDMW/wQNFLkNa0IJrcgXf/px1dTe3k2XLbHHvNBRAd9L9ONvwAt27e3tAM3cpIaqww68lDIySBXTkuMHmYLoTdJ20zst0f4IasgXbiANCSEA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8E641FDD4F96D41B8A69E9E3E27C7D5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce042779-c1fc-4253-cb62-08d69be1d522
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:59:13.7848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3989
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


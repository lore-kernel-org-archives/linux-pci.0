Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976FDC10F03
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59155218AE
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="w9U/ygVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfCAFEM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:04:12 -0500
Received: from mail-eopbgr800053.outbound.protection.outlook.com ([40.107.80.53]:38526
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727463AbfCAFEM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 00:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex6uyZdWem6jPJGDdDtu1KGRvPYljhIDe98tVWT8nUs=;
 b=w9U/ygVTDRpBZlzd/E/DLB0reE3jXxIiTgP+LVEI04SCve2cc5k0joGtc2+0ad8hy7DGrEjip0bgOLv9BIVLDJJKXFuSTECwFhwNmnF9TN2vJndYTtJFHUC6BM2kdOKccJW108pJls2ouuNWvC0s1Z5IhuNQBEZzAgfc66nFae8=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4533.namprd03.prod.outlook.com (20.178.50.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 05:04:09 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 05:04:09 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/5] PCI: dwc: Free the page for MSI IRQ in
 dw_pcie_free_msi()
Thread-Topic: [PATCH v2 2/5] PCI: dwc: Free the page for MSI IRQ in
 dw_pcie_free_msi()
Thread-Index: AQHUz+w0Gr/59ysaiUqI8xDUOx+UmA==
Date:   Fri, 1 Mar 2019 05:04:09 +0000
Message-ID: <20190301125707.73563471@xhacker.debian>
References: <20190301125510.4e2ee985@xhacker.debian>
In-Reply-To: <20190301125510.4e2ee985@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:404:f6::23) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 533dc7b9-6ae4-4055-455b-08d69e03565d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4533;
x-ms-traffictypediagnostic: BYAPR03MB4533:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB4533;23:lupy0sd23WLjsF6076Key36Bp5TaWyhrEgor4ZwbB?=
 =?us-ascii?Q?yaya+NK16/Y+RaIOEmYrJI3ZGyzWvbqSDujEQWD7o5wACveCmMRVWSQxbK7R?=
 =?us-ascii?Q?PIs6oFpIYC0JFHg/FALbq7SNxsX7RqqQBUPugfTjk59XR/EkjOkBHBXPMeqy?=
 =?us-ascii?Q?jPW/9VWYCcGulXp6KaZA2lNxxYZEhI2Mh2mNh2h+ImLRrCwdo1psbN7epIO0?=
 =?us-ascii?Q?fpJ3k377ore2wg0htKgYrXdmoa7daYbmFvZuDp1eMDkEGacZ28W7n6nKe8TR?=
 =?us-ascii?Q?JmLqtPMEH8A03yGpLQARlz72lOShZIS4hpDJgsxFOBwge5azCMEmZaAj7jg9?=
 =?us-ascii?Q?LVLthuAG7rjqOj4DvPh68wQJxa7um9t+Sdc4ZgtE2Ia09uv+aZ3fX7ZSZT97?=
 =?us-ascii?Q?2yPUWD2l6nHJtyDUHaThTiVRT+0p6TJ9agB6050/dO6/eJYHX2saqV939gHy?=
 =?us-ascii?Q?SJq3boBg/LPv6R/B6JpZmFiBmKwwmltvfGt41dkPwtAAY+SitTG4G4ilNQm9?=
 =?us-ascii?Q?bYxam5YciZ+yqsXdiE51abXZ7IKyX8DZJMkRNXgiRNwp5M1q6s/Blq1WvTfx?=
 =?us-ascii?Q?XlZwGdvXPTbWhHylfQmJZJV+CrHJuNDy6xtiV4EdSEKTPkBjJMHyoQ0pPiSW?=
 =?us-ascii?Q?1xDzF7mpgYfGOIof/h7CARrHadNfyGqGGhUAwzddOpv4QepxB6RwrCQDJE1B?=
 =?us-ascii?Q?vFGZta/xmJJjDG3BAZK/B34yrg8sctJJ8mSwTW2DKHIJdwZk8PFz1Iruf6vq?=
 =?us-ascii?Q?tKJeWvm10gBsAlQQbMANoqSraKWKUjsOyXozYPdKgG0M28AHJ/CoJQWydcOc?=
 =?us-ascii?Q?Q2hAWBNsg2hGGRQGiDyGNBDjDmA+s+R7O0R5dQGrvDEGiNpjeJTteQACrbIA?=
 =?us-ascii?Q?8vVdV1QX6xcl/3exyWwkO5PN1BEDdylVwJOzIoTlbKzmf4WGpNFDH1+YQDbw?=
 =?us-ascii?Q?TfFKQ4pu4lZf3tFH3qTsOurVYl4o/EOJ+3OnJ2ue0Ls2NBMWNBevC8JLnrU1?=
 =?us-ascii?Q?/CdxywnPzA183nprj2RpcWD9QUhpwRqUiHDpD67E/SK5sWBt7bsgz2O/0gj/?=
 =?us-ascii?Q?C8OsPLA9jXOweC1T3rf5Y2CP6VNjHSIoGsYVcku6Lap7Dgp3U/z+Kan4Njkv?=
 =?us-ascii?Q?X6BY9K8jh9/3xTGyM4mUADkNeF+tCbdvvecR8p0BoRFl7MJlrSPDNCq0CnjR?=
 =?us-ascii?Q?X5FNSy6eIdKTotDLqdRM2QS6YGsY87wXwmAR12TUdk9mNasraroLLwCtMCsx?=
 =?us-ascii?Q?KoYfajUok3K3SpG8sVUJ1qMLFWYocCO4nf3I5TpCEfvJFVVbfEjy02j2qMvz?=
 =?us-ascii?Q?MduHS0tCXsca91p6wO7U1q9aiS+ZOK4hJzSaNLjkIdw?=
x-microsoft-antispam-prvs: <BYAPR03MB4533BB3621DA123CEA7DCDCFED760@BYAPR03MB4533.namprd03.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(86362001)(1970100003)(117636001)(316002)(11346002)(97736004)(6486002)(76176011)(66066001)(25786009)(4326008)(68736007)(102836004)(50226002)(5660300002)(476003)(6436002)(2906002)(54906003)(70486001)(1076003)(9686003)(97876018)(106356001)(7736002)(386003)(8936002)(3846002)(14454004)(71200400001)(478600001)(71190400001)(186003)(81166006)(81156014)(6116002)(72206003)(256004)(446003)(305945005)(52116002)(53936002)(110136005)(26005)(8266002)(8676002)(99286004)(486006)(6506007)(6512007)(105586002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4533;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E+A6BVOCD+VDayczPH2qOt4LTeZUucotoYXZjUcoaVtGF2WycUh+ZoaEKCmz4NxQhkSJ7aPIPXd/GXpyeaTHim7Q63CFKX9cu9sGpjnoymvUkMSM+oGME5NgFa39W9Hx/VzIemPaNtah51BpdxZ/T7XzoHN6pv91RCUnMibWirN+at38rFgNFckUN8M1Geh0y3ey+BhvOy0vSJ2ParQE9IomRLyHYa4owPYErr4ZqyVnrinGYgLsIiqjjLLzP4FpqAq5Hmqrto9UaJk7Z7/bp4PeECgabmS3r5sHLqydM2WjJFzhRyEdu8z3UI8+xbDJMlxwzCHwXAvGbuTKJl2RsMPdAL7KHPVGpf8Iatv2bHUuGxAZ60JQmj0QVee/Y1+DTdj0MYue3QpKJroTiW7j5Yc6Iu1bpukPZhKpc4FBFy0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <83DE0D29CDD4F046B36B85F9615806AB@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533dc7b9-6ae4-4055-455b-08d69e03565d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 05:04:09.3929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4533
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To avoid memory leak, we need to free the page for MSI in
dw_pcie_free_msi().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index a94d3530b694..abe3ff5f0867 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -305,6 +305,8 @@ void dw_pcie_free_msi(struct pcie_port *pp)
=20
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
+
+	__free_page(pp->msi_page);
 }
=20
 void dw_pcie_msi_init(struct pcie_port *pp)
@@ -322,6 +324,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 		return;
 	}
 	msi_target =3D (u64)pp->msi_data;
+	pp->msi_page =3D page;
=20
 	/* Program the msi_data */
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index f6fb65a40f10..3be7ca9f1fc3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -179,6 +179,7 @@ struct pcie_port {
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
+	struct page		*msi_page;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
 	raw_spinlock_t		lock;
--=20
2.20.1


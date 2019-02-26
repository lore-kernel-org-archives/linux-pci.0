Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C611C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFFE21850
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="XxrENTlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfBZL4y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:56:54 -0500
Received: from mail-eopbgr810083.outbound.protection.outlook.com ([40.107.81.83]:2176
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfBZL4y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 06:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex6uyZdWem6jPJGDdDtu1KGRvPYljhIDe98tVWT8nUs=;
 b=XxrENTlpe/5QYKfuq9SUOnD2AAYf2XOZWGIYLFJvQNu3fkZ4FyRqVutF0mVj1QOw2z5kS1eL3xua4uIPiPTEfk+iRrA++oQBnGUOQK6EyEdlFy3yJ1redOO/caShrULqFsJ5qpYuCVssZ4rVMS8AOslGpPSZD6oU24bxbDO3wW0=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4423.namprd03.prod.outlook.com (20.178.49.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 26 Feb 2019 11:56:52 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:56:52 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/5] PCI: dwc: free the page for MSI irq in dw_pcie_free_msi()
Thread-Topic: [PATCH 2/5] PCI: dwc: free the page for MSI irq in
 dw_pcie_free_msi()
Thread-Index: AQHUzcpcnRavJqeZhE+qMQkNx0b7CA==
Date:   Tue, 26 Feb 2019 11:56:52 +0000
Message-ID: <20190226194954.4ad0be3d@xhacker.debian>
References: <20190226194806.34fc23b5@xhacker.debian>
In-Reply-To: <20190226194806.34fc23b5@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:404:42::30) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc539e5e-5cd2-4edc-1015-08d69be17ed8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4423;
x-ms-traffictypediagnostic: BYAPR03MB4423:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB4423;23:ZcDw+LphJvcqWtGyWJXRnVlrsMzFLHaWaFXmPLRmZ?=
 =?us-ascii?Q?+M2EXpu53LIX9ZOOQAn9u/LX/b3trLthQqezhLbyncisq1SoQqvJmbERxUSJ?=
 =?us-ascii?Q?weTanSHklCjsw+sWcfzck+1UKri5KeZel0uoqgNq7xn1scPSeKU9iHiRbwUW?=
 =?us-ascii?Q?omvrr+04crZGMvs00FnmhRyY0HDdkS0nqRGL9XMcVA2TAEYXsDfzIBXSSy/a?=
 =?us-ascii?Q?xbB/d4mC0CvZyEOgcU/BPlVAv9TOSNdUz5qKZSrvgWFnype2uCDwZQvKCanU?=
 =?us-ascii?Q?njFhgQmTa4jEX5bINO3HWvH2ugUz0JKo2G27avPtSk0W83gNV3pQvppAhEjg?=
 =?us-ascii?Q?8/NGJtTyL1c+T+e+0a0OhOVk4f5rxSggcbZH0ifkx3J2X/pWtoMI5nsNbNSm?=
 =?us-ascii?Q?D4QhAVoLUW+L/+ZBjDKK3cdaHFSsV0Cr/aejTkGg87e6dex7tZM/TgzRG6Bw?=
 =?us-ascii?Q?5gZEAhZAkHDkwBLHFysCqbfOPzXl+LuHTmsr2OZrAK/ogQ1QHBO5D5YO1/pk?=
 =?us-ascii?Q?chgybpClpeL5L3SOgYfA1j9Yo8/3pAHj7HZMjCXUjke3S1VwwySG7AcewaRQ?=
 =?us-ascii?Q?1SK8PyLeKAQf7ImzhWHo6rHpyT3H3sgj9kn18JRUZrUetcVCSJ1/Cbn3kb7a?=
 =?us-ascii?Q?/R8zshM5XEmDOx30NfamA2qbz1/wt3LL94IV83OoJG+sglHN0jLNiMjvm5Zd?=
 =?us-ascii?Q?ULgJ8IqIPJn4+NLn6mpKeQmPMEXDdW3AgDi8VpErPula8oVFQEbeBBYfe4UR?=
 =?us-ascii?Q?48OlXd6oX65JZIjPf/QreOwLZVCxecJUy33HGlas513NkFDFgZDvcjAGOMvP?=
 =?us-ascii?Q?V9v9/kg/YKmKVqH5xVy7drhAHfHF8UjGz6K+Fu25FcOCUErfcR909Z9uGGMR?=
 =?us-ascii?Q?uR0ueFILhapCbeHPaemfkhdpFFrfzDNFXLavsyvJgygn2+ubOBifNivCPOem?=
 =?us-ascii?Q?im6WEI1IbWwOW82TybH2oIN9lWEKGfA2uoj89ekpwqkPaEHJYZ/omuqxrRiP?=
 =?us-ascii?Q?dtquKfy/HrR0GSBH197R7ciu3J0KX7TxH98jv71V1rMVjH8Vr1treie4P/eu?=
 =?us-ascii?Q?YRPrzYPYSpEdDoXKqzvYFXykRWAuDlH+PDUwvII7pSjyhHJEsVpKBn3lYgLz?=
 =?us-ascii?Q?YVItL/M3zrzzrX38pNp76jGjIktLM+ponv/FPI8zdJc/lazPRSG5mHb9RAnC?=
 =?us-ascii?Q?KgZ1MUr2QwJH5qXPCmBxpnE+H2JfeCA6NtQ18t5yL9+Ru1M1g8JotPcag=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB4423715963EE4BAB154AFA7BED7B0@BYAPR03MB4423.namprd03.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(81166006)(106356001)(50226002)(6506007)(81156014)(6116002)(386003)(102836004)(305945005)(26005)(7736002)(97736004)(99286004)(3846002)(8676002)(76176011)(52116002)(68736007)(478600001)(2906002)(8936002)(72206003)(105586002)(110136005)(25786009)(316002)(66066001)(9686003)(6436002)(86362001)(486006)(2201001)(6512007)(2501003)(5660300002)(476003)(53936002)(256004)(6486002)(14454004)(186003)(1076003)(71200400001)(71190400001)(11346002)(446003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4423;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kaektce/DGv2ccOKpZzQV+nK1oeVWd9EbhYEyZUdxOBOH8GamI2fITtNXoUp0M9a8zZOOe59X23pZWyeFeIjcrpGsKhDYppKS4klCPZEPq2FKYTuoi34AOovxZw21VR5/pWbkCXusItYaDt6iEWBcgvOqkYf2wKob7o91DzG9zuhPHtMpkrl2ap3V2YZtPOSGQJYZkrjJTICvV8TYXirNfKmvW3tYS0fzXN1fbw/rzadH4UGMumvNAZQJNy4PhQCFnKq8qtHeqbvXR9VGgu/jHlv4kyYOTliE0VRqHeVMPwXTDjUk+5l187QND/x3doJOh24H4nvOZZ/UK0eenAk80UgLoIHklUbt47u6N3p/AOBgHrdyjKnVMjbSu+7iJAGyOofiGIdLlkGOrXqjq35XgWu2lUrR2aq4J7HneBAnD0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B91CE88369CA0449E23D88A7011297F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc539e5e-5cd2-4edc-1015-08d69be17ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:56:49.7035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4423
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


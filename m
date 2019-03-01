Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B840CC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD2920842
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 05:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="dcxWi/9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbfCAFCU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:02:20 -0500
Received: from mail-eopbgr800043.outbound.protection.outlook.com ([40.107.80.43]:35776
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbfCAFCU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 00:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjk8U/3sBYrKhekX4hroCjYXMnz/EbUE3OGOtIQqDiA=;
 b=dcxWi/9fXD7bHVJkdzYteLl5Dsh2cHQ2TqV54T3cOI4WQZlvoXfDvFf2tbOp7s59dD7FuaCRmvgqL9+qgDJ4Wl3IojiBfnTteOQHTeKhDuwnF/BJsJOMcppU17gB+nA2dd2/7HvrveDNutX2zP6hZYnKdeI4gfI7jHg8ukHvUnc=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4533.namprd03.prod.outlook.com (20.178.50.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 05:02:17 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1cca:e5f5:d31d:1e5c%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 05:02:17 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/5] PCI: dwc: Support remove
Thread-Topic: [PATCH v2 0/5] PCI: dwc: Support remove
Thread-Index: AQHUz+vxPcDv5Ll8t0yCbZJv4RtGhA==
Date:   Fri, 1 Mar 2019 05:02:17 +0000
Message-ID: <20190301125510.4e2ee985@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:404:a6::32) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 143c423c-967c-4455-5049-08d69e0313c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4533;
x-ms-traffictypediagnostic: BYAPR03MB4533:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB4533;23:M1q4HDMd311iszqj2nFnpzHO7HiyUedWnyaG4X9XM?=
 =?us-ascii?Q?RUGogK3iYIIHP/BhFz6rbAlB+wHYVr6gakk6VyhXQxFijpd1pghVXXZn87n/?=
 =?us-ascii?Q?p9/50Rb6oPRHrrcorlxDzZ+YrHmStuoOXdvIZhUThoYpRdWBWHkaYOBl78oy?=
 =?us-ascii?Q?1DfHoNFb86OdNhbTU6PL/XzkXOWmHCDp9v1Shy4sLb2fU+EmTE+22Vg5mCLa?=
 =?us-ascii?Q?QHquAS8xrYMxRL8OzvhiZdhSdkoHvI2A6iiIr+wCrUwvf1WX7GV2z32LtHgc?=
 =?us-ascii?Q?zQu0Qh2Fvn9PfN6n4k/NPKRk+fxJqGopZhcQN6eXHU1ZHbmqw6AI4Y2m0/kB?=
 =?us-ascii?Q?v9/IECOl/nJsoy8rfPYuRm27iKfhufrytY9Sy6GgSMJ+LVe7CnadvKReRNyt?=
 =?us-ascii?Q?MH0+lHCAZreeKqDZ/NFw6XBhNA2GUlSqrj1ErXO9UpZTSokWkhE9KOqFGnpS?=
 =?us-ascii?Q?A5AqA03N3+eeOT1YKi3H7LGYJsui25FBGp6YJIBTg2/Z5SsDMcnbMY+p4hp7?=
 =?us-ascii?Q?3JNYs9qhB+Sub8swtu50ELVX1zIz1rZ3TDwWFxQgC3ZOdtGSS8sZT9pLN0VS?=
 =?us-ascii?Q?Z+zjCEPli4tVoQGZU//qV7wnERKwRBM1tXus7XuwiWweZtk6bY8cHrnXVB/I?=
 =?us-ascii?Q?5lNa9ePRwhAt5wHSnkkgdGOu2OEEGWRJco5mqR1SOgSll3/jxNTWXTVqV7tP?=
 =?us-ascii?Q?FDMx289YPPlukx4zfLycNep9PQ/lEPygjMZAAWKJ/anr1tl5V7Bm65ddZ9zm?=
 =?us-ascii?Q?MHS8QtV3NghUpTgyU/kvy56VH/9tnhFrTY8oU/SjIOJtZwK1KBr+hmWtkicb?=
 =?us-ascii?Q?RCLKv5xfbgW7sykLywpFZxwRtAh29Fx4Uv6D/AfnawrMhQhIbOi6YcXK70o/?=
 =?us-ascii?Q?L9oq2JwH+qhIxbKmAwUN7He2Bh2A7oW1W8CxrvxxPoJhiUqWYi0qG6DSQcK0?=
 =?us-ascii?Q?RLH1xbncEkUc+Tpfku4KnlCFjKkPkCIKK/FpH64bA/6aIZ4ROvyHapTUDib5?=
 =?us-ascii?Q?dztJrehpYrM0fiQd0M7O3hbcz5ZLiN0Q+TPnMbUHbndw5M6gYj/XnWxDS0+j?=
 =?us-ascii?Q?WuCAk1UabPDi3ol+9emUQEOGI/xkX0BA1J7QwouC2nuTNptRY//u8Albc1qf?=
 =?us-ascii?Q?9veuPseevlbuJVQjOMF0gUe6vksM36ZXs7JjOvfxJRuO6KdFgqd+4PKsfjWY?=
 =?us-ascii?Q?2tbMRn1pTtPg9ciO+VlX5byU6lZLHszLkz7?=
x-microsoft-antispam-prvs: <BYAPR03MB4533BE7FC8CE5F879B4BE714ED760@BYAPR03MB4533.namprd03.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(86362001)(316002)(97736004)(6486002)(66066001)(25786009)(4326008)(68736007)(102836004)(50226002)(4744005)(5660300002)(476003)(6436002)(2906002)(54906003)(1076003)(9686003)(106356001)(7736002)(386003)(8936002)(3846002)(14454004)(71200400001)(478600001)(71190400001)(186003)(81166006)(81156014)(6116002)(72206003)(256004)(305945005)(52116002)(53936002)(110136005)(26005)(8676002)(99286004)(486006)(6506007)(6512007)(105586002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4533;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I6WpZPKdSm4GsRvHon9KnR59EHCA275j0sDBbSUbE+jaiMMxMTNZKZMuXRvet8RDNg2jVoXDi3FRzuDgXoY0HzWd2GUD3fPCunjAKa9FrBrITDNRMHQG4TNzjLc7VPMe6e0Kvsz0lmrAeItQPxsj/gpW5PsoGjzPurrh2TiL7Kz5ozcW2Xhsm7DlZprORRTPnEtXjb2RU4FSfFXrr4rx3pbk4psG/MJK2QypHmuEDW6H40zuxHmpFdZbwYdN657Kteu/vp+Nb19e3iNZxo3gxP5wnyNekiAhdr+spmzktIB2lu+a8C9NZRn0/Fa+HKig1sTx8evYVBFUtdB4zYUHZe/ogmfrqvSdRWxE2CDxaCh5QzUUvl8RDzBu4MxTN4DFiNFUe4QsgtiQY7IFKPTtV34x2sW1oF5LPxN1g+rf3bI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6AD9ADDA9579594AB28C290C7E143702@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143c423c-967c-4455-5049-08d69e0313c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 05:02:17.7527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4533
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the PCI dwc host users don't support the remove, but nothing
prevent us from supporting it. To achieve this goal, we need to ensure
we can do necessary clean up work.

Changes since v1:
  - address Bjorn's comments, I.E Capitalize, s/irq/IRQ/, s/msi/MSI/

Jisheng Zhang (5):
  PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is invalid
  PCI: dwc: Free the page for MSI IRQ in dw_pcie_free_msi()
  PCI: dwc: Free MSI in the error code path of dw_pcie_host_init()
  PCI: dwc: Use devm_pci_alloc_host_bridge() to simplify the code
  PCI: dwc: Save root bus for driver remove

 .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +
 2 files changed, 23 insertions(+), 17 deletions(-)

--=20
2.20.1


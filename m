Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10578C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 11:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F592177E
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 11:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1Wg2IXvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394596AbfBNLbB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:31:01 -0500
Received: from mail-eopbgr800083.outbound.protection.outlook.com ([40.107.80.83]:5776
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729808AbfBNLbA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Feb 2019 06:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUvkScEHiGzC/q47CEDhhQIdi43rPfrfzkglwcFPa8Y=;
 b=1Wg2IXvhQO8fO4vCHVZmZ0Q3RKnoKciECWYXo7S3s3Rmcvc0YMpAOlnCGt80svvGUrWKrxNAWwXc7vjkYTRzgIYJc9tq4a4azS8aRhhBCTEmHWtGi0MvNaq9SCz4YYR7XdhG/SxqObzQSQIZlM+6VnXEu7uFeZ3nroXHRZCAHzU=
Received: from BN6PR02MB2772.namprd02.prod.outlook.com (10.175.96.7) by
 BN6PR02MB2849.namprd02.prod.outlook.com (10.175.96.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 11:30:57 +0000
Received: from BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::963:fc2b:ba8f:c4e7]) by BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::963:fc2b:ba8f:c4e7%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 11:30:57 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: xilinx-nwl: Fix Multi MSI data programming
Thread-Topic: [PATCH] PCI: xilinx-nwl: Fix Multi MSI data programming
Thread-Index: AQHUw6gI/5etm/0omE2gWPjMEG0LpqXd7kyAgAE5zMA=
Date:   Thu, 14 Feb 2019 11:30:56 +0000
Message-ID: <BN6PR02MB2772BEF7F8644EF9AAF7F23AA5670@BN6PR02MB2772.namprd02.prod.outlook.com>
References: <1550067939-9859-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20190213164019.GD2280@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190213164019.GD2280@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7c37e5f-bb7c-480b-92ed-08d6926fe33a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR02MB2849;
x-ms-traffictypediagnostic: BN6PR02MB2849:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BN6PR02MB2849;23:YY+CVjuAVC+Oa5T1bTldQWSljFwKlzLg6xMZQNISs?=
 =?us-ascii?Q?xj07R9SbXdK4OocyFXj48jHwSi0wknU1gnr5OGpAxEYB6vrTowsqmrYD6/2m?=
 =?us-ascii?Q?0cMwrhTb2CmqtGwwuWJtezXaRHTpUPMhhZdG6eiNu5hq9vwNetZ0Y97dYjQW?=
 =?us-ascii?Q?VqXyv3YEzhoXgc4kDTp+WpiQ489cg2GhzIRwiwRkebpArrGUiT7WDjGOvo3J?=
 =?us-ascii?Q?KZIsG0Fa+U8H1wjHAbD73rwwTD4VzgY/95lEW/6FPzztTEHPpNCawbwVDA3b?=
 =?us-ascii?Q?+a+0AkvwUEZ4bmZreVAThX8n13Buf8X+0xS0peedTkH5cLO0sRcyNliFFO90?=
 =?us-ascii?Q?fAln+vLl0o0Fa6AxoOnzZFroH22xXVwGPDPYWD/eAZWWgO86qcXSEsIbI0He?=
 =?us-ascii?Q?nuJ89ouVHqtHjEKDfbNO7HI7CcKIoNFxfO05CEK5XyrLmcL9oOygWh/BKFE1?=
 =?us-ascii?Q?XGywsEXvSAaXmPZL8wtv+pgB+BTHL79NAyV9g72EFGh1jt58x3YXMHgwakZv?=
 =?us-ascii?Q?V+H/4XzKco/jZSjPmd9OYU7tXaLwjWIs4YA/zg5BhMgnAkFz4lj8EigDvFfH?=
 =?us-ascii?Q?IL8paSYhqiwyU/8Sj7EVKgXK6+idRDIW481uKRi/h0SvjLjDbsTY+3LiUj1e?=
 =?us-ascii?Q?kHBvX47nDcI1SEMV6zaSDss61B479CrjEMgXC2SxB2f4FYjdG9QyGFQiy6ja?=
 =?us-ascii?Q?zMgHezTzLX5aPyvQ2tc9UjtJpAIPRo5QkHaPS1I3OLqJQLh1lwBK61PmeNeH?=
 =?us-ascii?Q?GK21pyCI2Eqhz8YxL1bKs08wKEcsqqsMLszTI4LGQDVlClOQ2qdZQ0vmSFXP?=
 =?us-ascii?Q?VhpZF7YcWLvJHuEQdZ+zkDbgvdluNxRXPVtGnlRcRVk2/W+IvbNIbWgAjK+E?=
 =?us-ascii?Q?gjY5WtftaqHKoAY662ClhlTlWtTx8F1eKNi/z392543c3xkJR97o1A1A2zTE?=
 =?us-ascii?Q?rMy377T1frJEtWYocN1hdm+UMUFKeOJWD2qvteAKYlkkwYoKdsMAO4it2QDf?=
 =?us-ascii?Q?5J6V76ElXzDJSINaNAS8gBHZMUvHBam+agBbaezrSCUnwjC9MKFaceskCKZs?=
 =?us-ascii?Q?7RzECFRnIgrbG/5HcHv4st8GLp1aq1VSFTBgb42N50uij+9AOy8MkUWXNuj5?=
 =?us-ascii?Q?8KWMx3cuYL8CrE5h9JnpG7tETWlTzuX15RXT8/l4IAx4RKF6BrlySDK51ZmP?=
 =?us-ascii?Q?bRxqlyvDR/6dODuFPh3BM66nGammpJ/oqsmk+9c1YPRiiX3GTGc2PP0dmZVu?=
 =?us-ascii?Q?crSxC3tHk89Nr1o3IA=3D?=
x-microsoft-antispam-prvs: <BN6PR02MB2849625203787B6326D9B92AA5670@BN6PR02MB2849.namprd02.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(346002)(136003)(189003)(199004)(8936002)(8676002)(106356001)(6916009)(4326008)(316002)(25786009)(305945005)(7736002)(74316002)(2906002)(81166006)(6116002)(3846002)(14454004)(97736004)(66066001)(81156014)(105586002)(2351001)(14444005)(86362001)(478600001)(2501003)(256004)(229853002)(6506007)(6246003)(26005)(9686003)(5640700003)(55016002)(486006)(102836004)(6436002)(53936002)(11346002)(446003)(71200400001)(99286004)(68736007)(76176011)(54906003)(71190400001)(186003)(7696005)(33656002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2849;H:BN6PR02MB2772.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jXOaZ2yRHfgzwG/O35Lhbp4/PeUwPyypCofruVrjCrnst9XEaSKGeGYEKuKxPQxuNwF2gnRZUa2oyk7Krd9uxvK6fI2WTxTVWmi7Sgxj/CUWq0mPeRXQJplW/fsStj2eWmHhcOjlvdZsArb9HOoVgVFYCrX49Zqzlepwh5uEFqb00MIEMD1ib/NAB72rBqOp1aQetfAYH+bl84mpWR7O9e1l+psh8TQULy+jUqzPdc2soWJzlcOmWxhhfiwuk0QowutRq/A2YsuaIDJmA/4kvaxD8YRaaWfADYzb1WdYTEPxcsaJeO1yGOdLQWS8QNlgxif80pRWokr1pdv2sjgcbCzMKedVBTkQbRMrJ+yXx7vyyL+Mk3swE8K3y8FumG+xkTY2F1/LfRkIsEEpCJGCzsWnLQd21HEjPrHlCqpoGcU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c37e5f-bb7c-480b-92ed-08d6926fe33a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:30:56.9885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2849
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH] PCI: xilinx-nwl: Fix Multi MSI data programming
>=20
> On Wed, Feb 13, 2019 at 07:55:39PM +0530, Bharat Kumar Gogada wrote:
> > The current Multi MSI data programming fails if a end point is
> > connected with switch.
> >
> > Fix Multi MSI data, by programming data with required alignment.
>=20
> I have no idea what this means. If you are fixing a bug describe it prope=
rly
> and provide a Fixes: tag with the commit you are fixing.
>=20
Thanks Lorenzo for your time. Will add above details and re send.

Regards,
Bharat
>=20
>=20
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index 81538d7..36669c5 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -484,7 +484,7 @@ static int nwl_irq_domain_alloc(struct irq_domain
> > *domain, unsigned int virq,
> >
> >  	mutex_lock(&msi->lock);
> >  	bit =3D bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> > -					 nr_irqs, 0);
> > +					 nr_irqs, nr_irqs - 1);
> >  	if (bit >=3D INT_PCI_MSI_NR) {
> >  		mutex_unlock(&msi->lock);
> >  		return -ENOSPC;
> > --
> > 2.7.4
> >

Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB4C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 11:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77F2206DF
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 11:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="m1OU71/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfDDLsc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:48:32 -0400
Received: from mail-eopbgr810053.outbound.protection.outlook.com ([40.107.81.53]:11776
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729136AbfDDLsc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Apr 2019 07:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEPlsdMlPMysVpTVari4Jta/OvxzUtKOGd3e18hYqp8=;
 b=m1OU71/V+VrWUfus/CduU3FbU8e2zbUX+2qW7NCOyqXrRhPnQurNAs2bwtStpuuwJ3AvuKNNPcbbfewp7tlIYaQJJ7kXIsG834s95Z1vlbwMOjnThVtEYD8HvDjVMnGONofxD/pFaPDD66rPSmeRF3plyItzudXRJ3delXd6KYo=
Received: from BN6PR02MB2772.namprd02.prod.outlook.com (10.175.96.7) by
 BN6PR02MB3345.namprd02.prod.outlook.com (10.161.156.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Thu, 4 Apr 2019 11:48:24 +0000
Received: from BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::6cf5:d9:3347:151a]) by BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::6cf5:d9:3347:151a%11]) with mapi id 15.20.1750.014; Thu, 4 Apr 2019
 11:48:24 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: xilinx-nwl: Fix Multi MSI data programming
Thread-Topic: [PATCH v2] PCI: xilinx-nwl: Fix Multi MSI data programming
Thread-Index: AQHU2AAQCHDXCwr68kiV0ZLjhatkq6YnqKVQgAGD5wCAAtuSMA==
Date:   Thu, 4 Apr 2019 11:48:24 +0000
Message-ID: <BN6PR02MB2772E211BC97A597452D6806A5500@BN6PR02MB2772.namprd02.prod.outlook.com>
References: <1552304759-5394-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <BN6PR02MB2772BFC74C01857BA58FB5C7A5550@BN6PR02MB2772.namprd02.prod.outlook.com>
 <20190402160814.GA30068@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190402160814.GA30068@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b279957-daa7-4abd-d477-08d6b8f371d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR02MB3345;
x-ms-traffictypediagnostic: BN6PR02MB3345:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN6PR02MB33452C04FCA7BEA71BD0075AA5500@BN6PR02MB3345.namprd02.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(396003)(39860400002)(199004)(53754006)(189003)(6436002)(8936002)(99286004)(74316002)(81166006)(14444005)(5660300002)(81156014)(6916009)(256004)(52536014)(2906002)(8676002)(2501003)(102836004)(68736007)(6506007)(6116002)(3846002)(229853002)(54906003)(71190400001)(86362001)(14454004)(55016002)(4326008)(2351001)(5640700003)(7696005)(6246003)(9686003)(71200400001)(106356001)(25786009)(66066001)(476003)(486006)(97736004)(33656002)(105586002)(478600001)(76176011)(186003)(446003)(7736002)(53936002)(316002)(26005)(305945005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB3345;H:BN6PR02MB2772.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UyWLMtgMylzf9+JyOq0DDp7X3c+qUyxbH2hojc+XoBrSwOeYTXH12qyiE9xjKdzwqZxYgTgRg7IOOtu8L6XTwRAheHUiylJF0/R/96xmCjseoEC1565Qu1/4DNAHqs9BsUuC1nQrkisu9WyEF+U3Ik5pOiudqjj5JpzeEP1Vw3kOz/0CEygitfjJOfkc+HBAbB++6j81ewRdOaY/dfHEmqyolY+IeGctWJyjSOf4OarWI4X3uvxShwe5DGU9q/yXcJZHdNOzjsMohR/rMtxGandT2n0XM9fGpLJQJlNPM7nnjhKn54V2t8vtLT1hVlUgSG6q0xbcnWJUJwWDQivVYRm4jcEkCg6eM0kY5irGIBf2uQX1VE5Cx2L33vVOlRAeeGn/R+zDJT+Hp2Mi6HfQlk0fZek2+etOCeLqUnOCa3I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b279957-daa7-4abd-d477-08d6b8f371d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 11:48:24.3891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3345
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Mon, Apr 01, 2019 at 05:00:40PM +0000, Bharat Kumar Gogada wrote:
> > Hi All,
> >
> > Please let me know if anyone has any inputs on this.
> >
> > Regards,
> > Bharat
> > >
> > > The current Multi MSI data programming fails if multiple end points
> > > requesting MSI and multi MSI are connected with switch, i.e the
> > > current multi MSI data being given is not considering the number of
> > > vectors being requested in case of multi MSI.
> > > Due to this if multiple end points are connected and requesting MSI
> > > and multi MSI combination, the multi MSI data is ending up using
> > > wrong MSI data, which might be used by different device.
> > >
> > > Fix Multi MSI data programming with required alignment by using
> > > number of vectors being requested.
>=20
> I still do not understand what you mean I am sorry. An example is worth
> two thousand words, I would start with that as it stands this commit log
> does not provide any information on what you are actually fixing.
>
Hi Lorenzo, Thanks for your time.=20
Yes, will add an example to describe the problem.
=20
Regards,
Bharat
> > > Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL
> > > PCIe Host
> > > Controller")
> > > Signed-off-by: Bharat Kumar Gogada
> <bharat.kumar.gogada@xilinx.com>
> > > ---
> > > V2:
> > >  - Added more description of fix
> > > ---
> > >  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > > index 81538d7..36669c5 100644
> > > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > > @@ -484,7 +484,7 @@ static int nwl_irq_domain_alloc(struct
> > > irq_domain *domain, unsigned int virq,
> > >
> > >  	mutex_lock(&msi->lock);
> > >  	bit =3D bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> > > -					 nr_irqs, 0);
> > > +					 nr_irqs, nr_irqs - 1);
> > >  	if (bit >=3D INT_PCI_MSI_NR) {
> > >  		mutex_unlock(&msi->lock);
> > >  		return -ENOSPC;
> > > --
> > > 2.7.4
> >

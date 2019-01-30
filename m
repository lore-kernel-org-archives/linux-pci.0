Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD1EC282D8
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 17:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A32E21473
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 17:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="G3cbAPVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbfA3Rof (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:44:35 -0500
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:55174
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732527AbfA3Rof (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 12:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtabXhoOLem7y9THIY/E6ceuy5QU0QS50cnRDHjn4Tc=;
 b=G3cbAPVSEg/+8VhJdOr0SzAYWsv/0CTGhCMtEhcwbowlgf8IQ9zbWMUltK7333jlSv7sJze4JAHy3yxX5QHDbK6c7BZlQopm9H7t1hVXlgJdJfexYX7PuM5Ng2FM3NZELKLLktu2tk3/7eezZ9KYTAz5Y/81Hde4DNG7QBJJS3I=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6506.eurprd05.prod.outlook.com (20.179.43.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 17:44:31 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 17:44:31 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Thread-Topic: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Thread-Index: AQHUt/rA/dLikqWEmEaIytHIBNLPlqXGkyOAgAAJwICAAAX+AIAAEreAgAAFNYCAALluAIAAoq8A
Date:   Wed, 30 Jan 2019 17:44:31 +0000
Message-ID: <20190130174424.GA17080@mellanox.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205827.GM10108@mellanox.com> <20190130080208.GC29665@lst.de>
In-Reply-To: <20190130080208.GC29665@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:60::42) To DBBPR05MB6426.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6506;6:7o1T+xumdAiHJJQEuNs2JyMemFiVCsGVuYgr56NrpF28me4rRo0XdTyOccDulg8NPuSCBbfTy3GCJkafyzpIfG1q076Lm8cZ2RVknjpZqdIBdw2cAacnmxOS0zJU3jFR1EQ7oCdhSBceIHyFkvYGeVM1co83nMqsCiFgnB3apvXJYL2CpoZxpMA/4VOXQO4eTVnnPf2onbzB8vgw0IHJ30xYKsw4yDm+DmUP6Aqy7xSI7P2UWjoMCDXYZLtqBasucNJvoEgz9QE5A8De4PriX6gbrU75yzGJh/dGFIN5L6JLzAhLYr5W1kNs0p0z+rhbmXY2PSj1tbtjinJoJ3/H9CNyXrgZp/uoaPg8QQ0F4t/gt+458iiMpabJEwD7DWZmi9U4XwQvXw9VmG7OpyFcmlo8axjdAdRevUd/HATWJRz6mSBbb6yzPmXrLZNzEMp1pzm6ZiN//rZB1uUj+R2xhA==;5:Rkeek+TIFaY5Ofl+W42rGmLBLhzNbfdZSi3eF3ZolGiEQm4urds8EzCF1ze1qHIagOc15Hxs3YAjMtARHYMEejAkHWdoLvq8iqphqGNVzFbwe/JH+BRTAJSgsI9pRykxc2kKheDBePS4tRYGt89fvlOqZH3BEi5NXWKVd4rsTuKj3lzdwGh9uQ5n15Z22FbfChDK3dQR7tDHIDzRfVzKwg==;7:nFs7d3ifbSKtNL8KHmz7NeJxlcv8FKKX5cK5ucxvbmBHy83P+qlz+MPkPqHXruz1wLE8OwHx7leK7kg1OxvLqaglXwbsIkwLGD/QKXBnkb0tio+3kpcnXAcXHCKFvsOqzf8vjHv744m0/v86iEao7Q==
x-ms-office365-filtering-correlation-id: 3b15ce92-b7af-4bea-b247-08d686da96c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6506;
x-ms-traffictypediagnostic: DBBPR05MB6506:
x-microsoft-antispam-prvs: <DBBPR05MB65063224A790229E604086CDCF900@DBBPR05MB6506.eurprd05.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(2616005)(25786009)(7416002)(3846002)(316002)(8676002)(6116002)(81166006)(105586002)(81156014)(2906002)(93886005)(446003)(11346002)(102836004)(6916009)(4326008)(33656002)(8936002)(186003)(52116002)(305945005)(476003)(99286004)(76176011)(54906003)(7736002)(486006)(561944003)(26005)(217873002)(53936002)(66066001)(1076003)(6436002)(71200400001)(229853002)(6246003)(86362001)(97736004)(71190400001)(68736007)(6486002)(6512007)(14454004)(6506007)(106356001)(478600001)(386003)(36756003)(256004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6506;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ya5zZoENxkBXzzxhlK/yFwg3NzSUxoZ5vHX/bGW4YvUssmxqTYdaGXs4myCnD1rbPnkqc/RMEec8lDmVuitOJWeqHFp/0w4m6TVNLQqFpQ6GBN2OAwBkxtbA16m56WqCeKIR9uBF7d4ZvbjoOsx0Gns+lzTKzIdNnXvbvgI4KpQWh9Frh1C60dbtfinYRvM9KTkMHx/UjXek7ZrMg73aNPsa6oS1ThJj+HZ0taHF40eoJqLgL7cNjmnZGwHMFyEIqICugoSvLXW/nshUttpvK3HXPBDzmeUGqr7mc5gFaNUh0qIIwlq0TbzQM4ykj09W5BeadhPD1eaW7tDMwsqIsyyL4RCcOaF9j6tA6ZFyA1MopGdeEnBEugrSvF3cVS/VhO+r17u99+RqdfZ9iQ7lhFRaAtuwC2g7g5+aXsplPTc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F849EDC110592049BC19081D2ED8EABB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b15ce92-b7af-4bea-b247-08d686da96c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 17:44:30.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6506
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 09:02:08AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 29, 2019 at 08:58:35PM +0000, Jason Gunthorpe wrote:
> > On Tue, Jan 29, 2019 at 01:39:49PM -0700, Logan Gunthorpe wrote:
> >=20
> > > implement the mapping. And I don't think we should have 'special' vma=
's
> > > for this (though we may need something to ensure we don't get mapping
> > > requests mixed with different types of pages...).
> >=20
> > I think Jerome explained the point here is to have a 'special vma'
> > rather than a 'special struct page' as, really, we don't need a
> > struct page at all to make this work.
> >=20
> > If I recall your earlier attempts at adding struct page for BAR
> > memory, it ran aground on issues related to O_DIRECT/sgls, etc, etc.
>=20
> Struct page is what makes O_DIRECT work, using sgls or biovecs, etc on
> it work.  Without struct page none of the above can work at all.  That
> is why we use struct page for backing BARs in the existing P2P code.
> Not that I'm a particular fan of creating struct page for this device
> memory, but without major invasive surgery to large parts of the kernel
> it is the only way to make it work.

I don't think anyone is interested in O_DIRECT/etc for RDMA doorbell
pages.

.. and again, I recall Logan already attempted to mix non-CPU memory
into sgls and it was a disaster. You pointed out that one cannot just
put iomem addressed into a SGL without auditing basically the entire
block stack to prove that nothing uses iomem without an iomem
accessor.

I recall that proposal veered into a direction where the block layer
would just fail very early if there was iomem in the sgl, so generally
no O_DIRECT support anyhow.

We already accepted the P2P stuff from Logan as essentially a giant
special case - it only works with RDMA and only because RDMA MR was
hacked up with a special p2p callback.

I don't see why a special case with a VMA is really that different.

If someone figures out the struct page path down the road it can
obviously be harmonized with this VMA approach pretty easily.

Jason

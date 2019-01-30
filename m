Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD63C282D0
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 04:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF91220857
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 04:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="IiKv+TF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfA3Ead (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:30:33 -0500
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:53569
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730022AbfA3Eac (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 23:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZ7dGrVrH4fix/RckSJysHNQQzMdwLNZNKxx2zgBqog=;
 b=IiKv+TF4ExYJhrimZaR5omiiTbTu56jhpIZXxcdLcUxjtbyQO7jjbMiTcFMz64nrWh8r5U5KRQvLnX6JHx2qeROXK3EBtsfXZlAhuswr/MBeWQeoJMSIanE0GobTD3/djssHDpZU8i/JM8Z3Zab/YhbkjthSoWZfxmHWHFY68AY=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6490.eurprd05.prod.outlook.com (20.179.43.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 04:30:28 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 04:30:27 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Thread-Topic: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Thread-Index: AQHUt/rA/dLikqWEmEaIytHIBNLPlqXGkyOAgAAJwICAAAX+AIAABQ6AgAAJYICAAAV0AIAAIHwAgAAYiwCAAElEAA==
Date:   Wed, 30 Jan 2019 04:30:27 +0000
Message-ID: <20190130043020.GC30598@mellanox.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <20190129195055.GH3176@redhat.com> <20190129202429.GL10108@mellanox.com>
 <20190129204359.GM3176@redhat.com> <20190129224016.GD4713@mellanox.com>
 <20190130000805.GS3176@redhat.com>
In-Reply-To: <20190130000805.GS3176@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:101:1f::21) To DBBPR05MB6426.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6490;6:WNVa5kmtNYhrQecH5NtzMyEqe9Mj7Ofw9RtBgyxD5sVzCYc0J3dxq0OEgL6P0DRivVOwlAA8OT2Pnx4yiKq99O9pjw4CIzKKglcF6g8xYnLaciZfm/JfJ83mQ2xPNbPnh2wKstmfE/WNODNshIZS8hnfZQlQdIj+vo1PBFvIRcZFhNJq8UMO//3gCn7bWFpOdhQaq//ZzI9+JhfYCzxeWSC5a9unoXUhfqSVHBmlY8Jr4aoLJdac7mxiB8YuGLMSy42cuHlrAU90huUlFl9GMztnzyTKp88NiT1XjaqBFcB5YJrWTvyKPBvKZzZXJCTotVKx4HrI5bvOhgrmKO4wOtHcG1KYDXFymmpcyVjsjxvFPApi5Gk4NH72Dt00cKn7eSZ9axckgAvBUMbP220KHdD5AdSrboCNwwbO5vPNlR+v+0sqh0Ti2POHmDMj0Soia5l7wYzjDPJW9+3JmLdGNQ==;5:EajzuQwWBqn2oE2IZNKS12h0FCcYr8hQpMe23XCfOZSNtgSCZnA0IheuKb6Ta6aOobTYV+OiT0lGA0teu0tvyWV7SCm42mLQ69apAFQdedaZPeybVVr4rFl82hDcD739Wln5CzkEUGq/LN8M4VU7ds5FyJLBXCKWOkjGl2OwrOBW5kfFQJS7bVlu95WBVbTURHJFQKRMOaGeLHkQAqeYuA==;7:MS9/5eCcjLlpqAUtk2YC+x3ULHFTZdstvpWiHm1Ztfjjwutaog+a9HdPyxd3ESPylpySemRi6fbV81XWoNbCkAugYi06Allg4VwgSTKWh5Gsi9BU85Xya66ueSZpPvIL6NxiSAv3cR/JSOwDmzqjIQ==
x-ms-office365-filtering-correlation-id: 69aa6100-69ea-4065-8f44-08d6866ba8f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6490;
x-ms-traffictypediagnostic: DBBPR05MB6490:
x-microsoft-antispam-prvs: <DBBPR05MB6490E6A61E114209483BFF08CF900@DBBPR05MB6490.eurprd05.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(189003)(199004)(4326008)(6916009)(81156014)(36756003)(68736007)(33656002)(106356001)(6486002)(6512007)(229853002)(53936002)(6436002)(105586002)(99286004)(93886005)(2906002)(6246003)(25786009)(71200400001)(71190400001)(97736004)(316002)(54906003)(1076003)(486006)(256004)(217873002)(478600001)(186003)(102836004)(81166006)(14454004)(7416002)(8936002)(26005)(386003)(3846002)(6116002)(476003)(7736002)(6506007)(2616005)(305945005)(446003)(11346002)(52116002)(66066001)(8676002)(76176011)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6490;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q2PIQOHUZ507shIRaCG+bIPhKbAiXcpwhGrgHPLttJJwJ0HcZnzmWZkLOlbXrj+fzKTBhRIOwRIgtLMQ3Oemajr8yAwGWEM8mYvs+d4FHqKVNO+bSRgce9USmr9hZNAAyd7MJZ637D3LRREjASk6L0vjUmZfap3esfAEaQEq9BCHaUuFxN7BEbHxGlarIDQ54En5waxRholjtyc3v5U30J1/JFirDI9zZ2C3Q3W979st8Gc7lsGLZwiD4BQ1FvMNq/VpK6tIqgrzPeJKesIyR+isgYNXAdzgHKcbMbE1G1pIPTjrurqiBkAr1xFkLdXrt1FehSwZu/zHJjm58pwonwJSrg0+h8atEWY1sNnxBcjEeUWtaV32v6alH/FvkdR8YamlBhcqnisX9VIvY+Jri2mcLCICdu/rf5MNoSMXs18=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <653ABEE3FDEFC347BC03CDDE1CA5AC65@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aa6100-69ea-4065-8f44-08d6866ba8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 04:30:27.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6490
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 07:08:06PM -0500, Jerome Glisse wrote:
> On Tue, Jan 29, 2019 at 11:02:25PM +0000, Jason Gunthorpe wrote:
> > On Tue, Jan 29, 2019 at 03:44:00PM -0500, Jerome Glisse wrote:
> >=20
> > > > But this API doesn't seem to offer any control - I thought that
> > > > control was all coming from the mm/hmm notifiers triggering p2p_unm=
aps?
> > >=20
> > > The control is within the driver implementation of those callbacks.=20
> >=20
> > Seems like what you mean by control is 'the exporter gets to choose
> > the physical address at the instant of map' - which seems reasonable
> > for GPU.
> >=20
> >=20
> > > will only allow p2p map to succeed for objects that have been tagged =
by the
> > > userspace in some way ie the userspace application is in control of w=
hat
> > > can be map to peer device.
> >=20
> > I would have thought this means the VMA for the object is created
> > without the map/unmap ops? Or are GPU objects and VMAs unrelated?
>=20
> GPU object and VMA are unrelated in all open source GPU driver i am
> somewhat familiar with (AMD, Intel, NVidia). You can create a GPU
> object and never map it (and thus never have it associated with a
> vma) and in fact this is very common. For graphic you usualy only
> have hand full of the hundreds of GPU object your application have
> mapped.

I mean the other way does every VMA with a p2p_map/unmap point to
exactly one GPU object?

ie I'm surprised you say that p2p_map needs to have policy, I would
have though the policy is applied when the VMA is created (ie objects
that are not for p2p do not have p2p_map set), and even for GPU
p2p_map should really only have to do with window allocation and pure
'can I even do p2p' type functionality.

> Idea is that we can only ask exporter to be predictable and still allow
> them to fail if things are really going bad.

I think hot unplug / PCI error recovery is one of the 'really going
bad' cases..

> I think i put it in the comment above the ops but in any cases i should
> write something in documentation with example and thorough guideline.
> Note that there won't be any mmu notifier to mmap of a device file
> unless the device driver calls for it or there is a syscall like munmap
> or mremap or mprotect well any syscall that work on vma.

This is something we might need to explore, does calling
zap_vma_ptes() invoke enough notifiers that a MMU notifiers or HMM
mirror consumer will release any p2p maps on that VMA?

> If we ever want to support full pin then we might have to add a
> flag so that GPU driver can refuse an importer that wants things
> pin forever.

This would become interesting for VFIO and RDMA at least - I don't
think VFIO has anything like SVA so it would want to import a p2p_map
and indicate that it will not respond to MMU notifiers.

GPU can refuse, but maybe RDMA would allow it...

Jason

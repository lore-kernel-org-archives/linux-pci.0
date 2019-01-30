Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C31DC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9D920989
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="OP2/V+KT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfA3THC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:07:02 -0500
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:10304
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbfA3THB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 14:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYn1XKm1zC9bDOzSst3l2VKeBYjL91+5rAsvqaE7EmM=;
 b=OP2/V+KTnaUOBZ0/4R+nEfJW7Nc0Ok8Z3R7GpZo14zqMhk1sO/61TATlCvz3dzIEBJ4ZF9JeZ9flWYN3hhSZnI0igWUdBiXqVnPy+C/09qw6vF0tdRqBHR+SGIIXOVFzTp4t50jfLPqNz1Vu4TbTO73rysRKa4ZTSVBEboaCLss=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DB7SPR01MB0037.eurprd05.prod.outlook.com (20.178.85.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 19:06:57 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 19:06:57 +0000
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
Thread-Index: AQHUt/rA/dLikqWEmEaIytHIBNLPlqXGkyOAgAAJwICAAAX+AIAAEreAgAAFCQCAAAk3gIAABX0AgAATFYCAAA25AIAAGRqAgAAykICAAD3dAIAAukqA
Date:   Wed, 30 Jan 2019 19:06:57 +0000
Message-ID: <20190130190651.GC17080@mellanox.com>
References: <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
 <20190129205749.GN3176@redhat.com>
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
In-Reply-To: <20190130080006.GB29665@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0069.namprd22.prod.outlook.com
 (2603:10b6:301:5e::22) To DBBPR05MB6426.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7SPR01MB0037;6:XJyFTbwXf5/aSNktsqWWkl19JOZ9LIUJ51o1Pbn4P2yNzU1PRRcym1sVmglvAkyZGif+2ygQEmI3SbDUH5rTgdoSZbXeq8mOaX2FKhvCJUdF+mAUDGo1wCDLcoUtFgvzm1TvYYCDjJqtCnMB5UNa3VYz9pJVl+6Xd5/SRwne3ernFm/4lPFiKwYhzPTMH3Upz3bw1pYD2eJ5KLxEcE+Ne96T3ihocdKNZf51vNjKCAEBTWjTwKe0lujw/5Zb95MGmzZQ8Dnqw+2YraoF8S1weXXxPUK8xI5eA6a3sweBXs1Ym4KrfmEz+XlApQVKPQ1hPmHEVH29KPVy+R6nCmTlseYU21u6jeKdnXDi//DNEmTVrPOmLhVW8whhQIranJSvBPPSoRBFznBnuREGn9x7GCqStSa1FBEz4vpiCWkNVIJIWx8tJeoIm+3wwoBB25V4L88z51sRH9pjlXY2FFVfOg==;5:ik+XTq9JgLZH0gjb687ix2cYWvuBQWHaLUJ+QnclzyVL0REpOwXrmsWFGSlUnofYoL0E23XAucIB37hfA+Tar3avErhFah2N4lOXwAESU6amwrFlDxan0jSRUsc9MkCdXtCmgWRDuUN3RayXIMK86PsL8fmk7zvxd9FkJgGMWgcK5HSCIU2rm19NNgqefrMxEuYe6YC/JbQD+GE+Xj2dTA==;7:uB1KVQOEaWWxyx6JTR0m0g15sYtubSoy9YbTndOS2iymYR58Qm4QiSwdZIZm/4VmFBpCNb5WDaRNSYhqGBM26J2YlFszrgbwXkqj8cSnCvLvSRaEe5sBB726IwH3JxaJiIpy/VEs691iU+Lfwx5HYw==
x-ms-office365-filtering-correlation-id: cee10910-4fa4-4cd5-8c13-08d686e61ac7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7SPR01MB0037;
x-ms-traffictypediagnostic: DB7SPR01MB0037:
x-microsoft-antispam-prvs: <DB7SPR01MB0037B3A588E6A84C9A15E89BCF900@DB7SPR01MB0037.eurprd05.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(217873002)(2616005)(186003)(486006)(68736007)(11346002)(476003)(97736004)(229853002)(2906002)(36756003)(93886005)(7416002)(4326008)(86362001)(8936002)(256004)(446003)(305945005)(7736002)(6916009)(81156014)(81166006)(26005)(99286004)(8676002)(33656002)(102836004)(6486002)(6436002)(386003)(6506007)(71200400001)(71190400001)(6512007)(52116002)(105586002)(478600001)(53936002)(14454004)(25786009)(54906003)(6116002)(76176011)(1076003)(3846002)(6246003)(66066001)(106356001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7SPR01MB0037;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ebJec01bGV1042sVk3Qs2ISgeKGExakq+gjNBh3UI9Lvk4ngeZE8+LWAAowa5HKuIdWRx7rY+5ya5wyK8+d2b7KVzKD98ajh+B2pZhQmi/AfZbAsCywAylVHgG43ESjO/w9+b0pez0YrAp8K9R9twdToAiL6jARapx8pThQULDG5pgWFdz41hwc/u0UUs1F9KFq/QPKipYtzkPvoe/9pCGYpBlDK3+C1cauJBWxVu2Kfq5Rh/dCqeX7XNHRQxR98LzdR19ykGuK4zoxsOSvS6DrlLJ9WxQ05oc8YfD2sq3JIQP0RQKBduVEn9q+qhWpE3LdKcvBuB3Swl6Pbfkz5MHGnAg0cQaEeLClemKaggiOJvnNh6xl3m3giHPWjCJdTxisM6LbGlxoQH9gfrW6kO0r/F/31pJdaiHcTFUqbsUk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D5475048F79FD84A8C1E7231DA08336B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee10910-4fa4-4cd5-8c13-08d686e61ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 19:06:56.9369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7SPR01MB0037
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 09:00:06AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 04:18:48AM +0000, Jason Gunthorpe wrote:
> > Every attempt to give BAR memory to struct page has run into major
> > trouble, IMHO, so I like that this approach avoids that.
>=20
> Way less problems than not having struct page for doing anything
> non-trivial.  If you map the BAR to userspace with remap_pfn_range
> and friends the mapping is indeed very simple.  But any operation
> that expects a page structure, which is at least everything using
> get_user_pages won't work.

GUP doesn't work anyhow today, and won't work with BAR struct pages in
the forseeable future (Logan has sent attempts on this before).

So nothing seems lost..

> So you can't do direct I/O to your remapped BAR, you can't create MRs
> on it, etc, etc.

Jerome made the HMM mirror API use this flow, so afer his patch to
switch the ODP MR to use HMM, and to switch GPU drivers, it will work
for those cases. Which is more than the zero cases than we have today
:)

Jason

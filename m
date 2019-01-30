Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC1C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 20:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980F82184D
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 20:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="D7I9jHaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfA3ULZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:11:25 -0500
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:1276
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbfA3ULZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 15:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/d4iWFDvqxqaPKHJn/2sW6NH6J6175ArJyoM+4mbM0=;
 b=D7I9jHaI3NCw0GEkjda4NjPmlORlalKVDzuoenMAhNXntmX2r9fqvQs/nEjYwmptnvlztTlPxSt8lGr1xAiW2Vj+fKjdDu8N0bqLmaRHA6U5BS1TIVKhzPFevjiz5eKOI/8xYq5QnTmayV17KH6u4+S0Gfmiy7xmEmwyMYIEj7s=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6361.eurprd05.prod.outlook.com (20.179.41.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Wed, 30 Jan 2019 20:11:19 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 20:11:19 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
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
Thread-Index: AQHUt/rA/dLikqWEmEaIytHIBNLPlqXGkyOAgAAJwICAAAX+AIAAEreAgAAFCQCAAAk3gIAABX0AgAATFYCAAA25AIAAGRqAgAAykICAANmWgIAAG8YAgAAHLwCAAAROgIAABioAgAADIQA=
Date:   Wed, 30 Jan 2019 20:11:19 +0000
Message-ID: <20190130201114.GB17915@mellanox.com>
References: <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com>
 <bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
 <20190130185652.GB17080@mellanox.com> <20190130192234.GD5061@redhat.com>
 <20190130193759.GE17080@mellanox.com>
 <db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
In-Reply-To: <db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0124.namprd04.prod.outlook.com
 (2603:10b6:104:7::26) To DBBPR05MB6426.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6361;6:q3s3M782hLDrroygxK1QdL8JgvtOb2ovBfVLRyNVEdeo8F+j3LBQMtXhrHY9hC5yBKYakn1tJiwEtVA490ni8lsNcM+I2+rrd3myN/yQi/NEu7haP47/fIQ8qiNBg6LGxS4KJFlCezthLVj7mq+tVICXV2SPjlApmdJXdH4kIM5nTi4yaMUzzEL6R+DEZfx94gT3M01E7PeqPJbPqa3T4bK2V0AF+VDXNC+gHI2foLeBjfZ91MSuU2IiCctysHRTy1coI8Pm2BA/FMWQrpVgLjoEjDTm6UlXlW/NL1kjr2PI9rpNdrZMgqLmi/aNHFZ/xgoW+qzBqbMfx5EHRKo8fnMTu58Z1TSEnscXLa+eV9IGUWbHkcSkA3IC5mjXkaaDvzvZJIZ8TmL8eFTJ7kS1IUyp8V69pPgtc0GK7MCrT0t5/wwJMrtVLSYmQaarGl13Bbp9DqHc3muiuAFRgn7dbg==;5:McnnPWHU21mEfNwQhFhiX4yFo4qfJuC313Uu4NkFFZBm4KZmYdIVwHGL0ZS8+7ApfVWp5PkO4VYTbgBKcbdIfGLda7zhw8OEXktmSVBtuvPHL29JWQSqJaQjEBJx2OGfGWb1IM7KHz9n2mTxuIC+lWn8LpO+WKBZZSk2wwpso3Swi4OX/Gjsv7owQubBJ9T1r1yUM907M1jF5TVANns5Uw==;7:5fOJhDjEv9CjOZ8Dmm9/SrNhFa+yDQmrp39zdSfBoQdtAC/vW+FGHLAZ6+yUmnVL1BzwW3e1FcCmnFM6twATPBPHaFQnvNu+N29bQ2CUWlcCVu8ocPoFj/4Qnimp4y+9HURs6o/h6iUTrr2b+R3bhg==
x-ms-office365-filtering-correlation-id: 2207f1b2-408e-490f-d669-08d686ef18cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6361;
x-ms-traffictypediagnostic: DBBPR05MB6361:
x-microsoft-antispam-prvs: <DBBPR05MB63618885D8E355AFC9403F41CF900@DBBPR05MB6361.eurprd05.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(105586002)(106356001)(476003)(99286004)(66066001)(25786009)(2616005)(6506007)(486006)(386003)(33656002)(217873002)(7416002)(4326008)(6512007)(93886005)(2906002)(446003)(11346002)(186003)(36756003)(6436002)(256004)(71200400001)(6916009)(6116002)(8936002)(54906003)(102836004)(81156014)(26005)(97736004)(76176011)(52116002)(316002)(7736002)(53936002)(86362001)(3846002)(229853002)(68736007)(305945005)(1076003)(478600001)(6486002)(71190400001)(6246003)(8676002)(81166006)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6361;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0zN5CTWraRYIsQnw7ZFo6j+WCoIOOBIC6WfvLGY4EVz3idYXhWd+OAp+c5xDeX8wAcpOdKAVIBhrPKQzYv5qkAki5KOJgsQKfHvsdD+yIrnKGhtMEW++qSBtVCt+yv13BhHBYUD50+5c0HNBlFD2+f5kJp1oqtnE1cr9ZavSJAJJyxSZwpSQjpLwQhp5mRKm6Vu99Cv7uwMOBjyFNVE3TjqB81IdDNFBWjXmowN9qurBGAkjV0AxtT7t2R8l0kG+zyWo/weJKdetun3zetsGICe5h8PXiN/WEEyVaQ/Wm+TUDKaTltfLrMkOIJ2I0uxt3JJNDNixcChsEJCfvjiwsphHJv4EPw10SZRT9h5gy7ePsa6HDsqWofqA6Ux0SP7Zi0waJB+OM82jtU/jy3Nq9Lb96mVYEBi0lvTCkEQ1/FA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D7345561BF5804A8CD6EDF49CF98303@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2207f1b2-408e-490f-d669-08d686ef18cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 20:11:19.0932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6361
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 01:00:02PM -0700, Logan Gunthorpe wrote:

> We never changed SGLs. We still use them to pass p2pdma pages, only we
> need to be a bit careful where we send the entire SGL. I see no reason
> why we can't continue to be careful once their in userspace if there's
> something in GUP to deny them.
>=20
> It would be nice to have heterogeneous SGLs and it is something we
> should work toward but in practice they aren't really necessary at the
> moment.

RDMA generally cannot cope well with an API that requires homogeneous
SGLs.. User space can construct complex MRs (particularly with the
proposed SGL MR flow) and we must marshal that into a single SGL or
the drivers fall apart.

Jerome explained that GPU is worse, a single VMA may have a random mix
of CPU or device pages..

This is a pretty big blocker that would have to somehow be fixed.

> That doesn't even necessarily need to be the case. For HMM, I
> understand, struct pages may not point to any accessible memory and the
> memory that backs it (or not) may change over the life time of it. So
> they don't have to be strictly tied to BARs addresses. p2pdma pages are
> strictly tied to BAR addresses though.

No idea, but at least for this case I don't think we need magic HMM
pages to make simple VMA ops p2p_map/umap work..

Jason

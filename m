Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED04C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F15218D2
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="BG2ngckA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfA3Xad (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:30:33 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:39328
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfA3Xad (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 18:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkrI65YSQkqMDp5eITnkz7Pyjb8BFrmH3NI4zh+OjiY=;
 b=BG2ngckA3U/fu29wFBUSI06McqU92VoLkoftpkm9+9TfOfobHJk8zMUKDrhf1/031pryexZffF2ayXRjuP6C3zxt1R6FPl4Z9NSw51CmCX+p2HI2E62adW7qgW3FdMskzsNmW29ZuoFQ6IXsiqCjMcTPAvIHwdz38DP3hRgOgiI=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6330.eurprd05.prod.outlook.com (20.179.41.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 23:30:27 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 23:30:27 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Christoph Hellwig <hch@lst.de>, Jerome Glisse <jglisse@redhat.com>,
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
Thread-Index: AQHUt/rA/dLikqWEmEaIytHIBNLPlqXGkyOAgAAJwICAAAX+AIAAEreAgAAFCQCAAAk3gIAABX0AgAATFYCAAA25AIAAGRqAgAAykICAAD3dAIAAukqAgAAK3wCAAAOzAIAAEXyAgAANnoCAABFLgIAACqiA
Date:   Wed, 30 Jan 2019 23:30:27 +0000
Message-ID: <20190130233021.GD25486@mellanox.com>
References: <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com> <20190130080006.GB29665@lst.de>
 <20190130190651.GC17080@mellanox.com>
 <840256f8-0714-5d7d-e5f5-c96aec5c2c05@deltatee.com>
 <20190130195900.GG17080@mellanox.com>
 <35bad6d5-c06b-f2a3-08e6-2ed0197c8691@deltatee.com>
 <20190130215019.GL17080@mellanox.com>
 <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
In-Reply-To: <07baf401-4d63-b830-57e1-5836a5149a0c@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0005.namprd22.prod.outlook.com
 (2603:10b6:301:28::18) To DBBPR05MB6426.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6330;6:FO6cZ7ml1hQQ881Cww0x+E6DnXIiYnwHhnWzLeazT5tDISxxG3ZGpbWCSONWjglc5rOedRuXCrjagt/TTwS77n3Dh0Wv6jfCYIpa7lMKSR2jPgH8X43fNCZ9dyaNkJN7YeiwulhNE5Q2JRPnSmBzijuasTi6JfnWLnQutBDz7PGKZbA6D+NXjEYGHzvGeCDtimFnOKl3THyGkLJETSPYQUr275eAHYsVM2Irz8g79CvS1+bsNzrHW5CQAWrrX1wJiHhA6bYKWlQowcaRW04YxdDBvyXwyiMqYMhCLzgoVGV5G4NlQGXtZcztCeg0kUKBZ5F5elvB5WxLCCokUfBSo2OeEFUwEzuExD+PnY8ZxnNasyuehvM+qsQbKg1skg91QHrs7GOia1kBhK4BqAHGJNqzrpScgW9ImHT8VDwWjdqIH1FAs3g3/txbMWX92xhs5YZXQ/8ngzBMxnWtTcpSHA==;5:RCErp/n031cdMsQ/QDm3tOm0vJ77MFW4qaNC4EpygSkNYdWdkjYaSnJkfmhlALKhmhbaEcUpchF0iGqw+gcUe65kUkY5a73lvf4vVxXGlZvWozCrQr62XZ5fxi5E2cCIK1YEmD30PvOaRH+MT3FSMkyigBkwLArFyqKQtVe5B9p9/pGuBlFk7xMfxZFVfoYL7wPVOffZ3T3ES2nRLIw+Cw==;7:IKhYBrlAUW+b4PqifcfHNDW9Fp2rIpNeSWlxniW5AfsEjPRbOLBQDsShpF/3DGe34Bj6suBfS3X7EexICeTJNgBNQMP2RvwCZZzWSB+xc5b9ghDPJFyOcBiV9ErRQ5NXkUqfmz5XwGHtw36EcwJJ0w==
x-ms-office365-filtering-correlation-id: 8b7fc471-867e-471f-6161-08d6870aea8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6330;
x-ms-traffictypediagnostic: DBBPR05MB6330:
x-microsoft-antispam-prvs: <DBBPR05MB6330F6633BB35F3E4D456832CF900@DBBPR05MB6330.eurprd05.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(486006)(446003)(316002)(2616005)(6436002)(476003)(102836004)(97736004)(6506007)(11346002)(26005)(4326008)(386003)(2906002)(6512007)(54906003)(99286004)(36756003)(86362001)(14454004)(52116002)(6486002)(229853002)(7416002)(71190400001)(53936002)(71200400001)(478600001)(8676002)(81166006)(66066001)(33656002)(105586002)(81156014)(68736007)(3846002)(6116002)(8936002)(106356001)(6246003)(1076003)(53546011)(76176011)(93886005)(305945005)(25786009)(217873002)(7736002)(186003)(6916009)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6330;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hj/dmzC7U+OSVRBT/MoeeEdhCEO9wjaPT0CXw/bezhgAkgRq+lxA6z/e6OIn9kNEsJcTFsRS6FnxXuZePjMVL0K96+pgomWq8nyQ3MS7vt+UWS20pjtKvkSXc8Zas/BqgbQPxsPptlAb2a0gMXE8xupBR+ONlLeWbrdBEAUcy2a4/UTm5vCJR+HFuNbQy6VeEdEJKffjYn1ph415C6dsQbRhc6JWO/GNgjE9fI6+KuMnlNFAgtCG/EBJn2h9fZ0jz8yFTUgwHZyqwYQ7xtomV92x8IZT8LDN/W48+MXUya9Md4T6Xhg8uGcoUNOvUM/LimIqbxXAxgMWmPDllYpyKHSE1lwpCHACmvs/59jaJ9eEHWHPgWgswMS+z4cae7NZR+2FGdtqGbSz0mNz/2NEquFAdc1+qDlHUM5fII4mhT0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95781CBA468AA44CA09FE9E7B761A943@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7fc471-867e-471f-6161-08d6870aea8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 23:30:27.3975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6330
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 03:52:13PM -0700, Logan Gunthorpe wrote:
>=20
>=20
> On 2019-01-30 2:50 p.m., Jason Gunthorpe wrote:
> > On Wed, Jan 30, 2019 at 02:01:35PM -0700, Logan Gunthorpe wrote:
> >=20
> >> And I feel the GUP->SGL->DMA flow should still be what we are aiming
> >> for. Even if we need a special GUP for special pages, and a special DM=
A
> >> map; and the SGL still has to be homogenous....
> >=20
> > *shrug* so what if the special GUP called a VMA op instead of
> > traversing the VMA PTEs today? Why does it really matter? It could
> > easily change to a struct page flow tomorrow..
>=20
> Well it's so that it's composable. We want the SGL->DMA side to work for
> APIs from kernel space and not have to run a completely different flow
> for kernel drivers than from userspace memory.

If we want to have these DMA-only SGLs anyhow, then the kernel flow
can use them too.

In the kernel it easier because the 'exporter' already knows it is
working with BAR memory, so it can just do something like this:

struct dma_sg_table *sgl_dma_map_pci_bar(struct pci_device *from,
                                         struct device *to,
                                         unsigned long bar_ptr,
                                         size_t length)

And then it falls down the same DMA-SGL-only kind of flow that would
exist to support the user side. ie it is the kernel version of the API
I described below.

> For GUP to do a special VMA traversal it would now need to return
> something besides struct pages which means no SGL and it means a
> completely different DMA mapping call.

GUP cannot support BAR memory because it must only return CPU memory -
I think too many callers make this assumption for it to be possible to
change it.. (see below)

A new-GUP can return DMA addresses - so it doesn't have this problem.

> > Would you feel better if this also came along with a:
> >=20
> >   struct dma_sg_table *sgl_dma_map_user(struct device *dma_device,=20
> >              void __user *prt, size_t len)
>=20
> That seems like a nice API. But certainly the implementation would need
> to use existing dma_map or pci_p2pdma_map calls, or whatever as part of
> it...

I wonder how Jerome worked the translation, I haven't looked yet..

> We actually stopped caring about the __iomem problem. We are working
> under the assumption that pages returned by devm_memremap_pages() can be
> accessed as normal RAM and does not need the __iomem designation.

As far as CPU mapped uncached BAR memory goes, this is broadly not
true.

s390x for instance requires dedicated CPU instructions to access BAR
memory.

x86 will fault if you attempt to use a SSE algorithm on uncached BAR
memory. The kernel has many SSE accelerated algorithsm so you can
never pass these special p2p SGL's through to them either. (think
parity or encryption transformations through the block stack)

Many platforms have limitations on alignment and access size for BAR
memory - you can't just blindly call memcpy and expect it to work.
(TPM is actually struggling with this now, confusingly different
versions of memcpy are giving different results on some x86 io memory)

Other platforms might fault or corrupt if an unaligned access is
attempted to BAR memory.

In short - I don't see a way to avoid knowing about __iomem in the
sgl. There are too many real use cases that require this knowledge,
and too many places that touch the SGL pages with the CPU.

I think we must have 'DMA only' SGLs and code paths that are known
DMA-only clean to make it work properly with BAR memory.

Jason

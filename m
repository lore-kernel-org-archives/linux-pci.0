Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780DC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 23:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985C12147A
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 23:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Y9s1WZWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfA2XDI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:03:08 -0500
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:35872
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728224AbfA2XDI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 18:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRCEhY1aVU7aCRk7gwI5XUlpl7fXWIkzBIjSfI9zNgc=;
 b=Y9s1WZWeFidSPQoPs8EySuRkQyoFVSXWCyVpjyUbeb5XlMbk1aZWnfsH8WELw8JmAj7ti8Nascx2OjJNNPGhd5MGxir6F+n4Ln5SJQ2JpTelV5aSet3v2IrS1dzQ2bZ+HqNmgmGQ1WIfYtr9mvuD7cDg+WyCAqbjgaqyKmlL2hk=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6587.eurprd05.prod.outlook.com (20.179.44.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 23:02:25 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Tue, 29 Jan 2019
 23:02:25 +0000
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
Thread-Index: AQHUt/rA/dLikqWEmEaIytHIBNLPlqXGkyOAgAAJwICAAAX+AIAABQ6AgAAJYICAAAV0AIAAIHwA
Date:   Tue, 29 Jan 2019 23:02:25 +0000
Message-ID: <20190129224016.GD4713@mellanox.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <20190129195055.GH3176@redhat.com> <20190129202429.GL10108@mellanox.com>
 <20190129204359.GM3176@redhat.com>
In-Reply-To: <20190129204359.GM3176@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:301:60::17) To DBBPR05MB6426.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [64.141.16.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6587;6:WtWYP2bPjOw7uCYqevyGXvuXPqGrqF+j+zhPWiYSF5nTPElvy+YBHxIOmi1rgYGZb6S8tYOhZd14g1MdGuHhL16eCPE7n15EG676EVmdUXPrxdbL9SA3wUSTUqYFtEweep1x0rC3MXVa6TmbznAgBS4C8AI0CMmHt20nngy9fMKAqCslvqkzJMk0mBc9j+WrgTDX0xPGQBk3/vQSKjK7lZa+J6D5qcBBf2sbPUQu84ErkhfHhBlE4lvVAFyKM3GTE12O62R94j9pYwlm7XtWKauyQwjUUZqnQAphM2fYkzllCtwWb7X2dqZGFI/giAfqaN8HEMBDnH4Mzm0HX8QAbSbEbmafxRCjiwjh1E2y7aa+5DTpu25ifCXx+bEpjI9Pd/sgV6Rqki7SJJCfZnhpzEpRi1eo4fsLkf00mFhfIUiVfnxk7CWv7BEXk4zvvutqW0QnNiHV+r/4NOmSyQ/MuQ==;5:76jjAcaKJ4Hp3sr6+v/a1r3aAdRDS78F/qxqk6J9Y1D+EEFlxlEoi4HxG8R/r6/edwkLXBb9tilQzVJgbdfDcJhKn6W7p3TliaUtQcWsnFv6YwZ3uF123tmnjLHPTonbLYAJZjJ7STwrNiR9nVQsglz/edKO6Bvs6jeovRZ46GV6jWZCGoSLyU8E5vPds8GY64C8IhxWUBaI3eQjeBF8OQ==;7:zqulXEzKuHiKOxER43Qo6Ae/lkRzjrjsqrzA5bnFASp0o4lYGwb/6aaAFejrR9lK3JQq9oFeAy3xYUE5aNctkbkIFOB/LGNnhL+eqljFmJ+fXpWG/mcImjsYFGq6b+VElkiTqAcnr4iv8szU97OgaA==
x-ms-office365-filtering-correlation-id: ed2da41e-f6b3-4b49-da30-08d6863dd560
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6587;
x-ms-traffictypediagnostic: DBBPR05MB6587:
x-microsoft-antispam-prvs: <DBBPR05MB6587E91B6D6812D5D308805ACF970@DBBPR05MB6587.eurprd05.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(14454004)(54906003)(99286004)(93886005)(6512007)(6486002)(105586002)(106356001)(97736004)(3846002)(66066001)(76176011)(52116002)(7416002)(6436002)(316002)(6116002)(2906002)(256004)(86362001)(36756003)(217873002)(33656002)(6246003)(7736002)(53936002)(4326008)(6916009)(305945005)(8676002)(81156014)(8936002)(81166006)(229853002)(478600001)(2616005)(186003)(486006)(11346002)(386003)(1076003)(476003)(446003)(6506007)(26005)(25786009)(68736007)(71200400001)(71190400001)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6587;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QnhCELgnzfgkudITzWw8uj1nwD/JAsk4OgZeB8+0Zh1dK8nsbeBJ6IjY5OYb73NGXQkaiZzHbXD92B5vh+5Y59AX6EAczoRyr4oO5gQ/g3+FoWn4ObTm/kN7sp6q474g5XoDW62ExCYqqi9UdhJN5Ryrs9h14f6kEbTrdQZdB0/vpkLOWvzdjueFyJ0VC8Wkm7+vJoz8Ojmu2Fq51OymegoanfCW+VjLIljBap+Gs5MEJkyDaJT4qTzL8OtaYhpjIdTe1BTGo8a+MNNiELuf+znQjHMkGrDpJPelL3iPbPjYM7IvGESuk5EvWnnyosNiBXJVPMnaPpV2/kj+yd4Y/GeXaH2izP24BbeyZlCoxJeYXJ8uKHnjLS++JprB2Yl76fm82HWc7A9E8Wts+JHQRHUuLIgfXfUDuptgVk1mHww=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80A32BC881EDF545A23BE7BA9D3E7E68@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2da41e-f6b3-4b49-da30-08d6863dd560
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 23:02:25.0505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6587
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 03:44:00PM -0500, Jerome Glisse wrote:

> > But this API doesn't seem to offer any control - I thought that
> > control was all coming from the mm/hmm notifiers triggering p2p_unmaps?
>=20
> The control is within the driver implementation of those callbacks.=20

Seems like what you mean by control is 'the exporter gets to choose
the physical address at the instant of map' - which seems reasonable
for GPU.


> will only allow p2p map to succeed for objects that have been tagged by t=
he
> userspace in some way ie the userspace application is in control of what
> can be map to peer device.

I would have thought this means the VMA for the object is created
without the map/unmap ops? Or are GPU objects and VMAs unrelated?

> For moving things around after a successful p2p_map yes the exporting
> device have to call for instance zap_vma_ptes() or something
> similar.

Okay, great, RDMA needs this flow for hotplug - we zap the VMA's when
unplugging the PCI device and we can delay the PCI unplug completion
until all the p2p_unmaps are called...

But in this case a future p2p_map will have to fail as the BAR no
longer exists. How to handle this?

> > I would think that the importing driver can assume the BAR page is
> > kept alive until it calls unmap (presumably triggered by notifiers)?
> >=20
> > ie the exporting driver sees the BAR page as pinned until unmap.
>=20
> The intention with this patchset is that it is not pin ie the importer
> device _must_ abide by all mmu notifier invalidations and they can
> happen at anytime. The importing device can however re-p2p_map the
> same range after an invalidation.
>
> I would like to restrict this to importer that can invalidate for
> now because i believe all the first device to use can support the
> invalidation.

This seems reasonable (and sort of says importers not getting this
from HMM need careful checking), was this in the comment above the
ops?

Jason

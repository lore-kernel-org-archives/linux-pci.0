Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830C7C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5612184D
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="gyS4DX77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbfA3TiJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:38:09 -0500
Received: from mail-eopbgr00055.outbound.protection.outlook.com ([40.107.0.55]:33920
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387587AbfA3TiJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 14:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHIT1DeIPKnCvYcUeyhE0EtGWZMDqKh59X54jLmVJUU=;
 b=gyS4DX77O7CddFILxhwoDmTZHPNRUFeeiwygODXQ0HaKzhbKCXpHHl8n0EcfDF9zK15x6QwUucqkfU2oD9e4kujECqXol0rc6g+EIbWmTHlmgaifpfAtyEvzvL+c4pp7hLsRTiXZpPFME9ma34+74znidtJ0u9JCPW8OS9qTZTs=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6443.eurprd05.prod.outlook.com (20.179.42.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 19:38:05 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 19:38:05 +0000
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
Thread-Index: AQHUt/rA/dLikqWEmEaIytHIBNLPlqXGkyOAgAAJwICAAAX+AIAAEreAgAAFCQCAAAk3gIAABX0AgAATFYCAAA25AIAAGRqAgAAykICAANmWgIAAG8YAgAAHLwCAAAROgA==
Date:   Wed, 30 Jan 2019 19:38:05 +0000
Message-ID: <20190130193759.GE17080@mellanox.com>
References: <20190129205749.GN3176@redhat.com>
 <2b704e96-9c7c-3024-b87f-364b9ba22208@deltatee.com>
 <20190129215028.GQ3176@redhat.com>
 <deb7ba21-77f8-0513-2524-ee40a8ee35d5@deltatee.com>
 <20190129234752.GR3176@redhat.com>
 <655a335c-ab91-d1fc-1ed3-b5f0d37c6226@deltatee.com>
 <20190130041841.GB30598@mellanox.com>
 <bdf03cd5-f5b1-4b78-a40e-b24024ca8c9f@deltatee.com>
 <20190130185652.GB17080@mellanox.com> <20190130192234.GD5061@redhat.com>
In-Reply-To: <20190130192234.GD5061@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0147.namprd04.prod.outlook.com (2603:10b6:104::25)
 To DBBPR05MB6426.eurprd05.prod.outlook.com (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6443;6:8BjT0lPRGd/Bloy3I7se0owRa2eHox+OA3DG0HZqboKrfnk+nhBaZgiAHtWmWQTZgDJvfa3pAvYGLv0k97LV94I1xVio2b+Bbj827mAclCL+6ObT7pUrwx1nbTfJMVUVnHxP081fXmVZHLWUZGHVXRRdJ+HpMFRLYDHmV5l+QD/J4xdp/tpW2Eb6zmNTY82T/Lk4yJWxY7ZNUkw8+q4HjZiQcCeO7j0C71lN90Um6hh0Stc6qifTrcS8Ma9sXgIRmuAouxIEQBW3i1fW6k+xuhgjrCctWTXqNHnyLBqZgKlVy+KUnPnLNUYcFhZMQVi6LZZXXJ8/r+ZnfbGCZgprhmf+sW16CYz3Ve7lL/6YIAsGAEkAtbjd5REqEbYqPWyEehUbjMPHv1aQ3mvTwscs6E+18iKGvuw/Rg2w8hUZu5/KAxdalye3k9ib52JzeoC0MNc9cVes78FAnRZRT5xXwA==;5:GWwq+9oYouQYxo57/Jdm0Nk8hjAgkLD0W1mBLEpDhyA9ndsLEZuBpoeWJfcwow/vnJqMeqWuRfSzc964rMvOdT/1h/S33j+wuDNgpyzCY/biPrdVXaZuq+BnYD/P8uq6PLTbej4FsxdacOnnUElIVAo/A85I5Wzbh8m/DnrFtXu0qqV7v5nJ+0J/7Oz9h7hAoL6ToODzs4p3awRBt8BEEw==;7:joN3VKlx4Mnz/0jEG16C0H6erp7x6hJ4HLf4DwcClPN5VBQdHgsdPtWnvR3fAeLOl+0qrlZE8WHkZk5OSCQp8R3EwBsOj5yIX5SHEzkvzO4i38mxXWaNrIPb5m4lniEmoNN0LVCbZEQon60JU+VaUQ==
x-ms-office365-filtering-correlation-id: c97efedb-b36b-4a44-82bb-08d686ea7420
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6443;
x-ms-traffictypediagnostic: DBBPR05MB6443:
x-microsoft-antispam-prvs: <DBBPR05MB64432A3005A1BAD293C027D3CF900@DBBPR05MB6443.eurprd05.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(6436002)(53936002)(7736002)(6486002)(105586002)(76176011)(6246003)(33656002)(54906003)(81166006)(8936002)(81156014)(25786009)(316002)(8676002)(3846002)(6116002)(99286004)(6916009)(305945005)(7416002)(229853002)(4326008)(106356001)(52116002)(86362001)(66066001)(478600001)(97736004)(2906002)(26005)(386003)(14454004)(102836004)(2616005)(486006)(11346002)(476003)(446003)(186003)(6506007)(256004)(93886005)(68736007)(1076003)(71200400001)(217873002)(71190400001)(36756003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6443;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K2yF2AViWQZEc7ZI+pKRZyGM0T/vFd3ojbLsQvfXogDk3dndY7jjH9jsls8HSXnI52t+b5vSTqSqIq27m8soebCv+WX9wsMaVPY/o5FVX2h4NfWg0vvyoMNrwbMPBK4mMMOmErAktsps2xsXjBmL87PKV8EadBXrui+WDUPPIOf5LtLkgnJ5sx37UmqZ2GY6gXOmTWecpBWID+DqFKHqAm9NxdpC+sFkjYdX/QIqY9m8XFiJCfjJtJUZqInN+7EYwuLui6WLMVpddEvtYCRw2kaaYjcMeLkaoV/h7JBAfG+fSZ8lpRmgvK869WRwZSBLDnQ0TCLtcOrCRBZHUhXZX/Vyf9jivlrPYkIH+CrPnPphAScoYrlHQRxpFvE1vVM2UgTiz1U6vRMLM1FfFbDLKBEWInSn28alpnICZuzggFE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D90F85F4D783CE409C5D0F40D1A5C001@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97efedb-b36b-4a44-82bb-08d686ea7420
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 19:38:04.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6443
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 02:22:34PM -0500, Jerome Glisse wrote:

> For GPU it would not work, GPU might want to use main memory (because
> it is running out of BAR space) it is a lot easier if the p2p_map
> callback calls the right dma map function (for page or io) rather than
> having to define some format that would pass down the information.

This is already sort of built into the sgl, you are supposed to use
is_pci_p2pdma_page() and pci_p2pdma_map_sg() and somehow it is supposed
to work out - but I think this is also fairly incomplete.

ie the current APIs seem to assume the SGL is homogeneous :(

> > Worry about optimizing away the struct page overhead later?
>=20
> Struct page do not fit well for GPU as the BAR address can be reprogram
> to point to any page inside the device memory (think 256M BAR versus
> 16GB device memory).

The struct page only points to the BAR - it is not related to the
actual GPU memory in any way. The struct page is just an alternative
way to specify the physical address of the BAR page.

I think this boils down to one call to setup the entire BAR, like nvme
does, and then using the struct page in the p2p_map SGL??

Jason

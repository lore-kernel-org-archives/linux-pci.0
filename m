Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03564C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 20:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDAC20989
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 20:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="wPIJ6s3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfA2U6l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:58:41 -0500
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:2690
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbfA2U6l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 15:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crFkFDL6HoTHuo/PPx9XXMrngUcivpMe02RcQCcP4Dw=;
 b=wPIJ6s3RufR9eRbueTSWeYwDR/GduiVw4YBfIt4Hyv9t8mxhipnmT5x+xctLElvR2StMFXmoL+54HR39tshJXNDeRAUC7vxl1XAhC3X1Cy+PX0q3j55ctAuvbG2JWYZaSrveE1JqsT7JaAkCLQX6COW0eFAJfxAcPDrDLKf+Uoc=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6316.eurprd05.prod.outlook.com (20.179.40.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 20:58:35 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Tue, 29 Jan 2019
 20:58:35 +0000
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
Thread-Index: AQHUt/rA/dLikqWEmEaIytHIBNLPlqXGkyOAgAAJwICAAAX+AIAAEreAgAAFNYA=
Date:   Tue, 29 Jan 2019 20:58:35 +0000
Message-ID: <20190129205827.GM10108@mellanox.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
In-Reply-To: <99c228c6-ef96-7594-cb43-78931966c75d@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0011.namprd12.prod.outlook.com
 (2603:10b6:301:4a::21) To DBBPR05MB6426.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6316;6:oqhIb0u9iptFxG72au529ZElgzV0PiVBxK/BUGjyuI0YWtygReVbXKYKW3hiA8m+IVK+0SFb6W1wgtkImociII9p7vPFvA/csJ+MIO+2AcIrat/Cv1ro7aVGBCZ9JLI/f2mAsxy+NXO0JoBMr14Zbruj/olZwdNnJisjxghVN70HHDVxkwGKi5K7Vewc/hjoUS7KVVRI/0KAgjBCid7JnnxZaGUeXEcH62BwGKSrxEun8dlMa71S7s49+67/AStBqrpovQ8q1R6AeAnll99kItv1NGVxXJ+Nz10xQ8l3tHSBQwYVq/pTPajSfBLUiWQmEXU1vWJb80z5zw8KX3TXFFOPn6aNK4tNSdmFayPKpvYmAQRh4wQXDU00yB7k9nC+kMgesjZlHPR4LAiWtHaM+C0FtLCA+I6ZYeXLF8am1C4Y9lcFxXKKhYArAldb6us/QY15wHfH0hm6D1vVNj+MAg==;5:+qE1CX8Kk+8ReQpRlS9HfuhUYonq7jwd+vRqR6f1izm8h/9WN78KeScFAqKM1e3ldeMIFVXcYweGEZXO3LFWwik5+lVIWQAtsWuwHdX++MD2anPBrMxpjK2HuVgK+OW/oqiMLALtb7/FiJvoOaOAQQukUaGoAAABeLpf88VA+DvwMxqivpdilw8+6+9rC9zYAhySs0YQLxCKhGSlF3ggGQ==;7:6S4/VJX86as4RyCmbY495fgr1tkTVPeh/uwmayYoKNFOtL63/sHtAdqur7XksCQmMIbNs6NWvAOYDeAqpi7WKKkshr2M97phnp69DfWJ4YM/yulf948+GzilfzgXrsl6ogQlZgfdMCNV6lvef56Ovg==
x-ms-office365-filtering-correlation-id: f87fd651-db10-4ec2-3559-08d6862c8860
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6316;
x-ms-traffictypediagnostic: DBBPR05MB6316:
x-microsoft-antispam-prvs: <DBBPR05MB6316862A459C5F52DA1CEDC0CF970@DBBPR05MB6316.eurprd05.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(366004)(376002)(189003)(199004)(446003)(11346002)(54906003)(26005)(217873002)(6512007)(2616005)(476003)(66066001)(229853002)(186003)(4744005)(486006)(14454004)(8936002)(386003)(6506007)(36756003)(102836004)(93886005)(6116002)(256004)(3846002)(316002)(8676002)(81166006)(81156014)(478600001)(6916009)(71190400001)(71200400001)(7736002)(305945005)(4326008)(86362001)(76176011)(2906002)(97736004)(99286004)(52116002)(6436002)(6486002)(53936002)(6246003)(1076003)(33656002)(105586002)(25786009)(106356001)(7416002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6316;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IP3i1PaWZXDdSoMl6tt0T0n/TmKuOYDAq7AG5E/7PwNXD7FQSSlN6BI+tdiFth23Ut+YfpcTJq4lnjUNN8O0OAqokO0wqL6QVMbrHCbj4VLUmY56jFi0UXrjgtzx3h88yzuwKOc6AOkb5qfmKADJvTaQWvyV8eSM9ujt8GRh2qBN+viGHs8Gk/5xXBX2VZCHJxNN8c3bg9BFr6Gzx5wwhgObARcALYbmAu6BXnYEODItf7aaTmxJi0Kz0+ejh9OueWOBcZIP3guQVJXV14K2mjtKk7IgJzUUI1eXdKN7rU1p0HwZAwz3rUMhaRlvRkKgz1AnBPGMjPFzHbheB6Hcv0i72sMMW9nJftY7jzvndr9mPBPgOjMXNgHGGXZ/tnUmLLY0BrzgESVZ6MBhzo/qAcprtqzp0+qN33lFGGe5RwI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C53BE3538A37714BBCD7EECA0BFDFC44@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87fd651-db10-4ec2-3559-08d6862c8860
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 20:58:34.4173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6316
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 01:39:49PM -0700, Logan Gunthorpe wrote:

> implement the mapping. And I don't think we should have 'special' vma's
> for this (though we may need something to ensure we don't get mapping
> requests mixed with different types of pages...).

I think Jerome explained the point here is to have a 'special vma'
rather than a 'special struct page' as, really, we don't need a
struct page at all to make this work.

If I recall your earlier attempts at adding struct page for BAR
memory, it ran aground on issues related to O_DIRECT/sgls, etc, etc.

This does seem to avoid that pitfall entirely as we can never
accidently get into the SGL system with this kind of memory or VMA?

Jason

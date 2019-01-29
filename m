Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC8EC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 20:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E097820881
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 20:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="aB3pq3ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfA2UYq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:24:46 -0500
Received: from mail-eopbgr50056.outbound.protection.outlook.com ([40.107.5.56]:42097
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727342AbfA2UYp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 15:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmmVGMwD1mPL/AeO91IMwfMJjZRXwgBGoiyZWxY2itE=;
 b=aB3pq3exeOFhDaNBYfXwn79Y/6e8J4HJsQrltjNNAQiVsMKgtKZLd5El1MXyoROCd7updyJkXD+fPXMLg1kisJcQGd9ov3rpHv96cWeMM/EPKha7COQnZaxKnlzcWMsIGMP339IumOlNV7E0MLqCVgNhNFFEE2dlJtAvCkuadVE=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6540.eurprd05.prod.outlook.com (20.179.43.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Tue, 29 Jan 2019 20:24:36 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Tue, 29 Jan 2019
 20:24:36 +0000
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
Thread-Index: AQHUt/rA/dLikqWEmEaIytHIBNLPlqXGkyOAgAAJwICAAAX+AIAABQ6AgAAJYIA=
Date:   Tue, 29 Jan 2019 20:24:36 +0000
Message-ID: <20190129202429.GL10108@mellanox.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-4-jglisse@redhat.com>
 <ae928aa5-a659-74d5-9734-15dfefafd3ea@deltatee.com>
 <20190129191120.GE3176@redhat.com> <20190129193250.GK10108@mellanox.com>
 <20190129195055.GH3176@redhat.com>
In-Reply-To: <20190129195055.GH3176@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:301:4a::17) To DBBPR05MB6426.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6540;6:puCsVlOshOGcEPDBTq088yPYU6OduhwSj8GOl6yo6iwxd9ae0IyAh8ikWqbM28Fjn+fyvJKzqoms9f1OoB08HzZmWtaEjTwrGWr5oVsuIohT7Rhlm6vwI5ZBbN56FARje+L8go2KnvakpNzEE1Y8R3Djggi75Z7VYlreMHMxC9a+gqf92zSpl/LQlfw5Y01C/rtBfgoVV84Exsq5dH9kOvQBDASMBkjUM1S4cyOB+UeIO4UP7uonGPfuwXOPEx/alo1wWEsOn5WbMEON86E2294OUvwv/ogHK6jTEuEaQoEf++Y69+RxwzZhFqnmQze4HlSfdfN9aAW/eh+JgANQE+xO4oEnNvFq18ooBzwCawtEMZT6jemZyqd+a0+2VoJuMgDOz23E+IVuAZdasQDi0RvMoMkjCZlkD/Nbs2CYMjbnjEm509nxKsS4oFo3zOqpb890mb96Ymw1ZSnxwJ4DUw==;5:Ti8N3dgets0Im3zwXkF//R97pr9zDQmLhGmFHm8KhWz8SQDWfW5yKTlcw45RktABqo6WfwVLGvn9YCTbfL6EjXCARCndS3m7tCP+BUEouvLC3edOS3Ng5dMWeMWaCxMO++94i0s7nxllBCYsV5FFVgd6zJFCTC/Jx7BWld7HlORfhqhzsUlBLhhrr2eP7YvJXuNvENukvno5EqV4y4VsBA==;7:Ef5gTxnv45fVic8FN7EGf/uRPWQshv+DZVdsIrTdC3W1k9DYBOIe6JzpGANe7CEJgQZl8ppi+ylQ6wevtGQXV28dsu8GA8rI2htPMsN11shz+rid1HcgnDjTk1OwcUaGmPcJ+/rwQ9zXjMXdqEjkSw==
x-ms-office365-filtering-correlation-id: 69084849-ff17-4294-ce41-08d68627c93c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6540;
x-ms-traffictypediagnostic: DBBPR05MB6540:
x-microsoft-antispam-prvs: <DBBPR05MB65405EF636ECA08CE0FBD032CF970@DBBPR05MB6540.eurprd05.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(6116002)(1076003)(8676002)(6506007)(99286004)(102836004)(3846002)(305945005)(71190400001)(71200400001)(316002)(53936002)(25786009)(54906003)(106356001)(7416002)(6246003)(76176011)(105586002)(2616005)(2906002)(11346002)(86362001)(6916009)(486006)(14454004)(478600001)(52116002)(36756003)(68736007)(7736002)(81156014)(217873002)(93886005)(66066001)(81166006)(476003)(26005)(6512007)(446003)(33656002)(256004)(97736004)(6486002)(229853002)(6436002)(4326008)(386003)(8936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6540;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RPfm+qgeyEoBIz3jtZycUska64Kw3tLGCx1hbAg0e/0sCkyxtdCUwnUZMxn7mrXppLdmVj5Ik6qC+QoWpD6PVQ+fnTNqO/YLRkcCq4PmkIbcndSRyufKFe426QIhA8sT/jXCkCODXbKOMv5rm4PJzT4JMrAUaNx186dYVDfO13sjRNsaMlAYl+dVnZBZzpp0S7b/sB2ypJ0rADRvNEO4itj2zlBBrd3By11jBZUzHp4ddIOIhAXf61s6rmXAMJcOQzZ+P1+h6cGluztAmf1OH8p3uRqtsbnrSDQBvQSdL77AIsgFH8vwEa2TDLO9m8ZPPTmBJYZnLo2IDak5B1W9X9EXWDU6g7Bj0Ylu2s3eOvkT+MdkqlotBnLMxE9MKYG6/eKiiDBaxZcEEHGcqRmlD3qEoxp+zJayYqkq7uK9awk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B9013D8E8AFBE418AC181CA1F1B161F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69084849-ff17-4294-ce41-08d68627c93c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 20:24:35.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6540
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 02:50:55PM -0500, Jerome Glisse wrote:

> GPU driver do want more control :) GPU driver are moving things around
> all the time and they have more memory than bar space (on newer platform
> AMD GPU do resize the bar but it is not the rule for all GPUs). So
> GPU driver do actualy manage their BAR address space and they map and
> unmap thing there. They can not allow someone to just pin stuff there
> randomly or this would disrupt their regular work flow. Hence they need
> control and they might implement threshold for instance if they have
> more than N pages of bar space map for peer to peer then they can decide
> to fall back to main memory for any new peer mapping.

But this API doesn't seem to offer any control - I thought that
control was all coming from the mm/hmm notifiers triggering p2p_unmaps?

I would think that the importing driver can assume the BAR page is
kept alive until it calls unmap (presumably triggered by notifiers)?

ie the exporting driver sees the BAR page as pinned until unmap.

Jason

Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CB2C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 22:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454B12084C
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 22:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="puZzaqq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfA3W5V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:57:21 -0500
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:27510
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfA3W5V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 17:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGk9t9BHNwrMkg6K1npyELZ1MhmCrXCLnJJsKqQBeKg=;
 b=puZzaqq/ms5QN97muzSoMUrqKtRJqJNpLZb6HtkOZYtVmOYlo9oKH8StPkWw3siVwOZOhCzcr1tzkSHo6ArwhPc2DLCZxHfoMoWiyroVtrKSOeARv6gq5KAMKVGgE0nCoQTo+hV4VCAb+0yn8qa/ijNY7wY/7ihZOvG3mUxypsI=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6473.eurprd05.prod.outlook.com (20.179.42.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 30 Jan 2019 22:33:04 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::24c2:321d:8b27:ae59%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 22:33:04 +0000
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
Thread-Index: AQHUt/rA/dLikqWEmEaIytHIBNLPlqXGkyOAgAAJwICAAAX+AIAAEreAgAAFCQCAAAk3gIAABX0AgAATFYCAAA25AIAAGRqAgAAykICAANmWgIAAG8YAgAAHLwCAAAROgIAABioAgAADIQCAAAkGAIAAAccAgAAPg4CAAAL1AIAACaCAgAAAtAA=
Date:   Wed, 30 Jan 2019 22:33:04 +0000
Message-ID: <20190130223258.GB25486@mellanox.com>
References: <20190130185652.GB17080@mellanox.com>
 <20190130192234.GD5061@redhat.com> <20190130193759.GE17080@mellanox.com>
 <db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
 <20190130201114.GB17915@mellanox.com> <20190130204332.GF5061@redhat.com>
 <20190130204954.GI17080@mellanox.com> <20190130214525.GG5061@redhat.com>
 <20190130215600.GM17080@mellanox.com> <20190130223027.GH5061@redhat.com>
In-Reply-To: <20190130223027.GH5061@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:300:c0::33) To DBBPR05MB6426.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6473;6:EHp16Jtf0x51zHG5aY/zhYvDQsziogL8F7sSYuJ5A2YVm58AzpD4HBvViVJPYCtcTBumczXN14Fnhs7Ur9u/y7sjyyizPOrgbyHG/gPKWbfU8Bpwobg3H/UmfBbzxVTMs4wLnTrnAKdfxkinCaAi4+t+8BlOSuTbY0XNxweq6cdnj5FaS0+RMgiSyPTWDrTHhBvfIxzIF2hwT99UNqgvsDQr0+HMy0L4Jdp/CsGQAqZuq5MBG3xbFbKWcRWLVCl5O6IZ7aTZLajFA59zHMUW0WQOqw1QykTrN03fGVTvSjyJcsm0Eo5kQzngB1cBQQkhXagokbn9trzu/+PbN64+uuG5MKbLQky74RVPU3plsBR8xj0kDuBzA+FGHlEgrJ2R9AUs05z5x5nhbnZ7OuZyHMbRksZKa+L0AIwG8cLZ6L1VqxnXjmTPhfdElp5g7QcnJmedfh3FztbBBAnTtO16Og==;5:4V2k2nJENH8y65nJ5Gfqvy9D8sB+aCCLlXJ58DoWGQCCnA4HeSpZkv9jbd2ctZE9aS5l7ajzpMPjf0C/LSNguxUNYWZln+nspLQVq9Aeelpd0fU9S/WC8Sv/aTuS44iCNdUHb0ooVckfiZ7MCTn/KCUnivx2ezicFeBFU5hxrC32T6OoKOyojZMitvUVjnfX6hqcE2Ctok0gEuY8TpbIQg==;7:dL1aRu8v4M/v9IY8B3AykK1qCfv9jPWCwUJSrhVAsk6LM2PZw0E5YcaMj3wUj4iiuIwiRRa/6n1KBobPHIWIXengM2m3y56PtsBqtTDQLM1ZhSWCxWjwU8AfotxuX64ZrLWfbEX9Bf87FVvzgX1rxQ==
x-ms-office365-filtering-correlation-id: bdc53bcc-6a81-4e41-9bca-08d68702e621
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6473;
x-ms-traffictypediagnostic: DBBPR05MB6473:
x-microsoft-antispam-prvs: <DBBPR05MB64733D2CD3A0E0C76D746CE1CF900@DBBPR05MB6473.eurprd05.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(6506007)(97736004)(6512007)(478600001)(8676002)(1076003)(4744005)(3846002)(14454004)(99286004)(33656002)(386003)(2906002)(86362001)(53936002)(186003)(6116002)(26005)(102836004)(71200400001)(52116002)(76176011)(71190400001)(4326008)(7416002)(217873002)(2616005)(256004)(6486002)(105586002)(6246003)(229853002)(66066001)(476003)(8936002)(316002)(93886005)(25786009)(81156014)(54906003)(81166006)(68736007)(6916009)(36756003)(11346002)(446003)(6436002)(7736002)(486006)(305945005)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6473;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +xvNYsBqylgSr92YLOV0YwN6h/OnFAXQQL43w4CQNdG7MIJQXGWg7P645/BSG9/yPhvA40vr9gBxrnI5Eh/okD4U6MFQERpCPtzzfod5qZb2nB2a7GDLSScUEm64//BAA+k8olO64TKUa/Pr0AR4dwYGdLQ2yrBEW5jPYywxts/NiBHV4r8JJRILoAfcsOoHro4nLBkn/0hhuPTOkgutI3uTeehyqarEEqyAGzZBEp2kYHkbVOtA2NLPk68/1JH6lJv2MSdNExZTGeWSH89NtJTKEdGIs5Zuh+J04wiDYBCkJaauRsNHmW7Rf65Y5Um6lirm7nc2cPiUoYMYMwoszHTVItTZUfT66l1CCHQqSHnKgAzyWYYNsPIY+9GDbgdg15YmzvVl1mq5+Iz1btI4LkJKhQP25eCGKfhMbaN4DTE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A88F47E4F9E812418578E798DF4B84C0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc53bcc-6a81-4e41-9bca-08d68702e621
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 22:33:04.0130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6473
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 05:30:27PM -0500, Jerome Glisse wrote:

> > What is the problem in the HMM mirror that it needs this restriction?
>=20
> No restriction at all here. I think i just wasn't understood.

Are you are talking about from the exporting side - where the thing
creating the VMA can really only put one distinct object into it?

Jason

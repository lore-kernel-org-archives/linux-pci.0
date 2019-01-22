Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2564C282C3
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 13:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EC620870
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 13:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="sXtx0ssl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfAVNgL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:36:11 -0500
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:24232
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728463AbfAVNgK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jan 2019 08:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33rxIlRhvsHUo5009g6EOIuyIv5Q/+GCs2JdrnopLgw=;
 b=sXtx0sslZ8Y9cqKgym1gk4ogEliVoVXpkhq/jr5OyhlrxUcfDEfO/dtLqitdOEM0kufr2l9N4nz2Ih8zAH/SE/4hYkH/7IGj1HYebceY15CULyqjoqALL9ofVnhmxfQgLvfgO7Xk2Wm+WVqtPLOMl0QZR2fMtCZozE7XEeJm79E=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3397.eurprd05.prod.outlook.com (10.170.219.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 13:36:05 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320%2]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 13:36:05 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Olof Johansson <olof@lixom.net>, David Woods <dwoods@mellanox.com>,
        Robin Murphy <robin.murphy@arm.com>, arm-soc <arm@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        Christoph Hellwig <hch@lst.de>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
Thread-Topic: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
Thread-Index: AQHUcgMEWmkOtMRYOEe8dmJo8nndDKW1ql2AgAYLUACAAAXUOIAADhu/
Date:   Tue, 22 Jan 2019 13:36:04 +0000
Message-ID: <DB6PR05MB3223778EE7090BBC8744C9F8A1980@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1541089538-175682-1-git-send-email-lsun@mellanox.com>
 <1541089538-175682-5-git-send-email-lsun@mellanox.com>
 <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>,<20190122122022.ipn3jdfnxthhphrs@axis.com>,<DB6PR05MB32235BE3E5EBCA60ABDEDB13A1980@DB6PR05MB3223.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR05MB32235BE3E5EBCA60ABDEDB13A1980@DB6PR05MB3223.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [173.76.171.210]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR05MB3397;6:jl8rUmPUVp6LwUH2TyhoUwCXK4E2TQ9qkjliCW0eGSqfTLNHtpUHpq70Qyi9eLQnKV0pm8rCKox9RZfqi7uxB1/ApKmyUve28ybz2EQaAKq2LF6M7F9ea7AFQf2cd9KOPVs6TxPzwYQL0wmn6ETSUy70qmEzZljTuq6B5jJYl7lOHu5AlfUZ1sBYiwELqwonFTftHjJAoe1oYbWfp2N0U0xkTyOaKyQ71GFYWmYa9eyoTmr00O3aizAmFskm0djt8hlSeRz/ifadpxJVGCxCJZRqUmjYxENtgwtueHTr8pHieTGh/slXM7GIMDZnpnNjyB3Q5FpgnlH8cHHQcPfOyd0MLk27u6uZ5ixzPAhMJipPTwad9ogC8sdmP15qgn8V25f/usnqCdQNbzWYw2IsMMM575MyGtNqM/UElVe8DSU2LkzMxaZLRAIX32F6DmYhuYefUp0YopnETMX81mYnXQ==;5:o/ljuIIY+Jqxph5D/2PDWmn44KPMQbIoSfw3L89ZLDc54EzXwkjwdwB5HjYyr4cKbo0+yCUki1J1fYV+BpPm/Cat5orHHr99v2tAD1OXLi7EINM3ZLGYdDnEon4WDfgUDfH+HXu2Q8OXe9xsTeeGD8+tNTK76JQt/6x2biUGZHmNmbhbFctQ9lI/ke1eIVQdXuO9Mwg7KZkyLoIqE6iqpQ==;7:cMLxg+ij3fvOHqIwLNyrLZXQr/qP+Eob7/QbtAu7MhdSZD8rYu0WwlnHg8BkyPl+vgY3SjNjK0FgGlH3wcWQXxU/Mj8Mpr69/wLfPgvdsCVv/qXRStziOYu24KqPAi/4HVnj1DKEAVIKjF5ZrrwT4A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e757b3a1-1ed2-479e-ad0b-08d6806e8ed0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3397;
x-ms-traffictypediagnostic: DB6PR05MB3397:
x-microsoft-antispam-prvs: <DB6PR05MB33979FE571996F20DE546C50A1980@DB6PR05MB3397.eurprd05.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(43544003)(199004)(189003)(97736004)(68736007)(305945005)(53546011)(6506007)(93156006)(7736002)(74316002)(14454004)(478600001)(106356001)(229853002)(55016002)(105586002)(6436002)(9686003)(11346002)(446003)(476003)(486006)(26005)(25786009)(4326008)(33656002)(71190400001)(102836004)(71200400001)(7416002)(186003)(53936002)(6116002)(256004)(8936002)(81166006)(3846002)(8676002)(316002)(81156014)(76176011)(66066001)(99286004)(2940100002)(93886005)(7696005)(110136005)(54906003)(86362001)(2906002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3397;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BPpRZBcE5XqyvPH2sWECt1qquSWloWKOShjIfYL34hVzl2tbBWc1pQV1br92kNMZpkOI5RdoQ/GHy3dEitnowizvcOCFaXUkwEml/Fh8i2+w2n7bcuZEV825a5//jEuqo4sIezYp9R3PspELiGqXYjyWbHMQFDiNkhgBaOLVIL3z4L7Am9Ikh8m5ZfHw6FMK4hos3lOETdxYW032nrRBs9E1qCdveoe1z74all9wWfr5zJ1aU2sQqkFCdcfI7PAtPtV044XngqE8X9JuVtRAGW1sSFXBphx3VrpmE3ulon5bTB1YSjwCxBw3e4vUPNtUnjyvR+CBMMjJCNioj2JSbOArVdcPSUbr28Lt8zq466jmf61bE+RcazxiOOghfr2rUbdpofV5jDaOYFGl3MF1/BZsL6eHmBR8Bhbssk0jmBo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e757b3a1-1ed2-479e-ad0b-08d6806e8ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 13:36:04.8090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3397
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Sent: Tuesday, January 22, 2019 7:20 AM
To: Arnd Bergmann
Cc: Liming Sun; Olof Johansson; David Woods; Robin Murphy; arm-soc; DTML; L=
inux ARM; linux-pci; linux-ntb@googlegroups.com; Christoph Hellwig; virtual=
ization@lists.linux-foundation.org
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side R=
shim driver
=A0=20

On Fri, Jan 18, 2019 at 05:02:21PM +0100, Arnd Bergmann wrote:
>> On Thu, Nov 1, 2018 at 5:49 PM Liming Sun <lsun@mellanox.com> wrote:
>> >
>> > An external host can connect to a Mellanox BlueField SoC via an
>> > interface called Rshim. The Rshim driver provides boot, console,
>> > and networking services over this interface. This commit is
>> > the common driver where the other backend (transport) driver will
>> > use.
>> >
>> > Reviewed-by: David Woods <dwoods@mellanox.com>
>> > Signed-off-by: Liming Sun <lsun@mellanox.com>
>>=20
>> Hi Liming,
>>=20
>> I've taken a new look at your patch series for drivers/soc/ now,
>> thanks for your continued submissions.
>>=20
>> This is again just a set of very high-level comments, but I think we
>> should resolve some of the fundamental questions first.
>> Incidentally, Vincent Whitchurch has recently posted another
>> patch series with a very similar intention, but for other hardware
>> and taking a different approach.
>>=20
>> In both cases, the idea is to use virtio based drivers to provide
>> services from a host machine into another Linux instance running
>> on an embedded system behind a PCIe slot or similar. Your
>> Bluefield SoC patches are well written, but are intentionally
>> kept specific to a particular use case and tied to one piece
>> of hardware. In contrast, Vincent uses the existing code from
>> drivers/misc/mic/vop/ that is equally hardware specific, but he
>> extends it to be applicable to other hardware as well.
>>=20
>> It would be good if you could look at each other's approaches
>> to see where we could take it from here. I think ideally we
>> should have a common driver framework for doing the same
>> thing across both of your devices and as well as others.

> As far as I can see the biggest difference is that Rshim appears to
> support interfaces which do not have shared memory between the host and
> the card, which means that it has to jump through a lot more hoops to
> make virtio work.

> For example, the card side seems to use normal virtio-net and
> virto-console drivers, but the drivers/soc/mellanox/tmfifo.c driver,
> also running on the card, appears to have to actually look inside the
> virtqueues and shuffle the data over the TmFifo interface, and this
> driver has hard-coded support for only network and console, since it
> apparently needs to know the details of how the virtio drivers use their
> virtqueues (see tmfifo_virtio_rxtx()).

> And the host side appears to _also_ run the virtio-net driver and there
> the drivers/soc/mellanox/host/rshim_net.c code instead has to look
> inside the virtqueues and shuffle the data over the other side of the
> TmFifo interface.

> So to me this looks very different from a traditional virtio
> driver/device setup (which is what mic/vop uses).=A0 I may be missing
> something, but I don't quite understand why it's even using virtio in
> the first place.

Thanks  Vincent! This appears to be very good summary of this driver
does on the tmfifo part and the difference between  mic/vop. The fifo is
accessed by=A0register instead of shared memory.

The reason to use virtio framework is that it can be=A0easily used to add
more virtual devices as needed without implementing driver details for
each one. For example, the device side supports console and networking
for now over the FIFO. It only needs to implement function=20
tmfifo_virtio_rxtx() once to take care of the virtqueues=A0Rx/Tx, which are
shared by all virtual devices. With minimum changes, we could easily add
another device over tmfifo, like a virtio block device, since the queue
handling is already there.=20

The host side handles the virtqueues as well in rshim_net.c. It behaves
like a peer-to-peer to the device side while the tmfifo behaves like a
'wire' (transport) to pass data between the host and the device without
worrying about the data details.=

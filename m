Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8DFC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 19:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B404920652
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 19:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="RoZRrY3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBYTRs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:17:48 -0500
Received: from mail-eopbgr760114.outbound.protection.outlook.com ([40.107.76.114]:47405
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727047AbfBYTRs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Feb 2019 14:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY9y6f5q9pj9By3Yp+WlYqgnnBgiEdS+EJm0Ot8tJe4=;
 b=RoZRrY3uKCcW+3jcbI7B3GMocYr1u+duiVIKyysDP/fB0Esg5O59DaDBhBpTEull08eoWkXbY5sjSSRWX38HkndYjHPpvsity6DMe9A1XqId5SCS9gM4I2TIAUvg3mhCgfoHmNF5DciwLo6IAbnom5fZHu60vRTET+51UNszU+Y=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1312.namprd22.prod.outlook.com (10.174.162.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 19:17:45 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 19:17:45 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] MIPS: SGI-IP27 rework
Thread-Topic: [PATCH v2 00/10] MIPS: SGI-IP27 rework
Thread-Index: AQHUyicabaobcsLrVkGM419PhbaunaXreOgAgAVwWwA=
Date:   Mon, 25 Feb 2019 19:17:45 +0000
Message-ID: <20190225191743.atteae2cbyt5btb4@pburton-laptop>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
 <20190221205038.hcov3n574a3zqip7@pburton-laptop>
 <20190222091418.7c0eeb0d5c11b68874d8fdc9@suse.de>
In-Reply-To: <20190222091418.7c0eeb0d5c11b68874d8fdc9@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0001.prod.exchangelabs.com (2603:10b6:a02:80::14)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc6b0116-df7a-46e9-3244-08d69b55ebfa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1312;
x-ms-traffictypediagnostic: MWHPR2201MB1312:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1312;23:GlcvKQZ/zFUUZH2zg0dS1NInlodBDk2p3jtGrv5?=
 =?us-ascii?Q?4aHQJhztULo8uwRQBGCA0sYY3Ms7pLx3ccMfbz7p4q0fmddNK/97uNcezB99?=
 =?us-ascii?Q?6zuscCSXuLy/bcmyI4fogLFJTqD7YRnBCFGMTklQmY7rSMty/Vruea4hCWPp?=
 =?us-ascii?Q?yS/99xD/eR15OqbdteQ+tw+6CH+w18u4ba7UWeWw2CBcR0V+fOU7U4PtbwYQ?=
 =?us-ascii?Q?wjmO0ab1PjiRsY+zvGSJBfg4eX/RahhZc3/v2WpM4LEod17eF8UjUMlIHTWx?=
 =?us-ascii?Q?cTq3G76LJz/0Ii9gPyGaQEg8hYCEANaOpRNg7Esfn9JUtr1tDGPEjTdAk/gF?=
 =?us-ascii?Q?Dzh7PfrRMy+u7Kyto1eRB9BQdrdkPasw55JEg7UE917HMLZnkQSYV9nKQqgG?=
 =?us-ascii?Q?2I/V0gx5gG2mu5UPpbRRc7m7EbrRv4302GRGZU9u6hOal4novjqvyfbIX8+I?=
 =?us-ascii?Q?tRgZ7fgFcDVIcbLN74UF9ESPC1Kuaz5ejfORJjKkrf2BhNTdF8Zs08CckyQe?=
 =?us-ascii?Q?bSzyCVys72gPIAR/npHdHso3i1icMuUULWLqJmVECTdgb6bQ8ELQ3kf4b1xP?=
 =?us-ascii?Q?eJXvNWHFr6fBg1XPGs/0JKIgHmc40cVDVyrVmzNLMZA2h7CQisoBGHItARMo?=
 =?us-ascii?Q?ZWAlztfXJP3OwggwtHhZPRmAnUlVgBWEWNO0fK1w1V3Dwe6OvO4bBrkWtj0m?=
 =?us-ascii?Q?YK246L7DNZQF3FVxIlhJZsGcMEVdWPBDnKTzbVF/8PKNHYeISF6IMoOrKkVb?=
 =?us-ascii?Q?/fJCeOe4Q0dfZ1/B/rhzd0mwT2prg8XKudfqVbJfO5lvpXX8jauMY7kX4XBS?=
 =?us-ascii?Q?bv0GiSa6qaucepGbwSVpHfWEwuUXtcARojSHqiq9CtZ+A4ImdhxgtlPUXS8X?=
 =?us-ascii?Q?M6swNAsDqko0v7NOgqKYnOT12DvP0oiEBJ7pzpDFB0rvNSkUzedf5ReG3DEk?=
 =?us-ascii?Q?6EaPcEzw5DYMwTDXOe9Cnnt3sqGK3k2K4Esg5kqvpc3jbS2yCgMstBmnw2DM?=
 =?us-ascii?Q?jVAqyqyiY7C0tUHz9WeisDY+gNHPoT515N74fQwQisu83W2Td04/xDGLIH9h?=
 =?us-ascii?Q?W/CFvjKlSuNbDon7jw833r8bmhrGUYqavXTguFByIUXZ7Aab8GmwmCednhNv?=
 =?us-ascii?Q?ebVawWbzzKNaxGjwWWdN1djeu+2Cr9UsfSv1+kSR475ymjA4a9ud6GDePpI/?=
 =?us-ascii?Q?sWu2RXD65HTdcamiO061hCS86iR8N1T1GJPhU2hBZm2xQtuy78j/uDthNNE/?=
 =?us-ascii?Q?hK1GIMqypY1tA46pQczAzKc82ESjsWwaGDLCe7HIau63GKj+1l3Np2X8Z+6a?=
 =?us-ascii?Q?zmHkiUJNToLkUge97cYhkPz4=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB131235E2AD2C377781D50FE2C17A0@MWHPR2201MB1312.namprd22.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(376002)(136003)(346002)(39840400004)(189003)(199004)(97736004)(8936002)(71200400001)(7416002)(8676002)(7736002)(11346002)(4326008)(102836004)(446003)(25786009)(66066001)(1076003)(256004)(5660300002)(99286004)(186003)(68736007)(71190400001)(81166006)(81156014)(26005)(478600001)(76176011)(6916009)(42882007)(305945005)(33716001)(229853002)(316002)(6486002)(44832011)(2906002)(58126008)(53936002)(54906003)(486006)(3846002)(6116002)(14454004)(6436002)(6512007)(9686003)(476003)(386003)(105586002)(6506007)(106356001)(52116002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1312;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yrZLf8cVVr24epxBhQJDMz+mlcEW3HbQq4/IYY43IyoXBlNUByuSMidS8CBEJoeESuatB5wsBgksLEGINSZ6hcoyq/LxX739vPKx+kjG31GLFfzM69s9XsigWEVDUm0dEuoSJ959L2//NsXnZOX58IEXGev/ij1bmgE92x+xlczbR8WpnvBwKJUpZC3S07S+FldwW7NZHSflpZpR0hCnBO1pJ7ejT1Er/NgekuxIyfGQwkk28bIQ2qy83fidfiOBsygKNjZYijjHrsYb5znertIObG14hJIq6EpVyBcmcrKdMJaSmyH8Z+vQphjG7q8wAu8red6kw9b3Ap19cQdUu63NQ4D0owN9713HgSZJQzuO7q4q4MsrLoW4D/M2GuLwxe3I4Gj7ErCmy3qnV3ADbHAWigIAvh7kS2JSQm2AuZo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E2DF46FCF81084EBDFBCD0A5411DB15@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6b0116-df7a-46e9-3244-08d69b55ebfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 19:17:45.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1312
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Fri, Feb 22, 2019 at 09:14:18AM +0100, Thomas Bogendoerfer wrote:
> On Thu, 21 Feb 2019 20:50:39 +0000
> Paul Burton <paul.burton@mips.com> wrote:
>=20
> > I don't appear to have received patches 7 or 9 but I see from archives
> > there'll be a v3 of patch 9 at least.
>=20
> I'm still fighting with git send-email to do proper collecting of address=
es...
> And the mails to your @mips.com address bounced yesterday.

Interesting - thanks for letting me know. Some of our IT infrastructure
has been physically moved over the weekend so hopefully it's just
fallout from that, and I seem to be able to email myself from gmail at
least. Will keep an eye on it though!

> > So I can either apply 1-6 for v5.1 or defer the whole series. Let me
> > know - I'm happy either way.
>=20
> All changes will happen in patches 7-10, so appreciate, if you could
> apply 1-6 :-)

Great, I've pushed out mips-next with patches 1-6 applied. My ack email
script isn't yet smart enough to respond to the cover letter for a
series that's only partially applied, so apologies for the 6 separate
acks :)

Thanks,
    Paul

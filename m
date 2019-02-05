Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2D5C282CC
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092EE20663
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 15:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="dzVtvigd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfBEPpn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:45:43 -0500
Received: from mail-eopbgr1400091.outbound.protection.outlook.com ([40.107.140.91]:33856
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729989AbfBEPpn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Feb 2019 10:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW075yks0H+008UCyXNwgwldqQeoq/5XU5MqZPrXz7M=;
 b=dzVtvigd0W+u7J6lZrZj+w600Ht/r6MkXbr9GeOquwkNRSfJfejxJCCQPi6PUOBzdOJGLVWauyiIYaA1d6cA00L/dv99j+IDhd9ZEdFo516muR00EAXBgeh5DNyOoGcBTA/GhImMnnJ9TS3C648jCLyCJCqSyUSiRZj6+YPfMyA=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1690.jpnprd01.prod.outlook.com (52.133.160.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.23; Tue, 5 Feb 2019 15:45:39 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::9c4b:5b3e:212f:354e]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::9c4b:5b3e:212f:354e%3]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:45:39 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for
 r8a774c0
Thread-Topic: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support for
 r8a774c0
Thread-Index: AQHUlsmc+3AeyJiJUEOiPBskoyHDLaXLfMGAgAYm6wCAAAFrQA==
Date:   Tue, 5 Feb 2019 15:45:38 +0000
Message-ID: <TY1PR01MB17700A4F43A8F64656E1EDDAC06E0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1545134562-22450-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190201174005.GD22887@e107981-ln.cambridge.arm.com>
 <20190205153656.aywg4ewpyp34i633@verge.net.au>
In-Reply-To: <20190205153656.aywg4ewpyp34i633@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1690;20:tWivfJiPcpIiaqQNVrmsWRo3oUpY71xjIYNs32G+t3XDro6YCSz9WcmURHhv08axVZmD7B29FuWjYeKh1MIzi19VrJgK2aZ0/p0wBXfz4McnxDP/3XogSNLYrzS7h4f0RuQZBBOhE2iqwXX6MtObeT5bbeP5LQWRLsC7EezppnA=
x-ms-office365-filtering-correlation-id: c2c03d9d-6702-40ed-6ec2-08d68b80fa51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1690;
x-ms-traffictypediagnostic: TY1PR01MB1690:
x-microsoft-antispam-prvs: <TY1PR01MB16905ACC4AE880AECA3DA2B0C06E0@TY1PR01MB1690.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(71190400001)(76176011)(186003)(305945005)(66066001)(99286004)(9686003)(2906002)(71200400001)(25786009)(4326008)(7736002)(11346002)(446003)(476003)(54906003)(486006)(6436002)(7696005)(26005)(44832011)(316002)(3846002)(6116002)(110136005)(106356001)(7416002)(8676002)(6246003)(14454004)(86362001)(105586002)(345774005)(53936002)(33656002)(102836004)(81166006)(81156014)(55016002)(229853002)(256004)(14444005)(53546011)(6506007)(8936002)(478600001)(74316002)(97736004)(68736007)(138113003)(98903001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1690;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nhS1H44QaqVnaOHox+ZMUwcruMULF+rEyEmUr9yUVqib8NAL8Ln1dDkdgbn3P9xuY2OoPsfxtNl8SzZ7CKFebilIGrLCBjntSHzOJ0TJRsQ2CvQUNUQqf7P86zgy//DshdclY51QsTawujbEvmsDZG35Q4awhPnHEirVNNU1hbec4rHG7CBYbDyYGWyHXeBqvXnUcXNk92HnTeZjMQUoc1cFn3ZVKRO2S0aMsznzcGJWmqf7WdPmJJa94mb5A8l5XoZSXzA2RbKcycMGSx9ZYyFaYmYmd5OnDcCg6f8ZY4DQOO/aZIXvI77NKv5Gu/prB8U7K9jCd64us6rCWXntfyWbNIKKfmbY37C1kW/tK/ohqhKuLZGX62e8X8TQGUHw0CxJf1nBUBi5xOm7VReJmJbrOpvrrTTqQyUZIB24NoE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c03d9d-6702-40ed-6ec2-08d68b80fa51
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:45:38.9228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1690
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Simon, hello Lorenzo

> From: Simon Horman <horms@verge.net.au>
> Sent: 05 February 2019 15:37
> Subject: Re: [PATCH v2] dt-bindings: PCI: rcar: Add device tree support f=
or r8a774c0
>
> On Fri, Feb 01, 2019 at 05:40:05PM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Dec 18, 2018 at 12:02:42PM +0000, Fabrizio Castro wrote:
> > > Add PCIe support for the RZ/G2E (a.k.a. R8A774C0).
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > v1->v2:
> > > * Dropped change to the description of "phys" optional property accor=
ding
> > >   to Geert's comment
> > >
> > >  Documentation/devicetree/bindings/pci/rcar-pci.txt | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > Hi Fabrizio,
> >
> > Apologies for the delay in responding.
> >
> > Should I take this patch via the PCI tree ?
>
> Thanks, that would the preferred option from my point of view.

I agree, and thank you for replying Simon, as Lorenzo's email was
caught in my spam filter somehow, and I would have missed it if
it wasn't for your reply.

Thanks,
Fab

>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>
> >
> > Thanks,
> > Lorenzo
> >
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Doc=
umentation/devicetree/bindings/pci/rcar-pci.txt
> > > index 976ef7b..6904882 100644
> > > --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > @@ -3,6 +3,7 @@
> > >  Required properties:
> > >  compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> > >      "renesas,pcie-r8a7744" for the R8A7744 SoC;
> > > +    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
> > >      "renesas,pcie-r8a7779" for the R8A7779 SoC;
> > >      "renesas,pcie-r8a7790" for the R8A7790 SoC;
> > >      "renesas,pcie-r8a7791" for the R8A7791 SoC;
> > > @@ -13,7 +14,8 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 =
SoC;
> > >      "renesas,pcie-r8a77990" for the R8A77990 SoC;
> > >      "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
> > >       RZ/G1 compatible device.
> > > -    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible dev=
ice.
> > > +    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 or
> > > +     RZ/G2 compatible device.
> > >
> > >      When compatible with the generic version, nodes must list the
> > >      SoC-specific version corresponding to the platform first
> > > --
> > > 2.7.4
> > >
> >


Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael Hanna=
wald, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse =
10, 40472 Duesseldorf, Germany,Handelsregister/Commercial Register: Duessel=
dorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr.=
/WEEE reg. no.: DE 14978647

Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E591C28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE64B20890
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="tLhqPF5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE64B20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeJOQAu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:00:50 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:60053 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726273AbeJOQAu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 12:00:50 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie2.idc.renesas.com with ESMTP; 15 Oct 2018 17:16:35 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id D44817766B;
        Mon, 15 Oct 2018 17:16:35 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,383,1534777200"; 
   d="scan'208";a="295171626"
Received: from mail-ty1jpn01lp0177.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.177])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2018 17:16:35 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG6Zh/fA5A/F0iiqWb6PoDNxrcI8wUzx/a3Siynnsk8=;
 b=tLhqPF5LT97HaHDYPElzXN/GadY6Xng5KKbIvKoRyHlT/RZafRhpf71YeHtMo3gY8e7kdWEnBkUSBa1YC5IkSVlHf/CtAY13bKYNiulw3cjLbfgRV2D24MKZ86umFFZzVrbVwFCrCkQOsbA8HhWTmhOcZj1tknghXuNxfEgLk/s=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB1829.jpnprd01.prod.outlook.com (52.134.228.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.22; Mon, 15 Oct 2018 08:16:33 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::9f:3b9f:204c:d53f]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::9f:3b9f:204c:d53f%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 08:16:33 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Horman <horms@verge.net.au>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a7744
Thread-Topic: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a7744
Thread-Index: AQHUW/1na2/g+/g+6UiqrfCa7AMOk6UU+smAgAbXpQCABDMJcA==
Date:   Mon, 15 Oct 2018 08:16:33 +0000
Message-ID: <OSBPR01MB21034F491B7FDA80CE1824ACB8FD0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1538669267-17576-1-git-send-email-biju.das@bp.renesas.com>
 <20181008073445.ni4doozxflbqaanw@verge.net.au>
 <20181012160408.GE23257@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181012160408.GE23257@e107981-ln.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1829;20:G+l3oijKmtxiDGXYfvQBcTa6MAbEFE0LvdxDYd3Gz51Ngilqw7wZWpIhval1eXQxXk/8dQ4wYBvhPILI6qF63fvb0Zjz2quUly73T+IkJUgR535Z49nejSA6qjaOjcNdcIYnv8keV9fU5XWU3zB3VrCrBbH7KsXohT+ej2/YxGk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: bf65bc7f-05da-4bf6-b216-08d63276849b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1829;
x-ms-traffictypediagnostic: OSBPR01MB1829:
x-microsoft-antispam-prvs: <OSBPR01MB1829F37A1B61BE3FBAC56C37B8FD0@OSBPR01MB1829.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:OSBPR01MB1829;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1829;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(136003)(189003)(199004)(66066001)(53936002)(8936002)(2906002)(2900100001)(8676002)(97736004)(71190400001)(71200400001)(81166006)(7696005)(81156014)(54906003)(110136005)(105586002)(99286004)(5660300001)(55016002)(3846002)(76176011)(6116002)(68736007)(86362001)(106356001)(4326008)(9686003)(256004)(229853002)(6506007)(446003)(102836004)(14454004)(486006)(33656002)(7736002)(305945005)(11346002)(25786009)(316002)(6246003)(6436002)(74316002)(5250100002)(186003)(478600001)(26005)(476003)(44832011)(138113003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1829;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PPM4uoTtpOxEneZ6EzeNWXuReJUdGkwSXoWpvlyyOxkbb+zHrA/aFDTdvZ+yETAH+rI/Y/w6IbI1yT6ZNi0PW6tqvy0+fdK6uqQUxfWt851JQA35q0I5RSdWtHAexmStYSmwBWLG7g+juyyrabGkZ8MzVPK6hCsZ0kYdxcXDnOi+GbJYuSY8AMADgzkmZ/4rn8rcXrtYCfPIImXA4Co+upBIm8o3lGrnaaGVBgJjGsAE1uU4iVgrvheiyqJiIxYCm4ddBtzEdiGS5rLHYFfi8gIDB8u1lOiCBc6xtTeT4m/8HxbJv5D/P6DJzppGXb7ihvVi3VswpiEFHZmqVWmp0UewOnWMWEEIsZ+i+HwmwqU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf65bc7f-05da-4bf6-b216-08d63276849b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 08:16:33.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1829
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
> r8a7744
>
> On Mon, Oct 08, 2018 at 09:34:45AM +0200, Simon Horman wrote:
> > On Thu, Oct 04, 2018 at 05:07:47PM +0100, Biju Das wrote:
> > > Add support for r8a7744. The Renesas RZ/G1N (R8A7744) PCIe
> > > controller is identical to the R-Car Gen2 family.
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> >
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>
> Simon, Biju,
>
> I pulled the same binding for rcar2, I would pull this in the PCI tree to=
o unless
> you object, please let me know.

Thanks for pulling this into PCI tree.

Regards,
Biju



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.

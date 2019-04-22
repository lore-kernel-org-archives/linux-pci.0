Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58A4C282E2
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 07:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5B721741
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 07:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="AiVkxGGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfDVHyn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 03:54:43 -0400
Received: from mail-eopbgr740041.outbound.protection.outlook.com ([40.107.74.41]:13511
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbfDVHym (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 03:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjfSQIv0CNvflbyTM0fb+I2B+lfCtAnsRM90EMojDBE=;
 b=AiVkxGGYM9J7Pnkwf5XR+WB8d5/ik+C6g28olhCqGdUFSm3gTiG/OBNWJM+KMaNQEFtud6TWutcFuuqcwdxxhfqnkH5+lJzPEXg7CsVBih+uaGMq3c5pYHqIFCij9bF7iHzJaEnYfG9XZThFePGnrj3Z3LiYCKIMncW4krV6LN0=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4662.namprd03.prod.outlook.com (20.179.91.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 07:54:33 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::7933:c072:6250:6b25]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::7933:c072:6250:6b25%4]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 07:54:33 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
CC:     Vidya Sagar <vidyas@nvidia.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH V3 04/16] PCI: dwc: Perform dbi regs write lock towards
 the end
Thread-Topic: [PATCH V3 04/16] PCI: dwc: Perform dbi regs write lock towards
 the end
Thread-Index: AQHU9IqewpDyJpQXwE6mOsZ+3qv9QaZAHpeAgAe3OAA=
Date:   Mon, 22 Apr 2019 07:54:32 +0000
Message-ID: <20190422154608.6e6f8ae3@xhacker.debian>
References: <20190416192730.15681-1-vidyas@nvidia.com>
        <20190416192730.15681-5-vidyas@nvidia.com>
        <305100E33629484CBB767107E4246BBB0A22C127@de02wembxa.internal.synopsys.com>
In-Reply-To: <305100E33629484CBB767107E4246BBB0A22C127@de02wembxa.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2db3386-c0ce-4f3e-71dc-08d6c6f7c15d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR03MB4662;
x-ms-traffictypediagnostic: BYAPR03MB4662:
x-microsoft-antispam-prvs: <BYAPR03MB466261CC9CE303CC3B585BC1ED220@BYAPR03MB4662.namprd03.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(39850400004)(396003)(199004)(189003)(229853002)(6486002)(86362001)(6436002)(1076003)(256004)(68736007)(97736004)(14444005)(71200400001)(71190400001)(446003)(11346002)(476003)(52116002)(186003)(316002)(5660300002)(66946007)(486006)(4326008)(110136005)(54906003)(8676002)(386003)(6506007)(53546011)(14454004)(99286004)(25786009)(76176011)(26005)(73956011)(3846002)(102836004)(6116002)(9686003)(6512007)(7736002)(6246003)(7416002)(66476007)(8936002)(81166006)(81156014)(66556008)(64756008)(66446008)(53936002)(50226002)(478600001)(66066001)(2906002)(305945005)(72206003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4662;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z08ThfWHWTPymdZO7BOAycwDCXyRbvfUmrIH0op7fJu9ex7WAveMCUJ3+6FVJdKwqbo8qd9qIyKf9hXmnCvCJ0v1B4cS7g2T725ZjF8cNrhiD4QIWl8sDxnF94IlxyRi61dBofeDd7Ot0sVvqShkbOf13DDgKV+L22Tj2OMp+sqMIe0lUfcGtquRcbkkXG+ry/InBWu8PXks8uy8ZinwckQGbmM/E7kt/jaT4R7XoPi9uk6THC+f1k1op1e6W5VGZM6mj79h60H+lukySKfGETiC1Yo/oThAQVq55f7Z7SH1ED7aCjuZ401Eib3DlDlUfAP2r2Gr/61vMvLGD/YJICVKt16pT210f3erODAG+swxMZsrlx5NKhrGgW4Pbm9q2aNBFSYx+U1SldnTOhcQqkX2xBpokrKNPXEzkX42bGI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C182E1A434A58143A8B4545110B023F8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2db3386-c0ce-4f3e-71dc-08d6c6f7c15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 07:54:33.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4662
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Apr 2019 09:56:33 +0000 Gustavo Pimentel wrote:

>=20
> On Tue, Apr 16, 2019 at 20:27:18, Vidya Sagar <vidyas@nvidia.com> wrote:
>=20
> > Remove multiple write enable and disable sequences of dbi registers as
> > Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled =
by
> > DBI write-lock enable bit thereby not allowing any further writes to BA=
R-0
> > register in config space to take place. Hence disabling write permissio=
n
> > only towards the end.
> >
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> > Changes since [v2]:
> > * None
> >
> > Changes since [v1]:
> > * None
> >
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> > index 2a5332e5ccfa..c0334c92c1a6 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -683,7 +683,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >       val &=3D 0xffff00ff;
> >       val |=3D 0x00000100;
> >       dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
> > -     dw_pcie_dbi_ro_wr_dis(pci);
> >
> >       /* Setup bus numbers */
> >       val =3D dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
> > @@ -723,8 +722,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >
> >       dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> >
> > -     /* Enable write permission for the DBI read-only register */
> > -     dw_pcie_dbi_ro_wr_en(pci);
> >       /* Program correct class for RC */
> >       dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI=
);
> >       /* Better disable write permission right after the update */
> > --
> > 2.17.1 =20
>=20
> This setup sequence was written by Jingoo Han, let's check if he did this
> by some particular reason.
> Jingoo do you remember why you wrote the code like this?

FWICT, enabling RO writeable in the setup sequence is introduced in
commit d91dfe5054d4 ("PCI: dwc: Enable write permission for Class Code,=20
Interrupt Pin updates"). The Reason why not towards the end maybe
only enable the RO writeable when necessary.

thanks

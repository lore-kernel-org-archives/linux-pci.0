Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BD4C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 12:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11782183E
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 12:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="YRHfI4D+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfC2MAt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:00:49 -0400
Received: from mail-eopbgr790074.outbound.protection.outlook.com ([40.107.79.74]:7728
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729438AbfC2MAs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 08:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zvht1XmdfagwXU64Ii5ZRdVS9TszBL6z8T6aekXxQA=;
 b=YRHfI4D+quRfdJYh6iYMekXV1MgnG22SL/xQLvj/2V71wr4ak+qW7heQmilgJm5VT/NqlbR02JWywhhrjuWWsoyU/jkjYxr4ebf/69gzigadyCHDLjkGCX6tWPbElNx/FyhyAV8LlolTaRt2GjV5s7pMDZn/+cQQWgymO71a134=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4677.namprd03.prod.outlook.com (20.179.91.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 12:00:45 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 12:00:45 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 3/5] PCI: dwc: Free MSI in the error code path of
 dw_pcie_host_init()
Thread-Topic: [PATCH v3 3/5] PCI: dwc: Free MSI in the error code path of
 dw_pcie_host_init()
Thread-Index: AQHU3XDIG15Khrp4M0yWqpbAI3kJ06YhVumAgAE6IIA=
Date:   Fri, 29 Mar 2019 12:00:45 +0000
Message-ID: <20190329195301.30971bc1@xhacker.debian>
References: <20190318174415.74fd25a5@xhacker.debian>
        <20190318174841.522fb6fd@xhacker.debian>
        <689f8a0f-ba79-da80-d0e3-24ef6814a9aa@arm.com>
In-Reply-To: <689f8a0f-ba79-da80-d0e3-24ef6814a9aa@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:404:14::20) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7b253f7-b880-440f-e743-08d6b43e2cde
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4677;
x-ms-traffictypediagnostic: BYAPR03MB4677:
x-microsoft-antispam-prvs: <BYAPR03MB4677EE20A0BA08EECE462D2EED5A0@BYAPR03MB4677.namprd03.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(229853002)(53936002)(54906003)(478600001)(97736004)(106356001)(446003)(316002)(105586002)(86362001)(102836004)(6916009)(7736002)(476003)(9686003)(66066001)(305945005)(11346002)(256004)(6246003)(71200400001)(3846002)(72206003)(71190400001)(8676002)(50226002)(6116002)(4326008)(25786009)(8936002)(2906002)(6512007)(14454004)(486006)(6436002)(1076003)(81166006)(81156014)(186003)(68736007)(52116002)(53546011)(26005)(76176011)(99286004)(5660300002)(6506007)(6486002)(386003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4677;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3HYPmrRt9ZQEZpyRqFpfFXF2WywbuM0aVmLGAEhaBgpFI4K6iAIEJqY1ze9OFCaa7cMMTTM5rgeefW+VENI8Hdda3TSrz7Xu1YXwb79QwKvpl21voM28Ff1Ch+RcXLFLPAr5ph6hL9+GuNlcNQz2+uDUR8aNwc2/7RwKdVO8mv3p/pE7ntPvfpxyBgozAoD3QeRz7uJUn//1R+TcSPFXTBYOY1fIk0ryAtuZ7lCjQcbFKmvqKrtb2RL8D0FvITIU7B+hIDBcmg2l/W4qTAhCRax6t7OmlBNMb27J/gZ1DNm6AFmjiM+/u3rjruP1OY48XgVeOGRNi9HCDf+soWRwt85aAL4o89G16r83vDYDggB0tYVe2IEVxla02NUqDQUUCbEa9MA8nDXm4RUAXlQqmW0Spoy4WJL4xGXA+42U63o=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2370BD0DC888E844AA9EE49392686980@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b253f7-b880-440f-e743-08d6b43e2cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 12:00:45.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4677
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Mar 2019 17:08:43 +0000 Robin Murphy wrote:

>=20
>=20
> On 18/03/2019 09:56, Jisheng Zhang wrote:
> > If we ever did some msi related initializations, we need to call
> > dw_pcie_free_msi() in the error code path.
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> > index a71b874ae3c0..585080699675 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -483,7 +483,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >       if (pp->ops->host_init) {
> >               ret =3D pp->ops->host_init(pp);
> >               if (ret)
> > -                     goto error;
> > +                     goto err_free_msi;
> >       }
> >
> >       pp->root_bus_nr =3D pp->busn->start;
> > @@ -497,7 +497,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >
> >       ret =3D pci_scan_root_bus_bridge(bridge);
> >       if (ret)
> > -             goto error;
> > +             goto err_free_msi;
> >
> >       bus =3D bridge->bus;
> >
> > @@ -513,6 +513,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >       pci_bus_add_devices(bus);
> >       return 0;
> >
> > +err_free_msi:
> > +     if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled() && =20
>=20
> pci_msi_enabled() already has a stub for !CONFIG_PCI_MSI, so you
> shouldn't need an explicit IS_ENABLED() here.

Indeed, thanks very much. updated in V4

Thanks

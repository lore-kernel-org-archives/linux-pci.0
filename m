Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC57C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 16:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5513C20850
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 16:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q9m+nDT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfDJQAD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:00:03 -0400
Received: from mail-eopbgr820043.outbound.protection.outlook.com ([40.107.82.43]:23720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728970AbfDJQAC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 12:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oVD4x0YEOIuH206/23D/Y0QucKx9Yz0NqOseqXWq8A=;
 b=Q9m+nDT1DFQZO3oaCt/iGN3JPLWu3VRemW8E4WOVEJD0gn4paVHVPWbbXD4cq519dTXngWv/KuV4Mvo+ZjRYinR70qdKFy1P9i9/a6YzicbweGhleRs7kXrhYElgdKGGS1WZ5+xP6uumMoS4tCyip6iukrkwvYd9aDYNQopR71c=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.17) by
 BN6PR12MB1555.namprd12.prod.outlook.com (10.172.18.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Wed, 10 Apr 2019 15:59:58 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::687a:46f8:c99c:a46c]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::687a:46f8:c99c:a46c%2]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 15:59:58 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Nikolai Kostrigin <nickel@altlinux.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon R7
 GPUs
Thread-Topic: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon R7
 GPUs
Thread-Index: AQHU7x+DAmu/NcPAdEyJYqSbzdz726Y1cLAwgAAcggA=
Date:   Wed, 10 Apr 2019 15:59:57 +0000
Message-ID: <BN6PR12MB18094BA9F4011E6698A56742F72E0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190408103725.30426-1-nickel@altlinux.org>
 <20190408103725.30426-2-nickel@altlinux.org>
 <20190409215927.GC256045@google.com>
 <BN6PR12MB1809C529684D59E8DF3D1F0FF72E0@BN6PR12MB1809.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB1809C529684D59E8DF3D1F0FF72E0@BN6PR12MB1809.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [208.253.63.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f7ba6f4-0035-442d-cf2e-08d6bdcd94c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN6PR12MB1555;
x-ms-traffictypediagnostic: BN6PR12MB1555:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BN6PR12MB15556CAF79620377AE5F4B80F72E0@BN6PR12MB1555.namprd12.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(13464003)(199004)(8936002)(7736002)(97736004)(2940100002)(14444005)(6436002)(5660300002)(256004)(4326008)(25786009)(33656002)(74316002)(6116002)(3846002)(81156014)(105586002)(476003)(305945005)(11346002)(52536014)(81166006)(14454004)(446003)(71200400001)(102836004)(8676002)(229853002)(86362001)(486006)(316002)(55016002)(110136005)(2906002)(66066001)(6636002)(6306002)(53936002)(71190400001)(93156006)(53546011)(966005)(72206003)(54906003)(99286004)(7696005)(26005)(68736007)(6506007)(9686003)(93886005)(186003)(478600001)(6246003)(106356001)(76176011)(45080400002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1555;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TcDs/GiwRnJucLsYhdyGSW1iaiHxa6jZoKrLsY8H25YuR1/RItvHUjKUxMCJWjyuALwQ5S67jIeyNGRJSwXNsUZrhFnW3V42MwJukbx3kzmQvijLcSHYqCG/t3WzbGdlPVCjpI/2z6C1vDvtCuMMy2GbAY39BOyCB/xoIOOWQcQ3Oc9WP3QUp/dS4qOxfocHC/zLaE9663koCMvQLd1OvlRa4NuwpI6LsGt/IveVTEyPO8Q8gFWR467OlIPdG4S55U5mQg1KXV1NcwqSQ2J2xokuOa32reAFWDQ9NAKiCRvxaAjgtyyYImd9S1VpC/Y4yzL5MpVdKN8Z7xL0vMN0wPYxsOPj6bhz+SWaYJ0t0EFEaatLRVMkSiCFDlk2jn4lqLbqBwjdgnuh4pTogi+JmuhvL3XynL0crDP1uXtl8gI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7ba6f4-0035-442d-cf2e-08d6bdcd94c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 15:59:57.8728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1555
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Deucher, Alexander
> Sent: Wednesday, April 10, 2019 10:47 AM
> To: Bjorn Helgaas <helgaas@kernel.org>; Nikolai Kostrigin
> <nickel@altlinux.org>; Suthikulpanit, Suravee
> (Suravee.Suthikulpanit@amd.com) <Suravee.Suthikulpanit@amd.com>;
> Lendacky, Thomas <Thomas.Lendacky@amd.com>; Kuehling, Felix
> (Felix.Kuehling@amd.com) <Felix.Kuehling@amd.com>; Koenig, Christian
> (Christian.Koenig@amd.com) <Christian.Koenig@amd.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> jroedel@suse.de
> Subject: RE: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon
> R7 GPUs
>=20
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Tuesday, April 9, 2019 5:59 PM
> > To: Nikolai Kostrigin <nickel@altlinux.org>
> > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > jroedel@suse.de; Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD
> > Radeon
> > R7 GPUs
> >
> > [+cc Alex]
> >
> > This claims to be a resend, but I don't see a previous posting.
> >
> > There *was* discussion when the quirk was added two years ago for a
> > different device.  As part of that, Alex thought only that device
> > would be affected and ATS was validated on other GPUs:
> >
> >
> >
> https://lore.kernel.org/lkml/BN6PR12MB165278346BE8A76B1E4412AFF7EA0
> > @BN6PR12MB1652.namprd12.prod.outlook.com/
> >
> > On Mon, Apr 08, 2019 at 01:37:25PM +0300, Nikolai Kostrigin wrote:
> > > ATS is broken on this hardware (at least for Stoney Ridge based
> > > laptop) and causes IOMMU stalls and system failure. Disable ATS on
> > > these devices to make them usable again with IOMMU enabled Thanks
> to
> > > Joerg Roedel <jroedel@suse.de> for help.
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D194521
> > >
>=20
> + a few AMD people
>=20
> Seeing this bug makes it more clear.  I don't think this is a problem wit=
h the
> GPU.  I think it's a problem with either the sbios or iommu.  I think the=
 original
> quirk added for stoney (0x98e4) is probably wrong as well.  I suspect we
> need a quirk for a particular laptop or sbios versions.  We validated ATS
> extensively with Carrizo based systems (the system in the bug report abov=
e
> is Carrizo based) since it is the basis of our ROCm support on APUs.  We =
have
> also been involved in tons of Linux OEM preloads with both Carrizo and
> Stoney based APUs in combination with TOPAZ dGPUs (0x6900) and haven't
> seen this issue in those programs.  We also have TOPAZ dGPUs used in OEM
> programs with Intel chipsets and haven't seen the issue.  I suspect since
> windows does not use the IOMMU by default, the sbios settings may not be
> well validated on certain windows only skus.  I'd rather make these DMI
> matches or something like that for the platform or at the very least matc=
h
> the SSIDs as well.

Reading through these bugs again it seems to be an issue with Stoney APUs, =
not the dGPU specifically.  I think it would be better to disable ATS in ge=
neral if a stoney based platform was detected rather than adding ATS quirks=
 for devices then someone may put in a Stoney based platform.  It also seem=
s to be related to runtime pm on the dGPU.  Disabling runtime pm also seem =
to fix the issue.  On these systems runtime pm for the dGPU is controlled v=
ia ACPI (either ATPX or _PR3 depending on the platform).  Maybe something d=
oesn't get restored properly on runtime resume which cases the ATS issues?

Alex

>=20
> Alex
>=20
> > > Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>
> >
> > Joerg, I'm happy to merge this if you would review or ack it.  I don't
> > know enough to conclude that this is the root cause.  It'd be nice to
> > have an actual AMD erratum.  Maybe it would even have a list of
> > affected devices so we could get them all at once so people wouldn't
> > have to trip over them one by one.
> >
> > > ---
> > >  drivers/pci/quirks.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > > 4700d24e5d55..abb2532e16bf 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -4876,6 +4876,7 @@ static void quirk_no_ats(struct pci_dev *pdev)
> > >
> > >  /* AMD Stoney platform GPU */
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4,
> quirk_no_ats);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900,
> > quirk_no_ats);
> > >  #endif /* CONFIG_PCI_ATS */
> > >
> > >  /* Freescale PCIe doesn't support MSI in RC mode */
> > > --
> > > 2.21.0
> > >

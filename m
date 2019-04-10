Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE8EC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 14:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69789205F4
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 14:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DoqS19R+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbfDJOql (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:46:41 -0400
Received: from mail-eopbgr820059.outbound.protection.outlook.com ([40.107.82.59]:41280
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732418AbfDJOql (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 10:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOWrc3OPZFm84Qd/q3nvXFBQNf4w5CHpWzMIvjDT84s=;
 b=DoqS19R+CfiO4Yn6jjNKE6dBQabV4BFv3t2UcJoevUkbA+Anr7ryh6wc2Gbee1sZLr3Noqdwfi5KNXHEn8LuvzzdxdgWSLllKOnPnUIPIMFjmcgZ8MGn5m8TyzZNko/4I6vkNvRC9Oyg8E6D3e/J3wMRhgX6AmET+GAIFI9iGuE=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.17) by
 BN6PR12MB1633.namprd12.prod.outlook.com (10.172.18.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 10 Apr 2019 14:46:37 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::687a:46f8:c99c:a46c]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::687a:46f8:c99c:a46c%2]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 14:46:37 +0000
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
Thread-Index: AQHU7x+DAmu/NcPAdEyJYqSbzdz726Y1cLAw
Date:   Wed, 10 Apr 2019 14:46:37 +0000
Message-ID: <BN6PR12MB1809C529684D59E8DF3D1F0FF72E0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190408103725.30426-1-nickel@altlinux.org>
 <20190408103725.30426-2-nickel@altlinux.org>
 <20190409215927.GC256045@google.com>
In-Reply-To: <20190409215927.GC256045@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [208.253.63.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34b96f16-1d32-4e12-8030-08d6bdc355ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BN6PR12MB1633;
x-ms-traffictypediagnostic: BN6PR12MB1633:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BN6PR12MB1633B8238476C83871F50BB5F72E0@BN6PR12MB1633.namprd12.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39860400002)(396003)(376002)(199004)(189003)(13464003)(305945005)(6306002)(74316002)(446003)(5660300002)(105586002)(106356001)(9686003)(6636002)(97736004)(256004)(25786009)(52536014)(71190400001)(71200400001)(86362001)(14444005)(486006)(476003)(4326008)(110136005)(8676002)(6436002)(81156014)(966005)(478600001)(6246003)(45080400002)(72206003)(186003)(66066001)(14454004)(81166006)(99286004)(53546011)(26005)(6116002)(33656002)(6506007)(102836004)(68736007)(7696005)(53936002)(2906002)(229853002)(316002)(55016002)(3846002)(7736002)(76176011)(54906003)(11346002)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1633;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ihqDHKd65r8kcD5NjKULe/+fCQ8RfeKawFRlV0zKqzzurJQBRlGjgj5xbJiHa5G7pH1ysG9Hv9iF16gTg/b6VFlS8V6ZcviHb3rI3JffQIAkN3VRbG0k8YJW2RHRE1rOjcXyWE1eJyvGKN2AQUlJ14r3Wvl2+TGQ2dnBENUZmQ/NB8e0Utb19vTjhO4HTvn/9fpToyzSEmagcjSf0Ru7R/tFXle9WgMZjn5RUbX/by3i46RoDBcoQ4nM4wKT75EuSE+G/QJEI5L02H10uQUGqZwHAoodwDOkVcuhUspthzdeg+RdQWvWMQqaHgQoFKNP7XU6CDL28lXFfk0dMOHqBNwgZQuKRYthvciTRz/dTkLeutPDF2rdq/HURptaZ/IsVYHkulFw8JPIc+SD6RWN9GMvylf/bHwoAhdLFAffqMQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b96f16-1d32-4e12-8030-08d6bdc355ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 14:46:37.3741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1633
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, April 9, 2019 5:59 PM
> To: Nikolai Kostrigin <nickel@altlinux.org>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> jroedel@suse.de; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon
> R7 GPUs
>=20
> [+cc Alex]
>=20
> This claims to be a resend, but I don't see a previous posting.
>=20
> There *was* discussion when the quirk was added two years ago for a
> different device.  As part of that, Alex thought only that device would b=
e
> affected and ATS was validated on other GPUs:
>=20
>=20
> https://lore.kernel.org/lkml/BN6PR12MB165278346BE8A76B1E4412AFF7EA0
> @BN6PR12MB1652.namprd12.prod.outlook.com/
>=20
> On Mon, Apr 08, 2019 at 01:37:25PM +0300, Nikolai Kostrigin wrote:
> > ATS is broken on this hardware (at least for Stoney Ridge based
> > laptop) and causes IOMMU stalls and system failure. Disable ATS on
> > these devices to make them usable again with IOMMU enabled Thanks to
> > Joerg Roedel <jroedel@suse.de> for help.
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D194521
> >

+ a few AMD people

Seeing this bug makes it more clear.  I don't think this is a problem with =
the GPU.  I think it's a problem with either the sbios or iommu.  I think t=
he original quirk added for stoney (0x98e4) is probably wrong as well.  I s=
uspect we need a quirk for a particular laptop or sbios versions.  We valid=
ated ATS extensively with Carrizo based systems (the system in the bug repo=
rt above is Carrizo based) since it is the basis of our ROCm support on APU=
s.  We have also been involved in tons of Linux OEM preloads with both Carr=
izo and Stoney based APUs in combination with TOPAZ dGPUs (0x6900) and have=
n't seen this issue in those programs.  We also have TOPAZ dGPUs used in OE=
M programs with Intel chipsets and haven't seen the issue.  I suspect since=
 windows does not use the IOMMU by default, the sbios settings may not be w=
ell validated on certain windows only skus.  I'd rather make these DMI matc=
hes or something like that for the platform or at the very least match the =
SSIDs as well.

Alex

> > Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>
>=20
> Joerg, I'm happy to merge this if you would review or ack it.  I don't kn=
ow
> enough to conclude that this is the root cause.  It'd be nice to have an =
actual
> AMD erratum.  Maybe it would even have a list of affected devices so we
> could get them all at once so people wouldn't have to trip over them one =
by
> one.
>=20
> > ---
> >  drivers/pci/quirks.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > 4700d24e5d55..abb2532e16bf 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4876,6 +4876,7 @@ static void quirk_no_ats(struct pci_dev *pdev)
> >
> >  /* AMD Stoney platform GPU */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900,
> quirk_no_ats);
> >  #endif /* CONFIG_PCI_ATS */
> >
> >  /* Freescale PCIe doesn't support MSI in RC mode */
> > --
> > 2.21.0
> >

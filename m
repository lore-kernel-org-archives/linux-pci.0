Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E01C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 04:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE6F2081B
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 04:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fJPLol4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE6F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeK1PcN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:32:13 -0500
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:13028
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbeK1PcM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 10:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfbMlNNXuOtmfiWj9CoRWBvRnhMjrRLDgLFwsREIJco=;
 b=fJPLol4h7u9+U5SM9Fo1D1kGVBslO3+CBSoWjNZLe5086GiqjL4E4o0+FVBR070Kp19hpWAS91M/eUvd4ObWAv1wI/Fe17DN5f+kbeOZP2PT5PfY06pgw7J7ZeeAuLnp1hh3bgnv+JYg7TUAOKkkV3o4ENL3A5KkMHiwUnBc2uw=
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) by
 VI1PR04MB4863.eurprd04.prod.outlook.com (20.177.49.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 28 Nov 2018 04:31:56 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a%2]) with mapi id 15.20.1339.032; Wed, 28 Nov 2018
 04:31:56 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Chris Blake <chrisrblake93@gmail.com>
Subject: RE: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Thread-Topic: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Thread-Index: AQHUhi2yh4+Qm28J50ixacdSn4eZIqVjwNwAgAAJqACAALvmYA==
Date:   Wed, 28 Nov 2018 04:31:56 +0000
Message-ID: <VI1PR04MB48457E23AA3354316C7782D69AD10@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20181127083454.26560-1-Bharat.Bhushan@nxp.com>
        <20181127153356.GA112381@google.com> <20181127090830.084fedf1@x1.home>
In-Reply-To: <20181127090830.084fedf1@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4863;6:aF6s8CsSAyvs7RehX7dX+KM6uW7jMuBrDhsGKYov26Na0ZkqKDj2/Wlm2r8fgnpyKz+wnDFPmlStStEWJiUdxmaVtRGe6jB1xn6gDFSuDMyiUwNVpfxB2pHiCHEX8MfLTK6M45yKgyA5jHjNoyAUwRI5+5Fzg3VW4rTcorDF7b7+a4RUE9ICstlcs2ES/Ik7E6Di8lDrscv0wZpLilpiL2Z6NQq2YiNPjEunVNLyoXw/LYHZudzxNzv7xa6FfC+uiJMXpajB4H+B7l3pDBAa9a401pNdzC2nOf0EWvh/cOQfc+V4OA0DwnhCReh7wrs4WGgyp8GhsrswDHYo8YwAhb2V/0dQAaDk+S+jYq3CkdfD2cj+Y5QmBYvZITWrH0DoC4G3ZyClqPiG8Qnq1ZWsyE4p+RwBMtbJp5qHxrF/geok3t7rQwa/NkbKPtwo/g3L04bRvvJlobt+qyZ9vjdrdw==;5:Y36KgIUDH97JFPTzt9Kwl39VVDenwPx4hjoaT69xseuhG/+LkkCE/ig2dZ/DosKLEvLh7lfhOuogjbFbrUp5u09AMCJ47JKNeW+ZevrCJqnR+d3n5or6SL4feZRGHeQrLWSv/q5C20B1+t83E4yeA6riEAznfIV7U4wTeByaB1o=;7:VBGq2AFLRB78nFdi9WhEGeod0k1C0kK6t68h+RSDtScM7BTIvGH+/JxfvbbnkRZg0z55z6CXw2+v+zD/S/I/Jud2qJfX+PtzgkRrY3ecR+L2mq8qBCmswAvwhPYnwUZ8TTzRoAABATYki/7jEKobrQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dc25b543-296e-475d-dd4e-08d654ea6de8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4863;
x-ms-traffictypediagnostic: VI1PR04MB4863:
x-microsoft-antispam-prvs: <VI1PR04MB48637CBD13CE849F07153BC09AD10@VI1PR04MB4863.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4863;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4863;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(13464003)(199004)(189003)(54094003)(9686003)(55236004)(53936002)(3846002)(6116002)(7696005)(44832011)(4326008)(6306002)(14454004)(8936002)(81156014)(81166006)(99286004)(102836004)(8676002)(74316002)(26005)(6506007)(71190400001)(33656002)(45080400002)(486006)(53546011)(5660300001)(11346002)(97736004)(39060400002)(55016002)(966005)(305945005)(6246003)(68736007)(186003)(86362001)(575784001)(78486014)(6436002)(105586002)(316002)(66066001)(446003)(229853002)(25786009)(478600001)(256004)(76176011)(14444005)(71200400001)(2906002)(476003)(110136005)(7736002)(54906003)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4863;H:VI1PR04MB4845.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d4SqyLiCBjYubNUOCdd2ecA967MrC1FFUt6zQ7+dyPiu0Ai4MVbSud1snAfDF8Rh5SoPk1Fo+mmgsL+cvYw7STPcPhz1sbc3ibASmrSm7/YxTxSnIdwSlpORs6z3jmcQx0s3ywLK5/nQsPsYzFay6w0a6kB5EWRLerXWyMW0HByT+l/JH/ZJbZ2HyXPLv+msjOL8Lkpzg1ha0SzPdsdvewlBpfUc9okyeeJF5jy7k4WXEn4Q2aSmmW6++km/bJ1inTFq9pNPkfIH+JodF9H/4yMzpVaaYWXZkffVAk2N0q1vhDUo859GkgxmYrHHebDxUW4S1sxz9Fdu7vTiyAJUntvgjSxZOAckk4RCVfr2xgQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc25b543-296e-475d-dd4e-08d654ea6de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 04:31:56.1468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4863
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Tuesday, November 27, 2018 9:39 PM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Bharat Bhushan <bharat.bhushan@nxp.com>; linux-pci@vger.kernel.org;
> linux-kernel@vger.kernel.org; bharatb.yadav@gmail.com; David Daney
> <david.daney@cavium.com>; Jan Glauber <jglauber@cavium.com>; Maik
> Broemme <mbroemme@libmpq.org>; Chris Blake
> <chrisrblake93@gmail.com>
> Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
>=20
> On Tue, 27 Nov 2018 09:33:56 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> > [+cc David, Jan, Alex, Maik, Chris]
> >
> > On Tue, Nov 27, 2018 at 08:46:33AM +0000, Bharat Bhushan wrote:
> > > NXP (Freescale Vendor ID) LS1088 chips do not behave correctly after
> > > bus reset with e1000e. Link state of device does not comes UP and so
> > > config space never accessible again.
> >
> > Previous similar commits:
> >
> >   822155100e58 ("PCI: Mark Cavium CN8xxx to avoid bus reset")
> >   8e2e03179923 ("PCI: Mark Atheros AR9580 to avoid bus reset")
> >   9ac0108c2bac ("PCI: Mark Atheros AR9485 and QCA9882 to avoid bus
> reset")
> >   c3e59ee4e766 ("PCI: Mark Atheros AR93xx to avoid bus reset")
> >
> > 1) Please make your subject match (remove the spurious "bus" at the
> > end)

Will correct, added by mistake=20

> >
> > 2) This should probably be marked for stable (v3.14 and later, since
> > the quirk itself appeared in v3.19 and marked for v3.14 and later
> > stable kernels).  Maybe even mark it as "Fixes: c3e59ee4e766..." to
> > connect it.

Ok,

> >
> > 3) The 1957:80c0 PCI ID doesn't appear in
> >
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpci
> -
> ids.ucw.cz%2F&amp;data=3D02%7C01%7Cbharat.bhushan%40nxp.com%7C296
> 02a2efa584249221808d65482945b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C636789317139032063&amp;sdata=3D3jkRMa1NljSCp%2BvZP0kgz7D
> PWPJZH8d7JXhCE5vCCMk%3D&amp;reserved=3D0; can you add it?
> >

Yes, I will add

> > 4) Is there a hardware erratum for this?  If so, please include the
> > URL here.

No h/w errata as of now.

> >
> > 5) Can you reproduce the problem using the same endpoint (e1000e) on a
> > different system with a different bridge?

I have multiple LS1088 boards and I can observe problem with all LS1088 boa=
rds.
While when I  uses same PCI device on other NXP board (LS2088) then it work=
s fine.

> >
> > 6) Have you looked at this with a PCIe analyzer?  It would be very
> > interesting to compare the boot-time or system reboot path with the
> > individual bus reset path you're fixing.

I have not used PCIe analyzer,=20

> >
> > Since there are several similar reports and they sometimes involve the
> > same devices (both your patch and 822155100e58 mention e1000e), I'm a
> > little suspicious that we're doing something wrong in the bus reset
> > path.
>=20
> I agree, entirely excluding bus resets is not something to be taken light=
ly.  It's
> less than ideal for an endpoint and a fairly major functional gap for a
> downstream port.  It should really be considered a last resort.
>=20
> > I think bus reset uses Secondary Bus Reset in the Bridge Control
> > register.  That's a generic mechanism that I would expect to be pretty
> > well-tested.  I suspect the BIOS probably uses it in the reboot path,
> > and the device probably works after that.
> >
> > So I wonder if the Linux delay isn't quite long enough, or our first
> > access to the device isn't quite right, e.g., maybe there's some issue
> > with the bus/device number capture (PCIe r4.0, sec 2.2.6.2).
>=20
> Tweaking the delay would be a reasonable solution, though we are seeing
> some issues where users with lots of assigned devices that require bus
> resets experience long delays as vfio file descriptors are closed sequent=
ially
> on exit.

In pci_reset_secondary_bus() I have tried to increase the delay after reset=
 but not helped.=20
Do I need to add delay at some other place as well?=20

Thanks
-Bharat

>  So perhaps we could flag downstream ports requiring an extra delay,
> if that becomes a solution.  Your mention of the bus/device number also
> reminds me of the issue we saw on Threadripper where there were patches
> proposed to re-write the secondary and subordinate bus numbers after
> reset.  AMD was able to resolve that in a firmware update, but there coul=
d
> be something similar occurring here. Thanks,
>=20
> Alex
>=20
> > > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > > ---
> > >  drivers/pci/quirks.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > > 4700d24e5d55..b9ae4e9f101a 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -3391,6 +3391,13 @@
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033,
> quirk_no_bus_reset);
> > >   */
> > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100,
> > > quirk_no_bus_reset);
> > >
> > > +/*
> > > + * NXP (Freescale Vendor ID) LS1088 chips do not behave correctly
> > > +after
> > > + * bus reset. Link state of device does not comes UP and so config
> > > +space
> > > + * never accessible again.
> > > + */
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x80c0,
> > > +quirk_no_bus_reset);
> > > +
> > >  static void quirk_no_pm_reset(struct pci_dev *dev)  {
> > >  	/*
> > > --
> > > 2.19.1
> > >


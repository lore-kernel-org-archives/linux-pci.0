Return-Path: <SRS0=dobd=5V=dell.com=Narendra.K@kernel.org>
Return-Path: <SRS0=dobd=5V=dell.com=Narendra.K@kernel.org>
From: <Narendra.K@dell.com>
Cc: <x86@kernel.org>, <linux-pci@vger.kernel.org>, <Jordan.Hargrave@dell.com>,
	<Shyam.Iyer@dell.com>, <bhelgaas@google.com>, <Narendra.K@dell.com>
To: <helgaas@kernel.org>, <jdelvare@suse.de>
Subject: RE: dmi type 0xB1 record - unknown flag
Date: Fri, 16 Jun 2017 09:36:27 +0000
Message-ID: <fb0d720dc6c441539fb5130d2628158f@BLRX13MDC105.AMER.DELL.COM>
References: <20170601143826.5f980444@endymion>
 <68181b62786540ed8ca6ab877151a98b@BLRX13MDC105.AMER.DELL.COM>
 <20170602161311.27eab72d@endymion>
 <20170615213935.GH12735@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170615213935.GH12735@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Friday, June 16, 2017 3:10 AM
> To: Jean Delvare <jdelvare@suse.de>
> Cc: K, Narendra <Narendra_K@Dell.com>; x86@kernel.org; linux-
> pci@vger.kernel.org; Hargrave, Jordan <Jordan_Hargrave@Dell.com>; Iyer,
> Shyam <Shyam_Iyer@Dell.com>; bhelgaas@google.com
> Subject: Re: dmi type 0xB1 record - unknown flag
>=20
> On Fri, Jun 02, 2017 at 04:13:11PM +0200, Jean Delvare wrote:
> > ...
> > I think the whole thing can be simplified like this:
> >
> > From: Jean Delvare <jdelvare@suse.de>
> > Subject: x86/PCI: Simplify Dell DMI B1 quirk
> >
> > No need for such convoluted code, when all we need is to call one
> > function in one specific case.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
>=20
> Applied to pci/misc for v4.13, thanks!
>=20
> As far as I can tell, the new code is functionally equivalent to the old =
code, so
> I don't think there's any risk here.
>=20

Hi Jean/Bjorn,

Sorry for the delay. I applied the patch to the mainline kernel version 4.1=
2-rc5 and performed sanity test on  a  DellEMC PowerEdge R730XD system. It =
is working as=20
expected.  'dmesg' shows the message that 'pci=3Dbfsort' is enabled.

I also booted kernel version 4.12-rc5 with patch applied on a DellEMC Power=
Edge 1950 system which is listed in the ' pciprobe_dmi_table' quicks table.
It is working as expected and has not caused regression on this system. 'dm=
esg' shows the message that 'pci=3Dbfsort' is enabled.

[...]
> >
> > What do you think?
=20
Thank you for simplifying the code and for the patch.=20

With regards,
Narendra K

Return-Path: <SRS0=oZDb=5H=dell.com=Narendra.K@kernel.org>
Return-Path: <SRS0=oZDb=5H=dell.com=Narendra.K@kernel.org>
From: <Narendra.K@dell.com>
Cc: <jdelvare@suse.de>, <x86@kernel.org>, <linux-pci@vger.kernel.org>,
	<Jordan.Hargrave@dell.com>, <Shyam.Iyer@dell.com>, <bhelgaas@google.com>,
	<Sujith.Pandel@dell.com>
To: <helgaas@kernel.org>
Subject: RE: dmi type 0xB1 record - unknown flag
Date: Fri, 2 Jun 2017 09:47:55 +0000
Message-ID: <9b04fb5e2db744b29f660809197a2b52@BLRX13MDC105.AMER.DELL.COM>
References: <20170601143826.5f980444@endymion>
 <68181b62786540ed8ca6ab877151a98b@BLRX13MDC105.AMER.DELL.COM>
 <20170601165959.GB12257@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170601165959.GB12257@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Thursday, June 1, 2017 10:30 PM
> To: K, Narendra <Narendra_K@Dell.com>
> Cc: jdelvare@suse.de; x86@kernel.org; linux-pci@vger.kernel.org; Hargrave=
,
> Jordan <Jordan_Hargrave@Dell.com>; Iyer, Shyam
> <Shyam_Iyer@Dell.com>; bhelgaas@google.com
> Subject: Re: dmi type 0xB1 record - unknown flag

[...]
> > The value 0x00 is not a valid value. When the flag is 0x00, the sort
> > method will be the default that is decided by the kernel.
> >
> > There is no additional handling required for such a system.
>=20
> That was added by 6e8af08dfa40 ("PCI: enable pci=3Dbfsort by default on
> future Dell systems").
>=20
> The fact that BIOS supplied a B1 record with an unknown value (0) looks l=
ike a
> Dell BIOS defect, which is ironic, considering that Dell added this thing=
 in the
> first place.
>=20
> I think we should remove the message, since it is alarming to users and t=
hey
> can't do anything about it anyway.
>=20

Hi Bjorn,

Thank you for the feedback. We will submit a patch to remove the message.=20

With regards,
Narendra K

Return-Path: <SRS0=ztmW=BK=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=ztmW=BK=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <helgaas@kernel.org>
CC: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: RE: PCIe error reporting
Date: Wed, 11 Oct 2017 16:00:04 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD009155B@AcuExch.aculab.com>
References: <063D6719AE5E284EB5DD2968C1650D6DD008D9F2@AcuExch.aculab.com>
 <20171010211035.GY25517@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0090E73@AcuExch.aculab.com>
 <063D6719AE5E284EB5DD2968C1650D6DD00911C9@AcuExch.aculab.com>
 <20171011132525.GF25517@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171011132525.GF25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas
> Sent: 11 October 2017 14:25
..
> The current Linux behavior is based on the spec I cited above, which
> says
>=20
>   If any bits in the Control Field are returned cleared (masked to
>   zero) by the _OSC control method, the respective feature is
>   designated unsupported by the platform and must not be enabled by
>   the operating system. Some of these features may be controlled by
>   platform firmware prior to operating system boot or during runtime
>   for a legacy operating system, while others may be
>   disabled/inoperative until native operating system support is
>   available.

That is a strange statement.

What an earth have 'legacy operating system' and 'native operating
system' got to do with whether the ACPI features can be enabled.
How are we supposed to write the os support if the features are
disabled until it is available!

My best guess is that these are disabled because of bugs in windows.
Or maybe because some windows vendor drivers are writing to the
registers and it all goes horribly wrong if the os (windows) do so
as well.

Rather reminds me of the 'pnp aware os' bios question that was really
asking 'are you running windows 95'.

I've checked the bios setup - nothing useful.

> If Linux is handling _OSC correctly (always a question, since it's
> quite complicated), it sounds like your platform is telling Linux not
> to enable AER.
>=20
> You could experimentally make Linux enable AER anyway, but it's hard
> for me to see how we could do that safely in general.

Lets my try to get that system running a custom kernel...

> The short answer probably is "complain to your platform vendor".
LOL

	David

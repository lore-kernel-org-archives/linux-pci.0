Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5196BF15.3050208@ubuntu.com>
Date: Fri, 17 May 2013 19:36:53 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: enabling aspm on ati radeon
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan> <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com> <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com> <5196713A.1010102@ubuntu.com> <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com> <51968E9F.1010909@ubuntu.com> <CAErSpo6ZKB-4PTa_2Cthx_8S2txCbGyatbPmDUPYexCQFg-A=A@mail.gmail.com> <51969D30.1070502@ubuntu.com> <CAErSpo4H-=dnHON3vDvJEme2hGD0z0r_NSsm-Bk9tZ4QqtBTCw@mail.gmail.com>
In-Reply-To: <CAErSpo4H-=dnHON3vDvJEme2hGD0z0r_NSsm-Bk9tZ4QqtBTCw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/17/2013 05:28 PM, Bjorn Helgaas wrote:> A link has two ends.
Both ends have to support ASPM in order for it
> to work.  But ASPM on a particular link has no dependency on
> things elsewhere in the hierarchy.

Got you... I guess I was still thinking regular PCI and the naming
"root complex" made me think it was the whole root bridge, when it
really is that particular x16 pcie port that goes to the radeon.

> The link between 00:01.0 and 01:00.0 apparently only supports ASPM 
> on one end (the downstream end), so ASPM won't work on it.

I'll check the Intel spec sheet again, but I'm pretty sure it really
does support ASPM.  The CPU probably allows writes to the register,
and my bios must have configured it to say it doesn't support aspm.  I
guess I just need to wrangle setpci into trying to enable it despite
it not advertising support, or maybe see if I can get grub to poke the
capability register to make it say it supports it.

One question I have though is how to identify which port device
corresponds to which downstream device connected to it.  In other
words, how do you know 00:01.0 links to 01:00.0 ( other than seeing
that it's the x16 and knowing the radeon is plugged into the x16 slot ).


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJRlr8VAAoJEJrBOlT6nu75zL8IAImEt+ql6u1pqDSFPuDlLwSE
fbFWYYxZAzEGnzbAKGMUhueKHAa4rEnH2ztM8CYxdj3GVfSoTpwgcvz21L/fq/6L
z4OtChaw2cDiCevi95BR2xry2qBLnrHNq1qbD1yb832b5njCSr5SnTvUBUiH/4pN
twEAJ3HZp7Vblts4UMmn5sOT3cGd1Yr6sJp4Y068vPSGyx5Ixm5ROYEedN5tBnBl
zkeC+2vYXk0nIbMgJLWt4ZJRxXmX3/DXt8F1VL12NzlHpotuS5rPRpTR/el3sSty
J6HH/jlgSm+L3zuSPTicVAQBvYGcRhi/NbKDFPnZGGB8E7HsE9SIwNxzjzImyV0=
=X54u
-----END PGP SIGNATURE-----

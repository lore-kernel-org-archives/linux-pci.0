Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5196C81B.8060400@ubuntu.com>
Date: Fri, 17 May 2013 20:15:23 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: enabling aspm on ati radeon
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan> <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com> <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com> <5196713A.1010102@ubuntu.com> <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com> <51968E9F.1010909@ubuntu.com> <CAErSpo6ZKB-4PTa_2Cthx_8S2txCbGyatbPmDUPYexCQFg-A=A@mail.gmail.com> <51969D30.1070502@ubuntu.com> <CAErSpo4H-=dnHON3vDvJEme2hGD0z0r_NSsm-Bk9tZ4QqtBTCw@mail.gmail.com> <5196BF15.3050208@ubuntu.com> <CAErSpo5W=Zi_2s0ywfO4VPfbUfxhhCRUMn7oRhx_mi7yYpBHmw@mail.gmail.com>
In-Reply-To: <CAErSpo5W=Zi_2s0ywfO4VPfbUfxhhCRUMn7oRhx_mi7yYpBHmw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/17/2013 07:52 PM, Bjorn Helgaas wrote:
> setpci will write whatever you tell it to; it doesn't check any 
> constraints like "is ASPM supported?"  But the Link Capabilities 
> register is read-only per spec, so likely you won't be able to
> change that field, at least not by writing it directly.

I assume it is RO according to the PCIe spec ( buggers seem to only
allow members of pcisig to download it ), but I checked the Intel
specs for the chip ( Sandybridge ) and it's RW.  It looks like it
powers up as 00 and it's up to the bios to change it to advertise the
capability, and it seems Asus didn't bother with that.

> You can always try using setpci to set the ASPM enable bits in the 
> Link Control register on both the bridge and the device.  When 
> enabling, I think you're supposed to do the upstream end of the
> link first, then the downstream end (and the reverse for
> disabling).

One thing I don't see anywhere is a status bit showing whether it
actually *is* in L0s or L1 currently, so how to know if it's working?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJRlsgbAAoJEJrBOlT6nu75mVEIAIsgXJjpqx5BTaocW3fJdq/D
6uqBiZxrIiwzCxHcsxyyq2gf2z1cwV/SExb8KCtjycZjXha4Y4awa1ba+1H8QnUe
YjLwRzsVSxlXUArwcUTrGQXsCYL5Q5IYejXAE0ki36Yfp5YvrKDLfuoKet76ROAY
cIGY7w202o9jfCVVoc2nskwXWCOuTgdfffD3Kjhg5eLnB/SxcCfbIWvxw7pNmlW1
bmzBNg3Mbs/UpGSFoSAOKl2/gzniMtjej3iXEuPy/gp/BjrT9ijExlaE5s4gdxom
12GgHMO/+rtvXE0yz9+zD0oL3A8dLUW9cc1+pX6kjiSz6j7V7guRicNP1Zw4TLU=
=VABF
-----END PGP SIGNATURE-----

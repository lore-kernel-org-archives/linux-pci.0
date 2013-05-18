Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:34028 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3ERBUo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2013 21:20:44 -0400
Message-ID: <5196D765.9020600@ubuntu.com>
Date: Fri, 17 May 2013 21:20:37 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: enabling aspm on ati radeon
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan> <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com> <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com> <5196713A.1010102@ubuntu.com> <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com> <51968E9F.1010909@ubuntu.com> <CAErSpo6ZKB-4PTa_2Cthx_8S2txCbGyatbPmDUPYexCQFg-A=A@mail.gmail.com> <51969D30.1070502@ubuntu.com> <CAErSpo4H-=dnHON3vDvJEme2hGD0z0r_NSsm-Bk9tZ4QqtBTCw@mail.gmail.com> <5196BF15.3050208@ubuntu.com> <CAErSpo5W=Zi_2s0ywfO4VPfbUfxhhCRUMn7oRhx_mi7yYpBHmw@mail.gmail.com> <5196C81B.8060400@ubuntu.com> <CAErSpo6i939JR-3psRhXjkxE3sME8AJ3P84BGX9m1HhdzJxhAg@mail.gmail.com>
In-Reply-To: <CAErSpo6i939JR-3psRhXjkxE3sME8AJ3P84BGX9m1HhdzJxhAg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/17/2013 08:40 PM, Bjorn Helgaas wrote:
> Right; I meant RO per the PCIe spec.  If it's RW on your chip,
> setpci should be able to write it.

I assume it would do no good to change it at this point; it would need
to already be set at the time the kernel reads it and decides whether
or not to enable it, so I'd have to have grub set it before loading
the kernel.

> If you can measure the power consumption, you might be able to see
> a difference there.  I've seen people report that, but don't know
> how they do it.  For example: 
> https://lkml.kernel.org/r/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com

After
> 
enabling it on both ends ( despite the root port still claiming
it is not supported ) I still see ~121 watts according to the
Kill-A-Watt my system is plugged into.  Oh well.

Now that I double check myself, I realize that I misread the Intel
spec.  I was actually looking at the description for the link control
register instead of capabilities.  It uses the word "supported"
instead of "enabled" when describing the enable bits in the control
register, and they seem to skip right over describing the capability
register.  Trying to write to that has no effect, so it seems the CPU
is really telling me it doesn't support ASPM on that link, though it
is supposed to according to the feature description section of the
data sheet.  I am at a loss.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJRltdlAAoJEJrBOlT6nu75O60IAJEEfQfoRgEP24/+5/SDIfnF
lp5rBUc0afHcvV10m/5FAN8nefVfuLn0I6Iq2sHAgKPj7VG032MYXIAddrLK0tDH
owFXqgsUTHemfsrTz+QCKQnJzZVu9iReyXRVovFF/j+jtRs9X45QD8tJHKSUKPMb
uEyy7WeAoxxT6W6cIZSWrRChUnvq3soAcUiPkGdCHJep9jM8vBjidrADENavpzl6
tSHy/jEh5Cehr5oBX8JXB3e2x4AaDj5AE2CPWq1/ttQd0FRcUWZEHOZEcL2gN3Sp
AGm5efe64Gdcl48yqP5WQuGM0K0dHXoXbRkWRNy4LOxP43gynUJWY4ulFqB06SM=
=MOhM
-----END PGP SIGNATURE-----

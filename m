Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:36870 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab3EQVMS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2013 17:12:18 -0400
Message-ID: <51969D30.1070502@ubuntu.com>
Date: Fri, 17 May 2013 17:12:16 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: enabling aspm on ati radeon
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan> <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com> <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com> <5196713A.1010102@ubuntu.com> <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com> <51968E9F.1010909@ubuntu.com> <CAErSpo6ZKB-4PTa_2Cthx_8S2txCbGyatbPmDUPYexCQFg-A=A@mail.gmail.com>
In-Reply-To: <CAErSpo6ZKB-4PTa_2Cthx_8S2txCbGyatbPmDUPYexCQFg-A=A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 5/17/2013 4:24 PM, Bjorn Helgaas wrote:
> Oh, wait a minute...  You mentioned the radeon driver.  The Radeon 
> device in your system is at 01:00.0, and that is below the 00:01.0 
> bridge that said "ASPM unknown."  If the bridge leading to the
> Radeon device doesn't support ASPM, then of course, we won't be
> able to turn on ASPM for it.

That's what I was asking about before when I said surely the bridge
higher up doesn't have to have aspm enabled in order to enable it on
the downstream link?

> That doesn't explain why we don't turn on ASPM for the *other*
> devices (03:00.0, 05:00.0, 06:00.0, 09:00.0) though.

00:01.0 says it is the root complex, so wouldn't that make it upstream
of *everything*?  As I understand it, the root complex is built into
the CPU and has 16 lanes going to the video slot, and another 4 lanes
running at gen3 speed that Intel calls the DMI that goes to the PCH,
which has some internal functions, and bridges to another 20 pcie lanes.

Since the root complex is built into the cpu, I wouldn't think ASPM
could possibly make sense on it, so it showing that it doesn't support
ASPM makes sense to me.  That doesn't seem like it should preclude
using ASPM on the link down to the video card.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRlp0wAAoJEJrBOlT6nu7543QIAMfU7GnhweyxmunYl8fKq0B9
KCX3PSQaXXmknKxKtSDPtI3BhuTN+5g9KjXX+tDngETRPwq/5ZRXhIAcNjQCpv0d
K5Io/1vh652Aa0eVm1Yae+ejBWB/hWSu/AM/U0L1wyWGqat53QwfSHlMcQOFeuxq
oHoRrE5JtmcSbRbWtXFsOgRx5iXkgMzcwDxZ93Z4djhWjYGX+pGSk0DOTlttG/AP
RyT+oKYs8BmCytk/9/PFE0v/CtaAiNjEL42WAgv3nJMNuezG/CiBeUi7q9+vqKE8
1r+kGTbenKeEkboROWHXN/JCq3IsKCkff6rQC/s+oXBdORpCw46PcwpBno5kK+Q=
=sZdM
-----END PGP SIGNATURE-----

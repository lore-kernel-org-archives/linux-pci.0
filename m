Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <51968E9F.1010909@ubuntu.com>
Date: Fri, 17 May 2013 16:10:07 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: enabling aspm on ati radeon
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan> <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com> <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com> <5196713A.1010102@ubuntu.com> <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com>
In-Reply-To: <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 5/17/2013 3:52 PM, Bjorn Helgaas wrote:
> I just sent a patch to make lspci decode all possible values
> there. In the PCIe r2.1 spec, only 1 ("L0s") and 3 ("L0s and L1")
> were defined.  The r3 spec added 0 ("not supported") and 2 ("L1"),
> but lspci hadn't quite kept up.

So do you still want the lspci -xxxs output, or was that just to
answer the question of why it said unknown instead of not supported?
Are we then back to no idea?

I notice a number of functions in drivers/pci/pcie/aspm.c that look
like they need used to configure aspm.  The radeon driver does not
appear to call any of them ( grep for aspm came up with nothing ).
Could that be why?  I can't find anything under Documentation/ about
what a driver needs to do to enable aspm.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRlo6eAAoJEJrBOlT6nu75lxQIAMwrt4oDHt5MKiRfpPWIkPO4
DLoFtEax1CGy1Gqmhvw8QpzYw+daqWzYw01t2SDd+owLEHVdp8zzqW21TSld83yb
W9EmZH4NLIO9vsR/UqAHhmbbf9ooAwz+O26Vb7EarPtpNxkRHybDSPYVsv7Cs/R7
54gJOefq7SroiiSr31I0dQT8j57SBRjekJJMGsEh+Et2Cxz+z8CwynCYCoNjQdOQ
g89lyifTEdEy2DuXcRfeCcIH1mTNQazjsRu2/P6I+P/klpyS+b9HqMSUUwNUDwc/
eY1SWrbCt9/2XJ/B6ZxYK3Lmy+25m9fUNkQBsp3BqqXkUICHlE8zTm3DMG1rf6g=
=vIor
-----END PGP SIGNATURE-----

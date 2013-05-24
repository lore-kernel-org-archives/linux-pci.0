Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <519FC63F.3060205@ubuntu.com>
Date: Fri, 24 May 2013 15:57:51 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: enabling aspm on ati radeon
References: <519443A1.8050905@ubuntu.com> <5196D765.9020600@ubuntu.com> <CAErSpo6MGwHLJvis+4=vdQEJN=Qb9aC5e9=3Q6MdTB-HH84YBw@mail.gmail.com> <11045555.dLhhFPGoSV@vostro.rjw.lan>
In-Reply-To: <11045555.dLhhFPGoSV@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to the PCI express standard, the Link Capabilities register
lies at offset 0xC within the PCI Express root port capabilities
descriptor.  lspci decoded this and shows Unknown ASPM support,
because its value is zero, and this is why the kernel did not enable
ASPM in the Link Control register.  According to the Intel datasheets,
the offsets AC-AFh ( the structure itself starts at A0h ) are
reserved.  So astonishingly it seems that Intel does not know about
the Link Capabilities register!  On the other hand, the contents of
the register actually do seem to be mostly correct, despite what their
datasheet claims.  The one thing wrong with it is that it claims no
ASPM support, despite Intel claiming that it is supported.

For reference, the Intel datasheet I have been referring to is
document 324642-003: 2nd Generation Intel® CoreTM Processor Family
Desktop, Intel® Pentium® Processor Family Desktop, and Intel® Celeron®
Processor Family Desktop Datasheet, Volume 2, table 2-8 on page 84.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRn8Y/AAoJEJrBOlT6nu75P78IAMgL23DGmsBD+TKm3Ootr36E
5iG7NoPcvjYiP/yeHBvhXy5jw4ORfVFLEli82fFOTWAi1YL5mxRKctIiYzu9080N
T1YO34qE/QpXfu6PDYMuNQETteO7MElnM7SHpQQ1oG5pAjPjUB1Bjb54qm4fQt77
11q8W6w3KFegy6cZLqAMHO63gzqUL9G/Akn4BdGvjZyt2ouOZOBU6Siyu0wm+RZY
NUuoy+5wzaej9/T96XCkfHR1e5s32NdvkT9GUxhA8SONEOy892QvOuMWPWv/VHxr
YkVGkaGHXuLLyXNWvy1Tz31HqZlbFaDRw7VzfbW5iE7cMi9EsZxSfjSvSqPZ+/A=
=8hms
-----END PGP SIGNATURE-----

Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: George McCollister <george.mccollister@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, g5983969@trbvm.com,
	Roland Dreier <roland@purestorage.com>
Subject: Re: [PATCH] ACPI / PNP: Reserve ACPI resources at the fs_initcall_sync stage
Date: Thu, 17 Sep 2015 02:44:34 +0200
Message-ID: <1939916.sIenfPkyq6@vostro.rjw.lan>
In-Reply-To: <CAFSKS=OrfLH3q0xrt3T4L20nCcPYTsEB0YDVahmHa3-O79rE3A@mail.gmail.com>
References: <5042629.WJWA6bekh1@vostro.rjw.lan> <CAFSKS=OrfLH3q0xrt3T4L20nCcPYTsEB0YDVahmHa3-O79rE3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 16, 2015 04:45:51 PM George McCollister wrote:
> Unfortunately I just got around to trying linux 4.1.6 (which contains
> this commit) on the Versalogic Tiger (VL-EPM-24)
> http://www.versalogic.com/tiger and this commit breaks it, seems to be
> back to the old behavior reported here:
> 
> http://marc.info/?t=143092384600002&r=1&w=2
> 
> Before reversing the commit it shows:
> pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
> 
> After reversing the commit it shows:
> pci 0000:00:1c.0: BAR 13: assigned [io  0x3000-0x3fff]
> 
> I don't have a solution to propose at this point and haven't tried the
> latest upstream so I'll just be building with this commit reversed
> (which solves the problem) until I have a chance to look into this
> further.

It looks like on your system the ACPI resources really need to be reserved
before the PCI bus is initialized, but we can't do that unconditionally
for everyone without introducing regressions, so the only way to address
that I can see would be to blacklist your system.

Thanks,
Rafael


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37681 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031876AbbD2R2g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2015 13:28:36 -0400
Received: by igblo3 with SMTP id lo3so54942930igb.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2015 10:28:35 -0700 (PDT)
Date: Wed, 29 Apr 2015 12:28:32 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Adam Radford <aradford@gmail.com>,
	Neela Syam Kolli <megaraidlinux@lsi.com>,
	" linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	arkadiusz.bubala@open-e.com,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Kashyap Desai <kashyap.desai@avagotech.com>,
	Sumit Saxena <sumit.saxena@avagotech.com>,
	Uday Lingala <uday.lingala@avagotech.com>,
	megaraidlinux.pdl@avagotech.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: megaraid_sas: "FW in FAULT state!!", how to get more debug
 output? [BKO63661]
Message-ID: <20150429172832.GB7888@google.com>
References: <robbat2-20140712T111727-002806026Z@orbis-terrarum.net>
 <CAErSpo5+=33byGqCjFCSfTpfKFtSAHRqYLzGF7yf5d18gEmWsQ@mail.gmail.com>
 <robbat2-20140712T215640-831385120Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <robbat2-20140712T215640-831385120Z@orbis-terrarum.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, linux-kernel, Kashyap, Sumit, Uday, megaraidlinux.pdl]

On Sun, Jul 13, 2014 at 01:35:51AM +0000, Robin H. Johnson wrote:
> On Sat, Jul 12, 2014 at 11:29:20AM -0600, Bjorn Helgaas wrote:
> > Thanks for the report, Robin.
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=63661 bisected the problem
> > to 3c076351c402 ("PCI: Rework ASPM disable code"), which appeared in
> > v3.3.  For starters, can you verify that, e.g., by building
> > 69166fbf02c7 (the parent of 3c076351c402) to make sure that it works,
> > and building 3c076351c402 itself to make sure it fails?
> > 
> > Assuming that's the case, please attach the complete dmesg and "lspci
> > -vvxxx" output for both kernels to the bugzilla.  ASPM is a feature
> > that is configured on both ends of a PCIe link, so I want to see the
> > lspci info for the whole system, not just the SAS adapters.
> > 
> > It's not practical to revert 3c076351c402 now, so I'd also like to see
> > the same information for the newest possible kernel (if this is
> > possible; I'm not clear on whether you can boot your system or not) so
> > we can figure out what needs to be changed.
> TL;DR: FastBoot is leaving the MegaRaidSAS in a weird state, and it fails to
> start; Commit 3c076351c402 did make it worse, but I think we're right that the
> bug lies in the SAS code.
> 
> Ok, I have done more testing on it (40+ boots), and I think we can show the
> problem is somewhere in how the BIOS/EFI/ROM brings up the card in FastBoot
> more, or how it leaves the card.

I attached your dmesg and lspci logs to
https://bugzilla.kernel.org/show_bug.cgi?id=63661, thank you!  You did
a huge amount of excellent testing and analysis, and I'm sorry that we
haven't made progress using the results.

I still think this is a megaraid_sas driver bug, but I don't have
enough evidence to really point fingers.

Based on your testing, before 3c076351c402 ("PCI: Rework ASPM disable
code"), megaraid_sas worked reliably.  After 3c076351c402,
megaraid_sas does not work reliably when BIOS Fast Boot is enabled.

Fast Boot probably means we don't run the option ROM on the device.
Your dmesg logs show that in the working case, BIOS has enabled the
device.  In the failing case it has not.  They also show that when
Fast Boot is enabled, there's a little less MTRR write-protect space,
which I'm guessing is space that wasn't needed for shadowing option
ROMs.

I suspect megaraid_sas depends on something done by the option ROM,
and that prior to 3c076351c402, Linux did something to ASPM that was
enough to make megaraid_sas work.

I attached a couple debug patches to
https://bugzilla.kernel.org/show_bug.cgi?id=63661 that log all the
ASPM configuration the PCI core does.  One applies to 69166fbf02c7
(the pre-3c076351c402 commit), and the other applies to v4.1-rc1.
Could you boot both of those with "pci=earlydump" and attach the dmesg
logs to the bugzilla?  If you boot with the BIOS CMOS reset settings
(Fast Boot enabled and ASPM set to "BIOS"), I expect the 69166fbf02c7-
based kernel to work, and the v4.1-rc1-based one to fail.

> Full boot of the system was difficult on the 3.2 kernels, they didn't make it
> to userspace for other stuff being too new. For testing, I compiled
> CONFIG_MEGARAID_SAS=y on 3.2, and =m on 3.16-rc4; that way when the initramfs &
> userspace failed, the megaraid load was captured over IPMI serial.
> 
> I've done a lot of the analysis below while capturing.
> 
> I was going to be booting many times, so I flipped the 'Fast Boot'
> option back to Disabled, so I could more easily get to the BIOS settings
> to change options while testing. When I did so, an accidental boot on a
> kernel that previously failed suddenly worked, leading me to raise an
> eyebrow, and this expanded my test matrix more.
> 
> 3 kernels, 6 different BIOS config combinations (2x3) = 18 test cases
> Each configuration was booted at least twice; if the result of two boots was
> not identical, I booted a third time and took the majority result.
> 
> All kernels had no boot params involving PCI specified (none of pci=, pcie*=,
> disable_msi*).
> 
> Kernels:
> K.1: Ubuntu's 3.16-rc4
> K.2: 3.2-rc4 3c076351c402 - aspm merged
> K.3: 3.2-rc4 69166fbf02c7 - aspm merge parent
> Notes: 3.2* compiled with GCC4.6, 3.16-rc4 with GCC4.8
> 
> BIOS: Boot -> FastBoot:
> B1.1 Off
> B1.2 On (CMOS reset default)
> 
> BIOS: Advanced -> PCIe/PCI/PnP Configuration -> ASPM Support
> B2.1 Force L0s
> B2.2 BIOS (CMOS reset default)
> B2.3 Disabled
> 
> Reduced Kernaugh Map of results:
> Kernels,B1,B2:   Result
>   *, B1.1,    *  PASS
>   *, B1.2, B2.1  VARIABLE (9 runs: 5 fail, 4 pass, no kernel consistency)
> K.1, B1.2, B2.2  FAIL
> K.1, B1.2, B2.3  FAIL
> K.2, B1.2, B2.2  FAIL
> K.2, B1.2, B2.3  FAIL
> K.3, B1.2, B2.2  PASS
> K.3, B1.2, B2.3  PASS

I'm not very practiced with Karnaugh maps, so correct me if my
understanding is wrong:

  - Fast Boot disabled: all kernels always passed

  - Fast Boot enabled, ASPM set to Force L0s enabled: variable; no
    consistency of results

  - Fast Boot enabled, ASPM set to BIOS or Disabled: pre-3c076351c402
    always passed, post-3c076351c402 always failed

Bjorn

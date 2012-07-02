Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38162 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab2GBSyp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2012 14:54:45 -0400
Received: by lbbgm6 with SMTP id gm6so8030201lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 02 Jul 2012 11:54:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVzYCwAAEnhZSVotiB3R+XYGcT=SJ8ySBndvo0OpRXP7w@mail.gmail.com>
References: <bug-15362-41252@https.bugzilla.kernel.org/> <20120627140641.2187711F8B0@bugzilla.kernel.org>
 <CAErSpo4T5rBwoE7X2h1-CG9GoEPzXO+_1R7YVyv8wiL2qZW+XA@mail.gmail.com> <CAE9FiQVzYCwAAEnhZSVotiB3R+XYGcT=SJ8ySBndvo0OpRXP7w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Jul 2012 12:54:24 -0600
Message-ID: <CAErSpo67JZf81_Xco-r0R493Lmu4d5+2XBapT91tciuek2MskQ@mail.gmail.com>
Subject: Re: [Bug 15362] MPT Fusion SCSI drives no longer appear - suspect PCI
 bus scan bug
To: Yinghai Lu <yinghai@kernel.org>
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>, 543308@bugs.debian.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> in short: the bios is broken, it return wrong segment in DSDT.

I *think* what Yinghai is saying is:

  - MMCONFIG is not used either in 2.6.26 or 2.6.32.
  - BIOS reports these host bridges via DSDT PNP0A08 devices:
        [PCI0] leading to segment 0000 bus 00
        [PCI1] leading to segment 0001 bus 40
        [PCI2] leading to segment 0002 bus 80
  - Buses 40 and 80 are actually in segment 0, not segments 1 and 2.
  - When we enumerate bus 40 and bus 80, we pass seg=1 and seg=2,
respectively, to pci_conf1_read(), but 2.6.26 ignores seg.  For
example, when we think we're reading 0001:40:01.0 config space, 2.6.26
actually reads 0000:40:01.0 config space instead.
  - In 2.6.32, instead of ignoring seg, we return an error if it is
not zero.  Therefore, we fail to find anything on bus 40 and bus 80.

Sean, what system and BIOS version is this?  (The 3.4.x dmesg log or
the "dmidecode" output will contain this information.)  I don't expect
HP to change the BIOS, and it wouldn't be reasonable to require users
to debug this issue and upgrade their BIOS in any case.

But I would like to read the release notes or help text that mentions
this issue.  If all the buses were in fact in segment 0, the DSDT
would typically not have any _SEG methods at all, because segment 0 is
the default.  Yinghai is assuming that HP went to the trouble to *add*
_SEG methods that returned incorrect values.  But the fact that HP was
aware of the issue and provided the BIOS "disable ACPI bus
segmentation" option makes it less likely that this is the case.

Also, the system was very likely tested with Windows, and the fact
that the BIOS option is to *disable* segmentation suggests that the
default is "segmentation enabled."  So my guess is that segmentation
does work with Windows.  Sean, can you confirm or deny that?  The
AIDA64 tool (free trial version at http://www.aida64.com/) generates a
report with useful information.

I agree with Jonathan's assertion here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=543308#87 that the
BIOS switch is not adequate.  Neither is a patched DSDT.

I think it's likely that Windows works with segmentation, using
MMCONFIG, and that Linux is a bit too quick to disable MMCONFIG in
this case.

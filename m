Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:49945 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab3EQUYa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2013 16:24:30 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so5534240oag.39
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2013 13:24:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51968E9F.1010909@ubuntu.com>
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan>
 <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com>
 <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com>
 <5196713A.1010102@ubuntu.com> <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com>
 <51968E9F.1010909@ubuntu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 May 2013 14:24:10 -0600
Message-ID: <CAErSpo6ZKB-4PTa_2Cthx_8S2txCbGyatbPmDUPYexCQFg-A=A@mail.gmail.com>
Subject: Re: enabling aspm on ati radeon
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 17, 2013 at 2:10 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 5/17/2013 3:52 PM, Bjorn Helgaas wrote:
>> I just sent a patch to make lspci decode all possible values
>> there. In the PCIe r2.1 spec, only 1 ("L0s") and 3 ("L0s and L1")
>> were defined.  The r3 spec added 0 ("not supported") and 2 ("L1"),
>> but lspci hadn't quite kept up.
>
> So do you still want the lspci -xxxs output, or was that just to
> answer the question of why it said unknown instead of not supported?

Don't worry about the lspci -xxx output.  I think the lspci patch
should resolve that, and it's not related to your original issue.

> Are we then back to no idea?
>
> I notice a number of functions in drivers/pci/pcie/aspm.c that look
> like they need used to configure aspm.  The radeon driver does not
> appear to call any of them ( grep for aspm came up with nothing ).
> Could that be why?  I can't find anything under Documentation/ about
> what a driver needs to do to enable aspm.

The driver does not need to do anything to enable ASPM.  I'm sure we
can figure out what's going on here, but I need to review some of the
patches in my queue, so I don't have time to grub around in ASPM at
the moment.

If you want to take a look yourself, I'd start by adding printks in
the pcie_aspm_init_link_state() path.  You can probably figure out
where things go wrong pretty quickly.

Oh, wait a minute...  You mentioned the radeon driver.  The Radeon
device in your system is at 01:00.0, and that is below the 00:01.0
bridge that said "ASPM unknown."  If the bridge leading to the Radeon
device doesn't support ASPM, then of course, we won't be able to turn
on ASPM for it.

That doesn't explain why we don't turn on ASPM for the *other* devices
(03:00.0, 05:00.0, 06:00.0, 09:00.0) though.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:41327 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756464Ab3EQV3R (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2013 17:29:17 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so5178657obc.26
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2013 14:29:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51969D30.1070502@ubuntu.com>
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan>
 <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com>
 <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com>
 <5196713A.1010102@ubuntu.com> <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com>
 <51968E9F.1010909@ubuntu.com> <CAErSpo6ZKB-4PTa_2Cthx_8S2txCbGyatbPmDUPYexCQFg-A=A@mail.gmail.com>
 <51969D30.1070502@ubuntu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 May 2013 15:28:56 -0600
Message-ID: <CAErSpo4H-=dnHON3vDvJEme2hGD0z0r_NSsm-Bk9tZ4QqtBTCw@mail.gmail.com>
Subject: Re: enabling aspm on ati radeon
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 17, 2013 at 3:12 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 5/17/2013 4:24 PM, Bjorn Helgaas wrote:
>> Oh, wait a minute...  You mentioned the radeon driver.  The Radeon
>> device in your system is at 01:00.0, and that is below the 00:01.0
>> bridge that said "ASPM unknown."  If the bridge leading to the
>> Radeon device doesn't support ASPM, then of course, we won't be
>> able to turn on ASPM for it.
>
> That's what I was asking about before when I said surely the bridge
> higher up doesn't have to have aspm enabled in order to enable it on
> the downstream link?

A link has two ends.  Both ends have to support ASPM in order for it
to work.  But ASPM on a particular link has no dependency on things
elsewhere in the hierarchy.

>> That doesn't explain why we don't turn on ASPM for the *other*
>> devices (03:00.0, 05:00.0, 06:00.0, 09:00.0) though.
>
> 00:01.0 says it is the root complex, so wouldn't that make it upstream
> of *everything*?  As I understand it, the root complex is built into
> the CPU and has 16 lanes going to the video slot, and another 4 lanes
> running at gen3 speed that Intel calls the DMI that goes to the PCH,
> which has some internal functions, and bridges to another 20 pcie lanes.
>
> Since the root complex is built into the cpu, I wouldn't think ASPM
> could possibly make sense on it, so it showing that it doesn't support
> ASPM makes sense to me.  That doesn't seem like it should preclude
> using ASPM on the link down to the video card.

The link between 00:01.0 and 01:00.0 apparently only supports ASPM on
one end (the downstream end), so ASPM won't work on it.

Bjorn

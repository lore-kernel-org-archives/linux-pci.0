Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:55332 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756777Ab3ERAkd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2013 20:40:33 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so5286260obc.26
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2013 17:40:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5196C81B.8060400@ubuntu.com>
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan>
 <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com>
 <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com>
 <5196713A.1010102@ubuntu.com> <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com>
 <51968E9F.1010909@ubuntu.com> <CAErSpo6ZKB-4PTa_2Cthx_8S2txCbGyatbPmDUPYexCQFg-A=A@mail.gmail.com>
 <51969D30.1070502@ubuntu.com> <CAErSpo4H-=dnHON3vDvJEme2hGD0z0r_NSsm-Bk9tZ4QqtBTCw@mail.gmail.com>
 <5196BF15.3050208@ubuntu.com> <CAErSpo5W=Zi_2s0ywfO4VPfbUfxhhCRUMn7oRhx_mi7yYpBHmw@mail.gmail.com>
 <5196C81B.8060400@ubuntu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 May 2013 18:40:12 -0600
Message-ID: <CAErSpo6i939JR-3psRhXjkxE3sME8AJ3P84BGX9m1HhdzJxhAg@mail.gmail.com>
Subject: Re: enabling aspm on ati radeon
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 17, 2013 at 6:15 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/17/2013 07:52 PM, Bjorn Helgaas wrote:
>> setpci will write whatever you tell it to; it doesn't check any
>> constraints like "is ASPM supported?"  But the Link Capabilities
>> register is read-only per spec, so likely you won't be able to
>> change that field, at least not by writing it directly.
>
> I assume it is RO according to the PCIe spec ( buggers seem to only
> allow members of pcisig to download it ), but I checked the Intel
> specs for the chip ( Sandybridge ) and it's RW.  It looks like it
> powers up as 00 and it's up to the bios to change it to advertise the
> capability, and it seems Asus didn't bother with that.

Right; I meant RO per the PCIe spec.  If it's RW on your chip, setpci
should be able to write it.

>> You can always try using setpci to set the ASPM enable bits in the
>> Link Control register on both the bridge and the device.  When
>> enabling, I think you're supposed to do the upstream end of the
>> link first, then the downstream end (and the reverse for
>> disabling).
>
> One thing I don't see anywhere is a status bit showing whether it
> actually *is* in L0s or L1 currently, so how to know if it's working?

I don't think software can actually tell -- those transitions are
completely managed by hardware, and whenever the link is active, e.g.,
when you're accessing config space or transferring data, it would be
in L0.

If you can measure the power consumption, you might be able to see a
difference there.  I've seen people report that, but don't know how
they do it.  For example:
https://lkml.kernel.org/r/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com

Bjorn

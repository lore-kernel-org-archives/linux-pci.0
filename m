Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5196BF15.3050208@ubuntu.com>
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan>
 <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com>
 <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com>
 <5196713A.1010102@ubuntu.com> <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com>
 <51968E9F.1010909@ubuntu.com> <CAErSpo6ZKB-4PTa_2Cthx_8S2txCbGyatbPmDUPYexCQFg-A=A@mail.gmail.com>
 <51969D30.1070502@ubuntu.com> <CAErSpo4H-=dnHON3vDvJEme2hGD0z0r_NSsm-Bk9tZ4QqtBTCw@mail.gmail.com>
 <5196BF15.3050208@ubuntu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 May 2013 17:52:02 -0600
Message-ID: <CAErSpo5W=Zi_2s0ywfO4VPfbUfxhhCRUMn7oRhx_mi7yYpBHmw@mail.gmail.com>
Subject: Re: enabling aspm on ati radeon
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 17, 2013 at 5:36 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/17/2013 05:28 PM, Bjorn Helgaas wrote:> A link has two ends.
> Both ends have to support ASPM in order for it
>> to work.  But ASPM on a particular link has no dependency on
>> things elsewhere in the hierarchy.
>
> Got you... I guess I was still thinking regular PCI and the naming
> "root complex" made me think it was the whole root bridge, when it
> really is that particular x16 pcie port that goes to the radeon.
>
>> The link between 00:01.0 and 01:00.0 apparently only supports ASPM
>> on one end (the downstream end), so ASPM won't work on it.
>
> I'll check the Intel spec sheet again, but I'm pretty sure it really
> does support ASPM.  The CPU probably allows writes to the register,
> and my bios must have configured it to say it doesn't support aspm.  I
> guess I just need to wrangle setpci into trying to enable it despite
> it not advertising support, or maybe see if I can get grub to poke the
> capability register to make it say it supports it.

setpci will write whatever you tell it to; it doesn't check any
constraints like "is ASPM supported?"  But the Link Capabilities
register is read-only per spec, so likely you won't be able to change
that field, at least not by writing it directly.

You can always try using setpci to set the ASPM enable bits in the
Link Control register on both the bridge and the device.  When
enabling, I think you're supposed to do the upstream end of the link
first, then the downstream end (and the reverse for disabling).

> One question I have though is how to identify which port device
> corresponds to which downstream device connected to it.  In other
> words, how do you know 00:01.0 links to 01:00.0 ( other than seeing
> that it's the x16 and knowing the radeon is plugged into the x16 slot ).

lspci tells you that:

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core
Processor Family PCI Express Root Port
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0

The "secondary=01" means the bridge leads to bus 01, which is where
the 01:00.0 device is.

Bjorn

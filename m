Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5196D765.9020600@ubuntu.com>
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan>
 <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com>
 <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com>
 <5196713A.1010102@ubuntu.com> <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com>
 <51968E9F.1010909@ubuntu.com> <CAErSpo6ZKB-4PTa_2Cthx_8S2txCbGyatbPmDUPYexCQFg-A=A@mail.gmail.com>
 <51969D30.1070502@ubuntu.com> <CAErSpo4H-=dnHON3vDvJEme2hGD0z0r_NSsm-Bk9tZ4QqtBTCw@mail.gmail.com>
 <5196BF15.3050208@ubuntu.com> <CAErSpo5W=Zi_2s0ywfO4VPfbUfxhhCRUMn7oRhx_mi7yYpBHmw@mail.gmail.com>
 <5196C81B.8060400@ubuntu.com> <CAErSpo6i939JR-3psRhXjkxE3sME8AJ3P84BGX9m1HhdzJxhAg@mail.gmail.com>
 <5196D765.9020600@ubuntu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 May 2013 07:34:44 -0600
Message-ID: <CAErSpo6MGwHLJvis+4=vdQEJN=Qb9aC5e9=3Q6MdTB-HH84YBw@mail.gmail.com>
Subject: Re: enabling aspm on ati radeon
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 17, 2013 at 7:20 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/17/2013 08:40 PM, Bjorn Helgaas wrote:
>> Right; I meant RO per the PCIe spec.  If it's RW on your chip,
>> setpci should be able to write it.
>
> I assume it would do no good to change it at this point; it would need
> to already be set at the time the kernel reads it and decides whether
> or not to enable it, so I'd have to have grub set it before loading
> the kernel.

Yeah, setting the capability bits after the kernel has booted wouldn't
change anything except what lspci reports.

>> If you can measure the power consumption, you might be able to see
>> a difference there.  I've seen people report that, but don't know
>> how they do it.  For example:
>> https://lkml.kernel.org/r/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com
>
> After
>>
> enabling it on both ends ( despite the root port still claiming
> it is not supported ) I still see ~121 watts according to the
> Kill-A-Watt my system is plugged into.  Oh well.

ASPM only saves power when the PCIe link is idle.  I'm not a video
person, so I don't know how video usage translates into link usage,
and I don't know how much power it saves.  My guess is that the amount
is fairly small and might not be measurable with a Kill-A-Watt.

Bjorn

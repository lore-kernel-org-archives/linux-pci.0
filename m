Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 May 2015 08:13:23 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Michael Marineau <michael.marineau@coreos.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	platform-driver-x86@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petri Hodju <petrihodju@yahoo.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [Patch v3] apple-gmux: lock iGP IO to protect from vgaarb
 changes
Message-ID: <20150527081323.35a3cf88@pluto.restena.lu>
In-Reply-To: <CAGr1u3t1+ktKG_v74nQ2H6txGcWSwBBfsWS74k0Ao2pNTvgAng@mail.gmail.com>
References: <20150223215155.18444386@neptune.home>
	<20150303172753.GF83894@vmdeb7>
	<20150305232038.1873d380@neptune.home>
	<20150306174254.GB19001@vmdeb7>
	<20150307011546.0050279d@neptune.home>
	<20150309225238.0b9ced4e@neptune.home>
	<CAErSpo61r-_hy1hfUMm2ooXZVLTBhtjd-x5uXbyEg=WcG=itnQ@mail.gmail.com>
	<20150311223445.6af76f7c@neptune.home>
	<CAGr1u3tKVtQno=hUrKemLFYG12dtvPjFVR7oFwDG5cewJGCnJQ@mail.gmail.com>
	<20150527044749.GB21644@fury.dvhart.com>
	<CAGr1u3t1+ktKG_v74nQ2H6txGcWSwBBfsWS74k0Ao2pNTvgAng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 26 May 2015 22:35:46 -0700 Michael Marineau wrote:
> On Tue, May 26, 2015 at 9:47 PM, Darren Hart <dvhart@infradead.org> wrote:
> > On Tue, May 26, 2015 at 12:10:48PM -0700, Michael Marineau wrote:
> >> FYI, this actually broke backlight controls on my MBP11,3 because the
> >> assumption the patch makes that gmux is always loaded before graphics
> >> drivers didn't hold true. At least for me dracut included the nouveau
> >> module in the initrd but not gmux, ensuring the ordering was wrong. No
> >> errors were reporting, and gmux still offered the backlight device, it
> >> just became inoperable. I worked around this for my kernel by building
> >> gmux into vmlinuz instead of as a module but that isn't going to in
> >> more general configs because there is an apple backlight driver which
> >> cannot be built at all in that configuration.
> >>
> >
> > Thank you for reporting this Michael,
> >
> > That is tough as nouveau doesn't have an explicit dependency on gmux, so we
> > could do something like a passive request_module(), but if it isn't in the
> > initrd image, it would still fail as you describe.
> >
> >> Is there a way to make the ordering between nouveau and gmux more
> >> explicit/reliable? Can gmux complain loudly if the ordering is ever
> >> wrong?
> >
> > It should print an error if the probe fails due to the IO already being in use
> > or if it can't be allocated. The disabled IO case is only info level though,
> > perhaps that should be higher priority. Printing something when failing to probe
> > seems like a reasonable thing to do.
> >
> > Michael, which message do you get if you boot with "debug" or "loglevel=6" when
> > apple-gmux is not built-in?
> 
> No error, gmux claims it worked:
> [   13.693379] apple_gmux: Found gmux version 4.0.8 [indexed]
> [   13.693400] vgaarb: device changed decodes:
> PCI:0000:01:00.0,olddecodes=io+mem,decodes=io+mem:owns=none
> [   13.693404] apple_gmux: locked IO for PCI:0000:01:00.0
> 
> Full dmesg: https://gist.github.com/marineam/0e5a23548e8b3b2e1d50

What GPUs are there in your MBP11,3? From your dmesg it looks like all
you have is NVIDIA GPU 0000:01:00.0 (lspci?).

Is there a somehow hidden intel GPU around doing the backlight?
If so my locking does the wrong thing for your system as:

[    0.393298] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=none,locks=none
[    0.393299] vgaarb: loaded
[    0.393300] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.393301] vgaarb: bridge control possible 0000:01:00.0
...
[   13.693379] apple_gmux: Found gmux version 4.0.8 [indexed]
[   13.693400] vgaarb: device changed decodes: PCI:0000:01:00.0,olddecodes=io+mem,decodes=io+mem:owns=none
[   13.693404] apple_gmux: locked IO for PCI:0000:01:00.0

Here it triggers "olddecodes=none -> io+mem".

Making sure to lock only the intel GPU when present and especially protecting
against nvidia driver will be hard if legacy-IO is being processed by a hidden
device!

Bruno

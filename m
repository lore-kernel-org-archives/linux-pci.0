Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40969 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756736Ab3ETTw6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 May 2013 15:52:58 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phillip Susi <psusi@ubuntu.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: enabling aspm on ati radeon
Date: Mon, 20 May 2013 22:01:40 +0200
Message-ID: <11045555.dLhhFPGoSV@vostro.rjw.lan>
In-Reply-To: <CAErSpo6MGwHLJvis+4=vdQEJN=Qb9aC5e9=3Q6MdTB-HH84YBw@mail.gmail.com>
References: <519443A1.8050905@ubuntu.com> <5196D765.9020600@ubuntu.com> <CAErSpo6MGwHLJvis+4=vdQEJN=Qb9aC5e9=3Q6MdTB-HH84YBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, May 20, 2013 07:34:44 AM Bjorn Helgaas wrote:
> On Fri, May 17, 2013 at 7:20 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On 05/17/2013 08:40 PM, Bjorn Helgaas wrote:
> >> Right; I meant RO per the PCIe spec.  If it's RW on your chip,
> >> setpci should be able to write it.
> >
> > I assume it would do no good to change it at this point; it would need
> > to already be set at the time the kernel reads it and decides whether
> > or not to enable it, so I'd have to have grub set it before loading
> > the kernel.
> 
> Yeah, setting the capability bits after the kernel has booted wouldn't
> change anything except what lspci reports.
> 
> >> If you can measure the power consumption, you might be able to see
> >> a difference there.  I've seen people report that, but don't know
> >> how they do it.  For example:
> >> https://lkml.kernel.org/r/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com
> >
> > After
> >>
> > enabling it on both ends ( despite the root port still claiming
> > it is not supported ) I still see ~121 watts according to the
> > Kill-A-Watt my system is plugged into.  Oh well.
> 
> ASPM only saves power when the PCIe link is idle.  I'm not a video
> person, so I don't know how video usage translates into link usage,
> and I don't know how much power it saves.  My guess is that the amount
> is fairly small and might not be measurable with a Kill-A-Watt.

I'm pretty sure it's measurable, at least in some cases.  Phoronix did quite
some fuss about a commit that caused ASPM to not work any more on some systems
some time ago, so he had to be able to measure it (and it was called a "major
power regression").

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

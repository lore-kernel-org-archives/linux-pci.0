Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 11 Nov 2011 09:32:50 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Matthew Garrett <mjg@redhat.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Rework ASPM disable code
Message-ID: <20111111173250.GA8679@kroah.com>
References: <1320961113-5050-1-git-send-email-mjg@redhat.com>
 <CACna6rwxWUtfa2uz1hXVUthSpJF6SKP3V-ERt0=3oVQ2KKEo=g@mail.gmail.com>
 <20111111092811.54a03027@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20111111092811.54a03027@jbarnes-desktop>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2011 at 09:28:11AM -0800, Jesse Barnes wrote:
> On Fri, 11 Nov 2011 10:49:02 +0100
> Rafał Miłecki <zajec5@gmail.com> wrote:
> 
> > 2011/11/10 Matthew Garrett <mjg@redhat.com>:
> > > Right now we forcibly clear ASPM state on all devices if the BIOS indicates
> > > that the feature isn't supported. Based on the Microsoft presentation
> > > "PCI Express In Depth for Windows Vista and Beyond", I'm starting to think
> > > that this may be an error. The implication is that unless the platform
> > > grants full control via _OSC, Windows will not touch any PCIe features -
> > > including ASPM. In that case clearing ASPM state would be an error unless
> > > the platform has granted us that control.
> > >
> > > This patch reworks the ASPM disabling code such that the actual clearing
> > > of state is triggered by a successful handoff of PCIe control to the OS.
> > > The general ASPM code undergoes some changes in order to ensure that the
> > > ability to clear the bits isn't overridden by ASPM having already been
> > > disabled. Further, this theoretically now allows for situations where
> > > only a subset of PCIe roots hand over control, leaving the others in the
> > > BIOS state.
> > >
> > > It's difficult to know for sure that this is the right thing to do -
> > > there's zero public documentation on the interaction between all of these
> > > components. But enough vendors enable ASPM on platforms and then set this
> > > bit that it seems likely that they're expecting the OS to leave them alone.
> > >
> > > Measured to save around 5W on an idle Thinkpad X220.
> > >
> > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > 
> > Does it make sense to CC stable? To get it into 2.6.38+?
> 
> It's a pretty serious change that affects a lot of platforms, so I'd be
> nervous about sticking it in stable right away.  Maybe after some soak
> time upstream and/or broad testing in distros.

I agree.

I'll watch what happens with this patch before being willing to stick it
into the stable releases.

greg k-h

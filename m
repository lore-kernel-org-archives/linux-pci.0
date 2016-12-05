Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751570AbcLEVVp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Dec 2016 16:21:45 -0500
Date: Mon, 5 Dec 2016 15:21:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Masters <jcm@redhat.com>
Cc: Duc Dang <dhdang@apm.com>, Mark Salter <msalter@redhat.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
Message-ID: <20161205212140.GA18259@bhelgaas-glaptop.roam.corp.google.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com>
 <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
 <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLND=Ss8d-jv7wffbrtytrjj=SUnjDn9bognKUszhKguRV1A@mail.gmail.com>
 <d77e403c-81e9-114e-6ec6-bbffaa4ac36f@redhat.com>
 <20161202233943.GF9903@bhelgaas-glaptop.roam.corp.google.com>
 <62dd5462-4d68-b89f-2b45-0d58bbd96bcd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <62dd5462-4d68-b89f-2b45-0d58bbd96bcd@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 02, 2016 at 07:33:46PM -0500, Jon Masters wrote:
> On 12/02/2016 06:39 PM, Bjorn Helgaas wrote:
> > On Thu, Dec 01, 2016 at 11:08:23PM -0500, Jon Masters wrote:
> 
> >> Let's see if I summarized this correctly...
> >>
> >> 1. The MMIO registers for the host bridge itself need to be described
> >>    somewhere, especially if we need to find those in a quirk and poke
> >>    them. Since those registers are very much part of the bridge device,
> >>    it makes sense for them to be in the _CRS for PNP0A08/PNP0A03.
> >>
> >> 2. The address space covering these registers MUST be described as a
> >>    ResourceConsumer in order to avoid accidentally exposing them as
> >>    available for use by downstream devices on the PCI bus.
> >>
> >> 3. The ACPI specification allows for resources of the type "Memory32Fixed".
> >>    This is a macro that doesn't have the notion of a producer or consumer.
> >>    HOWEVER various interpretations seem to be that this could/should
> >>    default to being interpreted as a consumed region.
> > 
> > I agree; I think that per spec, Memory24, Memory32, Memory32Fixed, IO,
> > and FixedIO should all be for consumed resources, not for bridge
> > windows, since they don't have the notion of producer.
> 
> Ok. If we ultimately codify this somewhere as the general Linux kernel
> consensus (Rafael?) then we can also go and get the various ARM server
> specs updated to reflect this in (for e.g.) reference firmware builds.
> 
> > I'm pretty sure there's x86 firmware in the field that uses these for
> > windows, so I think we have to accept that usage, at least on x86.
> 
> Ok. I was pondering how to even go about finding that out, but even if
> I scheduled a job across RH's infra to look, that would be a drop in
> the bucket of possible machines that might be out there doing this.

Hmmm, when researching this, I thought I came across a change
specifically for a machine that used Memory32Fixed this way, but I
can't find it now.

The only thing I did find was some old experiments with Windows that
showed it interpreting a Memory32Fixed region as a window and putting
PCI devices in it: https://bugzilla.kernel.org/show_bug.cgi?id=15817
But that was a synthetic example with qemu, not a real machine in the
field.

> > Even without this patch, I don't think it's a show-stopper to have
> > Linux mistakenly thinking this region is routed to PCI, because the
> > driver does reserve it and the PCI core will never try to use it.
> 
> Ok. So are you happy with pulling in Duc's v4 patch and retaining
> status quo on the bridge resources for 4.10?

Yes, I think it looks good.  I'll finish packaging things up and
repost the current series.

Bjorn

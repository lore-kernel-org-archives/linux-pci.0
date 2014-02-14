Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dliviu.plus.com ([80.229.23.120]:51687 "EHLO smtp.dudau.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738AbaBNWLc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 14 Feb 2014 17:11:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.dudau.co.uk (Postfix) with SMTP id B89B2FFAFE
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2014 22:06:06 +0000 (GMT)
Date: Fri, 14 Feb 2014 22:00:47 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140214220047.GA5394@bart.dudau.co.uk>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <20140213182654.GA20043@obsidianresearch.com>
 <20140213195317.GQ13576@mudshark.cambridge.arm.com>
 <5805232.JrD2FybBlg@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5805232.JrD2FybBlg@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 14, 2014 at 10:59:06AM +0100, Arnd Bergmann wrote:
> On Thursday 13 February 2014 19:53:17 Will Deacon wrote:
> > On Thu, Feb 13, 2014 at 06:26:54PM +0000, Jason Gunthorpe wrote:
> > > On Thu, Feb 13, 2014 at 05:28:20PM +0100, Arnd Bergmann wrote:
> > > 
> > > > > Huh?  The reg property clearly has the size in it (as shown in the
> > > > > example below).  I guess I was just asking for the description
> > > > > here to say what the size was for the 2 compatibles since its
> > > > > fixed and known.
> > > > 
> > > > It's still an open question whether the config space in the reg
> > > > property should cover all 256 buses or just the ones in the
> > > > bus-range. In the latter case, it would be variable (but
> > > > predictable) size.
> > > 
> > > The 'describe the hardware principle' says the reg should be the
> > > entire available ECAM/CAM region the hardware is able to support.
> > > 
> > > This may be less than 256 busses, as ECAM allows the implementor to
> > > select how many upper address bits are actually supported.
> > 
> > Ok, but the ECAM/CAM base always corresponds to bus 0, right?
> 
> Ah, plus I suppose it ought to be a power-of-two size?
> 
> > > IMHO, the bus-range should be used to indicate the range of busses
> > > discovered by the firmware, but we have historically tweaked it to
> > > indicate the max range of bus numbers available on this bus (I think
> > > to support the hack where two physical PCI domains were roughly glued
> > > into a single Linux domain).
> 
> There is an interesting point about the domain assignment, brought to
> my attention by Russell's comment about the hw_pci struct: If we want
> to support arbitrary combinations of pci host bridges described in DT,
> we need a better policy to decide what domain to use. The approaches
> I've seen so far are:
> 
> 1. We assume each host bridge in DT is a domain by itself. I think
> we do that for all DT probed bridges on ARM (aside from shmobile)
> at the moment. In some cases, the the host bridge is a really a
> fiction made up by the host driver to couple various identical
> but independent PCIe root ports, but the same fiction is shared
> between DT and the PCI core view of it. This requires that we
> enable the PCI domain code unconditionally, and breaks all user
> space that doesn't understand domains (this should be rare but
> can still exist for x86 based software).
> 
> 2. The architecture or platform code decides and uses a method equivalent
> to ARM's pci_common_init_dev() after it has found all host bridges.
> The architecture "knows" how many domains it wants and calls
> pci_common_init_dev() for each domain, and then the setup() callbacks
> grab as many buses as they need within the domain. For a generic
> multiplatform kernel, this means we need to add a top-level driver
> that looks at all pci hosts in DT before any of them are probed.
> It also means the pci host drivers can't be loadable modules.
> 
> 3. We assume there is only one domain, and require each host bridge
> in DT to specify a bus-range that is a subset of the available 256
> bus numbers. This should work for anything but really big systems
> with many hot-pluggable ports, since we need to reserve a few bus
> numbers on each port for hotplugging.
> 
> 4. Like 3, but start a new domain if the bus-range properties don't
> fit in the existing domains.
> 
> 5. Like 3, but specify a generic "pci-domain" property for DT
> that allows putting host bridges into explicit domains in
> a predictable way.

What I'm going to suggest in my v2 patch (hope to send it before Monday)
is a new API in the generic PCI code that will allow you to create a
host bridge in a new domain or in the existing domain, with the management
of the domain number being done in the generic code.

Something like:

  int create_hostbridge_in_new_domain(....);
  int create_hostbridge(....);

with the functions being wrappers around the pci_hostbridge_of_init function
that I'm introducing.

What do you think?

Best regards,
Liviu

> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


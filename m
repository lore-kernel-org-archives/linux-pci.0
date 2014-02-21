Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:57279 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756093AbaBUAge (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Feb 2014 19:36:34 -0500
Date: Thu, 20 Feb 2014 17:36:19 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Will Deacon <will.deacon@arm.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v3 2/3] ARM: bios32: use pci_enable_resource to enable
 PCI resources
Message-ID: <20140221003619.GG19893@obsidianresearch.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <1392726043-31088-3-git-send-email-will.deacon@arm.com>
 <20140218154139.GF21483@n2100.arm.linux.org.uk>
 <20140220111238.GD3615@mudshark.cambridge.arm.com>
 <CAErSpo4KEGh7GAfEv-prj-UdJETCN9M5sEtdNF0NARa6-03HYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4KEGh7GAfEv-prj-UdJETCN9M5sEtdNF0NARa6-03HYA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 12:39:16PM -0700, Bjorn Helgaas wrote:
> > Damn, I just found a problem with this patch when PCI_PROBE_ONLY is set.
> >
> > The problem is that bios32.c won't create a resource hierarchy for the
> > firmware-initialised resources, so we have a bunch of orphaned resources
> > that we can't pass to pci_enable_resources (since it checks r->parent).
> >
> > This means that, unless firmware *enables* all of the resources, Linux won't
> > be able to enable them. I think this is stronger than simply not
> > re-assigning devices like the PCI_PROBE_ONLY flag intends.
> 
> By "firmware enabling resources," do you mean firmware assigning
> addresses in the BARs and turning on the PCI_COMMAND_MEMORY (or _IO)
> bits?
> 
> I'd like to make the generic code ignore BAR values if
> PCI_COMMAND_MEMORY (or _IO) is cleared.  When those bits are cleared,
> I don't think there's a good way to determine whether the address in a
> BAR is valid.

I think this is pretty smart, PROBE_ONLY really should mean
'everything is perfect, do not touch it' and if the device isn't
enabled, well.. It isn't enabled, the firmware should have done it.

Will, this if for kvmtool right? Keeping the patch as is and instead
changing kvmtool to enable the devices seems like a good option?

Alternatively, there are OF ways to communicate the BAR assignment
through the DT. I actually have no idea how this information is used
by the core code, but it might let you avoid the probe_only by
specifying the desired BAR value through the DT.

Regards,
Jason

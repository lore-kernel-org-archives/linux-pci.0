Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39518 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934319AbbGHIh5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Jul 2015 04:37:57 -0400
Date: Wed, 8 Jul 2015 09:38:26 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
Message-ID: <20150708083826.GA1912@red-moon>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
 <20150527210447.GY32152@google.com>
 <20150602145510.GE23650@red-moon>
 <1435099588.3996.14.camel@kernel.crashing.org>
 <CAErSpo6AziA5GXEi6AizW2WP6oLVMd1p57pWunDNBQeVXxp1nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6AziA5GXEi6AizW2WP6oLVMd1p57pWunDNBQeVXxp1nw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 12:02:14AM +0100, Bjorn Helgaas wrote:
> On Tue, Jun 23, 2015 at 5:46 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2015-06-02 at 15:55 +0100, Lorenzo Pieralisi wrote:
> >> While at it, do you think it is reasonable to also claim the bridge
> >> windows (resources) in the respective pci_read_bridge_* calls ?
> >
> > No, don't claim in read. There's a clear distinction between gathering
> > resources and claiming them, and we need to keep that.
> >
> > Some fixups might happen in between the two for example.
> 
> Are there any existing fixups like that?  Concrete examples would help
> figure out the best way forward.
> 
> Most arches call pci_read_bridge_bases() from pcibios_fixup_bus().  I
> think that's a poor place to do it because it's code that normally
> doesn't have to be arch-specific.  Resource claiming is also usually
> done from arch code, and it shouldn't be arch-specific either.
> 
> If we move both the read and claim into generic code, then we might
> need to make sure there's a fixup phase in between or something.

Yes, that's where I am at the moment. On arm/arm64 PROBE_ONLY systems, if
I can't claim bridge apertures upon pci_read_bridge_bases, I can't
claim device resources in pcibios_add_device() since the bridge apertures
have not been claimed at that point, hence resulting in failures.

Given current code I see the following options:

(1) Claim bridge resources in pci_read_bridge_bases()
(2) Claim bridge resources in pcibios_add_device() (but that's horrible,
    since it requires looking up device upstream bridge and claim its
    resources)
(3) Do not claim resources on PROBE_ONLY systems (that's what arm does at
    present) and do not enable resources in pcibios_enable_device
(4) Add an initcall to arm/arm64 that carries out a resource survey,
    that's what's done on powerPC and also x86 it seems
    (eg pcibios_init in arch/powerpc/kernel/pci_64.c)

Personally I think (1) is by far the cleanest solution, I understand
Ben's concern but we need a way forward.

I will have to revert to (3) unless we find another solution, I would
like to make progress on this since it became a blocking issue.

As I said before, I will move pci_read_bridge_bases() to generic code
regardless.

Comments appreciated.

Thanks,
Lorenzo

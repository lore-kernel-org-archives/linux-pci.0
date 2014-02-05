Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:56865 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbaBET1i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Feb 2014 14:27:38 -0500
Date: Wed, 5 Feb 2014 12:27:33 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Message-ID: <20140205192733.GG25695@obsidianresearch.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <1391532784-1953-3-git-send-email-will.deacon@arm.com>
 <3460536.Sh23gjDa6X@wuerfel>
 <20140205190947.GA22297@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140205190947.GA22297@mudshark.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 05, 2014 at 07:09:47PM +0000, Will Deacon wrote:
> Hi Arnd,
> 
> Thanks for having a look.
> 
> On Tue, Feb 04, 2014 at 07:13:49PM +0000, Arnd Bergmann wrote:
> > On Tuesday 04 February 2014 16:53:03 Will Deacon wrote:
> > > +
> > > +- ranges         : As described in IEEE Std 1275-1994, but must provide
> > > +                   at least a definition of the Configuration Space plus
> > > +                   one or both of IO and Memory Space.
> > > +
> > 
> > I might need to reread the spec, but I think the config space is not
> > actually supposed to be in the 'ranges' of the host bridge at all,
> > and it should just be listed in the 'reg'.
> 
> This wasn't at all clear to me (I listed it in the cover-letter as being
> something to sort out).

When we talked about this earlier on the DT bindings list the
consensus seemed to be that configuration MMIO ranges should only be
used if the underlying memory was exactly ECAM, and was not to be used
for random configuration related register blocks.

The rational being that generic code, upon seeing that ranges entry,
could just go ahead and assume ECAM mapping.

> Now, if "reg" is definitely the correct thing to do, is it simply a matter
> of putting the Configuration Space base address in there, or do we also need
> to do the rest of what ePAPR says (expansion ROM details, ...)? I don't like
> the idea of enumerating the entire bus in the DT when we don't need to.

If you use 'reg' then it is a private base address to your driver and
you can do whatever you want with it.

Most of the ePAPR things are only needed if the FW is going to
communicate detailed information to the OS, for an environment that
relies on Linux resource assignment and discovery you can just ignore
all that.

> > This won't allow extended config space. Why not just do the
> > regular mmconfig layout and make this:
> > 
> > 	cfg_offset(bus, device, function, register) =
> > 		bus << 20 | device << 15 | function << 12 | register;
> 
> Is it worth adding a DT property to support both, or is ECAM the only thing
> to care about? I'm happy either way, although I'll need to hack kvmtool to
> use the new scheme.

If you use ECAM then I wonder if your driver might be a generic SBSA
driver too?

I can't think of a reason to support alternate MMIO layouts if
kvmtool is the only user and can be changed.

> > I don't think we even want "virt" in the compatible string. The
> > binding should be generic enough that it can actually work with
> > real hardware.
> 
> Sure. How about "arm,pci-generic" ? Alternatives are
> "arm,pcie-generic" or "linux,pci-generic".

arm,pci-ecam-generic ?

Regards,
Jason

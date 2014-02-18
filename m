Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59504 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbaBRUTZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 15:19:25 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host controller
Date: Tue, 18 Feb 2014 21:19:21 +0100
Message-ID: <1433616.UrvWxRt80Z@wuerfel>
In-Reply-To: <20140218195732.GL2010@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com> <20140218193654.GK2010@mudshark.cambridge.arm.com> <20140218195732.GL2010@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 18 February 2014 19:57:32 Will Deacon wrote:
> On Tue, Feb 18, 2014 at 07:36:54PM +0000, Will Deacon wrote:
> > On Tue, Feb 18, 2014 at 07:32:33PM +0000, Arnd Bergmann wrote:
> > > On Tuesday 18 February 2014 19:09:29 Will Deacon wrote:
> > > Regarding the PCI_PROBE_ONLY flag, how do you set that? Should we
> > > have a standard DT property for that? On PowerPC we already specified
> > > "linux,pci-probe-only" and "linux,pci-assign-all-buses", which seems
> > > reasonable to use in architecture independent code as well.
> > 
> > For arch/arm/ it's done on the command line (pci=firmware) but yes, for the
> > generic driver it sounds like a good idea to put this in the device-tree.
> > I'll look at adding the ppc properties in the next version.
> 
> Damn, I spoke too soon. PowerPC puts this information in the /chosen node, so
> it applies to all PCI host controllers in the system. That then maps nicely
> to pci_{add,clear}_flags which are global properties in Linux.
> 
> It sounds like this should really be per-controller. What do you think?

I don't have a strong opinion either way. I think the reason for having it
in the /chosen node is so that a second-stage boot loader can easily
override it, which is not a concern for us. In particular, the properties
are only used on rtas-pci, which means we access the config space to
firmware runtime abstraction services rather than hardware registers.

Apparently the embedded powerpc platforms don't support these flags at
all, which I also didn't notice at first.

	Arnd

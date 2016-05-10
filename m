Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58187 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbcEJLvK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 May 2016 07:51:10 -0400
Date: Tue, 10 May 2016 06:51:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-pci@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build warning regression (104daa71b396 ("PCI: Determine actual
 VPD size on first access"))
Message-ID: <20160510115103.GB29582@localhost>
References: <20160509195410.GB18166@localhost>
 <57317B31.8030203@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57317B31.8030203@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Geert]

On Tue, May 10, 2016 at 08:09:53AM +0200, Hannes Reinecke wrote:
> On 05/09/2016 09:54 PM, Bjorn Helgaas wrote:
> > Hi Hannes,
> > 
> > Geert's list of build regressions and improvements
> > (http://lkml.kernel.org/r/1462782250-6231-1-git-send-email-geert@linux-m68k.org)
> > shows these new warnings:
> > 
> >   drivers/pci/access.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 318:8
> >   drivers/pci/access.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 340:6
> > 
> > which I think are due to 104daa71b396 ("PCI: Determine actual VPD size on
> > first access").
> > 
> > Would you mind fixing those up and sending me a patch?  These were in
> > the v4.6-rc1 regressions email, and I should have noticed then, but I
> > didn't.
> > 
> This is curious.
> The code has this:
> 
> size_t off = 0;
> 
> ...
> 
> dev_warn(&dev->dev,
> 	"invalid large VPD tag %02x size at offset %zu",
> 	tag, off + 1);
> 
> Which, as per my reading, suggests that the last argument to
> dev_warn() is of type size_t.
> 
> Which tree has generated the above warning?

Yeah, it wasn't obvious to me how this would happen either.  From
Geert's original email, I think the tree is v4.6-rc7, i.e.,
44549e8f5eea4e0a41b487b63e616cb089922b99.

Geert, can you tell which config generated this warning?

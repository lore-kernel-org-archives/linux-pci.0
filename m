Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:43516 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbaKMFTa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Nov 2014 00:19:30 -0500
Message-ID: <1415855968.28703.5.camel@concordia>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@ozlabs.org,
	Dave Airlie <airlied@linux.ie>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Anton Blanchard <anton@au1.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Nov 2014 16:19:28 +1100
In-Reply-To: <1415765215.5124.30.camel@kernel.crashing.org>
References: <1412656696.30859.122.camel@pasglop>
	 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
	 <1412746096.30859.229.camel@pasglop> <20141015221914.GD15225@google.com>
	 <1413413732.11213.27.camel@pasglop> <20141111211248.GI28161@google.com>
	 <1415759019.10731.1.camel@concordia>
	 <1415765215.5124.30.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-11-12 at 15:06 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2014-11-12 at 13:23 +1100, Michael Ellerman wrote:
> > On Tue, 2014-11-11 at 14:12 -0700, Bjorn Helgaas wrote:
> > > On Thu, Oct 16, 2014 at 09:55:32AM +1100, Benjamin Herrenschmidt wrote:
> > > > On Wed, 2014-10-15 at 16:19 -0600, Bjorn Helgaas wrote:
> > > > >   PCI/MSI: Add device flag indicating that 64-bit MSIs don't work
> > > 
> > > I'm still assuming you're going to merge this series, but I don't see it in
> > > your tree (https://git.kernel.org/cgit/linux/kernel/git/benh/powerpc.git/)
> > > yet.  Do you want me to do anything with it?
> > 
> > I'm doing the powerpc tree this cycle, so it'd be in my tree, but it's not:
> > 
> >   https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/
> > 
> > Ben if you want me to take it let me know.
> 
> Hrm, I might have dropped the ball accidentally here. Bjorn did you
> actually Ack the core changes ? In that case we should probably pick it
> up.

I tried piecing together this series with v2 of patch 3 as you described, I
think, but it didn't apply cleanly, and I'm not confident I won't screw it up.

So please resend the series the way you want it to go in.

You got an ack from Bjorn:

  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

And he asked you change the subject on patch 2 to:

  PCI/MSI: Add device flag indicating that 64-bit MSIs don't work


cheers



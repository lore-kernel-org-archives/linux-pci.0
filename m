Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45887 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759212AbcBXTxA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Feb 2016 14:53:00 -0500
Date: Wed, 24 Feb 2016 13:52:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2] PCI: imx6: add dt prop for link gen, default to gen1
Message-ID: <20160224195257.GA31108@localhost>
References: <1446735481-27326-1-git-send-email-tharvey@gateworks.com>
 <1447942365-11662-1-git-send-email-tharvey@gateworks.com>
 <20151125231435.GI8869@localhost>
 <CAJ+vNU0ar_d=2n4Yz3QX4qidSkH6PBLyfB8-w-ErLOYzwqj7rw@mail.gmail.com>
 <CAJ+vNU399O0uskuAQGaqPQUhFdNYktZY4bm-=JCmdEgQF-HgYg@mail.gmail.com>
 <loom.20160224T202751-432@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20160224T202751-432@post.gmane.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Tim]

On Wed, Feb 24, 2016 at 07:35:55PM +0000, Akshay Bhat wrote:
> Tim Harvey <tharvey <at> gateworks.com> writes:
> 
> > >>
> > >> Is there some sort of DT or OF spec that lists "max-link-speed" as a
> > >> generic property?  I see Lucas' desire to have this be common across
> > >> DesignWare PCIe cores.  Should it be moved up a level even from there,
> > >> i.e., to bindings/pci/pci.txt?
> > >
> > > Bjorn,
> > >
> > > I don't know what the general consensus is here. As your the PCI
> > > maintainer I would leave that up to you. Are there other platforms
> > > that need to link at a lesser capability than the host controller is
> > > capable of? I am only aware of the IMX6 and SPEAr13XX [1]
> > >
> > > I can make that change and re-submit if you feel that is necessary.
> > >
> > 
> > Bjorn,
> > 
> > Any thoughts here? I would really like to see this get picked up
> > sooner rather than later.
> > 
> > Regards,
> > 
> > Tim
> > 
> 
> Bjorn,
> 
> It looks like there was no further follow-up on this patch. Could you 
> kindly provide feedback to Tim's question? We have multiple i.MX boards 
> that could use this patch to resolve PCIe issues.

Tim had mentioned doing a v3 with a documentation update, so I
dropped the v2 patch in anticipation of v3, which never appeared.

Looking at it again, I have another question, so I'll respond to that
thread again.

Bjorn

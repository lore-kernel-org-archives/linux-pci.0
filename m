Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36548 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab2HTFal (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2012 01:30:41 -0400
Received: by pbbrr13 with SMTP id rr13so6440379pbb.19
        for <linux-pci@vger.kernel.org>; Sun, 19 Aug 2012 22:30:40 -0700 (PDT)
Date: Sun, 19 Aug 2012 22:30:36 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120820053036.GA23166@kroah.com>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
 <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
 <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
 <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2012 at 11:32:47PM +0200, Thierry Reding wrote:
> On Fri, Aug 17, 2012 at 03:25:22PM -0600, Bjorn Helgaas wrote:
> > On Fri, Aug 17, 2012 at 3:07 PM, Thierry Reding
> > <thierry.reding@avionic-design.de> wrote:
> > > On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
> > >> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
> > > [...]
> > >> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
> > >> > affect you?  I think we would still have to change some __inits to
> > >> > __devinit, including pcibios_update_irq(), but it might be more
> > >> > manageable.
> > >>
> > >> You said that depending on HOTPLUG wouldn't be enough because it would
> > >> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
> > >> theoretically possible to build a kernel without HOTPLUG but have the
> > >> enumeration start after init because of deferred probing. Those cases
> > >> won't work if we keep __init or __devinit respectively, right?
> > >
> > > Another possibility would be to make PCI select HOTPLUG or depend on it.
> > > That way it would be made sure that __devinit wouldn't cause all the
> > > functions to be discarded after init.
> > 
> > There's been some discussion recently about whether CONFIG_HOTPLUG is
> > worth keeping any more, but nothing's been resolved yet.  If we did
> > decide to remove CONFIG_HOTPLUG, or require it for PCI, I would rather
> > just remove all the __devinit annotations because they'd be
> > superfluous.
> 
> I've missed that discussion. Can you point me to it?

It's pretty much just me saying the whole thing is a mess, causes
problems, and really doesn't solve any memory usage issues.  Ideally we
should just:
	- remove CONFIG_HOTPLUG and assume it is enabled
	- because of that, we can delete the large majority of the
	  __dev* markings

The memory savings these days are so tiny, if at all, and everyone,
including me, gets it wrong all the time.

As we pretty much allow anything to be disabled/enabled at any point in
time after boot, we are all running systems that rely on CONFIG_HOTPLUG
anyway.  To find a static system that doesn't need it is quite rare from
what I have found.

greg k-h

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51028 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060AbcFTVfJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 17:35:09 -0400
Date: Mon, 20 Jun 2016 15:43:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 4/4] PCI: Add runtime PM support for PCIe ports
Message-ID: <20160620204334.GB17036@localhost>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
 <1461919919-120102-5-git-send-email-mika.westerberg@linux.intel.com>
 <20160617204824.GB10416@localhost>
 <20160617213209.GA1927@wunner.de>
 <20160620081057.GV1739@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160620081057.GV1739@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 20, 2016 at 11:10:57AM +0300, Mika Westerberg wrote:
> On Fri, Jun 17, 2016 at 11:32:09PM +0200, Lukas Wunner wrote:
> > On Fri, Jun 17, 2016 at 03:48:24PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Apr 29, 2016 at 11:51:59AM +0300, Mika Westerberg wrote:
> > [snip]
> > > > +
> > > > +	/*
> > > > +	 * Prevent runtime PM if the port is advertising support for PCIe
> > > > +	 * hotplug. Otherwise the BIOS hotplug SMI code might not be able
> > > > +	 * to enumerate devices behind this port properly (the port is
> > > > +	 * powered down preventing all config space accesses to the
> > > > +	 * subordinate devices). We can't be sure for native PCIe hotplug
> > > > +	 * either so prevent that as well.
> > > 
> > > Can we wordsmith this comment a bit?  I'm not sure what "BIOS hotplug
> > > SMI code" even is or why it is relevant.  And it seems x86-centric so
> > > may not apply to other arches.
> > 
> > The comment pertains to:
> > https://bugzilla.kernel.org/show_bug.cgi?id=53811
> > 
> > It was discussed on April 12/13:
> > https://patchwork.kernel.org/patch/8782801/
> > 
> > Executive summary:
> > On non-Macs, Thunderbolt is driven by the firmware in System Management
> > Mode, on hotplug the CPU receives a Sytem Management Interrupt (SMI) and
> > jumps to SMM code. This doesn't work reliably if the hotplug port has
> > been transitioned to D3hot, the SMM code tries to access config space
> > of hotplugged devices (not possible if port is in D3hot) and is apparently
> > too dumb to check if the port is in D3hot and wake it up.
> 
> That's the best guess what happens on non-Macs.
> 
> Bjorn, do you want me to update the comment to open up what SMI means
> and maybe add better explanation?

I withdraw my request.  I guess it's probably not worth doing anything
right now.  It's just a little out of place because this is
theoretically generic code, but the whole SMM thing is x86-specific.

Bjorn

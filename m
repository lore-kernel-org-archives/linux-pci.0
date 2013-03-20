Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42293 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab3CTT0s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2013 15:26:48 -0400
Date: Wed, 20 Mar 2013 19:26:04 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Oliver Neukum <oneukum@suse.de>, Michal Marek <mmarek@suse.cz>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciehp: Add pciehp_surprise module option
Message-ID: <20130320192604.GA11660@srcf.ucam.org>
References: <s5h38vqjhk6.wl%tiwai@suse.de>
 <20130320175234.GA8948@srcf.ucam.org>
 <s5hppytq430.wl%tiwai@suse.de>
 <20130320191250.GA11262@srcf.ucam.org>
 <s5hmwtxq3ic.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5hmwtxq3ic.wl%tiwai@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 20, 2013 at 08:23:39PM +0100, Takashi Iwai wrote:
> At Wed, 20 Mar 2013 19:12:50 +0000,
> Matthew Garrett wrote:
> > On Wed, Mar 20, 2013 at 08:11:15PM +0100, Takashi Iwai wrote:
> > > I'm afraid that it's too radical to enable always.
> > 
> > Why?
> 
> Because I'm conservative :)
> Well, dunno.  It's just my feeling without deep thought.

Adding a parameter means it's broken until people discover that they 
need to pass a parameter to make it work, and many people will just be 
stuck with it not working. It really should be the last resort.

> > > Or, what about to check this bit only for disable path?
> > 
> > What happens if you unplug the device on one of the affected machines?
> 
> It continues working.  I mean, the PCI device is still there after
> unplug, but the Realtek driver unmounts it smoothly.  Re-plugging also
> works, too.  So, the handling via pciehp is needed only for the very
> first time to register the PCI device.

But if I plug in a different device, things will be broken, right?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

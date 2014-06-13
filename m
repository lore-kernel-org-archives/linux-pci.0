Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6789 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaFMSCr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Jun 2014 14:02:47 -0400
Message-ID: <1402682562.3707.32.camel@ul30vt.home>
Subject: Re: help with setpci "no devices at"
From: Alex Williamson <alex.williamson@redhat.com>
To: Patrick <patrick@spellingbeewinnars.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Fri, 13 Jun 2014 12:02:42 -0600
In-Reply-To: <539B3878.2070202@spellingbeewinnars.org>
References: <539B2609.3090106@spellingbeewinnars.org>
	 <539B3878.2070202@spellingbeewinnars.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-06-13 at 13:44 -0400, Patrick wrote:
> On 13/06/14 12:25 PM, Patrick wrote:
> > Hi Everyone
> >
> > Thanks again to Bjorn for helping me in the thread "updating firmware 
> > with setpci"
> >
> > I have started a new thread as it's more specific than the previous 
> > one and might be more valuable this way in the archives.
> >
> > I replaced a PCI chip on one card I am trying to copy the good PCI 
> > configuration space settings from another card, as-is they are very 
> > different and the repaired card is failing.
> >
> > I found a perfect little awk script here to generate setpci commands 
> > from lspci -xxx  :
> >
> > https://gist.github.com/jlopez-git/4594728
> >
> > I ended up with setpci complaining about missing a width. I found this 
> > thread:
> > https://access.redhat.com/site/solutions/45240
> >
> > It looks like older versions of the tool did not require widths to be 
> > specified. The awk script may be a bit dated.
> >
> > I changed XX= to XX.b=
> > setpci -sD 04:01.0 00.b=813010e8
> >
> > based on:
> > http://www.tutorialspoint.com/unix_commands/setpci.htm
> > which gave this example:
> > setpci -s 13:8.4 40.b=50:d0,04:0c,ff
> >
> >
> > but now I have another error:
> > setpci: Warning: No devices selected for "04:01.0".
> > setpci: Invalid width "0".
> >
> >
> > lspci shows the device at:
> > 04:01.0 Unassigned class [ff00]: Device a101:81ff
> >
> > The example showed the b near the register address but the "invalid 
> > width 0" error has me wondering if it's supposed to go somewhere else 
> > or I should be using a different width flag.
> >
> > Could someone point me in the right direction ?
> >
> > Thanks for reading-Patrick
> >
> >
> 
> I am not sure if it is good etiquette to answer your own post but I 
> wanted to mention that I found two of my mistakes.
> 
> I specified B but I was writing 4 bytes. I thought I better use the -D 
> flag to test-run things but that doesn't look right in this situation.
> 
> setpci -s  04:01.0 0x00.L=813010e8
> 
> Ran without errors but the changes were not reflected in the card's 
> configuration space. lspci -xxx gave the same results before and after. 
> I have run all commands as root.
> 
> If anyone can point out another mistake I have made that would be so great.

I think the premise of being able to "update" a device via PCI config
space is flawed.  Much of config space is read-only, such as the vendor
and device IDs that you're trying to change.  The bits that can be
changed are not persistent across boots.  Some devices may have
sequences where vendor capability fields can be used to access some sort
of programming mode of the card, but they would be very device specific.
You cannot simply write a new value to any given register and expect it
to change and be persistent.  Thanks,

Alex


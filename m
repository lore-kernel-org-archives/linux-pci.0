Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38143 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757135Ab2ARUgY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2012 15:36:24 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 08F8F21498
	for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2012 15:36:23 -0500 (EST)
Date: Wed, 18 Jan 2012 12:35:36 -0800
From: Greg KH <greg@kroah.com>
To: Martin Burnicki <martin.burnicki@meinberg.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI card not accessible; I/O ports at <ignored>
Message-ID: <20120118203536.GB2671@kroah.com>
References: <4F16EA07.4000607@meinberg.de>
 <20120118162858.GB22156@kroah.com>
 <4F170DDB.3010105@meinberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F170DDB.3010105@meinberg.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2012 at 07:22:19PM +0100, Martin Burnicki wrote:
> Greg KH wrote:
> >On Wed, Jan 18, 2012 at 04:49:27PM +0100, Martin Burnicki wrote:
> >>Hi folks,
> >>
> >>I'm maintaining the driver software for the PCI cards manufactured
> >>by our company, Meinberg Funkuhren in Germany. Basically our Linux
> >>driver supports all our PCI cards on all Linux kernels 2.6.x and
> >>3.x. The PCI cards are e.g. GPS receivers, radio clocks, or IRIG
> >>time code receivers.
> >
> >Nice, any reason why these drivers aren't in the main kernel.org tree?
> 
> Yes, you wouldn't like the coding style of our driver ;-)
> 
> Seriously, I have discussed this with some Linux guys before, and
> also with some folks from *BSD who also wanted to pick up the driver
> into their *BSD source trees.
> 
> 
> The disadvantages of this approach were:

<snip>

That all makes sense, thanks.  It's your decision, but note, everyone
who has ever taken the time to get their code into the main kernel tree,
FreeBSD included, has had less time and energy maintaining it over the
long-run.

Plus, you get support for your customers from Red Hat and SUSE and
others, and you don't void their warranty by loading unsupported kernels
:)

But it's your business decision, if this is what you want to do, great,
best of luck.

thanks,

greg k-h

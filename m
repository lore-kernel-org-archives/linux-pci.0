Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39602 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754783Ab1KRTL6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2011 14:11:58 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E210C20E27
	for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2011 14:11:57 -0500 (EST)
Date: Fri, 18 Nov 2011 11:11:17 -0800
From: Greg KH <greg@kroah.com>
To: Felipe Balbi <balbi@ti.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] DWC3: use module_pci_driver
Message-ID: <20111118191117.GA25016@kroah.com>
References: <20111118181249.GA29495@kroah.com>
 <20111118181424.GB29495@kroah.com>
 <20111118190413.GA11736@legolas.emea.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111118190413.GA11736@legolas.emea.dhcp.ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2011 at 09:04:14PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Nov 18, 2011 at 10:14:24AM -0800, Greg KH wrote:
> > From: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > This cuts down on the boilerplate code.
> > 
> > 
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Looks good to me. It would be nice to see a similar patch for
> dwc3-omap.c moving the platform_driver_register to this new macro :-)

We already have a platform driver macro in the tree, feel free to move
it to use it now if you want :)

thanks,

gre gk-h

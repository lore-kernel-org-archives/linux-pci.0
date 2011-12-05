Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56001 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756446Ab1LESjD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 13:39:03 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4130420AE2
	for <linux-pci@vger.kernel.org>; Mon,  5 Dec 2011 13:39:02 -0500 (EST)
Date: Mon, 5 Dec 2011 10:38:22 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] PCI: Add helper macro for pci_register_driver boilerplate
Message-ID: <20111205183822.GA7193@kroah.com>
References: <20111118181249.GA29495@kroah.com>
 <20111205102829.1a98d25d@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111205102829.1a98d25d@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 05, 2011 at 10:28:29AM -0800, Jesse Barnes wrote:
> On Fri, 18 Nov 2011 10:12:49 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > From: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > This patch introduces the module_pci_driver macro which is a convenience
> > macro for PCI driver modules similar to module_platform_driver. It is
> > intended to be used by drivers which init/exit section does nothing but
> > register/unregister the PCI driver. By using this macro it is possible
> > to eliminate a few lines of boilerplate code per PCI driver.
> > 
> > Based on work done by Lars-Peter Clausen <lars@metafoo.de> for other
> > busses (i2c and spi).
> > 
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > ---
> > 
> > Jesse, I've added the same type of macros for i2c, spi, and usb to my
> > driver-core tree, and converted a number of drivers to these new macros.
> > If you give me the ack, I can add this patch to my tree as well.
> > 
> > I'll follow up this patch with an example showing how it works.
> > 
> > Comments?
> > 
> 
> Yeah, I have no problem with it.  You can queue it up with the other
> changes and add my acked-by to keep dependencies to a minimum.

Wonderful, will do.

greg k-h

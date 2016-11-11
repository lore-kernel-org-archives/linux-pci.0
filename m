Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934727AbcKKWeJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 17:34:09 -0500
Date: Fri, 11 Nov 2016 16:34:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Lukas Wunner <lukas@wunner.de>,
        Pierre de Villemereuil <flyos@mailoo.org>,
        linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] USB: UHCI: report non-PME wakeup signalling for
 Intel hardware
Message-ID: <20161111223404.GU9868@bhelgaas-glaptop.roam.corp.google.com>
References: <Pine.LNX.4.44L0.1610211642420.1898-100000@iolanthe.rowland.org>
 <20161022100344.GB16082@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161022100344.GB16082@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 22, 2016 at 12:03:44PM +0200, Greg KH wrote:
> On Fri, Oct 21, 2016 at 04:49:07PM -0400, Alan Stern wrote:
> > The UHCI controllers in Intel chipsets rely on a platform-specific
> > non-PME mechanism for wakeup signalling.  They can generate wakeup
> > signals even though they don't support PME.
> > 
> > We need to let the USB core know this so that it will enable runtime
> > suspend for UHCI controllers.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > CC: <stable@vger.kernel.org>
> > 
> > ---
> > 
> > Greg:
> > 
> > This patch is somewhat independent of the 1/2 patch I sent to Bjorn.  
> > Still, it will help to keep them together.  Is it okay to have him
> > merge both of them through his tree?
> 
> Fine with me:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I applied both these patches to pci/pm for v4.10, thanks!

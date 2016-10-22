Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Sat, 22 Oct 2016 12:03:44 +0200
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Pierre de Villemereuil <flyos@mailoo.org>,
	linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] USB: UHCI: report non-PME wakeup signalling for
 Intel hardware
Message-ID: <20161022100344.GB16082@kroah.com>
References: <Pine.LNX.4.44L0.1610211642420.1898-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1610211642420.1898-100000@iolanthe.rowland.org>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 21, 2016 at 04:49:07PM -0400, Alan Stern wrote:
> The UHCI controllers in Intel chipsets rely on a platform-specific
> non-PME mechanism for wakeup signalling.  They can generate wakeup
> signals even though they don't support PME.
> 
> We need to let the USB core know this so that it will enable runtime
> suspend for UHCI controllers.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: <stable@vger.kernel.org>
> 
> ---
> 
> Greg:
> 
> This patch is somewhat independent of the 1/2 patch I sent to Bjorn.  
> Still, it will help to keep them together.  Is it okay to have him
> merge both of them through his tree?

Fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

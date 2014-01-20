Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34641 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbaATUfu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2014 15:35:50 -0500
Date: Mon, 20 Jan 2014 12:36:36 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: "Chen, Jamie" <jamie.chen@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	USB list <linux-usb@vger.kernel.org>,
	"Tsai, Gaggery" <gaggery.tsai@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: EHCI host broken -- interrupts disabled
Message-ID: <20140120203636.GA30640@kroah.com>
References: <CAErSpo6v-QLkthigN3HdLizCa_7QxOS+dZ61Fse2jz5KJRdh0Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1401161435350.1109-100000@iolanthe.rowland.org>
 <20140117182231.GA18421@google.com>
 <F01C6967BCFFB14E8DF7F5D2FD1053EB1A18C3@PGSMSX103.gar.corp.intel.com>
 <20140120193918.GD5545@xanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140120193918.GD5545@xanatos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 20, 2014 at 11:39:18AM -0800, Sarah Sharp wrote:
> On Mon, Jan 20, 2014 at 12:15:47PM +0000, Chen, Jamie wrote:
> > Try to apply this patch to kernel 3.8.0.
> > 
> > Make sure the ehci can work fine and lspci show that PCI_COMMAND_INTX_DISABLE is 0.
> > 
> > The patch can resolved this issue.
> 
> Great!  Thanks for testing, Jamie.
> 
> Bjorn, can you add me to the Cc list for this patch?  I'd like to notify
> other Linux distros when it lands so they can pick it up.

Might as well mark it for stable@vger.kernel.org, so that it does
automatically get propagated to the distros...

thanks,

greg k-h

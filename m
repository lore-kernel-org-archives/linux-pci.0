Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45307 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755840Ab3ICXGX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2013 19:06:23 -0400
Date: Tue, 3 Sep 2013 16:06:19 -0700
From: Greg KH <gregkh@linux-foundation.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [RFC] pci: crash on pci_unregister_driver after
 pci_register_driver fails
Message-ID: <20130903230619.GA12729@kroah.com>
References: <20130903153815.13638272@nehalam.linuxnetplumber.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130903153815.13638272@nehalam.linuxnetplumber.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 03, 2013 at 03:38:15PM -0700, Stephen Hemminger wrote:
> While debugging another problem with a PCI driver, I noticed that if
> device probe routine returns an error, the kernel will crash when module
> is unloaded. It looks like pci_register_driver() sets drv->bus to be PCI
> then in the module unload.
> 
> module_unload
>    my_device_exit_module
>       pci_unregister_driver
>          bus_remove_driver
>            OOPS
> 
> One way to fix this would be to have pci_register_driver clear the bus
> flag (it has no reference) if an error was detected.

Odd, no other buses do this, why would it matter for PCI?  Maybe they
just never fail their registering calls.

How about putting this in the driver core instead so that all busses get
fixed?

thanks,

greg k-h

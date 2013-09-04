Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:61403 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763106Ab3IDQNI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2013 12:13:08 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so507676pdj.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2013 09:13:07 -0700 (PDT)
Date: Wed, 4 Sep 2013 09:13:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Greg KH <gregkh@linux-foundation.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [RFC] pci: crash on pci_unregister_driver after
 pci_register_driver fails
Message-ID: <20130904091302.59970bbc@nehalam.linuxnetplumber.net>
In-Reply-To: <20130903230619.GA12729@kroah.com>
References: <20130903153815.13638272@nehalam.linuxnetplumber.net>
	<20130903230619.GA12729@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 3 Sep 2013 16:06:19 -0700
Greg KH <gregkh@linux-foundation.org> wrote:

> On Tue, Sep 03, 2013 at 03:38:15PM -0700, Stephen Hemminger wrote:
> > While debugging another problem with a PCI driver, I noticed that if
> > device probe routine returns an error, the kernel will crash when module
> > is unloaded. It looks like pci_register_driver() sets drv->bus to be PCI
> > then in the module unload.
> > 
> > module_unload
> >    my_device_exit_module
> >       pci_unregister_driver
> >          bus_remove_driver
> >            OOPS
> > 
> > One way to fix this would be to have pci_register_driver clear the bus
> > flag (it has no reference) if an error was detected.
> 
> Odd, no other buses do this, why would it matter for PCI?  Maybe they
> just never fail their registering calls.
> 
> How about putting this in the driver core instead so that all busses get
> fixed?
> 
> thanks,
> 
> greg k-h

Never mind, buggy driver

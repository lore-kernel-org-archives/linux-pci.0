Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52645 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757300Ab2FGVcT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Jun 2012 17:32:19 -0400
Message-ID: <1339104711.24838.29.camel@pasglop>
Subject: Re: [PATCH v2 0/2] Add pcibios_device_change_notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Date: Fri, 08 Jun 2012 07:31:51 +1000
In-Reply-To: <4FD0A257.4070506@jp.fujitsu.com>
References: <4FBC4C86.9050206@jp.fujitsu.com>
	 <1338960416.7150.160.camel@pasglop> <4FD0A257.4070506@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2012-06-07 at 21:45 +0900, Hiroo Matsumoto wrote:
> 
> > Also you seem to add:
> > 
> > +               /* Setup OF node pointer in the device */
> > +               dev->dev.of_node = pci_device_to_OF_node(dev);
> > 
> > This shouldn't be needed anymore, the device node should be setup by the
> > core nowadays. Is this just a remnant of you rebasing an old patch or do
> > you have a good reason to add this statement ?
> 
> No, I don't have a good reason to add this statement.
> I just tried to make this code be same with pcibios_setup_bus_devices.
> Thanks for your review and comment. 

Unless I'm mistaken, this statement was removed from
pcibios_setup_bus_devices() recently so I'd say it's a leftover from
your patch having been originally done on top of an older kernel.

I won't be back for another week or so but I'll see if I can get things
tested in the meantime.

Cheers,
Ben.



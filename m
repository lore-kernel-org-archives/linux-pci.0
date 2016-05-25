Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:42143 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbcEYMNC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2016 08:13:02 -0400
Date: Wed, 25 May 2016 14:16:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Peter Wu <peter@lekensteyn.nl>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Power on bridges before scanning new devices
Message-ID: <20160525121626.GA6339@wunner.de>
References: <20160519231234.GB1785@al>
 <1463991648-85051-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160523200042.GB24375@localhost>
 <20160523215015.GA31479@localhost>
 <20160524122357.GA20453@localhost>
 <20160524125323.GE1789@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160524125323.GE1789@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika,

On Tue, May 24, 2016 at 03:53:23PM +0300, Mika Westerberg wrote:
> One thing I noticed, though. When a bridge is transitioned to D0 we only
> wait for 10ms which is requirement for PCI functions. However, PCI PM
> specification 1.2 (chapter 4.2) requires that for buses to transition
> from B2 to B0 we need to wait minimum of 50ms before accessing a
> function on that bus.
> 
> We even have PCI_PM_BUS_WAIT defined in include/linux/pci.h but it is
> not used anywhere. Maybe it was not needed originally because we never
> powered down bridges anyway but now when we do, I think it is good idea
> to do what the spec requires.

The macro was introduced with

    commit aa8c6c93747f7b55fa11e1624fec8ca33763a805
    Author: Rafael J. Wysocki <rjw@sisk.pl>
    Date:   Fri Jan 16 21:54:43 2009 +0100
    PCI PM: Restore standard config registers of all devices early

but the only usage of it was removed with

    commit 476e7faefc43f106a90b5c96166c59b75de19d30
    Author: Rafael J. Wysocki <rjw@sisk.pl>
    Date:   Thu Jan 22 23:39:57 2009 +0100
    PCI PM: Do not wait for buses in B2 or B3 during resume

Best regards,

Lukas

>
> What do you think? We could add a separate patch doing something like
> below to make sure the spec is followed.
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e785dc260e72..b3b794caa380 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2361,7 +2361,12 @@ void pci_pm_init(struct pci_dev *dev)
>  	}
>  
>  	dev->pm_cap = pm;
> -	dev->d3_delay = PCI_PM_D3_WAIT;
> +	/*
> +	 * PCI PM 1.2 specification requires minimum of 50ms before any
> +	 * function on the bus is accessed after the bus is transitioned
> +	 * from B2 to B0.
> +	 */
> +	dev->d3_delay = pci_is_bridge(dev) ? PCI_PM_BUS_WAIT : PCI_PM_D3_WAIT;
>  	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
>  	dev->bridge_d3 = pci_bridge_d3_possible(dev);
>  	dev->d3cold_allowed = true;

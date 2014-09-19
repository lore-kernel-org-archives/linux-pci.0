Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62794 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbaISREX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Sep 2014 13:04:23 -0400
Received: by mail-pa0-f47.google.com with SMTP id et14so471183pad.20
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2014 10:04:22 -0700 (PDT)
Date: Fri, 19 Sep 2014 11:04:18 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: David Henningsson <david.henningsson@canonical.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH] Add pci=assign-busses quirk to Dell Latitude D505
Message-ID: <20140919170418.GB19374@google.com>
References: <1409303414-5196-1-git-send-email-david.henningsson@canonical.com>
 <CAErSpo5v82xeYGqsiWXpfQdr8kF9x+1K4gjYremfCh3fNQ8Unw@mail.gmail.com>
 <540091D1.1040902@canonical.com>
 <CAErSpo6D+8KwM9LJC4VFCtGbQ65zh_2ZjNOuP-JQB1bmt5dwCw@mail.gmail.com>
 <CAErSpo6DDCkrew8rwkNX8=gzc19vErY5iafPBN4oKw_Ww792=g@mail.gmail.com>
 <54115995.5020107@canonical.com>
 <20140913031818.GA25656@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140913031818.GA25656@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 12, 2014 at 09:18:18PM -0600, Bjorn Helgaas wrote:
> On Thu, Sep 11, 2014 at 10:13:09AM +0200, David Henningsson wrote:
> > 
> > 
> > On 2014-09-10 20:08, Bjorn Helgaas wrote:
> > >[+cc Andreas]
> > >v3.16 fails with:
> > >
> > >   pci 0000:01:01.0: can't allocate child bus 01 from [bus 01]
> > >
> > >which Andreas added with fc1b253141b3 ("PCI: Don't scan random busses
> > >in pci_scan_bridge()").  But I don't understand that code well enough
> > >to know whether this commit is actually the cause of the problem.
> > >
> > >And I also haven't figured out how "pci=assign-busses" makes a difference.
> > >
> > >David, would you mind turning on CONFIG_DYNAMIC_DEBUG=y in your v3.16
> > >kernel, adding  'dyndbg="file probe.c +p"' to your boot arguments, and
> > >collecting another dmesg log?
> > 
> > Thanks for looking at this (and sorry for not having done a bisect yet).
> > 
> > Anyhow, a new dmesg log has now been posted at kernel bugzilla
> > #83441. It has a few more lines starting with "pci_bus" but nothing
> > that really stands out AFAICT.
> 
> We need to make progress on this regression before v3.17.  David, can you
> test the following revert (on top of v3.17-rc2)?  If it works, I plan to
> apply it for v3.17 (unless we have a better solution, of course).

David reported at https://bugzilla.kernel.org/show_bug.cgi?id=83441#c7 that
the revert below did fix the problem, so I'm going to apply it for v3.17.

I'd prefer to use something like Andreas' pci_grow_bus() patch, but I don't
think it's going to be ready in time for v3.17.  I hope we can polish that
for v3.18 or v3.19.

Bjorn

> commit 413db4234ebbb9750f01180c04965ad3a5e18986
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Sep 12 20:46:09 2014 -0600
> 
>     Revert "PCI: Don't scan random busses in pci_scan_bridge()"
>     
>     This reverts commit fc1b253141b3 ("PCI: Don't scan random busses in
>     pci_scan_bridge()") because it breaks CardBus on some machines.
>     
>     David tested a Dell Latitude D505 that worked like this prior to
>     fc1b253141b3:
>     
>         pci 0000:00:1e.0: PCI bridge to [bus 01]
>         pci 0000:01:01.0: CardBus bridge to [bus 02-05]
>     
>     Note that the 01:01.0 CardBus bridge has a bus number aperture of
>     [bus 02-05], but those buses are all outside the 00:1e.0 PCI bridge bus
>     number aperture, so accesses to buses 02-05 never reach CardBus.  This is
>     later patched up by yenta_fixup_parent_bridge(), which changes the
>     subordinate bus number of the 00:1e.0 PCI bridge:
>     
>         pci_bus 0000:01: Raising subordinate bus# of parent bus (#01) from #01 to #05
>     
>     With fc1b253141b3, pci_scan_bridge() just fails immediately when it notices
>     that we can't allocate a valid secondary bus number for the CardBus bridge,
>     and CardBus doesn't work at all:
>     
>         pci 0000:01:01.0: can't allocate child bus 01 from [bus 01]
>     
>     I'd prefer to fix this by integrating the yenta_fixup_parent_bridge() logic
>     into pci_scan_bridge() so we fix the bus number apertures up front.  But
>     that's a bigger effort, and I want to fix the regression while we're
>     working on it.
>     
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=83441
>     Link: http://lkml.kernel.org/r/1409303414-5196-1-git-send-email-david.henningsson@canonical.com
>     Reported-by: David Henningsson <david.henningsson@canonical.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: stable@vger.kernel.org	# v3.15+
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e3cf8a2e6292..7c8ca351beae 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -838,16 +838,12 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>  			goto out;
>  		}
>  
> -		if (max >= bus->busn_res.end) {
> -			dev_warn(&dev->dev, "can't allocate child bus %02x from %pR\n",
> -				 max, &bus->busn_res);
> -			goto out;
> -		}
> -
>  		/* Clear errors */
>  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
>  
> -		/* The bus will already exist if we are rescanning */
> +		/* Prevent assigning a bus number that already exists.
> +		 * This can happen when a bridge is hot-plugged, so in
> +		 * this case we only re-scan this bus. */
>  		child = pci_find_bus(pci_domain_nr(bus), max+1);
>  		if (!child) {
>  			child = pci_add_new_bus(bus, dev, max+1);

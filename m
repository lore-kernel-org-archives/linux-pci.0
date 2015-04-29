Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33991 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbD2WCv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2015 18:02:51 -0400
Received: by qkgx75 with SMTP id x75so23665400qkg.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2015 15:02:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABLseQ7Vog4YgCwhrVhqmp-8h84f2qbTog=nPYKzc4ZE8pvHhw@mail.gmail.com>
References: <CABLseQ7Vog4YgCwhrVhqmp-8h84f2qbTog=nPYKzc4ZE8pvHhw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 29 Apr 2015 17:02:30 -0500
Message-ID: <CAErSpo5JqouUgXw+9YWkk5BjAbTRUeoNYrmfPD4NQRh40jhkNA@mail.gmail.com>
Subject: Re: Endpoint-to-Endpoint communication - Handshake Problem Enumeration
To: Barry Grussling <barry@grussling.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Barry,

On Mon, Apr 27, 2015 at 1:22 PM, Barry Grussling <barry@grussling.com> wrote:
> Hello Everyone,
>
> I am working on a device with a PLX PCIe switch and multiple
> PCIe endpoints enumerated off an ARM RP.  I am playing with
> endpoint-to-endpoint communications.  I have verified after
> the PCIe bus is enumerated that I can send TLPs from
> one endpoint to an enumerated BAR on another endpoint
> and the TLP is directed to the other endpoint.  I have further
> verified that the RP receivies nothing as desired.

I think this is what we've referred to as "peer-to-peer" traffic.
Linux has no real infrastructure for supporting that, and there may be
assumptions that devices don't do it, e.g., when configuring MPS or
elsewhere.  I don't *know* of problems; it's just mostly uncharted
territory.

> The issue I am looking for some advice on is how to tell
> each endpoint what all the other endpoints BAR address is.
> For the sake of argument, lets say I have N modules and
> each module needs to know the enumerated endpoint
> address of the other N-1 modules Bar0 address.
>
> The brute force/prototype method I have been testing is
> scrape /proc/iomem after enumeration and write to each
> card's registers via /dev/mem the address of all other
> cards.  This works, but is not something I would put
> on my resume.  I am now trying to "do it right".  This
> scraping also assumes bus addresses and host addresses
> are the same.  This seems to be true on my architecture.

If you can get hold of struct pci_dev pointers for all the devices,
you can use pci_resource_start() to get CPU physical addresses for the
BARs.  You can use pci_bus_address() to get the bus address.  Bus
addresses and CPU physical addresses are the same on some
architectures, but certainly not all.

A bus address is only meaningful to other devices under the same host
bridge, but I'm guessing all the devices you're interested in are in
the same hierarchy.

> My preliminary driver design has a common base layer
> that each endpoint's driver registers with when it is probed.
> After the BAR addresses are assigned the endpoint driver
> tells the common base layer its assigned address and
> the base layer writes that into registers in all the
> other registered endpoints via their respective drivers.

All BARs should be assigned before a driver sees the device.  After
the PCI core calls the driver's probe function, the core should not
modify anything the driver uses.

> Before I go off boldly and and completely re-invent the
> wheel I was wondering if something like this had
> been contemplated or created yet, perhaps via
> callback hooks or some other PCIe framework
> thingy I am not aware of.  Or is there another way
> to achieve the same goal?
>
> Anyone have any feedback?
>
> Thanks for your time!
>
> Barry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

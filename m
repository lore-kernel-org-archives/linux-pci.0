Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:47487 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934805Ab3E1RBl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 13:01:41 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so10179905oag.20
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2013 10:01:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t-cMzioGkLBLXSzcGzZwC0cMm-486_h52PFx286p9sWGg@mail.gmail.com>
References: <CAH9N0t_dNJ+u+9BLFTsqRNnbRO4xMaGYqE6_du_u+joZfzBYyA@mail.gmail.com>
 <CAErSpo7TXMOake9=oXwa-JA9qd9FmwNtHqM6RSt12QO=WORshA@mail.gmail.com>
 <CAH9N0t8-6CgmhQhiu7zy1r4UnYyjJqkmAnrDRhjt3t71F7SxNA@mail.gmail.com>
 <CAE9FiQV4Okzz2jomvwzg7_jS5sKS9Br7LtjbMDy5=BHebTvyDA@mail.gmail.com> <CAH9N0t-cMzioGkLBLXSzcGzZwC0cMm-486_h52PFx286p9sWGg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 May 2013 11:01:20 -0600
Message-ID: <CAErSpo7zKC4eSBDnefraov8Aj211k8uEqcgQVLG8tgYeCdocww@mail.gmail.com>
Subject: Re: Pcie Linux HotPlug Driver
To: Paulo Ricardo Carvalho <pricardofc@ipfn.ist.utl.pt>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 28, 2013 at 6:05 AM, Paulo Fortuna Carvalho
<pricardofc@ipfn.ist.utl.pt> wrote:
> Hello Yinghai,
> Here goes, in attached .zip file the commands output that you suggested.

It looks like the part you're interested in is this:

    00:03.0 bridge to [bus 03-1a] (Intel root port)
    03:00.0 bridge to [bus 04-1a] (PLX 8733 upstream port)
    04:08.0 bridge to [bus 05-1a] (PLX 8733 downstream port)
    05:00.0 bridge to [bus 06-1a] (PLX 8696 upstream port)
    06:07.0 bridge to [bus 0a] (PLX 8696 downstream port)
    0a:00.0 endpoint (PLD Applications 6114)
    06:0e.0 bridge to [bus 11] (PLX 8696 downstream port)
    11:00.0 endpoint (PLD Applications 6014)

I assume everything except the root port is on your ATCA card, and you
want to hotplug the card as a whole.

This would be handled by the hotplug controller in the 00:03.0 root
port, using pciehp.

Your first step should be to verify that hotplugging the card works
without your ATCA drivers in the system.  When you hot-add the card,
you should see messages in dmesg about the hot-add event and
enumerating all the PCI devices on the card.  lspci at this point
should show your devices, and they should appear in sysfs, but of
course you can't use them because your ATCA drivers aren't loaded.

You should also be able to remove the card (you can request the
removal using the sysfs remove interface or buttons on your ATCA
chassis if they exist) and you should see notes in dmesg about the
devices being removed, and they should disappear from lspci output and
from sysfs.

Your ATCA drivers should be normal PCI device drivers (not port
drivers), and they shouldn't need to do anything special to deal with
hotplug.  From the point of view of your driver, there *is* no
hot-plug.  Your .probe() method will be called after the PCI core
enumerates and configures all the devices, just like it would be if
the card were present at boot-time.  Your .remove() method is called
before the device is powered-off, just like it would be at system
shutdown time.

If you're still having trouble, please collect a complete dmesg log
showing the problem.

Bjorn

> 2013/5/27, Yinghai Lu <yinghai@kernel.org>:
>> On Mon, May 27, 2013 at 9:45 AM, Paulo Fortuna Carvalho
>> <pricardofc@ipfn.ist.utl.pt> wrote:
>>> My card includes a PCIe Switch.
>>> My coordinators told me that a solution for hotplug (remove/insert
>>> board without shutting down the system) could be the PCIe Port Bus
>>> Driver Model using also pciehp.ko already installed in Linux System.
>>
>> can you post
>> lspci -vvxxx
>> lspci -tv
>> with and without your card/fpga working?
>>
>> If your card have a pcie switch, then you can make your down port has
>> pcie slot cap that support pciehp.
>>
>> Yinghai
>>

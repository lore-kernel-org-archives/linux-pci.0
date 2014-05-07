Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:51960 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895AbaEGNJE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 May 2014 09:09:04 -0400
Received: by mail-lb0-f175.google.com with SMTP id l4so1298950lbv.6
        for <linux-pci@vger.kernel.org>; Wed, 07 May 2014 06:09:03 -0700 (PDT)
MIME-Version: 1.0
Reply-To: pricardofc@ipfn.ist.utl.pt
Date: Wed, 7 May 2014 14:09:02 +0100
Message-ID: <CAH9N0t8HdJadhJ9A=Z2owAb0RZU70g2G+XWE+MG155hbb4BfWQ@mail.gmail.com>
Subject: Hotswap with an ATCA PCI Express carrier containing a PCIe Switch
From: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,
Im trying to remove and insert a carrier PCI Express card that
contains an endpoint card from an ATCA system. The PCI express card
that contains the PCIe Swittch (PEX 8696 from PLX) is attached to an
OSS (One Stop System) card that contains the Root Complex (PEX 8733
from Plx) via a PCI Express cable. The OSS card is a x16 PCI Express
card placed in the PCIE motherboard slot from a computer running
Redhat 6.3 with real time kernel version 3.0.9.rt.
When I hotplug, remove or insert, the endpoint connected to the
carrier card everything goes well with the removal and insertion
procedures (also the device drivers are unloaded and loaded from the
system when I run "remove" and "rescan" commands through an hotplug
developed service for this purpose).

Problems arrive when I try to hotplug (hotswap to be precise) the
carrier card containing PEX 8696 (PCIe Switch). I can perform the
operation once by removing and inserting the PCI Express cable
connected between carrier and OSS cards (and consequently unloading
and loading the corresponding carrier device drivers). When performing
the same operation for the second time I can remove the PCI express
cable and unload carrier device drivers again but the insert procedure
(and device drivers load operation) no longer occur because PCI
Express upstream (from PEX 8733, the root complex point of view) link
does not seems to happen (signalled by a LED indicator placed in the
carrier card).

There was a test in which I could manage to perform the above
operation 3 times and in the 4th insertion the same happened (but in
this test I opened the Plx editor software between each operation of
removal and insertion to capture a snapshot of the PEX 8733 upstream
registers to track and isolate the problem). So I suppose that somehow
when the link negotiation procedure fails the hotswap procedure no
longer occurs.

Also when I run "lspci" command PEX 8696 no longer appears (of course)
and the branch of the entire PCI express tree (path until the FPGA
endpoint) reaches only until the PEX 8733 downstream port.

Can anybody explain what is happening and what can I do to restore the
PCI express link each time I perform the hotswap procedure?
Also, from the registers snapshot I could see that somehow when this
happens there is always TLP packet that is waiting to be delivered
(pending I suppose) but I don't know if this is an hardware or
software issue.

Regards,
Paulo.

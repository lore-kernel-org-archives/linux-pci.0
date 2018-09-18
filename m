Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbeIRSxc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 14:53:32 -0400
Date: Tue, 18 Sep 2018 08:20:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Walker <danielwa@cisco.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: PCI: Enforce bus address limits in resource allocation
Message-ID: <20180918132056.GA254348@bhelgaas-glaptop.roam.corp.google.com>
References: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Daniel,

Sorry about the regression, and thanks very much for your
investigation to identify the cause!

On Fri, Sep 14, 2018 at 08:16:35AM -0700, Daniel Walker wrote:
> I have a powerpc system with PCI, and some devices attached to the PCI bus.
> In 3.10 everything worked fine, then we moved to 4.9 and we had some issues.
> I was able to bisect the issue down to the patch in the subject line.
> 
> f75b99d PCI: Enforce bus address limits in resource allocation
> 
> 
> From 3.10 here is part of the PCI initialization,
> 
> |pci 0001:0e:00.0: BAR 0: assigned [mem 0xfc0000000-0xfc00fffff pref]|
> |pci 0001:07:09.0: PCI bridge to [bus 0e]|
> |pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]|
>                 |||In this section the memory resource for the bridge is
> 64bit, and the device "BAR 0" gets a 64bit range. However, it seems the
> device is 32bit.|

The device does appear to have a 32-bit BAR because the "BAR 0" line
doesn't include "64bit".  However, the 0xfc0000000 resource is not an
indication of a 64-bit range because 0xfc0000000 is a CPU address, not
a bus address.

If the host bridge performs address translation, e.g., it might
produce a bus address by stripping off the high-order bits of the CPU
address, this might produce a 32-bit bus address.  The fact that the
device works suggests that the host bridge is doing some translation.

Documentation/DMA-API-HOWTO.txt has some generic background on these
translations.

The "bridge window" line contains "64bit", but that's telling us the
*width* of the bridge window register; it doesn't tell us anything
about the current *setting* of that register.

> |Now fast forward to 4.9 we get this,|

> pci 0001:0e:00.0: BAR 0: no space for [mem size 0x00100000 pref]
> pci 0001:0e:00.0: BAR 0: failed to assign [mem size 0x00100000 pref]
> pci 0001:07:09.0: PCI bridge to [bus 0e]
> pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]
> 
> |Here it seems to have a larger size, I'm not sure where the size is coming
> from.

The size is 0x00100000 (1MB), which is the same size as 
[mem 0xfc0000000-0xfc00fffff pref].

The size is normally discovered by probing the BAR (write all 1's to
the BAR then read it back to find which bits are writable and which
are read-only).  On powerpc we might learn it from DT instead.  But in
any case, we to get the same 1MB size, which is the same size as the
bridge window.  So this should still work unless there are other BARs
in that window.

> I was able to work around the issue by setting IORESOURCE_MEM_64 on
> the resource for this device. I also was able to work around it by setting
> "max = avail.end" to "max = (-1);" inside pci_bus_alloc_resource(). |
> ||
> ||I don't know if the problem is the patch, or something else inside our
> system, but any thoughts are appreciated.

It seems like we think the bridge window contains only 64-bit space
and therefore contains nothing usable by the 32-bit BAR.

You said later that the same problem exists on v4.19-rc4.  Can you
collect the complete dmesg log with that kernel?  That should tell us
about any host bridge address translation.

Bjorn

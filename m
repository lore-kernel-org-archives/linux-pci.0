Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38162 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbbE0WvU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 18:51:20 -0400
Received: by igbjd9 with SMTP id jd9so10831667igb.1
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2015 15:51:19 -0700 (PDT)
Date: Wed, 27 May 2015 17:51:16 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v0 00/13] PCI: Static Enumeration
Message-ID: <20150527214725.GE10210@google.com>
References: <f10f623e0316433abe30420d68f73e33@XCGVAG27.northgrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f10f623e0316433abe30420d68f73e33@XCGVAG27.northgrum.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 27, 2015 at 08:58:38PM +0000, Tang, Jason (ES) wrote:
> ...
> Q1: Doesn't PCI Hotplug already solve this problem?
> A1: From what I can tell, the existing PCI Hotplug infrastructure only
>     works with PCI endpoints; it has no way to handle hot adding a
>     bridge, and then later on hot adding an endpoint.

__pci_bus_size_bridges() uses pci_hotplug_mem_size (default 2MB,
overridable with "pci=hpmemsize=") to reserve space for things that may be
hot-added below a bridge that supports hotplug.  The thing that's added may
be a bridge, and that bridge might support hotplug, and it should work at
hot-add a device below that bridge.

So in principle, this should work, but there might be something broken.

If you conclude it "has no way to handle hot adding a bridge," there must
be something seriously broken, and I'd like to fix that, even if it's not
sufficient to deal with your whole situation.

Can you post a complete dmesg log showing the two hot-adds and the failure?

>     Static enumeration can also be used in cases where the memory
>     behind a bridge needs to be changed due to faulty hardware.

Can you elaborate on this a bit?  Are you saying you have a piece of
defective hardware, and you can avoid the defect by assigning different
addresses to it?

> Q2: Why do bus numbers need to be reenumerated?
> A2: Consider a bus "A", with secondary bus number 1), has two child
>     buses, "B" and "C". Suppose that "B" has no grandchild buses, so
>     let its bus range is [2-2]. Likewise, "C" also has no grandchild
>     buses, so its bus range is [3-3]. Therefore, "A"'s bus range is
>     [1-3]. Let a new bridge "D" be hot added under "B". This bridge's
>     bus needs to be within its parent's bus range, but "B" has no
>     space for it. If "B" were to be dynamically resized to [2-3], then
>     "C"'s bus number would now be invalid.

I would expect to see a dev->is_hotplug_bridge test in the bridge
enumeration path (maybe somewhere in pci_scan_bridge()) so we could
reserve some bus numbers for future hot adds.  But I don't, so maybe
this is just a bug.

There's a lot of this stuff that works fairly well as long as the BIOS has
preconfigured things.  If your BIOS doesn't do that, I could certainly
believe it wouldn't work as well.  I would prefer to make Linux work better
and depend less on BIOS if we can.

Bjorn

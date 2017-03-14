Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41566 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdCNNG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2017 09:06:28 -0400
Date: Tue, 14 Mar 2017 14:06:13 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andi Kleen <andi@firstfloor.org>
cc: bhelgaas@google.com, x86@kernel.org, linux-pci@vger.kernel.org,
        eranian@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/4] pci: Allow lockless access path to PCI mmconfig
In-Reply-To: <20170302232104.10136-1-andi@firstfloor.org>
Message-ID: <alpine.DEB.2.20.1703141106231.3619@nanos>
References: <20170302232104.10136-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2 Mar 2017, Andi Kleen wrote:

> From: Andi Kleen <ak@linux.intel.com>
> 
> The Intel uncore driver can do a lot of PCI config accesses to read
> performance counters. I had a situation on a 4S system where it
> was spending 40+% of CPU time grabbing the pci_cfg_lock due to that.
> 
> For 64bit x86 with MMCONFIG there isn't really any reason to take
> a lock. The access is directly mapped to an underlying MMIO area,
> which can fully operate lockless.
> 
> Add a new flag that allows the PCI mid layer to skip the lock
> and set it for the 64bit mmconfig code.
> 
> There's a small risk that someone relies on this lock for synchronization,
> but I think that's unlikely because there isn't really any useful
> synchronization at this individual operation level. Any useful
> synchronization would likely need to protect at least a
> read-modify-write or similar.  So I made it unconditional without opt-in.

This part of the changelog is just crap.

The reason why pci_lock exists and is taken for each single read/write
config is that some ops implementations, e.g. the generic ones, must
protect at this granularity level because

	ops->map_bus()
	read/writeX()

needs to be 'atomic'.

MMCONFIG obviously does not require this at all because it's a simple
byte/word/dword read/write which is serialized by itself. So it's obvious
that the serialization with pci_lock is pointless in this case.

It's not that hard to figure it out and write up a proper changelog instead
of handwaving about risk and whatever.

Thanks,

	tglx

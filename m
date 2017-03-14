Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:43305 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdCNQlF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2017 12:41:05 -0400
Date: Tue, 14 Mar 2017 17:40:49 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andi Kleen <ak@linux.intel.com>
cc: Andi Kleen <andi@firstfloor.org>, bhelgaas@google.com,
        x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
In-Reply-To: <20170314154155.GG32070@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.20.1703141713010.3619@nanos>
References: <20170302232104.10136-1-andi@firstfloor.org> <20170302232104.10136-3-andi@firstfloor.org> <alpine.DEB.2.20.1703141407090.3619@nanos> <20170314154155.GG32070@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 14 Mar 2017, Andi Kleen wrote:

> > And the way how this function is used is a horrible hack. It's called from
> > a random driver at some random point in time.
> > 
> > The proper solution is to identify the bus at the point where the bus is
> > discovered and switch it to mmconfig if possible.
> 
> But how would you know that it is safe?
> AFAIK the only one who knows "this is an internal SOC device" is the driver.

The driver handles a specific device, but you apply that tweak to the bus
of which the device hangs off.

> Or are you saying it should be enabled unconditionally for everything?

No.

> Or define some quirk table just for this purpose?

Nope. It's about identifying the bus.

The bus which contains the uncore devices:

 The Uncore devices reside on CPUBUSNO(1), which is the PCI bus assigned
 for the processor socket. The bus number is derived from the max bus range
 setting and the processor socket number.

So there should be a way to detect that and it would be appreciated if you
could talk to your hardware folks what's the programmatic way to figure it
out. Maybe there is information in ACPI as well.

Thanks,

	tglx

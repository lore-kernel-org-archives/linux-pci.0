Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:61938 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751188AbdCNRDH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Mar 2017 13:03:07 -0400
Date: Tue, 14 Mar 2017 10:02:55 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <andi@firstfloor.org>, bhelgaas@google.com,
        x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
Message-ID: <20170314170255.GH32070@tassilo.jf.intel.com>
References: <20170302232104.10136-1-andi@firstfloor.org>
 <20170302232104.10136-3-andi@firstfloor.org>
 <alpine.DEB.2.20.1703141407090.3619@nanos>
 <20170314154155.GG32070@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1703141713010.3619@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1703141713010.3619@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > Or define some quirk table just for this purpose?
> 
> Nope. It's about identifying the bus.

PCI just has no good way to identify busses.

> 
> The bus which contains the uncore devices:
> 
>  The Uncore devices reside on CPUBUSNO(1), which is the PCI bus assigned
>  for the processor socket. The bus number is derived from the max bus range
>  setting and the processor socket number.

I have had bad experiences with hard coding topology like this. These
things tend to be very configurable by BIOS.

> 
> So there should be a way to detect that and it would be appreciated if you
> could talk to your hardware folks what's the programmatic way to figure it
> out. 

There's likely some hidden register somewhere. But then it would be

check model number
look for hidden register
configure these busses

and it will likely change often.

Frankly I fail to see how such a thing is better than just using
the device ID. Perhaps the driver is not the right place for it,
but the ID seems to be.

The other option is to simply make it unconditional. That would
be even simpler, but it is a bit more risky. Hmm, I suppose may
be worth trying to find out what Windows uses. If they get away
with MMCONFIG everywhere we should be too.

Or the third option would be to move the ops pointer into the 
PCI device, so it's a per device setting. If people are ok with that
I can look into it.

> Maybe there is information in ACPI as well.

I don't think ACPI has any concept of "internal SOC busses"

-Andi

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41932 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdCNNzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2017 09:55:55 -0400
Date: Tue, 14 Mar 2017 14:55:30 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andi Kleen <andi@firstfloor.org>
cc: bhelgaas@google.com, x86@kernel.org, linux-pci@vger.kernel.org,
        eranian@google.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
In-Reply-To: <20170302232104.10136-3-andi@firstfloor.org>
Message-ID: <alpine.DEB.2.20.1703141407090.3619@nanos>
References: <20170302232104.10136-1-andi@firstfloor.org> <20170302232104.10136-3-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2 Mar 2017, Andi Kleen wrote:
> +struct pci_ops pci_mmconfig_ops = {
> +	.read = pci_mmconfig_read,
> +	.write = pci_mmconfig_write,
> +};
> +
> +/* Force all config accesses to go through mmconfig. */
> +int pci_bus_force_mmconfig(struct pci_bus *bus)
> +{
> +	if (!raw_pci_ext_ops)
> +		return -1;

We have error defines. That aside, the weak version of this returns 0,
i.e. success, but here you return fail. Consistency is overrated, right?

> +	bus->ops = &pci_mmconfig_ops;

What guarantees that raw_pci_ext_ops == pci_mmcfg? Nothing as far as I can
tell. So that function name is nonsensical. It does not force anything.

And the way how this function is used is a horrible hack. It's called from
a random driver at some random point in time.

The proper solution is to identify the bus at the point where the bus is
discovered and switch it to mmconfig if possible.

Thanks,

	tglx

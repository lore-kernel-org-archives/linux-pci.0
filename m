Return-Path: <SRS0=Rvi+=CV=ellerman.id.au=mpe@kernel.org>
Return-Path: <SRS0=Rvi+=CV=ellerman.id.au=mpe@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/pci: convert to use for_each_pci_bridge() helper
In-Reply-To: <20171122201259.GA21158@bhelgaas-glaptop.roam.corp.google.com>
References: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com> <20171122201259.GA21158@bhelgaas-glaptop.roam.corp.google.com>
Date: Thu, 23 Nov 2017 23:48:18 +1100
Message-ID: <87zi7d17ql.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Nov 10, 2017 at 07:52:29PM +0200, Andy Shevchenko wrote:
>> ...which makes code slightly cleaner.
>> 
>> Requires: d43f59ce6c50 ("PCI: Add for_each_pci_bridge() helper")
>
> Requires: 24a0c654d7d6 ("PCI: Add for_each_pci_bridge() helper")
>
> (My fault, I rebased that commit before sending it to Linus.)
>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> These don't depend on anything in the PCI core, so they could go
> either via my tree or the powerpc tree.  Since you acked this,
> Michael, I corrected the SHA1 above and put these both on my pci/misc
> branch.

Thanks. That's aiming for 4.16 I assume?

cheers

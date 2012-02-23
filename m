Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1329946899.20389.9.camel@pasglop>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
 <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com> <1329946899.20389.9.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Feb 2012 10:49:07 -0800
Message-ID: <CAErSpo6=ADAx0LPWQz-YGBm2opoKAMaPGDY6yqvkNY8riF9ZFQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] powerpc/PCI: replace pci_probe_only with pci_flags
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 22, 2012 at 1:41 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-02-22 at 11:19 -0700, Bjorn Helgaas wrote:
>>  int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
>> diff --git a/arch/powerpc/platforms/pasemi/pci.c
>> b/arch/powerpc/platforms/pasemi/pci.c
>> index b6a0ec4..b27d886 100644
>> --- a/arch/powerpc/platforms/pasemi/pci.c
>> +++ b/arch/powerpc/platforms/pasemi/pci.c
>> @@ -231,7 +231,7 @@ void __init pas_pci_init(void)
>>         pci_devs_phb_init();
>>
>>         /* Use the common resource allocation mechanism */
>> -       pci_probe_only = 1;
>> +       pci_add_flags(PCI_PROBE_ONLY);
>>  }
>
> Olof, do you remember why you used to set that on pasemi ?
>
> I would have expected it to be clear, so the kernel can re-assign things
> if needed. We really only want it set for pseries because of the
> hypervisor being a PITA :-)

Speaking of the hypervisor, powerpc has this of_scan_bus() thing which
seems to discover PCI devices using the OF device tree rather than
using PCI config accesses.  This seems related to the "pci_probe_only"
idea.

I wonder whether it would be possible/feasible/desirable to implement
this by using config space accessors that would internally look at the
OF device tree.  Then we possibly could use the standard PCI scan bus
path.  Maybe the core could detect non-changeable BARs somehow and
mark them, e.g., with IORESOURCE_PCI_FIXED.

Just a pie-in-the sky thought for now; I have no concrete plans to do
anything like this, but it seems like it might allow more unification
if it were possible.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40646 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754363AbbBBQYO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 11:24:14 -0500
Message-ID: <54CFA49C.50404@arm.com>
Date: Mon, 02 Feb 2015 16:23:56 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Andre Przywara <Andre.Przywara@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com> <CAErSpo5=NhPZ5RNbBeGqKuLbKdOyTD1m+ijWM2SzQFWuKLTJfg@mail.gmail.com>
In-Reply-To: <CAErSpo5=NhPZ5RNbBeGqKuLbKdOyTD1m+ijWM2SzQFWuKLTJfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/02/15 15:57, Bjorn Helgaas wrote:
> On Wed, Jan 28, 2015 at 8:51 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> pcibios_update_irq writes an irq number into the config space
>> of a given PCI device, but ignores the fact that this number
>> is a virtual interrupt number, which might be a very different
>> value from what the underlying hardware is using.
>>
>> The obvious fix is to fetch the HW interrupt number from the
>> corresponding irq_data structure. This is slightly complicated
>> by the fact that this interrupt might be services by a stacked
>> domain.
>>
>> This has been tested on KVM with kvmtool.
>>
>> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Jiang, are you OK with this patch as-is now, since it isn't used on x86?
> 
> Marc, Lorenzo, I assume this actually fixes a bug.  Can we get any
> more details about what happens when you hit the bug, and how you
> reproduced it (what platform, driver, etc.)?

It definitely fixes a bug. This has been found by running a KVM guest
using kvmtool PCI emulation, where the following things happen:

- Guest programs a virtual (bogus) interrupt number in the PCI device
config space (virtio disk in this case)
- kvmtool uses that interrupt number as is, without any other form of
validation
- Either the injection fails (because the interrupt is out of the range
of the virtual interrupt controller) -> virtio PCI device goes dead
- or the injection succeeds because this is a valid interrupt number,
but signals an unrelated peripheral -> virtio PCI device goes dead.

This can be trivially reproduced on any ARM PCI system that requires
legacy interrupts (i.e. no MSI support), and that uses a GIC interrupt
controller. Doing it in a VM is just much more convenient.

Hope this helps,

	M.
-- 
Jazz is not dead. It just smells funny...

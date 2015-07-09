Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46579 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbbGIOfI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jul 2015 10:35:08 -0400
Message-ID: <559E8699.4010007@arm.com>
Date: Thu, 09 Jul 2015 15:35:05 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>
Subject: Re: [PATCH v3 00/15] Introducing per-device MSI domain
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com> <20150709135809.GA5223@red-moon>
In-Reply-To: <20150709135809.GA5223@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 09/07/15 14:58, Lorenzo Pieralisi wrote:
> On Tue, Jul 07, 2015 at 06:17:50PM +0100, Marc Zyngier wrote:
>> [Picking up this series again after sleeping on it for too long,
>>  hopefully still relevant]
>>
>> MSI-like interrupts are starting to creep out of the PCI world, and
>> can now be seen into a number of "platform"-type busses. The
>> introduction of the MSI domains feature in v3.19 recognised that fact,
>> and started providing a way to implement this.
>>
>> Another problem we have to solve is to identify which MSI domain a
>> device is "connected" to. Currently, PCI gets away with a mixture of
>> arch-specific callbacks, and a msi_controller structure that can
>> optionally carry a pointer to an MSI domain. As we add new bus types
>> and start dealing with topologies that do not map to what PCI does,
>> this doesn't scale anymore.
>>
>> This patch series tries to address some of it by providing a basic
>> link between 'struct device' and an MSI domain. It also adds :
>>
>> - a way to "tag" domains according to the "type" of interrupt it
>>   provides (PCI/MSI, platform MSI...), allowing a driver for a piece
>>   of HW identified by its device_node to provide several IRQ domains
>>
>> - (yet another) way for PCI to propagate the domain pointer through
>>   the PCI device hierarchy, providing a method for OF to kick-start
>>   the propagation process, and finally allowing the PCI/MSI layer to
>>   use that information
>>
>> - a similar way to hook an MSI domain to a platform device.
>>
>> Hopefully this can serve as a model to implement support for different
>> but types.
>>
>> Additionally, the last few patches use all the above to remove any
>> trace of the msi_controller structure from the three MSI controllers
>> we use on arm64, so that they solely rely on the above infrastructure,
>> leading to some interesting improvements. We take this opportunity to
>> also kill the domain pointer from the msi_controller structure.
>>
>> My hope is to eventually kill msi_controller entirely, and only rely
>> on the msi_domain contained in the device structure (any help
>> welcomed).
> 
> And kill pcibios_msi_controller from arch/arm, which means we have
> to convert all arm platforms relying on pci_sys_data for the MSI look-up,
> I only have an iMX6 Sabrelite, so yes, help is welcome here.

Ah, yet another way to squirrel information away. Lovely. Yes, that
needs consolidating too, which means converting all ARM MSI controllers
to PCI/MSI IRQ domains. I did it for Tegra a long while ago, but don't
have the HW - anyone with a Tegra4 that could test this?

> BTW, is there a reason why _all_ arm host bridges rely on
> pcibios_msi_controller (so pci_sys_data) instead of initializing
> the struct pci_bus.msi pointer to carry out the MSI controller look-up ?

Probably an ordering issue - the bus may not be there yet. But ensuring
that the MSI domain is created early (before the bus is scanned) should
solve that problem nicely enough.

> I do not see any (and I want to get rid of pcibios_msi_controller on
> arm asap, if we can use the struct pci_bus.msi pointer patch that's
> trivial).
> 
> I know that the way forward is by doing it through domains and this
> patchset, just asking (to understand why pcibios_msi_controller is
> even needed on arm at present).
> 
>> This has been tested on arm64 with GICv2m (AMD Seattle) and GICv3 ITS
>> (FVP model).
> 
> I tested it on arm64 AMD Seattle too, so FWIW:
> 
> Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Excellent, thanks a lot!

	M.
-- 
Jazz is not dead. It just smells funny...

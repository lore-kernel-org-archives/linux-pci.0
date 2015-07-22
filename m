Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36520 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934333AbbGVOyS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Jul 2015 10:54:18 -0400
Message-ID: <55AFAE96.4070401@arm.com>
Date: Wed, 22 Jul 2015 15:54:14 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v4 04/19] PCI/MSI: Add hooks to populate the msi_domain
 field
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com> <1436962613-17359-5-git-send-email-marc.zyngier@arm.com> <20150721212644.GB3691@google.com> <55AFABF3.5050303@arm.com> <CAErSpo5GRHp0-51tj8XiXKLujkLmtdmhg+gJOy0szJpP3002cQ@mail.gmail.com>
In-Reply-To: <CAErSpo5GRHp0-51tj8XiXKLujkLmtdmhg+gJOy0szJpP3002cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 22/07/15 15:48, Bjorn Helgaas wrote:
> On Wed, Jul 22, 2015 at 9:42 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Hi Bjorn,
>>
>> On 21/07/15 22:26, Bjorn Helgaas wrote:
>>> On Wed, Jul 15, 2015 at 01:16:38PM +0100, Marc Zyngier wrote:
>>>> In order to be able to populate the device msi_domain field,
>>>> add the necesary hooks to propagate the host bridge msi_domain
>>>> across secondary busses to devices.
>>>>
>>>> So far, nobody populates the initial msi_domain.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  drivers/pci/probe.c | 30 ++++++++++++++++++++++++++++++
>>>>  include/linux/pci.h |  1 +
>>>>  2 files changed, 31 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index cefd636..376f6fa 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -661,6 +661,20 @@ static void pci_set_bus_speed(struct pci_bus *bus)
>>>>      }
>>>>  }
>>>>
>>>> +void __weak pcibios_set_host_bridge_msi_domain(struct pci_bus *bus)
>>>> +{
>>>> +}
>>>
>>> I don't think there's anything in this series that requires this to be a
>>> weak function, is there?  This is the only definition I see.
>>
>> It looks like all the pcibios_* functions so far have a weak attribute,
>> and I've added it as a matter of consistency.
> 
> We've used pcibios_* names where we might need an arch-specific
> implementation.  I'm not sure that's the case here -- do you envision
> an implementation under arch/* someday?  If not, maybe it should just
> be a pci_* function instead of pcibios_*.

I could definitely see non-OF driven architectures wanting to override this.

Or maybe we should turn it the other way around and make it call the
various firmware interfaces (OF, ACPI...) until one of them succeeds. In
which case your suggestion of making it a pci_* function makes a lot of
sense.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

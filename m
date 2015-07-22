Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36453 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932206AbbGVOnD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Jul 2015 10:43:03 -0400
Message-ID: <55AFABF3.5050303@arm.com>
Date: Wed, 22 Jul 2015 15:42:59 +0100
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
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com> <1436962613-17359-5-git-send-email-marc.zyngier@arm.com> <20150721212644.GB3691@google.com>
In-Reply-To: <20150721212644.GB3691@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 21/07/15 22:26, Bjorn Helgaas wrote:
> On Wed, Jul 15, 2015 at 01:16:38PM +0100, Marc Zyngier wrote:
>> In order to be able to populate the device msi_domain field,
>> add the necesary hooks to propagate the host bridge msi_domain
>> across secondary busses to devices.
>>
>> So far, nobody populates the initial msi_domain.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/pci/probe.c | 30 ++++++++++++++++++++++++++++++
>>  include/linux/pci.h |  1 +
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index cefd636..376f6fa 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -661,6 +661,20 @@ static void pci_set_bus_speed(struct pci_bus *bus)
>>  	}
>>  }
>>  
>> +void __weak pcibios_set_host_bridge_msi_domain(struct pci_bus *bus)
>> +{
>> +}
> 
> I don't think there's anything in this series that requires this to be a
> weak function, is there?  This is the only definition I see.

It looks like all the pcibios_* functions so far have a weak attribute,
and I've added it as a matter of consistency.

I don't mind dropping it though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5679968B.4090908@caviumnetworks.com>
Date: Tue, 22 Dec 2015 10:29:31 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Will Deacon <will.deacon@arm.com>
CC: David Daney <ddaney.cavm@gmail.com>,
	<linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/2] PCI: generic: Refactor code to enable reuse by other
 drivers.
References: <1450749222-15966-1-git-send-email-ddaney.cavm@gmail.com> <1450749222-15966-2-git-send-email-ddaney.cavm@gmail.com> <20151222100732.GD32623@arm.com>
In-Reply-To: <20151222100732.GD32623@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/22/2015 02:07 AM, Will Deacon wrote:
> On Mon, Dec 21, 2015 at 05:53:41PM -0800, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> No change in functionality.
>>
>> Move structure definitions into a separate header file.  Split probe
>> function in to two parts:
>>
>>     - a small driver specific probe function (gen_pci_probe)
>>
>>     - a common probe that can be used by other drivers
>>       (gen_pci_common_probe)
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   drivers/pci/host/pci-host-generic.c | 53 ++++++++++++-----------------------
>>   drivers/pci/host/pci-host-generic.h | 56 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 74 insertions(+), 35 deletions(-)
>>   create mode 100644 drivers/pci/host/pci-host-generic.h
>>
>> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
>> index 5434c90..e83cec7 100644
>> --- a/drivers/pci/host/pci-host-generic.c
>> +++ b/drivers/pci/host/pci-host-generic.c
[...]
>> -static int gen_pci_probe(struct platform_device *pdev)
>> +int gen_pci_common_probe(struct platform_device *pdev,
>> +			 struct gen_pci *pci)
>
> Whilst I'm fine with this patch, I don't know how Bjorn will feel about
> exposing this function outside of the generic host driver. We could avoid
> it by turning things upside-down and having the generic driver probe
> the other drivers by matching a compatible string with a probe function
> pointer, but I'd be interested to see what others think.
>

Note: I know that pci-host-generic is not built as a loadable module, but...

struct of_device_id, MODULE_DEVICE_TABLE, struct platform_driver and the 
registering of platform drivers is fairly well standardized in the 
kernel, and module loading userpace tools.

The struct of_device_id, MODULE_DEVICE_TABLE must really reside in the 
same module as the driver for the device.   We are creating a separate 
driver precisely because we don't want to mix all this ThunderX specific 
code into the pci-host-generic driver when it is used by arm-32bit and 
others.  This means that, at a minimum, we would have to export the 
pci-host-generic probe function so that it could be referenced by struct 
platform_driver in other modules.

This brings up the next problem.  How to attach driver specific data to 
the generic driver structures?  At first I tried augmenting  struct 
gen_pci_cfg_bus_ops with a callback .init() function to be called by the 
generic driver, but this would also require adding an an element to 
struct gen_pci to point to a driver specific data object.  It felt a 
little convoluted and complex.

This led me to the current design where struct gen_pci is embedded in 
the driver specific structure, and the allocation of this is done in the 
driver specific probe function.  No more callbacks, no additions to the 
pci-host-generic structures.  I think it is a little cleaner this way.

If there are suggestions as to how it can be made cleaner yet, I would 
be happy to implement and test them.

David Daney

> Will
>


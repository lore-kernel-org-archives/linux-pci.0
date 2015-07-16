Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59042 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755003AbbGPBWr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 21:22:47 -0400
Subject: Re: [PATCH] PCI / ACPI: Fix pci_acpi_optimize_delay() comment
To: Bjorn Helgaas <bhelgaas@google.com>,
	Srinidhi Kasagar <srinidhi.kasagar@intel.com>
References: <20150715092915.GA8262@intel-desktop>
 <20150715201414.GA25591@google.com>
Cc: linux-pci@vger.kernel.org
From: Aaron Lu <aaron.lu@intel.com>
Message-ID: <55A707BC.5010505@intel.com>
Date: Thu, 16 Jul 2015 09:24:12 +0800
MIME-Version: 1.0
In-Reply-To: <20150715201414.GA25591@google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/16/2015 04:14 AM, Bjorn Helgaas wrote:
> [+cc Aaron]
> 
> On Wed, Jul 15, 2015 at 02:59:46PM +0530, Srinidhi Kasagar wrote:
>> The function takes ACPI handle, not the device itself. Fix the
>> comment

I must have overlooked the comment while changing the function
prototype, thanks for the fix!

Regards,
Aaron

>>
>> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> 
> Applied to pci/misc for v4.3, thanks!
> 
>> ---
>> Add this as part of your trivial commenting fixes patch series
>>
>>  drivers/pci/pci-acpi.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 6f6f175f51f7..d2e2bf4ef0a4 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -594,7 +594,7 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
>>  /**
>>   * pci_acpi_optimize_delay - optimize PCI D3 and D3cold delay from ACPI
>>   * @pdev: the PCI device whose delay is to be updated
>> - * @adev: the companion ACPI device of this PCI device
>> + * @handle: ACPI handle of this device
>>   *
>>   * Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM
>>   * control method of either the device itself or the PCI host bridge.
>> -- 
>> 1.7.9.5
>>
>>
>> -- 


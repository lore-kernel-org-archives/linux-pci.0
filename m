Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D2EC282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7313F20838
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393057AbfBMRbI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:31:08 -0500
Received: from xes-mad.com ([162.248.234.2]:32407 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732968AbfBMRbI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 12:31:08 -0500
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 74A3520200;
        Wed, 13 Feb 2019 11:31:07 -0600 (CST)
Date:   Wed, 13 Feb 2019 11:31:07 -0600 (CST)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Message-ID: <1855383852.134524.1550079067380.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190130225752.GL229773@google.com>
References: <1539642186-12821-1-git-send-email-asierra@xes-inc.com> <1540483292-24049-1-git-send-email-asierra@xes-inc.com> <1540483292-24049-3-git-send-email-asierra@xes-inc.com> <20190130225752.GL229773@google.com>
Subject: Re: [PATCH v2 2/2] PCI/ACPI: Improve _OSC control request
 granularity
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - FF65 (Linux)/8.7.5_GA_1764)
Thread-Topic: PCI/ACPI: Improve _OSC control request granularity
Thread-Index: xGet9+y3wQ9XPB7zzF8oPZo4P9Hbbw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> To: "Aaron Sierra" <asierra@xes-inc.com>
> Sent: Wednesday, January 30, 2019 4:57:53 PM
> Subject: Re: [PATCH v2 2/2] PCI/ACPI: Improve _OSC control request granularity

> On Thu, Oct 25, 2018 at 11:01:32AM -0500, Aaron Sierra wrote:
>> This patch reorganizes negotiate_os_control() to be less ASPM-centric in
>> order to:
>> 
>>     1. allow other features (notably AER) to work without enabling ASPM
>>     2. better isolate feature-specific tests for readability/maintenance
> 
> I really like this idea; thanks for working it up!

Hi Bjorn,

Thanks for reviewing this. I've added follow-ups to each of your comments
below.

>> Each feature (ASPM, PCIe hotplug, SHPC hotplug, and AER) now has its own
>> inline function for setting its _OSC control requests.
>> 
>> Part of making this function more generic, required eliminating a test
>> for overall success/failure that previously caused two different types
>> of messages to be printed. Now, printed messages are streamlined to
>> always show requested _OSC control versus what was granted.
>> 
>> Previous output (success):
>> 
>>   acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability LTR]
>> 
>> Previous output (failure):
>> 
>>   acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
>>   acpi PNP0A08:00: _OSC: platform willing to grant []
>> 
>> Now:
>> 
>>   acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
>>   acpi PNP0A08:00: _OSC: platform granted [PME AER PCIeCapability LTR]
>> 
>> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
>> ---
>>  drivers/acpi/pci_root.c | 118 ++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 85 insertions(+), 33 deletions(-)
>> 
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index eb9f14e..9685aba 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -53,9 +53,10 @@ static int acpi_pci_root_scan_dependent(struct acpi_device
>> *adev)
>>  }
>>  
>>  #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
>> -				| OSC_PCI_ASPM_SUPPORT \
>> -				| OSC_PCI_CLOCK_PM_SUPPORT \
>>  				| OSC_PCI_MSI_SUPPORT)
>> +#define ACPI_PCIE_ASPM_SUPPORT (ACPI_PCIE_REQ_SUPPORT \
>> +				| OSC_PCI_ASPM_SUPPORT \
>> +				| OSC_PCI_CLOCK_PM_SUPPORT)
>>  
>>  static const struct acpi_device_id root_device_ids[] = {
>>  	{"PNP0A03", 0},
>> @@ -421,6 +422,72 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle,
>> u32 *mask, u32 req)
>>  }
>>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>>  
>> +static inline bool __osc_have_support(u32 support, u32 required)
>> +{
>> +	return ((support & required) == required);
>> +}
> 
> I'm not really a fan of function names with leading underscores, except
> maybe for "raw" things that don't acquire locks.

No problem, I will strip the underscores in v3.

>> +static inline int __osc_set_aspm_control(struct acpi_pci_root *root,
>> +					 u32 support, u32 *control)
>> +{
>> +	if (!IS_ENABLED(CONFIG_PCIEASPM) ||
>> +	    !__osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
>> +		return -ENODEV;
>> +
>> +	*control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
>> +		    OSC_PCI_EXPRESS_LTR_CONTROL |
>> +		    OSC_PCI_EXPRESS_PME_CONTROL;
> 
> I think this would be more readable if we could avoid the double
> negatives, e.g.,
> 
>  if (IS_ENABLED(CONFIG_PCIEASPM) &&
>      __osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT)) {
>          *control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
>                      OSC_PCI_EXPRESS_LTR_CONTROL |
>                      OSC_PCI_EXPRESS_PME_CONTROL;
>          return 0;
>  }
> 
>  return -ENODEV;

I tend to try to avoid avoidable indentation and to get out as early as
possible. In the case of these tiny functions, the style you suggested doesn't
cause any additional line wrapping or complexity. I will make this change,
except for __osc_set_aer_control(), where my original structure seems to be a
better fit.

> Since the caller ignores the return values anyway, I wonder if this
> could also work by *returning* the new mask bits instead of using
> "control" as a reference parameter, e.g.,
> 
>  if (IS_ENABLED(...))
>    return OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
>           OSC_PCI_EXPRESS_LTR_CONTROL |
>           OSC_PCI_EXPRESS_PME_CONTROL;
> 
>  return 0;
> 
> Then the calls would look like:
> 
>  control |= __osc_set_pciehp_control(root, support);
>  control |= __osc_set_shpchp_control(root, support);
>  ...

Yes, I do like that better. I had a draft with that structure, but I changed
for some reason. FYI, I'm inclined to rename these bit-setting functions to
"osc_get_X_control_bits()" to try to avoid confusion. Hopefully that sits well
with you.

-Aaron

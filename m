Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:20479
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932908AbaGQPWt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Jul 2014 11:22:49 -0400
Message-ID: <53C7EA41.8030907@amd.com>
Date: Thu, 17 Jul 2014 10:22:41 -0500
From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
	Clemens Ladisch <clemens@ladisch.de>
CC: Borislav Petkov <bp@alien8.de>, <jdelvare@suse.de>,
	<rdunlap@infradead.org>, <bhelgaas@google.com>,
	<lm-sensors@lm-sensors.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] hwmon, k10temp: Add support for AMD F15h M60h processor
References: <1405369388-12729-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
 <20140714195128.GA25124@pd.tnic> <53C43BDF.2070403@ladisch.de>
 <20140714203336.GA30926@roeck-us.net> <53C4DB2D.80406@ladisch.de>
 <53C4EE5C.5020407@roeck-us.net>
In-Reply-To: <53C4EE5C.5020407@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/15/2014 4:03 AM, Guenter Roeck wrote:
> On 07/15/2014 12:41 AM, Clemens Ladisch wrote:
>> Guenter Roeck wrote:
>>> On Mon, Jul 14, 2014 at 10:21:51PM +0200, Clemens Ladisch wrote:
>>>> Borislav Petkov wrote:
>>>>> On Mon, Jul 14, 2014 at 03:23:08PM -0500, Aravind Gopalakrishnan 
>>>>> wrote:
>>>>>> +    if (boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model == 
>>>>>> 0x60) {
>>>>>> +        pci_bus_write_config_dword(pdev->bus, PCI_DEVFN(0, 0),
>>>>>> +                       NB_SMU_IND_ADDR, IND_ADDR_OFFSET);
>>>>>> +        pci_bus_read_config_dword(pdev->bus, PCI_DEVFN(0, 0),
>>>>>> +                      NB_SMU_IND_DATA, &regval);
>>>>
>>>> How do you prevent races with any other code that accesses some 
>>>> indirect
>>>> register?
>>>>
>>> I just wanted to ask exactly the same question. I think this will need
>>> locking.
>>
>> If there actually is any other code; these indirect SMU registers appear
>> to be mostly undocumented and to be intended to be used by the BIOS.
>> (Which makes me wonder why the temperature sensor was moved there.)
>>
> Scary. Does that mean there is a chance they may get used through ACPI ?

I have been asking internally about this, and looks like it's just a 
register address change.
So we probably don't have to worry about this being used elsewhere..

>
>> Anyway, if a lock is needed, it looks as if it could go into a helper
>> function such as "amd_nb_smu_ind_read()" in arch/x86/kernel/amd_nb.c.
>>
> Yes, something like that.
>
>
Okay, I shall add the locking mechanism and re-send.

Thanks,
-Aravind.


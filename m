Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <54BF0BA5.8020806@linux.intel.com>
Date: Wed, 21 Jan 2015 10:15:01 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC Patch 09/19] ACPI: Fix a bug in parsing ACPI Memroy24 resource
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com> <1420684386-5975-10-git-send-email-jiang.liu@linux.intel.com> <1633329.njF7Ian1Kn@vostro.rjw.lan>
In-Reply-To: <1633329.njF7Ian1Kn@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/1/21 8:42, Rafael J. Wysocki wrote:
> On Thursday, January 08, 2015 10:32:56 AM Jiang Liu wrote:
>> According to ACPI spec 5, section 6.4.3.1 "24-Bit Memory Range Descriptor",
>> minimum, maximum and address_length field in struct acpi_resource_memory24
>> is in granularity of 256-bytes. So shift 8-bit left to get correct address.
> 
> Are you sure about this?
> 
> I'm reading ACPI 5.1 ATM and (on page 316) it only says about the range length
> being in 256 byte blocks.
Hi Rafael,
	According to ACPI spec 5.a sec 6.4.3.1,
Byte 4, "Range minimum base address, _MIN, bits[7:0]", "Address
bits[15:8] of the minimum base memory address for which
the card may be configured."
Byte 5, "Range minimum base address, _MIN, bits[15:8]", "Address
bits[23:16] of the minimum base memory address for
which the card may be configured".
Byte 10, "Range length, _LEN, bits[7:0]", "This field contains the lower
eight bits of the memory range length. The range length provides the
length of the memory range in 256 byte blocks."
Byte 11, "Range length, _LEN, bits[15:8]", "This field contains the
upper eight bits of the memory range length. The range length field
provides the length of the memory range in 256 byte blocks."

That means _MIN defines bits[23:8] of the minimal address, and _LEN
is in granularity of 256 bytes, so shift them left by 8 bits.
Regards,
Gerry

> 
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>  drivers/acpi/resource.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index abe3a29ad802..f4aeef22a9d8 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -90,8 +90,8 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res)
>>  	switch (ares->type) {
>>  	case ACPI_RESOURCE_TYPE_MEMORY24:
>>  		memory24 = &ares->data.memory24;
>> -		acpi_dev_get_memresource(res, memory24->minimum,
>> -					 memory24->address_length,
>> +		acpi_dev_get_memresource(res, memory24->minimum << 8,
>> +					 memory24->address_length << 8,
>>  					 memory24->write_protect);
>>  		break;
>>  	case ACPI_RESOURCE_TYPE_MEMORY32:
>>
> 

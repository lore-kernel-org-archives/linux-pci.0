Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35630 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbeAZOvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jan 2018 09:51:00 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so21758346wme.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2018 06:50:59 -0800 (PST)
Subject: Re: [PATCH v2 1/5] ACPI: export acpi_bus_get_status_handle()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, devel@acpica.org
References: <20180122085135.16732-1-hdegoede@redhat.com>
 <20180122085135.16732-2-hdegoede@redhat.com>
 <CAJZ5v0g7KppXpk_jRWjKz8-ncdJQHg-QU7oGrgPiBtczgf+gfQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <cf75e876-80b2-8f5d-bb17-11f6f3a1635a@redhat.com>
Date: Fri, 26 Jan 2018 15:50:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g7KppXpk_jRWjKz8-ncdJQHg-QU7oGrgPiBtczgf+gfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 01/23/2018 12:55 AM, Rafael J. Wysocki wrote:
> On Mon, Jan 22, 2018 at 9:51 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Some modular drivers need this, export it.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -This is a new patch in v2 of this patch-set
>> ---
>>   drivers/acpi/bus.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 4d0979e02a28..db0c05997cc2 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -108,6 +108,7 @@ acpi_status acpi_bus_get_status_handle(acpi_handle handle,
>>          }
>>          return status;
>>   }
>> +EXPORT_SYMBOL(acpi_bus_get_status_handle);
> 
> EXPORT_SYMBOL_GPL(), please.

Ok, v3 with this fixed coming up.

Regards,

Hans

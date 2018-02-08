Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] ACPI: Do not call _STA on battery devices with
 unmet dependencies
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        linux-pci@vger.kernel.org, devel@acpica.org
References: <20180122085135.16732-1-hdegoede@redhat.com>
 <3281375.11fh90aaLK@aspire.rjw.lan>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <7efce3e1-4cb7-fa68-9024-73fa124b9171@redhat.com>
Date: Thu, 8 Feb 2018 13:19:07 +0100
MIME-Version: 1.0
In-Reply-To: <3281375.11fh90aaLK@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 08-02-18 10:57, Rafael J. Wysocki wrote:
> On Monday, January 22, 2018 9:51:30 AM CET Hans de Goede wrote:
>> Hi All,
>>
>> Here is v2 of this set, new in v2 is the addressing of Bjorn's comments
>> to the "PCI: acpiphp_ibm: prepare for acpi_get_object_info no longer
>> returning status" patch and a new patch (the first patch in v2) which
>> exports acpi_bus_get_status_handle() for use in modules as acpiphp_ibm
>> will now depend on it.
>>
>> Here is the old coverletter from v1 (adjusted for the new patch):
>>
>> The ACPI code already contains quite a bit of code to not bind the
>> ACPI-battery until all deps for an ACPI battery device have been met,
>> but on some devices calling _STA before all deps are met is a problem
>> too because the _STA method uses an i2c OpRegion there.
>>
>> Here is the DSDT of the device I'm seeing this on:
>> https://fedorapeople.org/~jwrdegoede/toshiba-click-mini-dsdt.dsl
>>
>> This series modifies the kernel to not call _STA until all deps are met,
>> mirroring the binding behavior of the battery driver.
>>
>> Without this series a total of 32 ACPI errors get printend to the console
>> on boot, there are 4 errors per _STA call, 2 battery devices on this
>> system and 4 _STA calls per battery device.
>>
>> The first 2 commits are preparation commits for making the ACPICA changes
>> in the 4th commit, these commits are necessary to not break things after
>> the ACPICA changes.
>>
>> The 3th commit modifies acpi_bus_get_status to not call _STA on
>> battery devices until all deps are met. This fixes 2 of the 4 too early
>> _STA calls triggering these errors.
>>
>> The 4th commit makes the device instantiation code use
>> acpi_bus_get_status instead of acpi_bus_get_status_handle so that the
>> code to get the initial status also does not makes 1 too early _STA call.
>>
>> The 5th commit changes the ACPICA acpi_get_object_info function to not
>> call _STA. Only 1 user (which is fixed in the first commit) cares about
>> acpi_device_info.current_status. And the ACPICA code has this comment:
>>
>>   * Note: This interface is intended to be used during the initial device
>>   * discovery namespace traversal. Therefore, no complex methods can be
>>   * executed, especially those that access operation regions. Therefore, do
>>   * not add any additional methods that could cause problems in this area.
>>   * Because of this reason support for the following methods has been removed:
>>   * this was the fate of the _SUB method which was found to cause such
>>   * problems and was removed (11/2015).
>>
>> The described problems with the _SUB method clearly also apply to the _STA
>> method, so removing it from acpi_get_object_info seems like it is the right
>> thing to do here. This too fixes 1 too early _STA call, so that with all
>> 5 patches in place we've fixed all 4 too early _STA calls.
> 
> I've applied [1-4/5] from this series.

Thank you.

> The last one needs to go in via ACPICA anyway or we'll need to carry
> a Linux-specific replacement for acpi_get_object_info().

Ack, I'm discussing how to proceed with this with the ACPICA people.

Regards,

Hans

Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1519813744.10722.258.camel@linux.intel.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
 <20180222125923.57385-2-andriy.shevchenko@linux.intel.com>
 <20180226172832.7bf82336@endymion> <1519813744.10722.258.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Feb 2018 11:33:39 +0100
Message-ID: <CAJZ5v0hOvU25zWfVjBw-2iz5Y7V2FkSwoTZVZTpjEG9KOCQ6oQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] x86/pci: Re-use new dmi_get_bios_year() helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 11:29 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2018-02-26 at 17:28 +0100, Jean Delvare wrote:
>
>> > -   if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year
>> > < 2008) {
>> > -           if (iomem_resource.end <= 0xffffffff)
>> > -                   pci_use_crs = false;
>> > -   }
>> > +   if ((dmi_get_bios_year() < 2008) && (iomem_resource.end <=
>> > 0xffffffff))
>> > +           pci_use_crs = false;
>>
>> You are changing the behavior here, when DMI does not provide a BIOS
>> date. Beforehand, the test would fail and pci_use_crs would be left
>> alone. After your change, dmi_get_bios_year() will return 0, and
>> "0 < 2008" is true, so pci_use_crs is set to false.
>
> Hmm... Indeed.
>
>> I have no opinion on what this driver should do in such case,
>
> I would assume that no BIOS date is related to prehistoric firmwares and
>  using _CRS would sound weird on them.

Careful here.

You seem to be assuming that the DMI information is always valid
and/or complete which is know to not be the case sometimes.

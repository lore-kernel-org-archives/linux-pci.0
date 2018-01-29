Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <08f2a8aa-1510-3b78-4fa7-bf0ae194ccb0@redhat.com>
References: <20180126150300.9691-1-hdegoede@redhat.com> <20180126150300.9691-5-hdegoede@redhat.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B75696BC@ORSMSX110.amr.corp.intel.com> <08f2a8aa-1510-3b78-4fa7-bf0ae194ccb0@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2018 04:07:30 +0100
Message-ID: <CAJZ5v0gDLrDtgFKo5mUBuGWfAmv_3n1HEUTjnE3J8DSrRUbTCQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] ACPICA: Remove calling of _STA from acpi_get_object_info
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 27, 2018 at 3:02 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 26-01-18 21:42, Moore, Robert wrote:
>>
>> For ACPICA, this is a change to a published public interface. A change to
>> this will potentially affect many operating systems, so we would be very
>> hesitant to change it in the core ACPICA code.
>
>
> From the acpi_get_object_info() documentation in
> drivers/acpi/acpica/nsxfname.c:
>
>  * Note: This interface is intended to be used during the initial device
>  * discovery namespace traversal. Therefore, no complex methods can be
>  * executed, especially those that access operation regions.
>
> Since _STA can call Opregions, IMHO it does not belong in
> acpi_get_object_info()
> and as Erik mentioned _STA can have side-effects then that seems like
> another
> reason to NOT call it from acpi_get_object_info().
>
> But I can understand that you don't want to outright change the behavior of
> acpi_get_object_info() to call _STA since it has always done this, still
> calling _STA can be a problem in some cases.
>
> Perhaps we can give acpi_get_object_info() a flags argument, or if you want
> to
> preserve the current interface ad a new acpi_get_object_info_no_sta() call
> (and
> use flags under the hood so that we still have only 1 implementation) ?

Let's first get the [1-4/5] from this series in (as the last patch
depends on them AFAICS) and then we'll see.

Thanks,
Rafael

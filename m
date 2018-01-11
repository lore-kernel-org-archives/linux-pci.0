Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB191612888094C4794951FAE4F8160@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180111150316.19951-1-Yazen.Ghannam@amd.com> <CAJZ5v0gU6var3gNQsp2GkSujbR=vB2Zj4dZHKNOzfAtC76jFbA@mail.gmail.com>
 <DM5PR12MB191612888094C4794951FAE4F8160@DM5PR12MB1916.namprd12.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Jan 2018 19:03:23 +0100
Message-ID: <CAJZ5v0ie_FntO=TO1X_tX9xzz-t6Q_yeWvTfhqufTbYBdwMGJg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Disable AER when _OSC control bit is clear.
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 11, 2018 at 6:48 PM, Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>> -----Original Message-----
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
>> Rafael J. Wysocki
>> Sent: Thursday, January 11, 2018 12:39 PM
>> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
>> Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Linux Kernel Mailing
>> List <linux-kernel@vger.kernel.org>; Linux PCI <linux-pci@vger.kernel.org>;
>> Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Bjorn
>> Helgaas <bhelgaas@google.com>; Borislav Petkov <bp@suse.de>
>> Subject: Re: [PATCH] PCI/ACPI: Disable AER when _OSC control bit is clear.
>>
>> On Thu, Jan 11, 2018 at 4:03 PM, Yazen Ghannam
>> <Yazen.Ghannam@amd.com> wrote:
>> > From: Yazen Ghannam <yazen.ghannam@amd.com>
>> >
>> > Currently, aer_service_init() checks if AER is available and that
>> > Firmware First handling is not enabled. The _OSC request for AER is
>> > not taken into account when deciding to enable AER in Linux.
>> >
>> > We should check that the _OSC control for AER is set. If it's not
>> > then AER should be disabled.
>> >
>> > The _OSC control for AER is not requested when APEI Firmware First is
>> > used, so the same condition applies.
>> >
>> > Mark AER as disabled if the _OSC request was not made or accepted.
>> >
>> > Remove redunant check for aer_acpi_firmware_first() when calling
>> > aer_service_init(), since this is check is already included when
>> > checking the _OSC control.
>> >
>> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> > ---
>> >  drivers/acpi/pci_root.c       | 3 +++
>> >  drivers/pci/pcie/aer/aerdrv.c | 2 +-
>> >  2 files changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> > index 6fc204a52493..19a625ed8de9 100644
>> > --- a/drivers/acpi/pci_root.c
>> > +++ b/drivers/acpi/pci_root.c
>> > @@ -512,6 +512,9 @@ static void negotiate_os_control(struct
>> acpi_pci_root *root, int *no_aspm)
>> >                  */
>> >                 *no_aspm = 1;
>> >         }
>> > +
>> > +       if (!(requested & control & OSC_PCI_EXPRESS_AER_CONTROL))
>>
>> One of the operators above needs to be a && I suppose?
>>
>
> It's a 3-way bitwise AND to check that OSC_PCI_EXPRESS_AER_CONTROL is
> set in both "requested" and "control".
>
> IOW, we check if AER was requested by the OS and that the platform
> granted the request.

OK

I'll queue this up if Bjorn doesn't object, unless Bjorn wants to
apply it himself.

Thanks,
Rafael

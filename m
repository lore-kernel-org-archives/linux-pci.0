Return-Path: <SRS0=uw+h=FE=canonical.com=alex.hung@kernel.org>
Return-Path: <SRS0=uw+h=FE=canonical.com=alex.hung@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180210010548.GC206223@bhelgaas-glaptop.roam.corp.google.com>
References: <1518217003-19637-1-git-send-email-alex.hung@canonical.com> <20180210010548.GC206223@bhelgaas-glaptop.roam.corp.google.com>
From: Alex Hung <alex.hung@canonical.com>
Date: Fri, 9 Feb 2018 23:40:24 -0800
Message-ID: <CAJ=jquYWcs=Brehj-S66RQ4z4LTA8JQDT2zmGc-Pdo5TQ0PwBQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PCI: pci_link: change log level of no _PRS messages
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 9, 2018 at 5:05 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Feb 09, 2018 at 02:56:43PM -0800, Alex Hung wrote:
>> In recent Intel hardware the IRQs become non-configurable after BIOS
>> initializes them in PEI phase and _PRS objects are no longer included in
>> ASL.
>>
>> This is the same as "static (non-configurable) devices do not
>> specify a _PRS object" in ACPI spec. As a result, error messages
>> saying "ACPI Exception: AE_NOT_FOUND, Evaluating _PRS" does not need to
>> be in kernel messages all the time but only when debug is enabled.
>
> I agree and would even go further: _PRS is optional and I don't think
> there's a reason to log anything at all if it's absent.  A log message
> like "failed to evaluate _PRS" makes people think something is wrong
> when in fact nothing is wrong.

Bjorn,

Thanks for the feedback. Rafael and I had discussion on the previous
patch that removed the error message
(https://patchwork.codeaurora.org/patch/440263/), and had a conclusion
that using a level log of "debug" is more appropriate and less noisy
for most of default setting. After all, there can be other failure
types than _PRS is absent.

>
> That leads to the mindset of treating a missing _PRS as an error when
> it's not.  In fact, it looks like acpi_pci_link_add() *does* treat
> this as an error.  If _PRS doesn't exist, it skips the _CRS
> evaluation.  That seems wrong.

Do you mean we can do something like

        status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
                                     acpi_pci_link_check_possible, link);
        if (status == AE_NOT_FOUND) { // acceptable scenario but let's
still output a message
                acpi_handle_debug(link->device->handle, "_PRS is absent");
        } else if (ACPI_FAILURE(status)) { // something indeed wrong with _PRS
                acpi_handle_debug(link->device->handle, "failed to
evaluate _PRS");
                return -ENODEV;
        }
or
        status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
                                     acpi_pci_link_check_possible, link);
        if (ACPI_FAILURE(status)) { // output messages but do not return -ENODEV
                acpi_handle_debug(link->device->handle, "something
wrong with _PRS, so let's not use it");  // or a more meaningful
message
        }

and plus other probable changes and many tests as this affects other
parts of pci_link.c

Perhaps we can do this in two patches:
1. fix the error messages first - low risk and nobody freaks out with
the new hardware
2. refine _PRS & _CRT because of higher risk and extensive testing required

Rafael and Len

Any comments and suggestions on error messages or _CRS?


>
>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>> ---
>>  drivers/acpi/pci_link.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index 85ad679..9d9cf24 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -173,7 +173,7 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
>>       status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
>>                                    acpi_pci_link_check_possible, link);
>>       if (ACPI_FAILURE(status)) {
>> -             ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRS"));
>> +             acpi_handle_debug(link->device->handle, "failed to evaluate _PRS");
>>               return -ENODEV;
>>       }
>>
>> --
>> 2.7.4
>>



-- 
Cheers,
Alex Hung

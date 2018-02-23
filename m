Return-Path: <SRS0=+ZCK=FR=canonical.com=alex.hung@kernel.org>
Return-Path: <SRS0=+ZCK=FR=canonical.com=alex.hung@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hb3SBnKJm+EQaJk3dFp+_8kXHJ8SLH-QYrgR-bUiHwJg@mail.gmail.com>
References: <1518217003-19637-1-git-send-email-alex.hung@canonical.com>
 <20180210010548.GC206223@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0gBK8WmX4QYYBzVxdk8CaSBo5ckzmP49qr05+9DAYieqw@mail.gmail.com>
 <20180210153450.GD206223@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0iNq2ni9ML=_6H0i99dUm5+Noh1MQ9AO4JCiqyXU1xW3Q@mail.gmail.com>
 <CAJ=jquZtaLqZZQaAitPYLK4dGVXxw3U92NJB5KuP3oU-LFDudQ@mail.gmail.com> <CAJZ5v0hb3SBnKJm+EQaJk3dFp+_8kXHJ8SLH-QYrgR-bUiHwJg@mail.gmail.com>
From: Alex Hung <alex.hung@canonical.com>
Date: Thu, 22 Feb 2018 21:42:18 -0800
Message-ID: <CAJ=jquYi=6aH0yypv1CbfD+EVFCW70QtS-hAVMa9jJ3dpXPj-g@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PCI: pci_link: change log level of no _PRS messages
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 13, 2018 at 12:49 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Feb 13, 2018 at 5:03 AM, Alex Hung <alex.hung@canonical.com> wrote:
>> On Mon, Feb 12, 2018 at 12:51 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Sat, Feb 10, 2018 at 4:34 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>> On Sat, Feb 10, 2018 at 09:08:42AM +0100, Rafael J. Wysocki wrote:
>>>>> On Sat, Feb 10, 2018 at 2:05 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> > On Fri, Feb 09, 2018 at 02:56:43PM -0800, Alex Hung wrote:
>>>>> >> In recent Intel hardware the IRQs become non-configurable after BIOS
>>>>> >> initializes them in PEI phase and _PRS objects are no longer included in
>>>>> >> ASL.
>>>>> >>
>>>>> >> This is the same as "static (non-configurable) devices do not
>>>>> >> specify a _PRS object" in ACPI spec. As a result, error messages
>>>>> >> saying "ACPI Exception: AE_NOT_FOUND, Evaluating _PRS" does not need to
>>>>> >> be in kernel messages all the time but only when debug is enabled.
>>>>> >
>>>>> > I agree and would even go further: _PRS is optional and I don't think
>>>>> > there's a reason to log anything at all if it's absent.  A log message
>>>>> > like "failed to evaluate _PRS" makes people think something is wrong
>>>>> > when in fact nothing is wrong.
>>>>>
>>>>> _PRS is required if the link object is pointed to by a _PRT entry.
>>>>
>>>> The closest thing I see with a quick look is ACPI 6.0, sec 6.2.13:
>>>>
>>>>   These objects [PCI Interrupt Link Devices] have _PRS, _CRS, _SRS,
>>>>   and _DIS control methods to allocate the interrupt.
>>>>
>>>> I don't read that as a requirement for _PRS in particular; I read it
>>>> as saying that the interrupt link devices use the normal device
>>>> configuration method, i.e., _CRS is required and _PRS and _SRS are
>>>> optional and needed for configurable devices but not for static ones.
>>>
>>> Well, that's slightly out of context. :-)
>>>
>>> First of all, Section 6.2.13 says this: "Typically, the interrupt
>>> input that a given PCI interrupt is on is configurable. [...]  In this
>>> model, each interrupt is represented in the ACPI namespace as a PCI
>>> Interrupt Link Device."  Then, it says the above.
>>>
>>> Now, if _PRS is not present, the IRQ represented by the link object
>>> cannot be configured, so in fact the underlying assumption doesn't
>>> apply to it, strictly speaking.  It follows from the last paragraph in
>>> Section 6.2.13 that _PRT entries representing such IRQs should not
>>> point to interrupt link device objects (there should be 0 in their
>>> Source fields).
>>>
>>> Hence, if a _PRT entry points to an interrupt link device object in
>>> the namespace, _PRS should be present under this object or at least it
>>> is reasonable to expect that it will be present in there.
>>>
>>>> But this is just a drive-by comment and I'm really fine with whatever
>>>> you decide to do.
>>>
>>> OK
>>>
>>> So I think that (a) the message should be printed using
>>> acpi_handle_debug(), except that I would make it slightly more
>>> neutral, something like "_PRS not present or invalid", and (b) 0
>>> should be returned instead of -ENODEV when _PRS evaluation doesn't
>>> succeed.
>>
>> Looks like we will do the following.
>>
>>         if (ACPI_FAILURE(status)) {
>> -               ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRS"));
>> -                return -ENODEV;
>> +               acpi_handle_debug(link->device->handle, "_PRS not
>> present or invalid");
>> +                return 0;
>
> Yes, but this affects the caller.
>
> Please make sure that everything will work correctly in there after this change.

I tried the above changes and everything seems to work fine. I will
send updated patch shortly.

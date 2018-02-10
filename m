Return-Path: <SRS0=l0d9=FE=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=l0d9=FE=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180210010548.GC206223@bhelgaas-glaptop.roam.corp.google.com>
References: <1518217003-19637-1-git-send-email-alex.hung@canonical.com> <20180210010548.GC206223@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 10 Feb 2018 09:08:42 +0100
Message-ID: <CAJZ5v0gBK8WmX4QYYBzVxdk8CaSBo5ckzmP49qr05+9DAYieqw@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PCI: pci_link: change log level of no _PRS messages
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Hung <alex.hung@canonical.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 10, 2018 at 2:05 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
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

_PRS is required if the link object is pointed to by a _PRT entry.

> That leads to the mindset of treating a missing _PRS as an error when
> it's not.  In fact, it looks like acpi_pci_link_add() *does* treat
> this as an error.  If _PRS doesn't exist, it skips the _CRS
> evaluation.  That seems wrong.

I agree here.  _CRS still should be evaluated if _PRS is not there in
general, but in some cases the lack of _PRS *is* an error.

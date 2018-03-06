Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1520256299.10722.395.camel@linux.intel.com>
References: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jY-psSy51ZvrgHKidGg5CK_4hK1UGbhnzXD_QQxyCvZg@mail.gmail.com> <1520256299.10722.395.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 Mar 2018 16:12:25 +0100
Message-ID: <CAJZ5v0hZwz3fv2fBiXXTqO0E2AasphBYgX6tzUE8R-YK+wgmUw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86, dmi: introduce and use dmi_get_bios_year()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 5, 2018 at 2:24 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2018-03-02 at 12:10 +0100, Rafael J. Wysocki wrote:
>> On Thu, Mar 1, 2018 at 7:02 PM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > Introduce a new helper to extract a year from DMI BIOS date since
>> > there
>> > are most existing users do and newcomers would utilize as well.
>> >
>> > Ingo, this is respin of the patches in x86/platform. I think, if
>> > it's
>> > possible to rebase, would be easier just to replace existing ones.
>> >
>> > Otherwise I would reorganize them as a series of fixups.
>> >
>> > Bjorn, Jean, Rafael, thank you for your reviews!
>> >
>> > Since v1:
>> > - move the helper to be regular function (Bjorn, Rafael)
>> > - fix a potential regression introduced in pci_acpi_crs_quirks()
>> > (Jean)
>> > - adjust subject lines and commit message bodies (Bjorn)
>> > - add tags (Bjorn, Jean)
>> >
>> > Andy Shevchenko (4):
>> >   firmware: dmi_scan: Introduce the dmi_get_bios_year() helper
>> >   x86/PCI: Simplify code by using the new dmi_get_bios_year() helper
>> >   ACPI / sleep: Simplify code by using the new dmi_get_bios_year()
>> >     helper
>> >   PCI: Simplify code by using the new dmi_get_bios_year() helper
>>
>> I can apply this or if you want to route it differently,
>
> I don't know how to proceed here, Ingo applied v1 and there might be
> options like remove old and reapply new, or do a series of fixups.
>
> Ingo, can you suggest how to do this in the best way?

AFAICS the tip workflow is that things are not rebased in there, only
reverted if need be, and if the previous version was taken to tip,
reverting it is not worth the hassle IMO.

I'd just wait for it to be integrated and post an update on top of it
or even on top of linux-next.

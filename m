Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5A42F847.5060305@rock-chips.com>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
 <20171226023646.17722-5-jeffy.chen@rock-chips.com> <20171226235607.4rgp4ebrrktt6d56@rob-hp-laptop>
 <5A42F847.5060305@rock-chips.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 27 Dec 2017 09:30:22 -0600
Message-ID: <CAL_JsqJssPABjoRM-XAnuN_Xd2-sHoFifJNrRDdk_ruQ0DRw6A@mail.gmail.com>
Subject: Re: [RFC PATCH v12 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
To: JeffyChen <jeffy.chen@rock-chips.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Anderson <dianders@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, linux-pci@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 26, 2017 at 7:32 PM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> Hi Rob,
>
> Thanks for your reply.
>
> On 12/27/2017 07:56 AM, Rob Herring wrote:
>>>
>>> >
>>> >  drivers/of/of_pci_irq.c  | 49 +++++++++++++++++++++++++++++++
>>
>> Please move this to drivers/pci/of.c (or perhaps create pci/of_irq.c).
>>
>>> >  drivers/pci/Makefile     |  1 +
>>> >  drivers/pci/pci-driver.c | 10 +++++++
>>> >  drivers/pci/pci-of.c     | 75
>>> > ++++++++++++++++++++++++++++++++++++++++++++++++
>>
>> We already have drivers/pci/of.c. It's not clear what the difference is
>> from the filenames. Either merge with of.c or perhaps of-pm.c.
>
>
> this new file does something similar to the pci-acpi.c and pci-mid.c..

pci-acpi.c has similar things to pci/of.c. The naming is just not consistent.

Also, I plan to move the rest of drivers/of/of_pci* to drivers/pci.

> and i am agree the naming is not clear, maybe we can rename both of those
> files to something like pci-pm-***.c?

At least pci-acpi.c is more than just PM functions, so that doesn't
make sense. Given that all the ACPI related functions are in 1 file,
we should do the same for DT.

>
> Hi Rafael, do you think this would make sense?
>
>

[...]

>>> >+static int __init of_pci_init(void)
>>> >+{
>>> >+      if (!acpi_disabled)
>>> >+              return 0;
>>> >+
>>> >+      pci_set_platform_pm(&of_pci_platform_pm);
>>
>> I guess no DT based system will override this?
>
>
> i think the !acpi_disabled means acpi been disabled or CONFIG_ACPI is
> undefined.
>
> and pci-acpi.c would only work when we have CONFIG_ACPI.
>
> but i have no idea about pci-mid.c or would it possible to have more
> platform pm ops in the future...maybe we should add some dependency in the
> Kconfig?

It's probably fine given there are only 2 other implementations so far.

Rob

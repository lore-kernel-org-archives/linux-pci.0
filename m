Return-Path: <SRS0=AzQR=YZ=redhat.com=hdegoede@kernel.org>
Return-Path: <SRS0=AzQR=YZ=redhat.com=hdegoede@kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
To: Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@redhat.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de> <20170104210954.GA11946@al>
 <59349185.1aqio7kYFn@aspire.rjw.lan>
 <1456065516.8360056.1483572074197.JavaMail.zimbra@redhat.com>
 <20170105150646.GB21446@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Wu <peter@lekensteyn.nl>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kilian Singer <kilian.singer@quantumtechnology.info>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Peter Jones <pjones@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <bd9af400-6b8e-d852-8cf0-b437dffc507c@redhat.com>
Date: Wed, 11 Jan 2017 12:04:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170105150646.GB21446@wunner.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

HI,

On 05-01-17 16:06, Lukas Wunner wrote:
> On Wed, Jan 04, 2017 at 06:21:14PM -0500, David Airlie wrote:
>>> On Wednesday, January 04, 2017 10:09:54 PM Peter Wu wrote:
>>>> On Wed, Jan 04, 2017 at 09:16:39AM +0100, Lukas Wunner wrote:
>>>>> On Tue, Jan 03, 2017 at 06:05:57PM -0600, Bjorn Helgaas wrote:
>>>>>> I don't *want* to apply the revert.  It's on my for-linus branch as a
>>>>>> worst-case scenario change if we can't figure out a better fix.
>>>>>>
>>>>>> The patch below is preferable, but I'd rather not take even it,
>>>>>> because it takes away functionality and forces people to use a boot
>>>>>> parameter to restore it.  I expect that somebody will figure out how
>>>>>> to fix the regression Kilian found and also keep the new functionality
>>>>>> (without requiring boot parameters) before v4.10.
>>>>>
>>>>> The issue is constrained to hybrid graphics laptops with Nvidia discrete
>>>>> GPU using nouveau.  Hence it needs to be fixed in nouveau, not in the
>>>>> PCI core.
>>>>
>>>> The problem is not necessarily in the nouveau driver, the same problem
>>>> occurs when you enable RPM without loading nouveau. The issue is limited
>>>> though to some newer hybrid graphics laptops with Nvidia GPUs. While a
>>>> quirk can be added to nouveau, I think that a (temporary) quirk in core
>>>> would also be reasonable (since it also occurs without nouveau).
>>>>
>>>>> (AFAIUI, laptops with AMD discrete GPU are not affected as it is known
>>>>> when and how to call an ACPI method versus using PR3.)
>>>>>
>>>>> (Neither are laptops using the Nvidia proprietary driver as it doesn't
>>>>> runtime suspend the card.  But battery life will be terrible then.)
>>>>>
>>>>> We're at rc2 so the time frame for coming up with a fix is probably
>>>>> 4 weeks.  Peter and others have tried for months to reverse-engineer
>>>>> how to handle runtime PM on newer Nvidia cards.  It seems likely that
>>>>> we'll not find the ultimate solution to the problem within 4 weeks.
>>>>
>>>> Yep, a quick proper fix seems unlikely.
>>>> [ Help/ideas are welcome, I suspect that these failures to restore power
>>>> on laptops designed for Win8+ all have the same cause, related to some
>>>> unknown interaction between ACPI and PCI. Some links:
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=190861
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=156341 ]
>>>>
>>>>> The way it is now, i.e. defaulting to PR3 when available, regresses
>>>>> certain laptops such as Kilian's.  If on the other hand we default to
>>>>> DSM when available, we'll regress certain other laptops, as Peter has
>>>>> pointed out.  Whitelisting or blacklisting laptops doesn't seem a good
>>>>> approach either, ideally we'd want to use PR3 as Windows does.
>>>>>
>>>>> As said, the only short-term solution I see is to add an "optimus"
>>>>> module_param to nouveau to allow users to select which method to use.
>>>>> So in Kilian's case an additional command line parameter would be
>>>>> necessary to fix the issue.
>>>>>
>>>>> Does anyone see a better solution or can we agree on this one?  If so
>>>>> I can come up with a patch.  This could go in via Dave Airlie's tree.
>>>>
>>>> As pcie_port_pm=off already reverts to DSM, I do not think that an
>>>> additional (temporary) nouveau module parameter is going to help. I
>>>> instead propose a (hopefully temporary) quirk in pci core that disables
>>>> D3cold RPM for just Kilians Lenovo laptop (basically defaulting to
>>>> pcie_port_pm=off). Then the option pcie_port_pm=force can still be used
>>>> to test possible solutions in the future.
>>>
>>> I would rather add a quirk to the ACPI core to prevent the power resources in
>>> question from being enumerated.  Or even to prevent ACPI PM from being
>>> used for the port in question.
>>
>> I do have a W541 in a cupboard in the office somewhere, but I won't be close to
>> it for a couple of weeks. The W541 was the first place I tested the pm patches
>> so I'm kinda wondering whether it's all W541's or just some specific model/bios
>> combo.
>>
>> However I'm pretty much unavailable to do anything much until late Jan on this.
>
> Is there anyone else at Red Hat who might be able to look into this?
>
> ISTR that Hans de Goede is working on improving laptop support in Fedora,
> and Peter Jones recently got a patch merged for the W541 with the exact
> same firmware Kilian is using to work around a botched EFI memory map.
> Adding them to cc: in the hope that they may be able to help.
>
> @Peter, have you noticed issues with the discrete Nvidia GPU on your W541
> related to runtime suspend and system sleep?

I've tried to reproduce this problem on my W541, which has the exact
same CPU + GPU combo as the reporter of:

https://bugzilla.kernel.org/show_bug.cgi?id=190861

But no luck, I started out with BIOS-2.27 and when I could not reproduce
I updated to 2.29 (should have tried 2.28 which is what the reporter
has first in retrospect) and still no luck in reproducing this.

I'll attach acpidumps of the 2 Bios versions I've tried to the bug.

Regards,

Hans

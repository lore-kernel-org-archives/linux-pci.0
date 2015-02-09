Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vserver.eikelenboom.it ([84.200.39.61]:48280 "EHLO
	smtp.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933111AbbBITPe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 14:15:34 -0500
Date: Mon, 9 Feb 2015 20:15:27 +0100
From: Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <1703934611.20150209201527@eikelenboom.it>
To: Stefan Bader <stefan.bader@canonical.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Tony Luck <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [Bugfix 0/3] Xen IRQ related hotfixes for v3.19
In-Reply-To: <54D8DBC8.3020502@canonical.com>
References: <1421720467-7709-1-git-send-email-jiang.liu@linux.intel.com> <1369609199.20150205210757@eikelenboom.it> <54D8823F.9080900@canonical.com> <54D8A446.3000008@linux.intel.com> <54D8A83B.60307@canonical.com> <54D8DBC8.3020502@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Monday, February 9, 2015, 5:09:44 PM, you wrote:

> On 09.02.2015 13:29, Stefan Bader wrote:
>> On 09.02.2015 13:12, Jiang Liu wrote:
>>> On 2015/2/9 17:47, Stefan Bader wrote:
>>>> On 05.02.2015 21:07, Sander Eikelenboom wrote:
>>>>>
>>>>> Tuesday, January 20, 2015, 3:21:04 AM, you wrote:
>>>>>
>>>>>> Hi Thomas,
>>>>>>         This patch set includes three hotfixes related Xen IRQ for v3.19.
>>>>>> Sorry for the long delay to get these two regressions fixed, it really
>>>>>> cost me some time to read and understand Xen IRQ code.
>>>>>
>>>>>> Patch 1 fixes the failure to register ACPI SCI interrupt on Xen
>>>>>> domain0 by reworking acpi_gsi_to_irq(). I will backport it to v3.18
>>>>>> too once it reaches the mainstream kernel.
>>>>>
>>>>>> Patch 2 fixes the regression in Xen PCI device passthrough(pciback).
>>>>>> It's a temporary solution, I will send the formal fix for v3.20 and
>>>>>> it has passed tests too.
>>>>>
>>>>>> Patch 3 fixes an issue found when reading code. There's no real bug
>>>>>> reports related to this issue yet.
>>>>>
>>>>>> Great thanks to Konrad and Sander for testing fixes for these regressions.
>>>>>
>>>>>> Regards,
>>>>>> Gerry
>>>>>
>>>>> Hi Gerry,
>>>>>
>>>>> Since these patches now are: tested, reviewed and have landed into mainline,
>>>>> could you also provide the backports for 3.17 and 3.18 where required ?
>>>>
>>>> This would be my attempt of backporting those to 3.18 (I have not tried whether
>>>> they would apply to 3.17 as well). Those seem to work when test-booting and
>>>> Sander said he will give them a try as well. But better check yourself I did not
>>>> mess anything up while backporting. One of the three patches seemed not to be
>>>> required at all.
>>> I'm backporting them too, but now I will give up my patches:)
>>>
>>> The first one is a must, which should be applied to 3.17 and 3.18.
>>> The second one doesn't apply to 3.17 or 3.18.
>>> The third may be applied to v3.17 and v3.18, but it shouldn't be applied
>>> according to the stable-kernel doc because no user reports such a bug yet.
>> 
>> Hm, ok. So maybe I should retry with only patch#1 and verify that alone gets
>> around the acpi irq and the usb problems, too. Though interestingly from the
>> history, the acpi irq I saw in 3.17 while the usb devices started to fail with
>> 3.18. I will let you know in a bit. Just want to finish another bisect first.

> So it looks like patch #1 indeed does fix both the acpi irq and my usb devices.
> Sander, do you want to verify that variant, too?

Hi Stefan / Gerry,

Just tested with only patch 1, ended up the same .. the reported issues seem 
gone.


> The only odd thing left in a 3.18 with the fix (regardless of using patch #1
> only or patches #1 and #3) is that the ahci driver shows up with its pci bus
> number in /proc/interrupts. But that does not seem to have any relevant downside
> (cannot try 3.19 on that box right now for other reasons).

> -Stefan

> ...
> # 57: 12441  0    0    0  xen-pirq-msi       0000:00:1f.2
> #                                            (used to be ahci)

This is also there on baremetal with 3.19 on intel, so not xen related:
 27:       1868        582       1282        555  IR-PCI-MSI-edge      0000:00:1f.2

--
Sander

>> 
>> -Stefan
>> 
>>> Regards
>>> Gerry
>>>>
>>>> -Stefan
>>>>
>>>>>
>>>>> The number of people running into these (subtle) issues with these stable
>>>>> kernels seems to be steadily increasing.
>>>>>
>>>>> --
>>>>> Sander
>>>>>
>>>>>> Jiang Liu (3):
>>>>>>   xen/pci: Kill function xen_setup_acpi_sci()
>>>>>>   xen/irq, ACPI: Fix regression in xen PCI passthrough caused by
>>>>>>     cffe0a2b5a34
>>>>>>   xen/irq: Override ACPI IRQ management callback __acpi_unregister_gsi
>>>>>
>>>>>>  arch/x86/include/asm/acpi.h |    1 +
>>>>>>  arch/x86/kernel/acpi/boot.c |   26 +++++++++++------------
>>>>>>  arch/x86/pci/xen.c          |   49 ++-----------------------------------------
>>>>>>  drivers/acpi/pci_irq.c      |    1 -
>>>>>>  4 files changed, 16 insertions(+), 61 deletions(-)
>>>>>
>>>>>
>>>>
>> 
>> 




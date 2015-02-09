Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54D8A446.3000008@linux.intel.com>
Date: Mon, 09 Feb 2015 20:12:54 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Stefan Bader <stefan.bader@canonical.com>,
	Sander Eikelenboom <linux@eikelenboom.it>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [Bugfix 0/3] Xen IRQ related hotfixes for v3.19
References: <1421720467-7709-1-git-send-email-jiang.liu@linux.intel.com> <1369609199.20150205210757@eikelenboom.it> <54D8823F.9080900@canonical.com>
In-Reply-To: <54D8823F.9080900@canonical.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/2/9 17:47, Stefan Bader wrote:
> On 05.02.2015 21:07, Sander Eikelenboom wrote:
>>
>> Tuesday, January 20, 2015, 3:21:04 AM, you wrote:
>>
>>> Hi Thomas,
>>>         This patch set includes three hotfixes related Xen IRQ for v3.19.
>>> Sorry for the long delay to get these two regressions fixed, it really
>>> cost me some time to read and understand Xen IRQ code.
>>
>>> Patch 1 fixes the failure to register ACPI SCI interrupt on Xen
>>> domain0 by reworking acpi_gsi_to_irq(). I will backport it to v3.18
>>> too once it reaches the mainstream kernel.
>>
>>> Patch 2 fixes the regression in Xen PCI device passthrough(pciback).
>>> It's a temporary solution, I will send the formal fix for v3.20 and
>>> it has passed tests too.
>>
>>> Patch 3 fixes an issue found when reading code. There's no real bug
>>> reports related to this issue yet.
>>
>>> Great thanks to Konrad and Sander for testing fixes for these regressions.
>>
>>> Regards,
>>> Gerry
>>
>> Hi Gerry,
>>
>> Since these patches now are: tested, reviewed and have landed into mainline,
>> could you also provide the backports for 3.17 and 3.18 where required ?
> 
> This would be my attempt of backporting those to 3.18 (I have not tried whether
> they would apply to 3.17 as well). Those seem to work when test-booting and
> Sander said he will give them a try as well. But better check yourself I did not
> mess anything up while backporting. One of the three patches seemed not to be
> required at all.
I'm backporting them too, but now I will give up my patches:)

The first one is a must, which should be applied to 3.17 and 3.18.
The second one doesn't apply to 3.17 or 3.18.
The third may be applied to v3.17 and v3.18, but it shouldn't be applied
according to the stable-kernel doc because no user reports such a bug yet.
Regards
Gerry
> 
> -Stefan
> 
>>
>> The number of people running into these (subtle) issues with these stable
>> kernels seems to be steadily increasing.
>>
>> --
>> Sander
>>
>>> Jiang Liu (3):
>>>   xen/pci: Kill function xen_setup_acpi_sci()
>>>   xen/irq, ACPI: Fix regression in xen PCI passthrough caused by
>>>     cffe0a2b5a34
>>>   xen/irq: Override ACPI IRQ management callback __acpi_unregister_gsi
>>
>>>  arch/x86/include/asm/acpi.h |    1 +
>>>  arch/x86/kernel/acpi/boot.c |   26 +++++++++++------------
>>>  arch/x86/pci/xen.c          |   49 ++-----------------------------------------
>>>  drivers/acpi/pci_irq.c      |    1 -
>>>  4 files changed, 16 insertions(+), 61 deletions(-)
>>
>>
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] PCI: Revert "Implement pcibios_alloc_irq() and
 pcibios_free_irq()"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <56C55305.2050404@mcc.vniiem.ru> <20160218160319.GC17588@localhost>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
From: =?UTF-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>
Message-ID: <56CDF6E0.2060005@mcc.vniiem.ru>
Date: Wed, 24 Feb 2016 21:30:56 +0300
MIME-Version: 1.0
In-Reply-To: <20160218160319.GC17588@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've checked next next-20160218 tag and confirm that it works.

18.02.2016 19:03, Bjorn Helgaas пишет:
> On Thu, Feb 18, 2016 at 08:13:41AM +0300, Мороз Олег wrote:
>> On 17.02.2016 21:36, Bjorn Helgaas wrote:
>>> These are clean reverts of 991de2e59090 ("PCI, x86: Implement
>>> pcibios_alloc_irq() and pcibios_free_irq()") and related changes.
>>>
>>> We have two reports of drivers broken in v4.3 by Jiang's change,
>>> 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
>>> pcibios_free_irq()").
>>>
>>> It would be best to fix the problem instead of reverting 991de2e59090, but
>>> I don't have time to do that myself, and we haven't heard from Jiang, so
>>> the only choice I have is to revert the commit.
>>>
>>> Note that reverting will likely break IOAPIC hotplug.
>>>
>>> Олег and Sunjin, can you please test this and see whether it fixes your
>>> drivers?  This patch is based on v4.5-rc1.
>>>
>>> I intend to merge these for v4.5 unless I hear objections.
>>>
>>> They're on my for-linus branch, so they should appear in linux-next
>>> tomorrow.
>>>
>>> Changes from the v1 posting:
>>>    - Explicitly revert related patches instead of resolving conflicts
>>>      manually
>>> ---
>>>
>>> Bjorn Helgaas (3):
>>>        Revert "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"
>>>        Revert "PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed"
>>>        Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"
>>>
>>>
>>>   arch/x86/include/asm/pci_x86.h |    2 ++
>>>   arch/x86/pci/common.c          |   26 ++++++++++----------------
>>>   arch/x86/pci/intel_mid_pci.c   |    9 +++------
>>>   arch/x86/pci/irq.c             |   23 +++++++++++++++++++----
>>>   drivers/acpi/pci_irq.c         |   17 +++++++++++++----
>>>   include/linux/pci.h            |   17 -----------------
>>>   6 files changed, 47 insertions(+), 47 deletions(-)
>> As i undestand this patch will appear in kernel git repo tomorrow? I
>> don't need to apply in manyally to v4.5-rc1?
> These are included in the next-20160218 tag in the linux-next git repo (not
> Linus' repo) at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>
> You browse this at:
>
>    https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/
>
> If you'd rather, you can also apply the patches yourself to v4.5-rc1.
>
> Bjorn

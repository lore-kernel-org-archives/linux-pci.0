Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Wed, 17 Feb 2016 20:47:16 +0100
Message-ID: <CAJZ5v0g1TBiRhALk5Q8PbC2FOXvOCJJsfNBcTVBLFpjDFvp0ag@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PCI: Revert "Implement pcibios_alloc_irq() and pcibios_free_irq()"
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	=?UTF-8?B?0J7Qu9C10LPQnNC+0YDQvtC3?= <oleg.moroz@mcc.vniiem.ru>,
	Joerg Roedel <jroedel@suse.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sunjin Yang <fan4326@gmail.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 17, 2016 at 7:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> These are clean reverts of 991de2e59090 ("PCI, x86: Implement
> pcibios_alloc_irq() and pcibios_free_irq()") and related changes.
>
> We have two reports of drivers broken in v4.3 by Jiang's change,
> 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
> pcibios_free_irq()").
>
> It would be best to fix the problem instead of reverting 991de2e59090, but
> I don't have time to do that myself, and we haven't heard from Jiang, so
> the only choice I have is to revert the commit.
>
> Note that reverting will likely break IOAPIC hotplug.
>
> Олег and Sunjin, can you please test this and see whether it fixes your
> drivers?  This patch is based on v4.5-rc1.
>
> I intend to merge these for v4.5 unless I hear objections.
>
> They're on my for-linus branch, so they should appear in linux-next
> tomorrow.
>
> Changes from the v1 posting:
>   - Explicitly revert related patches instead of resolving conflicts
>     manually
> ---
>
> Bjorn Helgaas (3):
>       Revert "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"
>       Revert "PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed"
>       Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"

ACK for all three FWIW.

Thanks,
Rafael

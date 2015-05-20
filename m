Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <555BFB95.30208@linux.intel.com>
Date: Wed, 20 May 2015 11:12:21 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [RFC 2/4] PCI, MSI: Optionally free legacy PCI IRQ when enabling
 MSI/MSI-X
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com> <1430968374-29286-3-git-send-email-jiang.liu@linux.intel.com> <20150519213937.GR31666@google.com>
In-Reply-To: <20150519213937.GR31666@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/20 5:39, Bjorn Helgaas wrote:
> On Thu, May 07, 2015 at 11:12:52AM +0800, Jiang Liu wrote:
>> Once PCI MSI/MSI-X is enabled by the device driver, PCI device won't
>> make use of legacy PCI IRQ until PCI MSI/MSI-X is disabled again.
>> So optionally free legacy PCI IRQ when enabling MSI/MSI-X and reallocate
>> when disabling MSI/MSI-X.
> 
> The rest of this series makes sense to me.  If you want to remove an
> IOAPIC, you want to make sure all of the IRQs using that IOAPIC have been
> freed.
> 
> But I'm trying to figure out this patch.  Do you want to free the IRQ when
> enabling MSI because it enables you to remove the IOAPIC without removing
> the device?  That wouldn't really make sense to me because then the device
> has no possibility of using INTx.
Hi Bjorn
	Sorry for the confusion. This patch is not for IOAPIC
hot-removal, but it's an effort to use IRQ resource precisely.
The idea is to allocate IRQ resource on demand and release it
when not used. We could skip this patch if it's not worth the
cost.
Thanks!
Gerry

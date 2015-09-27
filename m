Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sun, 27 Sep 2015 16:15:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [PCI, x86] RIP: 0010:[<ffffffff81a2ef16>] [<ffffffff81a2ef16>]
 _raw_spin_unlock_irqrestore
Message-ID: <20150927141533.GA9667@pd.tnic>
References: <20150927131524.GA2461@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150927131524.GA2461@wfg-t540p.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 27, 2015 at 09:15:24PM +0800, Fengguang Wu wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit 991de2e59090e55c65a7f59a049142e3c480f7bd
> Author:     Jiang Liu <jiang.liu@linux.intel.com>
> AuthorDate: Wed Jun 10 16:54:59 2015 +0800
> Commit:     Bjorn Helgaas <bhelgaas@google.com>
> CommitDate: Thu Jul 30 14:05:57 2015 -0500
> 
>     PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()
>     
>     To support IOAPIC hotplug, we need to allocate PCI IRQ resources on demand
>     and free them when not used anymore.
>     
>     Implement pcibios_alloc_irq() and pcibios_free_irq() to dynamically
>     allocate and free PCI IRQs.
>     
>     Remove mp_should_keep_irq(), which is no longer used.
>     
>     [bhelgaas: changelog]
>     Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Thomas Gleixner <tglx@linutronix.de>

This one is seriously b0rked:

https://lkml.kernel.org/r/20150926164651.GA3640@pd.tnic

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

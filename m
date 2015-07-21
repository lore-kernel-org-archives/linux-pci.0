Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Jul 2015 08:30:31 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [RFC Patch V1 00/12] Reorganize struct msi_desc to prepare for
 support of generic MSI
Message-ID: <20150721133031.GF16841@google.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Paul]

On Thu, Jul 09, 2015 at 04:00:35PM +0800, Jiang Liu wrote:
> Recently Marc Zyngier <marc.zyngier@arm.com> has posted a patch set at
> https://lkml.org/lkml/2015/7/7/712
> to enhance PCI MSI code to support generic MSI.
> 
> This is a companion patch set to refine struct msi_desc and related data
> structures to support generic MSI, and it would be better to combined with
> Marc's patch set.  It's also requested by
> Stuart Yoder <stuart.yoder@freescale.com>
> 
> It first introduces a helper function msi_desc_to_pci_sysdata(), and
> convert current PCI drivers to use helper functions to access fields
> in struct msi_desc.
> Then it moves msi_list from struct pci_dev into struct device and
> refines struct msi_desc.
> At last it moves alloc_msi_entry() into kernel/irq/msi.c for reuse.
> 
> Currently msi_desc_to_pci_sysdata() and msi_desc_to_pci_dev() are
> implemented as normal functions instead of inlines to avoid header file
> inclusion issue. If inlined version is preferred for performance, we could
> move all of first_pci_msi_entry, for_each_pci_msi_entry, msi_desc_to_pci_dev
> and msi_desc_to_pci_sysdata from linxu/kernel/msi.h into linux/kernel/pci.h.
> 
> This patch set is based on v4.2-rc1 and passes 0day test suite. You
> may access the code at:
> https://github.com/jiangliu/linux.git msi_desc_v1
> 
> Thanks!
> Gerry
> 
> Jiang Liu (12):
>   PCI: Add helper function msi_desc_to_pci_sysdata()
>   MIPS, PCI: Use for_pci_msi_entry() to access MSI device list
>   PowerPC, PCI: Use for_pci_msi_entry() to access MSI device list
>   s390/pci: Use for_pci_msi_entry() to access MSI device list
>   x86, PCI: Use for_pci_msi_entry() to access MSI device list
>   PCI: Use for_pci_msi_entry() to access MSI device list
>   sparc, PCI: Use helper functions to access fields in struct msi_desc
>   PCI: Use helper functions to access fields in struct msi_desc
>   genirq: Move msi_list from struct pci_dev to struct device
>   genirq, PCI: Store 'struct device *' instead 'struct pci_dev *' in
>     struct msi_desc
>   genirq, PCI: Reorginize struct msi_desc to prepare for support of
>     generic MSI
>   genirq, PCI: Move alloc_msi_entry() from PCI MSI code into generic
>     MSI code

Sergei pointed out typos in the "Use for_pci_msi_entry()" subject and
changelogs; I assume you'll fix those.

Paul had a question on 09/12 regarding Kconfig, and I didn't see a
resolution to that.

For the PCI parts:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thomas, I assume you'll take this via your tree.

Bjorn

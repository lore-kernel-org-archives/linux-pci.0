Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 8 May 2013 21:10:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Lance Ortiz <lance.ortiz@hp.com>
Cc: bhelgaas@google.com, lance_ortiz@hotmail.com, jiang.liu@huawei.com,
	tony.luck@intel.com, rostedt@goodmis.org, mchehab@redhat.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aerdrv: Move cper_print_pcie() out of interrupt context
Message-ID: <20130508191019.GG30955@pd.tnic>
References: <20130508171519.26724.63307.stgit@grignak.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130508171519.26724.63307.stgit@grignak.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 08, 2013 at 11:15:19AM -0600, Lance Ortiz wrote:
> The following warning was seen on 3.9 when a corrected PCIe error was being
> handled by the AER subsystem.
> 
> WARNING: at .../drivers/pci/search.c:214 pci_get_dev_by_id+0x8a/0x90()
> 
> This occurred because code was added to the function cper_print_pcie() that
> calls the pci_get_domain_bus_and_slot() function.  cper_print_pcie() is called
> in an interrupt context and pci_get* functions are not supposed to be called
> in that context hence the warning.
> 
> The solution is to move the call to cper_print_aer() out of the interrupt
> context and into aer_recover_queue() to avoid any warnings when calling
> pci_get* functions.
> 
> Signed-off-by: Lance Ortiz <lance.ortiz@hp.com>

Looks good.

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

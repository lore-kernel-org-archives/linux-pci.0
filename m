Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 Jul 2016 16:29:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI/PCIe: make DPC explicitly non-modular
Message-ID: <20160728202859.GA2420@localhost.localdomain>
References: <20160728193303.12945-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160728193303.12945-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 28, 2016 at 03:33:03PM -0400, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pci/pcie/Kconfig:config PCIE_DPC
> drivers/pci/pcie/Kconfig:       bool "PCIe Downstream Port Containment support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.

Thanks for cleaning this up.

FWIW, all of the other pcie service drivers look like they could use
the same cleanup.

Reviewed-by: Keith Busch <keith.busch@intel.com>

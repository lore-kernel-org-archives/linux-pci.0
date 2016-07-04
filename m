Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49023 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbcGDRhy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Jul 2016 13:37:54 -0400
Date: Mon, 4 Jul 2016 18:37:52 +0100
From: Will Deacon <will.deacon@arm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, arnd@arndb.de, david.daney@cavium.com,
	jchandra@broadcom.com
Subject: Re: [PATCH 04/14] PCI: generic: make it explicitly non-modular
Message-ID: <20160704173752.GR1639@arm.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
 <20160702231334.26684-5-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160702231334.26684-5-paul.gortmaker@windriver.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 02, 2016 at 07:13:24PM -0400, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pci/host/Kconfig:config PCI_HOST_GENERIC
> drivers/pci/host/Kconfig:       bool "Generic PCI host controller"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the few trace uses of modular code and macros, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.

Ideally, we'd simply fix this to build as a module, but it's not clear
how to do that now that the ecam accessors have been split out into
their own file. A liberal sprinkling of EXPORT_SYMBOL might work, but
it's a bit grotty.

David, Jayachandran -- do you have any desire to build your PCI host
controller drivers as modules?

Will

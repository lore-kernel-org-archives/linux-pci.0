Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56284 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751523AbbLMKdj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Dec 2015 05:33:39 -0500
Date: Sun, 13 Dec 2015 11:33:29 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: <linux-kernel@vger.kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 03/10] drivers/pci: make host/pci-mvebu.c explicitly
 non-modular
Message-ID: <20151213113329.3b1a303f@free-electrons.com>
In-Reply-To: <1449970917-12633-4-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
	<1449970917-12633-4-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Paul,

On Sat, 12 Dec 2015 20:41:50 -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pci/host/Kconfig:config PCI_MVEBU
> drivers/pci/host/Kconfig:       bool "Marvell EBU PCIe controller"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
> 
> We don't have to disallow a driver unbind, since that is already
> done for us in this driver.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now ) contained at the top of the file in the comments.
> 
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

I think the general direction should rather be to change the PCI
subsystem to make it possible for those drivers to be built as modules.
However, since this is quite certainly a much larger effort, there is
no reason to not clean things up as they are today, so:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

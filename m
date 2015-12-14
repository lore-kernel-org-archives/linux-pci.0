Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0074.outbound.protection.outlook.com ([104.47.38.74]:10753
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751211AbbLNHZh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Dec 2015 02:25:37 -0500
Subject: Re: [PATCH 08/10] drivers/pci: make host/pcie-xilinx.c explicitly
 non-modular
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	<linux-kernel@vger.kernel.org>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <1449970917-12633-9-git-send-email-paul.gortmaker@windriver.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <566E6EE9.6000101@xilinx.com>
Date: Mon, 14 Dec 2015 08:25:29 +0100
MIME-Version: 1.0
In-Reply-To: <1449970917-12633-9-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13.12.2015 02:41, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pci/host/Kconfig:config PCIE_XILINX
> drivers/pci/host/Kconfig:       bool "Xilinx AXI PCIe host bridge support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.  This
> makes xilinx_pcie_free_irq_domain orphaned so we remove it too.

Right.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

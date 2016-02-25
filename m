Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34961 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932407AbcBYP7O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Feb 2016 10:59:14 -0500
Date: Thu, 25 Feb 2016 09:59:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	Ley Foon Tan <lftan@altera.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Russell Joyce <russell.joyce@york.ac.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ray Jui <rjui@broadcom.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Rob Herring <robh@kernel.org>, Duc Dang <dhdang@apm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-kernel@vger.kernel.org,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 0/6] Xilinx AXI PCIe Host Bridge driver fixes
Message-ID: <20160225155911.GF8120@localhost>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Paul,

On Thu, Feb 04, 2016 at 04:10:07PM +0000, Paul Burton wrote:
> This series fixes a number of issues found using the Xilinx AXI PCIe
> Host Bridge IP on the Imagination Technologies MIPS Boston development
> board. It has been split out of the larger Boston board support series
> at Michal's request.
> 
> Applies atop v4.5-rc2.
> 
> Paul Burton (6):
>   PCI: xilinx: Keep references to both IRQ domains
>   PCI: xilinx: Unify INTx & MSI interrupt FIFO decode
>   PCI: xilinx: Always clear interrupt decode register
>   PCI: xilinx: Clear interrupt FIFO during probe
>   PCI: xilinx: Fix INTX irq dispatch
>   PCI: xilinx: Allow build on MIPS platforms
> 
>  drivers/pci/host/Kconfig       |   2 +-
>  drivers/pci/host/pcie-xilinx.c | 125 +++++++++++++++++++----------------------

Looks like Bharat has some IRQ concerns, so I'm guessing you'll be
posting a v4?

Bjorn

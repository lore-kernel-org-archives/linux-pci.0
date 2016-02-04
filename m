Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42498 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbcBDRqu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 12:46:50 -0500
MIME-Version: 1.0
In-Reply-To: <1454602213-967-7-git-send-email-paul.burton@imgtec.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com> <1454602213-967-7-git-send-email-paul.burton@imgtec.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 4 Feb 2016 11:46:28 -0600
Message-ID: <CAL_JsqLRMiJ-0j_PrXSKqf6MrRfyqbDGaiaiEn4rAoFaCNgtKQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] PCI: xilinx: Allow build on MIPS platforms
To: Paul Burton <paul.burton@imgtec.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	Ley Foon Tan <lftan@altera.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Scott Branden <sbranden@broadcom.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Duc Dang <dhdang@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ray Jui <rjui@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 4, 2016 at 10:10 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> Allow the xilinx-pcie driver to be built on MIPS platforms. This will be
> used on the MIPS Boston board.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>
> ---
>
> Changes in v3:
> - Split out from Boston patchset.
>
> Changes in v2: None
>
>  drivers/pci/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 75a6054..0aee193 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -81,7 +81,7 @@ config PCI_KEYSTONE
>
>  config PCIE_XILINX
>         bool "Xilinx AXI PCIe host bridge support"
> -       depends on ARCH_ZYNQ
> +       depends on ARCH_ZYNQ || MIPS

Why don't you just remove the dependency? Then it gets better build coverage.

Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Feb 2016 10:53:24 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: <linux-kernel@vger.kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thierry Reding <thierry.reding@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/5] drivers/pci: make host/pci-keystone-dw.c modular
Message-ID: <20160208155324.GU23093@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
 <1454889644-27830-5-git-send-email-paul.gortmaker@windriver.com>
 <91848876.ZYig6qgHLq@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <91848876.ZYig6qgHLq@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH 4/5] drivers/pci: make host/pci-keystone-dw.c modular] On 08/02/2016 (Mon 10:59) Arnd Bergmann wrote:

> On Sunday 07 February 2016 19:00:43 Paul Gortmaker wrote:
> > Export the symbols that this driver requires in order for it to
> > be modular.  In addition to the one use case of a dw_pci sym, it
> > has many instances of its own ks_dw_pci syms that need exporting
> > in order to modpost w/o error.
> > 
> > Cc: Murali Karicheri <m-karicheri2@ti.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> 
> 
> Could we just have one module for the driver  instead of two?

That thought crossed my mind, but I was considering merging the C files
and figured it might be more churn than the maintainer wanted.  If
maintainers are good with the below (assuming it works) then yes that
also seems reasonable.

P.
--

> 
> Something like below (untested)
> 
> 	Arnd
> 
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 7b2f20c6ccc6..0b472c680348 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -8,7 +8,8 @@ obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
>  obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> -obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
> +obj-$(CONFIG_PCI_KEYSTONE) pci-keystone-mod.o
> +pci-keystone-mod-objs := pci-keystone-dw.o pci-keystone.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>  obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
>  obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
> 

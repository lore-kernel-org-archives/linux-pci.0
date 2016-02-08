Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:58060 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbcBHKAH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2016 05:00:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] drivers/pci: make host/pci-keystone-dw.c modular
Date: Mon, 08 Feb 2016 10:59:26 +0100
Message-ID: <91848876.ZYig6qgHLq@wuerfel>
In-Reply-To: <1454889644-27830-5-git-send-email-paul.gortmaker@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com> <1454889644-27830-5-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday 07 February 2016 19:00:43 Paul Gortmaker wrote:
> Export the symbols that this driver requires in order for it to
> be modular.  In addition to the one use case of a dw_pci sym, it
> has many instances of its own ks_dw_pci syms that need exporting
> in order to modpost w/o error.
> 
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---


Could we just have one module for the driver  instead of two?

Something like below (untested)

	Arnd

diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 7b2f20c6ccc6..0b472c680348 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -8,7 +8,8 @@ obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
 obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
-obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
+obj-$(CONFIG_PCI_KEYSTONE) pci-keystone-mod.o
+pci-keystone-mod-objs := pci-keystone-dw.o pci-keystone.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
 obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o


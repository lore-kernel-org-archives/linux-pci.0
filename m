Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 28 Aug 2015 16:43:50 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: PCI_RCAR_GEN2 and PCI_RCAR_GEN2_PCIE should depend
 on ARM
Message-ID: <20150828214350.GC27890@google.com>
References: <1439296994-28480-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439296994-28480-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 11, 2015 at 02:43:14PM +0200, Geert Uytterhoeven wrote:
> On arm64/shmobile:
> 
>     drivers/pci/host/pci-rcar-gen2.c: In function 'rcar_pci_cfg_base': drivers/pci/host/pci-rcar-gen2.c:112:34: error: dereferencing pointer to incomplete type
>       struct rcar_pci_priv *priv = sys->private_data;
> 				      ^
> 
> and
> 
>     drivers/pci/host/pcie-rcar.c:138:52: warning: 'struct pci_sys_data' declared inside parameter list
>      static inline struct rcar_pcie *sys_to_pcie(struct pci_sys_data *sys)
> 							^
> 
> pci_sys_data exists on ARM only, hence these drivers should depend on
> ARM unconditionally.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I applied this to pci-4.4/host-rcar, which I will rebase after v4.3
is released.

commit ae93c3763a294543fd790107e223023ae75cd93a
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Tue Aug 11 14:43:14 2015 +0200

    PCI: rcar: Build only on ARM
    
    The pci-rcar-gen2.c and pcie-rcar.c drivers use struct pci_sys_data, which
    only exists on ARM.  Building them on other arches, e.g., arm64/shmobile,
    causes errors like this:
    
      drivers/pci/host/pci-rcar-gen2.c: In function 'rcar_pci_cfg_base': drivers/pci/host/pci-rcar-gen2.c:112:34: error: dereferencing pointer to incomplete type
        struct rcar_pci_priv *priv = sys->private_data;
                                        ^
    Make these drivers depend on ARM unconditionally.
    
    [bhelgaas: changelog]
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index c132bdd..3745c63 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -39,7 +39,8 @@ config PCI_TEGRA
 
 config PCI_RCAR_GEN2
 	bool "Renesas R-Car Gen2 Internal PCI controller"
-	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
+	depends on ARM
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
 	  There are 3 internal PCI controllers available with a single
@@ -47,7 +48,8 @@ config PCI_RCAR_GEN2
 
 config PCI_RCAR_GEN2_PCIE
 	bool "Renesas R-Car PCIe controller"
-	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
+	depends on ARM
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
 

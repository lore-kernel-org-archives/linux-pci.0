Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50740 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbbLIQut (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Dec 2015 11:50:49 -0500
Message-ID: <56685BE5.3000909@arm.com>
Date: Wed, 09 Dec 2015 16:50:45 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: jakeo@microsoft.com, gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 4/7] PCI: Add fwnode_handle to pci_sysdata
References: <1449275767-1510-1-git-send-email-jakeo@microsoft.com> <1449275767-1510-5-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1449275767-1510-5-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/12/15 00:36, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This patch adds an fwnode_handle to struct pci_sysdata, which is
> used by the next patch in the series when trying to locate an
> IRQ domain associated with a root PCI bus.
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> ---
>  arch/x86/include/asm/pci.h | 15 +++++++++++++++
>  include/asm-generic/pci.h  |  4 ++++
>  2 files changed, 19 insertions(+)
> 

[...]

> diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
> index f24bc51..4092886 100644
> --- a/include/asm-generic/pci.h
> +++ b/include/asm-generic/pci.h
> @@ -21,4 +21,8 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>  #define PCI_DMA_BUS_IS_PHYS	(1)
>  #endif
>  
> +#ifndef pci_root_bus_fwnode
> +#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
> +#endif
> +
>  #endif /* _ASM_GENERIC_PCI_H */
> 

This breaks at least arm64 (as you can see from the reply to patch #5, 
because it does have its own asm/pci.h. Instead, how about moving this 
to linux/pci.h, just after the include of asm/pci.h? I just gave it a 
go, and it seems to work nicely (the first hunk fixes the rest of the
arm64 compile issue):

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8f3d056..c6369dd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -15,6 +15,7 @@
 #include <linux/pci-aspm.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
+#include <linux/irqdomain.h>
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index 4092886..f24bc51 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -21,8 +21,4 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 #define PCI_DMA_BUS_IS_PHYS	(1)
 #endif
 
-#ifndef pci_root_bus_fwnode
-#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
-#endif
-
 #endif /* _ASM_GENERIC_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6ae25aa..b4144228 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1517,6 +1517,10 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #include <asm/pci.h>
 
+#ifndef pci_root_bus_fwnode
+#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
+#endif
+
 /* these helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info */
 #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

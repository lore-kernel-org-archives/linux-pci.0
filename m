Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:7289 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbeDLRNn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Apr 2018 13:13:43 -0400
Date: Thu, 12 Apr 2018 10:47:10 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Alex_Gagniuc@Dellteam.com
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH 0/4] PCI/AER: Use-after-free fix
Message-ID: <20180412164709.spesry7skaa3x5hf@sbauer-Z170X-UD5>
References: <20180409220444.6632-1-keith.busch@intel.com>
 <a97b5921e5cf4855b5e76110a7984fdf@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a97b5921e5cf4855b5e76110a7984fdf@ausx13mps321.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 12, 2018 at 05:06:05PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> From: Keith Busch [mailto:keith.busch@intel.com] 
> 
> > AER error handling walks the PCI topology below a root port, saving pointers of the pci_dev structs affected by the error along the way.
> 
> Hi Keith,
> 
> I've been trying to do an ABA test to confirm that your change eliminates the use-after-free issue we've seen. The race seems to be quite elusive, so I can't reliably reproduce it. Your changes have not been forgotten; I have them staged for further testing.
> 
> Alex


If you need help triggering the race you can add a sleep/microsleep here:

aer_isr_one_error() between the find_source_device and process err device:

sbauer@sbauer-Z170X-UD5:~/nvme_code/upstream_jens/linux-block$ git diff drivers/pci/pcie/aer/aerdrv_core.c
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index a4bfea52e7d4..5ca0c07b1d05 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/kfifo.h>
+#include <linux/delay.h>
 #include "aerdrv.h"
 
 #define        PCI_EXP_AER_FLAGS       (PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
@@ -740,8 +741,10 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 
                aer_print_port_info(p_device->port, e_info);
 
-               if (find_source_device(p_device->port, e_info))
+               if (find_source_device(p_device->port, e_info)) {
+                       msleep(350);
                        aer_process_err_devices(p_device, e_info);
+               }
        }
 
        if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
@@ -759,8 +762,10 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 
                aer_print_port_info(p_device->port, e_info);
 
-               if (find_source_device(p_device->port, e_info))
+               if (find_source_device(p_device->port, e_info)) {
+                       msleep(350);
                        aer_process_err_devices(p_device, e_info);
+               }
        }
 }

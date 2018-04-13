Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:39710 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752212AbeDMOtL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2018 10:49:11 -0400
From: <Alex_Gagniuc@Dellteam.com>
To: <scott.bauer@intel.com>
CC: <keith.busch@intel.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <mr.nuke.me@gmail.com>
Subject: RE: [PATCH 0/4] PCI/AER: Use-after-free fix
Date: Fri, 13 Apr 2018 14:49:07 +0000
Message-ID: <ececc0bc7d41475e9065130cf563d46b@ausx13mps321.AMER.DELL.COM>
References: <20180409220444.6632-1-keith.busch@intel.com>
 <a97b5921e5cf4855b5e76110a7984fdf@ausx13mps321.AMER.DELL.COM>
 <20180412164709.spesry7skaa3x5hf@sbauer-Z170X-UD5>
In-Reply-To: <20180412164709.spesry7skaa3x5hf@sbauer-Z170X-UD5>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I got the cold chills when I realized you called for a delay of 350ms. It's=
 because 350ms is around the delay I've observed to be caused by FFS.
First run KASANed with the extra delay, so hopefully, I'll have more cement=
 test results by EOB today.

Alex

-----Original Message-----
From: Scott Bauer [mailto:scott.bauer@intel.com]=20
Sent: Thursday, April 12, 2018 11:47 AM
To: Gagniuc, Alexandru - Dell Team
Cc: keith.busch@intel.com; linux-pci@vger.kernel.org; bhelgaas@google.com
Subject: Re: [PATCH 0/4] PCI/AER: Use-after-free fix

On Thu, Apr 12, 2018 at 05:06:05PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> From: Keith Busch [mailto:keith.busch@intel.com]
>=20
> > AER error handling walks the PCI topology below a root port, saving poi=
nters of the pci_dev structs affected by the error along the way.
>=20
> Hi Keith,
>=20
> I've been trying to do an ABA test to confirm that your change eliminates=
 the use-after-free issue we've seen. The race seems to be quite elusive, s=
o I can't reliably reproduce it. Your changes have not been forgotten; I ha=
ve them staged for further testing.
>=20
> Alex


If you need help triggering the race you can add a sleep/microsleep here:

aer_isr_one_error() between the find_source_device and process err device:

sbauer@sbauer-Z170X-UD5:~/nvme_code/upstream_jens/linux-block$ git diff dri=
vers/pci/pcie/aer/aerdrv_core.c
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerd=
rv_core.c
index a4bfea52e7d4..5ca0c07b1d05 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/kfifo.h>
+#include <linux/delay.h>
 #include "aerdrv.h"
=20
 #define        PCI_EXP_AER_FLAGS       (PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVC=
TL_NFERE | \
@@ -740,8 +741,10 @@ static void aer_isr_one_error(struct pcie_device *p_de=
vice,
=20
                aer_print_port_info(p_device->port, e_info);
=20
-               if (find_source_device(p_device->port, e_info))
+               if (find_source_device(p_device->port, e_info)) {
+                       msleep(350);
                        aer_process_err_devices(p_device, e_info);
+               }
        }
=20
        if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) { @@ -759,8 +762,10 @@ =
static void aer_isr_one_error(struct pcie_device *p_device,
=20
                aer_print_port_info(p_device->port, e_info);
=20
-               if (find_source_device(p_device->port, e_info))
+               if (find_source_device(p_device->port, e_info)) {
+                       msleep(350);
                        aer_process_err_devices(p_device, e_info);
+               }
        }
 }

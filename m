Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH V2 06/23] XEN / PCI: Remove the dependence on arch x86 when PCI_MMCONFIG=y
Date: Wed, 16 Dec 2015 16:16:16 +0100
Message-Id: <1450278993-12664-7-git-send-email-tn@semihalf.com>
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In drivers/xen/pci.c, there are arch x86 dependent codes when
CONFIG_PCI_MMCONFIG is enabled, since CONFIG_PCI_MMCONFIG
depends on ACPI, so this will prevent XEN PCI running on other
architectures using ACPI with PCI_MMCONFIG enabled (such as ARM64).

Fortunatly, it can be sloved in a simple way. In drivers/xen/pci.c,
the only x86 dependent code is if ((pci_probe & PCI_PROBE_MMCONF) == 0),
and it's defined in asm/pci_x86.h, the code means that
if the PCI resource is not probed in PCI_PROBE_MMCONF way, just
ingnore the xen mcfg init. Actually this is duplicate, because
if PCI resource is not probed in PCI_PROBE_MMCONF way, the
pci_mmconfig_list will be empty, and the if (list_empty())
after it will do the same job.

So just remove the arch related code and the head file, this
will be no functional change for x86, and also makes xen/pci.c
usable for other architectures.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/xen/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 6785ebb..9a8dbe3 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -28,9 +28,6 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 #include "../pci/pci.h"
-#ifdef CONFIG_PCI_MMCONFIG
-#include <asm/pci_x86.h>
-#endif
 
 static bool __read_mostly pci_seg_supported = true;
 
@@ -222,9 +219,6 @@ static int __init xen_mcfg_late(void)
 	if (!xen_initial_domain())
 		return 0;
 
-	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
-		return 0;
-
 	if (list_empty(&pci_mmcfg_list))
 		return 0;
 
-- 
1.9.1


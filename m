Return-Path: <SRS0=SQ4s=BM=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=SQ4s=BM=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [RFC PATCH] PCI/portdrv: Fix switch devctrl error report enable.
Date: Fri, 13 Oct 2017 17:02:00 +0800
Message-ID: <1507885320-122365-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Current code has a bug, switch upstream/downstream port error report
is disabled.

DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
-[0000:00]-+-00.0-[01]--
           \-08.0-[02-07]----00.0-[03-07]--+-04.0-[04]--
                                           +-05.0-[05]--
                                           +-08.0-[06]--
                                           \-09.0-[07]--
portdrv_pci.c
pcie_portdrv_probe
	--->pcie_port_device_register
		--->get_port_device_capability
			--->pci_disable_pcie_error_reporting

aerdrv.c
aer_probe
	--->aer_enable_rootport
		--->set_downstream_devices_error_reporting

But current code RP AER driver probe is before switch UP/DP portdrv probe.
This is a RFC PATCH for discussing.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/pcie/portdrv_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 313a21d..6bb89ce 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -261,7 +261,9 @@ static int get_port_device_capability(struct pci_dev *dev)
 		 * Disable AER on this port in case it's been enabled by the
 		 * BIOS (the AER service driver will enable it when necessary).
 		 */
-		pci_disable_pcie_error_reporting(dev);
+		if((pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
+		   (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
+			pci_disable_pcie_error_reporting(dev);
 	}
 	/* VC support */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VC))
-- 
1.9.1

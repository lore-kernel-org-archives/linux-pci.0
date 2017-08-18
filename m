Return-Path: <SRS0=FFZG=7U=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=FFZG=7U=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <helgaas@kernel.org>
CC: <gabriele.paoloni@huawei.com>, <linuxarm@huawei.com>,
        <liudongdong3@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] PCIe AER: report uncorrectable errors only to the functions that logged the errors
Date: Fri, 18 Aug 2017 12:02:21 +0100
Message-ID: <1503054141-80272-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Currently if an uncorrectable error is reported by an EP the AER
driver walks over all the devices connected to the upstream port
bus and in turns call the report_error_detected() callback.
If any of the devices connected to the bus does not implement
dev->driver->err_handler->error_detected() do_recovery() will fail
leaving all the bus hierarchy devices unrecovered.

However for non fatal errors the PCIe link should not be considered
compromised, therefore it makes sense to report the error only to
all the functions that logged an error.
This patch implements this new behaviour for non fatal errors.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
Changes from v1:
   - now errors are reported only to the fucntions that logged the error
     instead of all the functions in the same device.
   - the patch subject has changed to match the new implementation
---
 drivers/pci/pcie/aer/aerdrv_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index b1303b3..057465ad 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -390,7 +390,14 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		 * If the error is reported by an end point, we think this
 		 * error is related to the upstream link of the end point.
 		 */
-		pci_walk_bus(dev->bus, cb, &result_data);
+		if (state == pci_channel_io_normal)
+			/*
+			 * the error is non fatal so the bus is ok, just invoke
+			 * the callback for the function that logged the error.
+			 */
+			cb(dev, &result_data);
+		else
+			pci_walk_bus(dev->bus, cb, &result_data);
 	}
 
 	return result_data.result;
-- 
2.7.4

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36333 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdF1XWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2017 19:22:14 -0400
Received: by mail-pg0-f49.google.com with SMTP id u62so38662693pgb.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Jun 2017 16:22:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: kys@microsoft.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, devel@linuxdriverproject.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH] hv: fix msi affinity when device requests all possible CPU's
Date: Wed, 28 Jun 2017 16:22:04 -0700
Message-Id: <20170628232204.15227-1-sthemmin@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When Intel 10G (ixgbevf) is passed to a Hyper-V guest with SR-IOV,
the driver requests affinity with all possible CPU's (0-239) even
those CPU's are not online (and will never be). Because of this the device
is unable to correctly get MSI interrupt's setup.

This was caused by the change in 4.12 that converted this affinity
into all possible CPU's (0-31) but then host reports
an error since this is larger than the number of online cpu's.

Previously, this worked (up to 4.12-rc1) because only online cpu's
would be put in mask passed to the host.

This patch applies only to 4.12.
The driver in linux-next needs a a different fix because of the changes
to PCI host protocol version.

Fixes: 433fcf6b7b31 ("PCI: hv: Specify CPU_AFFINITY_ALL for MSI affinity when >= 32 CPUs")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 84936383e269..3cadfcca3ae9 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -900,10 +900,12 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	 * processors because Hyper-V only supports 64 in a guest.
 	 */
 	affinity = irq_data_get_affinity_mask(data);
+	cpumask_and(affinity, affinity, cpu_online_mask);
+
 	if (cpumask_weight(affinity) >= 32) {
 		int_pkt->int_desc.cpu_mask = CPU_AFFINITY_ALL;
 	} else {
-		for_each_cpu_and(cpu, affinity, cpu_online_mask) {
+		for_each_cpu(cpu, affinity) {
 			int_pkt->int_desc.cpu_mask |=
 				(1ULL << vmbus_cpu_number_to_vp_number(cpu));
 		}
-- 
2.11.0

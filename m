Return-Path: <SRS0=ccIc=3B=linuxonhyperv.com=kys@kernel.org>
Return-Path: <SRS0=ccIc=3B=linuxonhyperv.com=kys@kernel.org>
From: kys@exchange.microsoft.com
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/2] pci-hyperv: Fix a bug in specifying CPU affinity
Date: Fri, 24 Mar 2017 11:07:21 -0700
Message-Id: <1490378842-26950-2-git-send-email-kys@exchange.microsoft.com>
In-Reply-To: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
References: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
List-ID: <linux-pci.vger.kernel.org>

From: K. Y. Srinivasan <kys@microsoft.com>

When we have 32 or more CPUs in the affinity mask, we should
use a special constant to specify that to the host. Fix this issue.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/host/pci-hyperv.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index ada9856..32a16fb 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -72,6 +72,7 @@ enum {
 	PCI_PROTOCOL_VERSION_CURRENT = PCI_PROTOCOL_VERSION_1_1
 };
 
+#define CPU_AFFINITY_ALL	-1ULL
 #define PCI_CONFIG_MMIO_LENGTH	0x2000
 #define CFG_PAGE_OFFSET 0x1000
 #define CFG_PAGE_SIZE (PCI_CONFIG_MMIO_LENGTH - CFG_PAGE_OFFSET)
@@ -897,9 +898,13 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	 * processors because Hyper-V only supports 64 in a guest.
 	 */
 	affinity = irq_data_get_affinity_mask(data);
-	for_each_cpu_and(cpu, affinity, cpu_online_mask) {
-		int_pkt->int_desc.cpu_mask |=
-			(1ULL << vmbus_cpu_number_to_vp_number(cpu));
+	if (cpumask_weight(affinity) >= 32) {
+		int_pkt->int_desc.cpu_mask = CPU_AFFINITY_ALL;
+	} else {
+		for_each_cpu_and(cpu, affinity, cpu_online_mask) {
+			int_pkt->int_desc.cpu_mask |=
+				(1ULL << vmbus_cpu_number_to_vp_number(cpu));
+		}
 	}
 
 	ret = vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt,
-- 
1.7.1

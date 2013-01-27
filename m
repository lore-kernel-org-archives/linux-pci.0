Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31179 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3A0TYZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 14:24:25 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
	linux-altix@sgi.com
Subject: [PATCH v3 14/22] PCI, ia64: Kill pci_find_next_bus
Date: Sun, 27 Jan 2013 11:23:41 -0800
Message-Id: <1359314629-18651-15-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace that with hotplug-safe version iteration.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Cc: linux-altix@sgi.com
---
 arch/ia64/hp/common/sba_iommu.c |    7 ++++---
 arch/ia64/sn/kernel/io_common.c |    5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index bcda5b2..0f27a37 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -2155,9 +2155,10 @@ sba_init(void)
 
 #ifdef CONFIG_PCI
 	{
-		struct pci_bus *b = NULL;
-		while ((b = pci_find_next_bus(b)) != NULL)
-			sba_connect_bus(b);
+		struct pci_host_bridge *host_bridge = NULL;
+
+		for_each_pci_host_bridge(host_bridge)
+			sba_connect_bus(host_bridge->bus);
 	}
 #endif
 
diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
index 8630875..131938b 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -516,6 +516,7 @@ arch_initcall(sn_io_early_init);
 int __init
 sn_io_late_init(void)
 {
+	struct pci_host_bridge *host_bridge = NULL;
 	struct pci_bus *bus;
 	struct pcibus_bussoft *bussoft;
 	cnodeid_t cnode;
@@ -530,8 +531,8 @@ sn_io_late_init(void)
 	 * PIC, TIOCP, TIOCE (TIOCA does it during bus fixup using
 	 * info from the PROM).
 	 */
-	bus = NULL;
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
+	for_each_pci_host_bridge(host_bridge) {
+		bus = host_bridge->bus;
 		bussoft = SN_PCIBUS_BUSSOFT(bus);
 		nasid = NASID_GET(bussoft->bs_base);
 		cnode = nasid_to_cnodeid(nasid);
-- 
1.7.10.4


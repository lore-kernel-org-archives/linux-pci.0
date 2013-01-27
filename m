Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:38258 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab3A0TYS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 14:24:18 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	x86@kernel.org
Subject: [PATCH v3 09/22] PCI, x86: Kill pci_find_next_bus in pcibios_scan_root
Date: Sun, 27 Jan 2013 11:23:36 -0800
Message-Id: <1359314629-18651-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace that with hotplug-safe version for iteration.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/pci/common.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 505731b..b4b4032 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -447,11 +447,14 @@ void __init dmi_check_pciprobe(void)
 
 struct pci_bus * __devinit pcibios_scan_root(int busnum)
 {
-	struct pci_bus *bus = NULL;
+	struct pci_host_bridge *host_bridge = NULL;
+	struct pci_bus *bus;
 
-	while ((bus = pci_find_next_bus(bus)) != NULL) {
-		if (bus->number == busnum) {
+	for_each_pci_host_bridge(host_bridge) {
+		if (host_bridge->bus->number == busnum) {
 			/* Already scanned */
+			bus = host_bridge->bus;
+			put_device(&host_bridge->dev);
 			return bus;
 		}
 	}
-- 
1.7.10.4


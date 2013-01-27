Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31233 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3A0TYg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 14:24:36 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH v3 15/22] PCI, alpha: Kill pci_root_buses
Date: Sun, 27 Jan 2013 11:23:42 -0800
Message-Id: <1359314629-18651-16-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace that with hotplug-safe version iteration.

-v2: Fix typo that is found by Fengguang

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index ef75714..6c55e16 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -305,10 +305,10 @@ pcibios_claim_one_bus(struct pci_bus *b)
 static void __init
 pcibios_claim_console_setup(void)
 {
-	struct pci_bus *b;
+	struct pci_host_bridge *host_bridge = NULL;
 
-	list_for_each_entry(b, &pci_root_buses, node)
-		pcibios_claim_one_bus(b);
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_claim_one_bus(host_bridge->bus);
 }
 
 void __init
-- 
1.7.10.4


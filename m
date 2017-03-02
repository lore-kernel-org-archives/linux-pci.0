Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17022 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751683AbdCCCFt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Mar 2017 21:05:49 -0500
From: Andi Kleen <andi@firstfloor.org>
To: bhelgaas@google.com
Cc: x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 4/4] perf/x86/intel/uncore: Enable forced mmconfig for Intel uncore
Date: Thu,  2 Mar 2017 15:21:04 -0800
Message-Id: <20170302232104.10136-4-andi@firstfloor.org>
In-Reply-To: <20170302232104.10136-1-andi@firstfloor.org>
References: <20170302232104.10136-1-andi@firstfloor.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Andi Kleen <ak@linux.intel.com>

On Intel systems some uncore counters are located in PCI config space.
On 4S systems with many uncore events being sampled at a high frequency
we can see significant overhead from the type 1 accesses: both
from the IO port accesses and also from lock contention on the locks
protection the IO port.

This patch uses the pci_bus_force_mmconfig() interface earlier
to force lockless MMCONFIG for the bus the uncore devices are
residing on, which significantly lowers overhead. These
busses only contain Intel on chip devices which support mmconfig.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 758c1aa5009d..4cc2ee3d0165 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -875,6 +875,12 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	struct intel_uncore_box *box;
 	int phys_id, pkg, ret;
 
+	/*
+	 * Force MMCONFIG for all accesses, as we can otherwise
+	 * have significant lock contention on the type1 IO port spinlock.
+	 */
+	pci_bus_force_mmconfig(pdev->bus);
+
 	phys_id = uncore_pcibus_to_physid(pdev->bus);
 	if (phys_id < 0)
 		return -ENODEV;
-- 
2.9.3

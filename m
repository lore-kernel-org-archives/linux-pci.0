Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B839BFF4;
	Wed, 29 Apr 2026 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465623; cv=none; b=uhWCyxiFpDz2fIMooXxlhz7sd1u5DMHv/RSTqiTfcYxYArOLVxLAA7E2wu6uZHcQUTDxsxEKi1msDSTxD8WCQr0GNgxD0QaKKUt2CBvFewSUw56/3CyS8bwNLQkwfJq9to70IWDsoktRG3fl5tyIhybYAEQRVnMQt/Lgynnyh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465623; c=relaxed/simple;
	bh=ymmlvQuMfjumemqUjGxrBNk55P+HxOLWdjtwtwvgzpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmuPuJOEdtl2wFCkt8//QNp9UIezMBEhbFdle9uxwXX9X2LEyxHnJ+Es0KK5RDL7aKiQDn7az7oDWO1GvwqJiZvKF3CodcZfhwl6TkBZ1SlITzAjsImxWasQEEti8667OFesoyDuLy2cYs2mpmddFnmXOqfPU3rhZSbj/ZIgUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmCXJCJk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmCXJCJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465622; x=1809001622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymmlvQuMfjumemqUjGxrBNk55P+HxOLWdjtwtwvgzpE=;
  b=FmCXJCJkASqDk6bLxh7n5s54XmXDrdDRUB811yCRMajQ0KL9RaPJPTCA
   KkSaEc5eEVWiyJsu8DEH0wh7wImLoDM+uSfzeKOKtXFSyhWzyc13e+vMo
   9F2eUMnTtGjPYSyE6IN/zJIzXbcueRj0Yjkth+ILcyzOtLo4SvFi6D8mJ
   L9WpSFDYQnCF58bfEKqfNa2gZ2Y4fRJUUNqLgmO7HFwC+0iNmf0C70Hsa
   VaJ7oJhN6vxOCD6Htq+6XxOpVJPAHNMFrDqtO9f4nE+h7bL9LXomxP9PL
   w2ApX9K/NrKbFJ9/i02Aj2s+saDO/NFKdIWHHKqZuWCkO3NXhCf8ep2lA
   Q==;
X-CSE-ConnectionGUID: IeFJgWgFQDS1OP7Ba02kVw==
X-CSE-MsgGUID: Xnc9dlsgRoSS8WsnsparVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77557715"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="77557715"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:01 -0700
X-CSE-ConnectionGUID: fNI/Y3zKR6KPwPYP7o+w8w==
X-CSE-MsgGUID: JPHHKUAmRmO30ZkLOgV5fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229669749"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/11] PCI: Consolidate add_list (aka realloc_head) empty sanity checks
Date: Wed, 29 Apr 2026 15:26:09 +0300
Message-Id: <20260429122617.7324-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Callers of __pci_bridge_assign_resources() and
__pci_bus_assign_resources() perform
WARN_ON_ONCE(list_empty(add_list))) checks to sanity check that all
optional sizes were processed (and removed) from the list. The empty
list sanity check is duplicated code so the more appropriate place for
it would be inside the called function.

Placing the empty list check into __pci_bus_assign_resources() also
ensures all callsites do perform the sanity check which currently is
not the case when being called from enable_slot(). This inconsistency
was noted by Sashiko though only inside its in depth log but not
flagged as a real problem, possibly because this is only a sanity check
that should never fire. Nonetheless, this sanity check has been very
useful to catch problems early in the past so it's good to do it
consistenty everywhere.

As __pci_bus_assign_resources() is recursive function, it needs to be
renamed to __pci_bus_assign_resources_one() to only perform the empty
list check at the end of processing the entire hierarchy in
__pci_bus_assign_resources().

Suggested-by: sashiko.dev # Sanity check missing from enable_slot()
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3765693e95f0..1e0e28efe8b8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1501,9 +1501,9 @@ static void pdev_assign_fixed_resources(struct pci_dev *dev)
 	}
 }
 
-void __pci_bus_assign_resources(const struct pci_bus *bus,
-				struct list_head *add_list,
-				struct list_head *fail_head)
+static void __pci_bus_assign_resources_one(const struct pci_bus *bus,
+					   struct list_head *add_list,
+					   struct list_head *fail_head)
 {
 	struct pci_bus *b;
 	struct pci_dev *dev;
@@ -1517,7 +1517,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 		if (!b)
 			continue;
 
-		__pci_bus_assign_resources(b, add_list, fail_head);
+		__pci_bus_assign_resources_one(b, add_list, fail_head);
 
 		switch (dev->hdr_type) {
 		case PCI_HEADER_TYPE_BRIDGE:
@@ -1537,6 +1537,16 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 	}
 }
 
+void __pci_bus_assign_resources(const struct pci_bus *bus,
+				struct list_head *add_list,
+				struct list_head *fail_head)
+{
+	__pci_bus_assign_resources_one(bus, add_list, fail_head);
+
+	if (WARN_ON_ONCE(add_list && !list_empty(add_list)))
+		pci_dev_res_free_list(add_list);
+}
+
 void pci_bus_assign_resources(const struct pci_bus *bus)
 {
 	__pci_bus_assign_resources(bus, NULL, NULL);
@@ -1641,6 +1651,9 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 			 pci_domain_nr(b), b->number);
 		break;
 	}
+
+	if (WARN_ON_ONCE(add_list && !list_empty(add_list)))
+		pci_dev_res_free_list(add_list);
 }
 
 static void pci_bridge_release_resources(struct pci_bus *bus,
@@ -2205,8 +2218,6 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 
 		/* Depth last, allocate resources and update the hardware. */
 		__pci_bus_assign_resources(bus, add_list, &fail_head);
-		if (WARN_ON_ONCE(add_list && !list_empty(add_list)))
-			pci_dev_res_free_list(add_list);
 		tried_times++;
 
 		/* Any device complain? */
@@ -2268,8 +2279,6 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 		pci_bridge_distribute_available_resources(bridge, &add_list);
 
 		__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
-		if (WARN_ON_ONCE(!list_empty(&add_list)))
-			pci_dev_res_free_list(&add_list);
 		tried_times++;
 
 		if (list_empty(&fail_head))
@@ -2339,8 +2348,6 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 
 	__pci_bus_size_bridges(bridge->subordinate, &add_list);
 	__pci_bridge_assign_resources(bridge, &add_list, &failed);
-	if (WARN_ON_ONCE(!list_empty(&add_list)))
-		pci_dev_res_free_list(&add_list);
 
 	if (!list_empty(&failed)) {
 		if (pci_required_resource_failed(&failed, type))
@@ -2473,7 +2480,5 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 			__pci_bus_size_bridges(dev->subordinate, &add_list);
 	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
-	if (WARN_ON_ONCE(!list_empty(&add_list)))
-		pci_dev_res_free_list(&add_list);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
-- 
2.39.5


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20939C002;
	Wed, 29 Apr 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465613; cv=none; b=XSItwaTuoqKqFKb7G3ZnvA8j2cIxgt82c13qukBoS/b1eS1nB+LoTiVsk1Y2AjOckIANJO736PT/UWT/CYk9aCH3eaeQSwMyvcjUIrc0QHTfFXT0YdSgdjG6oInqqy+ttsrw3KCJ0TDNCaiHCuzDJxwOVZ3QZxmBO4VChi30vqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465613; c=relaxed/simple;
	bh=NlSw3DKYOjHOeHYh/0go2vSw53u8u6nznavTwXNw3m0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgHpQRXnFQFwROPeSDCCpszSSpxvnvGm1epKYICuZx1SmmM+fn52fpf3ZeP9QNeQN1zV4LrnRYN+9vrCKw4/aqmGgY+IqRN40n0VaZQQ/PAwvA8mijgRN0CkD4MlULt278Rgyb8cTkxTVU8Twkpl3d7CinJye2paJK0JV+mBe/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8Dmh9QN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8Dmh9QN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465611; x=1809001611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NlSw3DKYOjHOeHYh/0go2vSw53u8u6nznavTwXNw3m0=;
  b=T8Dmh9QN7vTMXo+7Abx8weaCfVRCUWL7gMRn9Jvzs7MMSWr98+uB2yB6
   IEIgKCNMs4QiU2KM3JhjxWgSR+F+yIzSU68iePkk9/3IdJKmxrDDOQ4Iz
   /E7hPLG87GHDBf7X3O25ElxfoszCtBzSFOFMt5KK51ZoeRxWYFGqDCpew
   QOX1QPFWvVv4VFBnDdcwv7rJ+Q+9oyeLWbAGsd7YYBu9fDToSYE8+U7Bh
   hvTOC5ByVcKm4JjzYXSrsV+gPCBkZAC+9v24t9qefed0TLMsZNFXog3v1
   USI23fBRVdBnumMLRWZy56ErLdMHnFvn33duudkuK8b2z21RSsaWsfR0J
   g==;
X-CSE-ConnectionGUID: N22MFhwsQG+DbcgUpkMQiQ==
X-CSE-MsgGUID: AKDB1Du/RmGXknErETuYew==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77557694"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="77557694"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:51 -0700
X-CSE-ConnectionGUID: rb2ZCEBZRhq5Nh1Tx+QRvA==
X-CSE-MsgGUID: XJYr1JnTROCPcbw42Lz3bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229669702"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:47 -0700
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
Subject: [PATCH 02/11] PCI: Rename added to add_list
Date: Wed, 29 Apr 2026 15:26:08 +0300
Message-Id: <20260429122617.7324-3-ilpo.jarvinen@linux.intel.com>
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

The resource fitting algorithm uses different names from the list
holding the optional sizes: added, add_head, add_list, and
realloc_head. 'add_list' sounds the most natural and some of the
related variables also use 'add' such as 'add_size'.

To reduce variation, rename 'added' and 'add_head' to 'add_list'.
Also rename some 'realloc_head' cases selectively to 'add_list'.

While it would be nice to rename every 'realloc_head' to 'add_list' for
consistency, it might create a backport headache with all to work going
into this algorithm that may need to be eventually backported. Thus,
it's better to leave 'realloc_head' as is for now.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h       |  2 +-
 drivers/pci/setup-bus.c | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..4fcf5a25ad9e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -515,7 +515,7 @@ int pci_dev_res_add_to_list(struct list_head *head, struct pci_dev *dev,
 void __pci_bus_size_bridges(struct pci_bus *bus,
 			struct list_head *realloc_head);
 void __pci_bus_assign_resources(const struct pci_bus *bus,
-				struct list_head *realloc_head,
+				struct list_head *add_list,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 void pci_walk_bus_locked(struct pci_bus *top,
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4cf120ebe5ad..3765693e95f0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -756,13 +756,13 @@ static void __assign_resources_sorted(struct list_head *head,
 }
 
 static void pdev_assign_resources_sorted(struct pci_dev *dev,
-					 struct list_head *add_head,
+					 struct list_head *add_list,
 					 struct list_head *fail_head)
 {
 	LIST_HEAD(head);
 
 	pdev_sort_resources(dev, &head);
-	__assign_resources_sorted(&head, add_head, fail_head);
+	__assign_resources_sorted(&head, add_list, fail_head);
 
 }
 
@@ -1502,13 +1502,13 @@ static void pdev_assign_fixed_resources(struct pci_dev *dev)
 }
 
 void __pci_bus_assign_resources(const struct pci_bus *bus,
-				struct list_head *realloc_head,
+				struct list_head *add_list,
 				struct list_head *fail_head)
 {
 	struct pci_bus *b;
 	struct pci_dev *dev;
 
-	pbus_assign_resources_sorted(bus, realloc_head, fail_head);
+	pbus_assign_resources_sorted(bus, add_list, fail_head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pdev_assign_fixed_resources(dev);
@@ -1517,7 +1517,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 		if (!b)
 			continue;
 
-		__pci_bus_assign_resources(b, realloc_head, fail_head);
+		__pci_bus_assign_resources(b, add_list, fail_head);
 
 		switch (dev->hdr_type) {
 		case PCI_HEADER_TYPE_BRIDGE:
@@ -1613,19 +1613,19 @@ void pci_bus_claim_resources(struct pci_bus *b)
 EXPORT_SYMBOL(pci_bus_claim_resources);
 
 static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
-					  struct list_head *add_head,
+					  struct list_head *add_list,
 					  struct list_head *fail_head)
 {
 	struct pci_bus *b;
 
 	pdev_assign_resources_sorted((struct pci_dev *)bridge,
-					 add_head, fail_head);
+				     add_list, fail_head);
 
 	b = bridge->subordinate;
 	if (!b)
 		return;
 
-	__pci_bus_assign_resources(b, add_head, fail_head);
+	__pci_bus_assign_resources(b, add_list, fail_head);
 
 	switch (bridge->class >> 8) {
 	case PCI_CLASS_BRIDGE_PCI:
@@ -2303,7 +2303,7 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 	unsigned long type = res->flags;
 	struct pci_dev_resource *dev_res;
 	struct pci_dev *bridge = NULL;
-	LIST_HEAD(added);
+	LIST_HEAD(add_list);
 	LIST_HEAD(failed);
 	unsigned int i;
 	int ret = 0;
@@ -2337,10 +2337,10 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 	if (!bridge)
 		return -ENOENT;
 
-	__pci_bus_size_bridges(bridge->subordinate, &added);
-	__pci_bridge_assign_resources(bridge, &added, &failed);
-	if (WARN_ON_ONCE(!list_empty(&added)))
-		pci_dev_res_free_list(&added);
+	__pci_bus_size_bridges(bridge->subordinate, &add_list);
+	__pci_bridge_assign_resources(bridge, &add_list, &failed);
+	if (WARN_ON_ONCE(!list_empty(&add_list)))
+		pci_dev_res_free_list(&add_list);
 
 	if (!list_empty(&failed)) {
 		if (pci_required_resource_failed(&failed, type))
-- 
2.39.5


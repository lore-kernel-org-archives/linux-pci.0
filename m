Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842698;
	b=ER2DcYINQH1s8W/Sr/IeHim5Y53HTPT2KigilmuAP82D3wgkKzkpogoFcsnutm57txUa
	 DPhnS9jtG0V30B0HEefzopXgANNLEySHO58gKTGo+pMvFrhpggPZx5/goVK5svhhVnks0
	 L3coBqwb+HlkFPH/E1mrK+Kxe/OOiNhKOeeN4vYY1ab6M+F658QyEuwBHQ0TUu1n1S6y+
	 oDwZ8dnHf09fUsO5KLJFpgex6krXuSqUp7+W6Vrw3tjfCsvaOApGcs72yKKrKM8uyePSO
	 T45CqCZrf6CEjQerfxY+S3MSS04Y0QBYHO9YvOyoRjnE0KQWNABPBDRxxJYPLwtHdig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842698;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0/Ee3NCfb18sClwdBMuvAHPYXFi8wLgEs4914Y4P8LE=;
	b=ODsb6HHZMjKcQB6m/jrgUUXe9mRNuVI+KESW1kxexXrdFcri4+MEt8xP7d8fjrgTCf24
	 qfoac9itrJsq1TDIw6GdROYz8d7nhP1GhqY5+XAx41KSbnx1AOqSCi2H0G/5DiC1io27d
	 XO9uzeuJhJ8OyivsXlCwt3wUR4th8Jr4ggkgvOob+AigqzqHtqW6krVKUvqoBnEdTjCvE
	 qDiskMzPUBqPtEAqXxkFFB5nbkAPWSMsYCvc54e/NUfi6GPe3P3WdCJdrIiKQQiFnRQHf
	 svzMTq+EvmkbbRNRz23jGFAQqZ1j8A56rhH2ctpFP23cWh6pfJ3ttO07I5KbkrjDd9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AsTwXn4Z;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B036606A329;
	Mon, 16 Nov 2026 15:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B036606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AsTwXn4Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842699; x=1826378699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YC6Wc/uUi7zuMjAkV8L/3Qvhl8ox4DA4sGYD80FSI0A=;
  b=AsTwXn4Zc3Qt9GF3jKFlSDCQMI++ypEWzEig+dS7iPmKDa4juWnyo0oh
   CeZqQy7CXHiWkG/+LVY1V4ALG348seJ3XcPxf1M+39IIeL5Xl/xFPIx/X
   Y7oO+SXIr1TLAKp1tbfDDGwvCK6BnDJvYvLc0RQ6LGSOzVe5c5qEjvmMx
   i4XZPrbFaSD28MAG4+hfp2u2agPmisOpdX10tDBlJUhZKKxwwwvqr/Lo3
   Lgy5i9J2neQPFD+MXV7BPTkFtvpgzlUl0Z8W4MkT2bAOGuLtWsiJi2Pny
   JjLRK3Q7fo3CEmMqanbSEzBZF7wXXjSrLDWDU0T3mmuMiigbzOjER54Lh
   g==;
X-CSE-ConnectionGUID: mOO3d7VURu6NDKg0Jw5+qQ==
X-CSE-MsgGUID: 4PUBj+0+SPyQu3MDNASW7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3455518"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3455518"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:24:59 -0800
X-CSE-ConnectionGUID: h7c37hWKRM+Ydv04adzMmQ==
X-CSE-MsgGUID: wU6bFVapSBiZipUVw7PThQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9414134"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:24:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/13] PCI: Hold pci_bus_sem across sizing and assignment entrypoints
Date: Mon, 16 Nov 2026 17:23:49 +0200
Message-ID: <20261116152403.2672-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bridge window sizing and resource assignment algorithm walks
bus->devices and insert resources of the found devices into the resource
tree in many places. In addition, its internal datastructures hold
references to devices and resource it encountered while walking.

Most entrypoints to the algorithm do not hold pci_bus_sem, and
pci_assign_unassigned_bus_resources() drops it before the assignment
phase.

pci_rescan_remove_lock is not held by all callers and cannot be taken
by callers running under device_lock().

Protect the walks by holding pci_bus_sem for read across the entire
sizing and assignment operation right at the entrypoints.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f95f217f94e6..5b2d870ca13d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1457,6 +1457,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 void pci_bus_size_bridges(struct pci_bus *bus)
 {
+	guard(rwsem_read)(&pci_bus_sem);
 	__pci_bus_size_bridges(bus, NULL);
 }
 EXPORT_SYMBOL(pci_bus_size_bridges);
@@ -1549,6 +1550,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 void pci_bus_assign_resources(const struct pci_bus *bus)
 {
+	guard(rwsem_read)(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, NULL, NULL);
 }
 EXPORT_SYMBOL(pci_bus_assign_resources);
@@ -1837,7 +1839,7 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 	if (host->preserve_config)
 		return auto_disabled;
 
-	pci_walk_bus(bus, iov_resources_unassigned, &unassigned);
+	pci_walk_bus_locked(bus, iov_resources_unassigned, &unassigned);
 	if (unassigned)
 		return auto_enabled;
 
@@ -2190,6 +2192,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	int pci_try_num = 1;
 	enum enable_type enable_local;
 
+	guard(rwsem_read)(&pci_bus_sem);
+
 	/* Don't realloc if asked to do so */
 	enable_local = pci_realloc_detect(bus, pci_realloc_enable);
 	if (pci_realloc_enabled(enable_local)) {
@@ -2258,14 +2262,15 @@ void pci_assign_unassigned_resources(void)
 	}
 }
 
-void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
+static void pci_bridge_size_and_assign_resources(struct pci_dev *bridge)
 {
 	struct pci_bus *parent = bridge->subordinate;
 	/* List of resources that want additional resources */
 	LIST_HEAD(add_list);
 	int tried_times = 0;
 	LIST_HEAD(fail_head);
-	int ret;
+
+	guard(rwsem_read)(&pci_bus_sem);
 
 	while (1) {
 		__pci_bus_size_bridges(parent, &add_list);
@@ -2292,6 +2297,13 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 		pci_prepare_next_assign_round(&fail_head, tried_times,
 					      whole_subtree);
 	}
+}
+
+void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
+{
+	int ret;
+
+	pci_bridge_size_and_assign_resources(bridge);
 
 	ret = pci_reenable_device(bridge);
 	if (ret)
@@ -2424,7 +2436,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 			goto restore;
 	} else {
 		/* No bridge window to adjust; let the core reassign the bus. */
-		pci_bus_assign_resources(bus);
+		__pci_bus_assign_resources(bus, NULL, NULL);
 
 		list_for_each_entry(dev_res, &saved, list) {
 			if (!resource_assigned(dev_res->res)) {
@@ -2483,18 +2495,18 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 	/* List of resources that want additional resources */
 	LIST_HEAD(add_list);
 
-	down_read(&pci_bus_sem);
+	guard(rwsem_read)(&pci_bus_sem);
 	for_each_pci_bridge(dev, bus)
 		if (pci_has_subordinate(dev))
 			__pci_bus_size_bridges(dev->subordinate, &add_list);
-	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
 
 void pci_bus_size_and_assign_resources(struct pci_bus *bus)
 {
-	pci_bus_size_bridges(bus);
+	guard(rwsem_read)(&pci_bus_sem);
+	__pci_bus_size_bridges(bus, NULL);
 	__pci_bus_assign_resources(bus, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_bus_size_and_assign_resources);
-- 
2.47.3


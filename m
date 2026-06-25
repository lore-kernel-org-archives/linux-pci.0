Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291B3BE633
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367680; cv=none; b=lmBpLu1U3z5BbL5LpLQNLNnUQqIlGmJQ4V5ASt5TJlSFf57C1edjjYafpA6KgnaDYIx61dvHSt7fDMUh8JnW3AEZ7kULziM7C/bcgATtj3BWQFmaPDhtvOkufDTZrY7iJd6YHmY1iSXL/NttbauX+4xonOGzL+h/MJ8zVWMqld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367680; c=relaxed/simple;
	bh=WvOm1wB44N27wohGxJmXA5uNS1mFdko+yOz1BnzEKh0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCfDI4o9+S+wbRrN1eZ6W/fo5cYSTYMv+VW5vlNf3M71tIETJMVuTQt71WBvm5wYPmr9N66oNBssM5R4vyLA2qYwI78brjia7VG1RH19wsDiSEgPDYfsYS7iQW4bDnujErtMn0uGpDW00lh1P9kBfjOFbMeD3ma0fCTZ5D7AUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WteR3ms+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WteR3ms+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367679; x=1813903679;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WvOm1wB44N27wohGxJmXA5uNS1mFdko+yOz1BnzEKh0=;
  b=WteR3ms+MbPXni2xHQX8HKN86NWMIpJ1B6jZZwDv8yfZcNJCV5uMtx1+
   JG8R2BlLBHCoBYHxb+3fsCZREhO4xdYPVcpL4bxZgGwvPT/rR7D45yy2s
   HIxJcIhOmHe/GGxdv5b7ovjWpRKl7l4iBRGgAVs5p19XAB+nSGvBI2iwC
   cj9gRGf7k89kc6JBSK5G7z99uA5J8MvVF1djiSihNFrQ8AokY0L0G9tJy
   ghPq7Y5Ca7hJebaRL63NJXA6Q0YuuPNqDT2PSGmbtKORpcfMkJDK3XlT6
   xhLlnAtbzKLACVjXx0WgDOvcNYj5UD/TXJshnY2Mikg9Klgd3nsasKkD2
   A==;
X-CSE-ConnectionGUID: CeZBOXhvR66jYW5zWoeyoQ==
X-CSE-MsgGUID: ELMJfxYpTti0u1Qc646miw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83021831"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83021831"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:59 -0700
X-CSE-ConnectionGUID: tcMtQQXbRfOZr5AB5TuE2g==
X-CSE-MsgGUID: 1GI64uUfRMuJGRvQzMxX4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="250725463"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:57 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v5 4/8] PCI: vmd: Add vmd_create_bus()
Date: Thu, 25 Jun 2026 08:29:33 +0000
Message-ID: <20260625082940.1290740-5-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the VMD bus initialization code to a new helper vmd_create_bus().
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 57 ++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 443a0cefb7f7..c0a953df5f23 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -825,6 +825,37 @@ static void vmd_configure_membar1_membar2(struct vmd_dev *vmd,
 	vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);
 }
 
+static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
+			  resource_size_t *offset)
+{
+	LIST_HEAD(resources);
+
+	pci_add_resource(&resources, &vmd->resources[0]);
+	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
+	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
+
+	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
+				       &vmd_ops, sd, &resources);
+	if (!vmd->bus) {
+		pci_bus_release_emul_domain_nr(sd->domain);
+		pci_free_resource_list(&resources);
+		vmd_remove_irq_domain(vmd);
+		return -ENODEV;
+	}
+
+	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
+				   to_pci_host_bridge(vmd->bus->bridge));
+
+	vmd_attach_resources(vmd);
+	if (vmd->irq_domain)
+		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+	else
+		dev_set_msi_domain(&vmd->bus->dev,
+				   dev_get_msi_domain(&vmd->dev->dev));
+
+	return 0;
+}
+
 static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 {
 	struct pci_bus *child;
@@ -876,7 +907,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	int ret;
@@ -950,10 +980,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		vmd_set_msi_remapping(vmd, false);
 	}
 
-	pci_add_resource(&resources, &vmd->resources[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
-
 	sd->vmd_dev = vmd->dev;
 
 	/*
@@ -968,25 +994,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
-				       &vmd_ops, sd, &resources);
-	if (!vmd->bus) {
-		pci_bus_release_emul_domain_nr(sd->domain);
-		pci_free_resource_list(&resources);
-		vmd_remove_irq_domain(vmd);
-		return -ENODEV;
+	ret = vmd_create_bus(vmd, sd, offset);
+	if (ret) {
+		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
+		return ret;
 	}
 
-	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-				   to_pci_host_bridge(vmd->bus->bridge));
-
-	vmd_attach_resources(vmd);
-	if (vmd->irq_domain)
-		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
-	else
-		dev_set_msi_domain(&vmd->bus->dev,
-				   dev_get_msi_domain(&vmd->dev->dev));
-
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 
-- 
2.43.0


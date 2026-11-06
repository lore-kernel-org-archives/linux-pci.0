Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981771;
	b=1wRZTKzyGWL9k9vHPfsprAsv1Y7ZVF8JTthenV0fASjTcW0v4McEtPXL5bRTYzF+NRj6
	 DMMygCe/DwvsayBbsfxBj7nYRwybNTRLw13Sst6cJKb08Sh74/LVncQgDZouuuRKfi5gJ
	 DwGhJa4XXiRGQ8l24PDc7lQ/z3ipGEO3n6xO5EHzeOlF9zTlgA9J69/acaj1FKJZSe/0X
	 ZBrpmho3fwr/0HOG/qUSTUms4wdKSXf4uiwP/j2x63lyGKRwJzQcaChLIJv5qfaL1l8zp
	 KsnOFC3zMkaEVE4RdLuP9nPWXKwW5LuR+ZaATrLQinnZ7qUeBVdYpSH0a7sbSl0OjqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981771;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GNmj72H1QQvGuZswxUhTb8isho/r5RIIzcdIydvbLOc=;
	b=g/URtb3XdAmwOKWTQWA6t/0rbswexaBRfD0i0n5rOC0UJm9PiOsm9bbctVwWfh52yH+C
	 Q8eQa6dn5tMeZXdC9JCpPt0qLT5XzcVhmogrtqI0VURzwJ/Bz8KIlSX3zyGp+s4Ur7yVt
	 hjr0mUgQNATH54wzu5+is8GvBvpkDBLU2HNcT2HOc5nhQieH6jIQ6r7iWjDAP+rGsLIj1
	 McHqduNBhBs0e870HKO8IaAbvliu73AXtgLAqQ0SOv5rX0i9vJ28HogrPamKCHnFVqm56
	 xQ5AcnhYdvjenI0J/uGEGBSQU8+mh2DLaZSGSIcxWepy128ygb2ewv9YvAX5x0BT0EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YYBXwfy2;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107DD606A337;
	Fri,  6 Nov 2026 16:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 107DD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YYBXwfy2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793981771; x=1825517771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=01oPrTJdKgPDjdREDACJjlEIaBPuE6s2KCLMtJCePBU=;
  b=YYBXwfy204QIS5ytYqO1EZjHM94Pq43l/fOtSqg5fjG2PcTLhA4qNyjL
   +XVZZhqmNJ+CrDlX35kQA51sTAzSUgAg88YcE0q1uiYvtFdldCd9lmdUu
   DypTnv+4e92ZxEz3wkGnkTVSGSKKmMuK0TGM2cqlz2Vpgou+pQL7GMt9L
   JBKBCeL4ViCh+Io+EZ3lmQT8wdp9j5PJtM7PEgl4GOYN1897Z6zLEG4vE
   tQcHc/gTsRvNRWHSJut2opiGLfWM/6PFIDt0VcK/8CgsuR82xqDTRhZRN
   /xpExeMb2MW0JClfV8AfmKs/jp8c3vK359BfNJnHoHrtGLQnWot2zN77L
   Q==;
X-CSE-ConnectionGUID: F1Og5ykrRryDs0yoLo0hlw==
X-CSE-MsgGUID: s1EeDaHFT+aiiK/YrtMbZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2889314"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2889314"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:10 -0800
X-CSE-ConnectionGUID: ZQNGaNZ9RCOWswkT3JrGew==
X-CSE-MsgGUID: aO5pCN8dRv6agz4n6MWIYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7341899"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:07 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: nirmal.patel@linux.intel.com,
	bhelgaas@google.com,
	robh@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	asutosh.pathak@linux.intel.com,
	szymon.durawa@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 4/7] PCI: vmd: Add vmd_create_bus()
Date: Fri,  6 Nov 2026 18:42:52 +0000
Message-ID: <20261106184256.4130-5-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the VMD bus initialization code to a new helper vmd_create_bus().
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 63 ++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f50286ae242e..2acabe05e909 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1033,6 +1033,40 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
 	return 0;
 }
 
+static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
+			  resource_size_t *offset, bool vmd_in_guest)
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
+		pci_free_resource_list(&resources);
+		return -ENODEV;
+	}
+
+	/*
+	 * Don't copy _OSC control flags from root bridge if running in a VM, as
+	 * they don't reflect the physical root bridge capabilities.
+	 */
+	if (!vmd_in_guest)
+		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
+					   to_pci_host_bridge(vmd->bus->bridge));
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
@@ -1084,7 +1118,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	bool vmd_in_guest;
@@ -1141,10 +1174,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		vmd_set_msi_remapping(vmd, false);
 	}
 
-	pci_add_resource(&resources, &vmd->resources[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
-
 	sd->vmd_dev = vmd->dev;
 
 	/*
@@ -1159,30 +1188,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
-				       &vmd_ops, sd, &resources);
-	if (!vmd->bus) {
+	ret = vmd_create_bus(vmd, sd, offset, vmd_in_guest);
+	if (ret) {
+		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
 		pci_bus_release_emul_domain_nr(sd->domain);
-		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
-		return -ENODEV;
+		return ret;
 	}
 
-	/*
-	 * Don't copy _OSC control flags from root bridge if running in a VM, as
-	 * they don't reflect the physical root bridge capabilities.
-	 */
-	if (!vmd_in_guest)
-		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
-					 to_pci_host_bridge(vmd->bus->bridge));
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


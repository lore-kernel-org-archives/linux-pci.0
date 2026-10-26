Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039354;
	b=dE3VRVa68/A1AtGo2pBBxMFkp7nENb41l+MYsMkkbDjXR7eKch/Azjk+PsFP+wa8kzAv
	 FF+vbIiSA72L6OhNLdkfSOxOQvx33FlhLnAlqFsCY8rfVrkxVwRlLqsHOD9bcWcfcAycG
	 ji4XZfqnw09MEqWGu9VKyZ/yw043qJjHYh1u0OgDo6W6kyA3QZGbHyTYzQXxakiDR7cnB
	 Uuqim+dysnB7O9K1VhiTs6XCFvPZItpAWYM2usAApFtnJpe8xgOTfawh6WGiwwuwF7wYI
	 efv7GRTDJIKvVB4cnpduKJOgd63yYcsNMvpkS60AoQGObl344DuDCD5T4Mw/XQdn4kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039354;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z7B/dTIb8/pK8E1IQDWx96SBmYdO72XHZqvObADIF10=;
	b=WplR1mf2inkV/Rou4mT23/0VJL23+TclOP8C/0U1ehfZe5QiUGhudExVBJ6evbsFjWF+
	 xY3Npwk/XoOAVCmzsi/FuXSs/KBqTry/KXiXOfqBzYDPEcab6HK6EoJ9XKvqYo9Wbcips
	 mhPgvg7EN2/zCToHVQlK4uGYb2DgPs1JxYQTQnjZ1+sDGZUEgzbtAttwJmZBtHSy5E+ze
	 VWnGv3n0mGbml2DHcBGHiO+tB8l3NFGWnoC1+e2OZqeXGetGsIwk/Hi/RT1mQ+a6bWodo
	 bzOzLo3wgDE/i9dMo2H6CeBakCjd8sK93Hc048F+ZPWt3nI/zuYepnAA3nH99Dq3FgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TLRnqzhh;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F438606A325;
	Mon, 26 Oct 2026 18:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F438606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TLRnqzhh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039355; x=1824575355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WcnMhJTkCf1kLlzta7fUQzj02GyA2ZuLIkn9LjxCYs8=;
  b=TLRnqzhh3fuGncs8LEMPQEuBXaw8LgqHQvDaXfPng/Qg+fPLzPEr4KNi
   8iPai+R6q7V2jI19PYuvRTggHhmGgiOrMhOYvvHNGrKVTVOAm0XhmwEre
   KOULosmomxNrfIt2KlYASzyxqPqToVO5Ptq2jQZ4+TyPl+v4FLbJEJ1Mf
   o8RfXBcLDSC/6ffsT5AI12MR3GpFZ4brUvAHVm9aawLabZ/4qDMQ+Vf14
   vH4mqHlVcE/FUA/CrmhIVIpIkKoqIgaIC3e5uLNeLFjAuHIB8xUweA7vi
   1/0fN9CVzQDoHNJt6Sfdj0XcsWlaBe79UYxgN4l6tcaUY0UkHL24CGTCj
   w==;
X-CSE-ConnectionGUID: /vuIdP1aRjmob/xClwp2UA==
X-CSE-MsgGUID: aYdQQLTjQquHRhzoSgGk0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1601015"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1601015"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:15 -0700
X-CSE-ConnectionGUID: emhzhFUnTV28Seio/JA4Sg==
X-CSE-MsgGUID: tWu9riwZT7mzIqptpHjTOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4720099"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:12 -0700
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
Subject: [PATCH v9 4/7] PCI: vmd: Add vmd_create_bus()
Date: Mon, 26 Oct 2026 20:54:57 +0000
Message-ID: <20261026205502.3502574-5-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>
References: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>
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
index ed6d03656885..8b59b369f126 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -984,6 +984,40 @@ static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
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
@@ -1035,7 +1069,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	bool vmd_in_guest;
@@ -1092,10 +1125,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		vmd_set_msi_remapping(vmd, false);
 	}
 
-	pci_add_resource(&resources, &vmd->resources[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
-	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
-
 	sd->vmd_dev = vmd->dev;
 
 	/*
@@ -1110,30 +1139,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
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


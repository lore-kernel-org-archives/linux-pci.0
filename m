Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842754;
	b=xb9OCxgtDDc/zrgJ1w6K6I1iLbEWiqtTQspfoPSwPOxRKUov6YJLmBonn7F0rGUUCRZS
	 r7nJQfNjZ9qvajQZA20LtLHJYtpGDnKDwA+KcnWL9LxRCInf9gT9fAtc+bZLYD/EQP2eG
	 sNipnQEFYAf+2Mf6/yur1GHkVsgbPoh9/RIAzLRiFPy7ngh1gyC25rFOD91EQlNce5j18
	 dbloJ7Ruv5vJwKwgFB/umrU7PwhRCfrFLL+MVMMVOpxpk65WmjaIlRVcCVQvKy35NMIUx
	 2ybog5yLSmZAoZ/TSRmNMMDww/CumolaFc1vlraOmA850ZtH27QTEFcZyNqTR4okIpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842754;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=K4Mr4dOQI6FjaXja3aRp+WjigQ13Oo3MLV/Akj1RsXQ=;
	b=QTC8hvQw34Gq8iEfs5cs46cmJw43TYUj1D2Iopjrn7TyZABgxTZnb93ag/2sXOZ7q8IL
	 VR0J9g31j8FvjNteaXHXFtcEE5CkwdVmECIOlmKm41MQG0+SlJ8cCFwJc0UTzu/rSRe7d
	 /wsmrEMHqy5DSBXiqMKe5XUXLmxedTji9EBpHtDBJlN7BHmrEHZI3HDVA0gqXyDXQN1Tj
	 GEf8tbfYiYh17/+Xh7/P7FnlimfvkRnXLOSltTpNsRpay+mvhD9rkU5AIKOTSNGdkJvWh
	 6Rd1RvlALOQBJOK4oR8W9rJRnstjsc2rMHk0fqds8vqS5/ovi7lujNlM+PBTpHzpUOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VaFzPDvk;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA3606A334;
	Mon, 16 Nov 2026 15:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BDA3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VaFzPDvk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842752; x=1826378752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=psbeWQL5rZkB81k4mTNDoRo0PzupnO9y6aAPLXypTSg=;
  b=VaFzPDvkXYb3Ipx/GmW9v5jOE200WlCemM4ByPCOMRx27S57FYbglBTH
   mMHcOV35rc8d7kBGTHEsKM3Bth3cLJJnK4TVgHHvMhrbV3okh4Odm0oTb
   5Qqor+R9qTRMHUD6wKb+ryj1Atx71QEmFpVPCkXP0UnlVUQ63QohX64TH
   FrP6k7OxSZnci+gn57AAK5JGf52dOQFA1s/K/d7uzS8M3Ef+1kY9p9rtl
   V5tmMv9jKfj1LDeWdXGYJNKSL/4f6iIMyaDXhGAIxhBODYPkU/ZX3cZak
   q8S1Hyoi1MTKl2X2U50WfdNqvNrpFU9bsqOrcVaChznnWMFvT5AlcpKVj
   Q==;
X-CSE-ConnectionGUID: pQyU1NEHTxilEJVOJ+jsaA==
X-CSE-MsgGUID: 1jmSYWlrSeyP4YYKGwuNKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3614187"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3614187"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:51 -0800
X-CSE-ConnectionGUID: 6to89yRzS++9HyKyQn4bpQ==
X-CSE-MsgGUID: EvEThoghSJWZ0uxXQg0y4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9504816"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/13] PCI: hotplug: octep: Convert to pci_assign_unassigned_bus_resources()
Date: Mon, 16 Nov 2026 17:23:55 +0200
Message-ID: <20261116152403.2672-11-ilpo.jarvinen@linux.intel.com>
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

The Octeon hotplug driver scans single device and then attempts to
assign its resource using pci_bus_assign_resources(). That function
makes bridge window sizing disjoint from the assignment phase and is
going to be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources(). If no other bridges are involved,
the extra sizing should be no-op.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/octep_hp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_hp.c
index a0a7f9ccb8fa..e793fc3012fd 100644
--- a/drivers/pci/hotplug/octep_hp.c
+++ b/drivers/pci/hotplug/octep_hp.c
@@ -79,7 +79,7 @@ static void octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl,
 	/* Scan the device and add it to the bus */
 	hp_slot->hp_pdev = pci_scan_single_device(hp_ctrl->pdev->bus,
 						  hp_slot->hp_devfn);
-	pci_bus_assign_resources(hp_ctrl->pdev->bus);
+	pci_assign_unassigned_bus_resources(hp_ctrl->pdev->bus);
 	pci_bus_add_device(hp_slot->hp_pdev);
 
 	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %s\n",
-- 
2.47.3


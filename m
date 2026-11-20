Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182575;
	b=lhkkniqno/nzPjnqR6NSikioggvtKBR5U/gLcNbsTjdC4WhBVnINSE50oEcbaHv9+ptf
	 koBnDEzQFVPE4XOk20AwYyQwkmtwkmt/QekUUryZ/cibv6TSqo8CFeSDmb83l7VTDplTO
	 vBmVmabRwbC1/kqqWz2pjmjmkN/wo04eHfvBe8XHhIxEHLY3Y01VbJeuCJdI46GSO+o+I
	 Z8EiVxk8eSKGHMaP/+GvkxWssitGsK0Z3ftciF5Z2Y3qRjQv8+Xqkm8v77B7EDprpHb97
	 s0i1SAC+g7tSKUWZMh1QaX0qHu84yiuw/daKbuxCUbz8hXVB1NDwe+8l2gUQ6/vV2PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182575;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=p3BdWiQXzVaesRlq3JCs1LI6um4tlgLOWMQREIHLGas=;
	b=3n99UNPzgVxIwNoUrqCCySW229P1dPxuqE0PfkribqlkE90Vw1fAyjR2epEIPtA4GfcX
	 u0JGpH4n4CMaxy8szmLXJ6PswbBeiwe5BNXZLb6l7yzXWS9n94bstMOzod+a0m+Z7/5tE
	 vl8CrNh+qIseloYOI9AuRu9b/k2j7j2Lq+CPJvdzl5zmHFrqdq4wMwiXM4nNSvATZczH0
	 3xq3LVZKZhBpBLdgFlcZ/ET/ff0Xlr8BNbdutcmrEoszDejVUWI9/XFsT3VQACP39fM77
	 qrk3Iik1slLrwcTcZL23ci3rqFLyfv37dzw9uOS1G+F+EtSFSAsF3isD58mxlaLt4jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hp0Gc2nC;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D878606A336;
	Fri, 20 Nov 2026 13:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D878606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hp0Gc2nC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182575; x=1826718575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dCMNjcyVrm4R2RAv57l1r9Bm5WWB96E9m1eZjTLDFes=;
  b=Hp0Gc2nCoBL4xJEYOy94O6YtqK/AMWkWn7u4oVLIaf+ThsiMF4YAr+86
   VRNj9WI4kk69CH1zoTHaJbobwrMxebAiwYQARJbFWdxrdEhDHK530paki
   gBAAGZqLOPU7hWwq1IOVpRaYKvKzmOKTKgsnNQz2IWJo1cStxQ0FY++OU
   jWmAah9E88exO60XyL34VabGeESsv1IUUgPcDLR7QGypizqygODBXhGwa
   /5e2a2IxMSFQik7TKC0yOmtzdyiS1PpaBHGJvxtB0ZKRlPnsVqPvzy8K+
   unTOzK/Zvjug8WD77T9eP0EMXwU+xhZUL8LpXhFu41KUMCRxLsGKw/VyZ
   g==;
X-CSE-ConnectionGUID: 5pG0HfrISeur/2tGAEieZg==
X-CSE-MsgGUID: kUYZNf5PQiqOMk6lrh+qiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3955250"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3955250"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:35 -0800
X-CSE-ConnectionGUID: rhHRKgR5SYaAs8Dgfm3HPQ==
X-CSE-MsgGUID: l9rvHlc5SLuZndPccAnkRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10971504"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Shijith Thotton <sthotton@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 13/16] PCI: octep_hp: Convert to pci_assign_unassigned_bus_resources()
Date: Fri, 20 Nov 2026 15:47:08 +0200
Message-ID: <20261120134716.3027-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
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

The Octeon hotplug driver scans a single device and then attempts to
assign its resources using pci_bus_assign_resources(). That function
makes bridge window sizing disjoint from the assignment phase and is
going to be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources(). If no other bridges are involved,
the extra sizing should be a no-op.

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


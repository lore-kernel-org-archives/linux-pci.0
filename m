Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846035F180;
	Wed, 29 Apr 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465602; cv=none; b=BPMal6LS9qQTVt5cotgwCqg6AS68k6jruWMcA+ybUhGcz0BOGox2zn+tdhAcoTziZ602Jz6nzXjgvy1QWj9enNXVr4qJJw5ARFqBQ67jNsNI4gGQqJaFgk/ewLNWTmoIj4lo74G8hvdl6yEbT/mJ7vGzFzQMXPFWfwXYPhjq6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465602; c=relaxed/simple;
	bh=ZcnbBrCLet6KhQv9ffMklrkXZtBqvBKwCzYgPyMPV4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fo2zHozsDWBBRBcS8hg5bLHd675ufZAiu41zt3s3mnE04bJYn3Iw0F/BDmIPyqHfLv7XufTeniVxoCMkeYWk3P4Kg/+SKd3cBfE9T5d+WsZbnz0ZvBQU6f2Dp8rY2cCfPPLJ6cINjma+cr9NS8DqjR/StCqQK55ruhRFLE0vxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFqSbIVz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFqSbIVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465600; x=1809001600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZcnbBrCLet6KhQv9ffMklrkXZtBqvBKwCzYgPyMPV4M=;
  b=BFqSbIVzN8SWsagTP5Sr2jZ1H+R6Yy8EWcFbd3lpTnShl5mkznn3wZdS
   9EAPDenhGY+x8N6izGQvNtTLerSp2XCJAJR6hrVzWP+5jXhYakXyzIctD
   WFU6JCosidbsC015T92FhMdMbdqZRkQ8l0gqCqnaqHDwm1jkDxa6VLbLA
   v7Yo/DjZDW39FJ77pthBuKqCh2qwZqmDvte9JIKhLw9DB+zv/uv3BOGX2
   g0BfDZHuJsMdi15tZEUtMtIpQhznOfChzXltsNB6z/ivVqnPHxVVszHoe
   XHVHt+NffWznio/nRxtpCFb8xCtHjmdyfMBStuEfgkGTPorH1ZwrMmJMY
   g==;
X-CSE-ConnectionGUID: S7wpNlApSHKe74AafvwF5g==
X-CSE-MsgGUID: 0a3BNc2cRnOKWU08G35V/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77557668"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="77557668"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:40 -0700
X-CSE-ConnectionGUID: eJ2+zU6sTeuUgdPAP8eYLg==
X-CSE-MsgGUID: H7blClL+SSOTRT9AmhNfxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229669679"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:26:36 -0700
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
Subject: [PATCH 01/11] PCI: Log all resource claims
Date: Wed, 29 Apr 2026 15:26:07 +0300
Message-Id: <20260429122617.7324-2-ilpo.jarvinen@linux.intel.com>
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

There are two ways to graft resource into resource tree in PCI,
pci_assign_resource() and pci_claim_resource(). Only the former logs
the action which complicated troubleshooting the cases where resources
are assigned by pci_claim_resource() which mostly assigns the addresses
inherited from the FW.

Add logging into pci_claim_resource() to make troubleshooting easier.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-res.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index fbc05cda96ee..0d203325562b 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -167,6 +167,8 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 		return -EBUSY;
 	}
 
+	pci_dbg(dev, "%s %pR: claiming\n", res_name, res);
+
 	return 0;
 }
 EXPORT_SYMBOL(pci_claim_resource);
-- 
2.39.5


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648319;
	b=Sg1aIzKAouOWnKlSmRTHLkqpU5hw7FT1tTdElf9WdkO8YXG5BCqDdMi81/zRPzZ0hnFr
	 JFhMM6OvT8VLLsKBO60oyg46wOsI0DwBxWxTiSU6CbLmBjZ5WK3jr7qibnZjjAWpq5+9w
	 iLEWR7AOTIQOO1AcpjmyvxDm2Txlgd1LavZXG9IEKOeogPGJmwPyQObXo6q8djAL0qlqD
	 nIiCGoBwH7yPIpHLtH9OpaMOQiy2VCJ/OnuODP+TMC0sQI4OkdQ4ARjpgM/4v6+cJUsEt
	 ovuQmttAmdQjCZAWtQDc4RGTcxBIYv5C3Ce3Q26tnIR9zLEAkcgO+tDOfJL1EVqFqpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648319;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=p3BdWiQXzVaesRlq3JCs1LI6um4tlgLOWMQREIHLGas=;
	b=dXnuVzs2+HAgzPQgknG+LEHFupfsNCVqRdVcG65U3GPHQaRQLc8bMkq14UpH9ndAj2db
	 HWw9m1W6KwMIP+IMO53XHuSm4BfLKNar8l2byqQigg/ZUYYeKrV8yLoJybXsrEUH2B54n
	 44pTAbJBhDGVAq2ozgnMT0/kFJDawSYd3cr5JfN7YsmesbHjnaZOkKaO34dI7LGHiSopG
	 kmPPMgd+6dkv+Hp8ECTsPNcEi7hw8buHVmR0eiv4kvIZvZfVipVFCBB99uVAkyf/fzqlk
	 u+HlD9JNZgoXrIOjodzx7ffsixjzMJ/1fbGAykrD98TzMbPcHaf3HH5aiFtC1BPHNuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YDTM0ia0;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84720606A323;
	Wed, 25 Nov 2026 23:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84720606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YDTM0ia0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648319; x=1827184319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dCMNjcyVrm4R2RAv57l1r9Bm5WWB96E9m1eZjTLDFes=;
  b=YDTM0ia0XrdAA66SOXAIuAuZpa0M79iTzqJdnUf+g5sBGDUIEHJmyzu/
   Z06GSxLMg9lTmpzCfqjtfrez3wK/9SgNOtEZO3pKCZDZgzhBhRgrepUPn
   CP5ndwy6bk/SJSKPAvS/EcpwRSFQxC28jD0s/6JLliZLF62kNRz4AXImD
   6eZU/2B7lalZfsMs8guz/1c2KTjSWGa85iJT0GTgu03+x0nDm/UNG0sXO
   yl0NeM/iwUJb1MX33pulnltq3GK7IwI2fNRtIchomnUdwJQXyHVPIPzo6
   s0j/8RWbSwPAinp1YHbAzQBNE2HsVOlGCQ+lPtIKgCfBD43BDBTCoSnFg
   g==;
X-CSE-ConnectionGUID: 8Vj7oG5sRyC8AQOAMY08AQ==
X-CSE-MsgGUID: 62SPIxdgT9e9XGWkL+mY+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4451853"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4451853"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:59 -0800
X-CSE-ConnectionGUID: S/FPc1OTS6iXfZx4UBUhaw==
X-CSE-MsgGUID: yDfcvQe1SC+3vWXEqv0Qbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11874529"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Shijith Thotton <sthotton@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 14/17] PCI: octep_hp: Convert to pci_assign_unassigned_bus_resources()
Date: Thu, 26 Nov 2026 01:09:13 +0200
Message-ID: <20261125230925.2441-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842691;
	b=JmFC6vKrUjaVZmeFQ1XcpgNL6gWgStAkum2IrTOsHRFM2Xp6lrvvhLoVsz4m4Ng8nqrG
	 pSDnMCMBcBu7dJozpaWpipdWJIsqqq1QpOkbzkL+GofgB6cB/ZCDAYzjqoZopthgvzKLq
	 c5zwencuhQUREPeHzqPvqE9mpQwjNodx7Z64d6lk25+wIOo74wE6BvdS41Oz+YF99ZNvn
	 MAXyHQ11plWAQcSzn2TiIOWAE6rZmjzT7G8E2oJhLLCK7teZxvXI7LlNff+DGCGDUNXpe
	 mOp159XwNMmZIC4tS/Q8MJTuVn6LZaoRlqumMn3yZZVvDVHhPFmfbBn8Jao9skXRTyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842691;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=pr8sjRBaOsMM2QiF4ukN1zYZIF5Iort08uPjOr2zl4o=;
	b=FE0Q2BybrRTNBF+l/eBE0MemmLaJ9FlKK96D8ZjqjKssf+WNn8iWdvggo1+6Jy/pymd+
	 yG67THvyEQIxWU/E2/NfgG6hUJqOvJqs7W62SRgU/MO1XAxad8AhheX+WLRhx/kPQezoZ
	 78S8lDxOTYwnh/YKKHUhY8S93bIxeDxBm+rc5+deDFbgblgi0ZGBW1R5wzu+f2c94y+mK
	 HqPOinxGfkfc+TXLXKE8AtvQRBHpcFGNsu5WzK3LfXu/eqeGm0Yem9HRW331DA0UCgmfn
	 e0tBA5Dd/29cnaoLhKi5J54VCXY6Ej7Wx9m2AZtc4NqMCOqy8s+dFx8w1nuN3vYGeFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kDNwXUke;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69B606A322;
	Mon, 16 Nov 2026 15:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F69B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kDNwXUke
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842692; x=1826378692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RZJgoVSkiph9AQSq+zO/Iue6IPpp1uB58j5mvRoOkuQ=;
  b=kDNwXUke3uLQ3GJ/1PUCFqWnuuC1BThYkZt4HFzqlHLhHsR/gXcZlQol
   6Ulp+w3qf6ZVhUyXaB9aXvDUTPVQfObhn2yDqH/9fqmz9+zRrTDfOwhd+
   g1Fao6VUUSpPkg+eSKztsrLxIxARVotiNJBtPi4nE8NsDuBqGWwDhDV2f
   kA1TDwDT5Dq1NH/k7y3tCnUh8PpRj00k5muZWHnzoJygqJemBdqWt2Sau
   hWPbpJdYno4jMZdCoTXS9B6FrfzN3lpeFROkZxlX/wP6EKELz/iLYh/Wy
   q9FnY+BiZalYKLWD8jBlLCjmFE9gck4EaRstoHT73s0WhWannXqW7+7wp
   Q==;
X-CSE-ConnectionGUID: ztJx8lwjS/+40O/uaFoZYw==
X-CSE-MsgGUID: 9geo1jogRACcoMehvarwIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3455511"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3455511"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:24:51 -0800
X-CSE-ConnectionGUID: SU6rmxrWRauXUXNvY/iuGw==
X-CSE-MsgGUID: fJOCtozvQo2DstUCkQtC3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9414128"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:24:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/13] PCI: Use guard(&pci_bus_sem) in pci_do_resource_release_and_resize()
Date: Mon, 16 Nov 2026 17:23:48 +0200
Message-ID: <20261116152403.2672-4-ilpo.jarvinen@linux.intel.com>
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

pci_do_resource_release_and_resize() releases pci_bus_sem on its common
exit path. Use guard() instead to make adding more locking simpler.

The saved resource list is now freed while pci_bus_sem is held, which
is harmless as the list is local to the function.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 29ec9ba59d92..f95f217f94e6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2398,7 +2398,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	if (ret)
 		return ret;
 
-	down_read(&pci_bus_sem);
+	guard(rwsem_read)(&pci_bus_sem);
 
 	pci_dev_for_each_resource(pdev, r, i) {
 		if (i >= PCI_BRIDGE_RESOURCES)
@@ -2435,7 +2435,6 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	}
 
 out:
-	up_read(&pci_bus_sem);
 	pci_dev_res_free_list(&saved);
 	return ret;
 
-- 
2.47.3


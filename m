Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229836;
	b=qvkZ/Svigjc/hB71HSlvMs88pbrIAG1f0DrLj051gsNiOB8vBO5WfK6NyFgVPz0qVQ+S
	 Tr+7m5aSauunkGOT62KfPCIhdSC5m+m6/IEcjcHKbhVHwdOCPX4VbrvoH7HIonIX8uZyO
	 EnswV7fUq9au6K2WK12kGPHoj91wN9q/Z7ZQS0IDKwj8ZqqaIP0MVbz63W+8ZHud23hvl
	 IygUzVOnUoIbQ1xGNJVHORT+S4YqmtEqFT/bDEBSjWUNBCbubzbS8HBKklIxlynyH9KmD
	 Y1luGoR8XLnCkYWUX7wR9IZPWyFrJFUDkvtg96Z+zBsveVBzf/6bWbutfIKvVBR0zbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229836;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=kkHjrvDUSvd97LkLdq2kDFeq79z5vdLmwk/z6XccS2k=;
	b=rbG2S5nmaNjhnHSswiSeMTMgLnfYs5gcODy6JHwWFSQ//KGFNT+2Xm81Kb/XvTypJi4g
	 fh2MB/BtXQQDa8BuN9U1M+n0VBfi/DBU/+Fnlnn2Xusj0aWOFqY18rgPk4bveo+PQNwmZ
	 KeSsDOhZ15dtdHf3nRAQWUvGB1RiKSdlb7CF2PCtx8YCLbq2CRqXf9Wj7VnrSoZv7iEYG
	 K2XzimdgMJvCTqcRuKAVcntqc9+fdnWx7zPzfPIzWiWropmyYXXo9OTFgyl7vzmWO7nhC
	 YAhL8eX+9uY+yST2vW+lpk6OCrRwrhh3lD+oJ/MqH8Rue2YkexPzBToJ/ximGnL0wkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BYHDOMsH;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F1606A321;
	Mon,  9 Nov 2026 13:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D04F1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BYHDOMsH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794229836; x=1825765836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7LXLzC0gRylbqBTsZD+y1ZkJOs+qcyQ4bV2Qg0srZE=;
  b=BYHDOMsHkZ3cZB5Qglwav12tgQlrC0K2sePFcZ/27aIWDU/H+Pxod473
   Z+CfcWZV9Nm8pVtqoPG5zz5AHU1S1I+WrkltfnFPx9i3XExfPvVPmFLrR
   tY3fCIWGPRUgzXLraZHqfh/TnB9dPBJVe1mvJ6tHNYxflMUKzdIJlpyZc
   I/6QJn0STWqCGoIZ4zRJifqy6p6Q+OWBxw89XEmiwgY4kIvF/cBQDTdYU
   8BWJRGGcoJK2l4w8dkHNFKC08kmzSi9GJU8sVr7FjL9PbgK+v9nyTdbEu
   yGvCppdDVxwZddpxSXxFsOFRAEAwSSvI4Tsah9iNNUv4vQjgktvPR1SBd
   Q==;
X-CSE-ConnectionGUID: C9vob+gkRAKYxnYLUyIJdA==
X-CSE-MsgGUID: kGWVjulPR6SMFpoS2H61OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="3039508"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="3039508"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:10:36 -0800
X-CSE-ConnectionGUID: 5PUYAd50QkGEZoKjws36ng==
X-CSE-MsgGUID: GEPSSIKzSdKrJQUQbEOh0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7905762"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:10:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] PCI/sysfs: Remove resource assignment after BAR resize
Date: Mon,  9 Nov 2026 15:10:08 +0200
Message-ID: <20261109131011.1815-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
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

pci_resize_resource() assigns the resized BAR and the other BARs it
released, or restores the original configuration on failure. Calling
pci_assign_unassigned_bus_resources() after it is redundant. If that
call manages to assign more resources in some scenario, the problem
should be fixed inside pci_resize_resource() instead.

Remove the pci_assign_unassigned_bus_resources() call from
__resource_resize_store().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6669e9ad5bd3..bccd0bd5091b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1731,7 +1731,6 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 				       const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_bus *bus = pdev->bus;
 	unsigned long size;
 	int ret;
 	u16 cmd;
@@ -1768,8 +1767,6 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 		pci_warn(pdev, "Failed to resize BAR %d: %pe\n",
 			 n, ERR_PTR(ret));
 
-	pci_assign_unassigned_bus_resources(bus);
-
 	if (sysfs_create_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups))
 		pci_warn(pdev, "Failed to recreate resource groups after BAR resizing\n");
 
-- 
2.47.3


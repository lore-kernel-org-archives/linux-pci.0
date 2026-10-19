Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D8485925
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399042; cv=none; b=PCbZ0Nxq4pycvfGqrDz9hTJPBC0lsZN5m/9sEPxEY2MrobIvS04+p3m0BqW3OtzujI/2FmA3mwteOu+E8Wsdwv5vimX4iqaoMPkAT2Zx16XE3FkIjOkdVBFWY8vxLaQqH3zNAVyPe6m4gRhfe6c9/058692rT6cdf4YHGfSlc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399042; c=relaxed/simple;
	bh=v5JUwRGvZsgP6gvcKp0AUwYpT4C+Ah0sMy7KnBH3P74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8dFl8nl9UOyxdBmXUDeHDlMXweLSY5y3HmZyz6sqZhQSEdee0McUNNj2nMKfkItkVU5YfT1mtQsrbqwQ9FtoxMWJGS9APCcRgjIf0uDCgpfVY3kR1kKY8KkvDhNhSSO/jeiuYKQ/+LFWoFIKo1eY5qoLHN0D4IOHYCFeP6rCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEEuaSay; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEEuaSay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399041; x=1823935041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v5JUwRGvZsgP6gvcKp0AUwYpT4C+Ah0sMy7KnBH3P74=;
  b=ZEEuaSayD1Ut/9njUL1wWqPJlufVLY6IuyhK+nrzkSv96dcQzW2pek91
   inKHWTwC4SwOYVhRsEj2NRjiy11A+uKRK/iSf+kbLdLeJq5+5syEzDBj0
   TcdgGBIQPv4gmDpPKc8bmRgUp/GVphnB1LOgDBz/i3wITnnt1xR59Qd9a
   hHm+/bhD2BUZl5fmqDQEhFCMfJF+RZ+7VQvrMh2gUaGSTpweOSLlogu+g
   reaZU8K0T/yxllJ/By+5K2HLflkmsQUBqRAw6mLWgtH1dRx0v/cqnNUaB
   QCJpXYrCGdl04QhZM2hy+UuUr/BylGM1cbCkSGhlkgJ3Rvt1ktJLmxH8q
   w==;
X-CSE-ConnectionGUID: wiiFeFGmQN28s/0Fu+Nayg==
X-CSE-MsgGUID: XUfowMxDR6uHzAnQeCEFFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="978858"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="978858"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:37:05 -0700
X-CSE-ConnectionGUID: AbJcvy9EQGSwHZSHDWUXcw==
X-CSE-MsgGUID: n52I8idwQ5u1xFZGCTZsLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2477240"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:37:02 -0700
From: Lukasz Laguna <lukasz.laguna@intel.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: michal.winiarski@intel.com,
	djbw@kernel.org,
	brett.creeley@amd.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Subject: [PATCH v1 08/13] PCI/IOV: Allow bus reset_method for PF with VFs enabled
Date: Mon, 19 Oct 2026 10:35:09 +0200
Message-ID: <20261019083514.838640-9-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019083514.838640-1-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_parent_bus_reset() accepts a device for secondary bus reset only when
no other devices are present on that bus.

While that makes sense in most cases, it is too strict for SR-IOV. When
a PF has VFs enabled, those VFs are enumerated on the same bus. That
causes this check to reject the PF, even though its VFs are in the same
reset domain and should not block a PF bus reset.

Ignore PF-owned VFs in this check, so the bus reset method remains
available for PFs with VFs enabled.

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 90468e38dc5a..66680a05069d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4946,7 +4946,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
 		return -ENOTTY;
 
 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
-		if (pdev != dev)
+		if (pdev != dev && !(pdev->is_virtfn && pci_physfn(pdev) == dev))
 			return -ENOTTY;
 
 	if (probe)
-- 
2.43.0


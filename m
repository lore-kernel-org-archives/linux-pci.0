Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA1477E24;
	Tue, 28 Apr 2026 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400705; cv=none; b=Aq9hduOvwhL6pmB6mQi6EmXJe441VzSABHPn/9jcQHhBZWA8YA5rcfJpOXG0xNczp3ismlxuumljymaNzFiJ4tJjr0In68KHZGIfD7hAs64EQgr+aaa5MYW6ITh/F4xQU5B1GLK7rJMOM3rlf77QBjinUhvYkgDlbxJIRHWkL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400705; c=relaxed/simple;
	bh=nWSgDWNyRjK2UE8cBnMUttmO5wGsRarbFLnYiLV8Aoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRpejoVoJShHz3f6onkbUUThVBi37F5FiZULyBClumGGKBh/5D55H0p2SD46lh/UUpddWlHBNUszz4FLU25shvz07z34z/f0Yi/PR4bQQZpXt8gY5wuh/OP37ykHyCnoP4Wo7Zwlgu4d1Zll+oW/JPQ7X6eNtdR8CUUXacRQEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ha3Z3A3W; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ha3Z3A3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777400703; x=1808936703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nWSgDWNyRjK2UE8cBnMUttmO5wGsRarbFLnYiLV8Aoc=;
  b=ha3Z3A3W0HxnXpXRixCdGj90p+Xrw2vHb7Iox3QNWdQ+SbjxNBdlMYHl
   IqwYni314ZsTVhC4v9Y0sHOIXIVnE2c3jQQ+SnZJn91h3tk+l6lLoXT5m
   XvFjNmYkbGvl17CsZnwJ9CfjHJAkYlA4oVw3o1oZFl6Jf6r+y3AB9+UEC
   REv5uB1+UjsFg4jWO7GvVt1k+5X73QOyITunUk7yTaReAksEuZLz37k+t
   YfnuxSBGf4meY6A12mwhTO0XALQWI/Nry9iGv1jbd799QnaZPrOYd0Wep
   8gM0VkVHBopgzNhcZvEV7ZbhFjpt8o+cvhp4jtnWDtPaWvVTGTRqPWN/6
   Q==;
X-CSE-ConnectionGUID: GTfEzFDvSaSomWJS4f3pJg==
X-CSE-MsgGUID: Y3T48M2TSjqqJv0CEKIa5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="81927200"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="81927200"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 11:25:03 -0700
X-CSE-ConnectionGUID: HN5TYgJaTfqI9BCK+bCS8A==
X-CSE-MsgGUID: SOj1cGtkTlWen76Dpez2fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="257352887"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.9])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 11:24:59 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: 
Date: Tue, 28 Apr 2026 20:24:33 +0200
Message-ID: <20260428182454.464655-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH 0/2] PCI/CXL: Recover CXL Downstream Ports from PM Init failure

CXL r4.0 sec 8.1.5.1 Implementation Note describes a scenario in which a
Secondary Bus Reset, a Link Down, or Downstream Port Containment on a
CXL Downstream Port prevents Port PM Init from completing when ACS
Source Validation is enabled on the Downstream Port. The spec states
that another SBR alone does not recover the port and describes a
software recovery sequence.  

Patch 1 extends cxl_reset_bus_function(), the helper backing the cxl_bus
PCI/CXL reset method exposed to userspace via sysfs. It saves, clears,
and restores ACS Source Validation and Bus Master Enable on the CXL
Downstream Port around the SBR it issues. This keeps the userspace
cxl_bus reset path from leaving the port unable to complete PM Init.

Patch 2 adds a recovery pass during CXL enumeration. For each CXL
Downstream Port in a memdev's ancestry, the CXL core checks whether PM
Init has completed. If it has not, regardless of what caused the
failure, it invokes cxl_reset_bus_function() on the child below the port
in the hope of restoring the port to a usable state. CXL enumeration
re-runs after events that tear down and re-probe the memdev, including
DPC, AER, and Link Down, so those paths reach this recovery.

This small series is developed from an old RFC v3:
https://lore.kernel.org/linux-cxl/20260330193347.25072-1-fabio.m.de.francesco@linux.intel.com/

Fabio M. De Francesco (2):
  PCI/CXL: Allow PM Init to complete on cxl_bus reset if ACS SV enabled
  cxl/core: Recover from PM Init failure via cxl_reset_bus_function()

drivers/cxl/core/pci.c        | 30 ++++++++++++++++++++
 drivers/cxl/core/port.c       | 22 +++++++++++++++
 drivers/cxl/cxlpci.h          |  3 ++
 drivers/pci/pci.c             | 52 ++++++++++++++++++++++++++++++++++-
 include/linux/pci.h           |  1 + 
 include/uapi/linux/pci_regs.h |  2 ++
 6 files changed, 109 insertions(+), 1 deletion(-)

-- 
2.53.0


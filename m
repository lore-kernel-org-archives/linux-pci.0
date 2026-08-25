Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D892FFFA4;
	Tue, 25 Aug 2026 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636627; cv=none; b=aNxIsuRsSxkuJEiin5bdZIi3XI+6JC5SP/ZoqXaShp9AzlvmH6YTOVctmJCPANNBElSo7V9xtT8W0h/jucL3dxhpH5y5QpqvKen2E/5ZlOmEdWKaXaxRtBY0gR9t8zvHr8Q8wTPt4djPZpr1y3PJ/DQhNphJzBTiR/HN1Gt/+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636627; c=relaxed/simple;
	bh=y6GYOA0LrYUyP/W7Y/pMK8wJwKtz3hrhBChYcDsJdtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqBpOlWzd66vZb8dsnzln5AhVE9IHcq6yV1Cv6jZbSLtsNyADEOGQGl4ndATY4VzfieuO2IPjUDNqEkBeJQ8xpRv1PYz79P6zTDyzXQpx4uT50YMDU6wj1mLufyyfjAOP6gjIO3268I5CUCQAFABdQaartcs69b7k2Ue6mEAGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2TTO+01; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2TTO+01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787636625; x=1819172625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y6GYOA0LrYUyP/W7Y/pMK8wJwKtz3hrhBChYcDsJdtU=;
  b=j2TTO+01pXihwtsd61Vo+0mdcvbUFfWB6xF2YN3bsJwOchuR601lP16+
   G2wi2xou9zHcZl/Jn8AQPngQMEgu9h5kqhwydnsZ0rBivfwYWGborDIsG
   0ir3BqvktAGK7lB52jRn937nq12G0ofqn1BaEZk19s5aynxC5QYU902Ns
   uQpa01mbPVsqXJGtaPcnyFnppdwNODyuw3/Z2ehApsEYqtH6YVVyS9qk4
   dSgVC/MHEoluLehh6NwC1pmD0+qV+YB9SkSwpQnoCwtCZU7Zjf+npFF4p
   wYxsWkV1IKOFsGXbm4rfLb1un8ErfuQ5MJ34BgZd7qIx1rlQu+YWycQXL
   A==;
X-CSE-ConnectionGUID: hD0NkPwmTSu1qepYYHRqTQ==
X-CSE-MsgGUID: R5oJmrneRbKeSTttdtVm8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88152500"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88152500"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 22:43:45 -0700
X-CSE-ConnectionGUID: zRJeCF0qRdS8DdsPFGJwgA==
X-CSE-MsgGUID: qRMawO2pSxmWTSM7usLUQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="272418200"
Received: from unknown (HELO jraag-Z790M-ITX-WiFi.iind.intel.com) ([10.190.239.23])
  by fmviesa005.fm.intel.com with ESMTP; 24 Aug 2026 22:43:40 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	iweiny@kernel.org,
	ming.li@zohomail.com,
	bhelgaas@google.com,
	rodrigo.vivi@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	lukas@wunner.de,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/2] Export pcie_aer_is_native() to AER namespace
Date: Tue, 25 Aug 2026 11:12:49 +0530
Message-ID: <20260825054312.1319951-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds xe driver as a new user of pcie_aer_is_native() and
changes pcie_aer_is_native() export namespace to AER instead of CXL.
Detailed description in commit message.

v2: Change pcie_aer_is_native() export namespace to AER (Lukas)

Raag Jadav (2):
  PCI/AER: Export pcie_aer_is_native() to AER namespace
  drm/xe/ras: Enable SGUnit PCIe error reporting

 drivers/cxl/port.c          |  1 +
 drivers/gpu/drm/xe/xe_ras.c | 14 ++++++++++++++
 drivers/pci/pcie/aer.c      |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.43.0


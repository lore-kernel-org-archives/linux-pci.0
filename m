Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA82C3254;
	Wed, 18 Mar 2026 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853498; cv=none; b=eMQb4RwR3l8M3wld5dszOg9Bntk25xJt/ebkZ6Z/UgHesBTRuTRm9dr3G0vMNoGOUnXQVIBqwN1v392tpcwId7o/bDLtOzzDsI0DygroVT4eMbfHaD76u0IyCYspWE3JhaS0zLSfULSwwKOmCIgyEkds2YX10mE2d4g/I/2vtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853498; c=relaxed/simple;
	bh=JtkfgY2QPGPlp2YTL4Yb4oB5GPkIA4rMRtXgFu47Ayg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SpPZirJGwY/x/Y1UHnKzEZPc08nWisw7RCwiuijR5QagTTLivN2cOUjtCWBWKFxMnFYAo/x7sTHkRYNlsYy60jqGLr8jlSvJZI9Zo228iQfVnIH9LOtFEdNotlgOvWO6yHPy3Mrni1K4weyrkB22JTD0TwjBfeRiyEzLUuj/zBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2tKI9yJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2tKI9yJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773853498; x=1805389498;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JtkfgY2QPGPlp2YTL4Yb4oB5GPkIA4rMRtXgFu47Ayg=;
  b=m2tKI9yJwRjbeoL+Kf24vLq5tz62BMxKSGxwaQW0725logSUHo3WhEgg
   +2F43FdYPlNEuhw8oYfLby6QXrkkQe9EBC72cXjlVjolklW6pUmKms1mH
   rcwGs1Q2+h6+wcdqPL5FYHheTInbmX/cgw6CU4d6D9tNW73k+i9ccue9K
   qnKAlU6uriJF1L9jmYp+o/jpdb4Vkyh8julrPXTEo+bBhtv098rjNniFE
   AQlTK3gbYKHX/+hMjyc8D/NRfnJIstD76/y/OGWYqfcp2QTpe9382EDpN
   YMHBum144qSLgrdcpGsx4vI0Sw5jikxKqPJDAsPs6RrBAcy5jnbiIW/cQ
   A==;
X-CSE-ConnectionGUID: fyw8pkpSRluiQfBKv8I+aQ==
X-CSE-MsgGUID: 7sqJRSHBTGenJpgJPWL0ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78774964"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="78774964"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 10:04:57 -0700
X-CSE-ConnectionGUID: F7LWEGyJR2GziehxoTJuZw==
X-CSE-MsgGUID: ux+rqs3zSjyAZj1JDjCzOw==
X-ExtLoop1: 1
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 10:04:55 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Oliver OHalloran <oohall@gmail.com>,
	Jon Pan-Doh <pandoh@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1] PCI/DPC: Fix AER error logging for DPC/EDR triggered events
Date: Wed, 18 Mar 2026 10:04:49 -0700
Message-ID: <20260318170449.2733581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aer_print_error() skips printing if ratelimit_print[i] is not set.
In the native AER path, ratelimit_print is initialized by
add_error_device() during source device discovery, and is set to 1
for fatal errors to bypass rate limiting since fatal errors should
always be logged.

The DPC/EDR path uses the DPC-capable port as the error source and
reads its AER uncorrectable error status registers directly in
dpc_get_aer_uncorrect_severity(). Since it does not go through
add_error_device(), ratelimit_print[0] is left uninitialized and zero.
As a result, aer_print_error() silently drops all AER error messages
for DPC/EDR triggered events.

Set ratelimit_print[0] to 1 to bypass rate limiting and always print
AER logs for fatal errors.

Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
Co-developed-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
Signed-off-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fc18349614d7..7605ddd9f0ba 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -256,6 +256,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 
 	info->dev[0] = dev;
 	info->error_dev_num = 1;
+	info->ratelimit_print[0] = 1;
 
 	return 1;
 }
-- 
2.43.0


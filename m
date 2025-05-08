Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091E207DEE;
	Thu,  8 May 2025 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727309; cv=none; b=nBmr0CFeHtnPmL0wfE0tgYGKi5ISTorRGNFAP7v38jHXW5KyiR2Igqv/ya1a3dzUjm/+Y5Z8bBT77GimylHO6YA6+UyJhZN7fn2sA9+kQuRfttFQ4TQE52AMUlJt8qfCMWXfQa0QKY6hJFmHojYFCzrJRLluChDAIpbGextQaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727309; c=relaxed/simple;
	bh=sA79BhLzoabviz6+yizuG4pjmo9xJ41igQAOOF8SmKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL0GLls4+pi/yWUNrUEoZDS5O3C/t74RL7VV7PdNJRHfBHEoa4CAnz3Jg8BIK9nbHXwKyim5qbgpIhqvqd8Zo7jJzWRVewydrx4Vp18ObTZMfo6bNvK6BXWHFDFpgPSxEM1J/VDPuIlx4QRIQkw1vB0i7OpBB0YUrU2//HaSv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UA4m5QEk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UA4m5QEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746727308; x=1778263308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sA79BhLzoabviz6+yizuG4pjmo9xJ41igQAOOF8SmKM=;
  b=UA4m5QEkkulOZWnFzOv4+QAOICVLgrxXjK6fSO/rmggEWs9GwFAk5MtJ
   b+kewqplFtk3OxKyfUKGujIZBVMgAxxHu+hSSWBl1vn14t88/gbcqSKwb
   9BjGbaZTgHiSc3CjBdHzHfTXaiVhcIpwsty+RiId39ub/wePFSbZJj4aO
   VYKG1On/fv9NK/dowXV3azEeab/sI2vyDOu0p9R72iJqadYUvhbH8lPH7
   5UNGEsGVG+kPemi/vICG+BebXS1Kn0F9fsGsTZcTvSMlKvB0VXZ6Tr0qO
   drIhKmfQRYJqCSI15N/6zopEZEVPMMW1ArRMsXhReLsxGftaVzedMTdjM
   A==;
X-CSE-ConnectionGUID: pDpuDvjtT1aHxVxicVB1Aw==
X-CSE-MsgGUID: bNxs4jtfSL2IEu6q+QkVkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59160560"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="59160560"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:01:47 -0700
X-CSE-ConnectionGUID: 83Z7L5HhTlWSWPdtuv6jaA==
X-CSE-MsgGUID: o0QEA0A5QGWvn2HWFrPSAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136311427"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:01:44 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	guennadi.liakhovetski@linux.intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ALSA: hda: intel-dsp-config: Add WCL support
Date: Thu,  8 May 2025 21:02:39 +0300
Message-ID: <20250508180240.11282-5-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WCL uses the same receipt as PTL and PTL-H

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 01594f858129..3cb1e7fc3b3b 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -541,7 +541,7 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 
-	/* Panther Lake */
+	/* Panther Lake, Wildcat Lake */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_PANTHERLAKE)
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
@@ -551,6 +551,10 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = PCI_DEVICE_ID_INTEL_HDA_PTL_H,
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_WCL,
+	},
 
 #endif
 
-- 
2.49.0


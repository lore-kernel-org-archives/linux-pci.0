Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0347D935;
	Tue, 20 Jan 2026 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937684; cv=none; b=snFp89UzR8IoumDAWDAxTtq5UMMPXYrsoHeoBEKXdtq9TrQiowxyRe+8bvtRSpI+I32VYVvK5qB5HCerPe/aNsDcwmsGxOssr6Go0opgtdb32HdDeicwiGz4+FubIsfQX4DEWYJ6Kobndpvmyhg7FdufNluISF9K35/VMx09e8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937684; c=relaxed/simple;
	bh=JSmNji8KWt1lIxh8E+O3F5s8tfGgkKBxrp4DErhMj5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkxC2avnusJMhLIl1Xk7TKnuNFZWbLwoA2dN7/nlEVCsaakL7AuHIEkVFauF4XQozylo5yuzX7K0KctEccwb8QK+s/SY9Autw2EMgu1heuOJRW9Jbp3D2/eFq2V0KIEhrk4VLCqThITPQTFPo5B/YHcWUwydv+iLAXEoBPNR9Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPvylx8Z; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPvylx8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768937683; x=1800473683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JSmNji8KWt1lIxh8E+O3F5s8tfGgkKBxrp4DErhMj5I=;
  b=bPvylx8Z0fuVaU9GQF/OmxBVpEkSePBlfYzH+tjneMyEK3voQyZQ3DDT
   pSIllO/nSIoqiVmYdok+d0ttrIDuqKnSeb/KQsH1t11ywEqA/g9q39OdV
   SFqFXBZQ/6KQocrtlRKFMh89oqcWJYBeVsmVpfxebMdmbv2XVkp9apfhY
   aDMFrANlsAuU13nnofHGaYZ6a8sr/1wq5nzPM//xH6MmRetcwem4Ipctw
   FY4CGaBJNWP2A7JG6rzFxWBFC5wyxFb0EfwMC/gPB0r33FsAcc8735I5R
   a0ByzHX2AAd1NHip9HF7skssHlzz23oKAA8iKo3QPe0GFbATigN2RBnBr
   Q==;
X-CSE-ConnectionGUID: uErOLTNXS2uBV9U7T5xRYw==
X-CSE-MsgGUID: uG0yc1khSCmWBNhquWrD/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69888966"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="69888966"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:34:42 -0800
X-CSE-ConnectionGUID: SYGic18wQBygDFGf1AB8lg==
X-CSE-MsgGUID: 5icS8MT7RLuxF4Fge8aqtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="229165885"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:34:39 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de,
	bhelgaas@google.com
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-kernel@vger.kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 4/4] ALSA: hda: controllers: intel: add support for Nova Lake
Date: Tue, 20 Jan 2026 21:35:07 +0200
Message-ID: <20260120193507.14019-5-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120193507.14019-1-peter.ujfalusi@linux.intel.com>
References: <20260120193507.14019-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NVL to the PCI-ID list.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/controllers/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index bb9a64d41580..85324c7c796d 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -2551,6 +2551,7 @@ static const struct pci_device_id azx_ids[] = {
 	/* Wildcat Lake */
 	{ PCI_DEVICE_DATA(INTEL, HDA_WCL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Nova Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_NVL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	{ PCI_DEVICE_DATA(INTEL, HDA_NVL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
-- 
2.52.0


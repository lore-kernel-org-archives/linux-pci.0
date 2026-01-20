Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF847CC9B;
	Tue, 20 Jan 2026 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937681; cv=none; b=Tbup4LnGWlyzgHvrH4bOfym6ZwcpfhTZZPe/nyP1MamUPTlemQehAS9DrBpU7slki/PpvdQpFI2/VHpMhYK/yK0TNtU/Xm2CyN/uhkEun/1wIKdTTDvAo4UBuxGcqdid/mz4Qwdq+f2+o1KQbe6wLSbrvruP5sn2C9K9kl8xPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937681; c=relaxed/simple;
	bh=OmjurbsIwvq0EDrylw69BFqyXnnYtIDWZApQZ9tWpyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgX+rNeaXi4cITR1E9FfrAxnYlSiDkVSf8PfzENCQUed533WHWwyFLeNS05E2RNtf2Req4yrNXHVEveWAmEcz5GDN0ZaV/U92lePmuKUQBkhv4/jKbdaUgk4P/pJ7QYZbafFV7uCm9yM4p5kKqYoVruJoxKCXuEqIP5Mju4mIpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqwHDmEb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqwHDmEb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768937679; x=1800473679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OmjurbsIwvq0EDrylw69BFqyXnnYtIDWZApQZ9tWpyQ=;
  b=JqwHDmEbIItORFo8HOe3OU30KSxCvVwHU7EBG/75QCqfi9YTTZ+AJC0u
   X+WFvr4Cqi0YZ8CHZVuzjvk0iiNsdCsjf0M5mGP04057cmgGyy38Fgn0t
   jpAUTXSWz0md4/poT7VONOUS5woIh7V+2k1Mkf1ziO3HFDW1ZqfDK/uhp
   u3/R/M23918la9T6boQ5yYOgVwRMpSxJQf9KvaTrDXve3KP/my5blj94G
   lC/l9NzsR49ITeu/mUjuPMbqN0hxZXNpvRiww+xCs+1N+SjsIhb/Gwf11
   3xag9My91mbrq7c5ILypriPWrg6rwRzzjD96p43R8feKOYhMN44fVbTDf
   Q==;
X-CSE-ConnectionGUID: gkJqKNrPTCSWFygFDMjttQ==
X-CSE-MsgGUID: xCm/T22yRbidMLyp5HhzWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69888955"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="69888955"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:34:39 -0800
X-CSE-ConnectionGUID: 6hCCjzmAQoO32qWB98HG5w==
X-CSE-MsgGUID: TcFg0ttpQFquZHRQDgBnhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="229165874"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:34:35 -0800
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
Subject: [PATCH v2 3/4] ALSA: hda: core: intel-dsp-config: Add support for NVL
Date: Tue, 20 Jan 2026 21:35:06 +0200
Message-ID: <20260120193507.14019-4-peter.ujfalusi@linux.intel.com>
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

Add entry for NVL variant of Nova Lake family.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/core/intel-dsp-config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/core/intel-dsp-config.c b/sound/hda/core/intel-dsp-config.c
index ddb8db3e8e39..f0a44fd111f3 100644
--- a/sound/hda/core/intel-dsp-config.c
+++ b/sound/hda/core/intel-dsp-config.c
@@ -580,6 +580,10 @@ static const struct config_entry config_table[] = {
 
 	/* Nova Lake */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_NOVALAKE)
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_NVL,
+	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = PCI_DEVICE_ID_INTEL_HDA_NVL_S,
-- 
2.52.0


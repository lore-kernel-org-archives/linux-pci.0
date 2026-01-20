Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633B4418DC;
	Tue, 20 Jan 2026 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937671; cv=none; b=uDKCtGYZLSzQtYFnKuBMhiEMMc4af00Kk6rkDTtW1IRbZX6PzVBy8ccFWGq1vg/l4d+0EdK0GtAmiwSBAxx0vc+rtxPIk1DujZlBGtC7lxnWeDBkmfF2ATBrwg1s4oJyJbt44bQxD0WyzPZu/Cc++zuSIL6Til+BoYMpGOP7sBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937671; c=relaxed/simple;
	bh=LsUToe/3eQT5lCEd3tRHVoYfRc0Oxoh7eRQgYcr9IhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5oN2LLXfkjzGe0ZAzUYH/rM2DynRG7VYS/4cR2xKYr3Ije33k5VRL02octgWYt7eY+++S4MJ4NC9VOdnlxxVXAidX0O1huraCkuWdsOLZ+x8sAlYdk4c2RAXy4o5NJbBfzEtWuym0NRDm8v5mCHVM1y73H0zKZP8axDG/6WyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApofqX3f; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApofqX3f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768937669; x=1800473669;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LsUToe/3eQT5lCEd3tRHVoYfRc0Oxoh7eRQgYcr9IhA=;
  b=ApofqX3fJnlYGVvpl0Y0LvdGtzbqXfFOtLH+RCDSYB3o2IxyWk+O5iCL
   i3lsbPPXTkNCjTEbkCdOF9WdqeamsWxypIb7FNZpdkF3JVfCMlRQT9xHi
   mjFrFpCPh/9Ciz1wu81uawHwBfR9sBmTdhp9zhmHLWY0Su10WWw7Xd6yu
   De0ITLibKkyoMaadRRnJogVXI2FoaUGmd4XpjnG5rbbB992EIQH/vmbHU
   kTOYAR9Z/Q+UGYnuEHrtPIJ+70pbcSZgA5vxd+CClAjN8jwpmKw3kchkE
   bzwAmwCkOWA4YpZZ7B+tYJRXaHRc/Q08JZ9Z9G3bnAXD7Cle9mJtme08H
   w==;
X-CSE-ConnectionGUID: QDkYtzDcQAW7ce38ENPgZQ==
X-CSE-MsgGUID: 1CgtIOu+RkiC95L1/6okjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69888930"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="69888930"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:34:28 -0800
X-CSE-ConnectionGUID: rVbCllaLRH2t0LDwQzaYtw==
X-CSE-MsgGUID: nVbQ5FxbQ3W2jiGwXucBWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="229165822"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:34:24 -0800
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
Subject: [PATCH v2 0/4]  ASoC/SOF/PCI/Intel: Support for Nova Lake
Date: Tue, 20 Jan 2026 21:35:03 +0200
Message-ID: <20260120193507.14019-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v1:
- commit message/subject fixes suggested by Bjorn
- Acked-by tags added.

this series adds audio support for the NVL variant of the
Nova Lake family.
NVL also based on ACE4 audio subsystem, but with higher clock
rate, more DSP memory and more DSP cores (4 vs 2) compared to
NVL-S.

Regards,
Peter
---
Peter Ujfalusi (4):
  PCI: Add Intel Nova Lake audio Device ID
  ASoC: SOF: Intel: add support for Nova Lake NVL
  ALSA: hda: core: intel-dsp-config: Add support for NVL
  ALSA: hda: controllers: intel: add support for Nova Lake

 include/linux/pci_ids.h           |  1 +
 sound/hda/controllers/intel.c     |  1 +
 sound/hda/core/intel-dsp-config.c |  4 ++++
 sound/soc/sof/intel/hda.h         |  1 +
 sound/soc/sof/intel/nvl.c         | 24 ++++++++++++++++++++++++
 sound/soc/sof/intel/pci-nvl.c     | 31 +++++++++++++++++++++++++++++++
 6 files changed, 62 insertions(+)

-- 
2.52.0


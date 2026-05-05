Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068F494A15;
	Tue,  5 May 2026 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000430; cv=none; b=luVDFqqaJpB7aNrBAkRrIyjacmDkruDWIj2aFaZYs/Mf/HU2UVuHfiEaHSH8KLwmhSk1dYj8FQ4/9v+P9/tb5t/KDaTVxBtRt86M3faaLq2WvGA9t8IScGWX0sfz8L8XXRFmX8NWS1BUxfpR4oeEyyGmZt9UqiPSHA9IELIEOsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000430; c=relaxed/simple;
	bh=Ky4e3+BeD59r+7upVkZCBP24w/qzN4esoPcEPUeKrxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CF/IoLBNHpFtLc+W6YHX2k4lckECUTspu8TT9/HneyPj3SSP4sEaCXtr3TlaVq3neSzpX16tPkxQnyvKwHEZx6YBVAEBGyMyBcteBZGuUWJgP68IDsRtgCuhns7vwpbiUIPvm52WmBsWN74SB3r3FK+Mr52vh+MmIvVTW9p43go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJuzVhOE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJuzVhOE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778000427; x=1809536427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ky4e3+BeD59r+7upVkZCBP24w/qzN4esoPcEPUeKrxI=;
  b=fJuzVhOEoQ3IUdsJ2gXNXqPiwCVlAif+jeyXrYC3hNoPmH8iTHCkcLAF
   ctxVMvav0crbS2ZpDCMyQ2nxz58XLEBMFDnEP6JOp7bvkyqN9o3Tm7+ID
   bXIYXBxqKIANm2fnJbgQ/neN0NH6p1wIkV+cozpaQM5ti1lVhetqnV5bN
   AllyMu/nKNSSN4b2JlUjSmqTIdyM7wzavo893spYT37wOfPa9gm6LAX6R
   B0Ya2tagDQBoRAY8kTfRvTPxxxphQIO2qIQfEZ2wKTauSyed19TEl5mj+
   3Dr+YHBhyxo4VJXvijV9qb7iKevPJQGJaUszJEbIWojXp1hlhxznUqu1p
   Q==;
X-CSE-ConnectionGUID: ULYqYI7aSXKXjdKm2pL6Hg==
X-CSE-MsgGUID: WBZRjw9nRWm/SFyiyVYJQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77900516"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77900516"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 10:00:26 -0700
X-CSE-ConnectionGUID: Dk4LJCkWTJ+7kBYjh2dRpg==
X-CSE-MsgGUID: gKkq91GpRrq8vvbajW7J8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259211284"
Received: from soc-5cg43972f8.clients.intel.com (HELO localhost) ([172.28.182.189])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 10:00:23 -0700
From: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-xe@lists.freedesktop.org,
	Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
Subject: [PATCH 0/3] PCI/IOV: Restore initial VF BAR sizing after VF ReBAR
Date: Tue,  5 May 2026 19:00:07 +0200
Message-ID: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PF drivers can resize a VF BAR using VF Resizable BAR (ReBAR) support via
pci_iov_vf_bar_set_size(). The new size persists in the SR-IOV capability
config space. A later reprobe / unplug-rescan / next pci_enable_sriov()
then sees the inflated VF BAR registers, and the PCI core reserves MMIO
based on that size multiplied by TotalVFs.

On platforms with tight apertures, this can make subsequent SR-IOV enable
fail due to lack of address space.

This series records the initial per-VF BAR sizes during SR-IOV init and
restores those sizes when SR-IOV is disabled, when SR-IOV enable fails,
or when the PF driver is unbound.

Note on user-visible behavior: drivers that rely on a resized VF BAR
persisting across an enable/disable cycle must now call
pci_iov_vf_bar_set_size() again before each pci_enable_sriov().

Marcin Bernatowicz (3):
  PCI/IOV: Remember initial VF BAR sizes
  PCI/IOV: Restore initial VF ReBAR sizes on SR-IOV disable/failure
  PCI/IOV: Restore initial VF ReBAR sizes on PF release

 drivers/pci/iov.c | 64 +++++++++++++++++++++++++++++++++++++++++------
 drivers/pci/pci.h |  3 ++-
 2 files changed, 59 insertions(+), 8 deletions(-)

-- 
2.43.0


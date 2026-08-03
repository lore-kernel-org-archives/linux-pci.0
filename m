Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54AD37F33E;
	Mon,  3 Aug 2026 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753017; cv=none; b=BDF6+104CdozKdoWJIoJr9qDLaX1SHUsnahd1+1Nk4VUGRu8KX2vatpMmJYZGRnLNvRX1PS2SHrwPgsnG+Folj8FCH29SIgYKUublFfdG3yy03BfJ+hhvuYMwDjGRQQFCi4JFZ+yXw40PItSN1XgXBQMIpcpjS/d655SrG7sOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753017; c=relaxed/simple;
	bh=47+gwzbLR1bN29pgU5SS/7soUJUxYCdSq1hMuZW87Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8FmHCn+bA12rGQnkxiycNlC+UMP/emw785qy+SEGBcXwgLn83HbfWQrf4R2o6wnwFEZJYdCyNWZ2VxGp6wa1HKqhHn7Xe9HK0i1MhW1p3rYEiv/i8TpBn8Vau2AQkN46/BKo+hyr4KCa/eOGKO4RtnDlxuO1DQ9AH/HoFPNrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUOUhx8L; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUOUhx8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785753015; x=1817289015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=47+gwzbLR1bN29pgU5SS/7soUJUxYCdSq1hMuZW87Rg=;
  b=kUOUhx8LQreDg3ju5M75qrM/D5jHWyNPvzg6vyfUPYsLPTNUOFFawr7c
   ez2/UxAz0KB/Lxh5fZKw5YAVgcdLRw8muTknm0twjpENfCo3/ASfYUMjj
   zH5s8MFsHm68pFtv4hO7Za4fwpuRys4VkKYo6ur4eQv3bNCpr7p1SR8iI
   OVHtGlcm708hxOBol9658yDP6XP6vj8xj42rtAZm+WvAbAAXaadcSCSoJ
   LRDeD8GkxQrpRt2mXdSuo6KHJhI//mF7HQWeET4Qit1NhKC70YrArmxkD
   +sNvB1bmmYXz2QLq7mdmo+BXQ0NXyEgDrY3rx/HpdATN7p/KE2s9PLMLp
   A==;
X-CSE-ConnectionGUID: +1apjcckQZ6UU38viYFKSg==
X-CSE-MsgGUID: 88ITXceoRHGSH3+u4J/QTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="97446115"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="97446115"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:30:14 -0700
X-CSE-ConnectionGUID: yjLGgjUrQO64eFyDzpjrSg==
X-CSE-MsgGUID: vluNRbkUT1aHr+3GTRj1hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="284566502"
Received: from soc-5cg43972f8.clients.intel.com (HELO localhost) ([172.28.182.68])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:30:12 -0700
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
	intel-xe@lists.freedesktop.org
Subject: [PATCH v2 0/3] PCI/IOV: Restore initial VF BAR sizing after VF ReBAR
Date: Mon,  3 Aug 2026 12:30:04 +0200
Message-ID: <20260803103007.209625-1-marcin.bernatowicz@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
References: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
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
or when the PF driver is detached.

Note on user-visible behavior: drivers that rely on a resized VF BAR
persisting across an enable/disable cycle must now call
pci_iov_vf_bar_set_size() again before each pci_enable_sriov().

v1 -> v2:
  - Addressed sashiko-bot feedback.
  - Restore VF BAR sizes on early sriov_enable() validation failures too.
  - Move the detach-time restore from sriov_release() to pci_iov_remove().

Marcin Bernatowicz (3):
  PCI/IOV: Remember initial VF BAR sizes
  PCI/IOV: Restore initial VF ReBAR sizes on SR-IOV disable/failure
  PCI/IOV: Restore initial VF ReBAR sizes on PF driver remove

 drivers/pci/iov.c | 86 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/pci/pci.h |  3 +-
 2 files changed, 76 insertions(+), 13 deletions(-)

-- 
2.43.0


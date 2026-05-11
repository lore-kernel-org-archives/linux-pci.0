Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA414386557;
	Mon, 11 May 2026 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533787; cv=none; b=pVpIYtvcL+LoFYonOvZYw2ZIt8ydHKJvH5y4K+3eaQ1+YWcKlj/Bl16kDmsCbXlSugSvPLobQW0i+XLMjpmA/HWXED8hfC9way3UeWWvuNxDlfq/TzDR7NJyuDb/zWRxCdK2hj/KSx0NwJqPSH6OUPOe+rGPUVQe+it8NzQVj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533787; c=relaxed/simple;
	bh=8dkCnLEgNv/oqbfCXjbwQ2FXL9a0PxyR2RoJ8V9Q6dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlEcPGlEisifL2556EYdhUzw6yZTJz757nnRFZbzr00z2+u92ea7JL2MvTwfv4FWcm9L8dGB/wCigr76/Xn4O1qOaRN7a9Ymq1wIrIZyaDthWQKPoLS3UAoAiq6lFiZBJtgsP9FyxESshBCV7FGhrti7VB7njFSgMiI7S6mGC2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRj6OU/O; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRj6OU/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778533785; x=1810069785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8dkCnLEgNv/oqbfCXjbwQ2FXL9a0PxyR2RoJ8V9Q6dY=;
  b=eRj6OU/OSJIPqiBtxZehOpu8xHZUAPpS9bHUUEDhkv4tOuu6D78k+A9D
   iOr7mHp3iyy3TlhEJdRNDC9xeVtc3sMNRy+dmM2Oafty/lWbKkE8EWZMn
   8SJtr9v6hWb3kcyAFWpyMnbrSNztst427JC4nXRRgTIYc6RAV68svq5Vu
   9KGtRKYNAhD/YZIb7BYHFomJN7JFRO7LEOG0Wm2t4uenVCd3top65Szyu
   O4dWkycslHDcGxlNa5qJSOu/fxNvrm9eIh5W3K/X6j8iimWdWZjsxvuxV
   SxRQN/Sg0tntmiAOaknkGNhhrq67mG3jgVlG/YE0Edbsqb2oXLioChsHQ
   g==;
X-CSE-ConnectionGUID: b5PvPP9KRvGHNVJ9+M1QNw==
X-CSE-MsgGUID: nO5L+O3LSkKoP8mAJau6ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90534520"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90534520"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 14:09:45 -0700
X-CSE-ConnectionGUID: eGhIfeLaS2O+mmjIob6ATg==
X-CSE-MsgGUID: k54V2Y9CQqGZUNdi2dvEfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="241559237"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.210])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 14:09:44 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "David E . Box" <david.e.box@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [RFC PATCH v2 0/4] pcie/aspm: Enable all advertised ASPM states by default
Date: Mon, 11 May 2026 16:09:30 -0500
Message-ID: <20260511210936.562622-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bjorn, Rafael, all,

This series follows up on the discussion from August 2025 about ASPM
default behavior and enabling all advertised link power states by
default [1].

Today, ASPM behavior is influenced first by build-time configuration
(CONFIG_PCIEASPM_*), along with firmware-provided defaults. The reliance
on Kconfig for policy selection and the current two-phase configuration
model (initial safe setup followed by a later, more aggressive
driver-triggered configuration) complicate both usage and maintenance.

The direction discussed was to move toward a model where the OS enables
all supported ASPM states by default, while still respecting platform
policy (FADT, _OSC), driver constraints, and user overrides.

This series is an RFC to explore that direction and gather feedback.

Specifically, it:

    Enables all advertised ASPM states by default via the existing
    policy framework, which respects capability masks, blacklist
    restrictions, and user configuration.
    Consolidates ASPM configuration into a single initialization step,
    instead of the current two-phase model (pre-driver “safe” init
    followed by driver-probe adjustments). This simplifies behavior and
    reduces maintenance complexity.
    Adds detailed debug instrumentation to make ASPM configuration
    decisions and transitions more visible, helping to evaluate impact
    and identify mismatches with firmware expectations.
    Limits the default behavior change to newer systems using a DMI BIOS
    year check (>= 2025). This is intended to reduce risk on legacy
    platforms where firmware expectations or device behavior may not
    tolerate more aggressive ASPM enablement.
    Removes CONFIG_PCIEASPM_* policy selections in favor of runtime
    policy selection, simplifying configuration and making behavior
    more consistent.

This RFC is not intended for immediate upstreaming, but to evaluate the
feasibility and impact of this approach.

This does not address synthetic PCIe hierarchies (e.g. VMD), which may
lack valid firmware policy entirely. Those cases likely require
targeted handling and are left for follow-on work so that the core
defaulting model can be evaluated independently.

Feedback is especially welcome on:

    The DMI-based gating approach for limiting rollout risk
    Whether this correctly captures “enable all advertised states”
    The removal of Kconfig-based policy selection
    The shift from a two-phase to single-phase configuration model

[1] https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas/

v2: -- Removed extra whitespace
    -- Fixed unbalanced brackets
    -- Replaced second dmi_bios_year_check() with
       pcie_aspm_legacy_config_check()
    -- pcie_aspm_legacy_config_check() returns bool instead of int
    -- only log whether aspm is configured at build or boot time once

v1: https://lore.kernel.org/linux-pci/20260429180647.197072-1-thomas.falcon@intel.com/

Thomas Falcon (4):
  pcie/aspm: Add debug logging for aspm policy config
  pcie/aspm: Enable all power-saving states during link state
    initialization
  pcie/aspm: Enable all hardware power-saving states by default
  pcie/aspm: Remove CONFIG_PCIEASPM_* policy definitions

 Documentation/arch/x86/amd-debugging.rst |  5 +-
 arch/mips/configs/bmips_stb_defconfig    |  1 -
 arch/mips/configs/loongson2k_defconfig   |  1 -
 drivers/pci/pci-acpi.c                   |  3 +
 drivers/pci/pcie/Kconfig                 | 33 ---------
 drivers/pci/pcie/aspm.c                  | 86 +++++++++++++++++++-----
 include/linux/pci.h                      |  1 +
 7 files changed, 76 insertions(+), 54 deletions(-)

-- 
2.43.0


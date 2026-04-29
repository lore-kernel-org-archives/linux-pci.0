Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C7E413222;
	Wed, 29 Apr 2026 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486023; cv=none; b=CuwWUbtMJ09GjdDDFXy54eur8rpYoW6r1tdUZqH0VhBMZWkqagthQOCnizrzFdXRJDLJ6x4o0Jsd6V3a/1kCRHjU/S01o5JLtmYwEFhffmvUQ5YmEdHzA2Ii3D8CQIPYB+4dVg+UmPEacXDUVefuh8BErKABfCahqx7ImqWCWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486023; c=relaxed/simple;
	bh=/xqUyS0Nu6H02iDqmvzGe/xfNqDuvDK/AgOJphjGTes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h9tHYnL3bJsurvAI40kA9olyTUbPUEkcm2leMlWfraonvkjvjZVL6ABK4YVG+2vOqOuhPU5QDittmJihxc7/265t9Y4GEMVipNkzPqj+FOndquylGzJ/Ko6dPnv6Vp3EkrztVEqJ8AxuAM0Slnu/F+3jZ/UDdekJ8WXB7FsFEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTepb1qc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTepb1qc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777486021; x=1809022021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/xqUyS0Nu6H02iDqmvzGe/xfNqDuvDK/AgOJphjGTes=;
  b=XTepb1qc4+b4MkiJXGPyZWlAxQQqJ1wKqxKDcViIiWTRoRG6ZxCcnPVZ
   Sn01KWqPpz9/o4jMgj9IkOikqVvpIdP1WK8ScI//Td0B0N9If3bGcR4zP
   cbOzVh5yI09jfVRWmhbMFoy7VEjyCXnnbO4bYju41C4k0g4vBqISeeg3H
   xl8+yI1MY3r2+G8kx8Ye8IIAa3XIlZr7ImlHkKG43rfNfL6T66Q6I2D5j
   z8xAKKGVKWegIFV3G76d6SYpP4uEFdapKzO4ubWBR7As9F0tQdXqhHJZp
   FfdHQnM6FsNow1y3Tkr3xXNGBBH55wqtLtTEbAU3gBx4P/XPwu+D5/HLi
   w==;
X-CSE-ConnectionGUID: FH9e4M03T7Cv2i/7UVPy8g==
X-CSE-MsgGUID: UgOP8FbHSUyaLxDAwtdmwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78532267"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78532267"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:06:54 -0700
X-CSE-ConnectionGUID: NkYtTC8USS2bbeuKoGjrfQ==
X-CSE-MsgGUID: uJ5hh9mnQDycBeLyC2PWmA==
X-ExtLoop1: 1
Received: from iherna2-mobl4.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.251])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:06:53 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: "David E . Box" <david.e.box@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [RFC PATCH 0/4] pcie/aspm: Enable all advertised ASPM states by default
Date: Wed, 29 Apr 2026 13:06:42 -0500
Message-ID: <20260429180647.197072-1-thomas.falcon@intel.com>
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

Thomas Falcon (4):
  pcie/aspm: Add debug logging for aspm policy config
  pcie/aspm: Enable all power-saving states during link state
    initialization
  pcie/aspm: Enable all hardware power-saving states by default
  pcie/aspm: Remove CONFIG_PCIEASPM_* policy definitions

 Documentation/arch/x86/amd-debugging.rst |  5 +-
 arch/mips/configs/bmips_stb_defconfig    |  1 -
 arch/mips/configs/loongson2k_defconfig   |  1 -
 drivers/pci/pci-acpi.c                   |  4 +-
 drivers/pci/pcie/Kconfig                 | 33 ---------
 drivers/pci/pcie/aspm.c                  | 87 +++++++++++++++++++-----
 include/linux/pci.h                      |  1 +
 7 files changed, 77 insertions(+), 55 deletions(-)

-- 
2.43.0


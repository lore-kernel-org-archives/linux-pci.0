Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEFC280A56;
	Thu, 18 Jun 2026 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802445; cv=none; b=WmswZhWwCorFr8A97Rel/YeY1DO/1eETjGm1UztHg1HjUZZcDI0TyPv2KQwTPgADxcJFWSleDeFAWFicSvu4LXHRYx400+eSVfT/dj7gYe2D+d4aXlIfWazY/vBSpbKXnGQGBef5P74ns+Gz6TYrUDtyVhiOce7zFAq7GTJCcvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802445; c=relaxed/simple;
	bh=xYxg5ssbn/qq0ejDQ1H7dWD2pw6fIUaFnzLwr2Adtk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iizAjOS2U2KW+Ul8mHfS94jCAnMB8ORxKjIssiJi6dZ0OeOr0OSS7VhR7pq1pHTCLumVy3veAqb/Caz2Xi+kRenNZ0UcYFhdFEsAKXn/09qzBifSIIkmDsPrRkl8CWdNMuv0TT4YvEiBJEhPJehr//ORirL+eTGl+RjjXcNVnNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B811F000E9;
	Thu, 18 Jun 2026 17:07:24 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: terry.bowman@amd.com,
	bhelgaas@google.com,
	jic23@kernel.org,
	djbw@kernel.org
Subject: [RFC PATCH v2 0/2] PCI/CXL: Add RDPAS support for CXL.io
Date: Thu, 18 Jun 2026 10:07:20 -0700
Message-ID: <20260618170723.2010490-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Added multiple DSP per RCEC support.
- Added boundary checks for reading MMIO
- Addressed issues raised by shashiko
- See individual patches for detailed changes

The series add RCEC Downstream Port Assocation Structure (RDPAS) parsing
support to CXL.io. RDPAS is an ACPI table that is part of the CXL Early
Discovery Table (CEDT) defined in CXL specification r4.0 9.18.1.5. It
provides the mapping between RCEC and downstream ports. With RDPAS, the
error device can be directly found when an error is reported on RCEC,
without walking a number of RCiEP in order to determine which one reported
the error. While CXL.cachemem is supported by RDPAS, there is no easy way
to discover the source id of the error and therefore finding the Linux PCI
object for the RCiEP. The intention here is to accelerate the discovery
of the error by directly locating the error device with the given
information.

This series is based on top of Terry's CXL error protocol series [1].
Looking for comments on the series WRT if it makes sense to add on top
of Terry's error handling for RCH/RCD devices.

[1]: https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowman@amd.com/T/#t


Dave Jiang (2):
  PCI/CXL: Add RDPAS parsing support
  PCI/CXL: Enable usage of RDPAS to shortcut error device discovery

 drivers/cxl/acpi.c             |   5 +
 drivers/pci/pcie/aer_cxl_rch.c | 271 ++++++++++++++++++++++++++++++++-
 include/cxl/ras.h              |  18 +++
 3 files changed, 291 insertions(+), 3 deletions(-)
 create mode 100644 include/cxl/ras.h


base-commit: a558d1571c0b3bb6b4a830cb2cd8f128cc5ef3e1
-- 
2.54.0


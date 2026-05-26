Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D0403EA6;
	Tue, 26 May 2026 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819816; cv=none; b=Cnp4vH+jMrvJPiFkK2RVt6AMAhEvoDad8lAHLu0AVGTQggwYV/1WBn6EXzjtcbrCv3aLQAxD4Lv1sLuiRvpsF3ioY4N7RQtyjYJGr1G6gGq53U6O0fOJbAhUF5WFy7J7jGk8+jCOKPYmgvYqpQyhIojtFTorayFgcgp0j6wVCIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819816; c=relaxed/simple;
	bh=HR7eMr6jMQMi4wv2V8NRkkyNzfVldtiBLNsuhqoSU8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/d7b5fklcdSxlUBbF1uhdSmkSQiuG0zTAwL8uj+ToMZTVh8QbP0hXEZg61H8SKaALVRdBaYnqVQt0vxZOEdIUHzjXdbtO/4vNGaebzPoaNqxWhs/BTVHCGARCfQst2FTikxBBsgizRkxjj/tDbWNeXs9bvl8/V7y8k7Qy9NpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484171F000E9;
	Tue, 26 May 2026 18:23:35 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: terry.bowman@amd.com,
	bhelgaas@google.com,
	jic23@kernel.org,
	djbw@kernel.org
Subject: [RFC PATCH 0/2] PCI/CXL: Add RDPAS support for CXL.io
Date: Tue, 26 May 2026 11:23:32 -0700
Message-ID: <20260526182334.1010870-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/pci/pcie/aer_cxl_rch.c | 190 ++++++++++++++++++++++++++++++++-
 2 files changed, 192 insertions(+), 3 deletions(-)


base-commit: 721d08f9e0f07f8f1b93e7767762b565f088cdcd
-- 
2.54.0


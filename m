Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07087404E;
	Wed, 12 Aug 2026 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564089; cv=none; b=kyiK9jiEczH/TVXYGCLYFvzK97G3FN4Tjmwd81qUQEckmD45uHweRAe90jpRg/OuacG49B7W/9UJM6wSx3WLqSuGWVwIZxdVNejHiMxjDmuahfQ32vtb2+9xX6x/wKFxJsY/rYt+EoiNRgs05TvOLFwDnEWmWQELhzpQPPPm7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564089; c=relaxed/simple;
	bh=doVuSDT3SHyTs77s6X1YtZXjKFJcAa02zFCbKKo9hio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TVGXTDzUXYYWcPWGU71AGXkRZJEO5gJgSxMV0eZxtp5MtkENGmP36bH2146ErlDzMDbjhKgv+8V2krnC9D+gbbg2fshb11mquVx7HtELbtPZIAoL8ZAzevicTzlN+nCl8DHZHOHR9BRrDrrwyM+XFfVrNyJ1Gm1lxpe7/SxQySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J65Lagfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J65Lagfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACA91F000E9;
	Wed, 12 Aug 2026 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564088;
	bh=8NhpWmxABwm4VuRgMk0XpvLIeJxGbhLlRcTBash3Sio=;
	h=From:To:Cc:Subject:Date;
	b=J65LagfioFVVP0FZDWE9FHmPLDQBOmQk0YGOtSP/yGQHY0Cuprr9StQa2X8bGrfCr
	 nxOEv2eSvU6RexGSsSDCq0psrfXHib4qYd7xVyw0YW0D9yH98grAZrD3P6gwBpG+0a
	 baySkf7TT1jYDd5jbSKxrFS5lbuAFZH1dbTAG/udypnWqLt/BnncXKC5lcRblwh4ki
	 xwcTXqWCGCj9SaZM26ZWso0CqQftJtQ2xhufsdRut8JrriVm9xp6lJi3egIX+jNxR+
	 LvxDc4cVQ5Dve/2R/yILk3NZMprHUGhho5uIM9/5xz2hNSXjj8y571vXQ4agRJi3Am
	 sANGHKyjXm7rw==
From: Leon Romanovsky <leon@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: [PATCH RFC 0/7] PCI/HMAT: Describe P2PDMA reachability and performance
Date: Wed, 12 Aug 2026 22:47:37 +0300
Message-ID: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260715-hmat-p2p-eb4971a9d731
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

Linux derives P2PDMA reachability from visible PCI topology, ACS
configuration, and a host-bridge whitelist. It cannot describe conditional
or slower cross-host-bridge paths; passthrough can hide the physical peer
relationships.

This RFC series implements the proposed ACPI HMAT Type 3 extension below.
Directional Generic Port matrices describe reachability, ordering, latency,
and bandwidth. Linux uses ordered paths to authorize P2PDMA and their
latency/bandwidth to rank providers. A VMM could translate these matrices
into guest domains; that is outside this series.

  HMAT Type 3 structure

  Field               Offset       Bytes  Meaning
  ---------------------------------------------------------------
  Type:                    0           2  value 3
  Length:                  4           4  entire structure
  Flags:                   8           1  traffic classes
  Data-type:               9           1  metric selector
  Initiators:             12           4  Generic Port count (s)
  Targets:                16           4  Generic Port count (t)
  Base-unit:              24           8  ps or MB/s; non-zero
  Initiator-PDs:          32         4*s  proximity-domain list
  Target-PDs:         32+4*s         4*t  proximity-domain list
  Matrix:         32+4*(s+t)       2*s*t  directional Entry[i][j]
  Reserved: bytes 2-3, 10-11, and 20-23

  Flags: encoding
    bit 0  non-UIO
    bit 1  UIO

  Metrics: selector
    0/1/2  access/read/write latency
    3/4/5  access/read/write bandwidth

  Direction: Initiator PD[i] -- Entry[i][j] metric --> Target PD[j]

----------------------------------------------------------------------
Based on [PATCH v3 00/17] PCI/P2PDMA: Fix ACS egress control handling
https://lore.kernel.org/all/20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com/

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Leon Romanovsky (7):
      ACPICA: Define PCIe P2P latency and bandwidth information
      ACPI: HMAT: Make PCIe P2P paths available to consumers
      PCI/P2PDMA: Authorize HMAT-described cross-host-bridge P2P
      PCI/P2PDMA: Prefer providers with better HMAT performance
      ACPI: HMAT: Add KUnit tests for PCIe P2P matrix semantics
      PCI/P2PDMA: Add KUnit tests for HMAT policy boundaries
      PCI/P2PDMA: Add KUnit tests for HMAT provider ranking

 drivers/acpi/numa/Kconfig     |  13 ++
 drivers/acpi/numa/Makefile    |   1 +
 drivers/acpi/numa/hmat.c      | 245 +++++++++++++++++++++-
 drivers/acpi/numa/hmat_test.c | 223 ++++++++++++++++++++
 drivers/acpi/numa/hmat_test.h |  17 ++
 drivers/pci/Kconfig           |  14 ++
 drivers/pci/Makefile          |   1 +
 drivers/pci/p2pdma.c          | 300 ++++++++++++++++++++------
 drivers/pci/p2pdma_test.c     | 477 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  23 ++
 include/acpi/actbl1.h         |  27 ++-
 include/linux/acpi.h          |  26 +++
 12 files changed, 1298 insertions(+), 69 deletions(-)
---
base-commit: bc5261fca94dd94ab557cc0852ce465d9c3ab8b0
change-id: 20260715-hmat-p2p-eb4971a9d731

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


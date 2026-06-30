Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FC3EF0AC
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815353; cv=none; b=H9K8/34iRgjzbo/sd0apWBngMHqD6ec59nQZwXsVEKG2jPlpgzfSfPDit7j7fre5LEmm4zUxA7x/UNlf1DjjNMG4Vxnkz2VedB9lKIjgCXtTIQ/TlnhdhsFnwYe8Rdc9NNRzCs/zB0Jkb3lpzd3oU8skduuWDPdW9Qqt17GsZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815353; c=relaxed/simple;
	bh=KwSti1DlASa1sCNXt731KfJ/O52x1xo9X4zUVfSrZVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VWU0RNST7HMtl5FF/Dmkg1hF4osYzy4xH4afcz0JukU3hsfh8B3hWR/2cyXEuDQTGFzdBOH1WHTH+T83rrUuB8Tq0H6LeyznT7BJz1Tz2GGAkVr3woSg04cWTB9+IqoGDco8hZAKDKOcgcqef+sHI/BJ+rm4d1BRuQjJG23qNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yn1IOezO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yn1IOezO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DB3181A0D52;
	Tue, 30 Jun 2026 10:29:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ABE876025A;
	Tue, 30 Jun 2026 10:29:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA16A106F1D67;
	Tue, 30 Jun 2026 12:28:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782815348; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2+4EIv0ap2LV6fiDnp6t4LPD90S9eUNPfjd5B/AGdlQ=;
	b=yn1IOezOhnkCQGU0ICAdPFsgGnmpf8LaAOhU1pbktDa+NIFYReQaXzs/NQ3fdB/bAOm6eU
	7mJM+CEfdXfVbBu5+CzXgZW4EBeMiHG1UvhbO8lmYnrX9eNvrsRwqLlasbHFRC+NGRfsTL
	F3av+Io0fudhjx1TOM538rXRX4NPCCABplyFAPjKRQPGe3eJ3Tnhhgir5RO2qqUVCRhL/v
	B38ibFBNYtIYrZV+Ci9ARuMGYuKlECeXjuvejEfPZ20NavCEMas6RjzYW+I7Otg4Yc1jyL
	KTfOOUJnmpv/4cYbuTD+eauSTctmc5Ivh4dIBNcXtr2FqbgS6tUQNXV/3TYwMg==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Herve Codina <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v8 0/8] lan966x pci device: Add support for SFPs, PCI part
Date: Tue, 30 Jun 2026 12:27:54 +0200
Message-ID: <20260630102804.413563-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Previously, I sent a big picture series adding support for SFP ports
available on the LAN966x PCI device [0].

In this series patches touch several parts and sub-system in the kernel.
Reviews have be done and it makes sense to split the series and send
parts separately.

This current series is the extraction of patches related to issues in
the PCI subsystem. It has to be seen as a continuation of the big
picture series but related to this specific core part.

Patches 1 to 6 introduce and use fw_devlink_set_device() in already
existing code. No functional change but the introduction of the
fw_devlink_set_device() wrapper.

Patches 7 and 8 fix fw_devlink issues specific to PCI and the
device-tree nodes created during enumeration.

[0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Best regards,
Hervé

Changes:

v7 -> v8
  v7: https://lore.kernel.org/all/20260511155930.34604-1-herve.codina@bootlin.com/

  Rebase on top of v7.2-rc1

  - patches 4 and 5
    Add 'Reviewed-by: Andy Shevchenko'

  - Other Patches
    No other changes

v6 -> v7

  Rebase on top of v7.1-rc1

  - Patch 1
     Add Cc stable. Needed for patches 11 and 12

  - Patches 2 to 5
    No changes

  - Patch 6
     Add Cc stable. Needed for patch 13
     Add 'Acked-by: Bjorn Helgaas'

  - Patch 7
     Fix a typo in commit log
     Add Fixes tag + Cc stable
     Add 'Acked-by: Bjorn Helgaas'

  - Patch 8
     Add Fixes tag + Cc stable
     Add 'Acked-by: Bjorn Helgaas'

Older iterations:
  Patches 6 to 13 in the big picture series
  https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Herve Codina (8):
  driver core: fw_devlink: Introduce fw_devlink_set_device()
  drivers: core: Use fw_devlink_set_device()
  pinctrl: cs42l43: Use fw_devlink_set_device()
  cxl/test: Use device_set_node()
  cxl/test: Use fw_devlink_set_device()
  PCI: of: Use fw_devlink_set_device()
  PCI: of: Set fwnode device of newly created PCI device nodes
  PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge
    node

 drivers/base/core.c                      |  4 ++--
 drivers/pci/of.c                         | 10 ++++++++--
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c |  2 +-
 include/linux/fwnode.h                   |  6 ++++++
 tools/testing/cxl/test/cxl.c             |  4 ++--
 5 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.54.0


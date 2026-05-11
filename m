Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF2D2E2DF3;
	Mon, 11 May 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515189; cv=none; b=JlctPGI8MLQZLqAQIzT5jSEA9LTQKaOEgsCtZfzMBAOxA5KiNPtBHryJnAX6BfaFBUDn/QP87wKzANkO4Og5JbJTBdr6pqr2ckCnn+NSDn5UwH8l+tHt+uZuSGMk9n9avZjccmF2THdB2cze2kBtlg0XentAg2GnSboPgYvz4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515189; c=relaxed/simple;
	bh=IvYGVBdGBDKMK1xIEzBMh1/yy9kpR/D9yP4RW3+Cb/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gDxQ7Yn7qop317RBVLUbJ2R0Ef4iceb6N7MD/UXsU1Sk63qatQ+5Z8WTdqc3PfQgRTTlAu/cwtu4kMF/0AspNzndtoouL6pJB6FJWRBrwMfDWAdVhXb9Xdzb/is/nbfWmDZ2jlSp2pPTiB5l5cOmC1r0N8kTSBx22wzYs/K5hZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IQ5mHGnc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IQ5mHGnc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D3BAFC5E14B;
	Mon, 11 May 2026 16:00:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C5C860646;
	Mon, 11 May 2026 15:59:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87FEF11AF9E9C;
	Mon, 11 May 2026 17:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778515184; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=eyQuJkmyZiTdEHXz6zRZYqjFxw0mC3xdzkEgzi4rk8I=;
	b=IQ5mHGncyHb+/IETZMBUYIZ588GI8J3VHGp1xBdPYtBr0TGez1t8FjwGCar5iJFePtQBM+
	c1w2lgPYjjpfbeqjHn4tgPEGvoGN5f1vZyzR1q88lJYdu8qmN9ga+JlTT0VNMkZ+VkS/rl
	5ASFVFZPdYWdLGdLVl9r81+GwLfcKb7BK+0tamiMld/D4ST0BTDW6A7FF0Sn2U39VcnIcH
	ssz4UxZjm9ncSNDhUZUhg0H9A+tsNCt/5iQyWEVf5a6pQFkM7mURY2tW+AibDT0PbmNc2B
	ttx2lS52bzHhqp0o8SHhYkNR7eWhR5uhFs85oOi6GBhab/iFq0BKksqnOuj4cQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
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
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>,
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
Subject: [PATCH v7 0/8] lan966x pci device: Add support for SFPs, PCI part
Date: Mon, 11 May 2026 17:59:20 +0200
Message-ID: <20260511155930.34604-1-herve.codina@bootlin.com>
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

v6 -> v7

  Rebase on top v7.1-rc1

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


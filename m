Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721378;
	b=SNwjWnw/csOcy4FqqvGIIE34dKczrusMONFG6WhRMFrsvjeVHLagYcIk9R4coi2ctI75
	 gYt4IIBNTUroX82Lsp7iTX1H0ovuo1FWXmCBnfLZsuscor7Vb9yx9SOH6ACDGVTJGPEKr
	 rcnaIrbGwR4Qu9PDg+A9vIB4Eg5YMd3Q8fyr0M19uPuvkNQEMjn6M9KkGJHegyO4Gs5pz
	 hzUulzRSjYE0tK9VZhZ40TxyZQboS54jzfZmvxj8+18eE71Rbx7x1Hm0USVYTsSZ+aeuO
	 jdQI/GKpN2YSOG0TuX4PJuvMq62ezA79Tm6C0vJesscssga1VPjhk2Bh55DGNm8eu+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721378;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=eVE0ejZ3ci2yxPN6jCZmDS8n1PcFDNfCthsFocfpEwA=;
	b=dFsPwBoPoEMPIYkvWDzkOjYAE8NY97tej6QGk+45GGxcbrvt5UJ1El05iHJE1tOIjn3R
	 E3Ecf2CrF1bo+++E41s1ys5gWZtUZwjFop/oL0xAj+UxFhe8NCVkkDIfnWIZF8wg3qDNg
	 DD9ATiscqY60FdjW8txG9Lr+2buQGUqFUpcgLQX1OX52rrZCd7xMneN0IdMwBK1dksxua
	 aVD0HYgW9TRp3AST34HuMSEg0knrmSTjIpdoqKkgbe8c85vbTlnGA764S6uw0PwievzV+
	 6RsExJ2x6Kll5/sNYChEmTbXCtgyvdQBPKOlvCdeOZX2yzR6egNZ1ChTghGdnGwS3AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ENgVUUZy;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2C606D80C;
	Tue,  3 Nov 2026 15:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F2C606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ENgVUUZy
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 009C24E413DC;
	Tue,  3 Nov 2026 15:56:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BA2D06046C;
	Tue,  3 Nov 2026 15:56:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AE71103291E1;
	Tue,  3 Nov 2026 16:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793721370; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=eVE0ejZ3ci2yxPN6jCZmDS8n1PcFDNfCthsFocfpEwA=;
	b=ENgVUUZywDfvbrAKMBEOf/3VPdoxopBV5nEzTM5Vj2CPKkOqinuuuiU2HLjlRyNpKIMRe2
	y1KsG2q9tX0Zx4jTtO9So1iLEtT4yyDzQiugA9rIadmmyH8vN4pABb4gnLmH3E1zsdiebD
	yiaF04vnpPDPQ/5c+Sh3jKHe4j9GD9C00L2EPQSV7TbGmeE/NZ91j7p4zEFEcFqU/+7zTd
	UXUjl0pjlpQ2HYQaFhGmn52V1wOpbh83X09mPZjCQI5sH+1PevdXNKQ9RWtKdiC2Q0GGQ+
	xr7xUVmALdFV898oJKdz8KinfU5MMcvmjoimFmyknmW/dYllXYHrGPK5EYACag==
From: Herve Codina <herve.codina@bootlin.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Lizhi Hou <lizhi.hou@amd.com>
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
Subject: [PATCH v14 00/10] lan966x pci device: Add support for SFPs, PCI part
Date: Tue,  3 Nov 2026 16:55:06 +0100
Message-ID: <20261103155540.365294-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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

Patch 7 avoids a dangling pointer.

Patches 8 and 9 fix fw_devlink issues specific to PCI and the
device-tree nodes created during enumeration.

Patch 10 avoids the usage of np->data and adds guards to prevent
incorrect nodes removal.

[0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Best regards,
Hervé

Changes:

v13 -> v14
  v13: https://lore.kernel.org/all/20261012142826.159178-1-herve.codina@bootlin.com/

  Rebase on top of v7.4-rc1

  - Patches 1, 2, 6, 8, 9
    Add 'Tested-by: Abdurrahman Hussain'

  - Patch 10:
    Add 'Acked-by: Bjorn Helgaas'

  - Other patches:
    No changes

v12 -> v13
  v12: https://lore.kernel.org/all/20261001142815.277550-1-herve.codina@bootlin.com/

  - Patches 1 to 9
    No changes

  - Patch 10
    Split a test condition into two distinct checks as suggested by
    Andy. No functional change but readability improvement. Split done
    in both of_pci_remove_node() and of_pci_remove_host_bridge_node().

v11 -> v12
  v11: https://lore.kernel.org/all/20260909080114.591938-1-herve.codina@bootlin.com/

  - Patches 1 to 7
    Add 'Reviewed-by: Bartosz Golaszewski'

  - Patches 8 and 9
    No changes

  - Patch 10
    Add a NULL check for the retrieved OF node in removal functions to
    avoid any NULL pointer dereferences.
    Robustify the guard setting cset to NULL after freeing it.
    Those issues have been reported by Shashiko:
    https://lore.kernel.org/all/20260909081755.444E91F00A3A@smtp.kernel.org/

v10 -> v11
  v10: https://lore.kernel.org/all/20260717145147.823749-1-herve.codina@bootlin.com/

  Rebase on top of v7.3-rc1

  - Patches 1 to 5
    Add 'Reviewed-by: Richard Cheng'

  - Patches 6, 7 and 8
    Add 'Reviewed-by: Richard Cheng'
    Add 'Acked-by: Manivannan Sadhasivam'

  - Patch 9
    Add 'Reviewed-by: Richard Cheng'

  - Patch 10
    Rework removing np->data usage in the PCI devicetree node creation
    and removal.

v9 -> v10
  v9: https://lore.kernel.org/all/20260708100302.517792-1-herve.codina@bootlin.com/

  - Patches 1 to 6
    No changes

  - Patch 7
    Clear fwnode->dev also on error path.

  - Patch 8
    Clear fwnode->dev also on error path.

  - Patch 9
    No changes

  - Patch 10 (New patch in v10)
    Guard against node removal with incorrect np->data.

v8 -> v9
  v8: https://lore.kernel.org/all/20260630102804.413563-1-herve.codina@bootlin.com/

  - Patch 7 (new patch in v9)
    Clear fwnode->dev during root bridge node removal (avoid a dangling
    pointer).

  - Patch 8 (patch 7 in v8)
    Clear fwnode->dev during PCI device node removal.

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

Herve Codina (10):
  driver core: fw_devlink: Introduce fw_devlink_set_device()
  drivers: core: Use fw_devlink_set_device()
  pinctrl: cs42l43: Use fw_devlink_set_device()
  cxl/test: Use device_set_node()
  cxl/test: Use fw_devlink_set_device()
  PCI: of: Use fw_devlink_set_device()
  PCI: of: Clear fwnode->dev during root bridge node removal and error
    path
  PCI: of: Set fwnode device of newly created PCI device nodes
  PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge
    node
  PCI: of: Avoid np->data usage for the node changeset

 drivers/base/core.c                      |  4 +-
 drivers/pci/of.c                         | 52 ++++++++++++++++--------
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c |  2 +-
 include/linux/fwnode.h                   |  6 +++
 include/linux/pci.h                      | 11 +++++
 tools/testing/cxl/test/cxl.c             |  4 +-
 6 files changed, 58 insertions(+), 21 deletions(-)

-- 
2.56.0


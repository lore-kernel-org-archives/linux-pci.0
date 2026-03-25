Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130E3DD537
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449392; cv=none; b=IA/MkthaOjFoKq63Qd2MXwjXP7a10Bu3hEbjdyqVtRAAQNNScmgCl5qTFOjXFdg2yAD2yoIMseAKcH0sdsfoyYLf8vBRO+XNkeA5a0ziG3PNLFJZa7ba7gZWi5w2lB6iZSLrTjIyrcnC98ZxAjmis/+KtEosE9IFpYGZAPw+8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449392; c=relaxed/simple;
	bh=h+1fn0JZtGorBo0ABPL19TxQcTuEaOBq+JS480hET5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nDDBCXjIvlvJ01VQ92p8JcWe+tcskC3nIZBpEQDNyPX8GYu8mrNtgBa29+Ws7/8SpP0syNV4SIo2r53d6wbPuDVs8Fm0vM5WrUqb+0bsWBQpm8Ft+uwENkkzdUoYkLBPcW5H25MYwgvRq82ObqnIf+lugNlOS7rVFYst7PHL6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J+8+Gs8z; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J+8+Gs8z"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 37EA21A2FE3
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 14:36:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFAAF601FA;
	Wed, 25 Mar 2026 14:36:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98EC410451411;
	Wed, 25 Mar 2026 15:36:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774449382; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=uBAGq5C1sgN0aQkVYFS2CmcP2NtxLPIN/F46TQ7SNrI=;
	b=J+8+Gs8zMYMCtm/Qdzmg2Hr6g5pApWDWLucUyxvfXdcvlPlNyDOfD3rSSXO47DWsaJQYUY
	Q2bNunnNpFXAm1kEuVGvPVAStFTHKbqUtkbDipBe5lLNi+DK46ujDXE1sVgz24PdXlbOlD
	AjSi7maL6WLULJie2U4+fRM4lN/4WJld5CVaTE0f0b4E+5IUh9IV/9/IVEMaARQktqDLt4
	qi5X74AgTTudS+/E9I1KlNz4ZUHOv3eE9tY/KkoGXo1TujVLVTD3TV+mUX9TlEpwJDUV2v
	Jyy4kZVmRsIygLl8994rGRZHdmZVKlRypPftf199xb5zK2QUNSgH1/Mm/Gm95w==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Arnd Bergmann <arnd@arndb.de>,
	Herve Codina <herve.codina@bootlin.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 00/27] lan966x pci device: Add support for SFPs
Date: Wed, 25 Mar 2026 15:35:27 +0100
Message-ID: <20260325143555.451852-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
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

This series add support for SFPs ports available on the LAN966x PCI
device. In order to have the SFPs supported, additional devices are
needed such as clock controller and I2C.

As a reminder, the LAN966x PCI device driver use a device-tree overlay
to describe devices available on the PCI board. Adding support for SFPs
ports consists in adding more devices in the already existing
device-tree overlay.

With those devices added, the device-tree overlay is more complex and
some consumer/supplier relationship are needed in order to remove
devices in correct order when the LAN966x PCI driver is removed.

Those links are typically provided by fw_devlink and we faced some
issues with fw_devlink and overlays.

This series gives the big picture related to the SFPs support from
fixing issues to adding new devices. Of course, it can be split if
needed.

The first part of the series (patch 1 and 2 ) fixes fw_devlink when it
is used with overlay. Those patches were previously sent by Saravana
[0]. I rebased them on top of v7.0-rc1.

Also I added a call to driver_deferred_probe_trigger() in Saravana's
patch (patch 2) to ensure that probes are retried after the modification
performed on the dangling consumers. This allows to fix issues reported
by Matti and Geert [2] with the previous iteration patches.

Those modification were not sufficient in our case and so, on top of
that, patches 3 to 5 fix some more issues related to fw_devlink.

Patches 6 to 11 introduce and use fw_devlink_set_device() in already
existing code.

Patches 12 and 13 are related also to fw_devlink but specific to PCI and
the device-tree nodes created during enumeration.

Patches 14, 15 and 16 are related fw_devlink too but specific to I2C
muxes. Patches purpose is to correctly set a link between an adapter
supplier and its consumer. Indeed, an i2c mux adapter's parent is not
the i2c mux supplier but the adapter the i2c mux is connected to. Adding
a new link between the adapter supplier involved when i2c muxes are used
avoid a freeze observed during device removal.

Patch 17 adds support for fw_delink on x86. fw_devlink is needed to have
the consumer/supplier relationship between devices in order to ensure a
correct device removal order. Adding fw_devlink support for x86 has been
tried in the past but was reverted [1] because it broke some systems.
Instead of enabling fw_devlink on *all* x86 system, enable it on *all*
x86 except on those where it leads to issue.

Patches 18 and 19 allow to build clock and i2c controller used by the
LAN966x PCI device when the LAN966x PCI device is enabled.

Patches 20 to 24 are specific to the LAN966x. They touch the current
dtso, split it in dtsi/dtso files, rename the dtso and improve the
driver to allow easier support for other boards.

The next patch (patch 25) update the LAN966x device-tree overlay itself
to have the SPF ports and devices they depends on described.

The last two patches (patches 26 and 27) sort the existing drivers in
the needed driver list available in the Kconfig help and add new drivers
in this list keep the list up to date with the devices described in the
device-tree overlay.

We believe some items from the above list can be merged separately, with
no build dependencies. We expect:

 - Patches 1 to 5 to be taken by driver core maintainers

 - Patches 6 to 11 to be taken by driver core maintainers

 - Patches 12 and 13 to be taken by driver core or PCI maintainers
  (depend on patch 6)

 - Patches 14 to 16 to be taken by I2C maintainers

 - Patch 17 to be taken by driver core or OF maintainers

 - Patch 18 to be taken by clock maintainers

 - Patch 19 to be taken by I2C maintainers

 - Patches 20 to 27 to be taken by misc maintainers

Once again, this series gives the big picture and can be split if
needed. Let me know.

Compare to previous iteration, this v6 series mainly drop the patch
renaming get_dev_from_fwnode() to get_device_from_fwnode().

[0] https://lore.kernel.org/lkml/20240411235623.1260061-1-saravanak@google.com/
[1] https://lore.kernel.org/lkml/3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de/
[2] https://lore.kernel.org/all/072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com/

Best regards,
Hervé

Changes:

v5 -> v6
  v5: https://lore.kernel.org/lkml/20260227135428.783983-1-herve.codina@bootlin.com/

  - Patch 2 in v5:
    Removed

  - Patch 2 (3 in v5):
    Use get_dev_from_fwnode() due to renaming removal (patch 2 removed)
    Fix typos in comments
    Add 'Tested-by: Kalle Niemi'
    Add 'Tested-by: Geert Uytterhoeven'

  - Patch 6 (7 in v5):
    Add details in commit log
    Add 'Reviewed-by: Charles Keepax'

  - Patch 8 (9 in v5):
    Add 'Reviewed-by: Charles Keepax'
    Add 'Acked-by: Linus Walleij'

  - Patch 9 (10 in v5):
    Add 'Reviewed-by: Jonathan Cameron'

  - Patch 10 (11 in v5):
    Add 'Reviewed-by: Jonathan Cameron'

  - Other patches:
    No changes.

v4 -> v5
  v4: https://lore.kernel.org/lkml/20251015071420.1173068-1-herve.codina@bootlin.com/

  - Patch 2:
    Add 'Acked-by: Ulf Hansson'

  - Patch 3:
    Add a call to driver_deferred_probe_trigger()

  - Patch 5: (new patch)
    Depopulate devices at remove

  - Patch 6:
    Populate devices at probe.
    Switched back to modification proposed in v3

  - Patch 7 in v3 removed

  - Patch 7 (8 in v4):
    Add 'Reviewed-by: Andy Shevchenko'
    Add 'Reviewed-by: Ulf Hansson'

  - Patch 8 (9 in v4):
    Add 'Reviewed-by: Ulf Hansson'

  - Patches 9 to 15 (10 to 16 in v3)
    No changes

  - Patch 16 (17 in v4):
    Add 'Reviewed-by: Andi Shyti'

  - Patch 17 (18 in v4):
    Change an error code from -EINVAL to -ENODEV
    Add a blank line and fix a typo in commit log

  - Patch 18 (19 in v4):
    Simplify of_is_fwnode_add_links_supported().
    Move IS_ENABLED(CONFIG_X86) check in of_is_fwnode_add_links_supported().

  - Patches 19 to 21 (20 to 22 in v4)
    No changes

  - Patch 22 (23 in v4)
    Update due to simple-platform-bus removal

  - Patches 23 to 28 (24 to 29 in v4)
    No changes

v3 -> v4
  v3: https://lore.kernel.org/lkml/20250613134817.681832-1-herve.codina@bootlin.com/

  - Patch 1:
    No change

  - Patch 2:
    Update and fix conflicts. Indeed, since v3 iteration
    get_dev_from_fwnode() has been moved to device.h and used by
    pmdomain/core.c.

  - Patch 3:
    remove '#define get_device_from_fwnode()'

  - Patch 4:
    Fix conflict (rebase v6.17-rc6)
    Add 'Reviewed-by: Rafael J. Wysocki'
    Add 'Reviewed-by: Saravana Kannan'

  - Patch 5 (new in v4):
    Introduce simple-platform-bus (binding)

  - Patch 6 (5 in v3):
    Rework patch and introduce simple-platform-bus

  - Patch 7: (new)
    Use simple-platform-bus in LAN966x

  - Patch 8 (6 in v3):
    - No change

  - Patch 9 and 10 (7 and 8 in v3):
    Add 'Reviewed-by: Andy Shevchenko'

  - Patch 11 and 12 (9 and 10 in v3):
    Add 'Reviewed-by: Dave Jiang'

  - Patch 13 (11 in v3):
    Add 'Reviewed-by: Andy Shevchenko'

  - Patch 12 in v3:
    Patch removed.
    Adding __private tag in fwnode.dev is going to be handled in a
    dedicated series. Indeed a test robot reported an issue and more
    patches are needed (I have missed fwnode.dev users in several part
    in the kernel).

  - Patch 14 and 15 (13 and 14 in v3):
    No change

  - Patch 16 (14 in v3):
    Add 'Reviewed-by: Andi Shyti'

  - Patch 17 and 18 (16 and 17 in v3):
    No change

  - Patch 19 (18 in v3):
    Filter out support for fw_devlink on x86 based on some device-tree
    properties.
    Rewrite commit changelog
    Remove 'Reviewed-by: Andy Shevchenko' (significant modification)

  - Patch 20 (19 in v3):
    Add 'Acked-by: Stephen Boyd'

  - Patch 21 (20 in v3):
    Fix conflict (rebase v6.18-rc1)

  - Patches 22 to 24 (21 to 23 in v3):
    No change

  - Patch 25 (24 in v3):
    Fix conflict (rebase v6.18-rc1)
    Add 'Acked-by: Bjorn Helgaas'

  - Patches 26 to 29 (25 to 28 in v3):
    No change

v2 -> v3
  v2: https://lore.kernel.org/all/20250507071315.394857-1-herve.codina@bootlin.com/

  - Patch 1:
    Add 'Acked-by: Mark Brown'

  - Patch 2 and 3:
    No changes

  - Patch 4:
    Rewrite the WARN_ON() condition to avoid an additional 'if'

  - Patch 5:
    Fix typos in commit log
    Update a comment
    Remove the unneeded check before calling of_platform_depopulate()

  - Patches 6 to 11:
    No changes

  - Patch 12 (new in v3)
    Tag the fwnode dev member as private

  - Patch 13 (12 in v2)
    Fix a typo in the commit log

  - Patches 14 to 16 (13 to 15 in v2)
    No changes

  - Patch 17 (16 in v2)
    Check parent_physdev for NULL

  - Patch 18 (17 in v2)
    Capitalize "Link:"
    Add 'Reviewed-by: Andy Shevchenko'

  - Patch 19 (18 in v2)
    No changes

  - Patch 20 (19 in v2)
    Add 'Acked-by: Andi Shyti'

  - Patch 21 (20 in v2)
    No changes

  - Patch 22 (21 in v2)
    Add 'Reviewed-by: Andrew Lunn'

  - Patch 23 (22 in v2)
    Add 'Reviewed-by: Andrew Lunn'

  - Patch 24 (new in v3)
    Introduce PCI_DEVICE_ID_EFAR_LAN9662, the LAN966x PCI device ID

  - Patch 25 (23 in v2)
    Add 'Reviewed-by: Andrew Lunn'
    Use PCI_DEVICE_DATA() with PCI_DEVICE_ID_EFAR_LAN9662 instead of
    PCI_VDEVICE()

  - Patch 26 to 28 (24 to 26 in v2)
    No changes

v1 -> v2
  v1: https://lore.kernel.org/lkml/20250407145546.270683-1-herve.codina@bootlin.com/

  - Patch 1 and 3
    Remove 'From' tag from the commit log

  - Patch 2
    Add 'Reviewed-by: Andy Shevchenko'
    Add 'Reviewed-by: Saravana Kannan'
    Add 'Reviewed-by: Luca Ceresoli'

  - Patch 4 and 5
    No changes

  - Patch 6 (new in v2)
    Introduce fw_devlink_set_device()

  - Patch 7 (new in v2)
    Use existing device_set_node() helper.

  - Patch 8 to 11 (new in v2)
    Use fw_devlink_set_device() in existing code.

  - Patch 12 (6 in v1)
    Use fw_devlink_add_device()

  - Patch 13 (7 in v1)
    No changes

  - Patch 14 (8 in v1)
    Update commit log
    Use 'physdev' instead of 'supplier'
    Minor fixes in i2c_get_adapter_physdev() kdoc

  - Patch 15 and 16 (9 and 10 in v1)
    Use 'physdev' instead of 'supplier' (commit log, title and code)

  - Patch 17 (11 in v2)
    Enable fw_devlink on x86 only if PCI_DYNAMIC_OF_NODES is enabled.
    Rework commit log.

  - Patch 18, 19 and 20 (12, 13 and 14 in v1)
    No changes

  - Patch 21 (new in v2)
    Split dtso in dtsi/dtso

  - Patch 22 (new in v2)
    Rename lan966x_pci.dtso using the specific board name

  - Patch 23 (new in v2)
    Improve the driver introducing board specific data to ease support
    for other boards (avoid the direct dtbo reference in the function
    loading the dtbo).

  - Patch 24 (15 in v1)
    Refactor due to dtso split in dtsi/dtso

  - Patch 25 (new in v2)
    Sort exist driver list in Kconfig help

  - Patch 26 (16 in v1)
    Keep alphanumeric order for new drivers added in Kconfig help

Herve Codina (25):
  driver core: Avoid warning when removing a device while its supplier
    is unbinding
  bus: simple-pm-bus: Remove child devices when the bus is unbound
  bus: simple-pm-bus: Populate child nodes at probe
  driver core: fw_devlink: Introduce fw_devlink_set_device()
  drivers: core: Use fw_devlink_set_device()
  pinctrl: cs42l43: Use fw_devlink_set_device()
  cxl/test: Use device_set_node()
  cxl/test: Use fw_devlink_set_device()
  PCI: of: Use fw_devlink_set_device()
  PCI: of: Set fwnode device of newly created PCI device nodes
  PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge
    node
  i2c: core: Introduce i2c_get_adapter_physdev()
  i2c: mux: Set adapter physical device
  i2c: mux: Create missing devlink between mux and adapter physical
    device
  of: property: Allow fw_devlink device-tree on x86
  clk: lan966x: Add MCHP_LAN966X_PCI dependency
  i2c: busses: at91: Add MCHP_LAN966X_PCI dependency
  misc: lan966x_pci: Fix dtso nodes ordering
  misc: lan966x_pci: Split dtso in dtsi/dtso
  misc: lan966x_pci: Rename lan966x_pci.dtso to
    lan966x_evb_lan9662_nic.dtso
  PCI: Add Microchip LAN9662 PCI Device ID
  misc: lan966x_pci: Introduce board specific data
  misc: lan966x_pci: Add dtsi/dtso nodes in order to support SFPs
  misc: lan966x_pci: Sort the drivers list in Kconfig help
  misc: lan966x_pci: Add drivers needed to support SFPs in Kconfig help

Saravana Kannan (2):
  Revert "treewide: Fix probing of devices in DT overlays"
  of: dynamic: Fix overlayed devices not probing because of fw_devlink

 MAINTAINERS                               |   3 +-
 drivers/base/core.c                       |  90 +++++++++--
 drivers/bus/imx-weim.c                    |   6 -
 drivers/bus/simple-pm-bus.c               |  24 +--
 drivers/clk/Kconfig                       |   2 +-
 drivers/i2c/busses/Kconfig                |   2 +-
 drivers/i2c/i2c-core-base.c               |  16 ++
 drivers/i2c/i2c-core-of.c                 |   5 -
 drivers/i2c/i2c-mux.c                     |  26 ++++
 drivers/misc/Kconfig                      |  11 +-
 drivers/misc/Makefile                     |   2 +-
 drivers/misc/lan966x_evb_lan9662_nic.dtso | 167 ++++++++++++++++++++
 drivers/misc/lan966x_pci.c                |  30 +++-
 drivers/misc/lan966x_pci.dtsi             | 172 +++++++++++++++++++++
 drivers/misc/lan966x_pci.dtso             | 177 ----------------------
 drivers/of/dynamic.c                      |   1 -
 drivers/of/overlay.c                      |  15 ++
 drivers/of/platform.c                     |   5 -
 drivers/of/property.c                     |  26 +++-
 drivers/pci/of.c                          |  10 +-
 drivers/pci/quirks.c                      |   2 +-
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c  |   2 +-
 drivers/spi/spi.c                         |   5 -
 include/linux/fwnode.h                    |   7 +
 include/linux/i2c.h                       |   3 +
 include/linux/pci_ids.h                   |   1 +
 tools/testing/cxl/test/cxl.c              |   4 +-
 27 files changed, 572 insertions(+), 242 deletions(-)
 create mode 100644 drivers/misc/lan966x_evb_lan9662_nic.dtso
 create mode 100644 drivers/misc/lan966x_pci.dtsi
 delete mode 100644 drivers/misc/lan966x_pci.dtso

-- 
2.53.0


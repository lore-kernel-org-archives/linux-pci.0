Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0F4C33C4;
	Wed, 30 Sep 2026 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779842; cv=none; b=nD441e3P7wR6BCYK/MhvZFT7CGvRtF/aKijZsvlItcRvBf/N0bzIiAMGsEqgT131nINQJUEYjLXYZn0CACAkkZdms92Qm+ragW6aF1X+PkS2czDD1XnS+lBoKXp+Ect1P/0vHHG40fMp9DEtnBQXPeiTK3dgwG5U/5oynbpFpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779842; c=relaxed/simple;
	bh=4f/zH8Vejg6Bbx/LyQB/pVdfyu+jeCAEK50lJV8X280=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXOyCgF3qq71WE5NygzmSGiZQYekYrhOxMn3w7REs98QRHHWD4Mq3ybS2vPqdREEY45Sd5bE7S8bMH3QKo3butTH7QetYhq7YM+v8YaSKPJHI3nWgxxWkyCJ0epoZYMyccgOnF51U9DcfgiINTLJgDHl41F5V5zSvB4sziRuG7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7RAmTcL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7RAmTcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EF21F000FF;
	Wed, 30 Sep 2026 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779832;
	bh=MpMdRzzckzLQv6ms4O5nsBqMxlFgsrLRkIfljQLs9Uo=;
	h=From:To:Cc:Subject:Date;
	b=N7RAmTcLq87p7qZDbuXnNjnG1RznhM5UmBdBEcMKoI5LVS/lZ8cTa2b3kFLDJ5oDz
	 AEAZSkIcThy9/b7CEFMYVsihwPFiVDS07+AzAUwMWs+bPN4cJ108GwbkhroG9wXQX1
	 RzKMuhcPwgHs8gVxU/k8GUTPCnGHh8rU+x2k6iFZbh2I0MenctauenfS4Cmskf0M/k
	 +vVuALf2MdOpJKAxWZ/uNyoCCrQQK143aefTvtFC4rxiOSBROo2Jn6Dy/3kjmNKcF6
	 0rg1FROGhMsOXFkKI/O+0jbdvrgBOF+/fCGoMM421QlpivyaHgzOJt3rWJ91af4bp9
	 nkJ3KlMoH5/Hg==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yue Wang <yue.wang@Amlogic.com>,
	Hans Zhang <18255117159@163.com>,
	Rob Herring <robh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Jon Mason <jdmason@kudzu.us>
Cc: Keith Busch <kbusch@kernel.org>,
	mx2pg@pm.me,
	dlemoal@kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh Vaidya <mahesh.vaidya@altera.com>,
	Ricardo Pardini <ricardo@pardini.net>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [RFC PATCH 0/4] PCI: Fix and improve default MPS configuration
Date: Wed, 30 Sep 2026 16:50:17 +0200
Message-ID: <20260930145017.1356088-6-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14974; i=cassel@kernel.org; h=from:subject; bh=4f/zH8Vejg6Bbx/LyQB/pVdfyu+jeCAEK50lJV8X280=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLL2Kq78+pRbuntpZ1tKtdrhOLUi/5VRnVrGdRz622fPC JwvvvZBRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACaSz8PIMGNZ5D8xiVq5x1fO nff5xFZqa/Bub6QA/1bRiINPgjIYLRgZdjGfSVBL0Vnq9H8tW2yG0oHJkxb1uUnVXTkdt//FIo1 53AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This RFC reworks Hans's series "PCI: Configure Root Port MPS during host
probing" (v9, link below).  Besides configuring Root Ports, which that
series was about, it fixes other problems in how mainline programs the
Maximum Payload Size (MPS), and lists the problems it doesn't fix.

It is an RFC because it changes the default MPS policy, see "Open
questions" below, and because it has only been build-tested so far.

Background
==========

A PCIe device must not send a TLP with a payload larger than the MPS it
is programmed with, and a receiver treats a TLP larger than its own MPS
as Malformed, so all devices on a path need compatible MPS settings.

Unless a "pci=pcie_bus_*" option is given, the kernel uses the default
strategy, PCIE_BUS_DEFAULT: pci_configure_mps() programs each device, as
it is enumerated, to the MPS of its upstream bridge.  If the device's MPS
Supported (MPSS) is smaller and the upstream bridge is a Root Port, the
Root Port is lowered instead (9f0e89359775).  The other strategies either
configure whole hierarchies in pcie_bus_configure_settings()
(pcie_bus_safe, pcie_bus_perf, pcie_bus_peer2peer) or don't touch MPS at
all (pcie_bus_tune_off).

Problems found in mainline
==========================

Enumeration:

1. The saved MPS goes stale.  Fixed by patch 1.

   pcie_set_mps() changes Device Control, but not the copy saved by
   pci_bus_add_device() and the port driver.  The core changes the MPS
   of ports whose state has been saved: pci_configure_mps() lowers a
   Root Port when a device that supports less is hot-added below it,
   and with pci=pcie_bus_safe, pcie_bus_configure_settings() can do the
   same after a hot-add.  Drivers do it too, e.g. hfi1 on its upstream
   bridge.

   Since v7.3-rc1 (3fc686d550f6), a Root Port reset through
   host->reset_root_port(), e.g. on AER recovery or Link Down with the
   qcom and Rockchip DWC drivers, restores the Root Port's saved state
   without saving it first.  The Root Port goes back to the old, larger
   MPS while the device below it is restored to the smaller one, and the
   device may receive TLPs that it treats as Malformed.

2. Root Ports keep whatever MPS they came up with.  Fixed by patch 3.

   Root Ports have no upstream bridge, so pci_configure_mps() never
   configures them, and every hierarchy inherits the MPS that firmware or
   the hardware reset left in its Root Port.  On platforms whose firmware
   doesn't configure MPS, which is typical for DT-based systems with
   native host controller drivers, every hierarchy runs at the 128-byte
   reset value even if the Root Port and all devices below it support
   more, at a cost in throughput.  Host controller drivers work around
   this: the Meson driver programs its Root Port to 256 bytes itself,
   regardless of what the devices below it support, which patch 4
   removes.

3. Lowering the MPS only works directly below a Root Port.  Fixed by
   patch 2.

   - Below a Switch, the Switch ports keep the larger MPS, and a device
     that supports less is left mismatched with a "use
     pci=pcie_bus_safe" warning.  This happens at boot whenever firmware
     or a host controller driver programmed a larger MPS than a device
     below a Switch supports.  It has been a known limitation since the
     default strategy was introduced (27d868b5e6cf).

   - For a multi-function device directly below a Root Port, function 0
     is programmed to the Root Port's MPS first.  If function 1 supports
     less, the Root Port is lowered, but function 0 is left at the larger
     value and can send TLPs larger than the Root Port now accepts.  Only
     an informational message about the Root Port is printed.  This was
     introduced by 9f0e89359775.

Hotplug and rescan:

4. A device hot-added directly below a Root Port.  Fixed by patches 1-3.

   If the device supports less than the Root Port's MPS, the Root Port
   is lowered, with the multi-function problem from 3 and the stale
   saved state from 1.  If it supports more, it is only matched to the
   Root Port's current MPS: a Root Port is never raised again, e.g.
   after a device that supported less has been replaced, and without
   firmware MPS setup it stays at 128 bytes.  Devices found by a rescan
   below an empty Root Port slot behave the same.

5. A Switch hot-added directly below a Root Port.  Fixed by patch 2.

   The Upstream Port can lower the Root Port, but the Downstream Ports
   and the devices below them are only matched to their upstream bridge,
   and any of them that supports less is left mismatched with a warning.
   With patch 2, nothing below the Root Port is in use yet, so the whole
   new hierarchy is lowered.  Devices hot-added below the new Switch
   later are subject to 6.

6. A device hot-added below a Switch.  Not addressed.

   The Switch ports are in use and can't be lowered, so a device that
   supports less than their MPS, e.g. less than what firmware
   programmed, is left mismatched with a warning.  pcie_bus_safe avoids
   this by limiting hierarchies with hotplug-capable Switch ports to 128
   bytes.  Patch 3 doesn't raise hierarchies with hotplug-capable Switch
   ports, so it doesn't make this more likely on hot-add, but a device
   that shows up below a Switch without hotplug support, e.g. found by a
   rescan, can hit it after patch 3 has raised the hierarchy.

7. A Switch hot-added below another Switch.  Not addressed.

   Same as 6, for every port and device of the new Switch that supports
   less than the Downstream Port it is plugged into, e.g. when chaining
   Thunderbolt devices.

8. A device added next to devices already in use below the same Root
   Port, e.g. a new function found by a rescan while function 0 is
   bound.  Only partly addressed.

   Mainline lowers the Root Port below the active function, which is
   left at the larger MPS.  With patch 2, the hierarchy isn't changed,
   and the new function is left mismatched with a warning instead.

Other:

9. With pci=pcie_bus_safe or pcie_bus_perf, devices found by a rescan
   aren't configured at all: pci_configure_mps() leaves them to
   pcie_bus_configure_settings(), which the rescan helpers don't call.
   This doesn't affect the default strategy, where pci_configure_mps()
   configures each device as it's enumerated.  Calling
   pcie_bus_configure_settings() from the rescan helpers wouldn't fix
   this safely, since those strategies reprogram every device of the
   hierarchy, including ones in use.  Not addressed.

Approach
========

Two constraints drive the design:

- The MPS of a device that may have a driver bound can't be changed
  safely: the device may have DMA in flight, its driver may have cached
  the value, and the core's read-modify-write of Device Control isn't
  serialized against the driver's own updates of that register.
  Changes to a hierarchy are therefore limited to hierarchies in which
  no device below the Root Port has been added or made available for
  driver binding yet, i.e. during the initial scan, or when devices are
  hot-added or rescanned into an empty hierarchy, such as a slot directly
  below a Root Port.  As today, the Root Port itself may still be
  changed.

- A device hot-added below a Switch later can't lower the MPS of a
  hierarchy in use, so it only works if it supports the MPS the
  hierarchy already runs at (6).

A better solution would be to quiesce the drivers of all devices below
the Root Port, e.g. the way a reset does with ->reset_prepare() and
->reset_done(), change the MPS of the whole hierarchy, and then resume
them.  That would allow changing the MPS of a system that is in use,
including when a device that supports less is hot-added below a Switch
(6, 7) or next to devices in use (8), and patch 3 could then also raise
hierarchies with hotplug-capable Switch ports.  It requires every
affected driver to support being quiesced and to cope with a changed
MPS, e.g. drivers that cache it, which is beyond this series.

Only PCIE_BUS_DEFAULT changes; the other strategies are unchanged.

Why the Root Port MPS is set from pcie_bus_configure_settings()
===============================================================

v9 raised each Root Port to its maximum MPS when pci_configure_mps() ran
for the Root Port itself, and relied on lowering it again as devices
below it were enumerated.  At that point, nothing below the Root Port
has been enumerated yet, so the kernel can't know the smallest MPSS
below it, whether the hierarchy has hotplug-capable Switch ports, or
whether the slot is empty.  Raising the Root Port there:

- raises hierarchies with hotplug-capable Switch ports, which can't be
  lowered again once a device that supports less is hot-added below the
  Switch (6).  Undoing the raise for them would mean remembering the
  previous MPS of every Root Port;

- raises empty slots, so a Switch hot-added into one later inherits the
  raised MPS;

- happens only once, since a Root Port isn't enumerated again on
  hot-add, so the Root Port can't be raised again after a device that
  supported less has been replaced (4).

pcie_bus_configure_settings() runs after the hierarchy below a Root Port
has been scanned and before its drivers are bound: from pci_host_probe()
and the ACPI and arch-specific root bus scans, and from pciehp, acpiphp
and shpchp after a hot-add.  It is where the other strategies already
configure MPS for a whole hierarchy, and pcie_find_smpss() already
computes the smallest MPSS of a hierarchy, returning 128 bytes for
hierarchies with a hotplug bridge other than the Root Port.  Since patch
3 only raises, such hierarchies keep their MPS without any extra state.
An empty slot isn't raised until something is hot-added or rescanned
there, and every hot-add directly below a Root Port re-evaluates its
hierarchy.  The rescan helpers don't call pcie_bus_configure_settings(),
so patch 3 adds the same raise there.

Configuring the MPS in pci_bus_add_device() instead would also run after
the scan, but once per device rather than once per hierarchy, and it
would move all of the default MPS configuration into the driver binding
path.

Behavior changes
================

- With firmware that programs MPS, e.g. on x86, a hierarchy may now run
  at a larger MPS than firmware chose, and different Root Port
  hierarchies may end up with different values.  This could matter for
  peer-to-peer DMA between devices below different Root Ports, unless
  the Root Complex splits such TLPs.  pci=pcie_bus_peer2peer remains
  available for that case.

- A single device with a small MPSS found during enumeration lowers the
  MPS of every device below its Root Port.

- A device that shows up later below a Switch without hotplug support,
  e.g. found by a rescan, may find its hierarchy raised by patch 3, and
  is left mismatched with a warning if it supports less (6).

- Read completion coalescing is now also disabled on Intel 5000/5100 in
  the default mode (quirk_intel_mc_errata()), since the default mode can
  now raise MPS above what firmware programmed.

- Scan paths that call neither pcie_bus_configure_settings() nor the
  rescan helpers, mostly legacy ones or ones without Root Ports, don't
  raise anything, just as today.

Open questions
==============

1. Is raising a hierarchy above what firmware programmed acceptable for
   PCIE_BUS_DEFAULT, or should the raise be limited, e.g. to Root Ports
   that are still at the 128-byte reset value?

2. Hierarchies with hotplug-capable Switch ports keep their current MPS,
   so hot-add below a Switch behaves as today (6, 7).  The alternative is
   to limit such hierarchies to 128 bytes, like pcie_bus_safe does, which
   makes every hot-added device work, but costs performance where
   firmware programmed more.  Which is preferred?

3. Should a device that can't match a hierarchy in use (6, 7, 8) keep
   being bound with a warning, as today, or be left without a driver?

Testing
=======

Build-tested only: each patch builds without warnings with W=1 (x86_64
defconfig plus COMPILE_TEST and PCI_MESON), and checkpatch --strict is
clean.

Mahesh, Ricardo, Shawn: patch 3 is a new implementation, so I dropped
your Tested-by tags.  A re-test would be much appreciated.

---
Changes compared to v9:
- New patch 1: Update the saved MPS in pcie_set_mps(), so that a Root Port
  reset through host->reset_root_port() doesn't restore a stale MPS.
- Patch 2 (was 1): Only lower the hierarchy while no device below the
  Root Port has been added or made available for driver binding.  v9 also
  did it when a device was hot-added or rescanned below a Switch, changing
  the MPS of devices that may have drivers bound and DMA in flight, with
  an unserialized read-modify-write of Device Control that could race
  with their drivers' own updates (reported by sashiko-bot:
  https://lore.kernel.org/linux-pci/20260916155239.06ECC1F000FF@smtp.kernel.org/).
- Patch 2: Use pci_warn() with the same message as the rest of
  pci_configure_mps(), and reword the comment and commit message.
- Patch 3 (was 2): Reimplemented.  Instead of raising each Root Port to
  its maximum MPS during enumeration, raise the whole hierarchy after it
  has been scanned, from pcie_bus_configure_settings() and the rescan
  helpers, and only with PCIE_BUS_DEFAULT.  Hierarchies with a hotplug
  bridge other than the Root Port, and hierarchies in use, are left alone,
  so hot-add below a Switch keeps working as before.  v9 also changed the
  other strategies and could leave a rescanned Root Port above the MPS of
  the devices below it with pci=pcie_bus_safe.
- Patch 3: Apply the Intel 5000/5100 read completion coalescing quirk to
  PCIE_BUS_DEFAULT too, since it can now raise MPS above what firmware
  programmed.
- Patch 3: New subject and author, with Hans as co-developer, and dropped
  the Reviewed-by and Tested-by tags, since the implementation changed.
- Patch 4 (was 3): Use the "PCI: meson:" subject prefix.
- Rebase on v7.3-rc5.

v9: https://lore.kernel.org/linux-pci/20260916153907.60344-1-18255117159@163.com/

Hans Zhang (2):
  PCI: Match the hierarchy's MPS to a device's MPSS as necessary
  PCI: meson: Remove redundant MPS configuration

Niklas Cassel (2):
  PCI: Update saved Max Payload Size in pcie_set_mps()
  PCI: Configure Root Port MPS after scanning its hierarchy

 drivers/pci/controller/dwc/pci-meson.c |  25 +----
 drivers/pci/pci.c                      |  24 +++-
 drivers/pci/probe.c                    | 149 ++++++++++++++++++++++++-
 drivers/pci/quirks.c                   |   3 +-
 4 files changed, 172 insertions(+), 29 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0


Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B5436342;
	Mon, 20 Jul 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560116; cv=none; b=VCuLdVd/xW+05zuggWB3/+Cx7e1EppEEbiM/iPiFntcYVOIy9sLcGztTyF5Rq7A1wohmosqYH4HETJ+6DlkiPk9TjtTtH4ip6IUTlZpbqIYMwVyjREwFRx0doHk9/eXYvmQ4bTV0XT/MmngTrRR+8dKCbHlYPOIL5uI1hfkNfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560116; c=relaxed/simple;
	bh=5HZQA5URccZ3kIspyR81zZ4dz/7pSO2Ba6kQcERjTfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dw9k5YK/JLGB3JEGrVCk+Jz5yLXI/0KZFYHLRVDk2FqvyYrr0WZdPWMxL8zTDu3AaT68VUHx1jsDkgvjPtDLzqktRNqRxEO3sgddjAN6DjUZdIuBJZU8wykVHpHHt1KXZLS0orQxFSlTQIhLinAlAROd1x7rzYyHbx3MwxhPOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MnS4PMIW; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MnS4PMIW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jf
	+KfPnbSlEd5Caaq1yPzPWI1nsuoetMK6a5PKvV7zk=; b=MnS4PMIWi3Fxzeesdf
	QWICcqBmWL0CMHxDiwNrfoNeUrnS0Oo3n2gAQqdUPIesxXOLbbhTmEHOAv49JBIq
	jOzMFK+oSqH1agmp4i6Z+RPggBYsOsj72m4qHyQ3h19cJ+LR0HCtIAalgwJutOFT
	GqfAITMjuDKrDQDL6V6sRgmRw=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX+mO9OV5q8LEOKg--.8910S2;
	Mon, 20 Jul 2026 23:07:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 00/16] PCI: dwc: Cache PCIe capability offset and simplify drivers
Date: Mon, 20 Jul 2026 23:06:03 +0800
Message-Id: <20260720150619.24733-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX+mO9OV5q8LEOKg--.8910S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar4xWF43Ww15Kr4kCF18uFg_yoW7Aw4Dpa
	9IqrWSyr1ftr4avF4xA3WUZry5Cas3CFWUJ393Ww4fZFy3ua1UJr18CrWFyFy7KrWIvr13
	Kw4aqa4fuFykJFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zicdjtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B+vU2peOb91AgAA3K

Hi,

The DWC PCIe core and its many platform drivers repeatedly call
dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
PCI Express Capability structure. This is wasteful and makes the code
verbose. Some drivers even search for the offset in suspend/resume paths.

Add a cached pcie_cap field in struct dw_pcie and a helper
dw_pcie_get_pcie_cap() to initialize it once at the point when the
hardware is ready. Then replace all explicit capability searches with
the cached value across the entire dwc subtree.

**Safety analysis: DBI access timing**
The PCIe Capability offset is read from DBI configuration space. DBI
registers are only accessible after the controller's clocks, resets, and
power are enabled. The following call graph demonstrates that all
dw_pcie_find_capability() replacements occur only after hardware is ready:

- For Root Complex mode:
  dw_pcie_host_init()
    ...
    if (pp->ops->init)
      pp->ops->init   [enables clocks/resets]
    dw_pcie_get_pcie_cap()   [caches offset]
    ...
    dw_pcie_link_up
      pci->ops->link_up
    ...
    dw_pcie_start_link
      pci->ops->start_link
    ...
    pci_host_probe
    if (pp->ops->post_init)
      pp->ops->post_init
    ...

- For Endpoint mode:
  The core no longer automatically caches the offset in dw_pcie_ep_init().
  Instead, each EP driver must ensure hardware is enabled (clocks, power,
  PHY) before calling dw_pcie_get_pcie_cap(). Drivers like qcom-ep and
  tegra194 perform this in the PERST# deassert handler, where DBI is
  accessible. The helper will then cache the offset for subsequent uses.

- Some platform drivers (e.g., layerscape-ep) enable hardware themselves
  before calling dw_pcie_ep_init() and explicitly call
  dw_pcie_get_pcie_cap() to cache the offset early. This is safe.

Thus, no DBI access occurs before hardware is operational.

Changes in v3:
- Remove automatic caching from dw_pcie_ep_init() to prevent unclocked
  DBI access on EP platforms (qcom-ep, tegra194).
- Add explicit dw_pcie_get_pcie_cap() calls in qcom-ep and tegra194 EP
  paths after hardware enablement.
- Keep Host mode caching unchanged.
- Update commit messages accordingly.

Changes in v2:
- Move dw_pcie_get_pcie_cap() from the beginning of dw_pcie_host_init()
  and dw_pcie_ep_init() to after the hardware initialization callbacks
  (host_init/pre_init). This can prevent the reading of DBI when the clock
  is turned off or when the hardware is not ready.
- Convert all platform drivers to use the cached offset via
  dw_pcie_get_pcie_cap() or directly pci->pcie_cap where safe.
- Fix type mismatches (u16 -> u8).
- Properly split per-driver modifications.

v1: https://patchwork.kernel.org/project/linux-pci/cover/20260509135152.2241235-1-18255117159@163.com/

v2: https://patchwork.kernel.org/project/linux-pci/patch/20260530153101.695580-1-18255117159@163.com/

---
**Why splitting into per-driver patches**  
To facilitate review and potential bisection, each platform driver is
modified in its own patch. The core changes are in patches 1-2, and
follow-up patches convert individual glue drivers. If maintainers prefer
to squash them, please let me know and I will merge in v3.

This splitting patch of each controller was carried out solely for
the convenience of code review.
---

Hans Zhang (16):
  PCI: dwc: Add pcie_cap field and helper in designware header
  PCI: dwc: Use cached PCIe capability offset in core
  PCI: dwc: imx6: Use cached PCIe capability offset
  PCI: dwc: layerscape-ep: Use cached PCIe capability offset
  PCI: dwc: meson: Use cached PCIe capability offset
  PCI: dwc: rockchip: Use cached PCIe capability offset
  PCI: dwc: eswin: Use cached PCIe capability offset
  PCI: dwc: fu740: Use cached PCIe capability offset
  PCI: dwc: intel-gw: Use cached PCIe capability offset
  PCI: dwc: qcom-ep: Use cached PCIe capability offset
  PCI: dwc: qcom: Use cached PCIe capability offset
  PCI: dwc: sophgo: Use cached PCIe capability offset
  PCI: dwc: spacemit-k1: Use cached PCIe capability offset
  PCI: dwc: spear13xx: Use cached PCIe capability offset
  PCI: dwc: tegra194: Use cached PCIe capability offset
  PCI: dwc: ultrarisc: Use cached PCIe capability offset

 drivers/pci/controller/dwc/pci-imx6.c         |  6 +++---
 .../pci/controller/dwc/pci-layerscape-ep.c    |  9 +++-----
 drivers/pci/controller/dwc/pci-meson.c        |  4 ++--
 .../pci/controller/dwc/pcie-designware-ep.c   |  2 +-
 .../pci/controller/dwc/pcie-designware-host.c |  2 ++
 drivers/pci/controller/dwc/pcie-designware.c  | 15 ++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  | 17 +++++++++++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  2 +-
 drivers/pci/controller/dwc/pcie-eswin.c       |  3 +--
 drivers/pci/controller/dwc/pcie-fu740.c       |  2 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 13 ++++++------
 drivers/pci/controller/dwc/pcie-qcom.c        | 21 ++++++++-----------
 drivers/pci/controller/dwc/pcie-sophgo.c      |  5 +++--
 drivers/pci/controller/dwc/pcie-spacemit-k1.c |  2 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  6 ++----
 drivers/pci/controller/dwc/pcie-ultrarisc.c   |  2 +-
 18 files changed, 61 insertions(+), 54 deletions(-)


base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.34.1


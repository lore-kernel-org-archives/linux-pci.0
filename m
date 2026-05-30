Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9432B9A9;
	Sat, 30 May 2026 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155107; cv=none; b=pZ+9RGGtSpuHTEQMBL1VQ17RsULfgK68eC7ugzFHhr5cG/UxXddwVJ8UCW89vbzwrKmFqOBptBwxmi8cAfYKghGJUsS4VMpDCDxyQmldSjTeIU5Oqi4Icb5qGHFzKzEN77Q8DsC5d7idLn7KQId4SVKlXowgS1SxhDAX3Zh0kcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155107; c=relaxed/simple;
	bh=fEK98gR/zB9gEFIBAqp/XvWYAqb+0sgLn2OwsqQIGzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCwjceeWBeQ1geNGjqTXtHysQJ7KQPqfuylkCUOGXnCNSkaN9gdyQ+VrTi9NNc7zz4F4aelAoG1lcll4gt1heBXDyy0XqGpCFe7T5EOs3XJQ+v1yxlvFNhIv/3IguvsScjxPwDCuhsk6qNtCveHKFIx9gfBU8+q6ssgKmoIVz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W+xeNbNS; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W+xeNbNS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Bj
	RgFojgsTnP1227FE9wENDhbHeKJ14NsArd5sJv8G8=; b=W+xeNbNSlMYgALNiYx
	flOCTEUzXCHXQK8oVYxyVZoI3f0hR4wk7DMoq70Un3OjZtYUQmPKYYlIukUFQQkP
	F1GlLid3FWNYj03SABw+Yyp3BebRR/dxFp7WdFHiFmtwpdUEt7QUj5zVcLGYtJDJ
	GC6QWvF1ygceWfWYJtH5L+NwM=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnfA+4AhtqjqjeAQ--.36562S2;
	Sat, 30 May 2026 23:31:04 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s-vadapalli@ti.com,
	a-garg7@ti.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 00/16] PCI: dwc: Cache PCIe capability offset and simplify drivers
Date: Sat, 30 May 2026 23:30:45 +0800
Message-Id: <20260530153101.695580-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnfA+4AhtqjqjeAQ--.36562S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWDCw43JF4ktw47WFykXwb_yoW7JFW8pa
	9IqrWSyr1ftr4avF4xA3WUZFy5uas3CFyUJ393Ww1SvFy3u3WUJr1rArWFyFy7Kr4Ivr13
	Kw12q34xuFWkJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ5rxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xoQs2obArovgQAA31

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
  dw_pcie_ep_init()
    ep->ops->pre_init()    [enables clocks/resets]
    dw_pcie_get_pcie_cap()   [caches offset]
    dw_pcie_ep_init_non_sticky_registers() etc.

- Some platform drivers (e.g., layerscape-ep, tegra194) need the offset
  before calling dw_pcie_ep_init() / dw_pcie_host_init(). They already
  enable hardware themselves and explicitly call dw_pcie_get_pcie_cap()
  before the core caches it. This is safe and ensures the cached value is
  available for all later users.

Thus, no DBI access occurs before hardware is operational.

Changes in v2:
- Move dw_pcie_get_pcie_cap() from the beginning of dw_pcie_host_init()
  and dw_pcie_ep_init() to after the hardware initialization callbacks
  (host_init/pre_init). This can prevent the reading of DBI when the clock
  is turned off or when the hardware is not ready.
- Convert all platform drivers to use the cached offset via
  dw_pcie_get_pcie_cap() or directly pci->pcie_cap where safe.
- Fix type mismatches (u16 -> u8).
- Properly split per-driver modifications.

v1:
https://patchwork.kernel.org/project/linux-pci/cover/20260509135152.2241235-1-18255117159@163.com/

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
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 +++-
 .../pci/controller/dwc/pcie-designware-host.c |  2 ++
 drivers/pci/controller/dwc/pcie-designware.c  | 16 ++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  | 17 +++++++++++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  2 +-
 drivers/pci/controller/dwc/pcie-eswin.c       |  3 +--
 drivers/pci/controller/dwc/pcie-fu740.c       |  2 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 11 ++++------
 drivers/pci/controller/dwc/pcie-qcom.c        | 21 ++++++++-----------
 drivers/pci/controller/dwc/pcie-sophgo.c      |  5 +++--
 drivers/pci/controller/dwc/pcie-spacemit-k1.c |  2 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  6 ++----
 drivers/pci/controller/dwc/pcie-ultrarisc.c   |  2 +-
 18 files changed, 61 insertions(+), 55 deletions(-)


base-commit: 3a97877d13e1a29c50ab15ed0a0aba87b75061dd
-- 
2.34.1


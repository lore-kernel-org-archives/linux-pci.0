Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34753B6358;
	Thu, 12 Mar 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333518; cv=none; b=Y8+MbMekhL4AGIXG8jieGkTKZPj2TuUYISua9fxNQXxigpdhNN8zG6Tzq1ZUStvnUBe3GuQvNw4I3BeDrlAYZw2fkQe+51fYFc6Hi9gKUfEJAsxRrbgy4JLf8wk4LF3sWfjueoVjPUEKmJDBcQDHQUhrDJD5jX1KA9ASBYONB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333518; c=relaxed/simple;
	bh=kODxDtOQSMCXadxfPZtHEcOmWfvK+dcy5EXMBryIzkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=je2qH6lqLLcQ8eMy1Bel3LPp9DgCSHl2LfsPrubqzE+/gWSAfXfAFi9KGYk14Mm6AMuj/xgTk4/JMHajrMqG7tuPAltpyNGq643k8NP/bNVMd4wL5O05gHXcOs3fIqxti8zeYfJqdlcR8n6xUIXgUSgSfc2WLVFJZxt/apHfUu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Fx4rGQ+B; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Fx4rGQ+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8E
	vM0/fxe3qhVy2cIm2e3+OU/a5wMM0wZxizsylbxeM=; b=Fx4rGQ+BR/AQxSnyUb
	GiEIQ9eGzXMr7qODTrbc7ib+c2KhF/xq3iGl3c3yXGb1kEqMHJ3312T6rOdPtx7V
	hO5aFOAjSMVvNTrFj5547oqgclXWawUDb2w9miKdDnI70jBgaIC57hhdXdOj4nCi
	6tISLMyAvQSyW53qvrCe7sIRA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnN1Gl67JpMC_OAQ--.12929S2;
	Fri, 13 Mar 2026 00:36:57 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	florian.fainelli@broadcom.com,
	jim2101024@gmail.com
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	claudiu.beznea.uj@bp.renesas.com,
	linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v8 0/5] PCI: of: Remove max-link-speed generation validation
Date: Fri, 13 Mar 2026 00:36:47 +0800
Message-Id: <20260312163652.113228-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN1Gl67JpMC_OAQ--.12929S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw1kuw1Utr15Zr4rKFW5Awb_yoWrWw1fpa
	y2yFWFyr1xJF43Za17J3WUua4Yg3ZxArWjkr93Ww17ZFnxCF47XrySgF4FvF9rKrW7Zr12
	q3W2q3W7KFyjyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piY0PfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wosz2my66rEWAAA3E

Hi,

This series moves the validation from the common OF function to the
individual PCIe controller drivers.  To protect against out-of-bounds
accesses to the pcie_link_speed[] array, we first introduce a helper
function pcie_get_link_speed() that safely returns the speed value
(or PCI_SPEED_UNKNOWN) for a given generation number.

Then all direct uses of pcie_link_speed[] as an array are converted to
use the new helper, ensuring that even if an invalid generation number
reaches those code paths, no out-of-bounds access occurs.

For several drivers that read the "max-link-speed" property
(pci-j721e, brcmstb, mediatek-gen3, rzg3s-host), we add an explicit
validation step: if the value is missing, out of range, or unsupported
by the hardware, a safe default is used (usually Gen2). Other drivers
(mainly DesignWare glue drivers) rely on the helper to safely handle
invalid values, but do not yet include fallback logic or warnings.

Finally, the range check is removed from of_pci_get_max_link_speed(),
so that future PCIe generations can be supported without modifying
drivers/pci/of.c.

---
Changes for v8:
- Expand series from 2 to 5 patches to introduce pcie_get_link_speed() helper
  and split validation into per-driver changes.
- Add pcie_get_link_speed() helper for safe pcie_link_speed[] array access (Bjorn)
- Move max-link-speed validation from DWC core to individual drivers; add explicit
  fallback logic only for pci-j721e, brcmstb, mediatek-gen3, rzg3s-host.
- Convert all remaining direct pcie_link_speed[] accesses to use the new helper.
- Update commit messages to reflect the new design.

Changes for v7:
https://patchwork.kernel.org/project/linux-pci/cover/20260308142629.75392-1-18255117159@163.com/
- Add validation in dw_pcie_get_link_speed() (Bjorn)
- Modify it so that two patches constitute one series.

Changes for v6:
https://patchwork.kernel.org/project/linux-pci/patch/20251218132036.308094-1-18255117159@163.com/

- It'd be good to return the actual errno as of_property_read_u32() can return
  -EINVAL, -ENODATA and -EOVERFLOW. (Mani)

Changes for v5:
https://patchwork.kernel.org/project/linux-pci/patch/20251218125909.305300-1-18255117159@163.com/

- Delete the check for speed. (Mani)

Changes for v4:
https://patchwork.kernel.org/project/linux-pci/patch/20251105134701.182795-1-18255117159@163.com/

- Add pcie_max_supported_link_speed.(Ilpo)

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/patch/20251101164132.14145-1-18255117159@163.com/

- Modify the commit message.
- Add Reviewed-by tag.

Changes for v2:
https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
- The following files have been deleted:
  Documentation/devicetree/bindings/pci/pci.txt

  Update to this file again:
  dtschema/schemas/pci/pci-bus-common.yaml
---

Hans Zhang (5):
  PCI: Add pcie_get_link_speed() helper for safe array access
  PCI: dwc: Use pcie_get_link_speed() helper for safe array access
  PCI: j721e: Validate max-link-speed from DT
  PCI: controller: Validate max-link-speed
  PCI: of: Remove max-link-speed generation validation

 drivers/pci/controller/cadence/pci-j721e.c       |  3 ++-
 .../pci/controller/dwc/pcie-designware-host.c    |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c     |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c    |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c        |  4 ++--
 drivers/pci/controller/dwc/pcie-qcom.c           |  6 +++---
 drivers/pci/controller/dwc/pcie-tegra194.c       |  2 +-
 drivers/pci/controller/pcie-brcmstb.c            |  5 +++--
 drivers/pci/controller/pcie-mediatek-gen3.c      |  2 +-
 drivers/pci/controller/pcie-rzg3s-host.c         |  2 +-
 drivers/pci/of.c                                 | 12 +++++++-----
 drivers/pci/pci.h                                |  2 ++
 drivers/pci/probe.c                              | 16 ++++++++++++++++
 13 files changed, 41 insertions(+), 19 deletions(-)


base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
-- 
2.34.1


Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D017A300;
	Sat,  9 May 2026 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332099; cv=none; b=tKaMD0f9cMOYl59yPUugm9Kz+UsOwvGB7P+3pJy4mtn4XAKnBQEKxWi22IIBFLJsDLHJkML+rtje/bKk62bldPIj0kS1HhNfWXxWqOxQXZEc090dT+mmaQhgEpQKGvpB1mckm/7luIfJeVVZWmy226CDLFqyA3Z/fUu1QjnYMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332099; c=relaxed/simple;
	bh=98r9WLuAHytESLUtwU1vVxui3Nc147TQaPdd9lQR7w8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0jXsvrLsU7TbQf6Yka8/qT4i0zQilxuBcoHHAR4SOOol1SVBAhOTzobLC7PHAPXaIEAqU+PxpbI6mSxi97FGK/NAB9dbu/KB395a6UQ9HEvukxurbjc7hIeHAAlyztgdk1fVrSq5SU9H8SLoVIZeTzTmZjlTDd22OaIJ3FwOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kCT50K8y; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kCT50K8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GZ
	7OyzAdhKWGVcDphPIJl2UJSbYecAlO2028/o8+Sbw=; b=kCT50K8ySJQh7ETAJM
	y31GsOU/7VwHoEPgyfQMMLhz59b2Ayt0aE7WhX0RecjeImLUaAMp6hUzBCnLKvg7
	7pPRnbY8C5HlH1S5mL7j3Ub0i3YYKwzLfDYyYyb8W/He3/gRXm6kxfWVcFz5X/D3
	T4a81mc+29Z44jUr6o+PXVZtE=
Received: from Precision-7960.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHYi+GMf9pRitfDA--.13014S2;
	Sat, 09 May 2026 21:07:20 +0800 (CST)
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
Subject: [PATCH v2 0/3] PCI: cadence: Fix and generalize PCIe capability offset for Root Port
Date: Sat,  9 May 2026 21:07:13 +0800
Message-Id: <20260509130716.2104103-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDHYi+GMf9pRitfDA--.13014S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1kZw4xGF45WF13Zr4ruFg_yoW8tw18pF
	Z8XFWfJr4xJrWava93Aa1jqF1Skas5Aa17XwsrKr1rAr13uryUKFsa93WUXF47GrZ2vr12
	v34DtasF9FnFvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piNeOJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAnIbGn-MYmd3QAA3H

The Cadence PCIe controller has two major IP generations: LGA (Legacy)
and HPA. In Root Port mode, their configuration space base addresses
differ (LGA requires an offset of 0x200000, HPA uses 0). Moreover, the
PCI Express Capability structure may not reside at the hardcoded offset
0xC0 across all SoC integrations.

This series fixes the Root Port configuration space accessors to
correctly handle the base offset on LGA IP, then introduces a helper
to dynamically find and cache the PCIe Capability offset, and finally
replaces all hardcoded uses of CDNS_PCIE_RP_CAP_OFFSET with the cached
value.

Patch 1 fixes the fundamental read accessors for RC mode on LGA IP.
Patch 2 adds the caching helper.
Patch 3 removes the hardcoded offset and uses the dynamic one.

These changes have been tested on:
- LGA-based platform (TI J7200, J721E) - confirmed by Aksh Garg.
- HPA-based platform (CIX Sky1) - capability search works normal.

Note: This series depends on the previously submitted "is_hpa" flag
introduction:
https://patchwork.kernel.org/project/linux-pci/patch/20260508034101.1910036-1-18255117159@163.com/

Changes since v1:
- Fixed critical bug in cdns_pcie_get_pcie_cap() where dw_pcie types
  were incorrectly used (suggested by Bjorn Helgaas).
- Corrected function comment and parameter description.
- Added defensive check (not included in this version, but recommended).

Hans Zhang (3):
  PCI: cadence: Fix Root Port configuration space access for LGA IP
  PCI: cadence: Add cdns_pcie_get_pcie_cap() helper and cache capability
    offset
  PCI: cadence: Use dynamic PCIe capability offset in host driver

 .../pci/controller/cadence/pcie-cadence-ep.c  |  5 +--
 .../cadence/pcie-cadence-host-common.c        |  4 +--
 .../cadence/pcie-cadence-host-hpa.c           |  2 ++
 .../controller/cadence/pcie-cadence-host.c    |  6 ++--
 .../cadence/pcie-cadence-lga-regs.h           |  1 -
 drivers/pci/controller/cadence/pcie-cadence.h | 31 ++++++++++++++++++-
 6 files changed, 41 insertions(+), 8 deletions(-)


base-commit: 917719c412c48687d4a176965d1fa35320ec457c
prerequisite-patch-id: 2db32bc3c7b72f1206f365606060da203bfd683a
prerequisite-patch-id: f37881f3d5564b7bdd5e0aee093a297e3e0a79c0
-- 
2.34.1


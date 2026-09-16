Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C759D612;
	Wed, 16 Sep 2026 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573207; cv=none; b=F73nbHImE/bSxTeL99x/7HTytXXTb3d8F49SW0qIP0Y4EDoiCRCUP4LGZNdtTwOe/hNseXMbozw8AFTsHlABMwK98FqBQ6UCM+7dlKnoctsNq3Ij56yf6wJzBVyerKAlHniTvoSabvvExXd2icrKlpHrugLFptCh+od1yJtVSkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573207; c=relaxed/simple;
	bh=NgSijkFu4u5PjT9y5jVHH2/rZwkdksk1hXKeQgMWr70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GFZUhn5DeFFFVgPTlJbU3sHmBGbJqhMV6T4kE8fTclJcqiufGminze93+FinwkV+Or1hFa+/TkLVe2EcClh/z7A921tCXileTJd+JnpSZHzZ033nOxO7xqPzDNOr96yh9VqnSUG+vPNXDuRyIuY6cNcFGWqr37knD6UpI9Q0ZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QS0V/U/g; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QS0V/U/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iW
	vwV0Yb3kbxokRESrXjcOjAU5pqGLAd63JQ2bS+4jo=; b=QS0V/U/giChb2KR5sQ
	V+yWTFSjAoudfwbEijimVCSMr1afHSjxX/Tyb23a+NMLNa8yXADc5efgLNfbdm7A
	8EBmG0hGd+7ZXkpBhhJ/IXV+EnjCbX2b8Zl1Nm0H8ZS3iXCHiB3k6rG7AONIgcNe
	jVpFfRN1d7XtvxD4j5slmRFq8=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnbxQduKpqGzAlBA--.54876S2;
	Wed, 16 Sep 2026 23:39:10 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	heiko@sntech.de,
	mani@kernel.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v9 0/3] PCI: Configure Root Port MPS during host probing
Date: Wed, 16 Sep 2026 23:39:04 +0800
Message-Id: <20260916153907.60344-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbxQduKpqGzAlBA--.54876S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWUZr4xKry7trW8JrWfAFb_yoWrCryUpF
	WFqFsagrs7Gry3Ga17Cw42kFyYgws3A3y5Jw45K34fZF4YvF1jqrWv9F4Fvry7Xr4ag3WI
	qFZFq34Fkw1jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi0JP_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxB56HmqquB5tiAAA39

Current PCIe enumeration configures each device's Maximum Payload Size
(MPS) top-down to match its upstream bridge.  Root Ports, however, return
early from pci_configure_mps() because they have no upstream bridge, so
their MPS may remain at firmware defaults and fail to use the controller's
full capability.

There is also a hierarchy problem when a device's MPS Supported (MPSS) is
smaller than the MPS already programmed above it.  The existing reduction
only lowers a Root Port.  If a Switch is in between, the Switch ports keep
the larger MPS and the endpoint is left mismatched, which can cause
Malformed TLPs.

This series addresses both issues:

1. Patch 1 fixes pci_configure_mps() so that when a device's MPSS is
   smaller than the MPS already in use above it, the whole Root Port
   hierarchy is reduced as necessary, including Switch ports and
   already-programmed sibling devices.

2. Patch 2 safely initializes Root Port MPS to its maximum supported value
   during host probing.  Patch 1 ensures this larger initial value is
   reduced again when downstream devices require a smaller MPS.
   PCIE_BUS_TUNE_OFF and PCIE_BUS_PEER2PEER are left untouched.

3. Patch 3 removes the now-redundant Meson PCIe driver MPS programming and
   cleans up the resulting dead macros and misleading MRRS helper name.

---
Changes in v9:
- Add patch 1 to reduce the whole Root Port hierarchy when a downstream device
  has a smaller MPSS, addressing the Switch case reported by sashiko.
- Patch 2 keeps the Root Port max-MPS initialization, adds error handling, and
  relies on patch 1 for later reduction.
- Patch 3 drops PCIE_CAP_MAX_PAYLOAD_SIZE and MAX_PAYLOAD_SIZE, renames
  meson_size_to_payload() to meson_size_to_mrrs(), and updates the warning.

Changes in v8:
https://patchwork.kernel.org/project/linux-pci/patch/20260911132145.211380-1-18255117159@163.com/

- Rebase to v7.3-rc1.

Changes in v7:
https://patchwork.kernel.org/project/linux-pci/cover/20251127170908.14850-1-18255117159@163.com/

- Exclude PCIE_BUS_PEER2PEER mode from Root Port MPS configuration
- Remove redundant check for upstream bridge (Root Ports don't have one)
- Improve commit message and code comments as per Bjorn.

Changes for v6:
https://patchwork.kernel.org/project/linux-pci/patch/20251104165125.174168-1-18255117159@163.com/

- Modify the commit message and comments. (Bjorn)
- Patch 1/2 code logic: Add !bridge check to configure MPS only for Root Ports
  without an upstream bridge (root bridges), avoiding incorrect handling of
  non-root-bridge Root Ports (Niklas).

Changes for v5:
https://patchwork.kernel.org/project/linux-pci/patch/20250620155507.1022099-1-18255117159@163.com/

- Use pcie_set_mps directly instead of pcie_write_mps.
- The patch 1 commit message were modified.

Changes for v4:
https://patchwork.kernel.org/project/linux-pci/patch/20250510155607.390687-1-18255117159@163.com/

- The patch [v4 1/2] add a comment to explain why it was done this way.
- The patch [v4 2/2] have not been modified.
- Drop patch [v3 3/3]. The Maintainer of the pci-aardvark.c file suggests
  that this patch cannot be submitted. In addition, Mani also suggests
  dropping this patch until this series of issues is resolved.

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/patch/20250506173439.292460-1-18255117159@163.com/

- The new split is patch 2/3 and 3/3.
- Modify the patch 1/3 according to Niklas' suggestion.

Changes for v2:
https://patchwork.kernel.org/project/linux-pci/patch/20250425095708.32662-1-18255117159@163.com/

- According to the Maintainer's suggestion, limit the setting of MPS
  changes to platforms with controller drivers.
- Delete the MPS code set by the SOC manufacturer.
---

Hans Zhang (3):
  PCI: Match the hierarchy's MPS to a device's MPSS as necessary
  PCI: Configure Root Port MPS during host probing
  PCI: dwc: Remove redundant MPS configuration

 drivers/pci/controller/dwc/pci-meson.c | 25 ++----------
 drivers/pci/probe.c                    | 53 ++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 26 deletions(-)


base-commit: 08df884136f1c1197bab2a27814404fd329d9aac
-- 
2.34.1


Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75627F010;
	Thu, 30 Apr 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566290; cv=none; b=oQXOp8aaAQkVfrq1BwLMFQqQZYbgFgjfjwA4IoqDvT636t1F2SLO4AVSs0aVhCm9wGcTVwH3bG0LV7ZV4Rk3kau8e1nxF+0TqgPZi9MjYZ6JH3PEHyIMvNEUlWqOrw1Aci5GiWp3HtYBTtMg6nvJ99wEOKekWF06mPFMbNsYgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566290; c=relaxed/simple;
	bh=XYlepJ2zg8v2sfg25HgD6d5qLoil4AuAtFUxxV1iqBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K0KaOxqFhX9z8E2Koia7qszpdIFa8tPIDahlPhyUYDY4u4WWTiA+uigX2FMOIWILc1ub5xtrUNgM9V+m6TjomjP3wPdmSl68Btnr7X1bqN/6G3/tMARlFs5ZAsRLjt50loR8rlhq6Rld8jdZwneatcqLHYObpWPZKSFrwDDNQIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M2QEUZxc; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M2QEUZxc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sW
	KKnHbzkHVqsnzjDuIPGOuEmQVnvRdiBjV7VHlqOFA=; b=M2QEUZxcB2fAXoFy2P
	JP1FwEybW/jSUG7hVRO1F2+Vqohan8Bn+2a5teRN2aDWKSWCiKPHxKl6Nl7WfgHk
	G/qI7zpC/hQsxwuEHOCdCCF+lD2MD4n09O1HWvUPmK5LhyoNLRMocGtF1p7yWCKd
	ap91t7gw2pFJ3kdZ4mWW9hEqQ=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHJXM2gvNpY8PXCg--.48992S2;
	Fri, 01 May 2026 00:24:23 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	s32@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [RESEND PATCH 00/16] PCI: Use FIELD_MODIFY() to simplify bitfield operations
Date: Fri,  1 May 2026 00:24:04 +0800
Message-Id: <20260430162420.42839-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHJXM2gvNpY8PXCg--.48992S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar43Kr17CF1xWFW7tFyDAwb_yoW8uFy3pa
	y5KFyxZF18tr45ZF43Xa10kas0vFnYkFyUKa9Fg3srW3ZxCrWjgrWUtFyrtr9xJFW8uFyU
	Kw1Ut34UGFs3JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGNtxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BcFqGnzgjdMXAAA3p

Replace open-coded bitmask clear + FIELD_PREP() sequences with the
dedicated FIELD_MODIFY() macro.  FIELD_MODIFY() performs the same
operation but is shorter, less error-prone, and includes compile-time
checks to prevent field overflow.

This series touches the PCI core, PCIe extended capabilities (PTM, IDE,
TPH, MSI, REBAR, IOV, CardBus), and several DesignWare-based and
other PCI host controllers.  No functional change is intended.

The patches are split per subsystem or per driver to ease review:
---
Hi, If the Maintainers think it's not necessary, please ignore it.
---

Hans Zhang (16):
  PCI: Use FIELD_MODIFY()
  PCI/PTM: Use FIELD_MODIFY()
  PCI/IDE: Use FIELD_MODIFY()
  PCI/IOV: Use FIELD_MODIFY()
  PCI/TPH: Use FIELD_MODIFY()
  PCI/MSI: Use FIELD_MODIFY()
  PCI/REBAR: Use FIELD_MODIFY()
  PCI/CARDBUS: Use FIELD_MODIFY()
  PCI: al: Use FIELD_MODIFY()
  PCI: eswin: Use FIELD_MODIFY()
  PCI: s32g: Use FIELD_MODIFY()
  PCI: tegra194: Use FIELD_MODIFY()
  PCI: qcom: Use FIELD_MODIFY()
  PCI: dwc: Use FIELD_MODIFY()
  PCI: mvebu: Use FIELD_MODIFY()
  PCI: mediatek-gen3: Use FIELD_MODIFY()

 drivers/pci/controller/dwc/pcie-al.c          | 12 ++----
 .../controller/dwc/pcie-designware-debugfs.c  | 23 ++++-------
 .../pci/controller/dwc/pcie-designware-ep.c   |  3 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  3 +-
 drivers/pci/controller/dwc/pcie-eswin.c       |  3 +-
 drivers/pci/controller/dwc/pcie-nxp-s32g.c    |  3 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c | 40 +++++++------------
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +--
 drivers/pci/controller/dwc/pcie-tegra194.c    |  8 ++--
 drivers/pci/controller/pci-mvebu.c            |  3 +-
 drivers/pci/controller/pcie-mediatek-gen3.c   |  3 +-
 drivers/pci/ide.c                             |  6 +--
 drivers/pci/iov.c                             |  3 +-
 drivers/pci/msi/msi.c                         | 11 ++---
 drivers/pci/pci.c                             |  3 +-
 drivers/pci/pcie/ptm.c                        |  3 +-
 drivers/pci/rebar.c                           |  6 +--
 drivers/pci/setup-cardbus.c                   |  3 +-
 drivers/pci/tph.c                             | 10 ++---
 19 files changed, 51 insertions(+), 101 deletions(-)


base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
-- 
2.34.1


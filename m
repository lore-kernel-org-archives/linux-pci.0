Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F373BFE3F;
	Fri,  1 May 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777649803; cv=none; b=qCQgEldYyYN5uZAmyx42cXV4fHLD6ZhWTTs/whpjTeqyxXq1d2ALPJ7NNhoNNg8mnglRqQc4ODdUeEZDX6p7K1vf195aIRUbAltkmUaT1L7xsG2Zj1aNo/CAtYCX3K/L4hUyice83Napq2OCSDY+33wliZPSZ4zPbiSUJhJM/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777649803; c=relaxed/simple;
	bh=yQK8COgpW/fV6si1NNCHZeFrAK4MGBklWXRBqbL4QVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UAydWP2XH5rtYT6t6oXmUzZ/e2tGh2oXtHRcTOkKBvBAl1TI+Qrbr8vJWBPbV/A1VfohubG0Dx8YWGwPmb5jDFYqe5oJPILzxo/hRT6tr+7fldQNWZ9Z+bRMtvTQVvpZvERaHPOmwHCvTDypKA5sGSz3UJMxdP6qIs6u1aKG9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ioo1Aime; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ioo1Aime"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uR
	tlnL49pKeZCApCiJ/CvbaZOCEdzedFqtleNnlK0c0=; b=ioo1AimeJkcaKRj8Fj
	IrKD3TGc5GOVSIZgoPTkXi5LkY98r4n09UEesWcztOhKXK7RycZWuiHHtRHuR/VP
	IL4tMeVchuWTWHo2rSGcWak9r2li1ZQM+IoaWlpmcKGAm3d6dsSpzQVsd2kfCuXV
	23L2nV6FRS82iKj7Vm9l7E/DA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCH4HBbyPRpuOd_Cw--.58479S2;
	Fri, 01 May 2026 23:35:56 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vigneshr@ti.com
Cc: robh@kernel.org,
	s-vadapalli@ti.com,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/2] PCI: cadence: Add 100 ms delay after link up for speeds > 5 GT/s
Date: Fri,  1 May 2026 23:35:51 +0800
Message-Id: <20260501153553.66382-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH4HBbyPRpuOd_Cw--.58479S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWfKFW8Zr18uF4kWr48WFg_yoW8Zr18pa
	y5Wr4FkFn7Ww4avan7Z3W7Zry5uFn5J3y3Kr4kKa4Iq3sxCr93JF1IqFnaqayagFs5Zr12
	yw1qqasrCFsxuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGjg7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBzghGn0yFzAdgAA3D

As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
training completes before sending a Configuration Request.

The same requirement has already been addressed for the Synopsys
DesignWare PCIe controller in commit 80dc18a0cba8d ("PCI: dwc: Ensure that
dw_pcie_wait_for_link() waits 100 ms after link up").

This series implements the required delay for the Cadence PCIe controller.

Patch 1 introduces a 'max_link_speed' field in struct cdns_pcie and adds
the delay logic in cdns_pcie_host_wait_for_link(). Since max_link_speed
defaults to 0, the delay is not yet triggered. This patch prepares the
infrastructure and references the DWC implementation.

Patch 2 sets the max_link_speed value in the TI J721E glue driver based
on the maximum supported link speed (obtained from the device tree
"max-link-speed" property), thereby activating the delay when the
controller supports speeds greater than 5 GT/s.

Other Cadence-based glue drivers can be updated similarly in follow-up
work.

---
Our company's product is based on the HPA IP from Cadence. When connecting
to different devices, we encountered issues with the enumeration failure
when connecting to the NVIDIA RTX5070 GPU and the NVMe SSD with PCIe 5.0
interface. Our code is based on: 80dc18a0cba8d ("PCI: dwc: Ensure that
dw_pcie_wait_for_link() waits 100 ms after link up").
---

Hans Zhang (2):
  PCI: cadence: Ensure that cdns_pcie_host_wait_for_link() waits 100 ms
    after link up
  PCI: j721e: Set max_link_speed to enable 100 ms delay after link up

 drivers/pci/controller/cadence/pci-j721e.c               | 1 +
 .../pci/controller/cadence/pcie-cadence-host-common.c    | 9 +++++++++
 drivers/pci/controller/cadence/pcie-cadence.h            | 2 ++
 3 files changed, 12 insertions(+)


base-commit: e75a43c7cec459a07d91ed17de4de13ede2b7758
-- 
2.34.1


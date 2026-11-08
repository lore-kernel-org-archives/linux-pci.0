Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794130887;
	b=dtyiW8p2SPhk6fLJV3LRsxq6JYsb3SdK3BODXSeJpLJjgDs2vtzItDKHiBmvSuqGOPb7
	 a67xW9bULow0eTsZDzCS4awkH9fQUpOk13MWWeKqWQqHbQWX1kvVaPpPIbED0KD3s01IR
	 +mJWGBb+W4iDyOw70A712agkB7UIVufCPdmjo9v8Y2y6Tn3Xgw3R2T5SCnpRM4JA/qiRA
	 l6mOz3SNX4zaEI7JOofJS+6lx8A6dSkG/xHnnrZr4ihLslAnlGC7stK4CgMbVqKdxmDNN
	 goduzMlINLetJDahyDwHqq33PouwxQMcQvj+KpihEyHBeZX7aREog+D2iIomxVRb1Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794130887;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=l+50H9UydDgvjDUOodm6tPmjOieLyAKe00ss8qncm54=;
	b=W4bqEcOzuRGtD56jhH5xwQpwSVwYVhNn4t49feE2fGxTRd6DMYdc5RmC2mVeUrPP1zUw
	 QY2MtaPsRsULgezpgNfKLe2e5cYzvBTK3Lms1EhdzdAr+8Wk+7gT2cIhZWwzqCJDv/0y8
	 QdeLACkU67qYWhcaQmpfW16Sw1pS6iMDLvPQss0x5BGDEzQB3bW5oeMaJz9ypOUKmYR/1
	 2Cjfs+QHjvmvGUULYgaKGSJccXrjtTANL1wMRe6pqafzFg5pfl3K/bP80c+SrI7QZHZtE
	 55l1l0YnSgGmwQfXofz4u79J51kRucSxIUy+3lkjhZZLW0A7ac1y4/kPIfKyjwCpcoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Gkku8EDR;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454D606A339;
	Sun,  8 Nov 2026 09:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6454D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Gkku8EDR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=l+
	50H9UydDgvjDUOodm6tPmjOieLyAKe00ss8qncm54=; b=Gkku8EDRpHK2BOv3RK
	zcXV72FgYqH1xGfyYocVTtkXEYOJLKbRW3s+36B2QVaKjcbcQOiBPDus9+3+wuOq
	XCIRfxKMXn1n4jp9i3MGdk936eLruQYHkksXsBAR2tZ+oRPrUzZAFVz4IHBCKtAD
	eEAFN63OBFk6ytwHAopEhFGnY=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCXz8OTQ_BquUg4GA--.62891S2;
	Sun, 08 Nov 2026 17:40:37 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	thierry.reding@kernel.org,
	ryder.lee@mediatek.com,
	jonathanh@nvidia.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 0/5] PCI: Encapsulate pcie_link_speed array access
Date: Sun,  8 Nov 2026 17:40:29 +0800
Message-ID: <20261108094034.679945-1-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXz8OTQ_BquUg4GA--.62891S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar13WFy8trW5tF48XF1rCrg_yoW8CF1rpF
	ZrK3yFyr1DXrW5uFWDAa4UZF9Yv3ZxG3yUt34rKw4rZF13CrWfXa4S9w4rGF9FkrZrZry7
	JFnxtFn8ArnrAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUxhdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BbMcGrwQ5b4YAAA3R

Hi,

This series finishes encapsulating the pcie_link_speed[] array by
converting the remaining direct users to pcie_get_link_speed() and
making the array private to probe.c.

The pcie_get_link_speed() helper was introduced and accepted in the
v10 "PCI: of: Remove max-link-speed generation validation" series, but
a few users that were added later still index pcie_link_speed[]
directly.

Changes since v1:
- Rebase onto v7.4-rc1.
- Use pcie_get_link_speed(), which is already exported and
  bounds-checked, instead of introducing a new to_pcie_link_speed()
  helper.
- Split the pci.c change from the other core conversions, mirroring the
  split between v1 patches 1 and 2.
- Convert probe.c's max_bus_speed lookup, which v1 missed.
- Convert the Tegra264 and MediaTek controller drivers, which were
  added after the v10 series and would otherwise fail to build once the
  array is no longer exported.
- Split the two controller conversions into separate patches so each
  driver can be reviewed independently.
- Make pcie_link_speed[] static instead of only removing its extern
  declaration and export.

v1 series: https://patchwork.kernel.org/project/linux-pci/patch/20260315160057.127639-1-18255117159@163.com/

Hans Zhang (5):
  PCI: Use pcie_get_link_speed() in pci.c
  PCI: Convert remaining core pcie_link_speed[] users
  PCI: tegra264: Use pcie_get_link_speed()
  PCI: mediatek: Use pcie_get_link_speed()
  PCI: Make pcie_link_speed[] private to probe.c

 drivers/pci/controller/pcie-mediatek.c | 2 +-
 drivers/pci/controller/pcie-tegra264.c | 6 +++---
 drivers/pci/pci-sysfs.c                | 2 +-
 drivers/pci/pci.c                      | 9 ++-------
 drivers/pci/pci.h                      | 3 +--
 drivers/pci/probe.c                    | 5 ++---
 6 files changed, 10 insertions(+), 17 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0


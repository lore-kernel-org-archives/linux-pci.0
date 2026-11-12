Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450284;
	b=E/d120yoFW2m2sS4A5Tw9Xtj1/lL+Q1JAya6KsyCKtYruLHa6PIccwIq4OF75Z0R/En3
	 eemsd+6I8DJanVndHRshyuIP62i/oVkGlYxhV7/YUTtxzgtYfXf8DpN1C+B0x5MiewHfc
	 Ik4w3yzdiOlqC8NuqQ4Hr9/GmYlivwGCdf9JMQ3Twdo3mxfGdSO+Iza6ABf53P8GlfgFL
	 0ULLQ1iwRB/gScW0T7oWoMYN/wYx00rVU+LNEKURY4wXvgVlf1s1d/nOIS8+l+oFiA9Ke
	 vSJ3qUG0kZ1uvt9mfvDY3qYezuGjrhhSPCIPV8OmVBuLAMlD/pv3NzVqBKnr1YBIPdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450284;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=FSEZh3NZwb1p2uiVs9pz/oK72BBc8y3UgjZImSYaxGk=;
	b=BOMbKz3b7oIg9UmTHv3T50vdPJddL0+bxsUoglp/bkUFEZMEfbamPvUZKd7OlyCSp+A3
	 XLQ7X87y4wd0QkJ1qeheO6vnRSsQn7fk6YVde3GxKOT9BsamD+elTwde/zQTlTy8utZGU
	 ny7j+bvAmianeDw85KO7opE0LEKP0I9G4McbX3fFWmNwz2AX+epOTplQPZueNFbA5vIw7
	 laSym/6sG2FB03tGTni4Oc8I828JyFfsBwHuxmhdg9Qv5uvT8xyAAW2xjDhP9iLAgprJd
	 16hkPyuYtUljxPuPFtKNCWqYPZzynGXY/LetrMBHrx3u7a680LqXK/HBWl+nTXkbuEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XD5EZNd0;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1F606A898;
	Thu, 12 Nov 2026 02:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06F1F606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XD5EZNd0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FS
	EZh3NZwb1p2uiVs9pz/oK72BBc8y3UgjZImSYaxGk=; b=XD5EZNd0YTkq64O+hm
	YuLVoFqzWwZnpL4I1WMMwAXF+mVtN/Q+0SVXy/S+JNw77my+PeqIz82HDudtJhO3
	0grCrM7nJ2uFo0/CG59C4rB9RdLR1Ge5j3UVAAboBBz5WqJ5RuuRksyk1+pfYrCk
	ZGPyzuGsUrNtPlA7kdES8eIzY=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXj+5GI_VqPgXEGg--.53291S2;
	Thu, 12 Nov 2026 10:24:08 +0800 (CST)
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
Subject: [PATCH v3 0/5] PCI: Encapsulate pcie_link_speed array access
Date: Thu, 12 Nov 2026 10:24:00 +0800
Message-ID: <20261112022405.1230200-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDXj+5GI_VqPgXEGg--.53291S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1fCryfArWkGF43tr1fZwb_yoW8Kry5pF
	ZIy34Fyr1UJFW5uFZrAay7ZF9Y93ZxC3yUt34rK34fZF13CFW3XFyS9w4rAF9FkrZrZry7
	XF13t3Z8AFnrAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUxhdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7Anylmr1I0kjmgAA3N

Hi,

This series finishes encapsulating the pcie_link_speed[] array by
converting the remaining direct users to pcie_get_link_speed() and
making the array private to probe.c.

The pcie_get_link_speed() helper was introduced and accepted in the
v10 "PCI: of: Remove max-link-speed generation validation" series, but
a few users that were added later still index pcie_link_speed[]
directly.

Changes since v2:
- In pci.c, extract the PCI_EXP_LNKSTA_CLS field into a local
  lnksta_cls variable in pcie_link_bandwidth_mbps() and
  pcie_bandwidth_available() so the pcie_get_link_speed() calls stay
  readable.  This addresses the readability concern raised by Ilpo.
- No changes to the remaining patches.

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

v2 series:
https://patchwork.kernel.org/project/linux-pci/patch/20261108094034.679945-1-18255117159@163.com/

v1 series:
https://patchwork.kernel.org/project/linux-pci/patch/20260315160057.127639-1-18255117159@163.com/

Hans Zhang (5):
  PCI: Use pcie_get_link_speed() in pci.c
  PCI: Convert remaining core pcie_link_speed[] users
  PCI: tegra264: Use pcie_get_link_speed()
  PCI: mediatek: Use pcie_get_link_speed()
  PCI: Make pcie_link_speed[] private to probe.c

 drivers/pci/controller/pcie-mediatek.c |  2 +-
 drivers/pci/controller/pcie-tegra264.c |  6 +++---
 drivers/pci/pci-sysfs.c                |  2 +-
 drivers/pci/pci.c                      | 15 ++++++---------
 drivers/pci/pci.h                      |  3 +--
 drivers/pci/probe.c                    |  6 ++----
 6 files changed, 14 insertions(+), 20 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0


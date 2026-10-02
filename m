Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89DD486620;
	Fri,  2 Oct 2026 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939395; cv=none; b=QbiqH25Ct7PqbrHDWx5DnbMXCeeHYBnXvHRzohGMR+ihUc57LwI46VPZV5/yiPEMRdg8+EoNLthI1D7qFAuLdndHymZwh8ry2uIZawBveGH/XWkyRWta4K2IL2AXE2tWXseKyFDjD/NEg7ZysI5l6RV/srS6ZxfCDCKt3AzYp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939395; c=relaxed/simple;
	bh=H/qK4mai/x8RSntai1zU15A1m8zXiWZRcJ0D5OSNiUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJrY76l+lrzYv6IDs+PZdDp3cqQ8zQIveN8toKHLkPZvM0uHdTEcwhG+V5tzWpe28kzcg70L6W/DwAVoAZpS5KfVF+Q+NElA0nnu9M3ODkhvudlo47vJILDtW4Ilyo/R+5NYIE/0x9HtfQ0r7SrF6OExAtshiWqYPYGI5BhBSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dx29K0ns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dx29K0ns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92CE1F00893;
	Fri,  2 Oct 2026 11:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939385;
	bh=N2ytRxN1rG7UxXKy0d7aVyK0BAwVnhqc4AUMBzliFww=;
	h=From:To:Cc:Subject:Date;
	b=dx29K0ns6q3rNanMvzRcW6yBUPZtYUwQZTKp8AcwF0zNV2rMZr7q/h2fvfuu/XNPI
	 OyTwuNt7Yv4UMHXlIwpYXsbCwkDwRv1rLKx5FK8mzCwqL/jkuYS9WHnr/KcKB08LHB
	 cjgblqnpszs5JyMyNJJ8EKqq97Og8WScx0lLkhk/vR441vG0pX5tFcsh2V8L+XX+G1
	 fuw1/g6uEd2/sZfPsfTIKPGzjnozxxHXAE5ZJkoga3NdIc1ysY2NobmbiGzVkPLWQV
	 5+SuNU+AGx/mLnavwhFjetpar2get9cpczrDWQwtywn0ekDamny63ThWtDsIHNu3GB
	 gA0sclwrZUL3A==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	18255117159@163.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 0/9] PCI: rzg3s-host: Add PCIe hotplug support
Date: Fri,  2 Oct 2026 14:09:26 +0300
Message-ID: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds hotplug support for the rzg3s-host driver. This is a
continuation of the series John posted initially at [1]. Along with it,
prerequisites fixes and cleanup patches were added.

Thank you,
Claudiu

Changes in v5:
- collected tags
- added patch 3/9 ("PCI: rzg3s-host: Select PCI_HOST_COMMON")
- addressed sashiko review comments (detailed in individual patches)

Changes in v4:
- simplified comments in patch 2/8
- kept only DL_UpDown changes in patch 7/8
- added patch 8/8 for the .reset_root_port() support

Changes in v3:
- added patches 1-6
- re-worked patch 7 to use struct pci_host_bridge::reset_root_port() API

[1] https://lore.kernel.org/all/20260630141720.3938514-1-john.madieu.xa@bp.renesas.com/

Claudiu Beznea (8):
  PCI: rzg3s-host: Follow hardware manual clock/reset initialization
    order
  PCI: rzg3s-host: Fix runtime PM handling in the NOIRQ suspend/resume
    phase
  PCI: rzg3s-host: Select PCI_HOST_COMMON
  PCI: rzg3s-host: Drop nop instructions
  PCI: rzg3s-host: Move host configuration code together
  PCI: rzg3s-host: Move suspend/resume code into dedicated functions
  PCI: rzg3s-host: Move IRQ domain setup code
  PCI: rzg3s-host: Add bridge::reset_root_port()

John Madieu (1):
  PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

 drivers/pci/controller/Kconfig           |   1 +
 drivers/pci/controller/pcie-rzg3s-host.c | 901 ++++++++++++++---------
 2 files changed, 574 insertions(+), 328 deletions(-)

-- 
2.43.0


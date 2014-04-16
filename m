Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'linux-pci' <linux-pci@vger.kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org,
	'Liviu Dudau' <Liviu.Dudau@arm.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [RFC PATCH 0/2] Add support for Samsung GH7 PCIe controller
Date: Wed, 16 Apr 2014 13:41:53 +0900
Message-id: <000801cf592e$30b7bff0$92273fd0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support for Samsung GH7 PCIe host controller.
Samsung GH7 PCIe controller driver has dependency on the PCI arm64
arch support. So, the Liviu Dudau's patcheset for creating generic
host_bridge from device tree [1] and supporting PCI in AArch64 [2]
are required.

This patch is marked as RFC, so any comment will be welcomed.
Thank you.

[1] http://www.spinics.net/lists/linux-pci/msg29786.html
[2] http://www.spinics.net/lists/linux-pci/msg29793.html

Jingoo Han (2)
  PCI: designware: Add ARM64 PCI support
  PCI: exynos: Add PCIe support for Samsung GH7 SoC

---
 drivers/pci/host/Kconfig           |    2 +-
 drivers/pci/host/pci-exynos.c      |  135 +++++++++++++++++++++++++++++++++---
 drivers/pci/host/pcie-designware.c |   32 +++++++++
 3 files changed, 158 insertions(+), 11 deletions(-)

Best regards,
Jingoo Han


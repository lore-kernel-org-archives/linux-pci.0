Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:28616 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933209AbbDOGEK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Apr 2015 02:04:10 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<yuanzhichang@hisilicon.com>, <zhudacai@hisilicon.com>,
	<zhangjukuo@huawei.com>, <xiehaitao@huawei.com>,
	<liguozhu@hisilicon.com>, <wangzhou.bry@gmail.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [RFC PATCH 0/3] PCI: host: Add PCIe host support for Hisilicon Soc Hip05
Date: Wed, 15 Apr 2015 14:04:00 +0800
Message-ID: <1429077843-184462-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset adds PCIe host support for Hisilicon Soc Hip05. The PCIe hosts
use PCIe IP core from Synopsys. So the driver is based on designware PCIe driver.

Zhou Wang (3):
  PCI: host: designware: support ARM64
  PCI: Host: Add PCIe host support for Hisilicon Soc Hip05
  Documentation: devicetree: Add hisilicon PCIe host binding

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  46 ++++
 drivers/pci/host/Kconfig                           |   5 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-designware.c                 |  44 +++-
 drivers/pci/host/pcie-hisi.c                       | 252 +++++++++++++++++++++
 5 files changed, 345 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 create mode 100644 drivers/pci/host/pcie-hisi.c

-- 
1.9.1


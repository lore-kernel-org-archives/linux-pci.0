Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36736 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbH0Mea (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2015 08:34:30 -0400
Received: by wicgk12 with SMTP id gk12so7207139wic.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2015 05:34:29 -0700 (PDT)
From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	" David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>, <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@stlinux.com,
	linux-pci@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 0/4] PCI: st: provide support for dw pcie
Date: Thu, 27 Aug 2015 14:34:13 +0200
Message-Id: <1440678857-27118-1-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


This patchset is based on v4.2-rc1 and is based on 
[PATCH v8 0/6] PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
patchset from Zhou Wang.

Changes in v4:
 - Remove pci: designware: remove my pci_common_init_dev() patch and
	use [PATCH v8 3/6] PCI: designware: Add ARM64 support instead.
	This patch is a good solution for me to disable IO support.
 - add __init to st_pcie_probe() and use module_init() instead
	device_initcall() to prevent the probe function from being
	deferred and to prevent module unloading.

Changes in v3:
 - Remove power management functions (was not fully tested)
 - Remove configuration space range from dt binding
 - Remove pci_common_init_dev() call in pcie-designware.c to avoid 
   default IO space declaration. 

Changes in v2:
 - comestic corrections in device tree binding
 - add pci-st.c into MAINTAINERS
 - remove st_pcie_ops structure to avoid another level of indirection
 - remove nasty busy-loop
 - remove useless test using virt_to_phys()
 - move disable io support into dw-pcie driver

I don't change the st_pcie_abort_handler() function because abort handling
is masked during boot.


This patch-set introduces a STMicroelectronics PCIe controller.
It's based on designware PCIe driver.

Gabriel Fernandez (4):
  ARM: STi: Kconfig update for PCIe support
  PCI: st: Add Device Tree bindings for sti pcie
  PCI: st: Provide support for the sti PCIe controller
  MAINTAINERS: Add pci-st.c to ARCH/STI architecture

 Documentation/devicetree/bindings/pci/st-pcie.txt |  53 ++
 MAINTAINERS                                       |   1 +
 arch/arm/mach-sti/Kconfig                         |   2 +
 drivers/pci/host/Kconfig                          |   9 +
 drivers/pci/host/Makefile                         |   1 +
 drivers/pci/host/pci-st.c                         | 583 ++++++++++++++++++++++
 6 files changed, 649 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt
 create mode 100644 drivers/pci/host/pci-st.c

-- 
1.9.1


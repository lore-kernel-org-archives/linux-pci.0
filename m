Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48688 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965069AbbCPOZI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2015 10:25:08 -0400
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
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
	Andrew Lunn <andrew@lunn.ch>, Liviu Dudau <liviu.dudau@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@stlinux.com,
	linux-pci@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: [PATCH v2 0/5] PCI: st: provide support for dw pcie
Date: Mon, 16 Mar 2015 15:20:30 +0100
Message-Id: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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

Gabriel Fernandez (5):
  ARM: STi: Kconfig update for PCIe support
  PCI: st: Add Device Tree bindings for sti pcie
  PCI: st: Provide support for the sti PCIe controller
  PCI: designware: Add disable IO support
  MAINTAINERS: Add pci-st.c to ARCH/STI architecture

 .../devicetree/bindings/pci/designware-pcie.txt    |   2 +
 Documentation/devicetree/bindings/pci/st-pcie.txt  |  54 ++
 MAINTAINERS                                        |   1 +
 arch/arm/mach-sti/Kconfig                          |   2 +
 drivers/pci/host/Kconfig                           |   9 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-st.c                          | 617 +++++++++++++++++++++
 drivers/pci/host/pcie-designware.c                 |  24 +-
 drivers/pci/host/pcie-designware.h                 |   1 +
 9 files changed, 709 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt
 create mode 100644 drivers/pci/host/pci-st.c

-- 
1.9.1


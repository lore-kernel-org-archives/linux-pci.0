Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:45535 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242AbbEDMmY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 May 2015 08:42:24 -0400
From: Stanimir Varbanov <svarbanov@mm-sol.com>
To: Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mathieu Olivari <mathieu@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 0/5] Qualcomm PCIe and PCIe/PHY drivers
Date: Mon,  4 May 2015 15:42:13 +0300
Message-Id: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

Hi,

Here is a v2 of the patchset. The chages since v1 are:

 - take into accoint the review comments from the inital version
 - add support for pcie IP found on Snapdragon 600 (ipq/apq8064)

Version 1 of the patchset can be found at: 

https://lkml.org/lkml/2014/12/12/557

Commenst are welcome!

-------------------------------------------------------------------------------

This patchset introduces a Qualcomm PCIe root complex driver for
Snapdragon 805 (APQ8084). It also adds a PCIe PHY driver in generic
phy framework. The PCIe hardware use Designware IP core plus
Qualcomm application specific hw.

The first two patches add a PHY driver binding document and the 
PHY driver. Patches 3/5 and 4/5 add PCIe DT document and the driver.
Last 5/5 adds APQ8084 in mach-qcom as next multiplatform Qualcomm
SoC.

Stanimir Varbanov (5):
  DT: phy: qcom: Add PCIe PHY devicetree bindings
  phy: qcom: Add Qualcomm PCIe PHY
  DT: PCI: qcom: Document PCIe devicetree bindings
  PCI: qcom: Add Qualcomm PCIe controller driver
  ARM: qcom: Add Qualcomm APQ8084 SoC

 .../devicetree/bindings/pci/qcom,pcie.txt          |  231 +++++++
 .../devicetree/bindings/phy/qcom-pcie-phy.txt      |   60 ++
 MAINTAINERS                                        |    7 +
 arch/arm/mach-qcom/Kconfig                         |    7 +
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-qcom.c                       |  677 ++++++++++++++++++++
 drivers/phy/Kconfig                                |    9 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-qcom-pcie.c                        |  291 +++++++++
 10 files changed, 1293 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie-phy.txt
 create mode 100644 drivers/pci/host/pcie-qcom.c
 create mode 100644 drivers/phy/phy-qcom-pcie.c


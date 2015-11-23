Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36229 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbbKWJ3O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2015 04:29:14 -0500
Received: by wmww144 with SMTP id w144so87696126wmw.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2015 01:29:13 -0800 (PST)
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 0/6] Qualcomm PCIe driver and designware fixes
Date: Mon, 23 Nov 2015 11:28:57 +0200
Message-Id: <cover.1448270813.git.stanimir.varbanov@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set is continuation of previous v2 at [1]. This time I
decided to drop the PHY driver needed by pcie driver for apq8084
and send it separately soon (when sort out the need of separate phy
driver).

First two patches in the set are fixes in pcie designware driver
found during testing the qcom pcie driver. The second patch can
be treated as an RFC.

Next two patches adds DT binding document and the driver itself.

The last two patches just adds relevant dt node for apq8064 and
enable pcie usage on ifc6410 development board. The testing has been
made on ifc6410 development board.

Comments are welcome!

Here is edited description:

This patchset introduces a Qualcomm PCIe root complex driver for
Snapdragon 805 (APQ8084) and Snapdragon 600 (APQ8064). The PCIe
hardware use Designware IP core plus Qualcomm application
specific hw wrappers.

[1] https://lkml.org/lkml/2015/5/4/267

Stanimir Varbanov (6):
  PCI: designware: remove wrong io_base assignment
  PCI: designware: add memory barrier after enabling region
  DT: PCI: qcom: Document PCIe devicetree bindings
  PCI: qcom: Add Qualcomm PCIe controller driver
  ARM: dts: apq8064: add pcie devicetree node
  ARM: dts: ifc6410: enable pcie dt node for this board

 .../devicetree/bindings/pci/qcom,pcie.txt          |  231 ++++++++
 MAINTAINERS                                        |    7 +
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |   26 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   36 ++
 drivers/pci/host/Kconfig                           |   10 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-designware.c                 |    6 +-
 drivers/pci/host/pcie-qcom.c                       |  623 ++++++++++++++++++++
 8 files changed, 939 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 drivers/pci/host/pcie-qcom.c

-- 
1.7.9.5


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38308 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbLRMjJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2015 07:39:09 -0500
Received: by mail-wm0-f54.google.com with SMTP id l126so63476016wml.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Dec 2015 04:39:08 -0800 (PST)
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
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
Subject: [PATCH v5 0/5] Qualcomm PCIe driver and designware fixes
Date: Fri, 18 Dec 2015 14:38:54 +0200
Message-Id: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I'm sending v5 with following changes:
- in 1/5 - replace wmb() call with PCIE_ATU_CR2 register read.
- in 3/5 - addressed comments from Born Helgaas about usage of a
standard PCI capabilities register names and rename link training
function to the way that other Designware based drivers use.
- in 5/5 - addressed a comment from Bjorn Andersson about regulator
label duplication.

Comments are welcome!

The previous v4 of the patch set can be found at [1].

regards,
Stan

[1] https://lkml.org/lkml/2015/12/3/370

Stanimir Varbanov (5):
  PCI: designware: ensure ATU is enabled before IO/conf space accesses
  DT: PCI: qcom: Document PCIe devicetree bindings
  PCI: qcom: Add Qualcomm PCIe controller driver
  ARM: dts: apq8064: add pcie devicetree node
  ARM: dts: ifc6410: enable pcie dt node for this board

 .../devicetree/bindings/pci/qcom,pcie.txt          |  233 ++++++++
 MAINTAINERS                                        |    7 +
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |   26 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   36 ++
 drivers/pci/host/Kconfig                           |   10 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-designware.c                 |    7 +
 drivers/pci/host/pcie-qcom.c                       |  617 ++++++++++++++++++++
 8 files changed, 937 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 drivers/pci/host/pcie-qcom.c

-- 
1.7.9.5


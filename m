Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38019 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbcKNLQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2016 06:16:09 -0500
Received: by mail-wm0-f54.google.com with SMTP id f82so91690876wmf.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 03:16:08 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc: robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v4 0/3] PCI: qcom: Add support to msm8996 pcie controller.
Date: Mon, 14 Nov 2016 11:15:52 +0000
Message-Id: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset adds support to msm8996 pcie controller. I tested this patch on
v4.9-rc2 along with phy driver patch [1] and
"PCI: designware: check for iATU unroll support after initializing host"
fix [2] on DB820c APQ8096 board on port B and port C using sata and
ethernet controller.

Changes since v3:
	- remove unnesessary variable initialization spotted by vivek.
	- moved pipe clk disable before other clocks suggested by vivek.
	- fixed dt example suggested by Rob.
Changes since v2:
	- Removed regulators that belong to phy, spotted by Stephen
	- Removed clocks in to simple pm bus driver, spotted by Stephen
	- renamed msm8996 ops to v2 ops as suggested by Stephen.
	- cleanups as suggested by Stephen.
	- Add runtime pm support to driver.
	- Added pm clk support to simple pm bus driver.

Changes since v1:
	- Fixed dt example as suggested by Rob
	- added smmu bus clk dependency as smmu sits in between
	  system NOC and PCIe.
	- Removed smmu configuration from bindings and driver as
	  the smmu Level2 translation on this SOC is controlled by
	  the secure world, and level 1 translation is disabled,
	  so there is one-to-one mapping of the address space.

Thanks,
srini

[1] https://patchwork.kernel.org/patch/9384711/
[2] https://patchwork.kernel.org/patch/9377557/


Srinivas Kandagatla (3):
  bus: simple-pm: add support to pm clocks
  PCI: qcom: add support to msm8996 PCIE controller
  PCI: qcom: add runtime pm support to pcie_port

 .../devicetree/bindings/pci/qcom,pcie.txt          |  67 +++++++-
 drivers/bus/simple-pm-bus.c                        |  13 +-
 drivers/pci/host/pcie-qcom.c                       | 181 ++++++++++++++++++++-
 3 files changed, 254 insertions(+), 7 deletions(-)

-- 
2.10.1


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:56146 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbaE1OwA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 10:52:00 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 4/5] PCI: tegra: Remove deprecated power supply properties
Date: Wed, 28 May 2014 16:49:14 +0200
Message-Id: <1401288555-24197-5-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
References: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

These power supply properties are no longer needed since the binding now
contains the full set properties to accurately describe the power supply
inputs of the Tegra PCIe block.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index f56d89998a44..0823362548dc 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -84,11 +84,6 @@ Power supplies for Tegra30:
     - avdd-pexb-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
     - vdd-pexb-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
 
-Deprecated supplies:
-- pex-clk-supply: Supply voltage for internal reference clock
-- vdd-supply: Power supply for controller (1.05V)
-- avdd-supply: Power supply for controller (1.05V) (not required for Tegra20)
-
 Root ports are defined as subnodes of the PCIe controller node.
 
 Required properties:
-- 
1.9.2


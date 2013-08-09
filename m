Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:33112 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933943Ab3HIOuD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 10:50:03 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v6 14/14] MAINTAINERS: Add myself as Tegra PCIe maintainer
Date: Fri,  9 Aug 2013 16:49:32 +0200
Message-Id: <1376059772-16669-15-git-send-email-treding@nvidia.com>
In-Reply-To: <1376059772-16669-1-git-send-email-treding@nvidia.com>
References: <1376059772-16669-1-git-send-email-treding@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'll be taking on maintainership of the Tegra PCIe driver since it's now
moved out of arch/arm/mach-tegra.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd1b287..26fc20a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6287,6 +6287,13 @@ F:	Documentation/PCI/
 F:	drivers/pci/
 F:	include/linux/pci*
 
+PCI DRIVER FOR NVIDIA TEGRA
+M:	Thierry Reding <thierry.reding@gmail.com>
+L:	linux-tegra@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+F:	drivers/pci/host/pci-tegra.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
-- 
1.8.3.4


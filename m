Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jay Agarwal <jagarwal@nvidia.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/16] MAINTAINERS: Add myself as Tegra PCIe maintainer
Date: Thu, 25 Jul 2013 10:53:30 -0700
Message-Id: <1374774810-18459-17-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1374774810-18459-1-git-send-email-thierry.reding@gmail.com>
References: <1374774810-18459-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

I'll be taking on maintainership of the Tegra PCIe driver since it's now
moved out of arch/arm/mach-tegra.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1dd9bf0..e32db7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6271,6 +6271,13 @@ F:	Documentation/PCI/
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
1.8.1.5


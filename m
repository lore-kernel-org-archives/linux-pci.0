Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:38409 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757750AbbDVGQ2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Apr 2015 02:16:28 -0400
Received: by pabtp1 with SMTP id tp1so263686299pab.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2015 23:16:27 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v6 4/4] PCI: X-Gene: Add the MAINTAINERS entry for APM X-Gene v1 PCIe MSI driver
Date: Tue, 21 Apr 2015 23:15:11 -0700
Message-Id: <8f11c767011a346f6b75b1eea49ab3207a7e68b0.1429677787.git.dhdang@apm.com>
In-Reply-To: <cover.1429677787.git.dhdang@apm.com>
References: <cover.1429677787.git.dhdang@apm.com>
In-Reply-To: <cover.1429677787.git.dhdang@apm.com>
References: <553667FD.9090806@arm.com> <cover.1429677787.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds information of maintainers for APM X-Gene v1 PCIe
MSI/MSIX termination driver

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..a1b119b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7490,6 +7490,14 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*spear*
 
+PCI MSI DRIVER FOR APPLIEDMICRO XGENE
+M:	Duc Dang <dhdang@apm.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
+F:	drivers/pci/host/pci-xgene-msi.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
-- 
1.9.1


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og125.obsmtp.com ([64.18.0.245]:51320 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753507AbbERJzo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2015 05:55:44 -0400
Received: by pdea3 with SMTP id a3so141546615pde.2
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2015 02:55:42 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v7 4/4] PCI: X-Gene: Add the MAINTAINERS entry for APM X-Gene v1 PCIe MSI driver
Date: Mon, 18 May 2015 02:55:21 -0700
Message-Id: <143384a3562d824c290b3228c9817d8d1a8f487f.1431940313.git.dhdang@apm.com>
In-Reply-To: <cover.1431940313.git.dhdang@apm.com>
References: <cover.1431940313.git.dhdang@apm.com>
In-Reply-To: <cover.1431940313.git.dhdang@apm.com>
References: <20150422135002.1b407b98@why.wild-wind.fr.eu.org> <cover.1431940313.git.dhdang@apm.com>
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


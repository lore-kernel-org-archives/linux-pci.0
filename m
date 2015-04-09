Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og122.obsmtp.com ([64.18.0.192]:57459 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755868AbbDIRFt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 13:05:49 -0400
Received: by pdbqa5 with SMTP id qa5so102000687pdb.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2015 10:05:48 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v3 4/4] PCI: X-Gene: Add the MAINTAINERS entry for APM X-Gene v1 PCIe MSI driver
Date: Thu,  9 Apr 2015 10:05:06 -0700
Message-Id: <3a1a1d1aaf9be86cff6b3d978255bfec98707282.1428564115.git.dhdang@apm.com>
In-Reply-To: <cover.1428564115.git.dhdang@apm.com>
References: <cover.1428564115.git.dhdang@apm.com>
In-Reply-To: <cover.1428564115.git.dhdang@apm.com>
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org> <cover.1428564115.git.dhdang@apm.com>
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


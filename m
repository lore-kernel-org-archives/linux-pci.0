Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og125.obsmtp.com ([64.18.0.245]:33800 "HELO
	exprod5og125.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751076AbbAFQXh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jan 2015 11:23:37 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so30676265pdb.4
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2015 08:23:36 -0800 (PST)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>, Duc Dang <dhdang@apm.com>
Subject: [PATCH 4/4] PCI: X-Gene: Add the MAINTAINERS entry for APM X-Gene v1 PCIe MSI driver
Date: Tue,  6 Jan 2015 08:15:44 -0800
Message-Id: <9fd7f3ec58431a0fcba3600a0325920c86bc69fa.1420499393.git.dhdang@apm.com>
In-Reply-To: <cover.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
In-Reply-To: <cover.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds information of maintainers for APM X-Gene v1 PCIe
MSI/MSIX termination driver

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddb9ac8..283f09a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7303,6 +7303,14 @@ L:	linux-pci@vger.kernel.org
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


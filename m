Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:50237 "HELO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756360AbaIZVIs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Sep 2014 17:08:48 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so675175pab.19
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2014 14:08:47 -0700 (PDT)
From: Tanmay Inamdar <tinamdar@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Landley <rob@landley.net>,
	Liviu Dudau <liviu.dudau@arm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@apm.com, jcm@redhat.com,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: [PATCH v10 4/4] MAINTAINERS: entry for APM X-Gene PCIe host driver
Date: Fri, 26 Sep 2014 14:08:27 -0700
Message-Id: <1411765707-28822-5-git-send-email-tinamdar@apm.com>
In-Reply-To: <1411765707-28822-1-git-send-email-tinamdar@apm.com>
References: <1411765707-28822-1-git-send-email-tinamdar@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add entry for AppliedMicro X-Gene PCIe host driver.

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 670b3dc..b18bc49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6942,6 +6942,14 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*spear*
 
+PCI DRIVER FOR APPLIEDMICRO XGENE
+M:	Tanmay Inamdar <tinamdar@apm.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/xgene-pci.txt
+F:	drivers/pci/host/pci-xgene.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
-- 
1.9.1


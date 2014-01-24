Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:60901 "HELO
	exprod5og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753221AbaAXVds (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2014 16:33:48 -0500
Received: by mail-pd0-f181.google.com with SMTP id y10so3537228pdj.26
        for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2014 13:33:46 -0800 (PST)
From: Tanmay Inamdar <tinamdar@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Landley <rob@landley.net>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@apm.com, jcm@redhat.com,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: [RFC PATCH V3 4/4] MAINTAINERS: entry for APM X-Gene PCIe host driver
Date: Fri, 24 Jan 2014 13:32:48 -0800
Message-Id: <1390599168-13150-5-git-send-email-tinamdar@apm.com>
In-Reply-To: <1390599168-13150-1-git-send-email-tinamdar@apm.com>
References: <1390599168-13150-1-git-send-email-tinamdar@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add entry for AppliedMicro X-Gene PCIe host driver.

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c21402..721fec7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6539,6 +6539,13 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*designware*
 
+PCI DRIVER FOR APPLIEDMICRO XGENE
+M:	Tanmay Inamdar <tinamdar@apm.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	drivers/pci/host/pci-xgene.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
-- 
1.7.9.5


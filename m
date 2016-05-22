Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 35/54] MAINTAINERS: Add file patterns for pci device tree bindings
Date: Sun, 22 May 2016 11:06:12 +0200
Message-Id: <1463907991-7916-36-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 868111d26536f086..2e4bacda7f40a7e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8695,6 +8695,7 @@ L:	linux-pci@vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 S:	Supported
+F:	Documentation/devicetree/bindings/pci/
 F:	Documentation/PCI/
 F:	drivers/pci/
 F:	include/linux/pci*
-- 
1.9.1

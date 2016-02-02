Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 4/5] PCI: Remove empty asm-generic/pci-bridge.h
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 02 Feb 2016 13:38:56 -0600
Message-ID: <20160202193855.9258.11522.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

include/asm-generic/pci-bridge.h is empty, and nobody includes it, so
remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/asm-generic/pci-bridge.h |    9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 include/asm-generic/pci-bridge.h

diff --git a/include/asm-generic/pci-bridge.h b/include/asm-generic/pci-bridge.h
deleted file mode 100644
index 1b1d82f..0000000
--- a/include/asm-generic/pci-bridge.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#ifndef _ASM_GENERIC_PCI_BRIDGE_H
-#define _ASM_GENERIC_PCI_BRIDGE_H
-#endif	/* _ASM_GENERIC_PCI_BRIDGE_H */

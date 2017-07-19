Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36330 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbdGSCQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 22:16:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11so4680410pfj.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 19:16:32 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
        zourongrong@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, gabriele.paoloni@huawei.com,
        bhelgaas@google.com, airlied@linux.ie, daniel.vetter@intel.com,
        alex.williamson@redhat.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 4/4] arm64: allow non-legacy VGA devices to be default
Date: Wed, 19 Jul 2017 12:15:16 +1000
Message-Id: <20170719021516.24718-5-dja@axtens.net>
In-Reply-To: <20170719021516.24718-1-dja@axtens.net>
References: <20170719021516.24718-1-dja@axtens.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The VGA arbiter only marks a device as default if it can decode
legacy I/O and memory ranges. This is often not the case on arm64,
which doesn't use the legacy ranges.

Enable the VGA arbiter to mark the first enabled VGA card as
default.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Tested on a D05 using the hibmc card.
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dfd908630631..cefcbd442e4f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -28,6 +28,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_VGA_ARB_FALLBACK
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
-- 
2.11.0

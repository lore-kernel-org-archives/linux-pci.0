Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33718 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdGSB3n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 21:29:43 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1so4871688pgs.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 18:29:42 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
        zourongrong@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, gabriele.paoloni@huawei.com,
        helgass@kernel.org, airlied@linux.ie, daniel.vetter@intel.com,
        alex.williamson@redhat.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH 3/3] extend to arm
Date: Wed, 19 Jul 2017 11:28:37 +1000
Message-Id: <20170719012839.20124-5-dja@axtens.net>
In-Reply-To: <20170719012839.20124-1-dja@axtens.net>
References: <20170719012839.20124-1-dja@axtens.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cae4e677a181..e88081b515d2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -20,6 +20,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_VGA_ARB_FALLBACK
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
-- 
2.11.0

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:54521 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbeCDSb6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 4 Mar 2018 13:31:58 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 7/7] MAINTAINERS: Add entry for Jailhouse
Date: Sun,  4 Mar 2018 19:31:39 +0100
Message-Id: <36142d5c54b217e2e6df8c80936764d883180e93.1520188299.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520188299.git.jan.kiszka@siemens.com>
References: <cover.1520188299.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520188299.git.jan.kiszka@siemens.com>
References: <cover.1520188299.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf8d72d..6dc0b8f3ae0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7523,6 +7523,13 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 S:	Maintained
 F:	drivers/media/dvb-frontends/ix2505v*
 
+JAILHOUSE HYPERVISOR INTERFACE
+M:	Jan Kiszka <jan.kiszka@siemens.com>
+L:	jailhouse-dev@googlegroups.com
+S:	Maintained
+F:	arch/x86/kernel/jailhouse.c
+F:	arch/x86/include/asm/jailhouse_para.h
+
 JC42.4 TEMPERATURE SENSOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
-- 
2.13.6

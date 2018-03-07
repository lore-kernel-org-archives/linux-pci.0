Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:35652 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbeCGHjh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 02:39:37 -0500
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
Subject: [PATCH v5 7/7] MAINTAINERS: Add entry for Jailhouse
Date: Wed,  7 Mar 2018 08:39:18 +0100
Message-Id: <8be8af4084d862faa43d55c7bae94af7e0da1609.1520408357.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520408357.git.jan.kiszka@siemens.com>
References: <cover.1520408357.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520408357.git.jan.kiszka@siemens.com>
References: <cover.1520408357.git.jan.kiszka@siemens.com>
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

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:47578 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966069AbeCAFlK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Mar 2018 00:41:10 -0500
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
Subject: [PATCH v3 6/6] MAINTAINERS: Add entry for Jailhouse
Date: Thu,  1 Mar 2018 06:40:49 +0100
Message-Id: <35c7685c09f406c8497c60408dd861ab1dcc3941.1519882849.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519882849.git.jan.kiszka@siemens.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519882849.git.jan.kiszka@siemens.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a12af4f180..4b889f282c77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7521,6 +7521,13 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
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

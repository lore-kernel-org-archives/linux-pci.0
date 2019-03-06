Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB4CC43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 18:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8582063F
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 18:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfCFSvR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:51:17 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:48915 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfCFSvQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2019 13:51:16 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MqatK-1gflHP3Usy-00mY4K; Wed, 06 Mar 2019 19:51:07 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Subject: [PATCH] drivers: ntb: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:51:05 +0100
Message-Id: <1551898265-18909-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:5f39zJnw5ZY8mB6YYhZ0lzC2hbh8LIP7kjiVyiOaTLdIoC70MEa
 eLGwOwTCcil9oEZ2lj6nxytK1fQ1DLH5GAZLy2zKr9xk1VhaYIfO9uW34TkDc6i5fAeP7yj
 CeiDGVCWMbDLiQv3LyKjJgPHd3XWsJ7Xc6sfFo47VfheGqIApmsH3p7qc+JaDN/6C92UhKH
 W4jpT9dCsln+IubVis4dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dLVYLyFZ7b4=:w05iTnwv5BUqZejVhPj+GA
 oYkd2iOSIGTk2BZ/Sda9AUIT7uR9o0oBtrbX8JA6M6GpT1+7g6dC6NnbINcHspKv237OxYSSi
 Zg9jp8yotKxge1oAwCRxiXJOKcCydtiH2gRXfrWyP9rnFnJcnjBku5ydZjhrXLJpCzwVH2krP
 L44dcXmRWUIQUkrp8hImu66L9OiZmbxegSzq9oMf41L5BRoIRzziMOxlk2coNJrgFTw9HVib0
 e1iMZXIqazlBIkSYhk5XYrlBg1svbrZpM1sx8V2aTCGrl/nLZCxqrsmQDt1WdtLVbrfQBBbCg
 tZ3wpNTmWkyhFBrSU4qPlbFEO30dvyvoQa8Pfx10b+GopiWoN8D7CRkx6HstK5zo3C+qv0Q1O
 87Z3iE7NKeKZOsUU4lzcLN3+7d18uHifM7NFy3lMJLY4i1lW3NUD4kAk9OWf/p3lgRh/rHphP
 506RVnUi2ooNX6FpbpCdl4cYoYKWPMgMdvsR5kJfdDNBCt8/bH+Jyr5lfSaIQVhs0ZzmmjDHp
 rZJb6CPQUmvtgLM3oOnA5NMfV1AIdm1XMmLNsIwM9BpdfouP3/OELYssRmlCuW33I23ifCUul
 ytfEVgIfe57eG2yjjF1v0CUwDIeZusAU09dRoy4Xwg4dIhUP9wqilfNFoQhhee1e3Av6hMz6g
 6dD0+4xTetQFCYqS3v7W4EcJ5CZAMl+54fbBdsMu51U/LB5X0DLW8wE0YWurSlje8TrWLQWve
 DjyPFDEWbi1pLDXnPg8af20BUTWLCAPYNdyvvg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ntb/Kconfig          | 20 ++++++++++----------
 drivers/ntb/hw/amd/Kconfig   |  4 ++--
 drivers/ntb/hw/idt/Kconfig   | 41 ++++++++++++++++++++---------------------
 drivers/ntb/hw/intel/Kconfig |  4 ++--
 drivers/ntb/hw/mscc/Kconfig  |  8 ++++----
 drivers/ntb/test/Kconfig     | 26 +++++++++++++-------------
 6 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
index 95944e5..5ce3fdd 100644
--- a/drivers/ntb/Kconfig
+++ b/drivers/ntb/Kconfig
@@ -2,13 +2,13 @@ menuconfig NTB
 	tristate "Non-Transparent Bridge support"
 	depends on PCI
 	help
-	 The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
-	 connecting 2 systems.  When configured, writes to the device's PCI
-	 mapped memory will be mirrored to a buffer on the remote system.  The
-	 ntb Linux driver uses this point-to-point communication as a method to
-	 transfer data from one system to the other.
+	  The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
+	  connecting 2 systems.  When configured, writes to the device's PCI
+	  mapped memory will be mirrored to a buffer on the remote system.  The
+	  ntb Linux driver uses this point-to-point communication as a method to
+	  transfer data from one system to the other.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 if NTB
 
@@ -19,10 +19,10 @@ source "drivers/ntb/test/Kconfig"
 config NTB_TRANSPORT
 	tristate "NTB Transport Client"
 	help
-	 This is a transport driver that enables connected systems to exchange
-	 messages over the ntb hardware.  The transport exposes a queue pair api
-	 to client drivers.
+	  This is a transport driver that enables connected systems to exchange
+	  messages over the ntb hardware.  The transport exposes a queue pair api
+	  to client drivers.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 endif # NTB
diff --git a/drivers/ntb/hw/amd/Kconfig b/drivers/ntb/hw/amd/Kconfig
index cfe903c..9a90f17 100644
--- a/drivers/ntb/hw/amd/Kconfig
+++ b/drivers/ntb/hw/amd/Kconfig
@@ -2,6 +2,6 @@ config NTB_AMD
 	tristate "AMD Non-Transparent Bridge support"
 	depends on X86_64
 	help
-	 This driver supports AMD NTB on capable Zeppelin hardware.
+	  This driver supports AMD NTB on capable Zeppelin hardware.
 
-	 If unsure, say N.
+	  If unsure, say N.
diff --git a/drivers/ntb/hw/idt/Kconfig b/drivers/ntb/hw/idt/Kconfig
index f8948cf..5d106ac 100644
--- a/drivers/ntb/hw/idt/Kconfig
+++ b/drivers/ntb/hw/idt/Kconfig
@@ -3,28 +3,27 @@ config NTB_IDT
 	depends on PCI
 	select HWMON
 	help
-	 This driver supports NTB of cappable IDT PCIe-switches.
+	  This driver supports NTB of cappable IDT PCIe-switches.
 
-	 Some of the pre-initializations must be made before IDT PCIe-switch
-	 exposes it NT-functions correctly. It should be done by either proper
-	 initialisation of EEPROM connected to master smbus of the switch or
-	 by BIOS using slave-SMBus interface changing corresponding registers
-	 value. Evidently it must be done before PCI bus enumeration is
-	 finished in Linux kernel.
+	  Some of the pre-initializations must be made before IDT PCIe-switch
+	  exposes it NT-functions correctly. It should be done by either proper
+	  initialisation of EEPROM connected to master smbus of the switch or
+	  by BIOS using slave-SMBus interface changing corresponding registers
+	  value. Evidently it must be done before PCI bus enumeration is
+	  finished in Linux kernel.
 
-	 First of all partitions must be activated and properly assigned to all
-	 the ports with NT-functions intended to be activated (see SWPARTxCTL
-	 and SWPORTxCTL registers). Then all NT-function BARs must be enabled
-	 with chosen valid aperture. For memory windows related BARs the
-	 aperture settings shall determine the maximum size of memory windows
-	 accepted by a BAR. Note that BAR0 must map PCI configuration space
-	 registers.
+	  First of all partitions must be activated and properly assigned to all
+	  the ports with NT-functions intended to be activated (see SWPARTxCTL
+	  and SWPORTxCTL registers). Then all NT-function BARs must be enabled
+	  with chosen valid aperture. For memory windows related BARs the
+	  aperture settings shall determine the maximum size of memory windows
+	  accepted by a BAR. Note that BAR0 must map PCI configuration space
+	  registers.
 
-	 It's worth to note, that since a part of this driver relies on the
-	 BAR settings of peer NT-functions, the BAR setups can't be done over
-	 kernel PCI fixups. That's why the alternative pre-initialization
-	 techniques like BIOS using SMBus interface or EEPROM should be
-	 utilized.
-
-	 If unsure, say N.
+	  It's worth to note, that since a part of this driver relies on the
+	  BAR settings of peer NT-functions, the BAR setups can't be done over
+	  kernel PCI fixups. That's why the alternative pre-initialization
+	  techniques like BIOS using SMBus interface or EEPROM should be
+	  utilized.
 
+	  If unsure, say N.
diff --git a/drivers/ntb/hw/intel/Kconfig b/drivers/ntb/hw/intel/Kconfig
index 91f995e..c166d50 100644
--- a/drivers/ntb/hw/intel/Kconfig
+++ b/drivers/ntb/hw/intel/Kconfig
@@ -2,6 +2,6 @@ config NTB_INTEL
 	tristate "Intel Non-Transparent Bridge support"
 	depends on X86_64
 	help
-	 This driver supports Intel NTB on capable Xeon and Atom hardware.
+	  This driver supports Intel NTB on capable Xeon and Atom hardware.
 
-	 If unsure, say N.
+	  If unsure, say N.
diff --git a/drivers/ntb/hw/mscc/Kconfig b/drivers/ntb/hw/mscc/Kconfig
index 013ed67..74ec015 100644
--- a/drivers/ntb/hw/mscc/Kconfig
+++ b/drivers/ntb/hw/mscc/Kconfig
@@ -2,8 +2,8 @@ config NTB_SWITCHTEC
 	tristate "MicroSemi Switchtec Non-Transparent Bridge Support"
 	select PCI_SW_SWITCHTEC
 	help
-	 Enables NTB support for Switchtec PCI switches. This also
-	 selects the Switchtec management driver as they share the same
-	 hardware interface.
+	  Enables NTB support for Switchtec PCI switches. This also
+	  selects the Switchtec management driver as they share the same
+	  hardware interface.
 
-	 If unsure, say N.
+	  If unsure, say N.
diff --git a/drivers/ntb/test/Kconfig b/drivers/ntb/test/Kconfig
index a5d0eda..416ab56 100644
--- a/drivers/ntb/test/Kconfig
+++ b/drivers/ntb/test/Kconfig
@@ -1,27 +1,27 @@
 config NTB_PINGPONG
 	tristate "NTB Ping Pong Test Client"
 	help
-	 This is a simple ping pong driver that exercises the scratchpads and
-	 doorbells of the ntb hardware.  This driver may be used to test that
-	 your ntb hardware and drivers are functioning at a basic level.
+	  This is a simple ping pong driver that exercises the scratchpads and
+	  doorbells of the ntb hardware.  This driver may be used to test that
+	  your ntb hardware and drivers are functioning at a basic level.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 config NTB_TOOL
 	tristate "NTB Debugging Tool Test Client"
 	help
-	 This is a simple debugging driver that enables the doorbell and
-	 scratchpad registers to be read and written from the debugfs.  This
-	 enables more complicated debugging to be scripted from user space.
-	 This driver may be used to test that your ntb hardware and drivers are
-	 functioning at a basic level.
+	  This is a simple debugging driver that enables the doorbell and
+	  scratchpad registers to be read and written from the debugfs.  This
+	  enables more complicated debugging to be scripted from user space.
+	  This driver may be used to test that your ntb hardware and drivers are
+	  functioning at a basic level.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 config NTB_PERF
 	tristate "NTB RAW Perf Measuring Tool"
 	help
-	 This is a tool to measure raw NTB performance by transferring data
-	 to and from the window without additional software interaction.
+	  This is a tool to measure raw NTB performance by transferring data
+	  to and from the window without additional software interaction.
 
-	 If unsure, say N.
+	  If unsure, say N.
-- 
1.9.1


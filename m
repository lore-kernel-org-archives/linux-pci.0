Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CCC43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE7520684
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 22:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCFWDH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:03:07 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfCFWDH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2019 17:03:07 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hR1-1h6LS53ZVR-004gMV; Wed, 06 Mar 2019 23:02:56 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Subject: [PATCH v2] drivers: ntb: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 23:02:54 +0100
Message-Id: <1551909774-24030-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551898265-18909-1-git-send-email-info@metux.net>
References: <1551898265-18909-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Bl+njPbEV0w+56O64Wf7oS73X7UZCx/l6nvKm8OWkrsYa0TD8/n
 FX8oKjfjdQ056I++QIP11oQl3W0RMbnRRP8MmbGOIT6o4q8oeLsxA845p1QbHivwflPBqii
 6FxqI7h7yYpYyaakNHPeXmbskPpVo+fOhYJN+HILSzTnUSZlH1lalSotzW271FEcKwM/2ZQ
 jAaah8ypaJwfz/RvWX3KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2bdSXbD1pl8=:kLpDz6KSMp+ZFF131gJ4bh
 7KpNe6opHF5CEoNJO7rQUTGnN/hVNM5TBWq17xxrhoicTc5DUo6NJbmThNI/wC0VbbT/A/mpa
 FcpCSbrbOyVQmGLuAIjHJkJ5LPMLaaZ+tru8g+BBrK1dlEp7gl7UdA6u2fhGjvD9EDYP5yxOV
 h+MJzQvJIY1kVhyk5CwXdr+KJ/FXCKVAAPqJYMWW34YGg5CnRM2kMowhgSLScdoqWt5aP1Swp
 8vvWOVWPPJd17Toz4eHQo9rMd4BzF3F09rl6PcFwKq0OB9IogwjO4fa92cumA2jRLHH+zwP/R
 TJXhEDo2WyNjp7apklGIAZ3UEZ/ypujETSbvy2y0SGrTRqEgSzfwmA6AqqbMelcX8kpZAdhcT
 odrbrCa0/BAXk6J2FvyXBka97UPF4RDc2s/FqzAQHBmW5VnX9SDsB4tv8XaqYIRjDmMvhY68w
 eUC9Fnmc9h3P+jbdE3a0pm+7Cw1LjNcntLhM7l8BjHgIavxKoKyf97KF5HwF25whWsHAmhul7
 gmBusxmqtJ49JFk3NGbs0E+4bGCAz56ICcWRODmAd8Qr1AnN57eQ9RQUKL1YUzQ98Ny3T2C9R
 W2x0//4AzZDARqKuEdStIvpPuMtYgD+LqROOfztB3cKWSxVhTzVQ6sngCJ60m8uXBnRJXIa0E
 KQik9qf74EF2PS+tXUX1iWP6XZHF/0XCOpAOoQPNfZnLFIkqnrO8tqbbhYRY24+Qgzg0XiS1/
 3v5bgkCpyEBY+/sKUbm1I63v18PdWPCVRUNdsA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

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


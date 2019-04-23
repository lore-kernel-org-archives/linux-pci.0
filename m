Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564E6C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137B12183E
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCiNdsu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfDWQhe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:37:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33908 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfDWQhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:37:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so7894436pgq.1;
        Tue, 23 Apr 2019 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTxWAkITaeuXkEicHzgb86kvZ4CtkW/rQaAM31H+6pk=;
        b=eCiNdsu6+WsWsnughnjrVWSGiV78Aj4u6TzDcIJXQxaGjmBFblUZvNFfWA09+0kmL9
         8fP6mWrIjKmuzVEygYbJPteG90WmilTSL/qi9t36gkH9YXG8prEpQ3WYP2xc8Pf9DL4P
         0Qn57e/UltVviGuYURQcjbVbrUtn8kqZypF2CdcASLlaOjinHz8X6fewYJq9oPmrqZcb
         p0I3zdEU+FmutX6PpxW+tnXmfmUv0fW78pBTezP6rBNNiHhvVmWZkDhMq5P+p+ZZy9ov
         LzWf2S3JSyYkkCAuOpRsF5U3a9+FZEetKJ0gbL0Pr0CEzEE/mJoSoOXv3SUKbJVuENvF
         rPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTxWAkITaeuXkEicHzgb86kvZ4CtkW/rQaAM31H+6pk=;
        b=Zzpn0XuI/EG+Jn6Gbpql9VZhdKNn3F4pwI4RfIEXjOpFBYk0xwd5sNi6dIcDzYG1Si
         PoNHU25QsVuCVCV1/4JeAHeGvHng7HMLfcUqQtQTqnkxjuaGFEPk4sMpSBoAMAmKwHSW
         hst0yRwti80AoMLVHiCTsxd+UPrVP4F7LgU8BLwB6ar2KhV1SdwgZEQlr6xGAoHKex6O
         OcrhppCSnkesnh4E/lcJ5nS29plPoZvcdHhDfK8nDRc1S6NK+TbwBOvqMUZ4E1D0z/BL
         zsqJb0OKWPMTaPBthSxjijfxVJ8wL/6xVaqay5gWzpuvkyQOL23qj9VcCC6z0O+m0poY
         Waog==
X-Gm-Message-State: APjAAAXuyslB+PIkGu0rdUexwcoIvAcJs3eQL0EmhWwivU98U0YYQd92
        gTRujuUoAAO0hKGGW3f6rzMPH7a5
X-Google-Smtp-Source: APXvYqwIjT4Aqw/dt4AUVuGLYUuDxUT4V1yUKq/FUkadRtEM7yUEg7aqxi/U6zQ5lVGejG97D3BMcw==
X-Received: by 2002:a63:330e:: with SMTP id z14mr25407161pgz.4.1556037452484;
        Tue, 23 Apr 2019 09:37:32 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:37:31 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 43/63] Documentation: x86: convert earlyprintk.txt to reST
Date:   Wed, 24 Apr 2019 00:29:12 +0800
Message-Id: <20190423162932.21428-44-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/x86/earlyprintk.rst | 148 ++++++++++++++++++++++++++++++
 Documentation/x86/earlyprintk.txt | 141 ----------------------------
 Documentation/x86/index.rst       |   1 +
 3 files changed, 149 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/x86/earlyprintk.rst
 delete mode 100644 Documentation/x86/earlyprintk.txt

diff --git a/Documentation/x86/earlyprintk.rst b/Documentation/x86/earlyprintk.rst
new file mode 100644
index 000000000000..519402451f9c
--- /dev/null
+++ b/Documentation/x86/earlyprintk.rst
@@ -0,0 +1,148 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Early Printk
+============
+
+Mini-HOWTO for using the earlyprintk=dbgp boot option with a
+USB2 Debug port key and a debug cable, on x86 systems.
+
+You need two computers, the 'USB debug key' special gadget and
+and two USB cables, connected like this::
+
+  [host/target] <-------> [USB debug key] <-------> [client/console]
+
+There are a number of specific hardware requirements
+====================================================
+
+ a) Host/target system needs to have USB debug port capability.
+
+  You can check this capability by looking at a 'Debug port' bit in
+  the lspci -vvv output::
+
+    # lspci -vvv
+    ...
+    00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
+            Subsystem: Lenovo ThinkPad T61
+            Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
+            Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+            Latency: 0
+            Interrupt: pin D routed to IRQ 19
+            Region 0: Memory at fe227000 (32-bit, non-prefetchable) [size=1K]
+            Capabilities: [50] Power Management version 2
+                    Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
+                    Status: D0 PME-Enable- DSel=0 DScale=0 PME+
+            Capabilities: [58] Debug port: BAR=1 offset=00a0
+                                ^^^^^^^^^^^ <==================== [ HERE ]
+      Kernel driver in use: ehci_hcd
+            Kernel modules: ehci-hcd
+    ...
+
+  If your system does not list a debug port capability then you probably
+  won't be able to use the USB debug key.
+
+ b) You also need a NetChip USB debug cable/key:
+
+        http://www.plxtech.com/products/NET2000/NET20DC/default.asp
+
+    This is a small blue plastic connector with two USB connections;
+    it draws power from its USB connections.
+
+ c) You need a second client/console system with a high speed USB 2.0 port.
+
+ d) The NetChip device must be plugged directly into the physical
+    debug port on the "host/target" system.  You cannot use a USB hub in
+    between the physical debug port and the "host/target" system.
+
+    The EHCI debug controller is bound to a specific physical USB
+    port and the NetChip device will only work as an early printk
+    device in this port.  The EHCI host controllers are electrically
+    wired such that the EHCI debug controller is hooked up to the
+    first physical port and there is no way to change this via software.
+    You can find the physical port through experimentation by trying
+    each physical port on the system and rebooting.  Or you can try
+    and use lsusb or look at the kernel info messages emitted by the
+    usb stack when you plug a usb device into various ports on the
+    "host/target" system.
+
+    Some hardware vendors do not expose the usb debug port with a
+    physical connector and if you find such a device send a complaint
+    to the hardware vendor, because there is no reason not to wire
+    this port into one of the physically accessible ports.
+
+ e) It is also important to note, that many versions of the NetChip
+    device require the "client/console" system to be plugged into the
+    right hand side of the device (with the product logo facing up and
+    readable left to right).  The reason being is that the 5 volt
+    power supply is taken from only one side of the device and it
+    must be the side that does not get rebooted.
+
+Software requirements
+=====================
+
+ a) On the host/target system:
+
+    You need to enable the following kernel config option::
+
+      CONFIG_EARLY_PRINTK_DBGP=y
+
+    And you need to add the boot command line: "earlyprintk=dbgp".
+
+    .. note:: If you are using Grub, append it to the 'kernel' line in
+     /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
+     append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
+     using Grub2 on an EFI firmware system, append it to the 'linux'
+     or 'linuxefi' line in /boot/grub2/grub.cfg or
+     /boot/efi/EFI/<distro>/grub.cfg.)
+
+    On systems with more than one EHCI debug controller you must
+    specify the correct EHCI debug controller number.  The ordering
+    comes from the PCI bus enumeration of the EHCI controllers.  The
+    default with no number argument is "0" or the first EHCI debug
+    controller.  To use the second EHCI debug controller, you would
+    use the command line: "earlyprintk=dbgp1"
+
+    NOTE: normally earlyprintk console gets turned off once the
+    regular console is alive - use "earlyprintk=dbgp,keep" to keep
+    this channel open beyond early bootup. This can be useful for
+    debugging crashes under Xorg, etc.
+
+ b) On the client/console system:
+
+    You should enable the following kernel config option::
+
+      CONFIG_USB_SERIAL_DEBUG=y
+
+    On the next bootup with the modified kernel you should
+    get a /dev/ttyUSBx device(s).
+
+    Now this channel of kernel messages is ready to be used: start
+    your favorite terminal emulator (minicom, etc.) and set
+    it up to use /dev/ttyUSB0 - or use a raw 'cat /dev/ttyUSBx' to
+    see the raw output.
+
+ c) On Nvidia Southbridge based systems: the kernel will try to probe
+    and find out which port has a debug device connected.
+
+Testing that it works fine
+==========================
+
+  You can test the output by using earlyprintk=dbgp,keep and provoking
+  kernel messages on the host/target system. You can provoke a harmless
+  kernel message by for example doing::
+
+    echo h > /proc/sysrq-trigger
+
+  On the host/target system you should see this help line in "dmesg" output::
+
+    SysRq : HELP : loglevel(0-9) reBoot Crashdump terminate-all-tasks(E) memory-full-oom-kill(F) kill-all-tasks(I) saK show-backtrace-all-active-cpus(L) show-memory-usage(M) nice-all-RT-tasks(N) powerOff show-registers(P) show-all-timers(Q) unRaw Sync show-task-states(T) Unmount show-blocked-tasks(W) dump-ftrace-buffer(Z)
+
+  On the client/console system do::
+
+    cat /dev/ttyUSB0
+
+  And you should see the help line above displayed shortly after you've
+  provoked it on the host system.
+
+If it does not work then please ask about it on the linux-kernel@vger.kernel.org
+mailing list or contact the x86 maintainers.
diff --git a/Documentation/x86/earlyprintk.txt b/Documentation/x86/earlyprintk.txt
deleted file mode 100644
index 46933e06c972..000000000000
--- a/Documentation/x86/earlyprintk.txt
+++ /dev/null
@@ -1,141 +0,0 @@
-
-Mini-HOWTO for using the earlyprintk=dbgp boot option with a
-USB2 Debug port key and a debug cable, on x86 systems.
-
-You need two computers, the 'USB debug key' special gadget and
-and two USB cables, connected like this:
-
-  [host/target] <-------> [USB debug key] <-------> [client/console]
-
-1. There are a number of specific hardware requirements:
-
- a.) Host/target system needs to have USB debug port capability.
-
- You can check this capability by looking at a 'Debug port' bit in
- the lspci -vvv output:
-
- # lspci -vvv
- ...
- 00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
-         Subsystem: Lenovo ThinkPad T61
-         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
-         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-         Latency: 0
-         Interrupt: pin D routed to IRQ 19
-         Region 0: Memory at fe227000 (32-bit, non-prefetchable) [size=1K]
-         Capabilities: [50] Power Management version 2
-                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+
-         Capabilities: [58] Debug port: BAR=1 offset=00a0
-                            ^^^^^^^^^^^ <==================== [ HERE ]
-	 Kernel driver in use: ehci_hcd
-         Kernel modules: ehci-hcd
- ...
-
-( If your system does not list a debug port capability then you probably
-  won't be able to use the USB debug key. )
-
- b.) You also need a NetChip USB debug cable/key:
-
-        http://www.plxtech.com/products/NET2000/NET20DC/default.asp
-
-     This is a small blue plastic connector with two USB connections;
-     it draws power from its USB connections.
-
- c.) You need a second client/console system with a high speed USB 2.0
-     port.
-
- d.) The NetChip device must be plugged directly into the physical
-     debug port on the "host/target" system.  You cannot use a USB hub in
-     between the physical debug port and the "host/target" system.
-
-     The EHCI debug controller is bound to a specific physical USB
-     port and the NetChip device will only work as an early printk
-     device in this port.  The EHCI host controllers are electrically
-     wired such that the EHCI debug controller is hooked up to the
-     first physical port and there is no way to change this via software.
-     You can find the physical port through experimentation by trying
-     each physical port on the system and rebooting.  Or you can try
-     and use lsusb or look at the kernel info messages emitted by the
-     usb stack when you plug a usb device into various ports on the
-     "host/target" system.
-
-     Some hardware vendors do not expose the usb debug port with a
-     physical connector and if you find such a device send a complaint
-     to the hardware vendor, because there is no reason not to wire
-     this port into one of the physically accessible ports.
-
- e.) It is also important to note, that many versions of the NetChip
-     device require the "client/console" system to be plugged into the
-     right hand side of the device (with the product logo facing up and
-     readable left to right).  The reason being is that the 5 volt
-     power supply is taken from only one side of the device and it
-     must be the side that does not get rebooted.
-
-2. Software requirements:
-
- a.) On the host/target system:
-
-    You need to enable the following kernel config option:
-
-      CONFIG_EARLY_PRINTK_DBGP=y
-
-    And you need to add the boot command line: "earlyprintk=dbgp".
-
-    (If you are using Grub, append it to the 'kernel' line in
-     /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
-     append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
-     using Grub2 on an EFI firmware system, append it to the 'linux'
-     or 'linuxefi' line in /boot/grub2/grub.cfg or
-     /boot/efi/EFI/<distro>/grub.cfg.)
-
-    On systems with more than one EHCI debug controller you must
-    specify the correct EHCI debug controller number.  The ordering
-    comes from the PCI bus enumeration of the EHCI controllers.  The
-    default with no number argument is "0" or the first EHCI debug
-    controller.  To use the second EHCI debug controller, you would
-    use the command line: "earlyprintk=dbgp1"
-
-    NOTE: normally earlyprintk console gets turned off once the
-    regular console is alive - use "earlyprintk=dbgp,keep" to keep
-    this channel open beyond early bootup. This can be useful for
-    debugging crashes under Xorg, etc.
-
- b.) On the client/console system:
-
-    You should enable the following kernel config option:
-
-      CONFIG_USB_SERIAL_DEBUG=y
-
-    On the next bootup with the modified kernel you should
-    get a /dev/ttyUSBx device(s).
-
-    Now this channel of kernel messages is ready to be used: start
-    your favorite terminal emulator (minicom, etc.) and set
-    it up to use /dev/ttyUSB0 - or use a raw 'cat /dev/ttyUSBx' to
-    see the raw output.
-
- c.) On Nvidia Southbridge based systems: the kernel will try to probe
-     and find out which port has a debug device connected.
-
-3. Testing that it works fine:
-
-   You can test the output by using earlyprintk=dbgp,keep and provoking
-   kernel messages on the host/target system. You can provoke a harmless
-   kernel message by for example doing:
-
-     echo h > /proc/sysrq-trigger
-
-   On the host/target system you should see this help line in "dmesg" output:
-
-     SysRq : HELP : loglevel(0-9) reBoot Crashdump terminate-all-tasks(E) memory-full-oom-kill(F) kill-all-tasks(I) saK show-backtrace-all-active-cpus(L) show-memory-usage(M) nice-all-RT-tasks(N) powerOff show-registers(P) show-all-timers(Q) unRaw Sync show-task-states(T) Unmount show-blocked-tasks(W) dump-ftrace-buffer(Z)
-
-   On the client/console system do:
-
-       cat /dev/ttyUSB0
-
-   And you should see the help line above displayed shortly after you've
-   provoked it on the host system.
-
-If it does not work then please ask about it on the linux-kernel@vger.kernel.org
-mailing list or contact the x86 maintainers.
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 8a666c5abc85..7b8388ebd43d 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -13,3 +13,4 @@ Linux x86 Support
    exception-tables
    kernel-stacks
    entry_64
+   earlyprintk
-- 
2.20.1


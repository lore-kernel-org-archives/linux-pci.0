Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34758 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeEPBdl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 May 2018 21:33:41 -0400
Received: by mail-pl0-f66.google.com with SMTP id ay10-v6so1118854plb.1
        for <linux-pci@vger.kernel.org>; Tue, 15 May 2018 18:33:41 -0700 (PDT)
From: Rajat Jain <rajatja@google.com>
To: Martin Mares <mj@ucw.cz>, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>
Subject: [PATCH] lspci: Indicate if the OS / kernel go out-of-sync on BAR
Date: Tue, 15 May 2018 18:33:33 -0700
Message-Id: <20180516013333.135259-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the OS and device are reporting different BAR(s), currently
the lspci will happily show the OS version with no indication what
so ever that there is a problem. This is not correct in my opinion
because lspci is often used to debug devices, so should either show
the BAR reported by the device, or atleast an indication of
out-of-sync.

I spent a lot of time debugging a PCI device that would unexpectedly
clear out the BAR register due to some bug, and it was quite later
I realized that the lspci is showing me the OS version. So fix that.

On a system that is in problem state:

localhost ~ # setpci -s 1:0.0 0x10.l
00000004  <=== BAR is zeroed out
localhost ~ #

Before:

localhost ~ # lspci -v -s 1:0.0
01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
        Subsystem: Intel Corporation Dual Band Wireless-AC 7265
        Flags: bus master, fast devsel, latency 0, IRQ 275
        Memory at d1400000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number b4-d5-bd-ff-ff-c8-a1-6d
        Capabilities: [14c] Latency Tolerance Reporting
        Capabilities: [154] L1 PM Substates
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi

After:

localhost ~ # lspci -v -s 1:0.0
01:00.0 Network controller: Device 8086:095a (rev 59)
        Subsystem: Device 8086:5010
        Flags: bus master, fast devsel, latency 0, IRQ 275
        [out-of-sync] Memory at d1400000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number b4-d5-bd-ff-ff-c8-a1-6d
        Capabilities: [14c] Latency Tolerance Reporting
        Capabilities: [154] L1 PM Substates
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 lspci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lspci.c b/lspci.c
index 748452c..81c65f3 100644
--- a/lspci.c
+++ b/lspci.c
@@ -371,6 +371,20 @@ show_range(char *prefix, u64 base, u64 limit, int is_64bit)
   putchar('\n');
 }
 
+static pciaddr_t
+bar_value(struct device *d, int i, u32 flg)
+{
+  pciaddr_t val = 0;
+
+  /* Read higher order 32 bits if it's a 64 bit bar in memory space */
+  if (i < 5 && !(flg & PCI_BASE_ADDRESS_SPACE_IO) &&
+      (flg & PCI_BASE_ADDRESS_MEM_TYPE_MASK == PCI_BASE_ADDRESS_MEM_TYPE_64))
+      val = get_conf_long(d, PCI_BASE_ADDRESS_0 + 4 * (i + 1));
+
+  val = (val << 32) | flg;
+  return val;
+}
+
 static void
 show_bases(struct device *d, int cnt)
 {
@@ -401,6 +415,10 @@ show_bases(struct device *d, int cnt)
 	  flg = pos;
 	  virtual = 1;
 	}
+      else if (pos != bar_value(d, i, flg))
+	{
+	  printf("[out-of-sync] ");
+	}
       if (flg & PCI_BASE_ADDRESS_SPACE_IO)
 	{
 	  pciaddr_t a = pos & PCI_BASE_ADDRESS_IO_MASK;
-- 
2.17.0.441.gb46fe60e1d-goog

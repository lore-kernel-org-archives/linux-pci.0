Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38230 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeHaLhJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2018 07:37:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id e2-v6so5053219pgv.5
        for <linux-pci@vger.kernel.org>; Fri, 31 Aug 2018 00:31:03 -0700 (PDT)
From: Daniel Drake <drake@endlessm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org,
        peter@lekensteyn.nl, kherbst@redhat.com
Subject: [PATCH] PCI: add prefetch quirk to work around Asus/Nvidia suspend issues
Date: Fri, 31 Aug 2018 15:30:57 +0800
Message-Id: <20180831073057.14626-1-drake@endlessm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On over 40 Intel-based Asus products, the nvidia GPU becomes unusable
after S3 suspend/resume. The affected products include multiple
generations of nvidia GPUs and Intel SoCs. After resume, nouveau logs
many errors such as:

    fifo: fault 00 [READ] at 0000005555555000 engine 00 [GR] client 04 [HUB/FE] reason 4a [] on channel -1 [007fa91000 unknown]
    DRM: failed to idle channel 0 [DRM]

Similarly, the nvidia proprietary driver also fails after resume
(black screen, 100% CPU usage in Xorg process). We shipped a sample
to Nvidia for diagnosis, and their response indicated that it's a
problem with the parent PCI bridge (on the Intel SoC), not the GPU.

We found a workaround: on resume, rewrite the Intel PCI bridge
'Prefetchable Base Upper 32 Bits' register. In the cases that I checked,
this register has value 0 and we just have to rewrite that value.

It's very strange that rewriting the exact same register value
makes a difference, but it definitely makes the issue go away.
It's not just acting as some kind of memory barrier, because rewriting
other bridge registers does not work around the issue. There's something
magic in this particular register.

We examined our database of Asus hardware and identified 43 products
that we believe are affected. Checking the nvidia GPU parent PCI bridge
on each one, in total 5 Intel PCI bridges need quirking as below.
The quirk will run on bridges even where no nvidia GPU is connected,
but it should be harmless, and we at least limit it to only running
on Asus products.

This fix was tested on all the affected models that we have in hands
(X542UQ, UX533FD, X530UN, V272UN).

Signed-off-by: Daniel Drake <drake@endlessm.com>
---

Notes:
    If anyone has ideas for why writing this register makes a difference, or
    suggestions for other approaches then I'm all ears...
    
    Here is some basic info of the 43 products believed to be affected:
    basic DMI data, nvidia GPU PCI info, parent PCI bridge info.
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: FX502VD
    product_name: FX502VD
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1c8d] (rev ff) (prog-if ff)
    	!!! Unknown header type 7f
    00:01.0 PCI bridge [0604]: Intel Corporation Device [8086:1901] (rev 05) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: FX570UD
    product_name: ASUS Gaming FX570UD
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1f40]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: GL553VD
    product_name: GL553VD
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:15e0]
    00:01.0 PCI bridge [0604]: Intel Corporation Device [8086:1901] (rev 05) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: GL553VD
    product_name: GL553VD
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:15e0]
    00:01.0 PCI bridge [0604]: Intel Corporation Device [8086:1901] (rev 05) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: GL753VD
    product_name: GL753VD
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1590]
    00:01.0 PCI bridge [0604]: Intel Corporation Device [8086:1901] (rev 05) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: GL753VD
    product_name: GL753VD
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1590]
    00:01.0 PCI bridge [0604]: Intel Corporation Device [8086:1901] (rev 05) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: K401UQK
    product_name: K401UQK
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:14b0]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: P1440UF
    product_name: ASUSPRO P1440UF
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:174d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1f10]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: P2440UQ
    product_name: P2440UQ
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:13ce]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: P2540NV
    product_name: P2540NV
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134f] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:17f0]
    00:13.0 PCI bridge [0604]: Intel Corporation Device [8086:5ad8] (rev fb) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: P2540NV
    product_name: P2540NV
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134f] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:17f0]
    00:13.0 PCI bridge [0604]: Intel Corporation Device [8086:5ad8] (rev fb) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: P2540UV
    product_name: P2540UV
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134f] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:132e]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: P4540UQ
    product_name: P4540UQ
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1650]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: UX331UN
    product_name: UX331UN
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1d12] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:15de]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: UX410UQK
    product_name: UX410UQK
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:138e]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: UX430UQ
    product_name: UX430UQ
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:139e]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: UX430UQ
    product_name: UX430UQ
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:139e]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: UX533FD
    product_name: ZenBook UX533FD_UX533FD
    02:00.0 3D controller [0302]: NVIDIA Corporation GP107M [GeForce GTX 1050 Mobile] [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. GP107M [GeForce GTX 1050 Mobile] [1043:14a1]
    00:1c.4 PCI bridge [0604]: Intel Corporation Device [8086:9dbc] (rev f0) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: V221ID
    product_name: V221ID
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134f] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:15f0]
    00:13.0 PCI bridge [0604]: Intel Corporation Device [8086:5ad8] (rev fb) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: V272UN
    product_name: Vivo AIO 27 V272UN
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1d10] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:17be]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X430UN
    product_name: VivoBook S14 X430UN
    01:00.0 3D controller [0302]: NVIDIA Corporation GP108M [GeForce MX150] [10de:1d10] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. GP108M [GeForce MX150] [1043:199e]
    00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI Express Root Port [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X441MB
    product_name: X441MB
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:174e] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:171e]
    00:13.0 PCI bridge [0604]: Intel Corporation Device [8086:31d8] (rev f3) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X456UF
    product_name: X456UF
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1346] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:245a]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X510UQ
    product_name: X510UQ
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:145e]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X530UN
    product_name: VivoBook S15 X530UN
    01:00.0 3D controller [0302]: NVIDIA Corporation GP108M [GeForce MX150] [10de:1d10] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. GP108M [GeForce MX150] [1043:18ce]
    00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI Express Root Port [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X541UV
    product_name: X541UV
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134f] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:11ee]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X542UN
    product_name: X542UN
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1d10] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1b10]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X542UQ
    product_name: X542UQ
    01:00.0 3D controller [0302]: NVIDIA Corporation GM108M [GeForce 940MX] [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. GM108M [GeForce 940MX] [1043:142e]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X555UB
    product_name: X555UB
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1347] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:246a]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X555UQ
    product_name: X555UQ
    01:00.0 3D controller [0302]: NVIDIA Corporation GM108M [GeForce 940MX] [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. GM108M [GeForce 940MX] [1043:246a]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X556URK
    product_name: X556URK
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134e] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1490]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X570ZD
    product_name: VivoBook_ASUS Laptop X570ZD
    01:00.0 3D controller [0302]: NVIDIA Corporation GP107M [GeForce GTX 1050 Mobile] [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. GP107M [GeForce GTX 1050 Mobile] [1043:11d1]
    00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:15d3] (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X580GD
    product_name: VivoBook_ASUSLaptop X580GD_X580GD
    01:00.0 3D controller [0302]: NVIDIA Corporation GP107M [GeForce GTX 1050 Mobile] [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. GP107M [GeForce GTX 1050 Mobile] [1043:1fc0]
    00:01.0 PCI bridge [0604]: Intel Corporation Skylake PCIe Controller (x16) [8086:1901] (rev 07) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X580VD
    product_name: X580VD
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1a10]
    00:01.0 PCI bridge [0604]: Intel Corporation Device [8086:1901] (rev 05) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X580VD
    product_name: X580VD
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1c8d] (rev ff) (prog-if ff)
    	!!! Unknown header type 7f
    00:01.0 PCI bridge [0604]: Intel Corporation Device [8086:1901] (rev 05) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X705FD
    product_name: VivoBook Pro 17 X705FD_X705FD
    02:00.0 3D controller [0302]: NVIDIA Corporation GP107M [GeForce GTX 1050 Mobile] [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. GP107M [GeForce GTX 1050 Mobile] [1043:1431]
    00:1c.4 PCI bridge [0604]: Intel Corporation Device [8086:9dbc] (rev f0) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X705UD
    product_name: X705UD
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1c8d] (rev a1)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1b30]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X705UQ
    product_name: X705UQ
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:148e]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: X751NV
    product_name: X751NV
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134f] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:13be]
    00:13.0 PCI bridge [0604]: Intel Corporation Device [8086:5ad8] (rev fb) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: Z240IE
    product_name: Z240IE
    01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:1c8d] (rev a1) (prog-if 00 [VGA controller])
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1750]
    00:01.0 PCI bridge [0604]: Intel Corporation Device [8086:1901] (rev 05) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: ZN220IC-K
    product_name: ZN220IC-K
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134e] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:117e]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: ZN241IC
    product_name: ZN241IC
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1900]
    00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    
    sys_vendor: ASUSTeK COMPUTER INC.
    board_name: ZN270IE
    product_name: ZN270IE
    01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:134d] (rev a2)
    	Subsystem: ASUSTeK Computer Inc. Device [1043:1720]
    00:01.0 PCI bridge [0604]: Intel Corporation Device [8086:1901] (rev 05) (prog-if 00 [Normal decode])

 drivers/pci/quirks.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ef7143a274e0..e0d956ee459c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5119,3 +5119,26 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8575,
 			quirk_switchtec_ntb_dma_alias);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSEMI, 0x8576,
 			quirk_switchtec_ntb_dma_alias);
+
+/*
+ * The Nvidia GPU on many Intel-based Asus products is unusable after
+ * S3 resume. However, for unknown reasons, rewriting the value of register
+ * 'Prefetchable Base Upper 32 Bits' on the parent PCI bridge works around
+ * the issue.
+ */
+static void quirk_asus_pci_prefetch(struct pci_dev *bridge)
+{
+	const char *sys_vendor = dmi_get_system_info(DMI_SYS_VENDOR);
+	u32 value;
+
+	if (strcmp(sys_vendor, "ASUSTeK COMPUTER INC.") != 0)
+		return;
+
+	pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &value);
+	pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, value);
+}
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x1901, quirk_asus_pci_prefetch);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x31d8, quirk_asus_pci_prefetch);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad8, quirk_asus_pci_prefetch);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x9d10, quirk_asus_pci_prefetch);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x9dbc, quirk_asus_pci_prefetch);
-- 
2.17.1

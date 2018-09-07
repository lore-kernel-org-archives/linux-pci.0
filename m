Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36565 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeIGKPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2018 06:15:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so6414813pgo.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Sep 2018 22:36:24 -0700 (PDT)
From: Daniel Drake <drake@endlessm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org,
        peter@lekensteyn.nl, kherbst@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael.j.wysocki@intel.com,
        keith.busch@intel.com, mika.westerberg@linux.intel.com,
        jonathan.derrick@intel.com, kugel@rockbox.org, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org, nic_swsd@realtek.com
Subject: [PATCH] PCI: Reprogram bridge prefetch registers on resume
Date: Fri,  7 Sep 2018 13:36:14 +0800
Message-Id: <20180907053614.6540-1-drake@endlessm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 38+ Intel-based Asus products, the nvidia GPU becomes unusable
after S3 suspend/resume. The affected products include multiple
generations of nvidia GPUs and Intel SoCs. After resume, nouveau logs
many errors such as:

    fifo: fault 00 [READ] at 0000005555555000 engine 00 [GR] client 04 [HUB/FE] reason 4a [] on channel -1 [007fa91000 unknown]
    DRM: failed to idle channel 0 [DRM]

Similarly, the nvidia proprietary driver also fails after resume
(black screen, 100% CPU usage in Xorg process). We shipped a sample
to Nvidia for diagnosis, and their response indicated that it's a
problem with the parent PCI bridge (on the Intel SoC), not the GPU.

Runtime suspend/resume works fine, only S3 suspend is affected.

We found a workaround: on resume, rewrite the Intel PCI bridge
'Prefetchable Base Upper 32 Bits' register (PCI_PREF_BASE_UPPER32). In
the cases that I checked, this register has value 0 and we just have to
rewrite that value.

It's very strange that rewriting the exact same register value
makes a difference, but it definitely makes the issue go away.
It's not just acting as some kind of memory barrier, because rewriting
other bridge registers does not work around the issue. There's something
magic in this particular register. We have confirmed this on all
the affected models we have in-hands (X542UQ, UX533FD, X530UN, V272UN).

Additionally, this workaround solves an issue where r8169 MSI-X
interrupts were broken after S3 suspend/resume on Asus X441UAR. This
issue was recently worked around in commit 7bb05b85bc2d ("r8169:
don't use MSI-X on RTL8106e"). It also fixes the same issue on
RTL6186evl/8111evl on an Aimfor-tech laptop that we had not yet
patched. I suspect it will also fix the issue that was worked around in
commit 7c53a722459c ("r8169: don't use MSI-X on RTL8168g").

Thomas Martitz reports that this workaround also solves an issue where
the AMD Radeon Polaris 10 GPU on the HP Zbook 14u G5 is unresponsive
after S3 suspend/resume.

>From our testing, the affected Intel PCI bridges are:
Intel Skylake PCIe Controller (x16) [8086:1901] (rev 05)
Intel Skylake PCIe Controller (x16) [8086:1901] (rev 07)
Intel Device [8086:31d8] (rev f3)
Intel Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1 [8086:5ad6] (rev fb)
Intel Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port A #1 [8086:5ad8] (rev fb)
Intel Sunrise Point-LP PCI Express Root Port [8086:9d10] (rev f1)
Intel Sunrise Point-LP PCI Express Root Port #5 [8086:9d14] (rev f1)
Intel Device [8086:9dbc] (rev f0)

On resume, reprogram the PCI bridge prefetch registers, including the
magic register mentioned above.

This matches Win10 behaviour, which also rewrites these registers
during S3 resume (checked with qemu tracing).

Link: https://marc.info/?i=CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com
Link: https://bugs.freedesktop.org/show_bug.cgi?id=105760
Signed-off-by: Daniel Drake <drake@endlessm.com>
---

Notes:
    Replaces patch:
       PCI: add prefetch quirk to work around Asus/Nvidia suspend issues
    
    Below is the list of Asus products with Intel/Nvidia that we
    believe are affected by the GPU resume issue.
    
    I revised my counting method from my last patch to eliminate duplicate
    platforms that had multiple SKUs with the same DMI/GPU/bridge, that's why
    the product count reduced from 43 to 38.
    
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

 drivers/pci/pci-driver.c | 14 ++++++++++++++
 drivers/pci/setup-bus.c  |  2 +-
 include/linux/pci.h      |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bef17c3fca67..034f816570ad 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -524,6 +524,20 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 	pci_power_up(pci_dev);
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
+
+	/*
+	 * Redo the PCI bridge prefetch register setup.
+	 *
+	 * This works around an Intel PCI bridge issue seen on Asus and HP
+	 * laptops, where the GPU is not usable after S3 resume.
+	 * Even though PCI bridge register contents appear to be intact
+	 * at resume time, rewriting the value of PREF_BASE_UPPER32 is
+	 * required to make the GPU work.
+	 * Windows 10 also reprograms these registers during S3 resume.
+	 */
+	if (pci_dev->class == PCI_CLASS_BRIDGE_PCI << 8)
+		pci_setup_bridge_mmio_pref(pci_dev);
+
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 }
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1824e83b4..cb88288d2a69 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -630,7 +630,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
 }
 
-static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
+void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 {
 	struct resource *res;
 	struct pci_bus_region region;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8dd6241..b15828fc26a4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -934,6 +934,7 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
 void pci_bus_add_device(struct pci_dev *dev);
+void pci_setup_bridge_mmio_pref(struct pci_dev *bridge);
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res);
-- 
2.17.1

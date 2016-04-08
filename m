Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v11 55/60] PCI, x86: Allocate from high in available window for MMIO
Date: Thu,  7 Apr 2016 17:16:08 -0700
Message-Id: <1460074573-7481-56-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current code just use aligned start from avialable window, that could waste
big alignment from start.

We can align to the end from avialable window, so will save
start with big align to others: like second try for pref mmio
after first try already have non-pref assigned.

pci tree:
-[0000:00]-+-00.0
           +-1c.0-[01-10]--+-00.0-[02-10]--+-01.0-[03]----00.0  PLX Technology, Inc. Device 87b1
           |               |               +-02.0-[04-09]--+-00.0-[05-09]--+-01.0-[06]----00.0  PLX Technology, Inc. Device 87b1
           |               |               |               |               +-02.0-[07]----00.0  Broadcom Corporation Device 8650
           |               |               |               |               +-03.0-[08]--
           |               |               |               |               \-04.0-[09]----00.0  Altera Corporation Device 0201
           |               |               |               +-00.1  PLX Technology, Inc. Device 87d0
           |               |               |               +-00.2  PLX Technology, Inc. Device 87d0
           |               |               |               +-00.3  PLX Technology, Inc. Device 87d0
           |               |               |               \-00.4  PLX Technology, Inc. Device 87d0
           |               |               +-03.0-[0a-0f]--+-00.0-[0b-0f]--+-01.0-[0c]----00.0  PLX Technology, Inc. Device 87b1
           |               |               |               |               +-02.0-[0d]----00.0  Broadcom Corporation Device 8650
           |               |               |               |               +-03.0-[0e]--
           |               |               |               |               \-04.0-[0f]----00.0  Altera Corporation Device 0201
           |               |               |               +-00.1  PLX Technology, Inc. Device 87d0
           |               |               |               +-00.2  PLX Technology, Inc. Device 87d0
           |               |               |               +-00.3  PLX Technology, Inc. Device 87d0
           |               |               |               \-00.4  PLX Technology, Inc. Device 87d0
           |               |               \-04.0-[10]--
           |               +-00.1  PLX Technology, Inc. Device 87d0
           |               +-00.2  PLX Technology, Inc. Device 87d0
           |               +-00.3  PLX Technology, Inc. Device 87d0
           |               \-00.4  PLX Technology, Inc. Device 87d0
           +-1c.3-[11]----00.0

hotplug device under 0000:02:03.0

before the patch:

pci 0000:0a:00.0: BAR 9: no space for [mem size 0x03000000 64bit pref]
pci 0000:0a:00.0: BAR 9: failed to assign [mem size 0x03000000 64bit pref]
pci 0000:0a:00.0: BAR 8: assigned [mem 0xb0000000-0xb01fffff]  **************
pci 0000:0a:00.0: BAR 0: assigned [mem 0xb0200000-0xb023ffff]
pci 0000:0a:00.1: BAR 0: assigned [mem 0xb0240000-0xb0241fff]
pci 0000:0a:00.2: BAR 0: assigned [mem 0xb0242000-0xb0243fff]
pci 0000:0a:00.3: BAR 0: assigned [mem 0xb0244000-0xb0245fff]
pci 0000:0a:00.4: BAR 0: assigned [mem 0xb0246000-0xb0247fff]
pci 0000:0b:04.0: BAR 9: no space for [mem size 0x03000000 64bit pref]
pci 0000:0b:04.0: BAR 9: failed to assign [mem size 0x03000000 64bit pref]
pci 0000:0b:01.0: BAR 8: assigned [mem 0xb0000000-0xb00fffff]
pci 0000:0b:02.0: BAR 8: assigned [mem 0xb0100000-0xb01fffff]
pci 0000:0c:00.0: BAR 0: assigned [mem 0xb0000000-0xb003ffff]
pci 0000:0b:01.0: PCI bridge to [bus 0c]
pci 0000:0b:01.0:   bridge window [mem 0xb0000000-0xb00fffff]
pci 0000:0d:00.0: BAR 0: assigned [mem 0xb0100000-0xb013ffff 64bit]
pci 0000:0b:02.0: PCI bridge to [bus 0d]
pci 0000:0b:02.0:   bridge window [mem 0xb0100000-0xb01fffff]
pci 0000:0b:03.0: PCI bridge to [bus 0e]
pci 0000:0f:00.0: BAR 0: no space for [mem size 0x02000000 64bit pref]
pci 0000:0f:00.0: BAR 0: failed to assign [mem size 0x02000000 64bit pref]
pci 0000:0f:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
pci 0000:0f:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
pci 0000:0b:04.0: PCI bridge to [bus 0f]
pci 0000:0a:00.0: PCI bridge to [bus 0b-0f]
pci 0000:0a:00.0:   bridge window [mem 0xb0000000-0xb01fffff]
pcieport 0000:02:03.0: PCI bridge to [bus 0a-0f]
pcieport 0000:02:03.0:   bridge window [io  0x2000-0x2fff]
pcieport 0000:02:03.0:   bridge window [mem 0xb0000000-0xb24fffff]
pcieport 0000:02:03.0:   bridge window [mem 0x80200000-0x803fffff 64bit pref]
PCI: No. 2 try to assign unassigned res
pcieport 0000:02:03.0: resource 9 [mem 0x80200000-0x803fffff 64bit pref] released
pcieport 0000:02:03.0: PCI bridge to [bus 0a-0f]
pcieport 0000:02:03.0: BAR 9: no space for [mem size 0x03000000 64bit pref]
pcieport 0000:02:03.0: BAR 9: failed to assign [mem size 0x03000000 64bit pref]
pcieport 0000:02:03.0: BAR 9: no space for [mem size 0x02100000 64bit pref]
pcieport 0000:02:03.0: BAR 9: failed to assign [mem size 0x02100000 64bit pref]
pci 0000:0a:00.0: BAR 9: no space for [mem size 0x03000000 64bit pref]
pci 0000:0a:00.0: BAR 9: failed to assign [mem size 0x03000000 64bit pref]
pci 0000:0a:00.0: BAR 9: no space for [mem size 0x02100000 64bit pref]   **************
pci 0000:0a:00.0: BAR 9: failed to assign [mem size 0x02100000 64bit pref]
pci 0000:0b:04.0: BAR 9: no space for [mem size 0x03000000 64bit pref]
pci 0000:0b:04.0: BAR 9: failed to assign [mem size 0x03000000 64bit pref]
pci 0000:0b:04.0: BAR 9: no space for [mem size 0x02100000 64bit pref]   **************
pci 0000:0b:04.0: BAR 9: failed to assign [mem size 0x02100000 64bit pref]
pci 0000:0b:01.0: PCI bridge to [bus 0c]
pci 0000:0b:01.0:   bridge window [mem 0xb0000000-0xb00fffff]
pci 0000:0b:02.0: PCI bridge to [bus 0d]
pci 0000:0b:02.0:   bridge window [mem 0xb0100000-0xb01fffff]
pci 0000:0b:03.0: PCI bridge to [bus 0e]
pci 0000:0f:00.0: BAR 0: no space for [mem size 0x02000000 64bit pref]
pci 0000:0f:00.0: BAR 0: failed to assign [mem size 0x02000000 64bit pref]
pci 0000:0f:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
pci 0000:0f:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
pci 0000:0b:04.0: PCI bridge to [bus 0f]
pci 0000:0a:00.0: PCI bridge to [bus 0b-0f]
pci 0000:0a:00.0:   bridge window [mem 0xb0000000-0xb01fffff]
pcieport 0000:02:03.0: PCI bridge to [bus 0a-0f]
pcieport 0000:02:03.0:   bridge window [io  0x2000-0x2fff]
pcieport 0000:02:03.0:   bridge window [mem 0xb0000000-0xb24fffff]


after the patch:

pci 0000:0a:00.0: BAR 9: no space for [mem size 0x03000000 64bit pref]
pci 0000:0a:00.0: BAR 9: failed to assign [mem size 0x03000000 64bit pref]
pci 0000:0a:00.0: BAR 8: assigned [mem 0xb2300000-0xb24fffff]   *************
pci 0000:0a:00.0: BAR 0: assigned [mem 0xb22c0000-0xb22fffff]
pci 0000:0a:00.1: BAR 0: assigned [mem 0xb22be000-0xb22bffff]
pci 0000:0a:00.2: BAR 0: assigned [mem 0xb22bc000-0xb22bdfff]
pci 0000:0a:00.3: BAR 0: assigned [mem 0xb22ba000-0xb22bbfff]
pci 0000:0a:00.4: BAR 0: assigned [mem 0xb22b8000-0xb22b9fff]
pci 0000:0b:04.0: BAR 9: no space for [mem size 0x03000000 64bit pref]
pci 0000:0b:04.0: BAR 9: failed to assign [mem size 0x03000000 64bit pref]
pci 0000:0b:01.0: BAR 8: assigned [mem 0xb2400000-0xb24fffff]
pci 0000:0b:02.0: BAR 8: assigned [mem 0xb2300000-0xb23fffff]
pci 0000:0c:00.0: BAR 0: assigned [mem 0xb24c0000-0xb24fffff]
pci 0000:0b:01.0: PCI bridge to [bus 0c]
pci 0000:0b:01.0:   bridge window [mem 0xb2400000-0xb24fffff]
pci 0000:0d:00.0: BAR 0: assigned [mem 0xb23c0000-0xb23fffff 64bit]
pci 0000:0b:02.0: PCI bridge to [bus 0d]
pci 0000:0b:02.0:   bridge window [mem 0xb2300000-0xb23fffff]
pci 0000:0b:03.0: PCI bridge to [bus 0e]
pci 0000:0f:00.0: BAR 0: no space for [mem size 0x02000000 64bit pref]
pci 0000:0f:00.0: BAR 0: failed to assign [mem size 0x02000000 64bit pref]
pci 0000:0f:00.0: BAR 2: no space for [mem size 0x00010000 64bit pref]
pci 0000:0f:00.0: BAR 2: failed to assign [mem size 0x00010000 64bit pref]
pci 0000:0b:04.0: PCI bridge to [bus 0f]
pci 0000:0a:00.0: PCI bridge to [bus 0b-0f]
pci 0000:0a:00.0:   bridge window [mem 0xb2300000-0xb24fffff]
pcieport 0000:02:03.0: PCI bridge to [bus 0a-0f]
pcieport 0000:02:03.0:   bridge window [io  0x2000-0x2fff]
pcieport 0000:02:03.0:   bridge window [mem 0xb0000000-0xb24fffff]
pcieport 0000:02:03.0:   bridge window [mem 0x9fc00000-0x9fdfffff 64bit pref]
PCI: No. 2 try to assign unassigned res
pcieport 0000:02:03.0: resource 9 [mem 0x9fc00000-0x9fdfffff 64bit pref] released
pcieport 0000:02:03.0: PCI bridge to [bus 0a-0f]
pcieport 0000:02:03.0: BAR 9: no space for [mem size 0x03000000 64bit pref]
pcieport 0000:02:03.0: BAR 9: failed to assign [mem size 0x03000000 64bit pref]
pcieport 0000:02:03.0: BAR 9: no space for [mem size 0x02100000 64bit pref]
pcieport 0000:02:03.0: BAR 9: failed to assign [mem size 0x02100000 64bit pref]
pci 0000:0a:00.0: BAR 9: no space for [mem size 0x03000000 64bit pref]
pci 0000:0a:00.0: BAR 9: failed to assign [mem size 0x03000000 64bit pref]
pci 0000:0a:00.0: BAR 9: assigned [mem 0xb0000000-0xb20fffff 64bit pref]  *********
pci 0000:0b:04.0: BAR 9: no space for [mem size 0x03000000 64bit pref]
pci 0000:0b:04.0: BAR 9: failed to assign [mem size 0x03000000 64bit pref]
pci 0000:0b:04.0: BAR 9: assigned [mem 0xb0000000-0xb20fffff 64bit pref]  *********
pci 0000:0b:01.0: PCI bridge to [bus 0c]
pci 0000:0b:01.0:   bridge window [mem 0xb2400000-0xb24fffff]
pci 0000:0b:02.0: PCI bridge to [bus 0d]
pci 0000:0b:02.0:   bridge window [mem 0xb2300000-0xb23fffff]
pci 0000:0b:03.0: PCI bridge to [bus 0e]
pci 0000:0f:00.0: BAR 0: assigned [mem 0xb0000000-0xb1ffffff 64bit pref]   ********
pci 0000:0f:00.0: BAR 2: assigned [mem 0xb20f0000-0xb20fffff 64bit pref]   ********
pci 0000:0b:04.0: PCI bridge to [bus 0f]
pci 0000:0b:04.0:   bridge window [mem 0xb0000000-0xb20fffff 64bit pref]
pci 0000:0a:00.0: PCI bridge to [bus 0b-0f]
pci 0000:0a:00.0:   bridge window [mem 0xb2300000-0xb24fffff]
pci 0000:0a:00.0:   bridge window [mem 0xb0000000-0xb20fffff 64bit pref]
pcieport 0000:02:03.0: PCI bridge to [bus 0a-0f]
pcieport 0000:02:03.0:   bridge window [io  0x2000-0x2fff]
pcieport 0000:02:03.0:   bridge window [mem 0xb0000000-0xb24fffff]

So we allocate high for 0a:00.0 and etc, and leave low range like 0xb0000000 to
0b:04.0 and 0f:00.0

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/pci/i386.c     | 20 ++++++++++++++++++++
 drivers/pci/setup-bus.c | 11 ++++++++++-
 include/linux/pci.h     |  3 +++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index cf296f5..6121ef3 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -128,6 +128,24 @@ static void __init pcibios_fw_addr_list_del(void)
 	pcibios_fw_addr_done = true;
 }
 
+resource_size_t
+pcibios_align_end_resource(void *data, const struct resource *res,
+			resource_size_t size, resource_size_t align)
+{
+	resource_size_t start = res->start;
+
+	/* Take near end */
+	if (res->end + 1 > size) {
+		resource_size_t new_start;
+
+		new_start = round_down(res->end + 1 - size, align);
+		if (new_start > start)
+			start = new_start;
+	}
+
+	return start;
+}
+
 /*
  * We need to avoid collisions with `mirrored' VGA ports
  * and other strange ISA hardware, so we always want the
@@ -154,6 +172,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
+		start = pcibios_align_end_resource(data, res, size, align);
+
 		/* The low 1MB range is reserved for ISA cards */
 		if (start < BIOS_END)
 			start = BIOS_END;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 65a41e7..c282b86 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1318,6 +1318,15 @@ static void sort_align_test(struct list_head *head)
 	}
 }
 
+resource_size_t __weak pcibios_align_end_resource(void *data,
+					  const struct resource *res,
+					  resource_size_t size,
+					  resource_size_t align)
+{
+	/* default is not aligned to end */
+	return res->start;
+}
+
 static bool is_align_size_good(struct list_head *head,
 			resource_size_t min_align, resource_size_t size,
 			resource_size_t start)
@@ -1335,7 +1344,7 @@ static bool is_align_size_good(struct list_head *head,
 	list_for_each_entry(p, head, list)
 		if (allocate_resource(&root, &p->res, p->size,
 				0, (resource_size_t)-1ULL,
-				p->align, NULL, NULL))
+				p->align, pcibios_align_end_resource, NULL))
 			return false;
 
 	return true;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d7b1ceb..41d06ce 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -800,6 +800,9 @@ char *pcibios_setup(char *str);
 resource_size_t pcibios_align_resource(void *, const struct resource *,
 				resource_size_t,
 				resource_size_t);
+resource_size_t pcibios_align_end_resource(void *, const struct resource *,
+				resource_size_t,
+				resource_size_t);
 void pcibios_update_irq(struct pci_dev *, int irq);
 
 /* Weak but can be overriden by arch */
-- 
1.8.4.5

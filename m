Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:EFIFB FRAMEBUFFER DRIVER),
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH] efi/fb: Convert PCI bus address to resource if translated by the bridge
Date: Wed, 16 May 2018 14:23:49 -0400
Message-Id: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A host bridge is allowed to remap BAR addresses using _TRA attribute in
_CRS windows.

pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]

When a VGA device is behind such a host bridge and the resource is
translated efifb driver is trying to do ioremap against bus address
rather than the resource address and is failing to probe.

efifb driver is having difficulty locating the base address from BAR
address when

efifb: probing for efifb
efifb: cannot reserve video memory at 0x1e000000
efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
efifb: mode is 800x600x32, linelength=3200, pages=1
efifb: scrolling: redraw
efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0

Use the host bridge offset information to convert bus address to
resource address in the fixup.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/video/fbdev/efifb.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 46a4484..feef02b 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -428,6 +428,8 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 {
 	u64 base = screen_info.lfb_base;
 	u64 size = screen_info.lfb_size;
+	struct pci_host_bridge *bridge;
+	struct resource_entry *window;
 	int i;
 
 	if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
@@ -439,6 +441,27 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 	if (!base)
 		return;
 
+	bridge = pci_find_host_bridge(dev->bus);
+	if (!bridge)
+		return;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		phys_addr_t win_start;
+		phys_addr_t win_end;
+		size_t win_size;
+
+		if (resource_type(window->res) != IORESOURCE_MEM)
+			continue;
+
+		win_start = window->res->start - window->offset;
+		win_end = window->res->end - window->offset;
+		win_size = window->res->end - window->res->start + 1;
+		if (win_start <= base && win_end >= base + win_size - 1) {
+			base += window->offset;
+			break;
+		}
+	}
+
 	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
 		struct resource *res = &dev->resource[i];
 
-- 
2.7.4

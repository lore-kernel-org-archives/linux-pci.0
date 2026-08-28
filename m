Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6531E84B
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953648; cv=none; b=JZ9sTjn1C87Vul4wEM8vIS89bKnj6puqLKoqC+Qq4cfHPjt1pgTIe2ddMCI4DIFY79PELCwQczx7tocBkVH381Vx2hXNsNR5T/EBUObfFK6lxqqBUKQEi6C021CR7KvFzFTW4i3Q3YcSynKWdPgLBhhbolIeQMuqeCtAEXL1Gl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953648; c=relaxed/simple;
	bh=pvFAOoA0oBEdNhH8rJY40p/e4ujbhyQ0zwrqiD5XNek=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jgZK69yoMujXUg+/XPeU3enOO751f3dTKOgmkRByhJMIAYSZMQoSWIYZ4nCgbFSyWe5mETt59Qvn5moDoM/0QWFpNRuCzm55B8C2HdyAZrTNVjpcBUbgCXe2K2Z8DqdgUCnBR4ND0kASfvAyGhNyJoPhvKi/aEaKOwglrf1oHuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=t1Zcvhqn; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="t1Zcvhqn"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-857ff9fef54so18236577b3.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1787953645; x=1788558445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kfWOyLVK0JCKrI1kfo9Hy3MA2oWXEsu+uzUeglQMqwc=;
        b=t1ZcvhqnTIWEHkEYKTMqfehORmbCfaudRUX/XGxpt7ohO3lUYAqDT2iGMWUs4HUn8U
         lxVuQEdWFSx/EGE832pow6K/krpYWYXnWCE4G9gV8qys4fC4853THml1DPc6rFxuczLq
         xvxmySh+fq0HO5ixGl4I9/KKprBKEi7FhSn8NHpTePzNfvZ7o9SFxpoVF74plOrEMtef
         BhyUbtwj10wApt1SMgcKZ+PqZVeO4cHlwXm2O8FMqTgLo6ekbwduokrn+GITufW2UaLN
         ZUvZRpiyaBNvcM6XL4MXPUwJ3qFOmApRAO7NuX2Z5EfGWoCpddSM5FzqUVLOCdoyHxem
         5wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787953645; x=1788558445;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfWOyLVK0JCKrI1kfo9Hy3MA2oWXEsu+uzUeglQMqwc=;
        b=VEo0Mb+12yMl19vKFGtAiYcuj+jxPMF4c7+m7RTjaKSTM0bNUV/k9HS3Gn1ny/bNs+
         bw3LPT82DNJre12PxxrLwCaKiY6rTdEPA4gYnGdaU1XQInrpoPve1G07tCFrkMFS/Mgt
         YbLYlaVpLGp7RyxpeQOCxWeutFnftWv9ZhlDlwqOpMe9A875tlXD+4nNBe0JAY6iZTrG
         hOv/KbT/ISn59TI6eRmldfvIOQFi6DL02gYnI+uXexKVv4tfWRh9KWP+L6LDUl3nCB9G
         ooiXXmWdJ2ljj7UrEhj/ZltjxH5srJczHkyJ2zSvP0WSTvS9JxLHIt5PDJAXc9K8xYa/
         /YNA==
X-Forwarded-Encrypted: i=1; AKwUvBygDylJrrRboIKHw8knlmdeeNDA8q9FfpTQgNQ5EBz0z2dDMzqBgHZJ2MqcNdaBEJjdGLDvePYXmmI=@vger.kernel.org
X-Gm-Message-State: AFuF++knXf5ryHQeAZD017NSBZFtZhJChGrAn3PWZkWSM56cvmtlUBPa
	857YYiKpYRb5iWEEmulWLMlkdnoyAVo/oIzSIxUBrgy74nfip0m/Ta9zBEk2F+tZo02wnW1y1Er
	4FPJAEZM79g==
X-Gm-Gg: AYBFou1UL+sVZ07sD8Fl9NgPrYJInDK0Wk5+MZH3IWORmKiXfK2uz7VilxE59fZ1WjC
	GruQoX3pkC66r42ahEJ/PQDMe6/iLc53nnN5gCLGTE+Xvbt9p8S2eva3Ksmr0WOw/Y0PfxLj331
	0cwVRKeGzwOjujSHFUKovRygVL9Q9U+fzMKiDArUze88N/mk34jD+HeNa8YXywoPGRs1pJ6e+rH
	Qso4wqcuKYWbwBkgM/pSOtJF03kW+ErFxSG6XDLyzhOzPLMMa4gd1oxsUEa5cHj5CxScRm22GXN
	nwrAgZxUMqGpdS5qxrmd2UuudphGVwe8+TrOc+ddh4FkwYuDYWo9LRlDys0FeOHBAPe4HJEiDfp
	KJd9hSeHkLWddnXkGrK3OhslY12yz3ehwcbUSXHSA2aggnXWOntsd3PFQZI6IDXCvqxcSeJG31K
	x5V3KfiK5x9wPh5AVJpsxCzdO0t/OK7wqVgQ0Aug+4agBaHyvJ+mPTGhemD7/ECtXlFKcvZCu+d
	9If8nGDdQcEQ+Oq3Yxnq4OU8JNXbhVsKGi20QsItniy6CqJNKdKuYk=
X-Received: by 2002:a05:690c:d83:b0:7ba:f690:70be with SMTP id 00721157ae682-85d68a8e9dfmr39842137b3.7.1787953645334;
        Fri, 28 Aug 2026 14:47:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:1782:ba0:3c34:153:94fd:b73a? ([2600:1700:1782:ba0:3c34:153:94fd:b73a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e677606aesm12689867b3.45.2026.08.28.14.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 14:47:24 -0700 (PDT)
Message-ID: <5524e9e5-ecac-41c8-b11a-60a85f82fa17@jqluv.com>
Date: Fri, 28 Aug 2026 14:47:23 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: alexander.deucher@amd.com, ilpo.jarvinen@linux.intel.com,
 amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, nra3088@gmail.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Geramy Loveless <gloveless@jqluv.com>
Subject: [PATCH v2] PCI: Reserve prefetchable window headroom for Resizable
 BARs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Firmware typically sizes prefetchable bridge windows for the boot-time
BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is then
no room for a driver to grow a Resizable BAR afterwards: every window
from the leaf up to the root is sized for the small BAR, so
pci_resize_resource() fails with -ENOSPC. 

Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharing a 
bridge's single prefetchable window with a much larger one (e.g., a 32 GiB 
VRAM BAR) pushes the required window size past the large BAR's alignment. 
Because bridge windows round up to a power of two, this forces a massive 
alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window, 
wasting ~32 GiB per GPU).

This patch solves both issues to enable ReBAR on cascaded switch fabrics:

1. Reserve Headroom: 
Reserve prefetchable window headroom for the maximum size of each 
downstream Resizable BAR during the bridge sizing pass. The device BAR 
and hardware ReBAR are left at their boot size to prevent tearing down 
firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.

2. Pack Oversized Windows (BAR Demotion): 
The PCI-to-PCI Bridge spec (r1.2, sec 3.2.5) permits a prefetchable BAR 
to be assigned from the non-prefetchable window. By clearing the PREFETCH 
flag on small control BARs during enumeration, they are placed below 4 GiB. 
The prefetchable window is then cleanly sized to the large BAR alone.

Why this is safe for 32-bit (< 4G) MMIO space:
To prevent exhausting legacy < 4G space, demotion is strictly bounded. It 
only triggers beside a massive prefetchable BAR (>= 64 MiB), and the demoted 
BAR is strictly capped at 16 MiB (PCI_BAR_PACK_CAP). Even on an 8x GPU 
system, this consumes at most 128 MiB of < 4G space. 

Fallback / Alignment logic:
If the 32-bit space is exhausted, small BARs remain in the prefetchable 
window. The alignment logic gracefully handles this by rounding the bridge 
window up to the next power of two (e.g., growing to 64 GiB to fit a 32 GiB 
BAR + BAR2) to maintain PCIe compatibility, ensuring sibling GPUs land in 
properly aligned slots.

Reserving is safe by default: __assign_resources_sorted() satisfies all
required resources first. Use pci=no_rebar_reserve and pci=no_bar_demote 
to restore previous behaviours.

Testing Context:
- ASUS K14PG-D24
- 2x EPYC 9354
- 8x Radeon AI PRO R9700 (Navi 48, 1002:7551)
- Broadcom PEX890xx switches
- Kernel base: 45c13f3f9e3b (tested with SEV-SNP passthrough=1)

Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
---
 .../admin-guide/kernel-parameters.txt         |   9 ++
 drivers/pci/pci.c                             |  15 +++
 drivers/pci/pci.h                             |   2 +
 drivers/pci/quirks.c                          |  54 ++++++++
 drivers/pci/setup-bus.c                       | 118 ++++++++++++++++++
 5 files changed, 198 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 37006fc3eac3..7360407dd4b8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5246,6 +5246,15 @@ Kernel parameters
 		hpbussize=nn	The minimum amount of additional bus numbers
 				reserved for buses below a hotplug bridge.
 				Default is 1.
+		no_bar_demote	Do not demote small prefetchable BARs below 4 GiB to pack oversized prefetchable bridge windows.
+		no_rebar_reserve	Do not reserve prefetchable bridge-window
+				space for the maximum size of downstream Resizable
+				BARs. By default such space is reserved so a driver
+				can grow a BAR later (e.g. GPU VRAM BAR) even behind
+				fixed PCIe switch fabrics that firmware sized for the
+				boot-time BAR; the device BAR is left at its boot size
+				for the driver to resize and only bridge windows are
+				enlarged. Use this to restore the old behaviour.
 		realloc=	Enable/disable reallocating PCI bridge resources
 				if allocations done by BIOS are too small to
 				accommodate resources required by all child
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..0bb4ad570171 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -120,6 +120,17 @@ unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
 
+/*
+ * Prefetchable bridge-window headroom is reserved for the maximum size of
+ * downstream Resizable BARs by default, so a driver can grow one later
+ * (e.g. amdgpu VRAM BAR) even behind fixed PCIe switch fabrics.
+ * pci=no_rebar_reserve disables this.
+ */
+bool pci_rebar_no_reserve;
+
+/* pci=no_bar_demote disables demoting small prefetchable BARs below 4 GiB. */
+bool pci_bar_demote_disabled;
+
 
 /* PCIe MPS/MRRS strategy; can be overridden by kernel command-line param */
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
@@ -6840,6 +6851,10 @@ static int __init pci_setup(char *str)
 					simple_strtoul(str + 10, &str, 0);
 				if (pci_hotplug_bus_size > 0xff)
 					pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
+			} else if (!strncmp(str, "no_rebar_reserve", 16)) {
+				pci_rebar_no_reserve = true;
+			} else if (!strncmp(str, "no_bar_demote", 13)) {
+				pci_bar_demote_disabled = true;
 			} else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
 				pcie_bus_config = PCIE_BUS_TUNE_OFF;
 			} else if (!strncmp(str, "pcie_bus_safe", 13)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..0f21972b674a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -409,6 +409,8 @@ extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mmio_size;
 extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
+extern bool pci_rebar_no_reserve;
+extern bool pci_bar_demote_disabled;
 
 static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
 {
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..57a5926a273c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6423,3 +6423,57 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * Pack oversized prefetchable windows.
+ *
+ * A small prefetchable BAR (e.g. a 2 MiB doorbell) sharing a bridge's single
+ * prefetchable window with a much larger one (e.g. a 32 GiB framebuffer) pushes
+ * the window past the large BAR's alignment, so siblings behind a switch waste
+ * an alignment each.  A prefetchable BAR may legally be assigned from the
+ * non-prefetchable window (PCI-to-PCI Bridge spec r1.2 sec 3.2.5); clear PREFETCH
+ * on such small BARs so they are placed below 4 GiB and the prefetchable window
+ * is sized to the large BAR alone.  Run at enumeration -- before resources are
+ * sized -- so the reservation and assignment see the final layout.  Only small
+ * "control" BARs beside a large one are touched, bounding the extra below-4G use.
+ * pci=no_bar_demote disables this.
+ */
+#define PCI_BAR_PACK_MIN	SZ_64M	/* device must have a pref BAR at least this big */
+#define PCI_BAR_PACK_CAP	SZ_16M	/* only demote small pref BARs up to this size */
+
+static void quirk_pci_pack_prefetch(struct pci_dev *dev)
+{
+	resource_size_t max_align = 0;
+	struct resource *r;
+	int i;
+
+	if (pci_bar_demote_disabled)
+		return;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		r = pci_resource_n(dev, i);
+		if ((r->flags & (IORESOURCE_MEM | IORESOURCE_PREFETCH)) ==
+		    (IORESOURCE_MEM | IORESOURCE_PREFETCH))
+			max_align = max(max_align, pci_resource_alignment(dev, r));
+	}
+	if (max_align < PCI_BAR_PACK_MIN)
+		return;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		r = pci_resource_n(dev, i);
+		if ((r->flags & (IORESOURCE_MEM | IORESOURCE_PREFETCH)) !=
+		    (IORESOURCE_MEM | IORESOURCE_PREFETCH))
+			continue;
+		if (r->flags & IORESOURCE_PCI_FIXED)
+			continue;
+		if (pci_resource_alignment(dev, r) >= max_align)
+			continue;		/* an alignment-setting BAR, keep it */
+		if (resource_size(r) > PCI_BAR_PACK_CAP)
+			continue;		/* not a small control BAR */
+
+		r->flags &= ~IORESOURCE_PREFETCH;
+		pci_info(dev, "%pR: assigned from the non-prefetchable window to pack the prefetchable window\n",
+			 r);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_pci_pack_prefetch);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e8c94aa1d3c1..aa02b8454269 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -19,6 +19,7 @@
 #include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -1258,6 +1259,53 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
 	return true;
 }
 
+/*
+ * pci_rebar_reserve_size - prefetchable window headroom to reserve for a BAR
+ *
+ * Reserve enough prefetchable window space to later grow @resno of @dev to
+ * its maximum Resizable BAR size. This is done for every ReBAR-capable device
+ * by default (disable with pci=no_rebar_reserve). Only the optional (add_size)
+ * part of the enclosing window is inflated here; the device BAR resource and
+ * the hardware ReBAR are left at their boot size, so the driver still performs
+ * the actual resize into the reserved window. Reserving the window up front
+ * avoids -ENOSPC in pci_resize_resource() on fixed switch fabrics, where a
+ * window shared with a sibling's still-assigned BAR cannot be released and
+ * regrown at resize time.
+ *
+ * The reservation is strictly optional: __assign_resources_sorted() satisfies
+ * all required resources first and only then places add_size on leftover
+ * space, so reserving by default cannot make a required BAR or window fail.
+ *
+ * Return the extra bytes to reserve and raise *add_align to the BAR's
+ * alignment so the reserved space can actually hold the grown BAR.
+ */
+static resource_size_t pci_rebar_reserve_size(struct pci_dev *dev, int resno,
+					      resource_size_t *add_align)
+{
+	struct resource *res = pci_resource_n(dev, resno);
+	resource_size_t max_size, cur_size;
+	int max;
+
+	if (pci_rebar_no_reserve || resno >= PCI_STD_NUM_BARS)
+		return 0;
+
+	if ((res->flags & (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH)) !=
+	    (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH))
+		return 0;
+
+	max = pci_rebar_get_max_size(dev, resno);
+	if (max < 0)
+		return 0;
+
+	max_size = pci_rebar_size_to_bytes(max);
+	cur_size = resource_size(res);
+	if (max_size <= cur_size)
+		return 0;
+
+	*add_align = max(*add_align, max_size);
+	return max_size - cur_size;
+}
+
 /**
  * pbus_size_mem() - Size the memory window of a given bus
  *
@@ -1285,6 +1333,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	int order, max_order;
 	resource_size_t children_add_size = 0;
 	resource_size_t add_align = 0;
+	resource_size_t rebar_align = 0;
 
 	if (!b_res)
 		return;
@@ -1343,15 +1392,29 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
+
+			size += pci_rebar_reserve_size(dev, i, &rebar_align);
 		}
 	}
 
 	win_align = pci_min_window_alignment(bus, b_res->flags);
 	min_align = calculate_head_align(aligns, max_order);
 	min_align = max(min_align, win_align);
+	min_align = max(min_align, rebar_align);
 	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
 				  0, win_align);
 
+	/*
+	 * A window that reserves ReBAR headroom is larger than its own
+	 * alignment (e.g. 32 GiB BAR + doorbell => 33 GiB > 32 GiB). The
+	 * parent only reserves alignment padding for a child window when
+	 * its size <= its alignment, so round such a window's alignment up
+	 * to a power of two >= its size; sibling 32 GiB BARs behind one
+	 * switch then each land in a properly aligned slot.
+	 */
+	if (rebar_align && size0)
+		min_align = max(min_align, roundup_pow_of_two(size0));
+
 	if (size0) {
 		resource_set_range(b_res, min_align, size0);
 		b_res->flags &= ~IORESOURCE_DISABLED;
@@ -2179,6 +2242,52 @@ static void pci_prepare_next_assign_round(struct list_head *fail_head,
  * Second and later try will clear small leaf bridge res.
  * Will stop till to the max depth if can not find good one.
  */
+/*
+ * Release the 64-bit prefetchable BARs of resizable-BAR display devices so the
+ * windows enclosing them empty out and can be re-sized. The BAR *size* is left
+ * untouched (only released and re-placed), so the hardware ReBAR is never
+ * programmed here - the driver still owns the actual resize.
+ */
+static int pci_release_rebar_bars_cb(struct pci_dev *dev, void *data)
+{
+	struct resource *r;
+	unsigned int i;
+
+	if ((dev->class >> 16) != PCI_BASE_CLASS_DISPLAY)
+		return 0;
+	if (pci_rebar_get_max_size(dev, 0) <= pci_rebar_get_current_size(dev, 0))
+		return 0;
+	pci_dev_for_each_resource(dev, r, i) {
+		if (i >= PCI_BRIDGE_RESOURCES)
+			break;
+		if (r->parent && (r->flags & IORESOURCE_MEM_64) &&
+		    (r->flags & IORESOURCE_PREFETCH))
+			pci_release_resource(dev, i);
+	}
+	return 0;
+}
+
+/*
+ * Release the now-empty prefetchable bridge windows bottom-up so the sizing
+ * pass re-sizes them (with pci_rebar_pref_reserve() reservation) to fit the
+ * BARs a driver will later grow.
+ */
+static void pci_release_rebar_windows(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	struct resource *w;
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->subordinate)
+			pci_release_rebar_windows(dev->subordinate);
+
+	if (!bus->self)
+		return;
+	w = &bus->self->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
+	if (w->parent && (w->flags & IORESOURCE_MEM_64) && !w->child)
+		pci_release_resource(bus->self, PCI_BRIDGE_PREF_MEM_WINDOW);
+}
+
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 {
 	LIST_HEAD(realloc_head);
@@ -2190,6 +2299,15 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	int pci_try_num = 1;
 	enum enable_type enable_local;
 
+	/*
+	 * Release resizable device BARs and their prefetchable windows so the
+	 * sizing pass re-sizes those windows large enough (pci_rebar_pref_reserve)
+	 * for the BARs a driver will later grow. Only released and re-placed - the
+	 * BAR size is left untouched, so the hardware ReBAR is never programmed.
+	 */
+	pci_walk_bus(bus, pci_release_rebar_bars_cb, NULL);
+	pci_release_rebar_windows(bus);
+
 	/* Don't realloc if asked to do so */
 	enable_local = pci_realloc_detect(bus, pci_realloc_enable);
 	if (pci_realloc_enabled(enable_local)) {

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.53.0




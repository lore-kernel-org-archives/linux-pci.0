Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB8B48382E
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775744; cv=none; b=NPpIY7Kai2bvhRBuBMwKqU0jOuC/dJ+3Bzy/Hmk+sX+QSAHOMpvGsGa6/MExxTxa1s0BwwTe1uYwO3D3R95Pn2hGWQdSIseyAe50R+w0cmj9/HIAH7/5hMNs9+ZIr9ggs8pmiXVTsccgoyz1VM/ggioQBhilZRVykR4gvxRuZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775744; c=relaxed/simple;
	bh=/mYnOm9okVJC2BL0hOkgDtE8gUTwj0fQEdVHf0yekQo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=B5w/lRijZEhWJE4YHN1NFTHAhW7beBzw5N30dydrCAjA1Tu+2nvcAL3TdydnTB2mjN0k+udlnmz7NV5AYGt/p1NbP6Z+aZ2VD5OpM8MisNiMhTkWXNYi9CC4Kp05yWpzCfSwRwTIZKSF6ilywjJylTDcVMbF9KovpxvwVITq5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=Q9IDD0N5; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="Q9IDD0N5"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66ce5312ca6so2391484d50.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1787775741; x=1788380541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V8WTwpev7yC80C8GWV7MXU6aHOjLqfN0T/sKWekmcdY=;
        b=Q9IDD0N59j8V03nUM7HwXVvt/O4Ma3J3rZ+QB9DfS4JoEVcdIS3HPeIiMtNWNhRbhR
         Cufnm6t0MG54TEuFiWeheyLsjEj/14Loc4JakBkud7u/xTcDpASWGFxTCp7Ci7pe7yAw
         DiU5sCH/dS2RvygvjGrY0+I0orx05Oo2l5Gr47DmLIdOAL/+40lbLFuNCi1OItqoph1Z
         M2+jMElL6BBy9k9BK5qgNk3NmprdYZFvtqSH5YNE8gBo0GybT/h0i30mGKNTDIV0qiWk
         11nxv6QnzLOfXbP+BibLSk4UJ9pskC6YALMwOPqt1fqIq7xHJPoYfsFvLk+LsZ510dkO
         tH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775741; x=1788380541;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V8WTwpev7yC80C8GWV7MXU6aHOjLqfN0T/sKWekmcdY=;
        b=oTcZMsOQLvB0OMxAeh6fbcVcGsBNmApBuWkQpXYOg0c0IThK4O5LeUajQmPjbJAnmV
         rS8axwB7sSmb84/iWiMqCWVr7gKh3k73boz0vrqPPy3FdXaDjUVO8xBCLmg5TJJstbtV
         ToCWdxkURCrmie8kMQq4kjk+EXgFomfoJS+TkVwgYOf+rOJKhB99aYsfc7Id9Rxasr1J
         sbUvMLup4+9xG9w2kPKCd20sKJkfDQzquVxuIeATht4p0zDrU8G1QVrWAMEMKJmlx6ID
         dPrANeB3wHkJR3Nbu2Q8Ngx7XIlsmNEMpoQ7TwToDN3D4fs8DWViByVq6hyWtBqHz5nx
         KNQQ==
X-Gm-Message-State: AFuF++kXrDij3DRJcN92mz+fqOo01WBUFlqsR6wWHvlTAAPIuIbVFpSD
	9AgmzIAOsi2bX9jsIbUmVZhp5uGe008EDHFhhaHI9SlAARJ2Q/B9hISZWC/Ycq++W/8uvUlISX/
	Ek5VQJ8tGlw==
X-Gm-Gg: AR+sD12QR/wMRsi6HD8yNQc5J5E9tOerk9dMCM8F7BJ/rsiEGOdSp/Rfxmuy/2B3EkL
	T1Jk55bL2p2CXEHuDLZKey7m7o12NE2ALe3LW+/Kkh1OQ/GOUGbZ37doFzojyH23bvLV8It4wnq
	3AFo+zV6huR8FRx2FYw8KVAmI+ekm2GO33frQYCnjqNAMsiFdl0VotB7FqcKq29chGf+ezJeCsi
	w4Q7s9LsXKgOfEjbN70CtmWcjvNYN2Cnl0sO6tWgsa0tj/HuEegijZuA4EwbyryS5/VAtPyHMuO
	gM+TCbp+Exgh8uXoQZHQn/X60iCZZgfxLOmQRg+a9fIQ45bNkWVGy3jdh/4Jskb16k2n3i5fqrA
	NIySvzwjgv4RlzuMP6geiDufcYllojoD3Z5RbagmWAc9V1nZvB8wHvxkRb8sVJEkks/sgaUoAqp
	m2EQUfpcreOu+ReYlTOGvvPYdY85gX7QLjJLBuE/LtrRfd7MdbWTt3jZDkAuYCwJb9qMfIKOBbV
	7qt0Hr6nNQ6QR704SZ9oO/LOZ0tokw/HvajnWTG6WGu/B2Cnrh/dvTrjg==
X-Received: by 2002:a05:690e:134f:b0:66d:930:7203 with SMTP id 956f58d0204a3-66d8051724bmr1462997d50.38.1787775740884;
        Wed, 26 Aug 2026 13:22:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:1782:ba0:b856:d202:2fb0:b20c? ([2600:1700:1782:ba0:b856:d202:2fb0:b20c])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d245d9230sm2025752d50.9.2026.08.26.13.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 13:22:20 -0700 (PDT)
Message-ID: <a2292dfb-2ee5-4988-ac67-c75dd3e97a4c@jqluv.com>
Date: Wed, 26 Aug 2026 13:22:18 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alexander.deucher@amd.com,
 ilpo.jarvinen@linux.intel.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, nra3088@gmail.com,
 gloveless@jqluv.com
From: Geramy Loveless <gloveless@jqluv.com>
Subject: How to correctly reserve prefetchable bridge windows for large,
 resizable BARs behind PCIe switches (8x GPU, PEX890xx) - seeking guidance on
 upstreamable approach.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

We have an 8-GPU host where each GPU wants a 32 GiB resizable BAR, but 
the GPUs sit behind a multi-level Broadcom PEX890xx PCIe switch fabric 
whose prefetchable bridge windows are sized by firmware for the default 
256 MiB BAR. The kernel/driver never grows those windows, so every BAR 
stays a 256 MiB and the cards run in small-BAR mode.

We have an out-of-tree patch that makes it work (full patch inline below 
as PATCH 1), but we're not confident it's the right shape for upstream, 
and we've hit a nasty interaction with the GPU firmware (PSP) that 
suggests we're doing it at the wrong layer. We'd really appreciate 
guidance on the correct approach before we try to submit anything.

Background / history
--------------------
We first developed this reservation logic for Thunderbolt 5 / 
USB4-attached GPUs, where the tunneled PCIe hierarchy has the identical 
problem: firmware sizes the bridge windows for the boot-time BAR, and 
there's no room for the driver to grow a resizable BAR afterward. We 
found the exact same problem applies to GPUs behind on-board PCIe 
switches, so we adapted the same idea here.

Software versions (both inline patches are "git apply --check" clean on
these exact bases)
----------------------------------------------------------------------
- Kernel base:   torvalds 45c13f3f9 (Makefile VERSION 7.2.0;
                  "Merge tag 'hwlock-v7.3' ...")
- amdgpu:        amd-staging-drm-next @ 75a5e1b6b
                  ("drm/amdkfd: guard against NULL restore_mqd in CRIU queue
                   restore")
- PATCH 1 (inline below): our out-of-tree PCI window reservation.
- PATCH 2 (inline below): Mario Limonciello, commit 63b2896378d,
                  "drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs 
only",
                  Fixes: ea8ac194077d.

Note on the two amdgpu issues our PCI patch exposes: pre-sizing the fb 
BAR resource causes the *hardware* BAR to be large by the time amdgpu 
binds, which triggers two separate problems on the R9700 - (1) the early 
BAR0-aperture read added in ea8ac194077d returns ~0 for the IP-discovery 
table (PATCH 2 restricts that read to SR-IOV VFs and is what gets us pas
discovery today), and (2) the PSP teardown described below. Both 
disappear if the child BAR is left at its boot size and the driver 
performs the resize - which is the core of our question.

Hardware
--------
- Chassis/board:  ASUSTeK K14PG-D24 Series, BIOS 2001 (2024-08-02)
- CPU:            2x AMD EPYC 9354 (Genoa, 32C/socket, 2 NUMA nodes)
- Root complex:   AMD Genoa/Bergamo Root Complex [1022:14a4]
- PCIe switches:  Broadcom/LSI PEX890xx PCIe Gen5 Switch [1000:c030] 
(rev b0),
                   cascaded (upstream port -> multiple downstream ports ->
                   further PEX890xx stages -> one GPU per leaf)
- GPUs:           8x AMD Navi 48 [Radeon AI PRO R9700] [1002:7551] rev c0,
                   subsystem ASRock [.. :5413], 32 GiB VRAM each 
(gfx1201/RDNA4)
- GPU BDFs:       07:00.0 0a:00.0 68:00.0 6d:00.0 87:00.0 8a:00.0 
e8:00.0 ed:00.0
- Boot cmdline:   iommu.passthrough=0 pci=realloc (+ disable_acs_redir 
on the
                   eight switch downstream ports)

Topology (abridged; one leg shown, all eight are symmetric):

   [EPYC RC] -> PEX890xx up -> PEX890xx dn(62:00.0) -> PEX890xx(63:00.0) 
-> GPU(68:00.0)

Every prefetchable window in that chain is firmware-sized at 258 MiB
(256 MiB fb BAR + 2 MiB doorbell BAR), e.g.:

   62:00.0  Prefetchable memory behind bridge: ...  [size=258M]
   63:00.0  Prefetchable memory behind bridge: ...  [size=258M]

To resize a single GPU BAR to 32 GiB, every bridge window from the leaf 
up to the root must be enlarged, and windows feeding two GPUs need >= 64 
GiB in my specific use case but this needs to be generally acceptable 
for all use cases of course.

What we observe without any patch
---------------------------------
amdgpu_device_resize_fb_bar() runs and calls pci_resize_resource(pdev, 
0, <32G>), which returns -ENOSPC ("Not enough PCI address space for a 
large BAR") because the parent switch windows have no room, and nothing 
grows them. All eight BARs stay at 256 MiB.

(This is with current mainline/amd-staging; the recent removal of the 
driver-side re-assignment in db92e3fef53e2 does not change this outcome 
on our topology - we tested a revert and still got 256 MiB, because 
re-assigning unassigned resources does not grow already-assigned switch 
windows.)

Our current out-of-tree patch (PATCH 1, inline below)
-----------------------------------------------------
At pci_assign_unassigned_root_bus_resources() time we (a) bump each 
display device's fb BAR resource to its max ReBAR size, (b) release the 
prefetchable BARs/windows so the assignment pass re-sizes the whole 
prefetchable hierarchy large enough to hold the enlarged BARs, plus a 
small setup-res.c tweak so multiple max-size BARs can share one window 
with correct alignment. With this, all eight windows get sized for 32 
GiB and the resize succeeds.

The problem with our approach
-------------------------------------------------------
Bumping the fb BAR *resource* to max causes the assignment pass to 
program the hardware ReBAR to 32 GiB at enumeration time (before amdgpu 
binds). On these R9700s that early hardware BAR resize tears down the 
firmware-loaded PSP "sign of life" (sOS), and amdgpu's later PSP 
bring-up then fails to reload it:

     amdgpu ...: PSP load kdb failed!
     amdgpu ...: psp reg (0x16080) wait timed out ... read: 30000 exp: 
80000000
     amdgpu ...: hw_init of IP block <psp> failed -22

If instead the hardware BAR is left at its BIOS size and amdgpu performs 
the resize itself (which is what happens when firmware pre-enabled a 
large BAR), the PSP stays alive and the GPU comes up fine. So what we 
actually want is to reserve/size the prefetchable *windows* for 32 GiB 
while leaving the child BAR at its boot size, and let the driver do the 
hardware resize into the pre-sized window. Our current patch conflates 
the two.

Questions
---------
1. Is there an existing/preferred mechanism for reserving prefetchable 
bridge-window space for large resizable BARs across a switch hierarchy 
that we should be using (something analogous to the hotplug 
hpmemprefsize reservation, but for fixed switch fabrics)? We'd rather 
use it than carry this.

2. If a new mechanism is needed, where should it live? Our instinct is 
that the window sizing wants to happen in pci_bus_size_bridges()/the 
realloc (add_size) path so the child BAR resource is never grown - i.e. 
reserve the window, not the BAR. Is that the right direction, and is 
there a sanctioned way to request "N bytes of extra prefetchable window 
on this bridge" during the sizing pass?

3. Given the PSP interaction, is the expectation that the *driver* 
always owns the hardware BAR resize (so core should only ever arrange 
windows, never program the device ReBAR)? If so, is the resource-size 
bump we do simply the wrong tool?

4. We're happy to write this properly and carry the testing - we have 
the 8x R9700 / PEX890xx box and can iterate quickly. We can also share 
the full lspci -tvvv, dmesg, and the Thunderbolt/USB4 variant of the 
patch if useful.

Thanks a lot for any pointers,
Geramy Loveless

The two patches follow inline below.

==============================================================================
PATCH 1/2 - PCI: reserve prefetchable bridge windows for resizable BARs
             (our out-of-tree patch; git apply --check clean on 45c13f3f9)
==============================================================================
From: Geramy Loveless <gloveless@jqluv.com>
Date: Wed, 26 Aug 2026 00:00:00 +0000
Subject: [PATCH] PCI: reserve prefetchable bridge windows for 
multi-child resizable BARs

Out-of-tree patch we carry to make 8x resizable-BAR GPUs behind a 
cascaded PCIe switch fabric usable. Firmware sizes every prefetchable 
bridge window for the boot-time (256 MiB) BAR, so a driver's later 
resize to 32 GiB fails with -ENOSPC because no window in the chain has room.

Before sizing the bridge windows, bump each display device's fb BAR 
resource to its max ReBAR size and release the prefetchable BARs/windows 
so the assignment pass re-sizes the prefetchable hierarchy large enough. 
A small pci_align_resource() tweak lets several max-size BARs share one 
window.

NOTE (seeking review): bumping the BAR *resource* also programs the 
hardware ReBAR at enumeration time, which on AMD R9700 tears down 
firmware PSP state and breaks GPU init. The correct shape is likely to 
size the *window* only and leave the child BAR at boot size for the 
driver to resize.

Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
---
  drivers/pci/rebar.c     |  1 +
  drivers/pci/setup-bus.c | 62 
+++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/pci/setup-res.c |  7 ++++++
  include/linux/pci.h     |  1 +
  4 files changed, 71 insertions(+)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 5bbdc9470..3b621fa3c 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -190,6 +190,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, 
int bar)
  	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  	return FIELD_GET(PCI_REBAR_CTRL_BAR_SIZE, ctrl);
  }
+EXPORT_SYMBOL_GPL(pci_rebar_get_current_size);

  /**
   * pci_rebar_set_size - set a new size for a Resizable BAR
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e8c94aa1d..1bb018e3a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2179,6 +2179,59 @@ static void pci_prepare_next_assign_round(struct 
list_head *fail_head,
   * Second and later try will clear small leaf bridge res.
   * Will stop till to the max depth if can not find good one.
   */
+static int pci_reserve_rebar_cb(struct pci_dev *dev, void *data)
+{
+	struct resource *r;
+	unsigned int i;
+	int max, cur;
+
+	if ((dev->class >> 16) != PCI_BASE_CLASS_DISPLAY)
+		return 0;
+	max = pci_rebar_get_max_size(dev, 0);
+	if (max < 0)
+		return 0;
+	cur = pci_rebar_get_current_size(dev, 0);
+	if (cur < 0 || cur >= max)
+		return 0;
+	pci_resize_resource_set_size(dev, 0, max);
+
+	/*
+	 * Release every prefetchable BAR so the 64-bit prefetchable window
+	 * enclosing them empties and can be re-sized for the enlarged BAR0.
+	 * The hardware BAR is left untouched for the driver to resize.
+	 */
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
+ * Release the prefetchable bridge windows emptied by 
pci_reserve_rebar_cb() so
+ * the assignment pass re-sizes them to fit the reserved BARs. Recurse 
first so
+ * windows are released bottom-up; the !child test skips windows that 
still hold
+ * other devices' resources.
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
@@ -2190,6 +2243,15 @@ void 
pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
  	int pci_try_num = 1;
  	enum enable_type enable_local;

+	/*
+	 * Reserve window space for resizable device BARs at their maximum
+	 * size before sizing the bridge windows, so the windows fit the BARs
+	 * a driver will later grow. Only the resource size is set here; the
+	 * hardware BAR is left untouched for the driver to resize.
+	 */
+	pci_walk_bus(bus, pci_reserve_rebar_cb, NULL);
+	pci_release_rebar_windows(bus);
+
  	/* Don't realloc if asked to do so */
  	enable_local = pci_realloc_detect(bus, pci_realloc_enable);
  	if (pci_realloc_enabled(enable_local)) {
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 376f09630..db12092e1 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -280,6 +280,13 @@ resource_size_t pci_align_resource(struct pci_dev *dev,
  		return res->start;

  	remainder = size - ALIGN_DOWN(size, align);
+	/*
+	 * A window holding several align-sized resources has one tail per
+	 * resource, but only the lowest can tuck below the first aligned
+	 * boundary; the rest sit above it. Relocate a single tail's worth.
+	 */
+	if (ALIGN_DOWN(size, align) > align)
+		remainder /= ALIGN_DOWN(size, align) / align;
  	/* Don't mess with size that doesn't align with window size 
granularity */
  	if (!IS_ALIGNED(remainder, pci_min_window_alignment(dev->bus, 
res->flags)))
  		return res->start;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107..e15d78a31 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1500,6 +1500,7 @@ resource_size_t pci_rebar_size_to_bytes(int size);
  u64 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
  bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size);
  int pci_rebar_get_max_size(struct pci_dev *pdev, int bar);
+int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
  int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
  				     int exclude_bars);


==============================================================================
PATCH 2/2 - drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only
             (Mario Limonciello, commit 63b2896378d; verified applies to 
75a5e1b6b)
==============================================================================

 From 63b2896378d284e2043b44b81a0c044aef0e95fe Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 26 Aug 2026 12:02:53 -0500
Subject: [PATCH] drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only

The BAR0 fallback read path in amdgpu_device_read_fb_via_bar0() was
introduced as a workaround for SR-IOV virtual functions where the VRAM
aperture (adev->mman.aper_base_kaddr) is not available during early init.

However, the function currently allows any device (VF, PF, or bare metal)
to use this fallback path, which is unnecessary overhead for non-VF
configurations.

Since amdgpu_virt_init() runs during early initialization and sets
adev->virt.caps before any runtime framebuffer access occurs, we can
safely check amdgpu_sriov_vf() to restrict this workaround to only
SR-IOV VFs where it's actually needed.

Fixes: ea8ac194077d ("drm/amdgpu: reduce early full GPU access during 
SR-IOV init")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
  1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -774,6 +774,10 @@
  	u64 end;

  	if (!buf || !size)
+		return -EINVAL;
+
+	/* BAR0 workaround only needed for SR-IOV VFs */
+	if (!amdgpu_sriov_vf(adev))
  		return -EINVAL;

  	flags = pci_resource_flags(adev->pdev, 0);
-- 
2.43.0


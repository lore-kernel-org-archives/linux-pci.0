Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80B361DCB
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.183.30.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970879; cv=none; b=iDz4jCS4msNqfFRl5QEQU1O9jVaBb92+zBHp3kIFKrLINv54YE2P/bupIIgWW1+23S7Y7u4s+RT5Bj+KIdAbCBqII5bLZFlCMpoTTdsyeP5cGN2Oq3E7grIOLZy7aPbh/8WWkt8LnlrlxJ4yN4wNR7ahbCQDzO+/Mm0LEXKs9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970879; c=relaxed/simple;
	bh=JQTOYv5NYU7Flv/P6OLy9R9hGbe2CLPr3I902KcC7Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcLsqC0bk7yi3yuIvYfXBdkWGMHTmUWdbXlWKXcTgIpSAFExYifA8o+Ts7HsX5YIjXG66HOZ3f1CdWD6Yqo3Odt9DAIgfEXcYwLSBqX1aRiUIXhHoMvNeTxykF97vZhWH1Bwgwu8YxvYc5fQIawaJ9fGaRMR/fe5KuvB8C5pxS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=NvS2oz4g; arc=none smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="NvS2oz4g"
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692JR5OM1287666;
	Fri, 2 Oct 2026 19:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=p1; bh=s2Ll5dPYDtlVoPq2tW
	OW5wrKj5y61TaFmI9Z1wTykBY=; b=NvS2oz4gVX8NythBDJdOU9juq8544QUkov
	+2Ot9EgGlpKfD6hepVgo34tw2qg28AyAhg9zWSY03H/1ORJHGf3zpy1jDE9JyFS3
	e8/pK+5Jdvmyigwa80iAMLJNKh24qT4pKKx/HQwB7xTOOA1/c3C332AEkhDHwvKr
	RfzuyyreecHsWaWPh5AxYu75idP1AIi2r7IqIfqiQmdvOXC8ivVzXbfrzZXBaVCl
	KPAzbXKbFXNKwUXv5Ap8xf+r7LdTp3pPjcHajVjqvbNxy4KAskSKAkcm7ETcQUAT
	rF7g0YhEdxxKHHsEfRFKksefeS/FJi+VzouN8gg+WCpyFU2n4MzA==
Received: from usculxsnt01v.am.sony.com (usculxsnt01v.am.sony.com [160.33.194.232])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4gx6epywed-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 02 Oct 2026 19:31:17 +0000 (GMT)
Received: from pps.filterd (USCULXSNT01v.am.sony.com [127.0.0.1])
	by USCULXSNT01v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 692JN4RE3823563;
	Fri, 2 Oct 2026 19:31:16 GMT
Received: from usculxsnt13v.am.sony.com ([146.215.230.187])
	by USCULXSNT01v.am.sony.com (PPS) with ESMTPS id 4gx5ae9a89-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 19:31:16 +0000 (GMT)
Received: from pps.filterd (USCULXSNT13v.am.sony.com [127.0.0.1])
	by USCULXSNT13v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 692J942r1761800;
	Fri, 2 Oct 2026 19:31:16 GMT
Received: from us842f57abef3e.eu.sony.com ([10.10.10.214])
	by USCULXSNT13v.am.sony.com (PPS) with ESMTPS id 4gx5afe81c-2
	(version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256 verify=NOT);
	Fri, 02 Oct 2026 19:31:16 +0000 (GMT)
From: Maciej Grochowski <maciej.grochowski@sony.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH 1/2] PCI: Add pci=hpreserve= to reserve memory windows for a hotplug bridge
Date: Fri,  2 Oct 2026 21:31:10 +0200
Message-ID: <20261002193111.51637-2-maciej.grochowski@sony.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261002193111.51637-1-maciej.grochowski@sony.com>
References: <20261002193111.51637-1-maciej.grochowski@sony.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sony-BusinessRelay-GUID: sWsOduFvKczEIhZ7vm_eoKG6Q-4Ai0bz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Sony-EdgeRelay-GUID: EdHhVk2CGi_wQ0VyRGSBGF2KR6borvmr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-GUID: XTvJ-mgPv-5qfqbNtuvaBI0RnmHsAKlR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3NyBTYWx0ZWRfX2cgjZGp2msyj
 Uzaafn8l9PYXMHnjOYqA9ieVFrhwrIb9C0tv5vLAf1X0/hR7M+Zyuw9lb9xAvJqgrv2/l4l9cK6
 iCuXssSi3Wu1aqC3w5QH6Hhmq8yk15maOrK+R0Kb64Gm/ac9+wUV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3NyBTYWx0ZWRfX1MoWng0a+eKt
 keDsWDFs4PlJ6+aO+ilgrR76nufuZpR5AUyLGQViSa3TPlEji8K7lESeFaZDaEhEEzwZ+mrm1oL
 2Hi1MWVqleURcm4amZLb7TflqV/NvZSoy4gYU6bEP3Gbkiy8xKlg6Vbau5bZQ0CQ05tkNnIFfoh
 CcsxQr3tzh8qgKFyYbDiNP9N7T4oLy8T1OlBK6xcjjyQNMGCMEpUbF3IL7z7Jvg7P+IkBX/uPYF
 a48SgwEmPhBs5cR2Q/gcqxb6a2o7qNPXRqA945253PX4udrAurqdYE15e3XzPOw1IByLGf6xgQU
 jDo02FJNE6nk7ENVw3D+/w/kadBFXSOjlXpASyPAxmpbw7Cy6h0vHjBGXYnIGqngy+jpSMqmzOU
 GQhOjMDY32RUH334CU/fujoll5EoIXI8lqLtZc1ovJ1BfiJEpVTIwkIpnW0r5mXQFh3pgHZLG+l
 z9TwncpWE5DyTVz7Oxw==
X-Proofpoint-ORIG-GUID: XTvJ-mgPv-5qfqbNtuvaBI0RnmHsAKlR
X-Authority-Analysis: v=2.4 cv=L92I0OT8 c=1 sm=1 tr=0 ts=6ac00686 cx=c_pps
 a=+By/qi0JbgTNrI/GZhIcbg==:117 a=+By/qi0JbgTNrI/GZhIcbg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22
 a=6Vn1QVPt8UGdu3r8PAnt:22 a=z6gsHLkEAAAA:8 a=GAkUACBVjk-fT7zvbOsA:9
X-Sony-Outbound-GUID: XTvJ-mgPv-5qfqbNtuvaBI0RnmHsAKlR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01

A hotplug bridge is sized for the devices that are present when its
windows are sized, plus the optional hpmmiosize/hpmmioprefsize space.
Some topologies have devices that are known to appear later.  After a
reset of a two-level PCIe switch hierarchy, for example, pciehp
re-enumerates the upstream switch before the link to the nested switch
is back up, so the downstream port leading to the nested switch is
sized with nothing below it.  When the nested switch appears, its BARs
do not fit.

On a two-level Microchip PM50052 (Switchtec PFX) hierarchy whose nested
switch has an NTB function with a 1 GiB prefetchable BAR, a hard reset
of the top-level switch on v7.3-rc2 leaves downstream port 82:03.0
with a 206 MiB prefetchable window, an equal share of its
parent's window.  The nested switch returns about 0.6 s later and
fails:

  pci 0000:8c:00.1: BAR 2 [mem size 0x40000000 64bit pref]: can't assign; no space
  switchtec 0000:8c:00.1: probe with driver switchtec failed with error -16

The global hpmmioprefsize cannot express this.  It applies to every
hotplug bridge, it is optional space that is dropped when it does not
fit, and it has no alignment.  Here the root port window is 1036 MiB:
exactly the 1 GiB + 4 MiB + 4 MiB of the nested switch plus the 4 MiB
BAR of the top switch's management function.  Only one port may get
the space, and it has to be 1 GiB aligned.

Add "pci=hpreserve=<reservation>@<pci_dev>[; ...]" to request a minimum
size and alignment for the memory windows of specific hotplug bridges,
using the usual device specification.  A full path is more robust than
a bare BDF when downstream bus numbers change.  pbus_size_mem() folds
the reservation into the required size and alignment of the window,
so it is assigned like the resources of a device already present below
the bridge.  The runtime distribution of spare space can shrink only
the optional part, leaving the required reservation intact.

Without the parameter nothing changes.

Tested-by: Maciej Grochowski <maciej.grochowski@sony.com>
Signed-off-by: Maciej Grochowski <maciej.grochowski@sony.com>
---
 .../admin-guide/kernel-parameters.txt         |  34 ++++++
 drivers/pci/pci.c                             | 106 ++++++++++++++++++
 drivers/pci/pci.h                             |  19 ++++
 drivers/pci/setup-bus.c                       |  33 ++++++
 4 files changed, 192 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47..19b98e22b10e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5232,6 +5232,40 @@ Kernel parameters
 		hpbussize=nn	The minimum amount of additional bus numbers
 				reserved for buses below a hotplug bridge.
 				Default is 1.
+		hpreserve=
+				Format:
+				<reservation>@<pci_dev>[; ...]
+				where <reservation> is one or more of
+				<key>=<value> separated by colons.
+				Reserve resources for the hotplug bridges
+				specified (in the format described above)
+				for devices that are not present yet, e.g.
+				a switch that is expected behind the bridge
+				but whose link comes up only after the
+				bridge windows have been sized.  Unlike
+				hpmmiosize and hpmmioprefsize, which add
+				optional space that is dropped if it does
+				not fit, the reservation is required space:
+				the bridge window is sized to include it,
+				like the resources of devices already
+				present below the bridge.
+				Only hotplug bridges are affected.
+				Keys:
+				  mmio=nn[KMG]	Minimum size of the
+					non-prefetchable memory window.
+				  mmioalign=nn[KMG]  Minimum alignment of
+					the non-prefetchable memory window.
+				  mmiopref=nn[KMG]  Minimum size of the
+					prefetchable memory window.
+				  mmioprefalign=nn[KMG]  Minimum alignment
+					of the prefetchable memory window.
+				Alignments must be powers of two.  For
+				example,
+				  pci=hpreserve=mmiopref=1032M:mmioprefalign=1G@0000:80:01.1/00.0/03.0
+				reserves a 1 GiB-aligned 1032 MiB
+				prefetchable window below the downstream
+				port at devfn 03.0 of the switch behind root
+				port 0000:80:01.1.
 		realloc=	Enable/disable reallocating PCI bridge resources
 				if allocations done by BIOS are too small to
 				accommodate resources required by all child
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..f6922cf0d96e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -412,6 +412,109 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 	return 1;
 }
 
+/*
+ * "pci=hpreserve=<reservation>@<pci_dev>[; ...]", set in pci_setup() and
+ * copied in pci_realloc_setup_params().
+ */
+static const char *hotplug_reserve_param;
+
+static bool pci_hotplug_reserve_key(const char *p, size_t len, const char *key)
+{
+	return strlen(key) == len && !strncmp(p, key, len);
+}
+
+/*
+ * Parse one "<key>=<value>[:<key>=<value>]*@" reservation into @res.
+ * Returns a pointer to the device specification following the '@', or
+ * NULL if the reservation cannot be parsed.
+ */
+static const char *pci_parse_hotplug_reserve(const char *p,
+					     struct pci_hotplug_reserve *res)
+{
+	unsigned long long val;
+	size_t len;
+	char *end;
+
+	memset(res, 0, sizeof(*res));
+
+	for (;;) {
+		len = strcspn(p, "=:@;");
+		if (p[len] != '=')
+			return NULL;
+
+		val = memparse(p + len + 1, &end);
+		if (end == p + len + 1)
+			return NULL;
+
+		if (pci_hotplug_reserve_key(p, len, "mmio"))
+			res->mmio_size = val;
+		else if (pci_hotplug_reserve_key(p, len, "mmioalign"))
+			res->mmio_align = val;
+		else if (pci_hotplug_reserve_key(p, len, "mmiopref"))
+			res->mmio_pref_size = val;
+		else if (pci_hotplug_reserve_key(p, len, "mmioprefalign"))
+			res->mmio_pref_align = val;
+		else
+			return NULL;
+
+		p = end + 1;
+		if (*end == '@')
+			break;
+		if (*end != ':')
+			return NULL;
+	}
+
+	if ((res->mmio_align && !is_power_of_2(res->mmio_align)) ||
+	    (res->mmio_pref_align && !is_power_of_2(res->mmio_pref_align)))
+		return NULL;
+
+	return p;
+}
+
+/**
+ * pci_get_hotplug_reserve - get the resources reserved for a hotplug bridge
+ * @bridge: the bridge
+ * @res: filled in with the reservation for @bridge
+ *
+ * Look up @bridge in the "pci=hpreserve=" kernel parameter.  Only hotplug
+ * bridges are considered.
+ *
+ * Return: true if a reservation was requested for @bridge.
+ */
+bool pci_get_hotplug_reserve(struct pci_dev *bridge,
+			     struct pci_hotplug_reserve *res)
+{
+	const char *p = hotplug_reserve_param;
+	int ret;
+
+	if (!p || !bridge->is_hotplug_bridge)
+		return false;
+
+	while (*p) {
+		p = pci_parse_hotplug_reserve(p, res);
+		if (!p) {
+			pr_err_once("PCI: Can't parse hpreserve parameter\n");
+			return false;
+		}
+
+		ret = pci_dev_str_match(bridge, p, &p);
+		if (ret == 1)
+			return true;
+		if (ret < 0) {
+			pr_err_once("PCI: Can't parse hpreserve parameter\n");
+			return false;
+		}
+
+		if (*p != ';' && *p != ',') {
+			/* End of param or invalid format */
+			break;
+		}
+		p++;
+	}
+
+	return false;
+}
+
 static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
 			      u8 pos, int cap)
 {
@@ -6840,6 +6943,8 @@ static int __init pci_setup(char *str)
 					simple_strtoul(str + 10, &str, 0);
 				if (pci_hotplug_bus_size > 0xff)
 					pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
+			} else if (!strncmp(str, "hpreserve=", 10)) {
+				hotplug_reserve_param = str + 10;
 			} else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
 				pcie_bus_config = PCIE_BUS_TUNE_OFF;
 			} else if (!strncmp(str, "pcie_bus_safe", 13)) {
@@ -6879,6 +6984,7 @@ static int __init pci_realloc_setup_params(void)
 					   GFP_KERNEL);
 	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
 	config_acs_param = kstrdup(config_acs_param, GFP_KERNEL);
+	hotplug_reserve_param = kstrdup(hotplug_reserve_param, GFP_KERNEL);
 
 	return 0;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..5003d2c71200 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -410,6 +410,25 @@ extern unsigned long pci_hotplug_mmio_size;
 extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
+/**
+ * struct pci_hotplug_reserve - resources reserved for a hotplug bridge
+ * @mmio_size: minimum size of the non-prefetchable memory window
+ * @mmio_align: minimum alignment of the non-prefetchable memory window
+ * @mmio_pref_size: minimum size of the prefetchable memory window
+ * @mmio_pref_align: minimum alignment of the prefetchable memory window
+ *
+ * Requested with "pci=hpreserve=".  A value of zero means no reservation.
+ */
+struct pci_hotplug_reserve {
+	resource_size_t mmio_size;
+	resource_size_t mmio_align;
+	resource_size_t mmio_pref_size;
+	resource_size_t mmio_pref_align;
+};
+
+bool pci_get_hotplug_reserve(struct pci_dev *bridge,
+			     struct pci_hotplug_reserve *res);
+
 static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
 {
 	return dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e8c94aa1d3c1..105bf8694cdc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1258,6 +1258,38 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
 	return true;
 }
 
+/*
+ * Apply a "pci=hpreserve=" reservation to the memory window @b_res of the
+ * bridge leading to @bus.  Unlike the hpmmiosize/hpmmioprefsize space, the
+ * reservation is sized as required space, so it is in place before the
+ * devices that need it appear behind the bridge.
+ */
+static void pbus_size_mem_reserve(struct pci_bus *bus, struct resource *b_res,
+				  resource_size_t *size,
+				  resource_size_t *min_align)
+{
+	bool pref = b_res->flags & IORESOURCE_PREFETCH;
+	struct pci_hotplug_reserve res;
+	resource_size_t rsize, ralign;
+
+	if (!bus->self || !pci_get_hotplug_reserve(bus->self, &res))
+		return;
+
+	rsize = pref ? res.mmio_pref_size : res.mmio_size;
+	ralign = pref ? res.mmio_pref_align : res.mmio_align;
+	if (rsize <= *size && ralign <= *min_align)
+		return;
+
+	*size = max(*size, rsize);
+	if (!*size)
+		return;
+	*min_align = max(*min_align, ralign);
+
+	pci_info(bus->self, "bridge window to %pR: reserving %s size %#llx align %#llx\n",
+		 &bus->busn_res, pref ? "prefetchable" : "non-prefetchable",
+		 (unsigned long long)*size, (unsigned long long)*min_align);
+}
+
 /**
  * pbus_size_mem() - Size the memory window of a given bus
  *
@@ -1349,6 +1381,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	win_align = pci_min_window_alignment(bus, b_res->flags);
 	min_align = calculate_head_align(aligns, max_order);
 	min_align = max(min_align, win_align);
+	pbus_size_mem_reserve(bus, b_res, &size, &min_align);
 	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
 				  0, win_align);
 
-- 
2.47.3

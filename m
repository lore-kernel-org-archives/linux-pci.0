Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475F3EB7F4
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.183.30.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969797; cv=none; b=BovFbEB7gT5DrAAq2wPcg64tYCU5lWgVczdFSJufZ+TQp4r0OssweLl1smHnp0Jd7SX0RHoB6xKwdLDFGtb/i28UA0K5Zu5UrL8nD6ZLhmYLvMGOcz95o8OD5IBHG1duEeLf1AgDfXjYVmOwISLSqirOak3yKx/2zhybmMxtVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969797; c=relaxed/simple;
	bh=OUGr0HHZy0HzpOaMZv6rZGcyBaiTk3jqp9lR48LpTkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj0cZ5j5APY77/8JnDlY9Fb1ZPIh7SHuFbkdW91eXUFK/RlSatKv+1ny7/ARHzKB3i1udPavt5lx8J9yJUObo0V2WBdgWQE/7bTCL8Ptc+UVfW45drngxOVFnQ/gBDKqCcbGcA9VIP1waMsw7jjUixnHWPpe6IE+L+cRiLeGetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=bKKfheXt; arc=none smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="bKKfheXt"
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692JRfoA1637708;
	Fri, 2 Oct 2026 19:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=p1; bh=GR+pI+0DJh6hhxBPV8
	d0uWm8zweWnIqHS2S4KXgM9o8=; b=bKKfheXtQQ7q1T3Qm5E5WKVxdxizmRKTdb
	Ib25DDxpgpUmrBqtGKIBzXhhUAkx2r+vU+uwBgEm7hAMnN42RGB8hEDzciT6AtTl
	c50OouqdqmOdbJTJwWAzXz+1T758KcCcbGf91mf3SioTYS0eEZMEtr17/Zc+khxQ
	5F/NZnEkUdgtgIhHMV5Mm2uqbAEyYdZ/+N37iuDU/p/rGgtpLl2ljwgXSYmRhehf
	jZFTL6beW6WgCqBVCrqdtAz0kqwkHt9C8sEHgvzRJLoSAPhSfX3Zh/0xIEkIY8Cw
	kXw3q1UhZj4PI24zVX7ByCAJwg2vjXtGRgGlDG1mnFwuoXUyvoPQ==
Received: from sgppsem01v.sg.gdce.sony.com.sg ([121.100.43.221])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4gx5cwfxx1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 02 Oct 2026 19:31:24 +0000 (GMT)
Received: from pps.filterd (SGPPSEM01v.sg.gdce.sony.com.sg [127.0.0.1])
	by SGPPSEM01v.sg.gdce.sony.com.sg (8.18.1.11/8.18.1.11) with ESMTP id 692JBlkV1674029;
	Fri, 2 Oct 2026 19:31:21 GMT
Received: from usculxsnt13v.am.sony.com ([146.215.230.187])
	by SGPPSEM01v.sg.gdce.sony.com.sg (PPS) with ESMTPS id 4gx74j0xqp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 19:31:21 +0000 (GMT)
Received: from pps.filterd (USCULXSNT13v.am.sony.com [127.0.0.1])
	by USCULXSNT13v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 692J942s1761800;
	Fri, 2 Oct 2026 19:31:18 GMT
Received: from us842f57abef3e.eu.sony.com ([10.10.10.214])
	by USCULXSNT13v.am.sony.com (PPS) with ESMTPS id 4gx5afe81c-3
	(version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256 verify=NOT);
	Fri, 02 Oct 2026 19:31:18 +0000 (GMT)
From: Maciej Grochowski <maciej.grochowski@sony.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH 2/2] PCI: Allow pci=hpreserve= to reserve bus numbers for a hotplug bridge
Date: Fri,  2 Oct 2026 21:31:11 +0200
Message-ID: <20261002193111.51637-3-maciej.grochowski@sony.com>
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
X-Sony-BusinessRelay-GUID: jDvRJ451U7vC3cDZVTGmDQY56j12i9hU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Sony-EdgeRelay-GUID: wM3x_IgcAAGBsl4Z6O_DzIy09dT2wl7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3NyBTYWx0ZWRfX+w3kCYZwvntj
 cRINV+8Jla+vitF6kHyVJO8yQ3oG1q5+XKX4U7UXeQzCAbFIzKBY1D3ApOqrcR5NRw+C2IiNGMA
 jPCywUQXaDIHOyezrqRteyz4bt65sFet/cBO/4JVszX1lvLvwV15hJWjM0XRMw02g0I/mSAE63e
 e83QPb1X7ES6oBaizp5mDiCfsHIqyoF3SJGCBZB+wcS0fvK8QSlGNuKZoh0dwMOvA5PXW3E7wQO
 sLkSkZhjU3Zq+jKMSqWkgw6mx7OLKL41Zq9K4ohaoPVUa5JdbzQvOXHZpbRzCdXAMfDYg3dkWoB
 VVb+zBylsRoZNRkhJ8ZmPJjBdLhvov3doWpZJqv/crymLXZ1xDKEFH5C96sNVB4nS69Ex+Lfs3I
 mRqtHXr5Izt1GO9HN6p4oVH+d7iGIMtkg4qsBmdoCDpOgwnxXrWv41X7OofD5tjs0uszCBBAP7M
 YrpSmWhIr+BCdHL68hw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3NyBTYWx0ZWRfXxlcEl+ryCc7P
 Rj3Ly23G1kKan83QK9DsLH4kpCOde+XIuZVHDD/gM4DCz+rfu6wmfAJX+D2ch1wcXB1ZazotWQr
 oPzAC1w2iwy4LPB5s8LTZoLCebP5ivC6t0WcedpirjsTCTMyLNOk
X-Authority-Analysis: v=2.4 cv=QbXzLcbv c=1 sm=1 tr=0 ts=6ac0068c cx=c_pps
 a=5iEaAFJ3UIynSlflvg1n/g==:117 a=5iEaAFJ3UIynSlflvg1n/g==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22
 a=dNm3KQjjYUbhztXjLiFs:22 a=z6gsHLkEAAAA:8 a=sZtm-H0M5STMBRONTHkA:9
X-Proofpoint-ORIG-GUID: vZB64hbQkdXgn1TV08mFNIF4_nvc0FAX
X-Proofpoint-GUID: vZB64hbQkdXgn1TV08mFNIF4_nvc0FAX
X-Sony-Outbound-GUID: vZB64hbQkdXgn1TV08mFNIF4_nvc0FAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01

When the kernel assigns bus numbers to the bridges on a bus,
pci_scan_child_bus_extend() divides the spare bus numbers equally
between the hotplug bridges.  A switch that appears behind one of them
later cannot use more than that share.

After a hard reset of the top-level switch of a two-level
Microchip PM50052 hierarchy on v7.3-rc2, the 15 spare bus numbers below
the upstream port are split 3/3/3/3/3 between its five hotplug
downstream ports, leaving 82:03.0 with [bus 8c-8e].  The nested switch
that comes back behind it needs 11 (its upstream port's bus, its
internal bus and nine downstream ports), so part of it is unusable:

  pci 0000:8c:00.0: devices behind bridge are unusable because [bus 8d-96] cannot be assigned for them

hpbussize does not help: it applies to every hotplug bridge, so it
cannot give one port 11 bus numbers without asking the same for its
four siblings.

Add a "bus=" key to pci=hpreserve=.  A reserved hotplug bridge gets the
number of bus numbers it asks for, counted like hpbussize, and the
other hotplug bridges on the bus share what is left.  With "bus=11" on
82:03.0 the split above becomes 1/1/1/11/1.  If fewer bus numbers are
left than requested, the bridge gets what is left and a warning is
logged.

Without the parameter the distribution is unchanged.

Tested-by: Maciej Grochowski <maciej.grochowski@sony.com>
Signed-off-by: Maciej Grochowski <maciej.grochowski@sony.com>
---
 .../admin-guide/kernel-parameters.txt         | 18 ++++--
 drivers/pci/pci.c                             |  2 +
 drivers/pci/pci.h                             |  3 +
 drivers/pci/probe.c                           | 58 +++++++++++++++++--
 4 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 19b98e22b10e..fea5f1bb455f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5251,6 +5251,14 @@ Kernel parameters
 				present below the bridge.
 				Only hotplug bridges are affected.
 				Keys:
+				  bus=nn	Number of bus numbers for the
+					buses below the bridge, counted like
+					hpbussize.  When the kernel distributes
+					spare bus numbers between the hotplug
+					bridges on a bus, e.g. when a switch is
+					hot-added, the reserved bridge gets its
+					reservation first and the others share
+					what is left.
 				  mmio=nn[KMG]	Minimum size of the
 					non-prefetchable memory window.
 				  mmioalign=nn[KMG]  Minimum alignment of
@@ -5261,11 +5269,11 @@ Kernel parameters
 					of the prefetchable memory window.
 				Alignments must be powers of two.  For
 				example,
-				  pci=hpreserve=mmiopref=1032M:mmioprefalign=1G@0000:80:01.1/00.0/03.0
-				reserves a 1 GiB-aligned 1032 MiB
-				prefetchable window below the downstream
-				port at devfn 03.0 of the switch behind root
-				port 0000:80:01.1.
+				  pci=hpreserve=bus=11:mmiopref=1032M:mmioprefalign=1G@0000:80:01.1/00.0/03.0
+				reserves 11 bus numbers and a 1 GiB-aligned
+				1032 MiB prefetchable window below the
+				downstream port at devfn 03.0 of the switch
+				behind root port 0000:80:01.1.
 		realloc=	Enable/disable reallocating PCI bridge resources
 				if allocations done by BIOS are too small to
 				accommodate resources required by all child
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6922cf0d96e..81123789f66b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -454,6 +454,8 @@ static const char *pci_parse_hotplug_reserve(const char *p,
 			res->mmio_pref_size = val;
 		else if (pci_hotplug_reserve_key(p, len, "mmioprefalign"))
 			res->mmio_pref_align = val;
+		else if (pci_hotplug_reserve_key(p, len, "bus") && val <= 0xff)
+			res->buses = val;
 		else
 			return NULL;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5003d2c71200..56efd486cccd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -412,6 +412,8 @@ extern unsigned long pci_hotplug_bus_size;
 
 /**
  * struct pci_hotplug_reserve - resources reserved for a hotplug bridge
+ * @buses: bus numbers for the hierarchy below the bridge, including its
+ *	   secondary bus
  * @mmio_size: minimum size of the non-prefetchable memory window
  * @mmio_align: minimum alignment of the non-prefetchable memory window
  * @mmio_pref_size: minimum size of the prefetchable memory window
@@ -420,6 +422,7 @@ extern unsigned long pci_hotplug_bus_size;
  * Requested with "pci=hpreserve=".  A value of zero means no reservation.
  */
 struct pci_hotplug_reserve {
+	unsigned int buses;
 	resource_size_t mmio_size;
 	resource_size_t mmio_align;
 	resource_size_t mmio_pref_size;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..086b7a549c27 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3081,10 +3081,22 @@ void __weak pcibios_fixup_bus(struct pci_bus *bus)
  * equally between hotplug-capable bridges to allow future extension of the
  * hierarchy.
  */
+static unsigned int pci_hotplug_reserved_buses(struct pci_dev *bridge)
+{
+	struct pci_hotplug_reserve res;
+
+	if (!pci_get_hotplug_reserve(bridge, &res))
+		return 0;
+
+	return res.buses;
+}
+
 static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 					      unsigned int available_buses)
 {
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
+	unsigned int reserved_bridges = 0, reserved_buses = 0;
+	unsigned int hotplug_share = 0;
 	unsigned int start = bus->busn_res.start;
 	unsigned int devnr, cmax, max = start;
 	struct pci_dev *dev;
@@ -3115,12 +3127,28 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	 * buses between hotplug bridges.
 	 */
 	for_each_pci_bridge(dev, bus) {
-		if (dev->is_hotplug_bridge)
+		if (dev->is_hotplug_bridge) {
+			unsigned int reserved = pci_hotplug_reserved_buses(dev);
+
 			hotplug_bridges++;
-		else
+			if (reserved) {
+				reserved_bridges++;
+				reserved_buses += reserved;
+			}
+		} else {
 			normal_bridges++;
+		}
 	}
 
+	/*
+	 * Hotplug bridges with a "pci=hpreserve=" bus reservation get the
+	 * number of buses they asked for; the others share what is left.
+	 */
+	if (hotplug_bridges > reserved_bridges &&
+	    available_buses > reserved_buses)
+		hotplug_share = (available_buses - reserved_buses) /
+				(hotplug_bridges - reserved_bridges);
+
 	/*
 	 * Scan bridges that are already configured. We don't touch them
 	 * unless they are misconfigured (which will be done in the second
@@ -3152,12 +3180,34 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 			 */
 			buses = available_buses;
 		} else if (dev->is_hotplug_bridge) {
+			unsigned int reserved = pci_hotplug_reserved_buses(dev);
+
 			/*
 			 * Distribute the extra buses between hotplug
 			 * bridges if any.
 			 */
-			buses = available_buses / hotplug_bridges;
-			buses = min(buses, available_buses - used_buses + 1);
+			if (!reserved) {
+				buses = hotplug_share;
+				buses = min(buses, available_buses - used_buses + 1);
+			} else {
+				/* used_buses already includes this bridge's bus */
+				buses = available_buses + 1 > used_buses ?
+					available_buses + 1 - used_buses : 0;
+				buses = min(buses, reserved);
+			}
+
+			/* Bridges configured in the first pass keep their buses */
+			if (reserved && !dev->subordinate) {
+				/* The secondary bus is allocated even for 0 */
+				unsigned int granted = max(buses, 1U);
+
+				if (granted < reserved)
+					pci_warn(dev, "only %u of %u reserved bus numbers available\n",
+						 granted, reserved);
+				else
+					pci_info(dev, "reserving %u bus numbers\n",
+						 granted);
+			}
 		}
 
 		cmax = max;
-- 
2.47.3

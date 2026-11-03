Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.132.183.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730464;
	b=lEkT6MJ8H51dBu5TmRAvQd4/T8MuAnCrjQbt0GAMfbanTDKTvNaes5OPACFB5V7hQnif
	 W6dtsQ3kPpWBIX/2dvcXEUWxdreJTKoMgvhhwuprDk7gZa7D/plnPlocOW+54CZKO5ND5
	 Ez/1hlWsOm3jKcs22bZdZxtaDXAc/oxajXfUuQIen31biDNs94r644+iL5sy/DJPHY8/9
	 ndAJCFvrUr3e1ZPTWRr3dSx2fyuEMxAHiEkexkgODIEYMXj+6kHIZ2l5q90sAmDSl7r4p
	 gN5wmGbdzRJXyZfE6x+edKWWl9J/ScSd9buA03pNjCvDmwxKqFGlZNYN8nWlr3viOog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730464;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-Sony-BusinessRelay-GUID:
	 X-Proofpoint-Virus-Version:X-Sony-EdgeRelay-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Sony-Outbound-GUID:
	 X-Proofpoint-Virus-Version;
	bh=FcQW18igFmNwpgQ52DefJQ/lR+8v8LNa/utHyEf9HUM=;
	b=yZkszklANJv/1Mq/XtRqqMa7xWx+iYm0mXZEVD7Qu+0f2dLeu8Fsa3FRTjOkBa0Zaucn
	 zdc8v6EWXlodKM51dlSUH/lXi7YsqlTxE0XJh7BIy7cChr70nh49vxcFiJBZ12nZKLw/n
	 QfEGbZAoRlt7pyqbzTP10UdLfPUc8R4tGtJ60zM8sylTA/zpoeVXA6UzPI/e/EmkSk6cG
	 3ojdDc4YYliY4obu8oPVENo63bxqcgDVnS5FLhAzyhbj4AKnwe/vAy9TebhnfrVarm313
	 bmAvyterPS3AYz7ktoe2KstV3QW01WgGxsY6scs7kfSg3Y0EhSa4Bx/I8Ui7TV+JiPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sony.com;
	spf=pass smtp.mailfrom=sony.com;
	dkim=pass header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=DpFMXIsA;
	arc=none smtp.remote-ip=185.132.183.11
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F37C606A324;
	Tue,  3 Nov 2026 18:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F37C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=DpFMXIsA
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3Hl3OC3946215;
	Tue, 3 Nov 2026 18:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=p1; bh=FcQW18igFmNwpgQ52D
	efJQ/lR+8v8LNa/utHyEf9HUM=; b=DpFMXIsA96CrqDFKV/HB5MqvW8wQQpUh/U
	0M9xN5GalUnRrcUwt15sA907iv2PyibF7GWXe07c4pFlpy1qnKTa4sYxJYSLnfnO
	pUut4mYxnq+920nx0BegtwpvBaSKNOO6W/uot8YFCoDJy3JVD0Dg8oRLQoIN/Wb4
	7SJaHcj/blx9klV36F6HBsLanqqpvmKYm7JXyAk8W+QBj7Ie/hPqLFJWsRF5m1lj
	d8tcrXhReiZ/u5t2XuwA0RUucPlXuoa/G0NUkdS7hMKIaFipPvyn5d39pxm0Bv/x
	qzIHqZPeD7q5Sv9ibWPGD+SaDnzTNSWotq8hYBEMH7QipRacegfQ==
Received: from sgppsea02v.sg.gdce.sony.com.sg ([121.100.43.226])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4hn6hbc6g8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 03 Nov 2026 18:27:27 +0000 (GMT)
Received: from pps.filterd (SGPPSEA02v.sg.gdce.sony.com.sg [127.0.0.1])
	by SGPPSEA02v.sg.gdce.sony.com.sg (8.18.1.11/8.18.1.11) with ESMTP id 6A3HQc8d1602142;
	Tue, 3 Nov 2026 18:27:26 GMT
Received: from usculxsnt14v.am.sony.com ([146.215.230.38])
	by SGPPSEA02v.sg.gdce.sony.com.sg (PPS) with ESMTPS id 4hn9dgdva1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 18:27:25 +0000 (GMT)
Received: from pps.filterd (usculxsnt14v.am.sony.com [127.0.0.1])
	by usculxsnt14v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HNsvj020765;
	Tue, 3 Nov 2026 10:27:23 -0800
Received: from us842f57abef3e.ad.gaikai.biz ([10.10.10.214])
	by usculxsnt14v.am.sony.com (PPS) with ESMTPS id 4hp1wap27r-3
	(version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256 verify=NOT);
	Tue, 03 Nov 2026 10:27:23 -0800 (PST)
From: Maciej Grochowski <Maciej.Grochowski@sony.com>
To: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com
Cc: Maciej Grochowski <maciej.grochowski@sony.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH v2 2/2] PCI: Allow hpbussize for specific hotplug bridges
Date: Tue,  3 Nov 2026 10:27:20 -0800
Message-ID: <4ba0c23099e4a4f5ade2b4754871dfbcf896f7dc.1793724065.git.Maciej.Grochowski@sony.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793724065.git.Maciej.Grochowski@sony.com>
References: <cover.1793724065.git.Maciej.Grochowski@sony.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Sony-BusinessRelay-GUID: g23xSiXS_vmfchh8AqlAsLzdGqkq_AHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Sony-EdgeRelay-GUID: MnqbqhS2oEkJH6tLewsRD28KslyWvvu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX3g72AxNxV/UA
 JYY7+L0yoIjFkrWWZTzHXMo5Noc01IBZ7q4Xi2//tjcKmOYt8U3HlFLl8MEAi/C/PAG4OsKU6DE
 OB3UYZBXnxspzOC2qjsy9Mnvkne88vusBnPQzggw0AvUOe/EeTJr
X-Proofpoint-ORIG-GUID: _zFsMFWvLRq18LoEbNXBiR4exrrKXPvs
X-Proofpoint-GUID: _zFsMFWvLRq18LoEbNXBiR4exrrKXPvs
X-Authority-Analysis: v=2.4 cv=E7ZYNqdl c=1 sm=1 tr=0 ts=6aea2790 cx=c_pps
 a=6mgWUpd4vGE96FGw1JXD8A==:117 a=6mgWUpd4vGE96FGw1JXD8A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22
 a=lmptg-Pxpg44AF-n8Qp9:22 a=z6gsHLkEAAAA:8 a=NnfKt6W3vqzboaULA5AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX2DqBTgxOP5C/
 TBUdMTW0edHyvpAgMwmakrqpv/DLDCoke0sBJriWd5eJBu0+cRpquM51lvRqQ2InGun5Y0MyvK/
 b0Y/k9fcObkhl8nAxDti1GIu7/aQaRk6+Amtu/fCIQ/3tig/Gl252AYqnguZwYizeBAhlkT/Jcr
 HkGdaUDK8WpEXELI5ghry0AMvSsHs9rM9b87x84DacEaGFFgeVpR7w4AhcY483H1ZqD3R7rdg3P
 j2Iz0AxfW4tqEzS1M+YjWceQlpHA9j8DeAdFKq8H3Taovl8YHg1CvmMGUQ0y75gl3R5IPHFRdT2
 v4TwWkBS0QyHHC4T85sJzX8l+fdl+cuAJLRX76CJlccMgwvSXfMqPvDOMBDKLReXjlCfACb52TA
 pSJ+rEHv5Z2k6gqfdjigYU9cHKwtdmq3E3M1DEvFT80S0LCY1MKdhQFvki6ERx4LkyL1itJk/43
 y13fVtvJKvtX9WqdxZw==
X-Sony-Outbound-GUID: _zFsMFWvLRq18LoEbNXBiR4exrrKXPvs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01

From: Maciej Grochowski <maciej.grochowski@sony.com>

Spare bus numbers below a switch are divided between its hotplug ports.
A nested switch that appears later can need more than its port's share.
After a top-switch reset on our PM50052 hierarchy, five downstream ports
split 15 bus numbers equally, leaving the nested switch's port three
buses although its hierarchy needs 11.

A global hpbussize of 11 asks for the same minimum on all five ports, so
earlier siblings consume the range before the selected port is reached.

Allow hpbussize to take "<count>@<pci_dev>" entries, separated by
semicolons, using the lookup added by the memory-window patch:

  pci=hpbussize=11@0000:80:01.1/00.0/03.0

Recompute each unconfigured hotplug bridge's share from the bus numbers
still free and the remaining minima. The selected bridge's count replaces
its global minimum; the other bridges share the remainder. In this case,
the split becomes 1/1/1/11/1 instead of 3/3/3/3/3.

Include the global minimum for unselected bridges in that calculation.
Clamp scoped counts to 255 and stop before looking up a secondary bus
number above 255, so a large request cannot wrap the lookup to bus zero.

Apply the selected minimum when scanning the bridge's own child bus too.
Parent capacity still limits the reservation, and configured firmware
ranges are kept. A bare option keeps its existing global meaning.

Assisted-by: Opus 5.5 (implementation/testing), GPT-6.1 (review)
Signed-off-by: Maciej Grochowski <maciej.grochowski@sony.com>
---
 .../admin-guide/kernel-parameters.txt         | 16 ++++
 drivers/pci/pci.c                             | 34 ++++++--
 drivers/pci/probe.c                           | 87 ++++++++++++++++++-
 3 files changed, 126 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 19defbe2a1d6..f07ee41f7feb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5253,6 +5253,22 @@ Kernel parameters
 		hpbussize=nn	The minimum amount of additional bus numbers
 				reserved for buses below a hotplug bridge.
 				Default is 1.
+		hpbussize=nn@<pci_dev>[; ...]
+				The minimum amount of bus numbers for the
+				hotplug bridges specified (in the format
+				described above) instead of the default
+				amount above.  When the kernel numbers the
+				buses below the hotplug bridges on a bus,
+				e.g. after a switch is hot-added, these
+				bridges request at least nn bus numbers where
+				space permits; other hotplug bridges share
+				what is left.
+				Bridges numbered by firmware are kept.  For
+				example,
+				  pci=hpbussize=11@0000:80:01.1/00.0/03.0
+				gives 11 bus numbers to the downstream port
+				at devfn 03.0 of the switch behind root port
+				0000:80:01.1.
 		realloc=	Enable/disable reallocating PCI bridge resources
 				if allocations done by BIOS are too small to
 				accommodate resources required by all child
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7a6ce1d3360d..a02220e5aaf2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -413,11 +413,13 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 }
 
 /*
- * "<size>@<pci_dev>" entries of "pci=hpmmiosize=" and "pci=hpmmioprefsize=",
- * set in pci_setup() and copied in pci_realloc_setup_params().
+ * "<size>@<pci_dev>" entries of "pci=hpmmiosize=", "pci=hpmmioprefsize=" and
+ * "pci=hpbussize=", set in pci_setup() and copied in
+ * pci_realloc_setup_params().
  */
 static const char *hotplug_mmio_size_param;
 static const char *hotplug_mmio_pref_size_param;
+static const char *hotplug_bus_size_param;
 
 /* Match @bridge against a "<size>@<pci_dev>[;...]" list; first match wins */
 static bool pci_hotplug_size_match(struct pci_dev *bridge, const char *p,
@@ -455,23 +457,33 @@ static bool pci_hotplug_size_match(struct pci_dev *bridge, const char *p,
 /**
  * pci_hotplug_dev_size - get a hotplug size given for a specific bridge
  * @bridge: the bridge
- * @type: IORESOURCE_MEM, optionally with IORESOURCE_PREFETCH
+ * @type: IORESOURCE_MEM, optionally with IORESOURCE_PREFETCH, or IORESOURCE_BUS
  * @size: set to the size given for @bridge
  *
- * Look up @bridge in the "<size>@<pci_dev>" entries of "pci=hpmmiosize=" or
- * "pci=hpmmioprefsize=".  Only hotplug bridges are considered.
+ * Look up @bridge in the "<size>@<pci_dev>" entries of "pci=hpmmiosize=",
+ * "pci=hpmmioprefsize=" or "pci=hpbussize=".  Only hotplug bridges are
+ * considered.
  *
  * Return: true if a size was given for @bridge.
  */
 bool pci_hotplug_dev_size(struct pci_dev *bridge, unsigned long type,
 			  unsigned long *size)
 {
-	if (!bridge->is_hotplug_bridge || !(type & IORESOURCE_MEM))
+	const char *p;
+
+	if (!bridge->is_hotplug_bridge)
+		return false;
+
+	if (type & IORESOURCE_BUS)
+		p = hotplug_bus_size_param;
+	else if (type & IORESOURCE_PREFETCH)
+		p = hotplug_mmio_pref_size_param;
+	else if (type & IORESOURCE_MEM)
+		p = hotplug_mmio_size_param;
+	else
 		return false;
 
-	return pci_hotplug_size_match(bridge, type & IORESOURCE_PREFETCH ?
-				      hotplug_mmio_pref_size_param :
-				      hotplug_mmio_size_param, size);
+	return pci_hotplug_size_match(bridge, p, size);
 }
 
 static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
@@ -6966,6 +6978,9 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
 				pci_hotplug_mmio_size = memparse(str + 10, &str);
 				pci_hotplug_mmio_pref_size = pci_hotplug_mmio_size;
+			} else if (!strncmp(str, "hpbussize=", 10) &&
+				   strchr(str + 10, '@')) {
+				hotplug_bus_size_param = str + 10;
 			} else if (!strncmp(str, "hpbussize=", 10)) {
 				pci_hotplug_bus_size =
 					simple_strtoul(str + 10, &str, 0);
@@ -7013,6 +7028,7 @@ static int __init pci_realloc_setup_params(void)
 	hotplug_mmio_size_param = kstrdup(hotplug_mmio_size_param, GFP_KERNEL);
 	hotplug_mmio_pref_size_param = kstrdup(hotplug_mmio_pref_size_param,
 					       GFP_KERNEL);
+	hotplug_bus_size_param = kstrdup(hotplug_bus_size_param, GFP_KERNEL);
 
 	return 0;
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..b79a931edce5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1519,6 +1519,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		else
 			next_busnr = max + 1;
 
+		if (next_busnr > 0xff)
+			goto out;
+
 		/*
 		 * Prevent assigning a bus number that already exists.
 		 * This can happen when a bridge is hot-plugged, so in this
@@ -3076,6 +3079,62 @@ void __weak pcibios_fixup_bus(struct pci_bus *bus)
        /* nothing to do, expected to be removed in the future */
 }
 
+/* Bus numbers given for @bridge with "pci=hpbussize=<n>@<pci_dev>", or 0 */
+static unsigned int pci_hotplug_bus_reserve(struct pci_dev *bridge)
+{
+	unsigned long size;
+
+	if (!pci_hotplug_dev_size(bridge, IORESOURCE_BUS, &size))
+		return 0;
+
+	return min(size, 255UL);
+}
+
+/*
+ * Return the bus numbers for the next hotplug bridge on @bus that is not
+ * configured yet, out of the @left that the next bridge can still take.
+ * The secondary bus of each such bridge is already counted as used, so
+ * together they have @left plus one less than their count.  A bridge with
+ * its own "pci=hpbussize=" gets at least that many; the others share the
+ * rest equally.
+ */
+static unsigned int pci_hotplug_bus_share(struct pci_bus *bus,
+					  struct pci_dev *bridge,
+					  unsigned int left)
+{
+	unsigned int n, sum, share = UINT_MAX, prev, reserve;
+	struct pci_dev *dev;
+
+	n = 0;
+	for_each_pci_bridge(dev, bus)
+		if (dev->is_hotplug_bridge && !dev->subordinate)
+			n++;
+	if (!n)
+		return 0;
+	left += n - 1;
+
+	/* Each bridge above the share lowers it for the others */
+	do {
+		prev = share;
+		n = 0;
+		sum = 0;
+		for_each_pci_bridge(dev, bus) {
+			if (!dev->is_hotplug_bridge || dev->subordinate)
+				continue;
+
+			reserve = pci_hotplug_bus_reserve(dev) ?: pci_hotplug_bus_size;
+			if (reserve > prev)
+				sum += reserve;
+			else
+				n++;
+		}
+		share = n && left > sum ? (left - sum) / n : 0;
+	} while (share < prev);
+
+	reserve = pci_hotplug_bus_reserve(bridge) ?: pci_hotplug_bus_size;
+	return max(reserve, share);
+}
+
 /**
  * pci_scan_child_bus_extend() - Scan devices below a bus
  * @bus: Bus to scan for devices
@@ -3094,6 +3153,8 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
 	unsigned int start = bus->busn_res.start;
 	unsigned int devnr, cmax, max = start;
+	bool hotplug_reserve = false;
+	unsigned int reserve;
 	struct pci_dev *dev;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
@@ -3126,6 +3187,8 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 			hotplug_bridges++;
 		else
 			normal_bridges++;
+		if (pci_hotplug_bus_reserve(dev))
+			hotplug_reserve = true;
 	}
 
 	/*
@@ -3150,6 +3213,8 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	for_each_pci_bridge(dev, bus) {
 		unsigned int buses = 0;
 
+		reserve = 0;
+
 		if (!hotplug_bridges && normal_bridges == 1) {
 			/*
 			 * There is only one bridge on the bus (upstream
@@ -3163,7 +3228,16 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 			 * Distribute the extra buses between hotplug
 			 * bridges if any.
 			 */
-			buses = available_buses / hotplug_bridges;
+			if (hotplug_reserve && available_buses) {
+				if (!dev->subordinate) {
+					reserve = pci_hotplug_bus_reserve(dev);
+					buses = available_buses + 1 > used_buses ?
+						available_buses + 1 - used_buses : 0;
+					buses = pci_hotplug_bus_share(bus, dev, buses);
+				}
+			} else {
+				buses = available_buses / hotplug_bridges;
+			}
 			buses = min(buses, available_buses - used_buses + 1);
 		}
 
@@ -3172,6 +3246,12 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 		/* One bus is already accounted so don't add it again */
 		if (max - cmax > 1)
 			used_buses += max - cmax - 1;
+
+		if (reserve > max - cmax)
+			pci_warn(dev, "only %u of %u bus numbers available\n",
+				 max - cmax, reserve);
+		else if (reserve)
+			pci_info(dev, "reserving %u bus numbers\n", max - cmax);
 	}
 
 	/*
@@ -3180,7 +3260,10 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	 * bus number if there is room.
 	 */
 	if (bus->self && bus->self->is_hotplug_bridge) {
-		used_buses = max(available_buses, pci_hotplug_bus_size - 1);
+		unsigned long bus_size = pci_hotplug_bus_reserve(bus->self) ?:
+					 pci_hotplug_bus_size;
+
+		used_buses = max(available_buses, bus_size - 1);
 		if (max - start < used_buses) {
 			max = start + used_buses;
 

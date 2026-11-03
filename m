Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.132.183.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730464;
	b=MM0rS9H88ex15A8S8AVp+GX5mfObQqgCIkFRCmwuVp+vDFtaROV5idnKQ/mo8k0h52v3
	 nfBUc5PUJKArmky2dk98FsEfhj+nkJXzEEbcDc2aTm+kDFGqOdHe1mKHkNB2aHeIQCKGv
	 kpFfKh1OPGf9adQKn5KRK7AsX/aMYg9rlOYI/6Cht5TPyflwYUhDnbamLW+mnC9gY+CeN
	 d9BLqCBVPF/aI2cnO51fDfVWd/ur/Glm9kM9HU8sKbZyjzk7RPFtDg9cTb8Jw1N6iXbv8
	 Qk4VL9BtzSBvJGHpkxOxLr5tDXCQz+HB+4HooLHjpuFwMLFDtKO1I4HZY0rAfFbObgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730464;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-Sony-BusinessRelay-GUID:
	 X-Proofpoint-Virus-Version:X-Sony-EdgeRelay-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Sony-Outbound-GUID:
	 X-Proofpoint-Virus-Version;
	bh=1pGEb0MRufNyMzyrGQ27xnAn4N5VHeEJ55sDpJ67eqc=;
	b=gmjPNWEPvfeXZwNz7id4Tb6+eCejS35VMTE6IthHsl1qQiLAmnjBhuHX8jkIHt1NmNqy
	 eEgoM1ZvVXy2YJ1j2mLdLPTYu69Nfwe/WPopS3UtM2KIwxn2UU5UdxNf7f1+A3vBOrvSp
	 Pv4zOEQ4yNOlxjK94C+92lGfsPZrBsuquvzarRsoyZgbC7u04GYDhD03bfxttc7lGrS6+
	 /mfEw9CRGurWSwdNdJnXr+xjZcSvKXv4NQtOvYwd/mcanbfONy+ZWCEW6uKF1GCA6/lB+
	 WtcXsVqO6ZhIKrAjeKp23Lo1JRF97D0upwb7LZBSqFYUSuxvdSo8HkJCkxxlbcnvRYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sony.com;
	spf=pass smtp.mailfrom=sony.com;
	dkim=pass header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=E+Kog3mG;
	arc=none smtp.remote-ip=185.132.183.11
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28A606A31B;
	Tue,  3 Nov 2026 18:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F28A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=p1 header.b=E+Kog3mG
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HOB2N218042;
	Tue, 3 Nov 2026 18:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=p1; bh=1pGEb0MRufNyMzyrGQ
	27xnAn4N5VHeEJ55sDpJ67eqc=; b=E+Kog3mGvDCZ/YTxEhhm1jdNKwUMYSU1rp
	gGr4Yc+TvNoJa16lQgrYH+exeUkmxG4vCXV54iDzshx0fwGfHbpk4KDEmgnAjMlo
	FIi+27CV1sB6rQ/xrrvZo1YH8nMfg3P6O0j/syJW2m0PkZ2LOfp5ExNANwBkExli
	sh6HZyBSucFndrcHUoPBz7v8/VEIBLyR7W8sb0pqjh5m1bShFPt3ulKhYAfSy7OP
	qoZQuQQt0JAUp3rZ/eZPGZwi4DljEgage4fl3OHoVS7Twyp9LYsS6og+fT0OIrhV
	6OnKnjFzQWXMVx4lDlaP06hCcwY+MvMDa7apktS9wT2lTxNxWO8A==
Received: from sgppsea01v.sg.gdce.sony.com.sg ([121.100.43.225])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4hn76wc5sx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 03 Nov 2026 18:27:27 +0000 (GMT)
Received: from pps.filterd (SGPPSEA01v.sg.gdce.sony.com.sg [127.0.0.1])
	by SGPPSEA01v.sg.gdce.sony.com.sg (8.18.1.11/8.18.1.11) with ESMTP id 6A3HQHOD1554965;
	Tue, 3 Nov 2026 18:27:25 GMT
Received: from usculxsnt14v.am.sony.com ([146.215.230.38])
	by SGPPSEA01v.sg.gdce.sony.com.sg (PPS) with ESMTPS id 4hn9dgp3np-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 18:27:24 +0000 (GMT)
Received: from pps.filterd (usculxsnt14v.am.sony.com [127.0.0.1])
	by usculxsnt14v.am.sony.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HNump020778;
	Tue, 3 Nov 2026 10:27:22 -0800
Received: from us842f57abef3e.ad.gaikai.biz ([10.10.10.214])
	by usculxsnt14v.am.sony.com (PPS) with ESMTPS id 4hp1wap27r-2
	(version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256 verify=NOT);
	Tue, 03 Nov 2026 10:27:22 -0800 (PST)
From: Maciej Grochowski <Maciej.Grochowski@sony.com>
To: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com
Cc: Maciej Grochowski <maciej.grochowski@sony.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH v2 1/2] PCI: Allow hpmmiosize and hpmmioprefsize for specific hotplug bridges
Date: Tue,  3 Nov 2026 10:27:19 -0800
Message-ID: <7d68c3c861a92c944bcba84b0096f16550ca0403.1793724065.git.Maciej.Grochowski@sony.com>
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
X-Sony-BusinessRelay-GUID: NQN9-HkgkvXXgqNh1rgZldQkAfoOpR7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Sony-EdgeRelay-GUID: v7VDydPhTZbEL4mBHqC1J68qHu3w7U9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX83lDRH8FDMFA
 kYpyJyt+AoZ0cAFs68q/E3+avG3tv6pPKRjxYHKCt8nALGFaCcTpZWhrtcY872eyD5ZsES9IR7z
 DkRQ/ul+kP+s/Xox1RN8YhBsL3Qf2lXZegS5sdJ4s+042yHKT9O5
X-Proofpoint-GUID: 8xrudVsuOz_Np2u-TqMOP5U5OeLiL3Yv
X-Authority-Analysis: v=2.4 cv=N468hG9B c=1 sm=1 tr=0 ts=6aea278f cx=c_pps
 a=XNW8778QP6juiAqijDMnrw==:117 a=XNW8778QP6juiAqijDMnrw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22
 a=b20fedWF67CaGdYoUt4Y:22 a=z6gsHLkEAAAA:8 a=wMEEw2cCgUlW733BhQkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX+HxXu/sVHIeO
 vZFGs0QMPvmndoTARQDjCqtTHQujFrnbMKqSS61l1m8Z01bG7gmWKa2yfdjsn1yjRP1+DqlSqNI
 guhQP/tCA8ioajltyeVF9gRdWuCeCRoSPCXUMXOgTQctFt9bWTWMa2EfsqorGfuN2DQTpEKIsc/
 LFdU8hi0460RJY8cGb1hy0dtsr4BdPORNeETWdhX1HXwnCv2eGjK20bAIAnmDgb+qA7UTARkg3U
 bPm0CwJk5zu4Ev3qAgbq96b5c1EcSj+HOgY0Vf25x+d09OXkaVq24wf2hf6wgno3iimAcyJUyY9
 P08UZeo1nkopB47La+BJYYX9zN9vD37jYgNlwfntLCnzLXeMRuY8ed7hi9d1Ji91tKKlowB+yBI
 dAbUP2XqahrjLQldLBzmh/DAa3AxpOWrOdneyLl5uByv1v1l53s/8Rkbxp9KuXq9120QG8v+Xmh
 5gdMhKnoJZQmrN1bTpg==
X-Proofpoint-ORIG-GUID: 8xrudVsuOz_Np2u-TqMOP5U5OeLiL3Yv
X-Sony-Outbound-GUID: 8xrudVsuOz_Np2u-TqMOP5U5OeLiL3Yv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01

From: Maciej Grochowski <maciej.grochowski@sony.com>

A hotplug bridge can be sized before devices expected behind it appear.
After a reset of a two-level PM50052 hierarchy, the nested switch's link
returns after its downstream port has received an equal share of the
parent's window. Its 1 GiB prefetchable NTB BAR then fails assignment:

  pci 0000:8c:00.1: BAR 2 [mem size 0x40000000 64bit pref]: can't assign; no space

The global hotplug memory sizes are optional targets for every hotplug
bridge. They cannot reserve the required space and head alignment on one
specific port when the parent aperture cannot satisfy all its siblings.

Allow hpmmiosize and hpmmioprefsize to take "<size>@<pci_dev>" entries,
separated by semicolons, using the existing PCI device selectors. For
example:

  pci=hpmmioprefsize=1032M@0000:80:01.1/00.0/03.0

Use the selected size as a required total window minimum in pbus_size_mem()
and request head alignment of the largest power of two not above that
size. Apply size and alignment independently, preserving stronger existing
requirements. A 1032 MiB minimum therefore requests 1 GiB head alignment.

Reject scoped values that exceed the existing unsigned long size interface
before narrowing them. Also guard window adjustment when there is no
optional realloc entry: a required minimum equal to the global size can
leave no entry to trim.

Retain the existing global optional-space policy. Assigned firmware
windows are kept; the minimum applies when the kernel sizes a window,
such as after hot-add or resource reallocation. Allocation remains subject
to the parent aperture and normal placement rules. A bare option keeps
its existing global meaning.

Assisted-by: Opus 5.5 (implementation/testing), GPT-6.1 (review)
Signed-off-by: Maciej Grochowski <maciej.grochowski@sony.com>
---
 .../admin-guide/kernel-parameters.txt         | 25 +++++++
 drivers/pci/pci.c                             | 75 ++++++++++++++++++-
 drivers/pci/pci.h                             |  3 +
 drivers/pci/setup-bus.c                       | 25 +++++++
 4 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..19defbe2a1d6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5218,9 +5218,34 @@ Kernel parameters
 		hpmmiosize=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's MMIO window.
 				Default size is 2 megabytes.
+		hpmmiosize=nn[KMG]@<pci_dev>[; ...]
+				Reserve at least nn bytes of MMIO window for
+				the hotplug bridges specified (in the format
+				described above), e.g. for a switch that is
+				expected behind the bridge but whose link
+				comes up only after the bridge windows have
+				been sized.  Unlike the default amount, which
+				is optional space that is dropped if it does
+				not fit, this is required space: the window
+				is sized like it would be for devices already
+				present below the bridge, with head alignment
+				from the largest power of two not above nn.
+				The size must fit unsigned long.  Only hotplug bridges
+				are affected, and only windows the kernel
+				sizes, e.g. after a hot-add or with
+				pci=realloc; windows set up by firmware are
+				kept.
 		hpmmioprefsize=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's MMIO_PREF window.
 				Default size is 2 megabytes.
+		hpmmioprefsize=nn[KMG]@<pci_dev>[; ...]
+				Like hpmmiosize=nn[KMG]@<pci_dev>, for the
+				MMIO_PREF window.  For example,
+				  pci=hpmmioprefsize=1032M@0000:80:01.1/00.0/03.0
+				requests a 1032 MiB prefetchable window with
+				1 GiB head alignment below the downstream
+				port at devfn 03.0 of the switch behind root
+				port 0000:80:01.1.
 		hpmemsize=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's MMIO and
 				MMIO_PREF window.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..7a6ce1d3360d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -412,6 +412,68 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 	return 1;
 }
 
+/*
+ * "<size>@<pci_dev>" entries of "pci=hpmmiosize=" and "pci=hpmmioprefsize=",
+ * set in pci_setup() and copied in pci_realloc_setup_params().
+ */
+static const char *hotplug_mmio_size_param;
+static const char *hotplug_mmio_pref_size_param;
+
+/* Match @bridge against a "<size>@<pci_dev>[;...]" list; first match wins */
+static bool pci_hotplug_size_match(struct pci_dev *bridge, const char *p,
+				   unsigned long *size)
+{
+	unsigned long long val;
+	char *end;
+	int ret;
+
+	while (p && *p) {
+		val = memparse(p, &end);
+		if (val > ULONG_MAX)
+			return false;
+		p = end;
+		if (*p == '@') {
+			ret = pci_dev_str_match(bridge, p + 1, &p);
+			if (ret == 1) {
+				*size = val;
+				return true;
+			}
+			if (ret < 0) {
+				pr_err_once("PCI: Can't parse hotplug size parameter\n");
+				return false;
+			}
+		}
+
+		if (*p != ';')
+			break;
+		p++;
+	}
+
+	return false;
+}
+
+/**
+ * pci_hotplug_dev_size - get a hotplug size given for a specific bridge
+ * @bridge: the bridge
+ * @type: IORESOURCE_MEM, optionally with IORESOURCE_PREFETCH
+ * @size: set to the size given for @bridge
+ *
+ * Look up @bridge in the "<size>@<pci_dev>" entries of "pci=hpmmiosize=" or
+ * "pci=hpmmioprefsize=".  Only hotplug bridges are considered.
+ *
+ * Return: true if a size was given for @bridge.
+ */
+bool pci_hotplug_dev_size(struct pci_dev *bridge, unsigned long type,
+			  unsigned long *size)
+{
+	if (!bridge->is_hotplug_bridge || !(type & IORESOURCE_MEM))
+		return false;
+
+	return pci_hotplug_size_match(bridge, type & IORESOURCE_PREFETCH ?
+				      hotplug_mmio_pref_size_param :
+				      hotplug_mmio_size_param, size);
+}
+
 static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
 			      u8 pos, int cap)
 {
@@ -6892,9 +6954,15 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "hpiosize=", 9)) {
 				pci_hotplug_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "hpmmiosize=", 11)) {
-				pci_hotplug_mmio_size = memparse(str + 11, &str);
+				if (strchr(str + 11, '@'))
+					hotplug_mmio_size_param = str + 11;
+				else
+					pci_hotplug_mmio_size = memparse(str + 11, &str);
 			} else if (!strncmp(str, "hpmmioprefsize=", 15)) {
-				pci_hotplug_mmio_pref_size = memparse(str + 15, &str);
+				if (strchr(str + 15, '@'))
+					hotplug_mmio_pref_size_param = str + 15;
+				else
+					pci_hotplug_mmio_pref_size = memparse(str + 15, &str);
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
 				pci_hotplug_mmio_size = memparse(str + 10, &str);
 				pci_hotplug_mmio_pref_size = pci_hotplug_mmio_size;
@@ -6942,6 +7010,9 @@ static int __init pci_realloc_setup_params(void)
 					   GFP_KERNEL);
 	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
 	config_acs_param = kstrdup(config_acs_param, GFP_KERNEL);
+	hotplug_mmio_size_param = kstrdup(hotplug_mmio_size_param, GFP_KERNEL);
+	hotplug_mmio_pref_size_param = kstrdup(hotplug_mmio_pref_size_param,
+					       GFP_KERNEL);
 
 	return 0;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..3b681653b5d9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -419,6 +419,9 @@ extern unsigned long pci_hotplug_mmio_size;
 extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
+bool pci_hotplug_dev_size(struct pci_dev *bridge, unsigned long type,
+			  unsigned long *size);
+
 static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
 {
 	return dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed16ef7c26fa..f3992859d90f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -26,6 +26,7 @@
 #include <linux/ioport.h>
 #include <linux/cache.h>
 #include <linux/limits.h>
+#include <linux/log2.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -1285,6 +1286,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	int order, max_order;
 	resource_size_t children_add_size = 0;
 	resource_size_t add_align = 0;
+	unsigned long hp_size;
 
 	if (!b_res)
 		return;
@@ -1349,6 +1351,27 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	win_align = pci_min_window_alignment(bus, b_res->flags);
 	min_align = calculate_head_align(aligns, max_order);
 	min_align = max(min_align, win_align);
+
+	/*
+	 * A hotplug size given for this bridge is a required minimum, not
+	 * optional space like the global size: aligned for the largest BAR
+	 * that fits in it, so it is in place before the devices that need
+	 * it appear below the bridge.
+	 */
+	if (bus->self &&
+	    pci_hotplug_dev_size(bus->self, b_res->flags, &hp_size)) {
+		if (hp_size) {
+			size = max(size, hp_size);
+			min_align = max_t(resource_size_t, min_align,
+					  rounddown_pow_of_two(hp_size));
+			pci_info(bus->self, "bridge window to %pR: reserving %s size %#lx align %#llx\n",
+				 &bus->busn_res,
+				 b_res->flags & IORESOURCE_PREFETCH ?
+				 "prefetchable" : "non-prefetchable",
+				 hp_size, (unsigned long long)min_align);
+		}
+	}
+
 	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
 				  0, win_align);
 
@@ -1897,6 +1920,8 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 		}
 
 		dev_res = res_to_dev_res(add_list, res);
+		if (!dev_res)
+			return;
 		add_size = size - new_size;
 		if (add_size < dev_res->add_size) {
 			dev_res->add_size -= add_size;

Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5F472795;
	Tue,  1 Sep 2026 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252523; cv=none; b=N64Am0A14FavS7YFQe+ITQkGbHcEvDNGV50ntr76zpXF+slWdbfmUv65fELFOX7d5hq1wsiEvRD5etS/kNQv/UBJMh8kWwq8sKnVzPRdpYokgbdcTXzaojLdvAYIDwEn+KwrbA5SneD3SPSnTih6vorCQqrRKj8ZVwbC3blUEKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252523; c=relaxed/simple;
	bh=Wk5sEMb9LINLsnrda5qnSjDz5LAieS2TldfVF54QzsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dhx1NW9U7iskw37xKAaCQtY/LOiEQlo5wKjFf3LKUleDY+SEH+GZpd5I+o+1K9yP5z7MkrzXt7AR75Bv8KPhy0Nkv2oyRvZ8099dEf2FPT/Rbt59GR8ckezNnQnUVvbFDN/QrRrnnXuxIByViTj1hZmlOkJ92PK67bX2+KdMh1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1788252492teff1807c
X-QQ-Originating-IP: +RBFOTE4CvCvzCH75wZfmQq0Q2Rd0B2ygPN1I/8A7oo=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 16:48:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12533345009795839515
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Tue, 01 Sep 2026 16:47:54 +0800
Subject: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
In-Reply-To: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4411; i=sophon@radxa.com;
 h=from:subject:message-id; bh=Wk5sEMb9LINLsnrda5qnSjDz5LAieS2TldfVF54QzsA=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJjo35nxOY5ev1n+y+NXrkm8hi9RnvnNdnPRzwx72r
 sPFoWl2HaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACayIpLhv5vUeZPda9f1/b7Z
 FhYWWN3b9PFxYtj9lys/+H+4zLYjJpqR4ZTrcymxBRJ9dbVxESuYNBWnnNykN9mub8PjT78OH5n
 zmg8A
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NcVNg4YzPDc1xazVUX7u7R2D/hjsw+p7gtXqp1Yp0D8gsMLJM0ynnDmM
	lPWRmsH5fcE1/7K8dgx6KQvrv55kIaSLJI1CHnTvi3W7fk2x6gon6N0/CUfuUy9i6GqOgEk
	o1HH08rR7tt32TLyec9gG3zi5v3rzWG4oCjV+GS30fOWrORQEiTFAa29s0Zjkms68Q0DSTB
	bW3duGeky4rHRzdKaPOMvoy/SLwHIHAQCYuYONTk8NeSWoBKRIw4PqmirqxpdL/dM2OWz93
	IydQHBW/4psIv+412e83lnimt8zyJ9WTsauc0/8QPrA4XiyP0bmF8zE4p0O7cmw7jo/lrdi
	TiIyKzXLil+qbajJkhr1ZYMbR9r5AfOjFEDAyoIx2Kxcg75ioAnZRTYnAsrHUZq2TXnRvfM
	Tyw81KBGqFAZvB6qJhl2Eb6IOyHG9UfbvtkCBpLi+diPLr/hFFPNwL2pwL/bTSwKOb/BB44
	+eRbqZyUrKWx8xXmHNfYNslJjjxCvPF02mUA500rHLp+BkazFY9WzQ0n/rQSdddafyQvTO5
	ZSUAcF+pz9hJO8kPMyi6sWhOLWuZron18J5ihw8fHwufDHrD2mkcBhtsDRe/TfW0PQJgMB5
	hTBrhoKtBSNQCUf8E9Gc4ECU97+WWyjUbyC1QUAQOWyCUd+ODbO3kPoElk4XwXInAwYveCs
	n9Utj/NaJP9liRcwWpTVnGMnH9CKTVCth23JNIXnfHRdqn+fqqyVqZIEsAkkf5lVDC6Bmrw
	VCCGTWLfzB7uNdMii90g0ZDqSSMAaI5oZk75JjpKWg/nlVyjQcTBOiRNt/3vgFVEtLYhKH+
	BNUUCvT8yd2LjVPRVDBymMQ7wBZ0CrOsBPSoz2gFYo7KH77kQnlepGvRsVmbinROFnSbHsG
	ULSdsNQT3It2bi/wUVeDw1SlO4DS9I0PJDHGDWn7Afuh7/93dLCPYjt4RiN/FZnx4sq78eC
	FvmSPeMBMfCXB1ciloD6NEpW7Mg0Ofqn2a7qCgWtNXYqdKA7ICO9SSFDHYYSdpa0n6PNjLx
	rborTfA0Tt9o7A8M1QPf0g1FIHHQWSRCJbJZbMHCLPOAXMqxOMSd9Tgjp2xDi+0hNoP3qxA
	f3HqozXluzgdNbt38AvIfY=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

The TC9563 PCI power-control driver powers off external downstream ports
whose device tree nodes have status = "disabled".

On the Radxa Dragon Q8B, reading the Vendor ID from one of these
powered-off port functions during PCI enumeration raises an Arm SError
instead of returning an all-ones PCI error response. This prevents the
board from completing boot.

Commit 1a8c251cff20 ("PCI: move OF status = "disabled" detection to
dev->match_driver") made disabled PCI functions remain discoverable so
PCI fixups can still be applied, while suppressing driver binding later.
Preserve that behavior for endpoint functions.

For an unavailable node describing a PCI-to-PCI bridge, however, the
node also represents a subordinate bus that must not be enumerated.
Check the device tree node before reading the Vendor ID and return a PCI
error response without accessing config space when such a bridge is
disabled.

Functions not described by device tree and disabled endpoint functions
remain discoverable.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/pci/of.c    | 27 +++++++++++++++++++++++++--
 drivers/pci/pci.h   |  5 +++++
 drivers/pci/probe.c |  5 +++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index a51dff91b196..37e9062065d7 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -24,8 +24,8 @@
  * pci_set_of_node - Find and set device's DT device_node
  * @dev: the PCI device structure to fill
  *
- * Returns 0 on success with of_node set or when no device is described in the
- * DT. Returns -ENODEV if the device is present, but disabled in the DT.
+ * Return: 0 on success with of_node set or when no device is described in the
+ * DT.
  */
 int pci_set_of_node(struct pci_dev *dev)
 {
@@ -46,6 +46,29 @@ int pci_set_of_node(struct pci_dev *dev)
 	return 0;
 }
 
+/**
+ * pci_of_device_skip_config_read - check whether to skip probing a PCI device
+ * @bus: PCI bus to scan
+ * @devfn: device/function number to check
+ *
+ * Return: true only when firmware explicitly describes an unavailable PCI
+ * bridge/port node. Disabled endpoints remain discoverable so fixups still run,
+ * while driver binding is suppressed later in pci_bus_add_device().
+ */
+bool pci_of_device_skip_config_read(struct pci_bus *bus, unsigned int devfn)
+{
+	if (!bus->dev.of_node)
+		return false;
+
+	struct device_node *node __free(device_node) =
+		of_pci_find_child_device(bus->dev.of_node, devfn);
+
+	if (!node || of_device_is_available(node))
+		return false;
+
+	return of_node_is_type(node, "pci");
+}
+
 void pci_release_of_node(struct pci_dev *dev)
 {
 	of_node_put(dev->dev.of_node);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..7cb1d04d947d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1244,6 +1244,7 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
 				u8 *slot_power_limit_scale);
 bool of_pci_preserve_config(struct device_node *node);
 int pci_set_of_node(struct pci_dev *dev);
+bool pci_of_device_skip_config_read(struct pci_bus *bus, unsigned int devfn);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
@@ -1284,6 +1285,10 @@ static inline bool of_pci_preserve_config(struct device_node *node)
 }
 
 static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
+static inline bool pci_of_device_skip_config_read(struct pci_bus *bus, unsigned int devfn)
+{
+	return false;
+}
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..ce29bf78a6f7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2586,6 +2586,11 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				int timeout)
 {
+	if (pci_of_device_skip_config_read(bus, devfn)) {
+		PCI_SET_ERROR_RESPONSE(l);
+		return false;
+	}
+
 	return pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);

-- 
2.55.0


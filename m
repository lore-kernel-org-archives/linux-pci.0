Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960B41C2FF
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131671; cv=none; b=VT0Qq1DsXNcL8oHuNW2CD0ooyRZnSHJ0fOql6NlLN59mclJbhVSAGtF5fiFO/zzfTP99Urt+NzdsKjLGyrpgJ6LxxDccv1+T0ZIK/svILAqn+QoDkXtFSEtQlhjv/IaOXc6zQjbE2GhD8bIQ+kCeobXq/VgDyaj6dGDnp8hYUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131671; c=relaxed/simple;
	bh=hYodWpM6Q4Tyn72orHfZl9z8/Z+iKh5TvYtYdhoeo6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J63osM4x9Inaziq83+J4LLcBh+ZXINF1gQjKPoJ2TBAo5pLVRmISelAv6pEd8vZ4cnBBiLn5i9nAnwUEgEocCK/FHDfZbgjvgDl+ixn0UHYeCeIw8/xZqs53v3bT6haxCssCdfw8vwG9Z0xhLhRkfv9Zlhewp/Y3AaYcu64aVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=WrPWGZVk; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="WrPWGZVk"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e53581361so207873785a.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786131668; x=1786736468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lvk5a8L0OiCM9CkB/Syketa1Mo3vqjoq+QWQ6ts5wyE=;
        b=WrPWGZVkXdqWXBz/ZklA2m313TxQpGsFomwzA+KqIivHpisMQ+c0er2tecJsuUpYqQ
         xzaRvDAQPcz3ieP5KOevdGVxnLnAvZp2xk0KtVKRwsmzJvaA0Zl4s0BogOPFqN81wUXk
         U+zVGssOl1NPJtzrMPXWVUx2dJwd7H96Uk7Xs0MrhZt0VkpbSg6myjiJlopsBDtCdysm
         MxrK+YrthLb1AB+/HtEx0TFsThgfaCHM7KDxe2GcKwygjHJG5cqQo40AozQp532c25Eq
         Fd6P/HrIAK81mq0sY05iPYiP0qzVBPStYnsjC+SgQX94CbpYN41u+u4oi15ENScRB3V5
         /o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131668; x=1786736468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lvk5a8L0OiCM9CkB/Syketa1Mo3vqjoq+QWQ6ts5wyE=;
        b=dXgwyMBn8WMqBheNuMLUlfFU3L2duE8p/Qi1ESIqOnB1PgydDzEtv3JcYRQww7aAtY
         2bKP00H/CmSHcgSuNFajCLgmWRhkQ2m/yjdu95s0SPxN5Awp2ZVspI0zP/BFjkifrwrU
         84C8iUZUoaRiE8KwB8TMA0uVNMJrMrvTnv5Zh4k9kMTSzFghU/fLRI/r1B1cNgmUDIoW
         yQZckjAkBSPC6f91X3KLRQYbLgQsYOMTQn3ItFeuZ7XlBCWHIdyelfR+9VgoaGdDhbgs
         5pDcb0ARTdkszPtp/xLjWh/2Wg2NuPfKBEStdAPLnNKPxojy3H9DFLZeuMH3GKfd13WY
         B4Kg==
X-Forwarded-Encrypted: i=1; AHgh+RoVpPyfw+C7oTDVm+ZJgNGbIMen2SviFyVwAC/5gzSYjfyyjSTbiQAWBIYPpgRcooVo/6Pdh7Qo0os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/c8gs5dvSRXeM9NfFMRtV5Lpi5GByZqyPdJj17QwjMuTgyT1+
	Z7dDYo2vhKysQ/FwiHLchR64twwA5swtx+bdaYOx14t/KUvbTD3mcX8nfaH5u2i5eps=
X-Gm-Gg: AR+sD10Ghnun1tP4mRJMvB9UmYITBVX0TFFpWFGY8dyVC4x+dzuB0iZryF4VyXRqey+
	BLpJAKY26dN80K7DbswGhcExZkMLELUHpcNaPxno8UopNrhvuPcWgqMd0TOxTRPg2O3C3J1EvqB
	vfEj1OS9LmEXzEe5GJJRH0w1MWNSDMmZOGblJzxHiH4UK+749+6/Sgo9WwrT/V9ntBnyBU4uIKr
	XqMFzKq5BKU6S6e4l26byIvtWYjARZdldQgz6yUbHK5FNDNnBA1pgJ7KRFjIF/57pExgTvn68rW
	jnn6ctJN9rBLPEC4y8nf+gPX74ZbeWK7GvyYZXEOq3QBtadR6JtUvXsetAfHX/Y8vVImrdma+Mm
	y96xyNylBFYjaHK4djxWIjYneO5G8kjCvJbw0pbXixoCk93JjsJKyToSmvEujN1tFKiewspJB/R
	EryQE6kZK3G+1lvz8bSY+ortTaPyDoq8udgZ80EGSmu0Z7fcHq1sbx28GANiUShmXp/G8HxSoOp
	Bc=
X-Received: by 2002:a05:620a:2616:b0:92e:4927:1ff9 with SMTP id af79cd13be357-936491302dcmr2831301585a.40.1786131668128;
        Fri, 07 Aug 2026 12:41:08 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03aeadsm219786585a.3.2026.08.07.12.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 12:41:07 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] PCI: of: introduce of_pci_verify_node()
Date: Fri,  7 Aug 2026 14:40:58 -0500
Message-ID: <20260807194100.455599-5-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807194100.455599-1-elder@riscstar.com>
References: <20260807194100.455599-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 407d1a51921e9 ("PCI: Create device tree node for bridge") linked
the PCI enumeration process together with devicetree, creating a devicetree
node for discovered PCI bridges.  Its successor commit ae9813db1dc5a ("PCI:
Add quirks to generate device tree node for Xilinx Alveo U50") shows how
to use a PCI final fixup quirk to also create a devicetree node for a
non-bridge PCI device.  These changes allowed devicetree overlays to
describe components downstream of a PCI device, by providing a place to
attach the overlay.

Note that the dynamic devicetree node is only created if the device didn't
already have an assigned node.

Later, commit aa7b4bbcb3a1d ("arm64: dts: qcom: qcs6490-rb3gen2: Add
TC9563 PCIe switch node") *pre-defined* devicetree nodes to represent the
PCI device nodes that would (also) be discovered via the PCI enumeration
process.  The devicetree node in this case is created with the content
from the DTS file.  So when a (host) bridge is done being initialized
during PCI enumeration, no node is dynamically created (the commits
mentioned above do not apply).

Ideally, any pre-defined PCI devicetree node would contain exactly the
same information as whatever the dynamic creation process would produce
(though it could include more).

However that is not the case for the pre-defined Qualcomm RB3gen2 nodes.
And in particular, the endpoint (function) nodes include this property:

    device_type = "pci";

This is simply wrong; that property is meant only for bridge nodes.

Rob Herring requested that a runtime check to be added to spot this
specific error, only for non-bridge PCI devices.

(There are many things that could be verified for statically-defined
devicetree nodes, but this is all we'll do for now.)

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/bus.c |  1 +
 drivers/pci/of.c  | 27 +++++++++++++++++++++++++++
 drivers/pci/pci.h |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 655ed53436d3e..679afbc6d3109 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -351,6 +351,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 * are not assigned yet for some devices.
 	 */
 	pcibios_bus_add_device(dev);
+	of_pci_verify_node(dev);
 	pci_fixup_device(pci_fixup_final, dev);
 	if (pci_is_bridge(dev))
 		of_pci_make_dev_node(dev);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 8b18c4ba845cf..b51bb14857e9e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -663,6 +663,33 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	of_node_put(np);
 }
 
+void of_pci_verify_node(struct pci_dev *pdev)
+{
+	struct device_node *np = pci_device_to_OF_node(pdev);
+
+	/* If there's no pre-existing node, there's nothing to check */
+	if (!np)
+		return;
+
+	/*
+	 * Check a pre-existing devicetree node for errors.  The PCI
+	 * enumeration process gathered a lot of information about
+	 * the device, and ideally it matches what the devicetree
+	 * node says.
+	 */
+	if (pci_is_bridge(pdev))
+		return;
+
+	/*
+	 * Currently we just verify that non-bridges don't contain a
+	 * device_type = "pci" property.
+	 */
+	if (!of_node_is_type(np, "pci"))
+		return;
+
+	dev_err(&pdev->dev, "\"pci\" device_type NOT VALID for PCI endpoint\n");
+}
+
 void of_pci_make_dev_node(struct pci_dev *pdev)
 {
 	struct device_node *ppnode, *np = NULL;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c1..6c19895c14914 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1265,6 +1265,7 @@ static inline int of_pci_get_equalization_presets(struct device *dev,
 struct of_changeset;
 
 #ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+void of_pci_verify_node(struct pci_dev *pdev);
 void of_pci_make_dev_node(struct pci_dev *pdev);
 void of_pci_remove_node(struct pci_dev *pdev);
 int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
@@ -1275,6 +1276,7 @@ int of_pci_add_host_bridge_properties(struct pci_host_bridge *bridge,
 				      struct of_changeset *ocs,
 				      struct device_node *np);
 #else
+static inline void of_pci_verify_node(struct pci_dev *pdev) { }
 static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }
 static inline void of_pci_remove_node(struct pci_dev *pdev) { }
 static inline void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge) { }
-- 
2.53.0


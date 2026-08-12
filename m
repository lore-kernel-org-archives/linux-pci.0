Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CE47F770
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555387; cv=none; b=M8z+FPi1PR5AdF6zpMmC3/WthV9/gITIq2CP8QDJrOY1nwzkjK0l5Bhda22S19R4jK5I4Ug4BXHpjUJv9jAmJzRu0hREEwz6GF/wg0dFwmc/k360JojdmCcYgdtgnzUtdpU1ds9EjJX3paIvc3cXhBAw9O1p0f4Qb6T59AAx9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555387; c=relaxed/simple;
	bh=mPn73CqzfrdOvjuc2ohN6xC//Fl39RO2mkY8Ijir1Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvO+HzwcTkVylRhUsdyCJK9fGKR4tOzDf3iCbVPh7sNWWNGSSv0LKN0ohWSoQjM1CJYWzBUYXLFkbJpOAmshrV/FXa/v1OvY/UHE8aa9UJzK2Yl644Ytcu19lhswCN3QEL7utLpvgGClgVA6tlGBVxjMvyTG+nDstCK+iPrjM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Tj5YEt9g; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Tj5YEt9g"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-934944f2d22so88262385a.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786555379; x=1787160179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3K2YFyPbwee3TOPI2L++unR/lM5wpp/EyOEokJr7A+U=;
        b=Tj5YEt9g0cbsLqAdp6LjKTPrlJKVAxLH95aNmoaK+AGXsOHBVentwmaElh+9tDBtoU
         fUT+dLlJpBZ7TCZYCGUbOHtGbtJ+Gc2GEju5ydJbrsuyVqxs5lu7ankCuA2Vkdv+dU9N
         VciOiOeEsJ0XVBdvbFJVvMe07Y2rFbppJoyIdl00pAvV78baD5oEauVejLpRAwszDGVa
         HPXfr5BDn3ewg9uHIJx8v4PfWkShE7mW5HJH4zv05LvJ0NzsG2v7zifRcrr4B2jrSXW1
         VyIX82yo/OUrNML9yYmySdBhnJaHahw8Aat6v0mkh+JQbRqLeNBCWzuc3YmK6Qfj7Cqs
         AIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786555379; x=1787160179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3K2YFyPbwee3TOPI2L++unR/lM5wpp/EyOEokJr7A+U=;
        b=CIIrWMC1R9AGPUp5kx3iZ1JRwLrvTFSEFQAwHOfgFjgGv322yDqjFgzmW0SWzrUNa2
         Ey6i3CoJXlkWucGRGS9yAwpYBz7xbQzHv3ICT1X6IeWVwDjPV4RJFFOsclNS+ITBAaOl
         lQZgoafC2ALuo/+/0Bll2Lidshena4E4/fLO+oe0tpTG11fax79ilSrHNiNY6IsNhA4K
         Wxo6W+ZN0aKo6/RhGbJ6L3hITneCACPCqY5MvPMvb3LqNoyLlpcsGI9zTyQMkPD3be/X
         XDdV/0A4UY4938JikywZVYG8BmInDhVpwpu64ISuTAKZAhJHwaqdMayojPkDw3lst0pz
         TFbw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/DHczcE+qcEZYel6GVWX2bIWwgSYsffYWp+gEsE0UJUfHFfj64lFJumFd38TrVqtcCWhP5PR47UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvkIfQaPRfRLtJvUAtUNinT5nGOydSJkuYZs+YXjJAsWuX0aFc
	6kcKBsCLqzGS+f220a7PFJw90xb3RpcauVRhcTOomBAnW0Zdsn2SZ6t5ARLCS8iivSZMyWWAprm
	2L27jGYk=
X-Gm-Gg: AR+sD12icpHrA806//loVZ+SiUstMPtweAbbnhnmG91X/xylQDWM3X42allx9348kvK
	dFgcCjepx8zrOAVRNFRNVfcSBaoVLzOO5WtGmV6x4ogJ683bBkpJlXX7ku61NsIhYXXohcyCwAA
	KkaAkt2Ef6cAf3twi5co+FPIaWjsTnhYZv6qJrL/cv4u9gRqBGlgi3Y3RrxeoM+8ynGi6oM6Tbu
	shwMG6mCCDpO9wHvrXHMalIuFOBKOTa+UwbaQIe1wS6XEps/nMOfLGm2jKgdI1sqE4XySP9tXkl
	Q9NlzEmVoq9Qg+N53GugK+aGdoAOBPGd6U67njdDgP6pOlyScGexpx2SqvuzTGeST5CZJBAIt3b
	n3RL8svl3YFJ1vKX/WoXM5g4DQDOtD74P7YkLC2HdAC1riQPv9ORC9WVCM8KsUASd1S7w/TCijk
	JzT7sPsOXp16MebZECWWLdI8mc58qznHGCXgNtKKSaSQRzxoBreptKKt4vmkafXu3FAg==
X-Received: by 2002:a05:620a:a718:b0:92e:535b:e08b with SMTP id af79cd13be357-936b3d68c02mr526104385a.33.1786555378959;
        Wed, 12 Aug 2026 10:22:58 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5f720eesm173587685a.47.2026.08.12.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 10:22:58 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] PCI: of: introduce of_pci_verify_node()
Date: Wed, 12 Aug 2026 12:22:47 -0500
Message-ID: <20260812172247.276554-5-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812172247.276554-1-elder@riscstar.com>
References: <20260812172247.276554-1-elder@riscstar.com>
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
v2: Verify even if PCI_DYNAMIC_OF_NODES is not defined (Sashiko)

 drivers/pci/bus.c |  1 +
 drivers/pci/of.c  | 26 ++++++++++++++++++++++++++
 drivers/pci/pci.h |  3 +++
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
index 8b18c4ba845cf..0bbf1a915b7d2 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -1006,3 +1006,29 @@ int of_pci_get_equalization_presets(struct device *dev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
+
+/*
+ * Check a pre-existing devicetree node for errors.  The PCI enumeration
+ * process gathered a lot of information about the device, and ideally it
+ * matches what the devicetree node says.
+ */
+void of_pci_verify_node(struct pci_dev *pdev)
+{
+	struct device_node *np = pci_device_to_OF_node(pdev);
+
+	/* If there's no pre-existing node, there's nothing to check */
+	if (!np)
+		return;
+
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
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c1..88dde67bd60cb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1205,6 +1205,7 @@ bool of_pci_supply_present(struct device_node *np);
 int of_pci_get_equalization_presets(struct device *dev,
 				    struct pci_eq_presets *presets,
 				    int num_lanes);
+void of_pci_verify_node(struct pci_dev *pdev);
 #else
 static inline int
 of_get_pci_domain_nr(struct device_node *node)
@@ -1260,6 +1261,8 @@ static inline int of_pci_get_equalization_presets(struct device *dev,
 
 	return 0;
 }
+
+static inline void of_pci_verify_node(struct pci_dev *pdev) { }
 #endif /* CONFIG_OF */
 
 struct of_changeset;
-- 
2.53.0


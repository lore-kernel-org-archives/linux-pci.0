Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D54A2A44
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529579; cv=none; b=Bf3WDqyzTOoxzZ2LochrsTUTsvMTDEVQNBSTXeak+fhPJLbKFEEP9EH9hUttzRlApFm6FeivGART7JT8DBXbw54Wd6qqmb9aA1reUtK5t9sPK0O0pknFcMECjJt9gC20iOm8GRSuyE3y87pBUSJW3SZWLiZWjw7yLJXFND4qQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529579; c=relaxed/simple;
	bh=Umf4Qux19s/oJdiljE5afHHlwKfEF4F/L07jXGmhg5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJPX1RGJD6Vag+36bD8DZrnVrU5Mu9iR/o/b1GpwWnW4L5EAynrydqv7krGW/caMpsGKqMC9KoCqTT0ZL+nULKvmynxj1XQ7XvNT43iow7KMffFZ5/qgSlKubtuzs/K3plQ+H/W3wedfGslmiyi/Nsg5OwU1MF8goHU6PV68f+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=od7KOlCU; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="od7KOlCU"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-936c02e58dfso103697785a.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788529576; x=1789134376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8jU3bHZExWtt76MVfRZM8b738CbAPfC/obIJMlr2jck=;
        b=od7KOlCUXER52aiYLdNLdCgjzgIiLaCRwI8NiMvJGVZ9oU/dBRLjg+Jvz5dqSsyKQr
         yN5zylq0tdVfYALP5KLWiFy9FKthCXeAy7twcABhvoFEtGWuX7TW0DDFZ/D9+/sL06oK
         d6tHTTVhMdPPJBoJ4kU/o9hFt9hqmtiIN3jKmx5VQqZeywAIXTYUd1sM7VlEuASpXUPV
         VoneooKXEiKSz9sj1mYU0cKyD9/8H/ar91tQ/iO1I9xe0td9kCYN3RtlF0GFzfGpPP8M
         +U8g7V0E8x0sSMi5Zag9m407UhkL2mVbFAYPn+JtgNHZm4ts4spOdVvVpHHkuhtDhpaX
         KRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529576; x=1789134376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8jU3bHZExWtt76MVfRZM8b738CbAPfC/obIJMlr2jck=;
        b=ZwHEwE0cXKAYWMu5tSqaRzZummu6H/L7h/yi6MzhLLymf38D0XYzlWAaqYMQ2jGVJz
         XDybmNxinJfeaymo48NYXukMV+6jBZjsr4KwoQaI3SNdKollE94C4AKu1pq+4WVBGNuL
         GxEqjAt8L/G4lYhNhEtKomYMhvgk8GcDcOr5QzfQYLypC4EIb+ipkV8oUEtDrjdE2rSM
         PeM840R5cU+NJf7CbWMhFJ3FM7STSvj8oED8DlzIrGlmBfeja0Aqdwt0LvurfWuaZyPt
         FRYvGuM7l99kSkg4udxcszGa7g37q4F6tP7M2eDeJlcW5fCgLrtbctXq83dUFLD/WelP
         awgA==
X-Forwarded-Encrypted: i=1; AKwUvByyfZteuINzV9urasP2p1szPkVN5MnBwux3C7DJJaD4hi0CeX8ppwuuKpQkPPcfz+AY+Em/kB2sRPU=@vger.kernel.org
X-Gm-Message-State: AFuF++n5l41TnC+vM/K0OtTmXyKTRI+pbQxi4HYYEcyeJVf9lTm+i8hg
	PBrLHoHZzriroRuRoxd5lAh6mwoOujYehuNJ1r3YN3orkxbxquYBadUdL4vEnCfxZ2g=
X-Gm-Gg: AYBFou3BAeYtows1eZsDa8VCjRYTtHYqvTps7spt92bHTDOLyxrqGzQAQXNDzXwdIlh
	nnSeHauHjFoxfzt0+/5hdn+Rk5l9Mt46H4pE39qMwHhjYCfuWAH6YLkDiPeH55gztYQ345KbJCB
	2tz9ER4P+1XaxVo0vLyu9Nss7/C3d0PVf0Va+ICZnVJW2W++Gx7p32csEwWad4+91ytkabKw0z4
	2XnuKVQDYe2CWsN1KjEYDT6zB76IxH4XJGeZKm6ab8nTg6O+3GIcvIDseV9buY1PJw4+9vUhitm
	VVnSFaHZYiwaKSpBCxWjQQtojUNxnaF4DGWwNDBS2VXr0IuxLnbYIkRPZQ2ce9Mn6sr6zX9mabX
	imuiJG1FRu1yS7Fq+X12SXVaObnjanWwKRwuJMRJMNkLHTxA/jh2dOCNMddRJhFm6wTEPd24+3G
	VmYR2vGseRL/T5xG5Xu1KOliV8VdAQWdKZpIpBHcSnNebLp7XQpRG+M9sPTCJQ0ybt
X-Received: by 2002:a05:620a:8201:b0:936:499d:9504 with SMTP id af79cd13be357-939803443cbmr424763285a.14.1788529575649;
        Fri, 04 Sep 2026 06:46:15 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fafc3a7sm211613885a.14.2026.09.04.06.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:46:15 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org,
	saravanak@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] PCI: of: introduce of_pci_verify_node()
Date: Fri,  4 Sep 2026 08:46:06 -0500
Message-ID: <20260904134607.1856121-5-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904134607.1856121-1-elder@riscstar.com>
References: <20260904134607.1856121-1-elder@riscstar.com>
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
specific error, only for non-bridge PCI devices.  Herve Codina further
suggested we ensure that bridge PCI devices *do* define the device_type
property, with value "pci".  We also accept "pciex" as the value of the
device_type property for bridges.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v4: - Added "pciex" as a valid bridge device_type property value
    - Added Herve's Reviewed-by tag

 drivers/pci/bus.c |  1 +
 drivers/pci/of.c  | 32 ++++++++++++++++++++++++++++++++
 drivers/pci/pci.h |  3 +++
 3 files changed, 36 insertions(+)

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
index a51dff91b196d..5a040ed836744 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -1085,3 +1085,35 @@ int of_pci_get_equalization_presets(struct device *dev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
+
+/**
+ * of_pci_verify_node - Sanity check some PCI device node properties
+ * @pdev: The PCI device whose device node is checked
+ *
+ * PCI enumeration authoritatively discovers what we need to know about
+ * a PCI device.  A devicetree-based platform will represent a PCI root
+ * bridge with a node, but otherwise devicetree doesn't typically include
+ * many PCI nodes.  Where such nodes do exist, experience has shown that
+ * the "device_type" property is sometimes wrong, so warn about that.
+ */
+void of_pci_verify_node(struct pci_dev *pdev)
+{
+	struct device_node *np = pci_device_to_OF_node(pdev);
+	bool device_is_bridge;
+	bool device_type_pci;
+
+	/* Nothing to check if there's no pre-existing devicetree node */
+	if (!np)
+		return;
+
+	device_is_bridge = pci_is_bridge(pdev);
+	device_type_pci = of_node_is_type(np, "pci") ||
+			  of_node_is_type(np, "pciex");
+
+	/* Bridges should have device type "pci"; endpoints should not */
+	if (device_is_bridge == device_type_pci)
+		return;
+
+	dev_err(&pdev->dev, "PCI %s have \"pci\" device_type property\n",
+		device_is_bridge ? "bridge should" : "endpoint should not");
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc23..2e33d3bd4b0ba 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1253,6 +1253,7 @@ bool of_pci_supply_present(struct device_node *np);
 int of_pci_get_equalization_presets(struct device *dev,
 				    struct pci_eq_presets *presets,
 				    int num_lanes);
+void of_pci_verify_node(struct pci_dev *pdev);
 #else
 static inline int
 of_get_pci_domain_nr(struct device_node *node)
@@ -1308,6 +1309,8 @@ static inline int of_pci_get_equalization_presets(struct device *dev,
 
 	return 0;
 }
+
+static inline void of_pci_verify_node(struct pci_dev *pdev) { }
 #endif /* CONFIG_OF */
 
 struct of_changeset;
-- 
2.53.0


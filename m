Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE26498911
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903311; cv=none; b=p/Dignpt6lAzssBPdjgwXZ4LhuKuaJVlw+UP1N06kSCYUI9ssadlDfCBmxusI/s+jaLTzv0ibsiFUraWln0XV60lTSdWuMlyKh/CL9j81kT4LJao5PU8gA+orJ10njkJKV1W3N9naOSa+skrk7yyq/CcAwsITURXfm5k33XDneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903311; c=relaxed/simple;
	bh=1F3EiIo11jnrR8LsMQza9ZGSJ9SjVCrnkOQSsqUAwJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6dyFO8D6knEOuXzS5zHQ5VziAGJnxodtC6AsePeYE9iKKyMW9INzPF2IrOJmYMgC5i64xrLRtXw25a1Ufe2Ny+lGCw+am1zrPnoSpt70+FnC16aP6o43YkEp5/s6ZD6Tskyt958+89jJpP2duJoP1gNnVxLzVvHieR12n74iG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=nBpu8UpD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="nBpu8UpD"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9399798cdd2so226760385a.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788903308; x=1789508108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HE1zJOd468NvVHPcCax3V6S6Z0+9RulSQLUiQ0wVkKI=;
        b=nBpu8UpDl873Dqe4zjStxqCzK0TLQGiVVopSfCQE155ApxpGpebYL8gWKjt1omQAYd
         LB4VOPu2gaOiOmVwDy8CGEVXDHOSBZoKzGuNduBjeM+ulM9AhBKWfo0C64pOqIFp6YER
         9rFR+PuDUYuyOS7krRU1J5keuBRscCotFLRIPS8rXYTS0joAx9FjJMuSaKeO3FgQoHqM
         TQZKrrz8vKk1NqScJgMGdgQmsk8dEyCaPbZOFGWTbI4ZRu1jwrR8WfSWOOAadT7ZSkB8
         1EuY8e8Oh/kz2sYVNon/lAZuZHHufitWl+qRV77yla2lYfFijHqep9N/Fk6K69iJ8dEB
         cdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788903308; x=1789508108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HE1zJOd468NvVHPcCax3V6S6Z0+9RulSQLUiQ0wVkKI=;
        b=oPA5MbxwjIZypP0zq+++HUccrSvK5out10aYVgcFFjBi2yQ08P2L6D6cIilAPTlp2l
         hnVS0ZTtMGDplsggYS7RT3Vj5x0eQGDpJ36IK+I835tau6LLbM2mIzmKByJEEZSsL/bX
         AHscmdU1AKiM0DwQ+xXaysNLZk6E64swwd5d6VSe2XL316QgfocAa1/K1TVJdfN+Njtd
         smF+7Csu2+lGQA41pUVhF9BK8J2Q5gXT8XzsyIVCrLDuJK21qYStwbEiQMNeS04ha1qI
         qFWVQEKWgzTiV5TKkBJIvAp634NFM36aGM90fap9EUg4MDIs0bMKa53UPvsIwTlob8Tg
         hkgg==
X-Forwarded-Encrypted: i=1; AKwUvByKm9yB9kmOSr6OemTWud/hx7WuHnn5sqV4+ASv+z8fF9iiXuawGQ/TsPazOc0eStEWJ2C+rly7XVk=@vger.kernel.org
X-Gm-Message-State: AFuF++kJ4YsxAEq82akh9kaMqfN+lefKaFER5qujAoH8XOIyOC75tZ41
	kd9T/ZDEFh2rPkndmog3Mx6luTNrbBXSnj2vc9sGIqpz24ytW797+/giTgt5PEH/3ZE=
X-Gm-Gg: AYBFou1Qv5DqfrCDXRa3qjnpnyqXmBgNj5HMdtNgObCJ003JD9UjloTQ4UxF0Ri2Zn/
	pCNtzWJP0P9kRRmvGI5DnRPDyTZHX6kVDn2yKVn0gXwEM31zwDHR3yO1sXkEhArXu0lEYwxGDiS
	lZKA12i86+f4uFeZCIWQyf2reaaptKLC7sK4FsXZTlrMg56aNI7xSbHKd/wYWV301henh2B/vGm
	VDrkOGH4yXimbdb+0SWA/95H4pV2ryjEt2YQytT+8NxOhKo1Cw+n3OjiUV2BMar62hN5Qy5pinK
	odj9+dxci98UqAEzCUiPqbZr0/IwNnGrs5vgigTwPh4DMNZDNr7UdHbw1R8LdfK8nmcLsnbao7z
	+VYxZeNHnutDG7CeBeqtjvvO2pxcSFBFG86LnA9cIxZUu5+BY3cIkmAohJmqanHScF325QdzISX
	jhmKVTfSqHKsrgHVvy2YgjFQ4pGVC1wFAH4pETkC2tHZVCZX+bH/iMw2V/Vj7nyMChkJmQ4+THR
	u8=
X-Received: by 2002:a05:620a:290a:b0:939:ca4:4d5f with SMTP id af79cd13be357-939803240c2mr3342092185a.5.1788903307689;
        Tue, 08 Sep 2026 14:35:07 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9f0734sm1250497885a.4.2026.09.08.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:35:07 -0700 (PDT)
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
Subject: [PATCH v5 4/4] PCI: of: introduce of_pci_verify_node()
Date: Tue,  8 Sep 2026 16:34:58 -0500
Message-ID: <20260908213459.2519059-5-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908213459.2519059-1-elder@riscstar.com>
References: <20260908213459.2519059-1-elder@riscstar.com>
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


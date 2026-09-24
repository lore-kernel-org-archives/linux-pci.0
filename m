Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5C49F11D
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262157; cv=none; b=ksXv7dSasFXLfd+NpB79XJ0uFOGZiIquMePrTLoMNzkjP+HMn4/qlkR7ATSJoGBgjJBcSN+0bv/BVzjBsS39mC1fTlZY7h92kNOj4D9vRfqagQPq+apt6LJYeQprvtbCOw8SBu7RNoWctt4Gv/9RHYCqlO3JvTM2NxS+Nw+j3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262157; c=relaxed/simple;
	bh=X1KXs+i5uL9uwAw7KV41qBYIJSZ3+jEh3Bc9Sxzdsps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tbi4yFSIF+1MdjPTnZhPpc3axKhnlKazcKXIffeYYMgkqSJJJ6IiGpQvPhy1RV6jBdePr+/iHdfI5CJKCY3nB9sZ7psYhJUoLaTxjJ7nwyi91NO4lYZpg73loWdaEhi2nzCj8Yyvs4fJBj5f55eOlAXaar8gtZyigIvQAaY+TU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=xhDNwbl0; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="xhDNwbl0"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d8a00bcdso14777391cf.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790262152; x=1790866952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLSKarAZusXR0W9CXQ8qq3Qvo3B/rbo6r97R+Zk/6MU=;
        b=xhDNwbl0jSobv0z6BMv6cqJkaf6/0KFlt69f/TFEt9uju+7arJcP0/mQE1rFure/+G
         RSpckLxPez+IPmN2AGJLxF1uGJGUTTb4HU74FIYZ8XArPtkDN76Y40fztVKRzZmT4s5O
         Cnsr4VKKtD72gGuFngkNPMYoOt4XBFG0bFl7CGgLjaZRZtPk9c7770LlV3jHl1k6BlqQ
         8MP1mAJZ8QRzp4/GrSmD1H3Nw5VDlNAovGZVqN/X9uZN08Wobj+pGOtngq3t9o8pl/6o
         iNUL8wNxaos5rQWT6+1Zj7hmuzaE71zHmcbknoGqn+ejck8TmCKnW/up5rwzQ48tCLME
         oJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262152; x=1790866952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fLSKarAZusXR0W9CXQ8qq3Qvo3B/rbo6r97R+Zk/6MU=;
        b=GeUyPJMk29rSva/fBXNtKy21zv/snly16AcLAwOr1q7U2aWeDG6ZKBtHyWMw3AWyMV
         ybrVmmet+/+ukr7qVB/aX+BOdL00eShnKfT5H7GyYysuhVgLPVql7GCgXoW51IDr3yfp
         dZgKyot2tZwek0K/wZAeg96w2/m5FRNVKHAoM3DSG9ugoBIDNG6bXAqa0Q8x5j0Cq9h0
         7AOKEjj8mWfs9jOdw9R65W7RTteWP8r9sHjEIYsn7aQnnJ0porarv5P+Jj6mQpkhlKDf
         CwsnYSihL+6iv9oQQNVgHI6bEV48aCKFrfFDDlQSBYKOChsHZbNIvv3iESxWKE10FSbW
         VxeA==
X-Forwarded-Encrypted: i=1; AKwUvBz39OlWpT2d8qBAwlTJLPx0dp5B8kwD2B8pVmiz/611H7RXbKZlY8FwXhxvvIkYgCP4YOx7RX9uL8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kYJAQnJ3jyOWM/KEaOyy/8UGOynu8B574eUQmdPsdykjKQBx7+
	hyMTG7gEvspvnp1Kj6mtKRTjK8y4dd/2L2RVon+rb+3Ve2HSNElTo3XQe9dbM2nD/0NvkExOBtq
	3Ddwxon8=
X-Gm-Gg: AYBFou3pa/wD83tU3l76SO03X80GBSU7ci+kndMpUyYvs+qIVn7txlJY55/MeHHdiwx
	KSoi5vOgAaj9wl3O0GN7jovjb/9B+cXs/lR8eD4wZ4VcNaWB/z1bsMIifr5ixN9oUTcQ15EC26b
	oLQZgOJirA0ONDpNTDdyy7Rnqe5T5vdUtqK5lDF+lNTP5DaHGmyMKsHXOv2GOnbnlx6qN6sfPv4
	ai83IiQ0KxZxBa6c/KQGlF1YpQOn9WJOaGJgdKQuyiM2OADaUuE2+j/rVh5jNBUkhOVjcfeViVi
	TnnIS67AFLv4qPCwelkrJ/DsUFpAXOr9rIT2mQe13Q7cDFIx8ZxmXhCfytYFjavHq9lVeKhpaiP
	vmqAjZuI6ekzsH/apJ1Cma4Vn0X4BXrD+FkCLIS3axXViGBBFo/ukbAAvZvPXcd802YEEJ6phuV
	8P8KYhQwXnlyEq7OWj9yuIdYO+vZo5bDRFJ8161G+/IPuI0HIscyatEpIct90ymuR7cwCb/+2+9
	U1z
X-Received: by 2002:a05:6214:4801:b0:912:588d:55e8 with SMTP id 6a1803df08f44-91421c8bf57mr26174106d6.9.1790262151859;
        Thu, 24 Sep 2026 08:02:31 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e24e458sm18438236d6.21.2026.09.24.08.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:02:31 -0700 (PDT)
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
Subject: [PATCH v6 4/4] PCI: of: introduce of_pci_verify_node()
Date: Thu, 24 Sep 2026 10:02:21 -0500
Message-ID: <20260924150222.1179235-5-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924150222.1179235-1-elder@riscstar.com>
References: <20260924150222.1179235-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Open Firmware PCI Bus Supplement and Devicetree Specification
reserves the device_type property for PCI bridge nodes (with value
"pci" or "pciex").  Non-bridge PCI endpoint nodes must not include
this property.  Rob Herring observed that developers seem to get
this wrong.  Commit df4107fc729e3 ("arm64: dts: qcom: qcs6490-rb3gen2:
clean up PCI function nodes") and a few that follow demonstrate this.

Rob requested that a runtime check be added to spot this specific error,
only for non-bridge PCI devices.  Herve Codina further suggested we
ensure that bridge PCI devices *do* define the device_type property,
with value "pci" or "pciex".

Implement these suggested warnings in of_pci_verify_node(), a new
function called by pci_bus_add_device() for both bridges and endpoints.
If a PCI bridge has a devicetree node, a warning is issued if it has
a device_type property whose value is not "pci" or "pciex" (or if it
has no such property).  Similarly, a warning is issued for an endpoint
if it has a device_type property having one of those two values.

To be clear, this adds warnings, but otherwise ignores the errors
it warns about.  It is meant to help developers; users should never
see them.

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


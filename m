Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893100;
	b=gC1DWMVacKXnXTLGMU0L6Q723c4vbl9nzsTZrSmxBPpV+8YXP+hdJN7EUrMngjr0yItt
	 IIpOdVQQ2RHIdhySSbD5xwXIwKEyYB3B8N/HKRl0wPiORiWtpXvr90R4qk8fIUWS8tFrR
	 fR20529NlrIv9rARjQogAMQgtz5S/qV65vUvVXW1+C/NTx+/rknNNy+N5IGlTsCiMsrrt
	 SPVoJvuuaZHk/e+jghYIc3Q1AHYaHgxAuL5o7kEXdqEBAkF6mbhaTAvTLMR67DSHC4oM3
	 XNrLCcLn9UrTy1jnpgFRERTZoxWg3P4xEL1lb0ux4/IkY5GWzr0bc4fmTH2j9LuySsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0l6j1oaqdhgh/JwMCNrOMOspKQGhGlHYbhxav43JvKA=;
	b=j7lwz4cpNghOhlLSlu80vErijUdmHxE4Y3XmNpRz13IkScMRZgPxLPG8Kq4LUaYmZVJd
	 NsB4/BQZA1QndyeqT+slSrwjjpYuz3LtElfezDAia5Nw4ig/xVlYbE1Lum+CPoqVNrDPV
	 SK1serj84Gard9aM+jOB7WQx8JvsDW8m8FLp0q7Q1KZgSvw8Ri7n1rz2eRAba6uEbNZF0
	 SFwesTA/cjWffhPtzQM0xnu1I+mTlggv+BV01t49gb+GYC5N5CJsL9w/VF2ymcsjNSOWG
	 3ry2X1ok5gN+ZZaxOd3jMqxPW+Pdmu6lTfP39i5De+wRnEmI15u+imjVAI0xYHLkDwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=pIbF9eIp;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB69606D837
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB69606D837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=pIbF9eIp
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-55651e7de9bso1070699b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 07:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1793893099; x=1794497899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0l6j1oaqdhgh/JwMCNrOMOspKQGhGlHYbhxav43JvKA=;
        b=pIbF9eIpQUw9aeaIkjQhkifvbyT8i2wvbrqbK41ifsnKKvOxQkfT2inNS9BmQynMAh
         7K0hfpmGQlYoXEgkxP1RvKcAxmZnLAskwDyjcqLtV0LNMnmvcO7mjPVJgDV3N55m7HcA
         TJGgxF2Urd/OTKkiveJdxurFkOxszywy6i+C7Xf7r/kj5aiiRe+X7gxJLTBgaHpyhHrb
         K/bE0o8bw1Zgb2ggr6AJDndZPpGuYckiws4kyBOG0DFZ4yIWacSFvk5mGdlDbfkJd/3H
         NjvgdkmVZfBAPp9fQja0O46nnC2YGv9ToxbqAmL6xidGGc9VP4eY/rcbcSQcgxVTPdZu
         G9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893099; x=1794497899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0l6j1oaqdhgh/JwMCNrOMOspKQGhGlHYbhxav43JvKA=;
        b=E6ZWbZw2cGsyYgYkQOy9yC7/uHaLLGysWNVtj51DkMnx44v3dUHk8wZyM8JvqnLoJ6
         w2DQE6yMSdY+rZBryW4KArg0+rtIn95etXCbpAyqpeuraURD3uBWYHm3PJUsBfnmE7+B
         nbWch3m34Sm19OLz0DR17xU/xqKKbbvbUYy5uOcsfVjglc0xCHaXgWfLDaDF/oCSIh4J
         zibbAjXtEiEhNCdmQ1mvhmFlslPmWsGwl243qOSdUYim6O68oAJXKaeUC2RWr158Iv+W
         QJw18csI9QedHNHz5w6cG4hejW5xASojHog218WTV9uwZoLM/gf+1mkx3PdrhJv40640
         kIeQ==
X-Forwarded-Encrypted: i=1; AKwUvByqfgFn1F4Y4XExckCIoAmb79lrUNXmTki0mWBtGue8opLi3vQkRK+4BWfcFzmJTvbWuinsINVjgtg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YylXyKTT1LRn8K+wDS+CafdgU9Kb8Q5wV6HF2wzU9iBPG9kGa
	DiEuWASFaVAiMOx+etiNie+MtHNkLllgeEJ61oH/Vq62WfrEUOH5F83P+/+iuehtO/c=
X-Gm-Gg: AYBFou26PdcwmKF98mPTy+ZHsdD0BqfG8/mcmo9kaSE8/1lrwErodU5t3H5o95L7Y5T
	haEzV8+oFYQVLfiKguNjCT6OZ/UiQLnoX7eJFuNbRk/wCjxJUGqEq7P/5jMvF+zR4ve7gsz6y23
	ksaRgrgPLvkHtidnSJh8cKGVrM0jLXgBO9NWNXd6H0fYLSUgak9qUgQJ4Ibo8lL/E93fYEriqs1
	YHxY2RD+ja7N7kWI0H2CKamt7VHtS32epaziWp25IJHHkGQBuywUlQlbnFUAEe0sFEqYFIxjuJD
	FJ2TwKZyfI97rTdYNm/ZNVir7sOq/eoe7xa2CoiWx9aJXCsnSxrZhoANrEjDJM/6KaYMba8gnub
	tgsK1sU/DNCRDFDN4ZopCZR37sJEYQZ2jdbLtMqSOyuUQtqjqRX2wwcZww3gu38VNpvKEDYHesi
	paQQvOoXas+SdpckM9OLV+qI5atGd64yKZiEottY8jiGffP2Bq7LXUjZ21ax3NIwyjxW+ksyw9r
	v/A8eSDuyOIfqMlE54jPiMc2W398zfvT6MofS5GyoIMHqpdGwFxQ9Zy1m9RX4W7XZPOUajBC0Jh
	dZbsMqOMVWQPn3dAvG1uEOqpanTPSd5+pA==
X-Received: by 2002:a05:6808:1997:b0:4d5:295c:a82c with SMTP id 5614622812f47-5640df07875mr15241603b6e.57.1793893099154;
        Thu, 05 Nov 2026 07:38:19 -0800 (PST)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef6e3bsm4435329b6e.5.2026.11.05.07.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:38:18 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] PCI: of: introduce of_pci_verify_node()
Date: Thu,  5 Nov 2026 09:38:01 -0600
Message-ID: <20261105153801.435566-5-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105153801.435566-1-elder@riscstar.com>
References: <20261105153801.435566-1-elder@riscstar.com>
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
see these messages.

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
index 77efa4c5c960e..e93f602b9ca48 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1259,6 +1259,7 @@ bool of_pci_supply_present(struct device_node *np);
 int of_pci_get_equalization_presets(struct device *dev,
 				    struct pci_eq_presets *presets,
 				    int num_lanes);
+void of_pci_verify_node(struct pci_dev *pdev);
 #else
 static inline int
 of_get_pci_domain_nr(struct device_node *node)
@@ -1314,6 +1315,8 @@ static inline int of_pci_get_equalization_presets(struct device *dev,
 
 	return 0;
 }
+
+static inline void of_pci_verify_node(struct pci_dev *pdev) { }
 #endif /* CONFIG_OF */
 
 struct of_changeset;
-- 
2.53.0


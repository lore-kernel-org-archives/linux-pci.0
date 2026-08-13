Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED13C0630
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658846; cv=none; b=EJZhnQrXRhhaaT2B9oIcwBthIYE1WfDJqSOgKYp7l6dbwpQ7WRyozg5/vFnwemUNaR8squbI3vOa0jheFyolqEJxC1wizAPQLp3z2e+RflbS1x2rubwo8IRCKcoaGFeGUJl1yKE6Lo/PZtvTVLlqZb3wh87soN0Wyrootc4Z8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658846; c=relaxed/simple;
	bh=eCf4mdXngntMvLx+wFQ8/hDGjbead5uAt7RWmxkIJ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsF6P2z68nPMw2vlLD7TwVn0qzXjrb+s2xt4JawW8nl1uxhfWy/sJC4gu3JU0I+u5Fti4HbKoPfHYnCG/j/yRl7jdFKMXcYqSBGvpF0iCWAnT730sjBkXauZAACTARHUBkPYDZo4sYIpCkMvQxwTCsykXbzqA9dVtXHsA19Dg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=vuJBfkPo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="vuJBfkPo"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e6391b114so30220985a.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786658844; x=1787263644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9KD6iCvTFU5NwlbZkHnKNp8ocE1VNUwFqzlkThaFrQ=;
        b=vuJBfkPolVgbsAuc1UmPP3i6dzGErdobmtVE/NFEh8fIwTMcVTJ7KhbtnVDGeuU7y5
         cfk/z+HmweZssgk7cy7TNyhOYXZHPbq5kIiiICbtTLVP4/t24FFSTmzTsuirHWMHKgij
         DsB06fHWEdA5f1Q+xI6j07fY7PK/cbfmLZFkey39mShQe6j6nuyWZTXd3LBCCkulU8GV
         kDsYSgQecScAQrUdPP34zd8qeRatt4AAh5W76K3Qesa6DYkLQgLtThfAMron9cbgl2Gu
         LRrqExdR+7/ruuhHZ5yiaTbmztCyHMqVcWEWzjtCmqXUmdI1MVvD7xNA3rLoAIwgmg6v
         HOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658844; x=1787263644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r9KD6iCvTFU5NwlbZkHnKNp8ocE1VNUwFqzlkThaFrQ=;
        b=AKUddAv+zFu50slKpjiqpc9Ct/uvDAtiKfqdNvfq5GyakhgK0hiGS92/UEi4IHju2Q
         qUhi7wElg/1LMXOKHCdXJOrS70BIM6GPS/7jaS/LfQIemku/sfTgYYccVuxCiNQj+Rm0
         DCAj/H563HCNodY4G+vhqsNLT7T86JCp/fsmsfLQ+TaYW0Svh+qaQN4g8BrYl9F2iNOZ
         dxiJdneTBlY6WEjFSxxw/KYmPqk7TdhaL3XBXFCGhEoJ6BjNPq9HggKBpjQUvJWLWkgx
         w9IJNa703N5ger3uXk4JoivSZ85zhQUg1bhSlUcj93WLExXxjARhp8efD/Di5VnBi3eq
         MkmA==
X-Forwarded-Encrypted: i=1; AHgh+RpCc00w1W33vEs22ZceTdp17ZyT7triPKHVPJVWDhH8IHlbqZxD6FX+bxegnF4jISrc6fKkbmMqgX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNMJhJdNNm9XNZvndeX7qVmQupBM/v9Cr+Emtt5A6hsRGuWc7J
	0CBpCIEECBgXIpTZi8HKKn+4Yarr/TudoVPWwFiY45kUfUOe6vjfj7H95Ay3KDRrAPc=
X-Gm-Gg: AR+sD13PnbM1z+9lfV/74SQrWDmTSMVbGSKCS8/2LcVWfkSDYhY/IqHUm1urCuXJtiV
	93EjVtqgrrKpqC25roCO/6YjFLPlSdRBtUsKpfWrDkZqhmQSvNs6gYGI0GkTGx816fWHW+z0Aqg
	Q0H++/77uFTWuTvnXTcAM/dSO/9/ivbJyqjcEL/3ke6LsaWZs/18IBbk2pZJH+wchQgR4KhI4M8
	HNAajg9dmQ/GHF72j13RxaaNKGBHL2Jy3RZY2RZEn7PKzEnVYjaAojDvovyvi0nayVpUFzFTZsv
	79OFGxf30f1H7cRWfWBehqmyJyRS2hvgrTqR+9C7BviL9iYDpYIdgaOJ9EgymuHOboUwQhP4BHA
	r3s5KV3e5UJNgqe/wzfYD1zFX0tIhVt4KyOHSU8+3VFw3h7N/ni4z/jkEmHU8bkgXQuHCMEW8rG
	cCuUQXwyb5ciiS5QCdC0+Fi5h16KJWbTHbo/xm3O9lCWojaVW62sjY7DiwSwsGJJyR
X-Received: by 2002:a05:620a:4492:b0:936:583a:dd75 with SMTP id af79cd13be357-936d212c6fdmr99272085a.17.1786658844276;
        Thu, 13 Aug 2026 15:07:24 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce22e990sm86776985a.38.2026.08.13.15.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:07:23 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com
Cc: lizhi.hou@amd.com,
	herve.codina@bootlin.com,
	andrea.porta@suse.com,
	daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com,
	mani@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: of: introduce of_pci_update_endpoint_node_ranges()
Date: Thu, 13 Aug 2026 17:07:16 -0500
Message-ID: <20260813220717.1394644-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813220717.1394644-1-elder@riscstar.com>
References: <20260813220717.1394644-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 407d1a51921e9 ("PCI: Create device tree node for bridge")
introduced the PCI_DYNAMIC_OF_NODES Kconfig option, which creates
a devicetree node for a PCI bridge as part of pci_bus_add_device().
Its successor commit ae9813db1dc5a ("PCI: Add quirks to generate
device tree node for Xilinx Alveo U50") shows how to use a PCI final
fixup quirk to also create a devicetree node for a non-bridge PCI
device.  In both cases, of_pci_make_dev_node() uses an OF changeset
to dynamically create a node populated with appropriate properties
and apply it to the live devicetree.

The dynamic devicetree node for a PCI device will include a "ranges"
property, and a new type of 3-cell address is introduced for use
within an endpoint.  The endpoint's ranges property will contain a
range entry for each of the endpoint's BARs.  The "child address"
portion of each range will use the BAR number in the "flags" (first)
cell in the address.  This allows addresses within the endpoint to
be expressed relative to whatever address gets assigned to each BAR.

Unfortunately, if a PCI endpoint device had a devicetree node set
up statically, its "ranges" property (if present) will be static,
and it cannot contain the addresses assigned to the endpoint's BARs
during enumeration.

This means that the "BAR number" based addressing scheme doesn't
work for PCI endpoints whose devicetree nodes are created statically.

To remedy this, modify of_pci_make_dev_node() to dynamically create
a "ranges" property just as is done when the endpoint has a null
devicetree node pointer.  The device node will be updated to add
the new "ranges" property (or replace it if one exists).

This allows "BAR number" addresses to work correctly even when the
endpoint's devicetree node is created statically.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of.c          | 59 ++++++++++++++++++++++++++++++++++-----
 drivers/pci/of_property.c |  2 +-
 drivers/pci/pci.h         |  1 +
 3 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 0bbf1a915b7d2..ce14ae01d1f4b 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -663,20 +663,65 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	of_node_put(np);
 }
 
+/* Returns true if the ranges property was added or updated successfully */
+static bool of_pci_update_endpoint_node_ranges(struct pci_dev *pdev)
+{
+	struct device_node *np = pci_device_to_OF_node(pdev);
+	struct property *prop;
+	u32 *value;
+	u32 size;
+
+	prop = kzalloc_obj(*prop);
+	if (!prop)
+		return false;
+
+	value = of_pci_build_prop_ranges(pdev, &size);
+	if (!value) {
+		kfree(prop);
+		return false;
+	}
+
+	prop->name = "ranges";
+	prop->length = size * sizeof(u32);
+	prop->value = value;
+
+	/* The property value needs to be in big-endian byte order */
+	while (size--)
+		cpu_to_be32s(value++);
+
+	/* of_update_property() consumes the allocated property */
+	of_update_property(np, prop);
+
+	return true;
+}
+
 void of_pci_make_dev_node(struct pci_dev *pdev)
 {
 	struct device_node *ppnode, *np = NULL;
+	struct device *dev = &pdev->dev;
+	struct of_changeset *cset;
 	const char *pci_type;
-	struct of_changeset *cset;
 	const char *name;
 	int ret;
 
-	/*
-	 * If there is already a device tree node linked to this device,
-	 * return immediately.
-	 */
-	if (pci_device_to_OF_node(pdev))
+	/* No need to create a new devicetree node if one already exists */
+	if (pci_device_to_OF_node(pdev)) {
+		if (pci_is_bridge(pdev))
+			return;
+
+		/*
+		 * For an endpoint device, we need to add or update its
+		 * devicetree "ranges" property.  The new property will
+		 * include an entry for every BAR, mapping BAR offsets
+		 * to the actual assigned PCI bus address space for the
+		 * endpoint.  The child space in each range uses the flags
+		 * cell of the child bus address to encode the BAR number.
+		 */
+		if (!of_pci_update_endpoint_node_ranges(pdev))
+			dev_err(dev, "failed updating ranges property\n");
+
 		return;
+	}
 
 	/* Check if there is device tree node for parent device */
 	if (!pdev->bus->self)
@@ -715,7 +760,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 
 	np->data = cset;
 
-	ret = device_add_of_node(&pdev->dev, np);
+	ret = device_add_of_node(dev, np);
 	if (ret)
 		goto out_revert_cset;
 
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 48ce467e7e966..744dee0dd9625 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -116,7 +116,7 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
  *
  * Caller is responsible for ensuring the returned pointer gets freed.
  */
-static u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
+u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
 {
 	bool bridge_device = pci_is_bridge(pdev);
 	struct of_pci_range_entry *entries;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e1ccdd6f6418..6ae8adb30fdd0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1316,6 +1316,7 @@ struct of_changeset;
 #ifdef CONFIG_PCI_DYNAMIC_OF_NODES
 void of_pci_make_dev_node(struct pci_dev *pdev);
 void of_pci_remove_node(struct pci_dev *pdev);
+u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count);
 int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 			  struct device_node *np);
 void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge);
-- 
2.53.0


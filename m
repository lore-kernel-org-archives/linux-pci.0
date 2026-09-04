Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F438F927
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490113; cv=none; b=A0DDhdEbPfRyAN0p5+guJkPQGewbeyivDQythfTN8VJbXOMan5J+v/rOLwakZeS00UE6JyzxmPpqd/LQxXxlwwzKgPwJB4O+EyxA4n0K2gvayRf4tllbz/wKHzinH01bpU/BDo5xZT1ceFE6JgDnKz8NvNETTRVjg2YbDL8jPj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490113; c=relaxed/simple;
	bh=4ZavyL42xtglVBipSMRWA6ihGhpqB9JmwP1ZH/ASTvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BJBOmSOxYzvZLlwjet5T0ij4UD5s7Pa2I7SYSLZ/GP+RmkCCrQO5/9kgN+wTtMNhFZqfQ/Ktd4c/pzgY1kIOn8MFLpIX8weLA2qybq1G01PyyKLJDGJM6uoWpRKBnqZemNmENNW88clZTOaYoZEvijUZoPk3y6btj1rwhXqBUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZS19nsP; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZS19nsP"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-85602449126so1085880b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 19:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788490110; x=1789094910; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsPb5bVQxBixryBb9IXokn4XCrzoWNCx2hg/i/D0/QM=;
        b=VZS19nsPAlk++BgBjodp/6ZR158Fq63p9aLTLCKhKbJ8kUoQQ2tZk9KqIUgttCmfRv
         u37iiqT+x95KsB/f0AoNTn19GkkhrQFXHNjr0G7lNlK1Kj5r10QvlL7JjlgEiAJB8RW/
         G9xHAdRB16nySxukxHvxmVV2FGbToo2hVVE6RFdP09fTVgr56MIEhrmNLqNlRbToD6bY
         XiA9OZOVTHtOVb1iz0pZtNVsUWo1Y/Ay8JWBT0DiAFlU1+MvhlMcki78un6azM5f1qmn
         CHw5yKQfYK2dsvRtsAPgun0oEOFYM8PXHCYIjZERoIsrcBElxfN+atdT7PkW2TlM0lAJ
         hx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788490110; x=1789094910;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZsPb5bVQxBixryBb9IXokn4XCrzoWNCx2hg/i/D0/QM=;
        b=N7X2V4NIrThRJU9Oea3fRO1/Zmi1FF2ogynXi3gt3gKg5y+RepJ7orntvb9UoQrRGC
         sh0PoZekxs3PI7ZFidydpsL8qFyvGZqEkX1lc7OmdxlgJF8SN+o3IfI4J9mmstury+/d
         dmpJMv7FSr/6Z40asnwSwRkwUQ2UpjafqfMEowwCHd9KgYQE3IJzIBu1rwjzE0r1PVE4
         M6zANHtowOztXOdXo1uV9M49c3XyoFEA2NkGw0HwWl7aP/YS45360bMY2XrrnGzd5eKy
         9+IdloVDudcwfasMWct9w5PwalANcYknoprdifkRFnj4UZ+EGPcUAE80NFIzTYqEClha
         4Sog==
X-Forwarded-Encrypted: i=1; AKwUvBzpXe9oYhITEbrbUk1l2WVAFRV5rVNI9Rpwu02H88T8YuFf0Y/gPQZap7SwGhgptgrhHeEDuXJXd+M=@vger.kernel.org
X-Gm-Message-State: AFuF++lCo/mtzVO6FuYgkD24jP+Ci4pM+gMBqeXvBFH01wwPc6WdoFlM
	qX/1QDpzV9S03CRSpcOfUh30AQooldL7bt6bjKDmoWNpiesRDkjUV8h8OgGWQBQ2fo4JrS5aH6I
	TDRQuKoVaK5wneT7kfmrz50k8DuW1zgGKZg==
X-Received: from pfbdo7.prod.google.com ([2002:a05:6a00:4a07:b0:845:a3d5:fed])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4298:b0:857:726d:2706 with SMTP id d2e1a72fcca58-8616c63f134mr5037616b3a.18.1788490110155;
 Thu, 03 Sep 2026 19:48:30 -0700 (PDT)
Date: Fri, 04 Sep 2026 02:48:28 +0000
In-Reply-To: <20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260904-pcie-link-endpoints-v2-1-16fcb301a3e4@google.com>
Subject: [PATCH v2 1/3] PCI: Add pcie_get_link_endpoints() helper
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>, 
	sashiko-bot@kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

In PCIe topologies, physical links are point-to-point connections
between an Upstream Component (Downstream Port, such as a Root Port
or Switch Downstream Port) and a Downstream Component (Upstream Port,
such as an Endpoint or Switch Upstream Port), per PCIe Base Specification
Revision 7.0 / 6.0 sec 1.3.1.

Drivers across drivers/pci/ (such as Lane Margining at Receiver and AER
recovery) coordinate operations across both ends of a PCIe link:
  - Lane Margining at Receiver (LMR): requires resolving both link
    endpoints to establish hierarchical locking and runtime PM pinning.
  - AER/DPC Recovery: identifies the parent bridge to coordinate link
    resets and recovery sequences.

Introduce pcie_get_link_endpoints() and pcie_put_link_endpoints() in the
PCI core to provide a standardized, symmetric, and race-safe helper:
  - Validates output pointer arguments and initializes them to NULL.
  - Resolves Physical Functions for VFs via pci_physfn().
  - For Endpoints: resolves parent Downstream Port via
    pci_upstream_bridge().
  - Resolves base Function 0 symmetrically on the link subordinate bus
    for both non-ARI multi-function devices and ARI (Alternative
    Routing-ID Interpretation) devices where all functions (0..255)
    belong to the same logical device.
  - Safely inspects subordinate bus and bus device lists under
    down_read(&pci_bus_sem), verifying bridge ownership
    (child->self == pdev) to eliminate ABA pointer identity and UAF
    races with concurrent hot-remove.
  - Symmetrically acquires references via pci_dev_get() on both resolved
    endpoints on success, or returns -ENODEV if either end is unresolved.

Callers release acquired references using pcie_put_link_endpoints().

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-pci/20260831214631.7CD5E1F000E9@smtp.kernel.org/
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pci.c   | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |   5 ++
 2 files changed, 157 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..d1e3d6e3f5b1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4654,6 +4654,158 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	return rc;
 }
 
+/*
+ * pcie_get_subordinate_bus_locked() - Safely obtain active subordinate bus.
+ * Validates that a child bus matching bridge @pdev is actively linked in
+ * pdev->bus->children under pci_bus_sem. Verifies bridge ownership
+ * (child->self == pdev) to prevent Use-After-Free or ABA pointer identity
+ * races during concurrent hot-remove (pci_remove_bus / pci_remove_bus_device).
+ */
+static struct pci_bus *pcie_get_subordinate_bus_locked(struct pci_dev *pdev)
+{
+	struct pci_bus *child;
+
+	lockdep_assert_held_read(&pci_bus_sem);
+
+	if (!pdev->subordinate)
+		return NULL;
+
+	list_for_each_entry(child, &pdev->bus->children, node) {
+		if (child->self == pdev)
+			return child;
+	}
+
+	return NULL;
+}
+
+/*
+ * pcie_find_link_upstream_func0() - Find the base Function 0 device on a link.
+ * Handles ARI (Alternative Routing-ID Interpretation) and multi-function
+ * topologies uniformly and symmetrically.
+ */
+static struct pci_dev *pcie_find_link_upstream_func0(struct pci_bus *bus,
+						     struct pci_dev *hint)
+{
+	struct pci_dev *child;
+
+	if (!bus)
+		return NULL;
+
+	if (pci_ari_enabled(bus)) {
+		/*
+		 * In ARI, all functions (0..255) on the bus belong to the same
+		 * logical device. Base Function 0 is strictly devfn == 0.
+		 */
+		list_for_each_entry(child, &bus->devices, bus_list) {
+			if (child->devfn == 0)
+				return pci_dev_get(child);
+		}
+	} else if (hint) {
+		/* Non-ARI: find Function 0 in the same device slot */
+		if (PCI_FUNC(hint->devfn) == 0)
+			return pci_dev_get(hint);
+
+		list_for_each_entry(child, &bus->devices, bus_list) {
+			if (PCI_SLOT(child->devfn) == PCI_SLOT(hint->devfn) &&
+			    PCI_FUNC(child->devfn) == 0)
+				return pci_dev_get(child);
+		}
+	} else {
+		/* Non-ARI from Downstream Port: prefer devfn 0, then any Func 0 */
+		list_for_each_entry(child, &bus->devices, bus_list) {
+			if (child->devfn == 0)
+				return pci_dev_get(child);
+		}
+		list_for_each_entry(child, &bus->devices, bus_list) {
+			if (PCI_FUNC(child->devfn) == 0)
+				return pci_dev_get(child);
+		}
+	}
+
+	/* Fall back to hint or first device on subordinate bus */
+	if (hint)
+		return pci_dev_get(hint);
+
+	child = list_first_entry_or_null(&bus->devices, struct pci_dev, bus_list);
+	return pci_dev_get(child);
+}
+
+/**
+ * pcie_get_link_endpoints - Identify Upstream and Downstream ends of a PCIe link
+ * @pdev: Any PCIe device on the link (Downstream Port or Endpoint)
+ * @downstream_port: Output pointer to Downstream Port (Upstream Component)
+ * @upstream_port: Output pointer to Upstream Port (Downstream Component)
+ *
+ * Identifies both ends of a point-to-point PCIe link. Acquires a reference
+ * (pci_dev_get()) on both discovered endpoints on success. Callers must release
+ * acquired references with pcie_put_link_endpoints() or pci_dev_put().
+ *
+ * Return: 0 on success, -EINVAL if @pdev is NULL or not PCIe, or -ENODEV if
+ * either end of the link cannot be resolved.
+ */
+int pcie_get_link_endpoints(struct pci_dev *pdev,
+			    struct pci_dev **downstream_port,
+			    struct pci_dev **upstream_port)
+{
+	struct pci_dev *down = NULL, *up = NULL;
+
+	if (!downstream_port || !upstream_port)
+		return -EINVAL;
+
+	*downstream_port = NULL;
+	*upstream_port = NULL;
+
+	if (!pdev || !pci_is_pcie(pdev))
+		return -EINVAL;
+
+	pdev = pci_physfn(pdev);
+	if (!pdev->bus)
+		return -ENODEV;
+
+	if (pcie_downstream_port(pdev)) {
+		struct pci_bus *subordinate;
+
+		down_read(&pci_bus_sem);
+		subordinate = pcie_get_subordinate_bus_locked(pdev);
+		if (subordinate)
+			up = pcie_find_link_upstream_func0(subordinate, NULL);
+		up_read(&pci_bus_sem);
+		down = pci_dev_get(pdev);
+	} else {
+		down = pci_dev_get(pci_upstream_bridge(pdev));
+		down_read(&pci_bus_sem);
+		up = pcie_find_link_upstream_func0(pdev->bus, pdev);
+		up_read(&pci_bus_sem);
+		if (!up)
+			up = pci_dev_get(pdev);
+	}
+
+	if (!down || !up || !pci_is_pcie(down) || !pci_is_pcie(up)) {
+		pci_dev_put(down);
+		pci_dev_put(up);
+		return -ENODEV;
+	}
+
+	*downstream_port = down;
+	*upstream_port = up;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcie_get_link_endpoints);
+
+/**
+ * pcie_put_link_endpoints - Release references acquired by pcie_get_link_endpoints
+ * @downstream_port: Downstream Port pointer
+ * @upstream_port: Upstream Port pointer
+ */
+void pcie_put_link_endpoints(struct pci_dev *downstream_port,
+			     struct pci_dev *upstream_port)
+{
+	pci_dev_put(upstream_port);
+	pci_dev_put(downstream_port);
+}
+EXPORT_SYMBOL_GPL(pcie_put_link_endpoints);
+
 /**
  * pcie_wait_for_link_delay - Wait until link is active or inactive
  * @pdev: Bridge device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..671d8db5898e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1272,6 +1272,11 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
+int pcie_get_link_endpoints(struct pci_dev *pdev,
+			    struct pci_dev **downstream_port,
+			    struct pci_dev **upstream_port);
+void pcie_put_link_endpoints(struct pci_dev *downstream_port,
+			     struct pci_dev *upstream_port);
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
 DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))

-- 
2.55.0.1003.g10538fe699-goog


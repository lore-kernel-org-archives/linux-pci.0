Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAEA4195A3
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 05:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499459; cv=none; b=PwCeR6nrh8CnS7FJJqbKrEFh0C+MI5JIWRyMlNH82GRS28NH00tEYY/JAqE/TOZm9gqliGeRoU0d4Xkv10euAsu3uKEw17J9Q6YJ0yWcwlGh1bkQPhjz9IUJmn+8tsNBIH5l7eqeY0ee0Veb4u2AWUd1MYmLk8SOVOMHlq0Kjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499459; c=relaxed/simple;
	bh=4ZavyL42xtglVBipSMRWA6ihGhpqB9JmwP1ZH/ASTvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y2FD15kG9CoiTyCxMUWL5PgeJj3dz/IaD06WEdrQ0FPuHhjLYJhOSGfST4lUL0C+TtfIvxciq5+VLmLTERabeK3DK9cLyCx1SI/A+9lw6C1OW0vSkpuJ0Pq/jzFfMiTnsk9uyKZTaU73EEgLZ96NnqiKnTenzvsHv4iuthOux7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmNKUYtB; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmNKUYtB"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfe48ca1efso8942135ad.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 22:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788499454; x=1789104254; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsPb5bVQxBixryBb9IXokn4XCrzoWNCx2hg/i/D0/QM=;
        b=rmNKUYtBQBe7FPZJVAs+XTwr3qgj4RqGMHOl0hjmi1JlyqGCt6C0bbw5/wArLUbfG1
         loJp7mrynquobo4zg4rB2+oqyAO5Z73PT+g2caOJ2VkkbexcdV6BUZK0kha3HSzQpTLB
         0njtCUI5zM59hpzXyDyhbL13EHO/hwvrdTuxPvj9TLAZusWeFbOr3olUcKzLXMOkF7EO
         k4tSOyMNbAlqHF7ng0wB/1rMO8sZc76y4ShQd+uATgAZKJpTDeEOFxirdH4BJnrPiVH8
         qoobVOGr3fVjZZnzWgcGbvd7LrSBHXTZU81Zv6k9vx2Qua0YNJXRaziIfaKPyAmbRPzf
         HQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788499454; x=1789104254;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZsPb5bVQxBixryBb9IXokn4XCrzoWNCx2hg/i/D0/QM=;
        b=BhAbCfaN2u2OWVuExRRz3LTt6r3pc7LK52ilCrjRseSUpPf3mHog1h01ZQZByuEqOB
         7ILuH3VVd/gG8MNfl3iWAjc3FigvDjdQR+gIdwQmVenBVpbeIhEwvi1xz/PO8L2DysM9
         hm1wyXKnNcYuQvA9Uu4lIOYLobuphlAjL8qqnAYN8tdaCxP5DDMVt2U1KJLH59eeBttv
         u9EIEtaFtiFp7sSHo8vR+f0oUXjVVdQA7zzQBBaMTLhSc59885KPRAnnlvie63BpkEEJ
         K2N076k7Zr/H4kEx9YVNoMZN6lJTGHHk/3QeVLTfQAZ9CqjRozx1Z5T2LKGnlH1UUtyr
         kqSg==
X-Forwarded-Encrypted: i=1; AKwUvBxKwJYVdowfGUZCbNndqI3zBz8kPK7casdNVVLSaUryzofxcfe9M3DTCnlnRcNI8FCdxCEOrhZ3XjI=@vger.kernel.org
X-Gm-Message-State: AFuF++mnmoG+K8Eie70UshvqfHw0Gldx6JhU0yRUF8HFMRSasi515WDj
	Y4zUAr6XPzceuXkMNbaeMzM7WzPPUCF7PyrahKoHCQSxyLL1IrmvjbnU4FuMIk4G7fopD1/l4SE
	Sq4rApzLorwx3GO2MmirHeRnk4NLvVEV5ng==
X-Received: from pltt21.prod.google.com ([2002:a17:902:d155:b0:2cf:afd2:6506])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f690:b0:2d8:d4ce:7e3d with SMTP id d9443c01a7336-2db126326f4mr47549945ad.18.1788499454225;
 Thu, 03 Sep 2026 22:24:14 -0700 (PDT)
Date: Fri, 04 Sep 2026 05:24:12 +0000
In-Reply-To: <20260904-pcie-link-endpoints-v3-0-4b9a91bd4b35@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904-pcie-link-endpoints-v3-0-4b9a91bd4b35@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260904-pcie-link-endpoints-v3-1-4b9a91bd4b35@google.com>
Subject: [PATCH v3 1/3] PCI: Add pcie_get_link_endpoints() helper
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


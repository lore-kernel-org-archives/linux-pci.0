Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533E37E5F4
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206704; cv=none; b=luR1Z/aGW2Nc6PbNd1TGW0McCeDMsye5wQtnXFu+boXp+vBPLLqcOqA8NcD3YMShpd+nAYT5K49OTINzqau4CMuDI8yNgxQNFiYfkZmC2iJf+obm9+lKPz7+E2T9zqmbbGpGxbIlXqDmg7aflYNDhpFVBnu4GMYWNAZHba236CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206704; c=relaxed/simple;
	bh=ogaNwEJPj1anxxgzO5JbrX2B9A0WCXUin+5LwdkKgb0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ypwx9930XkoY3wavkiAMZIpf2ZtPPg3m28IRb7y89iEtLuxwMr97+2DXz8UGR72obMEatsUIj4SIhCroS1YriT+Myu2tnpEfuiuB0oMah7YBPhhCqJoKVPFKWiBSD6KKVyt92aUVe3EXe4n3nyPwFAXe/7kyqTXlD2ZFO5Dq6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8kStlbG; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8kStlbG"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbee6bb8408so5260157a12.3
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788206701; x=1788811501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VQEcr/OvKrgDDu2LGE7v3a5Mgn/4plrpKKfKHe+7A/w=;
        b=R8kStlbGpjB53aldvz1HubwAU1QUb2UW+31uAWZrRZq+NoVVRpxl522Q5wD9168j5y
         AD62QrpoICAsvt88/ZjZpTB+cbceeeNOBPlpvV+BX6ZPHVumHCDrOnfavcGjqz7yqfJ9
         E6Gc0sDhq2pt9Vhw5XvhqgyJvE8CPH4XKku/r9npipCz9QgznhmhvQ9VPvCtPW1aIICp
         63Bd9buoF3PCvR+XNIfO0ROkSRM6Aqr4rt2HY5jcNFL6pQygKMAAIQY+M0WgGldmNEaJ
         icTjnx7gUTfw+EMWSUEwEoiHsW5+HnFcpBVmlBLH82COR+XB0gGgcrSH7o+ek25457R6
         g9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206701; x=1788811501;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQEcr/OvKrgDDu2LGE7v3a5Mgn/4plrpKKfKHe+7A/w=;
        b=D7BZwCp/xJFDZz0pVZxVxl8F7NHbhMcAj1ClyJkSEYicRXPD2Y0D8/8A8T/JBOxHEg
         Tx3vInQnEfJzp7X0cQ+SQIJWUE34ACHUxyvsqmiXJCjC+7ZuTrfvdBYstQWPnsYi60J2
         0QJ0xE+1l2RNvZYb0xlUz2Vofa1Kt9Wft6T78UkI5+1nNcuF4uJnwAVescrBBqeJBUo2
         S6L9Eo789KkvEFwiIRu0Q4/PHsXtt2Tw4ckkY2c2oth/61Q0wLx8N8qTs+QKS6AIkbka
         D7U4FcOYNee/RhdXjloaz9Iui518kirGEWkUZUsduoYvRED7aEueCVjracxGSG5NU+6U
         3t7w==
X-Forwarded-Encrypted: i=1; AHgh+RqW+CRDzkM0xSRhe4YAtZb5IyTCNH4tS2mtXGjPCK8c8p6hFEMMTdYteNcjTVhosZVxI/WKqENjSj8=@vger.kernel.org
X-Gm-Message-State: AFuF++mceSbznVNNR+rKMNNZKscU3T+8tNJqq0Hg+H/K+fwlxYzM3MN5
	dWKHOcoU9qXPwflvu/f7vBm+xH0smonosH6WJhqmZ9h4Q+dXhM0vOWFQQWacsUJnaU6Q9kIx5MF
	lxHkO4+LNKi+nB+adXwTlOMt/OVTYtGWU+g==
X-Received: from pgbaz9.prod.google.com ([2002:a05:6a02:49:b0:cc1:c899:13e5])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:918f:b0:3d1:e510:905f with SMTP id adf61e73a8af0-3d265e3f7b2mr36171322637.1.1788206701180;
 Mon, 31 Aug 2026 13:05:01 -0700 (PDT)
Date: Mon, 31 Aug 2026 20:04:44 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFvelWoC/x3MSwqAMAwA0atI1gZSxe9VxIXYqEGJpRURine3u
 HyLmQiBvXCAPovg+ZYgpyaYPIN5m3RlFJsMBRU1taVBNwvjIbojq3Wn6BWwa1o2RLayVEMqned Fnv86jO/7AZdCKSdlAAAA
X-Change-Id: 20260831-pcie-link-endpoints-978e100d5d06
X-Mailer: b4 0.14.3
Message-ID: <20260831-pcie-link-endpoints-v1-1-32c2fd893e9e@google.com>
Subject: [PATCH] PCI: Add pcie_get_link_endpoints() helper
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

In PCIe topologies, physical links are point-to-point connections
between an Upstream Component (Downstream Port, such as a Root Port
or Switch Downstream Port) and a Downstream Component (Upstream Port,
such as an Endpoint or Switch Upstream Port), per PCIe Base Specification
r7.0/r6.0 sec 1.3.1.

Currently, various drivers across drivers/pci/ independently infer the
two ends of a PCIe link using varied ad-hoc methods:
  - ASPM (drivers/pci/pcie/aspm.c): pcie_aspm_get_link(),
    alloc_pcie_link_state(), and pci_configure_ltr() resolve parent
    bridges and subordinate function 0.
  - Precision Time Measurement (drivers/pci/pcie/ptm.c):
    pci_upstream_ptm() traverses pci_upstream_bridge() to validate
    upstream link partner capabilities.
  - PCIe Link Retrain (drivers/pci/pci.c): pcie_retrain_link() and
    pcie_update_link_speed() coordinate link retraining from the
    Downstream Port across the subordinate bus.
  - AER/DPC Recovery (drivers/pci/pcie/err.c): pcie_do_recovery()
    identifies the parent bridge via pci_upstream_bridge() to trigger
    secondary bus reset and broadcast driver recovery callbacks.
  - Lane Margining at Receiver (LMR): margin_enable_write() requires
    both link endpoints to establish hierarchical locking and runtime PM
    pinning.

Ad-hoc subordinate bus iteration risks races with concurrent device
removal or hotplug if pci_bus_sem is omitted.

Introduce pcie_get_link_endpoints() and pcie_put_link_endpoints() in the
PCI core to provide a standardized, symmetric, and race-safe helper:
  - For Endpoints: resolves the parent Downstream Port via
    pci_upstream_bridge(pdev).
  - For Downstream Ports: safely inspects the subordinate bus under
    down_read(&pci_bus_sem) and acquires a reference via pci_dev_get()
    on the child device.

Callers release the acquired reference using pcie_put_link_endpoints().

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Hi Bjorn, Ilpo, and PCI maintainers,

During the review of the PCIe Lane Margining at Receiver (LMR) patch series
(v7: https://lore.kernel.org/linux-pci/20260828-pcie-lmt-v7-1-6012e9e0940a@=
google.com/),
Ilpo J=C3=A4rvinen pointed out that feature drivers (such as LMR) resolving=
 link
partners duplicate link traversal logic that is already present in drivers =
such
as ASPM:

  "This feels like duplicating similar functionality with the aspm driver
   that also wants to infer ends of the link when giving a pci_dev in.
   The aspm driver currently does that within, but it kind of duplicating
   pci_bus. It would be nice to avoid the duplication and have something
   similar for this in PCI core."

In PCIe topologies, physical links are point-to-point interconnects
between an Upstream Component (Downstream Port, such as a Root Port or Swit=
ch
Downstream Port) and a Downstream Component (Upstream Port, such as an Endp=
oint
or Switch Upstream Port), per PCIe Base Specification Revision 7.0 / 6.0
Section 1.3.1.

Several subsystems across drivers/pci/ independently infer and coordinate b=
oth
ends of a PCIe link:
  1. ASPM (drivers/pci/pcie/aspm.c): pcie_aspm_get_link(),
     alloc_pcie_link_state(), and pci_configure_ltr() resolve parent bridge=
s
     and subordinate function 0 to configure ASPMC and L1SS.
  2. Precision Time Measurement (drivers/pci/pcie/ptm.c): pci_upstream_ptm(=
)
     traverses pci_upstream_bridge() to validate upstream link partner
     capabilities.
  3. PCIe Link Retrain (drivers/pci/pci.c): pcie_retrain_link() and
     pcie_update_link_speed() coordinate link retraining from the Downstrea=
m
     Port across the subordinate bus.
  4. AER & DPC Recovery (drivers/pci/pcie/err.c): pcie_do_recovery() identi=
fies
     the parent bridge via pci_upstream_bridge() to trigger secondary bus
     resets and broadcast driver error callbacks.
  5. Lane Margining at Receiver (LMR): margin_enable_write() requires both
     link endpoints to establish hierarchical locking (pci_dev_lock) and
     runtime PM pinning.

Currently, these drivers independently implement ad-hoc traversals via
pci_upstream_bridge() or subordinate bus device iteration. Ad-hoc subordina=
te
bus iteration is error-prone and risks races with concurrent hot-unplug or
device removal if pci_bus_sem is omitted.

This patch introduces pcie_get_link_endpoints() and pcie_put_link_endpoints=
()
in the PCI core (drivers/pci/pci.c and include/linux/pci.h) as a standalone
helper:
  - For Endpoints: resolves the parent Downstream Port via
    pci_upstream_bridge(pdev).
  - For Downstream Ports: safely inspects the subordinate bus under
    down_read(&pci_bus_sem) and acquires a reference via pci_dev_get() on t=
he
    child device.

Callers release the acquired reference with pcie_put_link_endpoints().

Validation:
  - Compiled clean on x86_64 defconfig (0 warnings, 0 errors).
  - Multi-architecture build validated for ARM64 and x86_64 targets.
  - Passed checkpatch.pl (0 warnings, 0 errors).
  - Passed Sashiko pre-commit test runner (ID: 46b5f8a3da1ca0056407b3db6c82=
b001264f86b7).
---
 drivers/pci/pci.c   | 50 +++++++++++++++++++++++++++++++++++++++++++++++++=
+
 include/linux/pci.h |  6 ++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..7bdfe7e5ab3a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4618,6 +4618,56 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use=
_lt)
 	return rc;
 }
=20
+/**
+ * pcie_get_link_endpoints - Identify Upstream and Downstream ends of a PC=
Ie link
+ * @pdev: Any PCIe device on the link (Downstream Port or Endpoint)
+ * @downstream_port: Output pointer to Downstream Port (Upstream Component=
)
+ * @upstream_port: Output pointer to Upstream Port (Downstream Component)
+ *
+ * Identifies both ends of a point-to-point PCIe link. Increments referenc=
e count
+ * on @upstream_port if dynamically discovered on a downstream port. Calle=
rs must
+ * release with pcie_put_link_endpoints().
+ *
+ * Return: 0 on success, or -EINVAL if @pdev is NULL or not PCIe.
+ */
+int pcie_get_link_endpoints(struct pci_dev *pdev,
+			    struct pci_dev **downstream_port,
+			    struct pci_dev **upstream_port)
+{
+	if (!pdev || !pci_is_pcie(pdev))
+		return -EINVAL;
+
+	if (pcie_downstream_port(pdev)) {
+		*downstream_port =3D pdev;
+		down_read(&pci_bus_sem);
+		*upstream_port =3D pdev->subordinate ?
+			pci_dev_get(list_first_entry_or_null(&pdev->subordinate->devices,
+							     struct pci_dev, bus_list)) : NULL;
+		up_read(&pci_bus_sem);
+	} else {
+		*downstream_port =3D pci_upstream_bridge(pdev);
+		*upstream_port =3D pdev;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcie_get_link_endpoints);
+
+/**
+ * pcie_put_link_endpoints - Release references acquired by pcie_get_link_=
endpoints
+ * @pdev: Device passed to pcie_get_link_endpoints()
+ * @downstream_port: Downstream Port pointer
+ * @upstream_port: Upstream Port pointer
+ */
+void pcie_put_link_endpoints(struct pci_dev *pdev,
+			     struct pci_dev *downstream_port,
+			     struct pci_dev *upstream_port)
+{
+	if (pdev && pcie_downstream_port(pdev) && upstream_port)
+		pci_dev_put(upstream_port);
+}
+EXPORT_SYMBOL_GPL(pcie_put_link_endpoints);
+
 /**
  * pcie_wait_for_link_delay - Wait until link is active or inactive
  * @pdev: Bridge device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..d30bf056a7ce 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1264,6 +1264,12 @@ struct resource *pci_find_parent_resource(const stru=
ct pci_dev *dev,
 u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
+int pcie_get_link_endpoints(struct pci_dev *pdev,
+			    struct pci_dev **downstream_port,
+			    struct pci_dev **upstream_port);
+void pcie_put_link_endpoints(struct pci_dev *pdev,
+			     struct pci_dev *downstream_port,
+			     struct pci_dev *upstream_port);
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
 DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))

---
base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
change-id: 20260831-pcie-link-endpoints-978e100d5d06

Best regards,
--=20
Priyank Rathod <rathodpriyank@google.com>


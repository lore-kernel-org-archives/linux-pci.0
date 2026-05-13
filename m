Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE294345CD8
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675042; cv=none; b=XU6Z5F4mueUK6qe75fU+qW5FGGIZISEAbyWpZxbeWNYyi0ta3IKoZ8/CyEMG9m5mWchtvAv1ndJFzCtSBp+uhM9PstPLRQos6NR9QtgWlKZNURYaTpxgeGzknBS5VYju29SZCtGRazFeVeezfMkEKWtlUblRlvZaxxEn93tVNqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675042; c=relaxed/simple;
	bh=lIozm580QVseEfafixzD/2ghGcrM+HimVm3zC6i5++M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovya1gpL8VXI4Bg3fnld2qRUlvHWV+BKByqsI67DCVXSgKJF//sb8trJD1BZAMk4YrVBD91+KNhDat46DlLuzbPvLZtzASlWATrc3gNpz/jsjsFdPPZ3P4zWhT+57bb/Xle7WrzGHlgdpeU6Ff3Xr8RavXyTN0M96Dwc/op00GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4qkdpDA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4qkdpDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778675039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q2BuRMaZwe2gPBAfnao93Zz1+V5eakDSMF2oBOxmE+g=;
	b=Q4qkdpDAnWG30qApByxfHbaUlw/iXbF6qiM4kvLNeKs75q3O1eS9N3RB3er5opBe96ory3
	Vd1neRiZlY4sIXhL2tHekggwN10XCDOPut52udJnmmDghd4kMeiHqF72CkgvwCWa5/Haku
	Qjq6wktCSul4dfXwUI9sEyDIZvnqxlY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-dJgsGdOCOdCY43Sj5eKWYA-1; Wed,
 13 May 2026 08:23:58 -0400
X-MC-Unique: dJgsGdOCOdCY43Sj5eKWYA-1
X-Mimecast-MFC-AGG-ID: dJgsGdOCOdCY43Sj5eKWYA_1778675037
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B757180034C;
	Wed, 13 May 2026 12:23:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.110])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 343D71955D84;
	Wed, 13 May 2026 12:23:54 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v3 1/2] PCI: Add D3cold as general reset method
Date: Wed, 13 May 2026 14:23:48 +0200
Message-ID: <20260513122349.268753-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add D3cold power cycle as a general PCI reset method, available for
single-function devices. This provides a more robust reset mechanism
than D3hot for devices where a full power cycle is beneficial.

The implementation uses pci_set_power_state(dev, PCI_D3cold), which
automatically handles platform differences:
- Platforms WITH _PR3 ACPI power resources: true D3cold (power cycle)
- Platforms WITHOUT _PR3: automatic fallback to D3hot transition

D3cold reset is placed at the end of the reset hierarchy as a last
resort before giving up, since it provides a strong reset when other
methods are unavailable or broken.

Reset hierarchy with this change:
1. device_specific
2. acpi
3. flr
4. af_flr
5. pm (D3hot via config space)
6. bus (SBR)
7. cxl_bus
8. d3cold (NEW - power cycle with D3hot fallback)

This benefits devices that:
- Have broken or missing FLR
- Advertise NoSoftRst+ incorrectly (blocking D3hot PM reset)
- Have broken bus reset implementations
- Need power cycle for reliable reset
- Are used in VFIO passthrough scenarios

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v3: Implement d3cold as a general PCI core reset method instead of
  device-specific quirk approach from v2 (Alex Williamson suggestion)
v2: https://lore.kernel.org/all/20260508145153.717641-2-jtornosm@redhat.com/

 drivers/pci/pci.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  2 +-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..6da8feff7ccc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4491,6 +4491,46 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	return ret;
 }
 
+/**
+ * pci_d3cold_reset - Put device into D3cold (or D3hot) and back to D0 for reset
+ * @dev: PCI device to reset
+ * @probe: if true, check if D3cold reset is supported; if false, perform reset
+ *
+ * Attempt to reset the device by transitioning through D3cold and back to D0.
+ * On platforms with ACPI _PR3 power resources, this performs a true D3cold
+ * power cycle (actual power removal). On platforms without _PR3 support,
+ * pci_set_power_state() automatically falls back to D3hot, providing a
+ * D3hot->D0 reset transition.
+ *
+ * Only available for single-function devices to avoid affecting other
+ * functions in multi-function devices.
+ *
+ * Returns 0 if device can be/was reset this way, -ENOTTY if not supported,
+ * or other negative error code on failure.
+ */
+static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
+{
+	int ret;
+
+	if (dev->multifunction)
+		return -ENOTTY;
+
+	if (probe) {
+		if (!pci_pr3_present(dev))
+			pci_dbg(dev, "d3cold reset: no _PR3 support, will use D3hot fallback\n");
+		return 0;
+	}
+
+	if (dev->current_state != PCI_D0)
+		return -EINVAL;
+
+	ret = pci_set_power_state(dev, PCI_D3cold);
+	if (ret)
+		return ret;
+
+	return pci_set_power_state(dev, PCI_D0);
+}
+
 /**
  * pcie_wait_for_link_status - Wait for link status change
  * @pdev: Device whose link to wait for.
@@ -5065,6 +5105,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
+	{ pci_d3cold_reset, .name = "d3cold" },
 };
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..1ca7b880ead7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.53.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C781388890
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274424; cv=none; b=Cp54h/2aVPF1aOlt4sGo/pKaRizjXO2ffvwhb9a+mo8i5MZZB4c3N0P4vbhBWN7uak+7I3fNK8Pw/4nlnQp/rD5OuKzuCNojU6rRqj64Otz+c68RKHN4NcS9voNAj9bw+cQuzuoVFT7npGPgEXRGJb4n/q0SGFF+hFLAYZqMiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274424; c=relaxed/simple;
	bh=d3WgDjpu2x8otTXEevPDJQZBVp0KfQcGkGPkob30UJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsGlqXPOC8D1oU5ZCqVDnNmmIDICZ9y6ZT8PCRRZSFYHwMnkbZT70VpbK2Gwr7atyD+TUIT7NZldDhyxM8FXK2eZyUahsJCfqe3o0bY9CBzjaAdj/STYet6TnmZ/rgzNIx63EuXPDyZFZb9qFr4qtQM5Xq0C0/h627mfw8BELpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCmhQ0TW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCmhQ0TW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781274422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+9WVanvaDPGBZOyMlBen4PPe6xSb3aQF/JsFC1M/M8M=;
	b=ZCmhQ0TWtDKXWYHToCiFpjt3vBGUR93YQnv51/Lf/erTtLIy5URkkSxSkYW0SSBkPAfxnt
	DOcEZrGedxZSfrYslTcZmxZtQTUOyCPvoYvE+6Lssf76KU95t+QSGItmYWIR9lXr8zHN7l
	nrw9j1dm7YxiK2vD0at8BUq7EnxGn8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-Ykr_fRK1MZK2zdPPqwysZA-1; Fri,
 12 Jun 2026 10:26:59 -0400
X-MC-Unique: Ykr_fRK1MZK2zdPPqwysZA-1
X-Mimecast-MFC-AGG-ID: Ykr_fRK1MZK2zdPPqwysZA_1781274417
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C074118005A6;
	Fri, 12 Jun 2026 14:26:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EA2030001A1;
	Fri, 12 Jun 2026 14:26:51 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: jjohnson@kernel.org,
	mani@kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Date: Fri, 12 Jun 2026 16:26:38 +0200
Message-ID: <20260612142638.1243895-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
lack working reset methods for VFIO passthrough scenarios. These devices
have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
broken bus reset.

The problem manifests in VFIO passthrough scenarios:

- WCN6855 WiFi card (17cb:1103): Normal VM operation works fine, including
  clean shutdown/reboot. However, when the VM terminates uncleanly
  (crash, force-off), VFIO attempts to reset the device before it can
  be assigned to another VM. Without a working reset method, the device
  remains in an undefined state, preventing reuse.

- WCN7850 WiFi card (17cb:1107): Same behavior as WCN6855.

- SDX62/SDX65 5G modems (17cb:0308): Never successfully initialize even
  on first VM assignment without proper reset capability.

Add device-specific reset entries for these Qualcomm devices using D3hot
power cycling. Testing shows that despite advertising NoSoftRst+, D3hot
transition provides sufficient reset for VFIO reuse, particularly after
unexpected VM termination. While not a complete reset (BARs preserved),
it provides the only viable reset mechanism for these devices.

Testing was performed on desktop platforms with M.2 WiFi and modem cards
using M.2-to-PCIe adapters, including extensive force-reset cycling to
verify stability.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v9:
  - Complete redesign based on maintainer feedback (Alex Williamson, Bjorn
    Helgaas, Rafael Wysocki): dropped general d3cold infrastructure entirely
    and now just a single patch: the proven D3hot reset for specific
    Qualcomm devices (device-specific reset)
  - Previous v8 patch 1/3 (general d3cold) dropped: concerns about ACPI
    portability, bridge issues, runtime PM, and lack of _PR3 hardware for
    testing.
  - Previous v8 patch 3/3 (quirk_no_bus_reset) already merged for v7.2
v8: https://lore.kernel.org/all/20260609163649.319755-1-jtornosm@redhat.com/

 drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 431c021d7414..bac1edb6c2dc 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4240,6 +4240,41 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+/*
+ * Device-specific reset method for certain Qualcomm devices via D3hot power
+ * cycle.
+ *
+ * These specific Qualcomm devices lack FLR capability, advertise NoSoftRst+
+ * (blocking PM reset), and have broken bus reset. Despite advertising
+ * NoSoftRst+, testing shows that D3hot transition provides sufficient reset
+ * for VFIO reuse, particularly after unexpected VM termination where the
+ * device would otherwise remain in an undefined state. While not a complete
+ * reset (BARs are preserved), it provides the only viable reset mechanism for
+ * these devices in the commented situations.
+ */
+static int reset_qualcomm_d3hot(struct pci_dev *dev, bool probe)
+{
+	int ret;
+
+	if (probe)
+		return 0;
+
+	if (dev->current_state != PCI_D0)
+		return -EINVAL;
+
+	ret = pci_set_power_state(dev, PCI_D3hot);
+	if (ret)
+		return ret;
+	msleep(200);
+
+	ret = pci_set_power_state(dev, PCI_D0);
+	if (ret)
+		return ret;
+	msleep(200);
+
+	return 0;
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4255,6 +4290,9 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_qualcomm_d3hot },  /* WCN6855 */
+	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_qualcomm_d3hot },  /* WCN7850 */
+	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_qualcomm_d3hot },  /* SDX62/SDX65 */
 	{ 0 }
 };
 
-- 
2.54.0


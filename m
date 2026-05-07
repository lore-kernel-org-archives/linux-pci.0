Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CD401A03
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164186; cv=none; b=YUm5ovBDm3HzDbpZetCXQCk1IYCZCPNnRISNRpqHipgp4fZeKKKD1SrNRTGpBgoofYCNkaTzAwaHIhW7cdYe0ZOrE5vEDqF6fXlyR1/ehjOGG2c47qMZS2C6PGLV8OkPVLYGcpuNHhMMpLLztC9a5dHwEJn56V6wkSSsRhOG9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164186; c=relaxed/simple;
	bh=ezmR/KKCPtyWBUwCLXTx1NDZJ26eGNGjHFL8tYzcbi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKHgBq/7eyHfQ1GaHLZ819s7MUc0NXCNGiI+RFMQTfJ/WGAgxgeGlrLBbm07tu2EZtiEBXj2FfsAhj0xe3JI5HuwhsGK5na16snFk/Aysk1s/IGSh5bnFcT2W2pNmUFwW5no+gCA4ZifnYc1Lp8NGN8tzRgYIeM86gf8zyOKZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkleaJYq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkleaJYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778164184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p/Ie+sFcRQTzoKcDR8BzjhL+HxzOxnnOZKDIau57duo=;
	b=EkleaJYq/ooIoJgX6P+n6Q2nGm7iAkhP6gcjj/jLDVjX/M+nTyENVKOBWfF8tv34LWNaam
	5R6yxoTaUmOPX57Egv+xPcOl2CCI6SAGgjrTzDFDzyTlfb7g4zZFCiVfXSJW0Y62xA3+aG
	CKUktGhn5x6agMhHv875vikA6K39rdo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-b3OGTQWWOeW15l0LltNXTA-1; Thu,
 07 May 2026 10:29:38 -0400
X-MC-Unique: b3OGTQWWOeW15l0LltNXTA-1
X-Mimecast-MFC-AGG-ID: b3OGTQWWOeW15l0LltNXTA_1778164177
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60C0218E6A5A;
	Thu,  7 May 2026 14:29:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C99471803A92;
	Thu,  7 May 2026 14:29:26 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH] PCI: Add D3cold reset quirk for devices with broken/missing FLR
Date: Thu,  7 May 2026 16:29:16 +0200
Message-ID: <20260507142916.392983-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Some PCIe devices require D3cold power state transitions for proper
firmware reset when used in VFIO passthrough scenarios, but lack
Function Level Reset (FLR) capability or have incomplete FLR
implementations that don't fully reset firmware state.

Known devices affected:
- Qualcomm ath11k WiFi (17cb:1103) - FLReset-, reset unreliable
- Qualcomm ath12k WiFi (17cb:1107) - FLReset-, reset always fails
- Qualcomm SDX62/SDX65 5G modems (17cb:0308) - FLReset-, never
  initialize in VMs
- MediaTek mt7925e WiFi (14c3:7925) - FLReset+ but broken, reset always
  fails

The problem manifests in two scenarios:

1. WiFi devices (ath11k, ath12k, mt7925e): Normal VM operation works fine,
   including clean shutdown/reboot. However, when the VM terminates
   uncleanly (crash, force-off), VFIO attempts to reset the device before
   it can be assigned to another VM. Because FLR is missing or broken, the
   reset fails and the device remains in an undefined state, preventing
   reuse.

2. Modem devices (SDX62/SDX65): Never successfully initialize even on first
   VM assignment due to lack of proper reset capability.

Add reset_device_d3cold() quirk that performs a simple D3cold->D0
power cycle when the device is bound to vfio-pci. This provides
firmware reset capability for VM reset operations where standard PCI
reset methods are insufficient.

The quirk only applies during VFIO passthrough - native drivers use
their own reset mechanisms and will fall back to standard PCI reset
methods by returning -ENOTTY.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..11d9a8b562e4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4237,6 +4237,40 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+/*
+ * Some devices need D3cold->D0 power cycle for proper firmware reset
+ * when used in VFIO passthrough. Some claim FLReset+ but it's incomplete,
+ * others lack FLR entirely, and standard reset methods don't fully reset
+ * firmware state. On bare metal with native drivers, we skip this and let
+ * the driver handle reset via standard methods.
+ */
+static int reset_device_d3cold(struct pci_dev *dev, bool probe)
+{
+	int ret;
+
+	if (probe)
+		return 0;
+
+	if (!dev->driver || strcmp(dev->driver->name, "vfio-pci") != 0)
+		return -ENOTTY;
+
+	/*
+	 * D3cold->D0 power cycle for firmware reset.
+	 * VFIO has already disabled interrupts and will handle state
+	 * save/restore, so we just do the power transition.
+	 */
+	ret = pci_set_power_state(dev, PCI_D3cold);
+	if (ret && ret != -EIO)
+		pci_warn(dev, "D3cold transition failed: %d\n", ret);
+
+	ret = pci_set_power_state(dev, PCI_D0);
+	if (ret && ret != -EIO)
+		pci_warn(dev, "D0 transition failed: %d\n", ret);
+
+	pci_info(dev, "D3cold reset completed\n");
+	return 0;
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4252,6 +4286,10 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_device_d3cold },     /* Qualcomm ath11k WiFi */
+	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_device_d3cold },     /* Qualcomm ath12k WiFi */
+	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_device_d3cold },     /* Qualcomm SDX62/SDX65 5G modem */
+	{ PCI_VENDOR_ID_MEDIATEK, 0x7925, reset_device_d3cold }, /* MediaTek mt7925e WiFi */
 	{ 0 }
 };
 
-- 
2.53.0


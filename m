Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677401514E4;
	Wed, 21 May 2025 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747869348; cv=none; b=AiZ59hWcfOZ9EtpixaE+lkO6oxDHOfKsG986rorHQtRVNwM0NO04aIf88JxMZm4J6VNuorAYq6XZA29daLoJm2fcDfpe+fZ+7E9+IA6KSueQeW43jfdkpJh3Xue5Rhlnx1KL7NeGg3UQVkN4+NPKyk1ZCyyq3KRmZcrbgJsvUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747869348; c=relaxed/simple;
	bh=UZH8O/yFhlSvBGj6PPR/eSxBbfCrW3GJCL7zdOrXI3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B6twH4+bip2CnoqKxDDfMrkNL1RSRAISAMnqdeix58bRwD5/faJQc/LlCbf3BuncaoZPGud3EGFk3vBPhMuaW0lfqEpoFSVI9RdZnFVRsN7jHwm3K3wsswX7uv56A7Yr4Abwm35hN1amlz2VXpeGOl0gFBtf53VwYT6RnYj8CBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=exd+CbyU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="exd+CbyU"
Received: from CPC-grwhy-1BDK8.redmond.corp.microsoft.com (unknown [70.37.26.36])
	by linux.microsoft.com (Postfix) with ESMTPSA id EF091206833B;
	Wed, 21 May 2025 16:15:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF091206833B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747869341;
	bh=PNaUsQe2aYaNXAl5aCvXXrNudZA8LGO1pKKU6yDFpC8=;
	h=From:To:Cc:Subject:Date:From;
	b=exd+CbyU6iS7yU7B+s03INckHHHJCYjYooxmbdv6w8PoNcw1HkhoNex/sh3LZzTnx
	 1ui0b2A7995TiYnqm7V01gxArc+PYVcgPWbAezxdJIwHYt552jEX1xcoTH/993eccz
	 c94wWxaBVm9XmY6mQzBdHbLGeG9q82BDsM8ssMGc=
From: grwhyte@linux.microsoft.com
To: linux-pci@vger.kernel.org
Cc: shyamsaini@linux.microsoft.com,
	code@tyhicks.com,
	Okaya@kernel.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Reduce delay after FLR of Microsoft MANA devices
Date: Wed, 21 May 2025 23:15:39 +0000
Message-Id: <20250521231539.815264-1-grwhyte@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Graham Whyte <grwhyte@linux.microsoft.com>

Add a device-specific reset for Microsoft MANA devices with the FLR
delay reduced from 100ms to 10ms. While this is not compliant with the pci
spec, these devices safely complete the FLR much quicker than 100ms and
this can be reduced to optimize certain scenarios

Signed-off-by: Graham Whyte <grwhyte@linux.microsoft.com>
---
 drivers/pci/pci.c    |  3 ++-
 drivers/pci/pci.h    |  1 +
 drivers/pci/quirks.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9cb1de7658b5..ad2960117acd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1262,7 +1262,7 @@ void pci_resume_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_resume_one, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 {
 	int delay = 1;
 	bool retrain = false;
@@ -1344,6 +1344,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_dev_wait);
 
 /**
  * pci_power_up - Put the given device into D0
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f2958318d259..3a98e00eb02a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -109,6 +109,7 @@ void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int __pci_reset_bus(struct pci_bus *bus);
+int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout);
 
 struct pci_cap_saved_data {
 	u16		cap_nr;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c354276d4bac..94bd2c82cbbd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4205,6 +4205,55 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+#define MSFT_PCIE_RESET_READY_POLL_MS 60000 /* msec */
+#define MICROSOFT_2051_SVC 0xb210
+#define MICROSOFT_2051_MANA_MGMT 0x00b8
+#define MICROSOFT_2051_MANA_MGMT_GFT 0xb290
+
+/* Device specific reset for msft GFT and gdma devices */
+static int msft_pcie_flr(struct pci_dev *dev)
+{
+	if (!pci_wait_for_pending_transaction(dev))
+		pci_err(dev, "timed out waiting for pending transaction; "
+			"performing function level reset anyway\n");
+
+	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
+
+	if (dev->imm_ready)
+		return 0;
+
+	/*
+	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress. However, 100ms is much longer than required for modern
+	 * devices, so we can afford to reduce the timeout to 10ms.
+	 */
+	usleep_range(10000, 10001);
+
+	return pci_dev_wait(dev, "FLR", MSFT_PCIE_RESET_READY_POLL_MS);
+}
+
+/*
+ * msft_pcie_reset_flr - initiate a PCIe function level reset
+ * @dev: device to reset
+ * @probe: if true, return 0 if device can be reset this way
+ *
+ * Initiate a function level reset on @dev.
+ */
+static int msft_pcie_reset_flr(struct pci_dev *dev, bool probe)
+{
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
+		return -ENOTTY;
+
+	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return msft_pcie_flr(dev);
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4220,6 +4269,12 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_SVC,
+		msft_pcie_reset_flr},
+	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT,
+		msft_pcie_reset_flr},
+	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT_GFT,
+		msft_pcie_reset_flr},
 	{ 0 }
 };
 
-- 
2.25.1


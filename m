Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7435C1B7
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907809; cv=none; b=IbnyKIp7vWhOpPi3GOHy6RGy/8ipGx4x/P47RY1maDy2K61Wtp2JQhc0mtiGvblKIrZHzmSWH+wjMBtW4mHfa+6a+lZ8e+NXvOTnlhcZTaVpXY+WbNfQjxPyZM9TIrKVvXNGUHDBgJ+a8VboAMa/hKAeke+fixQJIcHs0CC0UCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907809; c=relaxed/simple;
	bh=4GDblstlsCDueqIubrTthUM32CZg2GleNHsWoczy0GQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=daASKM7AfIlPJu+hOoWbUksv7j9yDVYY0ENDTLNyoSbiV7ozphNVxefjcjm5nQnV7ZGIttwb1URHQiSvhPVwhNMNjz2rAifM/kYZ71BkDjJ8Er8ZIqaMuVvhy8P1PPBave3wXCpzCfrYNesPLOf944V36szg1hQ+9yAgql2i+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id DB25835E;
	Fri, 24 Jul 2026 17:43:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C811960CF04D; Fri, 24 Jul 2026 17:43:18 +0200 (CEST)
Message-ID: <d983b813043c518d098e2919161e816b91f15862.1784905909.git.lukas@wunner.de>
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:02 +0200
Subject: [PATCH 2/6] PCI/AER: Log agent & layer for each individual error
To: Bjorn Helgaas <helgaas@kernel.org>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Qingshun Wang <qingshun.wang@linux.intel.com>, Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Terry Bowman <terry.bowman@amd.com>. Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Arjun Govindjee <agovindjee@purestorage.com>, Ashish Karkare <ashishk@purestorage.com>, Jasjeet Rangi <jrangi@purestorage.com>, Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com, sconnor@purestorage.com, an.luo@enflame-tech.com, fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com, xin.wang@enflame-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The AER driver maps detected errors to the corresponding agent and layer
per PCIe r7.0 sec 6.2.7 and logs both.

If multiple errors were detected, their agent and layer may differ.
However the AER driver only logs one agent and one layer for all of them,
which seems nonsensical.

Log the agent and layer for each individual error instead.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e07d0e05b5d6..9cdac1c8c52e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -558,11 +558,11 @@ static const char *aer_uncorrectable_error_string[] = {
 };
 
 static const char *aer_agent_string[] = {
-	"Receiver ID",
-	"Requester ID",
-	"Completer ID",
-	"Transmitter ID",
-	"Component ID",
+	"Receiver",
+	"Requester",
+	"Completer",
+	"Transmitter",
+	"Component",
 };
 
 #define aer_stats_dev_attr(name, stats_array, strings_array,		\
@@ -844,8 +844,8 @@ static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	const char **strings;
 	unsigned long status = info->status & ~info->mask;
+	const char *errmsg, *agent, *layer;
 	const char *level = info->level;
-	const char *errmsg;
 	int i;
 
 	if (info->severity == AER_CORRECTABLE)
@@ -855,10 +855,17 @@ static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	for_each_set_bit(i, &status, 32) {
 		errmsg = strings[i];
-		if (!errmsg)
+		agent = aer_agent_string[AER_GET_AGENT(info->severity, BIT(i))];
+		layer = aer_error_layer[AER_GET_LAYER_ERROR(info->severity,
+								       BIT(i))];
+		if (!errmsg) {
 			errmsg = "Unknown Error Bit";
+			agent = "";
+			layer = "";
+		}
 
-		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
+		aer_printk(level, dev, "  [%2d] %-17s | %-11s | %-17s%s\n",
+			   i, errmsg, agent, layer,
 				info->first_error == i ? " (First)" : "");
 	}
 }
@@ -879,9 +886,9 @@ static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
 void aer_print_error(struct aer_err_info *info, int i)
 {
 	struct pci_dev *dev;
-	int layer, agent, id;
 	const char *level = info->level;
 	const char *bus_type = aer_err_bus(info);
+	int id;
 
 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
 		return;
@@ -897,17 +904,13 @@ void aer_print_error(struct aer_err_info *info, int i)
 		return;
 
 	if (!info->status) {
-		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+		pci_err(dev, "%s Bus Error: severity=%s (Inaccessible)\n",
 			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
-	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
-	agent = AER_GET_AGENT(info->severity, info->status);
-
-	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
-		   bus_type, aer_error_severity_string[info->severity],
-		   aer_error_layer[layer], aer_agent_string[agent]);
+	aer_printk(level, dev, "%s Bus Error: severity=%s\n",
+		   bus_type, aer_error_severity_string[info->severity]);
 
 	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
 		   dev->vendor, dev->device, info->status, info->mask);
@@ -940,8 +943,8 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	int tlp_header_valid = 0;
 	const char *bus_type;
-	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
 		.severity = aer_severity,
@@ -972,14 +975,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (!aer_ratelimit(dev, info.severity))
 		return;
 
-	layer = AER_GET_LAYER_ERROR(aer_severity, status);
-	agent = AER_GET_AGENT(aer_severity, status);
-
 	aer_printk(info.level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
 		   status, mask);
 	__aer_print_error(dev, &info);
-	aer_printk(info.level, dev, "aer_layer=%s, aer_agent=%s\n",
-		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	if (aer_severity != AER_CORRECTABLE)
 		aer_printk(info.level, dev, "aer_uncor_severity: 0x%08x\n",
-- 
2.53.0


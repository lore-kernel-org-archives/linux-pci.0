Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6830C629
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908944; cv=none; b=T5B1kKr4ahg7CnRFgjMYpSwQ5q2TR3prSf8O894Brv3frQufFk1y7wMEUWZQYF+xu/Pi8S7xQxUWaRYBUwC0Ft4EZqlAnC4DH3EsT0HkqfcvYDDtvDQNf9JbxG/s5VocuNr8sloHbiGnqqnAB2L0TZqlrrxnshqleOzjbfhSy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908944; c=relaxed/simple;
	bh=p+aN+uIZMF644Gcopa3f6CH/7HD1WboeZWVw5cXvS1o=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=ZMwnQseREt/X4zkiOJsrbOV7xWUYtLP9DGAyujy9/Ykeuz4sz9IVGULnOazd0PguQPMAd/1T4RtuefzkWWpOL4kenOwE+ErkZdrvNKc+HLBhfjDHJsyvXLR1TA3xQTnm7RdgLdxyOlsb8JYvh4cpKS5/xzrL+7AyraUNi9Tm8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 8BBF535E;
	Fri, 24 Jul 2026 18:02:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6A3C760CF04D; Fri, 24 Jul 2026 18:02:20 +0200 (CEST)
Message-ID: <0f2f037c7ccf099f0c253cbc4ad9be526c68c5af.1784905909.git.lukas@wunner.de>
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:05 +0200
Subject: [PATCH 5/6] PCI/AER: Move retrieval of FEP and TLP Log into helper
To: Bjorn Helgaas <helgaas@kernel.org>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Qingshun Wang <qingshun.wang@linux.intel.com>, Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Terry Bowman <terry.bowman@amd.com>. Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Arjun Govindjee <agovindjee@purestorage.com>, Ashish Karkare <ashishk@purestorage.com>, Jasjeet Rangi <jrangi@purestorage.com>, Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com, sconnor@purestorage.com, an.luo@enflame-tech.com, fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com, xin.wang@enflame-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

When aer_get_device_error_info() gathers information on Uncorrectable
Errors from a device, it reads the First Error Pointer and TLP Prefix/
Header Log and caches them in struct aer_err_info.

Those two fields will also need to be read for Advisory Non-Fatal Errors
(which are signaled as Correctable Errors).  Move their retrieval into a
new aer_get_uncor_info() helper for reuse by the imminent Advisory
Non-Fatal Error support.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4d1d99662086..c196c94f43d7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1289,6 +1289,27 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif
 
+static void aer_get_uncor_info(struct pci_dev *dev, struct aer_err_info *info,
+			       u32 status)
+{
+	u16 aer = dev->aer_cap;
+	u32 aercc;
+
+	/* Get First Error Pointer */
+	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
+	info->first_error = PCI_ERR_CAP_FEP(aercc);
+
+	/* Get TLP Prefix/Header Log */
+	if (tlp_header_logged(status, aercc)) {
+		info->tlp_header_valid = 1;
+		pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
+				  aer + PCI_ERR_PREFIX_LOG,
+				  aer_tlp_log_len(dev, aercc),
+				  aercc & PCI_ERR_CAP_TLP_LOG_FLIT,
+				  &info->tlp);
+	}
+}
+
 /**
  * aer_get_device_error_info - read error status from dev and store it to info
  * @info: pointer to structure to store the error record
@@ -1302,7 +1323,6 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 {
 	struct pci_dev *dev;
 	int type, aer;
-	u32 aercc;
 
 	if (i >= AER_MAX_MULTI_ERR_DEVICES)
 		return 0;
@@ -1340,18 +1360,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 		if (!(info->status & ~info->mask))
 			return 0;
 
-		/* Get First Error Pointer */
-		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
-		info->first_error = PCI_ERR_CAP_FEP(aercc);
-
-		if (tlp_header_logged(info->status & ~info->mask, aercc)) {
-			info->tlp_header_valid = 1;
-			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
-					  aer + PCI_ERR_PREFIX_LOG,
-					  aer_tlp_log_len(dev, aercc),
-					  aercc & PCI_ERR_CAP_TLP_LOG_FLIT,
-					  &info->tlp);
-		}
+		aer_get_uncor_info(dev, info, info->status & ~info->mask);
 	}
 
 	return 1;
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998647;
	b=FZ5DEFPT9kUxaLqrluz3cpRgp9AKMZB+hQF3fFdSjw9XmxyQslMflhKEhgCs4/4a07Vw
	 FTgcn37Us4eAzTC6FN4e4tBzumNsTA3afGlfaiq7RhWjFnaS+7HLtqWCVFxo/Nrb+FVhn
	 Pa391DUTgnJFLDq8tiX2zyz+KBaUIrGGGEBpwSsw+i/4MQF4dNjxmehMzvQ10S4fFAxbP
	 +ons9u5sfjUBWHBfmpUKhZRCU0RbfTBewsl8iWHXyZGOVD7JAaDoStbzuHGc+EUe3PKl3
	 gLFYNGxDE+k4dN+jb6wUMj5+uw8ki/vCV1tFwnm1JeLtUbTnBCqv9XsXevzz2QFMdHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998647;
	h=DMARC-Filter:Received:Received:Message-ID:In-Reply-To:References:
	 From:Date:Subject:To:Cc;
	bh=zXpUKWW6Hx2bk+Iwk827DIeBENgbMoEUuiov/SIQQsQ=;
	b=eTf5BJL2q1K7GIvALcM3nLLvcQewBR4zH5GLJGv+3ieB/60TjdT9/I0QC34uGMsoAzcr
	 qskAKJFTeDTEQgznkQtNVLrjZSEQTxssCJXW2FTkp80Li/Rc5gRjFv/xKYC01fbgzlF6m
	 a3GHfUaiYaRk9BNtbpCGXMDDaB3GJm+YBLPIUY0K2YBBz7nBpugaq1SjUWmLjQLzrTy3J
	 HL4Zia9K+VkVmpYG+4jp/jNX7IpiEUlW1AlAoTkJD5nx88faWLSQMy7SHLDql1XHGSGEz
	 6dcNUaq81tZZe3WmflxVPrhiKBzKYaYU38+UdnA+2YliU5kX5SrYjjQjqqHXrWtRovA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443EB606A325
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 10:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 443EB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id B42D6414F;
	Wed, 18 Nov 2026 11:44:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8E2036000333; Wed, 18 Nov 2026 11:44:05 +0100 (CET)
Message-ID: <8ab33b2307e9136719f72ccc2d9f946417651eab.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:03 +0100
Subject: [PATCH v2 3/7] PCI/ERR: Clear error status bits more selectively
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Darshit Shah <darnshah@amazon.de>, Jason Perlow <jperlow@gmail.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

After recovery from a PCIe error, all of the error status bits in the
Device Status register are cleared indiscriminately, regardless of the
error's severity.

So when a Correctable Error occurs simultaneously to an Uncorrectable
Error, after the former is handled, it is cleared alongside the latter.
As a result, the Uncorrectable Error isn't handled at all.

Conversely, an Uncorrectable Error occurring shortly before a Correctable
Error may cause the latter to be cleared and thus ignored.

Avoid by clearing only the error bits corresponding to the error severity
being handled.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v1 -> v2:
  * New patch to clear error status bits more selectively (sashiko).
 
 drivers/pci/pcie/aer.c | 20 +++++++++++++++++++-
 drivers/pci/pcie/err.c |  7 ++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6f2460231422..51cf2ff8c85a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -141,6 +141,12 @@ struct aer_info {
 					PCI_ERR_ROOT_MULTI_COR_RCV |	\
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
+static const u8 severity2devsta[] = {
+	[AER_NONFATAL]    = PCI_EXP_DEVSTA_NFED,
+	[AER_FATAL]       = PCI_EXP_DEVSTA_FED,
+	[AER_CORRECTABLE] = PCI_EXP_DEVSTA_CED,
+};
+
 static bool pcie_aer_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
@@ -1314,6 +1320,17 @@ bool is_aer_internal_error(struct aer_err_info *info)
 }
 #endif
 
+static void pcie_clear_device_status_sev(struct pci_dev *dev, u8 severity,
+					 u32 uncor_status)
+{
+	u16 devsta = severity2devsta[severity];
+
+	if (uncor_status & PCI_ERR_UNC_UNSUP)
+		devsta |= PCI_EXP_DEVSTA_URD;
+
+	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, devsta);
+}
+
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
@@ -1344,7 +1361,8 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 			if (pdrv && pdrv->err_handler &&
 			    pdrv->err_handler->cor_error_detected)
 				pdrv->err_handler->cor_error_detected(dev);
-			pcie_clear_device_status(dev);
+			pcie_clear_device_status_sev(dev, AER_CORRECTABLE,
+						     info->anfe_status);
 		}
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 1a7fc71c79d8..24a8a8263c2e 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -21,6 +21,10 @@
 #include "portdrv.h"
 #include "../pci.h"
 
+#define PCI_EXP_DEVSTA_UNC_MASK	(PCI_EXP_DEVSTA_NFED | \
+				 PCI_EXP_DEVSTA_FED | \
+				 PCI_EXP_DEVSTA_URD)
+
 static pci_ers_result_t merge_result(enum pci_ers_result orig,
 				  enum pci_ers_result new)
 {
@@ -274,7 +278,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * signaling device may not even be visible to the OS.
 	 */
 	if (host->native_aer) {
-		pcie_clear_device_status(dev);
+		pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
+					   PCI_EXP_DEVSTA_UNC_MASK);
 		pci_aer_clear_nonfatal_status(dev);
 	}
 
-- 
2.53.0


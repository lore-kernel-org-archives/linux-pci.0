Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF783783B5
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533123; cv=none; b=b4Z192Gj9FPbb11/UmcfljVFjiMkx/YlCDGgCctN3eExzELId8RonMwPHKRqp2ngnY6aYqj+uvOIMvrJod9KxvkkbwZ1HAvPSSZ/4+HswIz/m8z6vDsJcgCa993En3bLn7ZaSja2oSBMCt3fDKi8p6MSKggrVWxsy9YM3OQSL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533123; c=relaxed/simple;
	bh=dE9PkOyXqY//6rIbUTB5KI+seevk/GuxonZsox/D4/Y=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=Jj8TkMyJR9btLpSi5oRyC9s4jLw41atp+kXOmnv/qJud0mN9AaxdKRuXEIjRlswZ674l/WvjA6ZZ8HAzouSiY3tQx+J5MgelGMX172fs8T88xmoildgv4PpbuiXsNXOhgBs44Abt4KE/k4QSlZKQRhIAZTg8aBRMyypmJXYE3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 327DC70A0;
	Sun, 27 Sep 2026 20:18:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2D7C0625294D; Sun, 27 Sep 2026 20:18:39 +0200 (CEST)
Message-ID: <244713dea3786099e9ad4eb10ff9f2f430cd7ad3.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:06 +0200
Subject: [PATCH 6/7] PCI/AER: Renumber severity constants
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The AER driver uses constants for Correctable, Non-Fatal and Fatal Error
severity which look as if they match something in the spec, but are
actually just made-up numbers.

Use the bit number in the Device Status Register instead (PCIe r7.1 sec
7.5.3.5).  A subsequent commit takes advantage of this by using BIT() to
conveniently compute the register bit corresponding to a given severity.

While at it, drop the DPC_FATAL constant which was introduced by commit
b09803b5e546 ("PCI/DPC: Use the generic pcie_do_fatal_recovery() path")
but never saw any use in 8 years.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer.c  | 2 +-
 include/linux/aer.h     | 8 ++++----
 include/ras/ras_event.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 34a8eddc427a..6bc843ab9b37 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -504,9 +504,9 @@ void pci_aer_exit(struct pci_dev *dev)
  * AER error strings
  */
 static const char * const aer_error_severity_string[] = {
+	"Correctable",
 	"Uncorrectable (Non-Fatal)",
 	"Uncorrectable (Fatal)",
-	"Correctable"
 };
 
 static const char *aer_error_layer[] = {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index df0f5c382286..795c55132008 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -11,10 +11,10 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 
-#define AER_NONFATAL			0
-#define AER_FATAL			1
-#define AER_CORRECTABLE			2
-#define DPC_FATAL			3
+/* Must match bit number in Device Status Register (PCIe r7.1, sec 7.5.3.5) */
+#define AER_CORRECTABLE			0
+#define AER_NONFATAL			1
+#define AER_FATAL			2
 
 /*
  * AER and DPC capabilities TLP Logging register sizes (PCIe r6.2, sec 7.8.4
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index fdb785fa4613..1e03ade99386 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -302,7 +302,7 @@ TRACE_EVENT(non_standard_event,
  *			([domain:]bus:device.function).
  * u32 status -		Either the correctable or uncorrectable register
  *			indicating what error or errors have been seen
- * u8 severity -	error severity 0:NONFATAL 1:FATAL 2:CORRECTED
+ * u8 severity -	error severity 0:CORRECTED 1:NONFATAL 2:FATAL
  */
 
 #define aer_correctable_errors					\
-- 
2.53.0


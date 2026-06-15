Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF13F410A
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530111; cv=none; b=mk0EmEa/O/YXUlHI+vXZyoaDzTjN4KWGooXXVG8SvMpm9mqJkNP8Q9v3DOOGiYFFqSP4bOCycwfKXB3ohGpOFScPELymZIU5PT5yzcyZJmC1stV1GTvZb0o0ht+Y6GZNEXQc+fwL12945bMfiuvMDNV8J8/tM2pt5F/dC2vk+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530111; c=relaxed/simple;
	bh=C08qkmQPoPQU/ScYvUW+JTSposABCSApDCgHvXzmWHg=;
	h=Message-Id:From:Date:Subject:To:Cc; b=kM9NJ4PRU+stUT7nqhcjWL7++t/B4V1NqheeB10U8T+hh+mkiI+K1HkhICxRjiZA71DtIC/eq8IlyzDsxaVkxYpryBsLSbBNGyFJRn/WHU41K2Nl6I6HpHnqSQYyuj6pWRj/kXeqahNivvzeTRv40BPIHIU81ol0wpfTd3COqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 32D1610E07;
	Mon, 15 Jun 2026 15:19:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2D8846018168; Mon, 15 Jun 2026 15:19:24 +0200 (CEST)
Message-Id: <7bdfaf14d7e5a466f3f650150c688a60e947a7a9.1781527060.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 15 Jun 2026 15:19:30 +0200
Subject: [PATCH] PCI/TSM: Resume device to D0 for CMA-SPDM operation
To: Dan Williams <djbw@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: Vivaik Balasubrawmanian <vivaik.balasubrawmanian@intel.com>, John Allen <john.allen@amd.com>, Bjorn Helgaas <helgaas@kernel.org>, linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Yilun Xu <yilun.xu@linux.intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Alexey Kardashevskiy <aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Per PCIe r7.0 sec 6.31.3, CMA-SPDM operation in non-D0 states is optional.
The spec does not define a way to determine if it's supported, so resume
to D0 unconditionally for the duration of a CMA-SPDM exchange.  Vivaik has
talked to Windows engineers and they said that Windows does the same.

Note that for plain DOE operation, it is sufficient for the device to be
in D3hot and its parents in D0 because config space remains accessible in
D3hot.  So CMA-SPDM goes beyond the requirements of plain DOE and hence
resuming to D0 needs to (only) be done in code paths which use DOE
specifically for CMA-SPDM.

The pattern used herein for runtime resume is the best practice introduced
by commit ef8057b07c72 ("PM: runtime: Wrapper macros for ACQUIRE()/
ACQUIRE_ERR()").

Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encryption")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.19+
Cc: Vivaik Balasubrawmanian <vivaik.balasubrawmanian@intel.com>
---
We're in the merge window for v7.2 and this isn't super urgent,
so it's targeting v7.3 via tsm.git/next.

Technically I'd have permission to apply myself,
but I wouldn't want to without acks from Dan and AMD!
Thanks for taking a look!

 drivers/crypto/ccp/sev-dev-tsm.c | 6 ++++++
 drivers/pci/tsm.c                | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
index b07ae52..108204f7 100644
--- a/drivers/crypto/ccp/sev-dev-tsm.c
+++ b/drivers/crypto/ccp/sev-dev-tsm.c
@@ -7,6 +7,7 @@
 #include <linux/tsm.h>
 #include <linux/iommu.h>
 #include <linux/pci-doe.h>
+#include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <linux/module.h>
 
@@ -30,6 +31,7 @@ static int sev_tio_spdm_cmd(struct tio_dsm *dsm, int ret)
 {
 	struct tsm_dsm_tio *dev_data = &dsm->data;
 	struct tsm_spdm *spdm = &dev_data->spdm;
+	int pm_ret;
 
 	/* Check the main command handler response before entering the loop */
 	if (ret == 0 && dev_data->psp_ret != SEV_RET_SUCCESS)
@@ -38,6 +40,10 @@ static int sev_tio_spdm_cmd(struct tio_dsm *dsm, int ret)
 	if (ret <= 0)
 		return ret;
 
+	PM_RUNTIME_ACQUIRE(&dsm->tsm.base_tsm.pdev->dev, pm);
+	if ((pm_ret = PM_RUNTIME_ACQUIRE_ERR(&pm)))
+		return pm_ret;
+
 	/* ret > 0 means "SPDM requested" */
 	while (ret == PCI_DOE_FEATURE_CMA || ret == PCI_DOE_FEATURE_SSESSION) {
 		ret = pci_doe(dsm->tsm.doe_mb, PCI_VENDOR_ID_PCI_SIG, ret,
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 5fdcd7f..af1817e 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
+#include <linux/pm_runtime.h>
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
 #include <linux/xarray.h>
@@ -886,6 +887,7 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz)
 {
 	struct pci_tsm_pf0 *tsm;
+	int rc;
 
 	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
 		return -ENXIO;
@@ -894,6 +896,10 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 	if (!tsm->doe_mb)
 		return -ENXIO;
 
+	PM_RUNTIME_ACQUIRE(&pdev->dev, pm);
+	if ((rc = PM_RUNTIME_ACQUIRE_ERR(&pm)))
+		return rc;
+
 	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
 		       resp, resp_sz);
 }
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7EE31B80D;
	Fri, 19 Jun 2026 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859130; cv=none; b=qOldr5wv06Zen5FJ/JFPb+4YpmU19kkgpYqqr4o0MMn4B0um8Z56jGcfpywZBDQNzKhI1Df80P7ZeryEwrYz/aX5Hd9Dnef0FlerCUvOTQItT6UDh/9jzi/U4Jn4dsSaOWn+Q/nb5ub/M4cfmm7Z2nEc4dbWJ6kkxQHkDUruSQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859130; c=relaxed/simple;
	bh=WDwPTNTG/aheF+IOBPlfAuOF6nc7TH5sfeRITWefefY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WB5sfD/EVix+1X3BJ36Mla6EdtSy0XpONCFosh/kb33iFl/y+MS4+zhYnYXESL59fBO7YsfJXWbq5ENQgV15bCYNCP9wPgM6wAbQZZnRIen0tAMXwmfFaDhRnB1hSxOdS3QqITNoi4nt3oPe7qPg8Q3PshFmM+bRgGf7UC+wwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm045v6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm045v6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B261F000E9;
	Fri, 19 Jun 2026 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859128;
	bh=1xP9Elz8G9gYa3ky+C5oo0oSwd4JFSUlfxkzHa8jlKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pm045v6Sk8A3Jcb6IESBn+nq11xekVlXKRBu7DJ/WBhCZsIQ+PrLE1CnwftYEmMeV
	 FcLMjYszoiStPo88QyDe/jjkJDCSd96Ja1z4LsUt4B9Ikz0JWETpuUuuvT0g0mo2vA
	 jYIPbxaymC/jCoBk1okrdPJHqRFh9tXDvnpoZ1O1AwCUv7gyxapuWhgDYmg+l3W0gu
	 MzKe2RQgvW10YTZmLPZPPC62c8CvbHssnzlOCMdxGqRm9o5Oih2Yn6uDRNGwWJq2U1
	 Ejzkf33KD+dmpBPAQv9cvOdpIizVqMJtBA438ciUy6PlXg8BxX9kBTA0CMOTrQLUF5
	 QsiOMGQviwj5w==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 01/25] PCI/sysfs: Use PCI resource accessor macros
Date: Fri, 19 Jun 2026 08:51:36 +0000
Message-ID: <20260619085200.3729431-2-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace direct pdev->resource[] accesses with pci_resource_n(),
and pdev->resource[].flags accesses with pci_resource_flags().

No functional changes intended.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..1fbc3daf87cc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -177,7 +177,7 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 		max = PCI_BRIDGE_RESOURCES;
 
 	for (i = 0; i < max; i++) {
-		struct resource *res =  &pci_dev->resource[i];
+		struct resource *res = pci_resource_n(pci_dev, i);
 		struct resource zerores = {};
 
 		/* For backwards compatibility */
@@ -689,7 +689,7 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 		return sysfs_emit(buf, "%u\n", (pdev == vga_dev));
 
 	return sysfs_emit(buf, "%u\n",
-			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
+			  !!(pci_resource_flags(pdev, PCI_ROM_RESOURCE) &
 			     IORESOURCE_ROM_SHADOW));
 }
 static DEVICE_ATTR_RO(boot_vga);
@@ -1082,7 +1082,7 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int bar = (unsigned long)attr->private;
 	enum pci_mmap_state mmap_type;
-	struct resource *res = &pdev->resource[bar];
+	struct resource *res = pci_resource_n(pdev, bar);
 	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
@@ -1286,7 +1286,7 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 		retval = pci_create_attr(pdev, i, 0);
 		/* for prefetchable resources, create a WC mappable file */
 		if (!retval && arch_can_pci_mmap_wc() &&
-		    pdev->resource[i].flags & IORESOURCE_PREFETCH)
+		    pci_resource_flags(pdev, i) & IORESOURCE_PREFETCH)
 			retval = pci_create_attr(pdev, i, 1);
 		if (retval) {
 			pci_remove_resource_files(pdev);
-- 
2.54.0


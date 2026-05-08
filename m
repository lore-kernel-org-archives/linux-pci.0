Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466D1EE01A;
	Fri,  8 May 2026 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214952; cv=none; b=rNshK3VaCHGDp8WbBfeXCzwTXauqKtSMbSYJkgGjwCMXgAGd94b66EdiDS7Gb4M0NdoBAhZvAPOO+az3oOoRgdpgbqlM7a67eJ9wfdkzFwiSOgK7GVKOVrs1OXG6+LlkpoE6oPYrlwqePAQZmOPHG25UkcMkPT4w74hls3CNePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214952; c=relaxed/simple;
	bh=WDwPTNTG/aheF+IOBPlfAuOF6nc7TH5sfeRITWefefY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcoT9MJsUkw48v4WYInK6GGoaNcWmuTGsq9aIlsTmzScUi0XwUllZpoURkbkhpUAnS5EAY4FviMheGIs4FsuT7mCNS7YotiJ+cpyx6kw1JhYQhF3t6529hST58mqM78sKWNYgoAYzJABotNtPKKtXG+0Mj0dNt0mjWh3IWn07XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSX0Q8P9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSX0Q8P9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF84C2BCB4;
	Fri,  8 May 2026 04:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214952;
	bh=WDwPTNTG/aheF+IOBPlfAuOF6nc7TH5sfeRITWefefY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSX0Q8P9O3xCKA1agZ7C+qOu6qFFi4Ulv/QOKaAK2PhJ9diY1idDPEnAI19hbu9dX
	 nrxmZlu6jg0rQA9s7X0DMpvxGzmN+dghu0dwTncyg/Rxzy/NczJRuJxZ6U0J6LwfEq
	 YqtcMeH/HN89A+ltKONnrYc1/kvrdNa9hA/cchlzTG9wFaFyNgpzVACr1jyZes3mZj
	 MAbffU8TxVbFd85lnYY0cxXF/bQzAi8m4CsiIortm+10T6S/nIrGrfpYNM9ed6KXKA
	 Up9ntZLx4IohFr5Lq7b3F/lGAQvLVXPz+Zd9416FoaHZxHUNPiAVT/bpV1Iyt4tHYi
	 ibzM9+nYDo+kA==
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
Subject: [PATCH v7 01/24] PCI/sysfs: Use PCI resource accessor macros
Date: Fri,  8 May 2026 04:35:20 +0000
Message-ID: <20260508043543.217179-2-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
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


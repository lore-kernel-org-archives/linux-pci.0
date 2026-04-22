Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B199A37FF7A;
	Wed, 22 Apr 2026 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874536; cv=none; b=Z7WZcqyHVoUK6AEdsOr0yUmAwzyhnPBEV7O7CFSUnDfN8H5AOyQ9P4J7vzZfqoRNJFZ13MPu0fNWmRkNsS6HKrJPYkIdWcAvVDnUbDMna7LWJz5P+gP6WG9UbMzlOZCizai/j2+OVDdt4y3SqjcuiaG4ScuJ2h9oL1bLLyzJP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874536; c=relaxed/simple;
	bh=dFCDzhXA2zUSnlj0+jJsCYTv9upJPkAyBg063oGGGK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7+yYJZVDeyHdQ46eQ+KKujmejptxUefBOM0al5Qzpbp+PZlWH1HX9hc64kyLpuNiOGKRagOM0fqDhCtLkAOIwkvVAvQyOYGhq3w+v2iFhdaprektVJYjYZz04uAYjESGsE0Wu44cgU1E2ZF/W416XOFlmRa6W4YzqKJ12mpHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8QdmUHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8QdmUHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B917C19425;
	Wed, 22 Apr 2026 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874536;
	bh=dFCDzhXA2zUSnlj0+jJsCYTv9upJPkAyBg063oGGGK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8QdmUHE22S/biCkSxFIOC14JtXTSxgA4FYN2o0neiedaWK8dLMHPunLd4X2UIExa
	 fbzI4bOnwaWE+ngvwJt6ZeJzCYXsZ4kO6kjIWY0MAg3MFhCWc5CzEN0nOs9p93y47Y
	 zdwWd97wxcDcfUK95xpLmLs/yrQiEK5HAcFdj6zOR1/cUGAmz+OT8pWQEyqwEm6gYs
	 sBAMXyqoPbDKR5h4lD0HI4LpjIEnV7b1fkvWyMLYXG3zJvzNLMVek/O0P9fSknydP0
	 /TI104uBsJeLPyuRiCg9eg9mkSmplBo9QzuAoD80kRIv1cbfgTbffByeVS7VwniOQ/
	 NF2QAwy85F9Dw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v6 24/24] PCI/sysfs: Limit BAR resize attribute scope to platforms with PCI mmap
Date: Wed, 22 Apr 2026 16:14:07 +0000
Message-ID: <20260422161407.118748-25-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The resourceN_resize sysfs attributes allow users to resize
Resizable BARs (ReBAR).  After a successful resize, the resource
attribute groups are removed and recreated so that the updated
BAR sizes are reflected in the sysfs files.

Resizable BARs are a PCI Express extended capability
(PCI_EXT_CAP_ID_REBAR), which requires PCIe extended config
space.

Every PCIe-capable architecture defines either HAVE_PCI_MMAP or
ARCH_GENERIC_PCI_MMAP_RESOURCE (via the relevant arch headers
or the generic asm-generic/pci.h fallback).  On platforms that
define neither, the resource files are not created and the sysfs
group remove and create calls in __resource_resize_store() are
no-ops.

Thus, move the resize show and store helpers, the per-BAR attribute
definitions, and the attribute group behind the existing #ifdef
HAVE_PCI_MMAP || ARCH_GENERIC_PCI_MMAP_RESOURCE guard, and fold
the group reference in pci_dev_groups[] into the existing #if block.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b167e32d55ac..37c1990124d0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1690,6 +1690,7 @@ static const struct attribute_group pci_dev_reset_method_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1804,6 +1805,7 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
 	.is_visible = resource_resize_attr_is_visible,
 };
+#endif
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
@@ -1878,8 +1880,8 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_resource_io_attr_group,
 	&pci_dev_resource_uc_attr_group,
 	&pci_dev_resource_wc_attr_group,
-#endif
 	&pci_dev_resource_resize_attr_group,
+#endif
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
-- 
2.54.0


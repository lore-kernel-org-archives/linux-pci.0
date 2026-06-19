Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8D18FDBD;
	Fri, 19 Jun 2026 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859216; cv=none; b=qexNWqowKFConPlmWUP2sigMbhqzBhre/Fbom4/gJ9f58eM9LG3D1uGGwqSWlicRDSuK0PYBgU1cqocrb+sgYc92vUd8hPqsFkdXmw/lMVrnZ+fhXG0LEUPSbLlOcQZm5IQ//FcXG4JFU182+C6Dowcok5ca7pZTUqAoOK/Qzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859216; c=relaxed/simple;
	bh=q6eh3YWRlj4SdW0vT1gEKkpxB8oWR43EJ8X/XthYkE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohTBDMsbjcPvswB+YrZHYxzTfGEP+OD5jYfiXeUexUGPFjkZ8jHjgrYaZ5EsgyBXulJ1i5RwlLDin86YZyDek/FM26G7hBVJOnFpaSBBvcu7/syZUK4f5q1iSlzGEONpzdjJHIZ1Wyrrs0SS/Ka9oYXEq+VWdL3oK18GmgjCDYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR7iqatK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR7iqatK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769F91F00A3D;
	Fri, 19 Jun 2026 08:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859215;
	bh=AEt6yMxt+anDbS/xfw6iqNjqi9OlzbWZj7cBi3ZQBhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YR7iqatK+cx4aYp6j5tWzOuzMZJB0txouHE9bTlGvW0HPY4heYYHga1kXZ+YKjyNP
	 E7drzIXDvtVBCjndnrWFcqc/Wm40uJZIQOAK6xmt3w4hUzhltEhe/Njp7N2adLkil0
	 R32L5Yb0XO1sc7o9DyAn5dyfGuEwSbnqWwHcoOvVyLGGUJbaSel6ORZ2AO6UcopuFh
	 nrLgGV2fNEIUp8e2ivUkR+UZFJc3CLuoujqPHdS16JN4QE+Wy9i1+ilgQPP/BhV5Ja
	 kVk4zoH1apiKNPSTe1xDDOn8t0pp9RbSfDCNw9pJBTcTn6aMFMXb+2To7gxOTpRdoQ
	 CNUEKwaiwjAGg==
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
Subject: [PATCH v8 25/25] PCI/sysfs: Limit BAR resize attribute scope to platforms with PCI mmap
Date: Fri, 19 Jun 2026 08:52:00 +0000
Message-ID: <20260619085200.3729431-26-kwilczynski@kernel.org>
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

Currently, __resource_resize_store() uses sysfs_remove_groups()
and sysfs_create_groups() on pci_dev_resource_attr_groups to
tear down and recreate the resourceN files after a BAR resize,
so the updated BAR sizes are visible in sysfs.

The resourceN files only exist on platforms that define
HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE.  On platforms
that define neither, pci_dev_resource_attr_groups is NULL and
the sysfs_remove_groups() and sysfs_create_groups() calls in
__resource_resize_store() become no-ops.

Resizable BAR (ReBAR) is a PCI Express extended capability
(PCI_EXT_CAP_ID_REBAR) that requires PCIe extended config
space.  Every PCIe-capable architecture defines HAVE_PCI_MMAP
or ARCH_GENERIC_PCI_MMAP_RESOURCE (via arch headers or the
asm-generic/pci.h fallback).  Architectures without either
only support conventional PCI and cannot have any ReBAR-capable
devices.

Thus, move the resize show and store helpers, the per-BAR attribute
definitions, and the attribute group behind the existing #ifdef
HAVE_PCI_MMAP || ARCH_GENERIC_PCI_MMAP_RESOURCE guard, and fold the
group reference in pci_dev_groups[] into the existing #if block.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index dd87b83ba3a9..4216ed520d41 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1652,6 +1652,7 @@ static const struct attribute_group pci_dev_reset_method_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1766,6 +1767,7 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
 	.is_visible = resource_resize_attr_is_visible,
 };
+#endif
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
@@ -1840,8 +1842,8 @@ const struct attribute_group *pci_dev_groups[] = {
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


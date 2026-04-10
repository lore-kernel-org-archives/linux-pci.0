Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63C322B9F;
	Fri, 10 Apr 2026 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800270; cv=none; b=IM6st5Q69wQRJpX74/mgRx8ibJmzqWv0YuO6kqJcvYXYVY4Ve08ZD8kTZqbsuULcAplZ5hGZ2Ze5h+3p9E8B8JHz4ec7+IDDIV0euZk+2WCnDitmey+aC0ooPaGKvRu1+iC2U+KUfDA25GQ2ypQXx+JTVtGSdTsjS7Kg+cBnUMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800270; c=relaxed/simple;
	bh=SlA86Vk8baRXQR0BnWNH5kTBhDDsrbQCeLelGiUcIhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqY8MI9/SmDaSdNBxZIssY1POjzt7ru8wXLx2nbYJwsJU1uYAsKkVHYcugi38fHSS1JmymIZsKWQN41IFIu0FEyh4V1gyWLkrl1oLtwxLGLtKbfdLFulNNhcVU2lhRcSov9yXBmOtiDuH13uKzkHw1zn50HzBsWLqoZ2bC3fk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcvCvu1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcvCvu1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09FCC19421;
	Fri, 10 Apr 2026 05:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800270;
	bh=SlA86Vk8baRXQR0BnWNH5kTBhDDsrbQCeLelGiUcIhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcvCvu1F0ELy21z3VhUeHZ6QkMm2uK3tzS3tjPDvgLq3IkQCv59Ks34yFtdIYtfkb
	 OwNykDB4t4X9XeTkfS80bpawZL8lajMVhR9KZOrBDO06iXISXejvRIVcDf1qKzGvqE
	 6S/keGfXeBHWPi/f8NZ83MhatTuZl7IBNXeJYgV//BBAit3YnfmNs9dB78yjSHz3/H
	 AQoDsbJKLzVa2jN/WM9xgfeNm89ixMJqurWfa9wiWiKtlKj4Us9R/pY80LaVx03kqK
	 NShhU1170i4ZwjUivcMBfjuEKYVCuyjG34uQgRLuc2KJEvxedHfkEOfcP++w+2m7AW
	 nTkyouxx4lTZw==
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
Subject: [PATCH 07/20] PCI/sysfs: Convert __resource_resize_store() to use static attributes
Date: Fri, 10 Apr 2026 05:50:27 +0000
Message-ID: <20260410055040.39233-8-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, __resource_resize_store() calls pci_remove_resource_files()
and pci_create_resource_files() to tear down and recreate resource
files after a BAR resize.

Replace this with sysfs_update_groups(), which re-evaluates visibility
and also runs the .bin_size callback for the static resource attribute
groups after a BAR resize.

At the moment, the resize code references the static resource group
symbols, so wrap it and the resize group registration in pci_dev_groups[]
under the same "HAVE_PCI_MMAP || ARCH_GENERIC_PCI_MMAP_RESOURCE" guard.

While at it, add a warning if pci_resize_resource() fails to
expose potential failures, and rename resource_resize_is_visible()
to resource_resize_attr_is_visible() and the corresponding group
variable to align with the naming convention used by the resource
attribute groups.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index e56fddbe7914..1fabd0baeb56 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1386,6 +1386,12 @@ static const struct attribute_group pci_dev_resource_wc_attr_group = {
 	.bin_size = pci_dev_resource_bin_size,
 };
 
+static const struct attribute_group *pci_dev_resource_attr_groups[] = {
+	&pci_dev_resource_io_attr_group,
+	&pci_dev_resource_uc_attr_group,
+	&pci_dev_resource_wc_attr_group,
+	NULL,
+};
 #endif
 
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
@@ -1643,6 +1649,7 @@ static const struct attribute_group pci_dev_reset_method_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1692,14 +1699,15 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	pci_write_config_word(pdev, PCI_COMMAND,
 			      cmd & ~PCI_COMMAND_MEMORY);
 
-	pci_remove_resource_files(pdev);
-
 	ret = pci_resize_resource(pdev, n, size, 0);
+	if (ret)
+		pci_warn(pdev, "Failed to resize BAR %d: %pe\n",
+			 n, ERR_PTR(ret));
 
 	pci_assign_unassigned_bus_resources(bus);
 
-	if (pci_create_resource_files(pdev))
-		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");
+	if (sysfs_update_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups))
+		pci_warn(pdev, "Failed to update resource groups after BAR resizing\n");
 
 	pci_write_config_word(pdev, PCI_COMMAND, cmd);
 pm_put:
@@ -1742,7 +1750,7 @@ static struct attribute *resource_resize_attrs[] = {
 	NULL,
 };
 
-static umode_t resource_resize_is_visible(struct kobject *kobj,
+static umode_t resource_resize_attr_is_visible(struct kobject *kobj,
 					  struct attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1750,10 +1758,11 @@ static umode_t resource_resize_is_visible(struct kobject *kobj,
 	return pci_rebar_get_current_size(pdev, n) < 0 ? 0 : a->mode;
 }
 
-static const struct attribute_group pci_dev_resource_resize_group = {
+static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
-	.is_visible = resource_resize_is_visible,
+	.is_visible = resource_resize_attr_is_visible,
 };
+#endif
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
@@ -1872,6 +1881,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_resource_io_attr_group,
 	&pci_dev_resource_uc_attr_group,
 	&pci_dev_resource_wc_attr_group,
+	&pci_dev_resource_resize_attr_group,
 #endif
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
@@ -1884,7 +1894,6 @@ const struct attribute_group *pci_dev_groups[] = {
 #ifdef CONFIG_ACPI
 	&pci_dev_acpi_attr_group,
 #endif
-	&pci_dev_resource_resize_group,
 	ARCH_PCI_DEV_GROUPS
 	NULL,
 };
-- 
2.53.0


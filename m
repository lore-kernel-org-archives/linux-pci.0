Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32381C5D7D;
	Sat, 11 Apr 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894542; cv=none; b=oRNOgF2Vb3otuN2zFIbivv754qsP5PEMfyMQgh5kECW5qwlx/NXYsRgzzUTZUikXQ07CGLqOVQ+SfK0p9VuH12yH4Fk1CUbq+y1VQ7ajcDharTbR1lxmhBoY3lFiBkycme80p3Qrk62MlBktAkKyXUlFA0eMdFHmkmGcA7WAyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894542; c=relaxed/simple;
	bh=UUdcfp1Jj+7X39UhUYZiEAGo8M2BFY1tXtTB8pe0jdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZmndW4JhJ+84M38c7HiuJuM5YV+w/aGqHS89TB35dfGAba1/EbYBbxKJrhmfLwcWARbKsUi5MoW5A2MJIRv7nJJiLLTKz22WC1N0dROiidK1yNkapvNsjfByz7Mf+Xd2/okW0nB7/DurWDU0jtV7rd5l3FxQKM5TeaNge0edxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzKF0gfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzKF0gfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5B5C4CEF7;
	Sat, 11 Apr 2026 08:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894541;
	bh=UUdcfp1Jj+7X39UhUYZiEAGo8M2BFY1tXtTB8pe0jdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzKF0gfZsTJvOqnWuzxJdUYfZoqTbpWXMQrTizAIxQ/+UtJLTllDKMUPIcI3yM0DX
	 Ca6CHETvribfiTZtj2sXAn2CwIyqhjDmkT98/5L3VIC8oVthBAtSESEIoSLuGk3TUC
	 gkQDIy4Ss1TOVLbfhVsmrzGm0w08vKKoItkeqpC3WuY0aUyy0glfVX4+qDaO5PMYEI
	 zzwNlnxl2Kynv01wi5wG9jkDVSeQMdW04eiHDQfbyztARqaEzHqKJHij2xJ6mhUTQb
	 9/deriR2IALMiqOspq55xqLH0viTdKjg0CSQx8ZZ2zTK0c9b+ExDHD5R5hWSsd4RSt
	 QsgdytvWfOMbQ==
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
Subject: [PATCH v4 08/24] PCI/sysfs: Convert __resource_resize_store() to use static attributes
Date: Sat, 11 Apr 2026 08:01:32 +0000
Message-ID: <20260411080148.471335-9-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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

Replace these with sysfs_remove_groups() before the resize and
sysfs_create_groups() after, which re-evaluates visibility and
runs the .bin_size callback for the static resource attribute
groups.  Also, add a warning if pci_resize_resource() fails to
expose potential failures.

For architectures without HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE,
define pci_dev_resource_attr_groups as NULL so the resize path compiles
unconditionally and sysfs_remove_groups() and sysfs_create_groups() become
no-ops.

While at it, rename the resource_resize_is_visible() to
resource_resize_attr_is_visible() and the corresponding group variable
to align with the naming convention used by the resource attribute
groups.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2922905ff070..c0925bdc9ecd 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1386,6 +1386,14 @@ static const struct attribute_group pci_dev_resource_wc_attr_group = {
 	.bin_size = pci_dev_resource_bin_size,
 };
 
+static const struct attribute_group *pci_dev_resource_attr_groups[] = {
+	&pci_dev_resource_io_attr_group,
+	&pci_dev_resource_uc_attr_group,
+	&pci_dev_resource_wc_attr_group,
+	NULL,
+};
+#else
+#define pci_dev_resource_attr_groups NULL
 #endif
 
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
@@ -1692,14 +1700,17 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	pci_write_config_word(pdev, PCI_COMMAND,
 			      cmd & ~PCI_COMMAND_MEMORY);
 
-	pci_remove_resource_files(pdev);
+	sysfs_remove_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups);
 
 	ret = pci_resize_resource(pdev, n, size, 0);
+	if (ret)
+		pci_warn(pdev, "Failed to resize BAR %d: %pe\n",
+			 n, ERR_PTR(ret));
 
 	pci_assign_unassigned_bus_resources(bus);
 
-	if (pci_create_resource_files(pdev))
-		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");
+	if (sysfs_create_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups))
+		pci_warn(pdev, "Failed to recreate resource groups after BAR resizing\n");
 
 	pci_write_config_word(pdev, PCI_COMMAND, cmd);
 pm_put:
@@ -1742,7 +1753,7 @@ static struct attribute *resource_resize_attrs[] = {
 	NULL,
 };
 
-static umode_t resource_resize_is_visible(struct kobject *kobj,
+static umode_t resource_resize_attr_is_visible(struct kobject *kobj,
 					  struct attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1750,9 +1761,9 @@ static umode_t resource_resize_is_visible(struct kobject *kobj,
 	return pci_rebar_get_current_size(pdev, n) < 0 ? 0 : a->mode;
 }
 
-static const struct attribute_group pci_dev_resource_resize_group = {
+static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
-	.is_visible = resource_resize_is_visible,
+	.is_visible = resource_resize_attr_is_visible,
 };
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
@@ -1873,6 +1884,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_resource_uc_attr_group,
 	&pci_dev_resource_wc_attr_group,
 #endif
+	&pci_dev_resource_resize_attr_group,
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
@@ -1884,7 +1896,6 @@ const struct attribute_group *pci_dev_groups[] = {
 #ifdef CONFIG_ACPI
 	&pci_dev_acpi_attr_group,
 #endif
-	&pci_dev_resource_resize_group,
 	ARCH_PCI_DEV_GROUPS
 	NULL,
 };
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782518FDBD;
	Fri, 19 Jun 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859155; cv=none; b=HpY5ExrgdhUmYrO9kVTl3wa9u+7ZdxrJf71Ma63M2OGZO2rKIUh8+aFWsSnpEu7Zckql/dqK9qOrkuD79bXj03iWh0aPfBgY1CxvdaEd/I/I6oc/aF11TE9IMWK9KNX0L/LXIQDA0iSJrL5F9U8+vZyUKtlk+O5c6KbqlgkVa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859155; c=relaxed/simple;
	bh=qZNTaBqT/sdlMdXYYaj8lcAQVN0PW95yTZPVlpc9fw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzU2cezrv3B+24ko3xhRdz3sOMvfc+QghHkFXBxW7dNuIG3/PN+wVhVm+/85+K8JBnuODPFWMWQmWMILmwTMLqIXwBnqZDCi81y5aBxZow2p5Eq4YmdHb8Bl1FNfPBWxSSG46PJO+cHlufBbfqlKyXXItxPnCnItGpSwi4xLPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+HUR0Su; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+HUR0Su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F7F1F00A3A;
	Fri, 19 Jun 2026 08:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859154;
	bh=r68zxN0KHcb5URqlhy3b5QGz3OV09mDNBvnBZmcOinI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B+HUR0SuVtr+KdBlj9DwDcjD2iiVtVekAzi01Hw9fc4udUAaSOKeQcP4PT6ohbgFY
	 r01XcEUYQVJmkecGUizQvNEGZ5OIR+5B4EUD+1JZCjo06+PttSC5My1YRC8st6fgN3
	 BgQr/cLnksZozav+YHtfwX7XZGkz2v7LLXbhJD3g+4rvaySw3CLMIqCBPH6jdtnNg4
	 6ONFRIoqbxpyShKoba1orlhZV2Is6isJydSDpnkJIMvNteOPSupXqYXsE5OJzxkas5
	 MbbkpZtxujsgwKS1s1v3BxKZSE+HlEMxBKMjKiF1GsEtsd+IvylpLgTqOwH8ct24TE
	 Jv4BMAeeT/Vtw==
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
Subject: [PATCH v8 08/25] PCI/sysfs: Warn about BAR resize failure in __resource_resize_store()
Date: Fri, 19 Jun 2026 08:51:43 +0000
Message-ID: <20260619085200.3729431-9-kwilczynski@kernel.org>
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

Add a pci_warn() to __resource_resize_store(), so that BAR resize
failures are visible to the user, which can help troubleshoot any
potential resource resize issues.

While at it, rename the resource_resize_is_visible() to
resource_resize_attr_is_visible() along with the corresponding
group variable to align with the naming convention used by the
resource attribute groups.

Also, change the order of pci_dev_groups[] such that the resize
group is now located alongside the other resource groups.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 615bbee1a1c8..b8b7fb809c69 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1679,6 +1679,9 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	sysfs_remove_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups);
 
 	ret = pci_resize_resource(pdev, n, size, 0);
+	if (ret)
+		pci_warn(pdev, "Failed to resize BAR %d: %pe\n",
+			 n, ERR_PTR(ret));
 
 	pci_assign_unassigned_bus_resources(bus);
 
@@ -1726,7 +1729,7 @@ static struct attribute *resource_resize_attrs[] = {
 	NULL,
 };
 
-static umode_t resource_resize_is_visible(struct kobject *kobj,
+static umode_t resource_resize_attr_is_visible(struct kobject *kobj,
 					  struct attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1734,9 +1737,9 @@ static umode_t resource_resize_is_visible(struct kobject *kobj,
 	return pci_rebar_get_current_size(pdev, n) < 0 ? 0 : a->mode;
 }
 
-static const struct attribute_group pci_dev_resource_resize_group = {
+static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
-	.is_visible = resource_resize_is_visible,
+	.is_visible = resource_resize_attr_is_visible,
 };
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
@@ -1857,6 +1860,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_resource_uc_attr_group,
 	&pci_dev_resource_wc_attr_group,
 #endif
+	&pci_dev_resource_resize_attr_group,
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
@@ -1868,7 +1872,6 @@ const struct attribute_group *pci_dev_groups[] = {
 #ifdef CONFIG_ACPI
 	&pci_dev_acpi_attr_group,
 #endif
-	&pci_dev_resource_resize_group,
 	ARCH_PCI_DEV_GROUPS
 	NULL,
 };
-- 
2.54.0


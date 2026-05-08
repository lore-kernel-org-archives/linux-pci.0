Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511C015539A;
	Fri,  8 May 2026 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214978; cv=none; b=ZJecuQS65PqgUGcFJEMIwaiLYofO+nQHWnpX22N5DYdPm+FRTyvdzr6mQeI9wKnnKS+Ii0FG1k3Fnr7QRqC8kYkmFSuQYwedRxlAkOT+34ACydpIjdHoq2ev5W2BgBrY03QU/KEHVjRCzCkigIjiStJu35ntsNlEL2VHQBSE9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214978; c=relaxed/simple;
	bh=npFjt2eFuO2uVckDmBE/VjWzSztOJLV6MfwijXvEL7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs6XO0eSDiLudPdexu6U2a7zG4Kkg7M5muOY2aSE9ZbBCFYPErDQuNEpQxAXJSK/h8E6fg6orwzHZbORuMCINnJva91tAAt9BMLpP2svewQ8tpG+bZn2ZBKpWeCVLeIsCZNFfRwyE5gaGmd2i/a6kQBlyJFeWTWrkkTWq/Dmkg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAOVaKZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAOVaKZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD14C2BCB4;
	Fri,  8 May 2026 04:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214977;
	bh=npFjt2eFuO2uVckDmBE/VjWzSztOJLV6MfwijXvEL7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAOVaKZSgv2JC8kYDcMYr1zfF/BGWGk29hLtLyOrUeg8gi/M4FBPWTP2DTqY8U0kL
	 OAnpX7rAzXkuisaJu0w4BgQT7QdsdJyl8OifmwkmOGmW+2QET8CxzeJ1yL7GhtDaw7
	 ZCBLnOnzfkEOau9IOeVLnWqxP37EdoKqckL55iCjfDknDHWHJQwXkAXt82crrhzqay
	 KBq9hS8BDOas3hPbCvUYSSSN5JrcBWN++vRoX5EVzilPjLteTkI7I80XbftbQ6Mvwt
	 xgEONVRMWMXalytUEVfgLhDHExjS7vPZtQ95P0MpkaACcMgyrCMXMFYlw5KUw/B8iS
	 +qEnUACT6QfRg==
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
Subject: [PATCH v7 08/24] PCI/sysfs: Warn about BAR resize failure in __resource_resize_store()
Date: Fri,  8 May 2026 04:35:27 +0000
Message-ID: <20260508043543.217179-9-kwilczynski@kernel.org>
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
index 0fa126d46e35..f34415a401ec 100644
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


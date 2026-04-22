Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE537C923;
	Wed, 22 Apr 2026 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874480; cv=none; b=Zrwiim9FrpB3RwM6k/TwyLeKluF0cK7vcHfgad8IFGVkjJk8MtwIN+3bJN8ncDGWfs+CprRBdMPENsfGwR4Aew4DBXCAil3T29JseAbRITfNTShOdQOxDTPu2e5/8cNGecM8U753AIfAMD6+IxoXcf9188nvJeRctNErnVFdpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874480; c=relaxed/simple;
	bh=tPC3J3ZhBEH6py/uCTWgJRVGCTKnpjJlJA0/I3j9P2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOO11UyUgdVXz0Iy4iTNXS3RLBmRuud02Wq9C4H0z0YyBNp/swkUM15lGTO7Z6guwUSzKdDcnhcokKxWzk98Z8G2U2N6cHmrd5I17sLNU70faLxDCw4krlljOMACWQ5qJJa3GQQEv/D5oksuq/DaB6+IcspPC3TGEGw1pKEYO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIy7Urip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIy7Urip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FA2C2BCB2;
	Wed, 22 Apr 2026 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874479;
	bh=tPC3J3ZhBEH6py/uCTWgJRVGCTKnpjJlJA0/I3j9P2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIy7UripanPcwv0lcuvpN+LC+hvGpFWR4gvFU0nG+S4dMTz0zbh0L0Rro2gNPgIqU
	 MQgN/EIbpsPzR2bfNN5K4/GxS/7qge8+CTlD8vA1Kr990ZENvd73NqkFRZigpT4Juv
	 mtx7SGoHAu4WtHEnmEhNvDJhqsWPzBfRshYvQURZyR3ckGX2rZOtGQiIkOEVmQQYGo
	 7zAodRktmezQzJRsQVYUp8Dq+oJfmNwREDfqbDAKSU+JJUkt/apjGg7+alxm75ODF4
	 gQanKXWrYMI1XPIlfvagSjJJitwmQWqgZadMoayLQWWtYzdEHn3EdJ9GrBwFM4wS6F
	 sE0wogHvrgNzQ==
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
Subject: [PATCH v6 08/24] PCI/sysfs: Warn about BAR resize failure in __resource_resize_store()
Date: Wed, 22 Apr 2026 16:13:51 +0000
Message-ID: <20260422161407.118748-9-kwilczynski@kernel.org>
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

Add a pci_warn() to __resource_resize_store(), so that BAR resize
failures are visible to the user, which can help troubleshoot any
potential resource resize issues.

While at it, rename the resource_resize_is_visible() to
resource_resize_attr_is_visible() along with the corresponding
group variable to align with the naming convention used by the
resource attribute groups.

Also, change the order of pci_dev_groups[] such that the resize
group is now located alongside the other resource groups.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 3508e29f6ad1..c0925bdc9ecd 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1703,6 +1703,9 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	sysfs_remove_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups);
 
 	ret = pci_resize_resource(pdev, n, size, 0);
+	if (ret)
+		pci_warn(pdev, "Failed to resize BAR %d: %pe\n",
+			 n, ERR_PTR(ret));
 
 	pci_assign_unassigned_bus_resources(bus);
 
@@ -1750,7 +1753,7 @@ static struct attribute *resource_resize_attrs[] = {
 	NULL,
 };
 
-static umode_t resource_resize_is_visible(struct kobject *kobj,
+static umode_t resource_resize_attr_is_visible(struct kobject *kobj,
 					  struct attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1758,9 +1761,9 @@ static umode_t resource_resize_is_visible(struct kobject *kobj,
 	return pci_rebar_get_current_size(pdev, n) < 0 ? 0 : a->mode;
 }
 
-static const struct attribute_group pci_dev_resource_resize_group = {
+static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
-	.is_visible = resource_resize_is_visible,
+	.is_visible = resource_resize_attr_is_visible,
 };
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
@@ -1881,6 +1884,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_resource_uc_attr_group,
 	&pci_dev_resource_wc_attr_group,
 #endif
+	&pci_dev_resource_resize_attr_group,
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
@@ -1892,7 +1896,6 @@ const struct attribute_group *pci_dev_groups[] = {
 #ifdef CONFIG_ACPI
 	&pci_dev_acpi_attr_group,
 #endif
-	&pci_dev_resource_resize_group,
 	ARCH_PCI_DEV_GROUPS
 	NULL,
 };
-- 
2.54.0


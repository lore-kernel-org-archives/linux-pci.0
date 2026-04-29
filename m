Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1841B342;
	Wed, 29 Apr 2026 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486024; cv=none; b=cw1JKr7PQUTkzjjCP7pFXoyIIpM4hQVvlVIx3NSj3VkTnUGvEl2uzJ8aCQy9/w7NH6EdTf2YDxGdGK7nZTXP6nhQLgUuyuPUNWevFyAFqpy9KIp4urKduVh8Izr+R9Ubv5/eWsZx2KTOlh4ZGfTIjAPHq7YsfgqJp22yDKUtD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486024; c=relaxed/simple;
	bh=i9DctissnUwJ7gbXq/le4a2C0KOutO1M9loIHeYL1Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUGzdd7+yfCxcmOY7nEq6xnGRT1dtjxarMNfq09D5jo8grzTPIwcYq4LLaLdiySqZZwGmT5/eynS+KZL4OY2sIcLhqYIMR3m7KBrZtPniZuruAAcSmaFQnm+7nMW7hKlGAXWxwzRV2MNEh8vedxIuKDQMTFpy4OTLL7Dv/vkhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIWLhGr2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIWLhGr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777486021; x=1809022021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i9DctissnUwJ7gbXq/le4a2C0KOutO1M9loIHeYL1Lw=;
  b=nIWLhGr2oH9OB574DqFAIj3FpaADp3kw0Q9B/ZuKyZthTQi6MusX1Weh
   5PnqzhoFPcFQHnXrxkVsCxcrBHqj2q+kWEXY+H+pgwYsbtmd7NQg7R+5J
   Y1vE2e/GxPiBmQ7e2ik0YHAoiyz1SjIEHz8dmhhK6GJqEO5pjnit3/LW4
   zWi6Ve9l68NmxaO2lGAVtZ6MAXgVgVUcemb9WbH1aAxlZW/3eJ/CoAkMW
   fVOThzgb9YyQiTBfjqGcUqfMv4fgm9fx+Q6FHsldgv255TrG/sOVjuvUD
   WPo+PiuA+fdZ8ku41+2XPJM4UQqVc4sH817t0EAfMG7vZQj1+mbwZBgyn
   w==;
X-CSE-ConnectionGUID: 5NrUaydTRcKHv4JMOJ4ngQ==
X-CSE-MsgGUID: 7yI7nKyMT1K2FVzWvuQD4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78532279"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78532279"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:06:55 -0700
X-CSE-ConnectionGUID: 0l/u9bIgQEKXPMYLrAqsww==
X-CSE-MsgGUID: UasF+sk9QB2H/NXH9bhDcw==
X-ExtLoop1: 1
Received: from iherna2-mobl4.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.251])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:06:54 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: "David E . Box" <david.e.box@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [RFC PATCH 2/4] pcie/aspm: Enable all power-saving states during link state initialization
Date: Wed, 29 Apr 2026 13:06:44 -0500
Message-ID: <20260429180647.197072-3-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429180647.197072-1-thomas.falcon@intel.com>
References: <20260429180647.197072-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting powersave and powersupersave states at ASPM
link state initialization allows for a simpler and more
maintainable enabling flow that presumes all advertised
power states work. Restrict this behavior to systems
with a BIOS release during or after 2025.

Suggested-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 drivers/pci/pcie/aspm.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cd23c1462502..84d49aa8a5ba 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -24,6 +24,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/dmi.h>
 
 #include "../pci.h"
 
@@ -1057,6 +1058,23 @@ static void free_link_state(struct pcie_link_state *link)
 	kfree(link);
 }
 
+static int pcie_aspm_legacy_config_check(void)
+{
+	static bool legacy_aspm_config;
+	static bool checked;
+
+	if (checked)
+		return legacy_aspm_config;
+	if (dmi_get_bios_year() < 2025)
+		legacy_aspm_config = true;
+
+	pr_info("ASPM configuration is determined at %s time\n",
+		 legacy_aspm_config ? "build" : "boot");
+	checked = true;
+
+	return legacy_aspm_config;
+}
+
 static int pcie_aspm_sanity_check(struct pci_dev *pdev)
 {
 	struct pci_dev *child;
@@ -1196,8 +1214,9 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	 * the BIOS's expectation, we'll do so once pci_enable_device() is
 	 * called.
 	 */
-	if (aspm_policy != POLICY_POWERSAVE &&
-	    aspm_policy != POLICY_POWER_SUPERSAVE) {
+	if (!pcie_aspm_legacy_config_check() ||
+	    (aspm_policy != POLICY_POWERSAVE &&
+	     aspm_policy != POLICY_POWER_SUPERSAVE)) {
 		pcie_config_aspm_path(link);
 		pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	}
@@ -1379,8 +1398,9 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 	if (aspm_disabled || !link)
 		return;
 
-	if (aspm_policy != POLICY_POWERSAVE &&
-	    aspm_policy != POLICY_POWER_SUPERSAVE)
+	if (!pcie_aspm_legacy_config_check() ||
+	    (aspm_policy != POLICY_POWERSAVE &&
+	     aspm_policy != POLICY_POWER_SUPERSAVE))
 		return;
 
 	down_read(&pci_bus_sem);
-- 
2.43.0


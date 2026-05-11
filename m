Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B394D2EF2;
	Mon, 11 May 2026 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533790; cv=none; b=ukQW9WPyrTFzMF2Vndj0IBqxlliznOyYSB3+h2s/ikzJZ39oJqiTOr2ZxIq9vtn4RrXeRyBCJ+VzHNj+j769RySe1fG+6566MMeJfzELpNjUF4kvdkpm/VAOhlOFLuqbQFYX0OA0Wr8rq1O0cWTFgBFwY9BDSW3rZ4R1gAvCTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533790; c=relaxed/simple;
	bh=So38ME1vYHb9mQ3XtR6l+44EchNFkSfMlfW0YtBVrRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FN/mBsf++XlpnqCVRIQN6YHPyr2RsrhXqbIbzCdzMlU83jYIyKlakCA+YG/v6b1lOB0EjJ7qjBZyqQFAfoaAcg4xQcaZyhQhNhB7obpB7ctwnO3swWRGN1q2KWO4BMBBB19QstUzlqYVkQbIaBqmPHHouvMReqS6q5z+WIQIm9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSfY9RU/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSfY9RU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778533788; x=1810069788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=So38ME1vYHb9mQ3XtR6l+44EchNFkSfMlfW0YtBVrRE=;
  b=BSfY9RU/XeeU+RbVWRnBSWndO7zmbv4kdPbSE1bjwwAI3Iic9UDys3y2
   dGS98GCFSSwnp+3PEE89PMyV62Tt4VEdtjWErrQVQimJX743RuLGfyHuu
   nMYoScaQHujdjACXRrwGeKevwiUD+76D6sHkzGpOysGkRAXdLwgr9Pr2m
   5ur0kh/8ny3RewwtmQpeA2/kxcNwzXkuw7FJBzrKaH0gHPbdJvxdH70V/
   FBZCcDNqmiJaTZ9IASP2+J9YoWZcn/LRuXGsUqDjQ8jKbPmW+PWZ3HIxN
   yH+XQgh5DIB0imXYiE1W2CfX7pU7NOw0HFkZQ/coYGnqlcmpcmEOVAy2T
   Q==;
X-CSE-ConnectionGUID: HLw7k6JLTbyenTtXlsXi7w==
X-CSE-MsgGUID: Nxg5qg9BQwmp+pfg6Zuq4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90534535"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90534535"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 14:09:48 -0700
X-CSE-ConnectionGUID: TGEMsOfeR1W3fvY+ldgqdw==
X-CSE-MsgGUID: 1bNp4yDRSuKn1Hzk/KWBkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="241559246"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.210])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 14:09:47 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "David E . Box" <david.e.box@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [RFC PATCH v2 2/4] pcie/aspm: Enable all power-saving states during link state initialization
Date: Mon, 11 May 2026 16:09:32 -0500
Message-ID: <20260511210936.562622-3-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511210936.562622-1-thomas.falcon@intel.com>
References: <20260511210936.562622-1-thomas.falcon@intel.com>
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
v2: -- pcie_aspm_legacy_config_check() returns bool instead of int
    -- only log whether aspm is configured at build or boot time once
---
 drivers/pci/pcie/aspm.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cd23c1462502..e93b72494534 100644
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
 
+static bool pcie_aspm_legacy_config_check(void)
+{
+	static bool legacy_aspm_config;
+	static bool checked;
+
+	if (checked)
+		return legacy_aspm_config;
+	if (dmi_get_bios_year() < 2025)
+		legacy_aspm_config = true;
+
+	pr_info_once("ASPM configuration is determined at %s time\n",
+		     legacy_aspm_config ? "build" : "boot");
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


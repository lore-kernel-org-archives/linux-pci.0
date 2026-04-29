Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6344F35F180;
	Wed, 29 Apr 2026 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465695; cv=none; b=LjX1VfjbUoXEJ0vV2nADOuEa3JndbTaqrOQx/ww9gD8SdTwtnbbw738qhheWZU5hRLAzEa/xeWTkubE8rnYTxtFo+KCcsvkymq1ae4PvWC0Ue/W2c7TrQEZPTg2Ffm2jw8yGhKmOmrMnL00dVxIBCFrgsegrfQCcBxv13MZTeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465695; c=relaxed/simple;
	bh=oeSgNgDXBsgR0efD4S75suw6nUvLdg/+OHFHO/cn4ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzvliPIV5X8YyjzXIuI/pH9Q5dmr6Y5svmnCQ3gPcKmCeUsA6AjhkieIuNBxsl44sQKPnrFoyLYPXZgAHyFkVjk+qPBkyQZgqdDHy2A0BE1XpgAxSmRyn3DIi6FvM0LYnYnfLJvDW3Qnzu5pbrd+BMUzNW44XohxyUKNMJQUms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iElUlVt2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iElUlVt2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465694; x=1809001694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oeSgNgDXBsgR0efD4S75suw6nUvLdg/+OHFHO/cn4ws=;
  b=iElUlVt2r4us9Z9oq44dJwqga3x0BaziHQCPCTg2MBRm+/mPC5g2hX0b
   YD8aWuIMlPhpTX1hiZXhAQMoO+N/g5uVxXJxTBLsncS5A5mjVqO3bV3zQ
   HzUHln74tQVRCgAktBuMWGDkzEsawNCvBc+/cQrMb/1TXL9RVl47Lgpl0
   6DxUV8ELeIWofu8RpISn9rLG5w6SjSSkD/mvhcQKakVd9GuovPvWgC4ib
   2xg1mXx8iavY5i8/PQILB1OX+RN++QiP3kFMIFCc2DfEHbeFXTy20hYTy
   VK7vlbV8CF0CJLGZrgOi6XG3rbjGWIuDIVW38Fra1pQE3N9VPmi7qTArc
   Q==;
X-CSE-ConnectionGUID: V1fbMe5zQumZVVSOjB4OdQ==
X-CSE-MsgGUID: 5WT/aL4hSrWk7fMcPROtDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101863"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101863"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:14 -0700
X-CSE-ConnectionGUID: M7JSCq3WQimiDepsf6U6sQ==
X-CSE-MsgGUID: /7sDIPHHQWeOjNW11AQIwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="257573749"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/11] PCI: Move pci_resource_alignment() to setup-res.c file
Date: Wed, 29 Apr 2026 15:26:15 +0300
Message-Id: <20260429122617.7324-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_resource_alignment() is a bit one the complex side to have in a
header so put it into setup-res.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h       | 13 ++-----------
 drivers/pci/setup-res.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e0fcc33dfef6..472b6c2f7c4d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1044,17 +1044,8 @@ static inline void pci_suspend_ptm(struct pci_dev *dev) { }
 static inline void pci_resume_ptm(struct pci_dev *dev) { }
 #endif
 
-static inline resource_size_t pci_resource_alignment(const struct pci_dev *dev,
-						     const struct resource *res)
-{
-	int resno = pci_resource_num(dev, res);
-
-	if (pci_resource_is_iov(resno))
-		return pci_sriov_resource_alignment(dev, resno);
-	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
-		return pci_cardbus_resource_alignment(res);
-	return resource_alignment(res);
-}
+resource_size_t pci_resource_alignment(const struct pci_dev *dev,
+				       const struct resource *res);
 
 resource_size_t pci_min_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 0d203325562b..18e8775ea848 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -246,6 +246,18 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 	return 0;
 }
 
+resource_size_t pci_resource_alignment(const struct pci_dev *dev,
+				       const struct resource *res)
+{
+	int resno = pci_resource_num(dev, res);
+
+	if (pci_resource_is_iov(resno))
+		return pci_sriov_resource_alignment(dev, resno);
+	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
+		return pci_cardbus_resource_alignment(res);
+	return resource_alignment(res);
+}
+
 /*
  * For mem bridge windows, try to relocate tail remainder space to space
  * before res->start if there's enough free space there. This enables
-- 
2.39.5


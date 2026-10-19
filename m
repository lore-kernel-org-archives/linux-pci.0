Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F004973A0
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399013; cv=none; b=DhXh9iUOQYcNeJBCJLU2m6WlIHZc0VyY8J+LPqdSASCwWQmgydhahSDjBNsHa2HpoNMHWsJhG29kIH0e02hthRsWgnxNpJZMMsk4lxNxXH4BtNTnHqdw5Th9YKMGes1seaY5ot6rkWKo2idYMOe0UyYB4/DlSoagbv2kR6ImtJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399013; c=relaxed/simple;
	bh=9NAn4Ivz2zyzyNxU+SAB6ZyCzYN7TGFrNtyNej320Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFnXNMrKVBYts6zcwcKnfJ0D/qx+9y/9jIPITm6bkEUp/n0Jroxtleucl56g23LfU98kMB6Ept7BUUnGbpZjKreYpcDpp5skQRDJ/m+SnVtx3cFCs1exsvjPFVBw+IhVNuYcAFh+FOrKjMLmW8HUi/fK0gKr6HN/dPr+PWxnOd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xiw76NXQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xiw76NXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399012; x=1823935012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NAn4Ivz2zyzyNxU+SAB6ZyCzYN7TGFrNtyNej320Gk=;
  b=Xiw76NXQaDJWvl2CqGjhiR5OtUgdp0OCyz/fp4U+LHQUr9DPY4V5nOz1
   6gmFoYNw8gEcWn2QZ7fd5kMllsunjDnkDUJZKL3fBNPY9wqr0OLGcd82A
   RfgVaO675/ISHkuRfwrVYxzU4657UgXhqeM7fvlk0TcbSf+FKXdAY975k
   1ntGVp7NWv3ewqxh1Gmv4Kd8utHoCrTG/TOOJp1oRg/bSXnlierIw8vwd
   p5Izi4YKqYIMqgFgtDgN31wD/rdUKSKvvpAWpLQbg509hD10Mc3dpaekG
   MmiGP2NM+YPH9wAZvSiYdCP1+2JlyYpDuBejEr0c9R1l4YOUE2BnXDx5j
   w==;
X-CSE-ConnectionGUID: hO9Di7wkRamgyjwThQWh8A==
X-CSE-MsgGUID: qg3cZOPnQc+2hDToABbYBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1090694"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1090694"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:36:51 -0700
X-CSE-ConnectionGUID: nbd50S28QZWK+XnP6b+nAw==
X-CSE-MsgGUID: JIVGEuAIR8eUnkobjOWZrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2478452"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:36:49 -0700
From: Lukasz Laguna <lukasz.laguna@intel.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: michal.winiarski@intel.com,
	djbw@kernel.org,
	brett.creeley@amd.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Subject: [PATCH v1 05/13] ionic: Lock VFs around pci_reset_function_locked()
Date: Mon, 19 Oct 2026 10:35:06 +0200
Message-ID: <20261019083514.838640-6-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019083514.838640-1-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_reset_function_locked() now requires PF callers to hold the device
locks for all enabled VFs as well. Lock VFs around the reset in
ionic_pci_error_resume().

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 05f19489ec5c..a0f501fe33e4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -505,8 +505,11 @@ static void ionic_pci_error_resume(struct pci_dev *pdev)
 	struct ionic *ionic = pci_get_drvdata(pdev);
 	struct ionic_lif *lif = ionic->lif;
 
-	if (lif && test_bit(IONIC_LIF_F_FW_RESET, lif->state))
+	if (lif && test_bit(IONIC_LIF_F_FW_RESET, lif->state)) {
+		pci_dev_lock_vfs(pdev);
 		pci_reset_function_locked(pdev);
+		pci_dev_unlock_vfs(pdev);
+	}
 }
 
 static const struct pci_error_handlers ionic_err_handler = {
-- 
2.43.0


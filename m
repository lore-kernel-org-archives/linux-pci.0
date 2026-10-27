Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117187;
	b=ncbAkcXYRhgpw8ZU1/VWV83f1vWQt6NXQdILYWhI8OmrcMw8dgsZe7bYmE21G6Jewgj1
	 g95kPQGVxUGYm3Hg8sYz0vPzGybiyOyjxUOy9aZIrXx8dEYI2V8uQjvSWvL9dLlOOBqoc
	 RB6CULd2bK+N7iTUNXT9Ar2gMNQr/RX+AwvwBIapjSLYpXpGV4EPyJz9edpiWDeiZfDWu
	 5qbSbWk2mB2Sfs7IZ9m/7TDobubpPc9SEiK4QyJzMDi594U/QJwsHxpmjBxIHJE6qzhYu
	 a51qjQ41hHUbU3Mqp1Zib5VilZURLrErXEd857bXGjJKtAri2CoZBA8E5wPgpEsXYOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117187;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D07402jPXlqCeK2TJfmjC6SnHlqz1ZGbzSaGFAuWW3s=;
	b=TVqvHDJhU0y58qnGubsK5aFT+DdnulQ912WvOJrPOG1Wiu9GeP1GJa2nV4NB4ohDEwXU
	 4FosHfso3u6vLzoD1amOjiZZyqQuie94TYdIAd6i+f9gYOEbX+clzqrS9U873bmOsfwWS
	 9kloqgff1IGkO+OOcIJ7YE4+cQ1z6xPt5PCos7kCobJwiM5Vtgq9yIBnnKkAE1dB+fGPQ
	 byuD9kVrik507rXTYRqOejWdRTtSXHFUWoCigoUsV7/zP4eQpMVoXgLLBCpyz/3TARZOU
	 gHX2sVVJU5W308MGPYHJnYKgTelYZkIxB1CQPtcFobNdk5u6R16WVvtHfONlbiRD5GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bsfhFoYw;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12035606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12035606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bsfhFoYw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117186; x=1824653186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2DfO6JSvkNnF2pDagpqNDefLAqJsKNR3NugftUreUgk=;
  b=bsfhFoYw+oSbyvWRliBim++EQzRzcxgs09BqArsLsGs6bBWTSVSw1Nh7
   8yArwrrrV7Cn3pNFWCACsWxZ4u2z2N43pFn4xRzgTupYbGFVg857n9vrp
   KUKhebKo0/LblotlLnkkjdLehmYgukqXQOv0uEvS8c+9LBJEZYzFZan3N
   ukPJLQLGCGPle4zhdel5yVp9pyk+MOzF9co3DLPnTmELRJZdUD8ZX/MSM
   bHZ4nk/Qd+jwv0WhIIAuvSI0P4gy+3lZFylTXlYBx4W328Y7FQDbtQbP0
   kMHqwua3ncs4J/GeMEVa4Lp7GTqtSVdLZmcYn6BekElioQvECvK2wmnvN
   A==;
X-CSE-ConnectionGUID: 7UvKNYZdSouspiMZWTACNQ==
X-CSE-MsgGUID: 2WOZLh89SsqWG95RltXySQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1711567"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1711567"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:06:25 -0700
X-CSE-ConnectionGUID: nltA2kIjRdy++6BYkYQ2Nw==
X-CSE-MsgGUID: t6hD/SVySYCX+BYYIh462w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4956106"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:06:22 -0700
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
Subject: [PATCH v2 05/13] ionic: Lock VFs around pci_reset_function_locked()
Date: Tue, 27 Oct 2026 17:04:38 +0100
Message-ID: <20261027160446.858300-6-lukasz.laguna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027160446.858300-1-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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
index ddc2f9770df4..7a9473603d51 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -507,8 +507,11 @@ static void ionic_pci_error_resume(struct pci_dev *pdev)
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


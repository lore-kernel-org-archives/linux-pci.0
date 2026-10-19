Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221449739E
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399016; cv=none; b=AMUPwiXKLM0IMNWIBWugb0d3y0EO9DhwFKH+Gi4Ce73uUJ36zzCgIS27PgEQHlai8ZupL3jKuPla0BnE9ubTc+ggwaFCEX6RuJETiWOKPJ0p4xuDOW50hD1wMJ4rCbXJDmDr8kRwzVcj+zODdHXV9Mml7yvPUc2IDfZkwlWZPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399016; c=relaxed/simple;
	bh=A65CObzgdbzoLlpXnQ/wM5dluhKpDN2KH5S0bLb6t4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ+WykNKiQIJBW+WZQpJBSmMSjBmq3yPDO1wfRl5zivAcijrDWVg4NGnmeetKdV1bQ2u86VM71Hl9x2Ok750lwKHiqva9A9J7yXF0BScQUSeE+AbHkmZJrEJtZzaxRHtb53j6eI4jarwdGfjdkJ7y/2JaVs9iuWwWrhPYVWeA8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0bmkYP5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0bmkYP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399016; x=1823935016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A65CObzgdbzoLlpXnQ/wM5dluhKpDN2KH5S0bLb6t4I=;
  b=K0bmkYP5yG0PZLiKZ4d3F6kG9jJsy37d49I9dvEpb3whHo5calV1oGg4
   CwafebSbMO3Hvjz19nDITVx6shX0OJ/cvPZmXnZw5eGQ3jEhxSj9iMrwt
   Sujc6aFS1AvjSEQL2NFdoEii3hBho6gj4hMeVKSPcdOfuQ5Jop7vdQZ1t
   fb5/K8nuPR4ozJ/ifpYig0Q49BOEmB8dhAUD9dHI1xmxDa9RXwnLhF/th
   7j0o0CEXrQgQfPGT+kIEwDegnNMnEl86uHLnCMiDdEbO8B8CljhJPYtPw
   G6KQVsCwZQxhF5Xx+6Lb7NeiVT/qkaygktlzZbaNk54AymT6toXyQZ1vf
   Q==;
X-CSE-ConnectionGUID: iwDx7qbvSredHOacOiz87A==
X-CSE-MsgGUID: lJFOa115QbWE+wuCg9C2TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1090702"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1090702"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:36:55 -0700
X-CSE-ConnectionGUID: V43C9+aPRAWedS2qnkxW3A==
X-CSE-MsgGUID: TZz8gV3yToeUA3EpBZm9UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2478484"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:36:53 -0700
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
Subject: [PATCH v1 06/13] pds_core: Lock VFs around pci_reset_function_locked()
Date: Mon, 19 Oct 2026 10:35:07 +0200
Message-ID: <20261019083514.838640-7-lukasz.laguna@intel.com>
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
pdsc_pci_error_resume().

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index bb79e7476370..23e03d813fdc 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -583,8 +583,11 @@ static void pdsc_pci_error_resume(struct pci_dev *pdev)
 {
 	struct pdsc *pdsc = pci_get_drvdata(pdev);
 
-	if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
+	if (test_bit(PDSC_S_FW_DEAD, &pdsc->state)) {
+		pci_dev_lock_vfs(pdev);
 		pci_reset_function_locked(pdev);
+		pci_dev_unlock_vfs(pdev);
+	}
 }
 
 static const struct pci_error_handlers pdsc_err_handler = {
-- 
2.43.0


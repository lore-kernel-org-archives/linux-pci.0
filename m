Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117191;
	b=Ue5yBX4e8WWkq3Z4twY40vcgiVM7QlpsZ5/RK2SnAZ1r7ZaBEHf7POIUyNXvDSt+YlY8
	 0YMwTy/8fOOMhY3gSHZgohW66bTgwxIfH0Bw1k3dHzEoiSFR5s33B3l0vXDivBuOEIWfj
	 n+drRx39vzVdSujshBQthyWDDybaO1Tb5H3vTa92oK6nCxdcjvw3KcRyrCzkgVjlHxFXb
	 qVdO1rKCSBPIDV7ypxpTFmbRe/rNvntCiAt55TFVoERw8l/G6ZGdAAWUUxHtH2ydg/XO7
	 orW54vFbyRLy2Cko7dccJK707WKh6v4x6z3prXTrVrbkHIIEdN6mRQAgD/3I5LObACg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117191;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GNDz0lJ3mwYID4SA9PFD0ECfX4nuBCCsgT92yced4D4=;
	b=piAdp/N5+QEcO0gTT0QvEm9CGOrnBqsED5BU1C8BArMUxaegy42BGc9/1ZORTYm5BFtM
	 hf3580jVYUykrfoF7/pdisA/v0wdVkYMMetsJewSLAWU0El6mSdEDve24eFxspE6MszDp
	 eIXvrD5w59VXvTvmoXhDggMH4Q9kI/h6ibdyfnco5eO/jnmnpqCiP0JR6kyF7LOhKvZCa
	 vv26VO+F4aqWCN61kt34ASehcuffHMqvVVKpZUwiMfkFmBn9yASRTchxJWOkUaY8EW5Vo
	 kmb4Z6sksP2olRAJlu+18WocOsNfsYzxa/67FIVs/zw9ZLJsLvgWsFU8+WE1InlBeoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="TtnIHQ/C";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B86606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B86606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TtnIHQ/C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793117191; x=1824653191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9eB/oGA7tZdrteju60L6fWRCAGFzrNZ+h2YxVLCxAak=;
  b=TtnIHQ/CNRGGPSqzfDBmdk8OghjWuX/aObdOL9v1vuW7CP6ok/4iqZyE
   uBT39v7HjxivIr0R8bzONARwC2Q12ovVRCTf98XRhNVzXFXK51V29hr50
   JRjb9xP06YLMtAfD7BPhpo6/G2oSsyyiIOKPRZKhgvIseywtSDUEN73Hr
   qA/dvOwvaZ+8dbFnVgKJnZMA2n+K3KZfox05H/jSJ1ZNcv6vhLOsO+FfZ
   tdBtu9yHl8SpO7W/AlG8pe7Swn3rsqf4gh4mBT+XvgAOjLC/J0lUhW0Id
   h9lXpKJ0nGQT1AnpFlFomy9UE/XeRdv9SgVo+5unbFPm+ZF4hWJyR8M5x
   A==;
X-CSE-ConnectionGUID: gYNo2iB/T0i6ZrHJ7Ddp6Q==
X-CSE-MsgGUID: Ynotz9zQRoKsnww9+qfWcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1711582"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1711582"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:06:30 -0700
X-CSE-ConnectionGUID: 0eBBN++KSFq9KnVuwNDlkA==
X-CSE-MsgGUID: TmrqXOGaSEWCxlQoT2/yJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4956116"
Received: from dev-150.igk.intel.com (HELO localhost) ([10.91.214.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:06:27 -0700
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
Subject: [PATCH v2 06/13] pds_core: Lock VFs around pci_reset_function_locked()
Date: Tue, 27 Oct 2026 17:04:39 +0100
Message-ID: <20261027160446.858300-7-lukasz.laguna@intel.com>
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
pdsc_pci_error_resume().

Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index a971c66d36f9..b649f78721b4 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -589,8 +589,11 @@ static void pdsc_pci_error_resume(struct pci_dev *pdev)
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


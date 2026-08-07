Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008642A15B;
	Fri,  7 Aug 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114658; cv=none; b=kjBEweVenTiZQZdk+gtH+Pd2DE75gB1woNKhR2DVmzbgRGYqy821fknGBRxcSu5IsNdRQNTdPl0JytklJyoX75GwUso/WutiRrhgTLhhzEKVy9Kg7spNnpY3S84NvHFEMR3nunVUpQNtqu3p6wYopsUYQwcTmjPKec1kXELsE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114658; c=relaxed/simple;
	bh=6Rl+Rgm264AjO8qM07awhvbwkMrjgpE41Tf0eFaZ47E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhsGIixOtu9HLrlC3bbOkKTYgWeOlkY4irbVp7SGTKZ2dV/qfNfeQsyIJrdQcWYcQGemHdlxQ0EzKOGXWwWivFal3g9kvqhJkjgKHUKc+hMb+/orUX/ZN1DadX2QVr3e0rj7Zjn59FrdLMMMdET7unk8BvpEp0r8pJHjS8pF48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tga+gBku; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tga+gBku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786114657; x=1817650657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Rl+Rgm264AjO8qM07awhvbwkMrjgpE41Tf0eFaZ47E=;
  b=Tga+gBkuA9cNxTz/DGz97g4L7/Kj648U8VQ2rUb8LHz4U+8RzazG1tzg
   Tfe4cA+PJ1EcWGKiiU7yKUSE+ifykLWZkBmqXGZr0oTI+tbcY6myLUOxX
   TBqHx4iKoi+hJRD1IOOwmNz/QfKY9/Ae3MUP9Et8GA39aaZhcq50VsBjj
   Ppi9esfOEtisR8LudSU9HL3Jf1+gowPX/3d09ORXX2RliwF9V5eaFf5bj
   xyUOlH73mJuXeTuKpVe4S//IHQ1di6k4VkKZ1Ulpp+SfDZIDtlVIUkavV
   IbVALaeN1yKKwdPq1FnBFx1Tl/eT5KMCCgx+3vCK8BeY5nqU+9lgylt6b
   w==;
X-CSE-ConnectionGUID: aUEQ6zRzRcK04rDNem9fKQ==
X-CSE-MsgGUID: +xLxwFA/SfuA3h6JmHR2Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86485218"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86485218"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:36 -0700
X-CSE-ConnectionGUID: /JuiAGbPSRqY0HkiARNztw==
X-CSE-MsgGUID: EIcZxlcATkyr+d3TASXtoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259809896"
Received: from amilburn-desk.amilburn-desk (HELO ahunter6-desk) ([10.245.245.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:57:00 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V5 05/14] i3c: Make dev->desc locking assumptions explicit
Date: Fri,  7 Aug 2026 17:56:29 +0300
Message-ID: <20260807145638.168865-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807145638.168865-1-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

i3c_device_get_info() takes the bus normal-use lock before accessing
dev->desc. Under that lock, the descriptor pointer is guaranteed to be
valid for the duration of the access.

Remove the unnecessary NULL check on dev->desc so the code more clearly
reflects the locking rules and expected descriptor lifetime.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V5:

	Added Frank's Rev'd-by

Changes in V4:

	Added Mukesh's Acked-by tag

Changes in V3:

	New patch


 drivers/i3c/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index a3778282e84c..5e6df6de0283 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -101,8 +101,7 @@ void i3c_device_get_info(const struct i3c_device *dev,
 		return;
 
 	i3c_bus_normaluse_lock(dev->bus);
-	if (dev->desc)
-		*info = dev->desc->info;
+	*info = dev->desc->info;
 	i3c_bus_normaluse_unlock(dev->bus);
 }
 EXPORT_SYMBOL_GPL(i3c_device_get_info);
-- 
2.53.0


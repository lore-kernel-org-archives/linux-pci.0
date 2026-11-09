Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229860;
	b=WyzAwAUAx1lSw2RUQpTiB9xlZwioNfmyWQOp3QSRV+u91gt4yaT20O4S8Mecze+bqCee
	 HHoZ8HH6dR1ckYVKneg2yeRkU39j7KXbRsfc3GL66RmPgs5ZkDl8yCg8c9b2Beew6AdLe
	 sBQCAPltcPnoSbKuNkhw3Pf0+kLO5gb/kThHrqhXdyxa+lUNFUZTXLDu1vL0SWfHgoOSr
	 QqLZi7zlj8kLRg5HPCnQvB0TyAw7BZJhOB0KSCxby7SZZhImzNmGtepnVlAuBgQFxwKr+
	 UNMak9eOL69FoCiDXpDfcp8LlL0edhEhIZ8pBqYqcSVCQNUhlcuFPwA+vpzlrJzqvmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229860;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=A7mNXlZUVimdG14ChDRBXqLXI8W0LtI4Z8X2rq1hlx0=;
	b=0gL5lQKPi22dwJ11JmcGBzSrDM58kAuGfeVhOZUR+KgAQ04qb5WgOdxUKOS44doTDgOs
	 K1W3/kVOxPQMMRwi8S8ENBF9NDwWM5lNevP1fQaYCUIBkQeLZtYSFOv0Ui0awfFZF7vNi
	 r5VGr3Pg93SxsyMIE8dscdQ95hgY0E0SA+ldMRmSCTArKURcE+TNgPzwdarg5flDkEt1A
	 QGdY8322MvVPW4J1jcY1BClLwprkuL/7X3X2VsCLkmKG10iqkPSsM1XaxMh32k1ilNYpZ
	 235cKHRnLroaAFIyb1kZgTEAlRGJpQON2Vsz3lHgTB4RJB7XDoUJ/GgPddt3zGxBOew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eD1EhzID;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20062608361C;
	Mon,  9 Nov 2026 13:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20062608361C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eD1EhzID
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794229860; x=1825765860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KiHN1pxVayKxO5mupz+g4G35Vt9fAcltz04pRwX/fbg=;
  b=eD1EhzIDSORkpsWPSlE4mxd9u32A6NiQRpTYoJbGpBxO0IEyywSjxVGZ
   VYCP0R5tV3ulOE6dclP5RKoCxjzafmiittiB3SmWRmFqNa6AggxVDCwHu
   LhHbedQU9GgdtqdiWXZEQtOuReQbd9bqC9webzTC7vn/o5dHK0eBt2CRd
   LMOSeLOkwqsZw+Zyzus20wHBRWInoasgQjnAx4yGAJkq9awsCcta/IO9k
   Q51u3aZ/KPG5wyYPR/5oXKxMyhFqhtLLceN4gHvqyGe/dT1El40EsKpEu
   dHmjvX7K/ZpJMfw8iRWtMbjoJKiIAOuaH1nMHuKpV2hdK78qGdHzU3t+e
   A==;
X-CSE-ConnectionGUID: KcTiHIoOSiKKJcrnkpD2aA==
X-CSE-MsgGUID: A9O7s9GuS0CotmCfW9gTSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2843624"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2843624"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:11:00 -0800
X-CSE-ConnectionGUID: pK5ua5WPTUKCTO+ozskMtg==
X-CSE-MsgGUID: msX1r8hZQGewA2KlQ6L/PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7683823"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:10:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] drm/i915: Remove driver side resource assignment after BAR resize
Date: Mon,  9 Nov 2026 15:10:10 +0200
Message-ID: <20261109131011.1815-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_resize_resource() assigns the resized BAR and the other BARs it
released, or restores the original configuration on failure. Calling
pci_assign_unassigned_bus_resources() after it is redundant. If that
call manages to assign more resources in some scenario, the problem
should be fixed inside pci_resize_resource() instead.

Remove the pci_assign_unassigned_bus_resources() call from
i915_resize_lmem_bar().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_region_lmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
index b8a39567a334..d6f5e340657c 100644
--- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
+++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
@@ -104,7 +104,6 @@ static void i915_resize_lmem_bar(struct drm_i915_private *i915, resource_size_t
 
 		_resize_bar(i915, GEN12_LMEM_BAR, rebar_size);
 
-		pci_assign_unassigned_bus_resources(pdev->bus);
 		pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
 		intel_uncore_forcewake_put(&i915->uncore, FORCEWAKE_ALL);
 	}
-- 
2.47.3


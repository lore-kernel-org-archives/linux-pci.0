Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4879399023;
	Wed, 29 Apr 2026 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465645; cv=none; b=VbXAZt42bCKNL4jbTpGiQAkx5914Ho5y9nUuUit78y7OlfjRck1kTQHAsvcXkULk3QU9BIm2wQ35SNkYmc3crJangRXzcarNk4Z/Ie5L5BnrxA7Vn89P9lwiewkZTBcmfRYZ7+3eWQ2rn1woJQJvy9YjbRN5GOQ/SofuNGVBMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465645; c=relaxed/simple;
	bh=8VXJ5q9tWKaV2T92TCmAxPMeclranQN4ydQ0uXeo4AY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMvblRTZVDGMQk1S1qemBxeZJpyCAxmJDvTfxKn4QvDJjSETvxA4yqH5scY9DNKaGxaJ+lGdyA88GblVbIQYR3teJj7IkLzWiim6PAAJ7VUkQ3GIaLgXaoqTuuELUszUOmmFhJNdz8avJQM93ZGTViX9/9h3IWqIakuyNmSRzf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTH/zqHM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTH/zqHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465645; x=1809001645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8VXJ5q9tWKaV2T92TCmAxPMeclranQN4ydQ0uXeo4AY=;
  b=gTH/zqHM0CQH/QjUuj6zUxRbXUlTnuNcit7QGSSqFzIRCckS5YDsP4Bo
   l5msHNbEa6gFXzrTAyVPZ7HISwSsldJ4SLCaXR37ZEqKo+J0ujo+bIffX
   YwoqezD+Artr5I/az89BedvnKhV7Urd7BKy09ncV90F4zqiSbdJmewenq
   YFruvdJopoxWJ6jpAKn+esQc9TnsK9CAvrAdTWw3sxT2ajs+28KwN2t38
   zp0rzU6KC8Id534AbpFgAzJOBPCintj647Irp5TnO8fRMYVKXrXV9PvmU
   gznt2gH/7cGv+Dd2EGGx8lB1suSGOWyMyG/T1GXeiGfdy1Rq5bXVch7Aq
   w==;
X-CSE-ConnectionGUID: n2hr5JWSQmO+ht37pyTZtA==
X-CSE-MsgGUID: kwHYQsGpT3SLBRQ4Yi2UkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101799"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101799"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:24 -0700
X-CSE-ConnectionGUID: Jgvu4VG+RDuYkRSRGmchNQ==
X-CSE-MsgGUID: ccCDbeE2TSqj2vquDJN+4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234512170"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:20 -0700
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
Subject: [PATCH 05/11] resource: Make resource_alignment() input const resource
Date: Wed, 29 Apr 2026 15:26:11 +0300
Message-Id: <20260429122617.7324-6-ilpo.jarvinen@linux.intel.com>
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

resource_alignment() does not need to change resource so it can be
made const.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/ioport.h | 2 +-
 kernel/resource.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 3c73c9c0d4f7..f7930b3dfd0a 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -261,7 +261,7 @@ extern int allocate_resource(struct resource *root, struct resource *new,
 struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
-resource_size_t resource_alignment(struct resource *res);
+resource_size_t resource_alignment(const struct resource *res);
 
 /**
  * resource_set_size - Calculate resource end address from size and start
diff --git a/kernel/resource.c b/kernel/resource.c
index d02a53fb95d8..3d17e3196a3e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1238,7 +1238,7 @@ reserve_region_with_split(struct resource *root, resource_size_t start,
  *
  * Returns alignment on success, 0 (invalid alignment) on failure.
  */
-resource_size_t resource_alignment(struct resource *res)
+resource_size_t resource_alignment(const struct resource *res)
 {
 	switch (res->flags & (IORESOURCE_SIZEALIGN | IORESOURCE_STARTALIGN)) {
 	case IORESOURCE_SIZEALIGN:
-- 
2.39.5


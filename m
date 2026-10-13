Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7574E3240;
	Tue, 13 Oct 2026 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897011; cv=none; b=o/aYnbHjRDkoh6Xh33FRHK3xPbtWWrRWnD3hlcHKlR69vsHaRpP/T0/sB5YgZueFbQk1Jmq+L65nDKDy38bgmBHFUOahmUjxXkz9Nu1jhuIm+ClNqkbKqiMqI9z1rNEoNE9ZlHdAF/e7wsxvO40G5LW3ljHLNNxfI17OBzJM6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897011; c=relaxed/simple;
	bh=uWw7miYY/K6HKIHWabwfzSPo+0rir5K2/cFJqMnC8U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/EF/ZDCJ91Eu3vXHDVHG8DVoylSFdJRVcVYxMJVYf8S6dJy7zocVv2hsmW0qPQJpXHwFvChq3LDvwmwzipFkRjnPuKDLsBxL7/9vsNoccDvGsu0DQaCcc1fFxPrbuRi4nkIuT1xdJrF4ZnVoPhsYUCaM0ZUPEl2cY/aaaHByS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edn9hptB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edn9hptB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897010; x=1823433010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uWw7miYY/K6HKIHWabwfzSPo+0rir5K2/cFJqMnC8U0=;
  b=edn9hptB5QDq83AF9rfOTitEgQ7SbRRFVkeIdcO7VFc0SU7smZSh3Oho
   NVQFhjTQGcROzE1ep8KbfK/fHQtmYXkUFF92IOuBiSiIQyzwHXuJ+QA3I
   /0UWo3T0v205O9qgVuTGupNYgEUAO++kNWhXbjvRZ+o9h4V+sf9QjEDy8
   Rw45M1cdaeHHxDRSQ0DGjq51hFrxTmEje5Gt17WD7ZWATGnTidZs0ufGe
   pxtqWt0cgQ5CAb9L5keBCPwIjEVtj9oP/U6qzCYaYKkUxEAsY8z4dcmCz
   i02AoKATSpjiYeMLbVa1JJEb1RF1IoprWQUK5Ch7ZuteEfnJ2cqnWiJ6D
   g==;
X-CSE-ConnectionGUID: L7GT5ASjQRSrouDo/XRb6w==
X-CSE-MsgGUID: bPxhQNl0QGG2kCm/+yDkNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="614201"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="614201"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:10:09 -0700
X-CSE-ConnectionGUID: tZBghMNyTLqI9NM+tch8dw==
X-CSE-MsgGUID: 1l1FhHImQlqvh3rVTbMcZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1247544"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:10:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 1/8] resource: Mark free space assigned
Date: Tue, 13 Oct 2026 16:09:35 +0300
Message-ID: <20261013130948.6231-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Free space ranges are (part of) assigned ranges. Since new resources
have IORESOURCE_UNSET, the flag gets copied also to full_avail.flags,
which hampers printing them with %pR.

Clear IORESOURCE_UNSET for the free space indicator resource.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index e60539a55541..17e7fccd859c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -731,6 +731,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 	resource_alignf alignf = constraint->alignf;
 
 	full_avail.start = root->start;
+	full_avail.flags &= ~IORESOURCE_UNSET;
 	/*
 	 * Skip past an allocated resource that starts at 0, since the assignment
 	 * of this->start - 1 to full_avail->end below would cause an underflow.
-- 
2.47.3


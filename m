Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AA3BB13E;
	Wed, 17 Jun 2026 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682233; cv=none; b=dAv0fngzpobGHVOIcSUv3SlvOj/4WZTReu/mfUhC3h8KhoS5V0NHVTRPuykLlfVAa2J1lFaUhi1qHe7YYCbkzh1u9PVxool7Fc35bk+OwKi9VujdK1YrXaNjAXdHfwodwxokvce3ao8974SmYmxz8GeQQszn11Rd9cG2O11Pck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682233; c=relaxed/simple;
	bh=vX+SK5biF18HWMNs2gKYB/K/CyR/ty1NqvQZn4jwlro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=art14uwfSHL/v1I1gJQQ0J11MtgzUUV0nsCJ3qrqYrxHDmRuBhkGfolL66CYSFsxKGNE0jyuQ6rQYyipmRmFBd6lbWiMNdoKDeOZlKiiLNEkUGE1wMcnK+QJF0hc0QWBhslOy4YDYJWM+Rp1tlyvdWqAEupY/n2flG/YByU7hfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=en2Jeoy/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="en2Jeoy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781682232; x=1813218232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vX+SK5biF18HWMNs2gKYB/K/CyR/ty1NqvQZn4jwlro=;
  b=en2Jeoy/5oLJUIERqyAoJ2fCyp7aML11lDr0/QseLqM1stil8LxzEWs6
   0WWWq6lDlfv4yB3qaM5RhVUguGCIxakvIS9/EVodyTTU6wYxujZN05aNr
   Sb1XmdHLCJxl3a0qAbPnCbl/0l7fdfOtCDeygvXQusuDJ1pXbjz7HxyvJ
   TeyCTW0jKYfw+jfPPr7hwV6vg6Q1R7pxea8+MDRQxPa4S2rhBmbmc52ni
   ybiXugeZuyYumlPvRvlJLBDlY/SLGf+jPFwWYp+gSSLaO7GmEqGFh8Y2A
   8CHoFshG1436H6cIaC1c/FjoCRpBwKPnTKBX2MlOw3oxtH9iISKPap7vO
   g==;
X-CSE-ConnectionGUID: SW8FKW6+Q0+elStqg8czTA==
X-CSE-MsgGUID: 4Kc/HjI4QRWpOkNVu91N1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93133610"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93133610"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:43:51 -0700
X-CSE-ConnectionGUID: 4+C+s93ZTHiNEEKhh5bHAw==
X-CSE-MsgGUID: xz7U0y1eTuOMAeeIH2qTyA==
X-ExtLoop1: 1
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:43:48 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: Junjie Cao <junjie.cao@intel.com>,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org,
	cpgs@samsung.com,
	arun.george@samsung.com,
	vikash.k5@samsung.com,
	s.neeraj@samsung.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	gost.dev@samsung.com
Subject: Re: [RFC 5/8] hw/cxl: Wire UIO capability into HDM decoder registers
Date: Wed, 17 Jun 2026 23:45:17 +0800
Message-ID: <20260617154521.520191-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609105836.3702787-6-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com> <20260609105836.3702787-6-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Tue,  9 Jun 2026 16:28:33 +0530, Shrihari E S wrote:
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,
> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> -                     UIO_DECODER_COUNT, 0);
> +                     UIO_DECODER_COUNT,
> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio ?
> +                     decoder_count : 0);

CXL2_UPSTREAM_PORT is an enum constant with a non-zero value, so
"|| CXL2_UPSTREAM_PORT" is always true and the type check collapses
to just "uio" -- every type that reaches hdm_init_common() with
uio=true gets the UIO bit set.  Presumably the intent was:

    (type == CXL2_TYPE3_DEVICE || type == CXL2_UPSTREAM_PORT) && uio

I haven't proposed which types should be in that set -- patch 7 sets
crp->uio_capable on the cxl-rp, so a root port may well be intended
here too.  Either way the current expression isn't gating on type.
The same applies to the UIO_DECODER_COUNT line just below.

Many thanks,
Junjie

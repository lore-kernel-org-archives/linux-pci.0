Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD433FE01;
	Wed, 21 Jan 2026 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010735; cv=none; b=bcwzKR7wE8cPfZKu2edhtp52iy+7cGCj/xxFeX9OG10CnoOwr1p8ZWwWHohyky6FBU+HQfSMtO0kpIxjiHUHV8jXO/V0JLt73JwMAm9l/zG+SkEChx4AgCT6dxoLkIsBgefqx7BF/Rgcf0s26O/DoOmrO1POjiFlgpsozwsNsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010735; c=relaxed/simple;
	bh=A4w+rDHjRDiP28J3S2x1QzZ1cmlmuNQef9O9fVSRutk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJfcGQpZThcUaNcAGhlRUavk3We9iuG6gYAhXjvrAdsSQoprXnDOu598dacqkqJ5m+e4mgju7ERdE5IwhMiMEB2OlhdcMS3b1sHtR+IwkK5JRw5WzsNWtLCS7Jys37hjxqtfVT+wx7eNZut+s2FgO/Igqs4mJO9x63T3sl0RzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jo0EATMI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jo0EATMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769010734; x=1800546734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A4w+rDHjRDiP28J3S2x1QzZ1cmlmuNQef9O9fVSRutk=;
  b=Jo0EATMIPzVNZgyds9zNaQvIHVsh/ljotoz/gNsioQAsRUKy7OAABble
   EukupVjX4VjdTqQ40onPMqmMATlcR/IRGT5E4GAWz8IvxBAkWT6NUINmU
   ZNGVyC8GIiJFVgcT6h0k9PKi7h72x3fl49ty5i5WkmjQsQ77suMjQ2wh6
   XjqYxn2I6t3BZ+LIV3HccGxdcX1N9cIHoq+hXkHKqToYoblSkYbXzsYiV
   XIqbjpDtEKZT6d8YSDHn4D9VgRqTy1oLLy4DpKmZtQIp9zBm0R3k2Y1F8
   SHIgkFjp63NTcEskmQubFYNXlyWDAtKwA8V6JNs3s7QjqVbce3RXlQnhH
   w==;
X-CSE-ConnectionGUID: bjt7YXZtQA+tarRNJOQ0JA==
X-CSE-MsgGUID: N8VU+bQeTi+yIEPqLQ+6qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70153213"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70153213"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 07:52:12 -0800
X-CSE-ConnectionGUID: ZX7V+TikReyKM0t+t4WN5Q==
X-CSE-MsgGUID: NMXySlZZTmuPOn7ofhuBPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206804663"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 07:52:10 -0800
Date: Wed, 21 Jan 2026 17:52:07 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: BAR resize rollback fixes
Message-ID: <aXD2J0-Rlh2ZlxSN@intel.com>
References: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Wed, Jan 21, 2026 at 03:14:15PM +0200, Ilpo Järvinen wrote:
> Hi all,
> 
> This series fixes two issue in BAR resize rollback found by
> Ville Syrjälä <ville.syrjala@linux.intel.com>.
> 
> Ilpo Järvinen (2):
>   PCI: Fix BAR resize rollback path overwriting ret
>   PCI: Fix Resizable BAR restore order

Thanks.

Looks to be working fine now:
 i915 0000:03:00.0: BAR 2 [mem 0x4030000000-0x403fffffff 64bit pref]: releasing
 pcieport 0000:02:01.0: bridge window [mem 0x4030000000-0x403fffffff 64bit pref]: releasing
 pcieport 0000:01:00.0: bridge window [mem 0x4030000000-0x403fffffff 64bit pref]: releasing
 pcieport 0000:00:01.0: bridge window [mem 0x4030000000-0x40407fffff 64bit pref]: was not released (still contains assigned resources)
 pcieport 0000:00:01.0: Assigned bridge window [mem 0x4030000000-0x40407fffff 64bit pref] to [bus 01-04] cannot fit 0x200000000 required for 0000:02:01.0 bridging to [bus 03]
 pcieport 0000:02:01.0: bridge window [mem size 0x200000000 64bit pref] to [bus 03] requires relaxed alignment rules
 pcieport 0000:00:01.0: Assigned bridge window [mem 0x4030000000-0x40407fffff 64bit pref] to [bus 01-04] cannot fit 0x200000000 required for 0000:01:00.0 bridging to [bus 02-04]
 pcieport 0000:01:00.0: bridge window [mem size 0x200000000 64bit pref] to [bus 02-04] requires relaxed alignment rules
 pcieport 0000:01:00.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
 pcieport 0000:01:00.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
 pcieport 0000:01:00.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
 pcieport 0000:01:00.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
 pcieport 0000:02:01.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
 pcieport 0000:02:01.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
 pcieport 0000:02:01.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
 pcieport 0000:02:01.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
 i915 0000:03:00.0: BAR 2 [mem size 0x200000000 64bit pref]: can't assign; no space
 i915 0000:03:00.0: BAR 2 [mem size 0x200000000 64bit pref]: failed to assign
 i915 0000:03:00.0: BAR 2 [mem size 0x200000000 64bit pref]: can't assign; no space
 i915 0000:03:00.0: BAR 2 [mem size 0x200000000 64bit pref]: failed to assign
 pcieport 0000:00:01.0: PCI bridge to [bus 01-04]
 pcieport 0000:00:01.0:   bridge window [mem 0x57000000-0x583fffff]
 pcieport 0000:00:01.0:   bridge window [mem 0x4030000000-0x40407fffff 64bit pref]
 pcieport 0000:01:00.0: PCI bridge to [bus 02-04]
 pcieport 0000:01:00.0:   bridge window [mem 0x57000000-0x583fffff]
 pcieport 0000:01:00.0:   bridge window [mem 0x4030000000-0x403fffffff 64bit pref]
 pcieport 0000:02:01.0: PCI bridge to [bus 03]
 pcieport 0000:02:01.0:   bridge window [mem 0x57000000-0x581fffff]
 pcieport 0000:02:01.0:   bridge window [mem 0x4030000000-0x403fffffff 64bit pref]
 i915 0000:03:00.0: BAR 2 [mem 0x4030000000-0x403fffffff 64bit pref]: old value restored
 i915 0000:03:00.0: [drm] Failed to resize BAR2 to 8192M (-28)
 i915 0000:03:00.0: [drm] Using a reduced BAR size of 256MiB. Consider enabling 'Resizable BAR' or similar, if available in the BIOS.

For the series:
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
>  drivers/pci/rebar.c     | 18 +-----------------
>  drivers/pci/setup-bus.c | 23 +++++++++++++++++++----
>  2 files changed, 20 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> -- 
> 2.39.5

-- 
Ville Syrjälä
Intel

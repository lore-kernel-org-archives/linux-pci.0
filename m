Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C848B365;
	Wed, 15 Jul 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131072; cv=none; b=av4jfxbvGtVbW4R6Wy5hn7NBVygAMKmrU9QDwtiCIv37ZHyl5c2ZUsKAQQ9elkP2mJEVmnDJp46dtcbWIhfCuznCnN6lt1npgxWHOwDDonZdHpLinvuCYf0AeUOYoO5MoURvcBearrqYkeTzuJy9QBI/pNJognTlLPCZXFfStI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131072; c=relaxed/simple;
	bh=Cc4fmB36NkjZV10QmGbEykVjRwbveguHgU8funQ3kkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsjawZxKeR7p+VeI7OaGnkty39Y/s3mP6egxJjTnPNP7P62rQIiot/h7AUCS0VQuQV5FnAmMUg7LTPtWAAYoK8kEryXVBsLuerm9cIW9lv3rzhYY+iV/rQ30N7ErjyMxgQfGtqjb72ijkCLUdZJP+T3NUpldhE8KZTGQHNM38+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZYrZJln; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZYrZJln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784131071; x=1815667071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cc4fmB36NkjZV10QmGbEykVjRwbveguHgU8funQ3kkA=;
  b=PZYrZJlnj5Ea6rajr60A3Rgsy2pileB/UJhPLNG5zGNibmd7Obs3PBuc
   HUlIuydvWfyMJL2AUVKWJDXi/yjVtqOOBZH116TsAQvfUaPIW31Na6nyD
   cmhl902Pe9pb/qQPuqlj3vvVmNxjYamtwvxsxZ+OUOItQpi6MCKAWzle8
   s7s2Q2iSrCPQQjOXZnxWJ4fvGE4gUKKEcj1YYmk7mSVpbUYay58Cl/zM4
   gilln/xgxWEl7spzgX/EjZa9NdAIH3u1nrCqOvtMJU0Ljpc+YImW3nRy5
   bzeAL9AhABwyssOyI0ruSFw044dzUc0VQvrIiCbevVNv74NpcxdpkcFsZ
   w==;
X-CSE-ConnectionGUID: E+fDKWe0Rrm/6DVkpQ/v7A==
X-CSE-MsgGUID: 3Nj5VThxQzmmsOsNaDNBdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84732776"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84732776"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:57:50 -0700
X-CSE-ConnectionGUID: YwVVVqb7TImXhi20BxVLuA==
X-CSE-MsgGUID: QhOnIYEGTAmUA7nS3nUtqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="249856952"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:57:48 -0700
Date: Wed, 15 Jul 2026 18:57:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v1 3/4] ACPI: video: Drop backlight parent device
 reference later
Message-ID: <alet-d0ANFzlIK66@ashevche-desk.local>
References: <5115219.31r3eYUQgx@rafael.j.wysocki>
 <3052896.e9J7NaK4W3@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3052896.e9J7NaK4W3@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 05:19:08PM +0200, Rafael J. Wysocki wrote:

> Update acpi_video_dev_register_backlight() to put the parent device after
> registering the backlight class device under it instead of attempting to
> register the backlight class device under a parent that (theoretically)
> may be gone at that point.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



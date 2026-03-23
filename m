Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00652390236;
	Mon, 23 Mar 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263786; cv=none; b=rWlOEWVMw4VFUD16y1dD1xw86Xsq3eY639tr5fz9EV325NRmENzPROyslWbAyRjzaRu2bS7+sSMsCp4Lju+Aw3vgtVNGw1egFNeUdSI+Ics7qsVUcZbHMDNcU/zhR1oZAZQ96ExXhfZZoOre7adYmoTMVs3uIo6hB3fzzXMz450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263786; c=relaxed/simple;
	bh=lwzszmN0gUEL/hG6F2iaX0s8NeEJgFur5NjFkR20Uys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgOClanDl+IdpwoqzM2kk0lNoFarYzoMmVcDP3KOclcE4iUGW3Lo9VZbN9F3O9RHea4aurF43OeyNC/EmLgx+i7cPtnHnP6NrSaE2KhSOE0Lobte+JsnkIYPggDZFvLxUIgEIPLYPMHCsIncK2a0PBvOnMaIQEP4gZ4O4t9LaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSTw/RLw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSTw/RLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774263785; x=1805799785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lwzszmN0gUEL/hG6F2iaX0s8NeEJgFur5NjFkR20Uys=;
  b=JSTw/RLwOAlKBB7e/25YzpmI2KMN8Kjr7Gh2YqR/gknmQ3550f1bFPZQ
   A4dy7OFGV2y1vb4Pp+V5OJvRANlN//tA3KAQRzTvrMCtgM7dcxN9gImYf
   w+hFYjZD6culaZaKztStW1zuOqaEdkJYXFKNFRtYji3qsJRYt2MWsgBkr
   kNGXuRPBjT4NehR0m9+Epnp6VgjuG9NCjLR9Ysg54rGly2+OspyM28soS
   uCyNiTdMigTLoi5BiPMgK6eInw4qlRpYs7AYzffvagQQZjRlk8TFhNPlM
   8VK3cKtXviAUIeG7UqJXorG8eYoAE5Jo9jlmPCEi6yJSU8fNSzaL4ex9x
   g==;
X-CSE-ConnectionGUID: mBOSxtqWTWuaUUdEkVV8yA==
X-CSE-MsgGUID: 2xqiAxhFRqqhYsFcg/YEOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75282125"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75282125"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 04:03:05 -0700
X-CSE-ConnectionGUID: 873TmT3jQ4y335vwFWd4BQ==
X-CSE-MsgGUID: yWr1G0QiR3WIzW2GQd0Elg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="225713352"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 23 Mar 2026 04:03:02 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 75D2995; Mon, 23 Mar 2026 12:03:01 +0100 (CET)
Date: Mon, 23 Mar 2026 12:03:01 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Maciej Grochowski <mx2pg@pm.me>,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: Re: [PATCH] Documentation: PCI: Document decoding of TLP Header in
 AER messages
Message-ID: <20260323110301.GX2275908@black.igk.intel.com>
References: <bf826c41b4c1d255c7dcb16e266b52f774d944ed.1774246067.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf826c41b4c1d255c7dcb16e266b52f774d944ed.1774246067.git.lukas@wunner.de>

On Mon, Mar 23, 2026 at 07:52:39AM +0100, Lukas Wunner wrote:
> The prefix/header of the TLP that caused an error is recorded by the Root
> Complex and emitted to the kernel log in raw hex format.  Document the
> existence and usage of tlp-tool, which allows decoding the TLP Header
> into human-readable form.
> 
> The TLP Header hints at the root cause of an error, yet is often ignored
> because of its seeming opaqueness.  Instead, PCIe errors are frequently
> worked around by a change in the kernel without fully understanding the
> actual source of the problem.  With more documentation on available tools
> we'll hopefully come up with better solutions.
> 
> There are also wireshark dissectors for TLPs, but it seems they expect a
> complete TLP, not just the header, and they cannot grok the hex format
> emitted by the kernel directly.  tlp-tool appears to be the most cut and
> dried solution out there.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Maciej Grochowski <mx2pg@pm.me>

Good idea, this is useful.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

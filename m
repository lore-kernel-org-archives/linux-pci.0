Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5235E1AE;
	Sat,  3 Oct 2026 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061601; cv=none; b=of547hQqEfN8UbogFbzlQN1e6wkeE7kmLVGCdbNi+aainzEqcH+KQE7vreN/vM+g3XKPbIsLubJhT/Rtn+SO0YNdydBeq5rMem6ab5lOn94IR8dYBEmnftz8dm7bzFyxISnEnukBJB/7y1mIW24wf/6TQDOIaFKWs/HhQofRyKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061601; c=relaxed/simple;
	bh=6YmSDdxKEVQ0IENYScjeZQmJ83BkyUs0pR5KIXOTRHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVsmc763H031RMaYteGyQAoi8CwJ3nI248kPQI7uHj2iXzrHBpgmlrrZtkzhlli9idT/CUF3xaftEO8/gEp3nEkIdG7YdOrhwW5XQhcZcJRHHQ7WpaRFO/mch+i0X378SYNFH/AcC2ta7asDvD3/tPpUu/4VP+IISoLYcQiyBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXPudDZ6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXPudDZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791061599; x=1822597599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6YmSDdxKEVQ0IENYScjeZQmJ83BkyUs0pR5KIXOTRHU=;
  b=EXPudDZ62kiS8j7tRxY7M3l2zA193tr54V82HSogfQYk5FDqgohCQHmJ
   6blOYv3xdrk/e1WHwOkTEg0PP/rH1bvfpoaSrURrBqioZDAJnqaGCT3pd
   5nN0Wmup7HJIqFVP8QiWf24akhDZpdBepshNty2LmoZk5V5fa2bbyVF3X
   iQDdgFWAgFOzXl8D/Es9LwGWmjT7CAZwFPynm6cdDdeqSsxGI3YehvqAY
   NeV+vQShQdynBFfB2y0NccK8x4kv1yOiw6KSzTcWCBu/Pg/xZXhr3icqX
   pW946qZ+ITLHTJlCKtA/MoBIfQmOyu5Vnm6eVLUR9vkQPO/AM1r5YoxiY
   w==;
X-CSE-ConnectionGUID: Esud+GgVTz+aWM+1crf+RA==
X-CSE-MsgGUID: UuPh5mZqRN2GYXFEQBlVQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90920242"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="90920242"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 14:06:38 -0700
X-CSE-ConnectionGUID: xzKpLxD0Q7WmjJcYGWMcHA==
X-CSE-MsgGUID: mTNviLB7RZSKfuuXuz3wGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="588311"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.88])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 14:06:34 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id DA1B611FA5B;
	Sun, 04 Oct 2026 00:06:32 +0300 (EEST)
Date: Sun, 4 Oct 2026 00:06:32 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-pci@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] media: Consolidate AtomISP v2 PCI IDs in the
 pci_ids.h
Message-ID: <asFuWAQUPxETWqDL@kekkonen.localdomain>
References: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Fri, Oct 02, 2026 at 11:43:43AM +0200, Andy Shevchenko wrote:
> We have a few drivers using same pair of the PCI IDs across the kernel and
> there seems more to go, consolidate AtomISP v2 PCI IDs in pci_ids.h database.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Assuming that media subsystem is the main beneficiary I think it is the best
> to route it via that tree. For others (i915, PCI, PDx86), please Ack if you
> are agree.

I missed this earlier... I'll take this via the media tree.

Thanks!

-- 
Sakari Ailus

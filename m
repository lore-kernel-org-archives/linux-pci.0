Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3222A4EE;
	Mon, 23 Feb 2026 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879032; cv=none; b=PkEEtEbMgaOj9IFIVwP7aXDYCdb7scyhNiTYQ4ZfKh/hDyRdw0oqC7fGWF7exferRzjR3/MjtvFKBN9L9Cx97FJbKKH3qR4tbMgvayt6GqFuHq10tSpztbody20a7l9awXOZvyJKfQMO09rPOjqFZ4yM9T//8niLuESLTqrHDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879032; c=relaxed/simple;
	bh=glIjqqtHnoQ3/dJYexcXXlyM9zaoPblIiJ37YOk4Ar0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz2fQqLjYmkkOAd+ii32qUnG+MmuzNjIOnTrp/ZZozbpWz37FM5A9MHUne11be7zYZK9iHa2CD4wi/Uh6MspYYb71DEHvTvZvQRJRvB57bE8qP1+TT+FVnwIn/+/0eZgvdu7j9vTn+a/2SyWRfjTAkEF6RIKSKGjyNow0fkOtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KscPfkTM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KscPfkTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771879031; x=1803415031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=glIjqqtHnoQ3/dJYexcXXlyM9zaoPblIiJ37YOk4Ar0=;
  b=KscPfkTMVoWoQzLrokBMjSpCuR0oMwfXMVAHRTZ8yX0fVMbSsURajt4Z
   SLDOq+gDk+BEcvNaYpFyLrJtyAQrif2+nyeX9cKAUSO8LdV3BwIzb5H2f
   mVjliPGxILA1FS5OEmwFVGy0hkqwdkuyGMDrIa02v1YmCkIfGoP5tDUAX
   yaIzk+tO87lcOjeeov2ThqI7S0acbYXjSp5hnBcNg161agS7K6r1St/Yw
   8mDsI2k+mv9ZRHTUmbVuavJe+9XgBQrj/yygpWnT6FskXtk+veUID1emj
   F6sHqC03/Qn440KtbVCr0dQgq7jlU18jsdLEJfDfmhlEhD2JNL++PtIdB
   Q==;
X-CSE-ConnectionGUID: rTT5siZaT0iSqD76EzarzQ==
X-CSE-MsgGUID: +EBvGciNR6G0YvuvCuoE5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="90467415"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="90467415"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:37:10 -0800
X-CSE-ConnectionGUID: 3ce1ZNztSBaRrtu5spVebw==
X-CSE-MsgGUID: LIFPJdGmR6ikLz91xKt/3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="213988516"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:37:08 -0800
Date: Mon, 23 Feb 2026 22:37:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH] PCI: Disable ATS via quirk before notifying IOMMU drivers
Message-ID: <aZy6cge_a9a7O03g@smile.fi.intel.com>
References: <20260223184017.688212-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223184017.688212-1-dmatlack@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 06:40:16PM +0000, David Matlack wrote:
> Ensure that PCI devices that have ATS disabled via quirk have it
> disabled before IOMMU drivers are notified about the device. Otherwise
> the IOMMU driver will see that the device has ATS enabled during probing
> and then later it will get disabled.
> 
> This fixes at least one bug in the Intel IOMMU driver where it adds the
> device to an rbtree because it sees ATS is enabled, but then ATS gets
> disabled via quirk. When the device is destroyed (e.g. hot-unplug, VF
> destruction, etc.) the driver sees that ATS is disabled and does not
> remove it from the rbtree. This inevitably leads to a use-after-free
> and corruption of the rbtree.
> 
> Fix this by disabling ATS via quirk during "early" fixups instead of
> "final" fixups.

Hmm... Sounds to me like a premature disablement, but I leave it the experts.
What I think about the case, that IOMMU should be probably fixed to avoid such
situation for all level of quirks. Can it be feasible?

> Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devices")
> Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/

> Cc: Raghavendra Rao Ananta <rananta@google.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>

These...

> Signed-off-by: David Matlack <dmatlack@google.com>
> ---

...may go here with the same effect on email, but reducing the unneeded noise
in the actual Git history.

-- 
With Best Regards,
Andy Shevchenko



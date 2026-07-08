Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1B262D0B;
	Wed,  8 Jul 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521217; cv=none; b=CrA/nfExbgBx6nBymffT1ANr/G3YcPd1OMyClb/nUBNK00OmJW4lbuRIynOVtgL9bvXxeUcFV7PmCFvXrzEGgU8B4Ybq0kYeuzwfE3ksoosbioPfuKC+NBwFCWBUaIVsMf2P5Y+jXWFEI85rewGuUGUnaszYGbcm1lKHgQ204UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521217; c=relaxed/simple;
	bh=8C8X4vP+A7G3owbVIx2Aqa2iT7J/SaFyqNUq/e8jmSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So/a1dwrrjljLmThPCcNzMnz6JnT25oHq3umnHW/mEsy3Lb/0AxM+NdILzY3sKmNjH9J9yUZH5Xe/ViEYc75Co28+w0Y7G4equu1/H06+qo0Eo21HH0Dtmzr9D5grRd/yZ/EirTCC1bCZO/SjttSjlh9idfEWDx8o8BCKRwwvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EW1W1nWX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EW1W1nWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783521216; x=1815057216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8C8X4vP+A7G3owbVIx2Aqa2iT7J/SaFyqNUq/e8jmSs=;
  b=EW1W1nWXvqpVRFZvkLSDogL3Q05OzoEDqlbm2yHU2CPRTyV2h6yxxBbb
   kFz0XnzHulyMMDPOJj1gqncizW0ksgOzWYOangMQijy7axFaCyp0mdSTg
   ebD5KUwrgeo36XvcWnuS4qGNRWELwjhesVfNrFk2tyRK9tfhrdnBjm5Eb
   uyPHbte+k8h0ZsfWJTE23eSJBM25lYJdZXUic2QTy3Scgf1EncI8eQ/XQ
   LUq/YdndvGEsQyquADTzyZ8GX46Ozbt+tE+NJmZTuPzWJhPa0dW//fiad
   j3D+nhFFW6avdyryskJpI+47WamQo4vGM+71bxAD0kYAx5STQCsAdt8L0
   Q==;
X-CSE-ConnectionGUID: dZSR3/ASQgaacdPIxlF9CA==
X-CSE-MsgGUID: mafmUwzIRfSi3SwfBP9sTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88097493"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="88097493"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:33:36 -0700
X-CSE-ConnectionGUID: Ym94SfGoQMGiSKjoqlCRUg==
X-CSE-MsgGUID: UJuPNHZWTmeeK3SkecJbkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258604784"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:33:34 -0700
Date: Wed, 8 Jul 2026 17:33:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: acpiphp_ibm: Do not use uninitialized
 device_class
Message-ID: <ak5fuxGP1Rsqr8kd@ashevche-desk.local>
References: <8730724.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8730724.T7Z3S40VBb@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 02:40:22PM +0200, Rafael J. Wysocki wrote:

> Passing an uninitialized pnp.device_class string to
> acpi_bus_generate_netlink_event() is effectively equivalent
> to passing an empty string literal to it.
> 
> Accordingly, make the driver do the latter instead of doing the
> former.
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_class from struct
> acpi_device_pnp in the future.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF0E33A70E;
	Thu, 16 Jul 2026 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227014; cv=none; b=puLSNBr31zCsTlqeRaAPnDxA8tlSK9yeQddvdnv9NxcbsD6YS4z8uOFgoT2VbItB52jzt+XNLti2GK6Mvf2PSasEjGTXmD/VDfeDF9S9tm62Vwe1AgXSDlnSdZzuGweNmOiSaI+6Zypl0KCiHt7h20tRLtrGXighxaoK0HZxspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227014; c=relaxed/simple;
	bh=BchtDMMKp+TIsPTrVl+PvcLDOZOFvhR42RmqjR0SZf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpN24dA/F4s2Yex1u7s+zQXlzeXvz8146UF2phKDgJd/9sDnIR4BNORnvhHAF5Zfq+BW2nh3sZP7rdXUElkwjLx8i082E7sfckLH1HaN7TijJIJVjqymKHQEj4LM2uGooFCz0tapegLbz95l0WVX/8PmF7jAEiTwRfavdN02R6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O09A3qDh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O09A3qDh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784227012; x=1815763012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BchtDMMKp+TIsPTrVl+PvcLDOZOFvhR42RmqjR0SZf0=;
  b=O09A3qDhf4fDI8eJZiLUymqiOtuu+m7dVI+eIpyXCsUFn6OW++NHj00w
   lfUZQ8LqyT8DiOfZp/QAD9lc8QLT/Ay+mxIxX6Lb06HAzksBn2ZNr7yJV
   gMltuur3yrSfqn2PrOWYkmztAIWdoxdP1UtqCbRR3pFNrQj/oUjKZjjW0
   FghGiTddeQu0RGtXxBwjd9N3o92ZdT+B6E1usEMNcgmcTmLfi6iF6ao7M
   DCc0Vr9VIy5SSbK2jAqGKC7BYOC9dTBGBCjKglxojLz/zM7bNnBZMMAoc
   1i7npfTLJS3g8YG66oVnCBpgEFIYn7PAuQO8BKTRfg/bJoqiBBP+aDzBX
   Q==;
X-CSE-ConnectionGUID: PhC2l1wpT7GguzNQ1vh23w==
X-CSE-MsgGUID: PJBW33RUSUWJmU/2nXt4TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84674869"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84674869"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:36:51 -0700
X-CSE-ConnectionGUID: NLhMM2KLRSa+IAHR8Qe9RQ==
X-CSE-MsgGUID: e7zl5Y0IT/acSWvpLiU8Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="281018681"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:36:49 -0700
Date: Thu, 16 Jul 2026 21:36:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 2/4] ACPI: PCI: Introduce acpi_dev_get_pci_dev()
Message-ID: <alkkv0dkx4lhuzC4@ashevche-desk.local>
References: <12935400.O9o76ZdvQC@rafael.j.wysocki>
 <3430928.44csPzL39Z@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3430928.44csPzL39Z@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 04:04:53PM +0200, Rafael J. Wysocki wrote:

> Some acpi_get_pci_dev() callers already have a struct ACPI device for
> which they want to get the struct pci_dev pointer of the associated
> PCI device, so they don't need to look for one.
> 
> For this reason, add acpi_dev_get_pci_dev() that will get a PCI device
> for a given ACPI one (if possible) and turn acpi_get_pci_dev() into
> a static inline helper passing the acpi_fetch_acpi_dev() return value
> directly to acpi_dev_get_pci_dev().
> 
> No intentional functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



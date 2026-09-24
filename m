Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DCA3BD635;
	Thu, 24 Sep 2026 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281553; cv=none; b=ieilhFQKv+6BnFdjqwL1+6Lzih+obLCCdhhB5b8lfCG56Lltq9+vVM6G+jGd0hhb7FK8Zhm2eSEldXEgWM1oCVrr1ne0GrMFYrDHcC0o1rebNCY2d/IMzgbD61WN6c6e+EPxLa6PyF2L5VUCnZk/o6tu16hHFhnNjYuCIK9bWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281553; c=relaxed/simple;
	bh=gYK6ndsFHPVYHwKFga4puHoXE0sqDic9pm0N4BfZYNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHT05ZcOQr6SB/43uM1X+dMOyKq5yhJVZKEAM6o8GH1qQaBB3iDGgxYWWm/ruus8f92kiXMS+Gc1b6tl9qdwzFbjnaYVtzV0ua+46Ld69o9O1Nm2v16mCKbzQsd3b1613+Ota4/4TsCHXlt4RXtcSe+USUsGzvREXesnp7ysRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zv1AdEXk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zv1AdEXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790281545; x=1821817545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gYK6ndsFHPVYHwKFga4puHoXE0sqDic9pm0N4BfZYNk=;
  b=Zv1AdEXkLafcUxVuL1XoXR3k1sLy44BFpzms5VMrhMP+sSu/MQlhjqQr
   eokOGXUzwZ7lua9O8Ez5tLZ6I+jWXruvNxpK/RdTwXIJPKrpD0F9yfFeN
   tudQNFZeAI0LwhDAzzvURZvqPqteGS6bEgVw9l10LO1Fmpt5zl0jBhuDn
   eP6e4V+LzFCwdgOu8p+jAqtOPPsMQtc0hAvq75PFP0xi01hObCPyJ7mtx
   /nuSx+pmToDBmoJwHGfxrAH5TG26L5IWnEe7CsyYKKS+VxqFarsOWdxc8
   D8pecDIhHBwUP0WkB/d6ObYMgAJ3lq6evPKd/gZBv10yCMVaO8LE1XW00
   w==;
X-CSE-ConnectionGUID: rK7y5XBRQgOOWBliy43UQA==
X-CSE-MsgGUID: 67N7FgUtQSifWZbEa88hRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89977133"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="89977133"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 13:25:40 -0700
X-CSE-ConnectionGUID: Yg+Sv6gGRDqo9Oi07q8ixA==
X-CSE-MsgGUID: Omt4/15OTcWXQrw3pYJv6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="274236211"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 13:25:37 -0700
Date: Thu, 24 Sep 2026 23:25:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] PCI: tegra194: Check core reset deassertion
Message-ID: <arWHPtdCfbmnMKxT@ashevche-desk.local>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-3-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923072237.1139013-3-mmaddireddy@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 23, 2026 at 12:52:28PM +0530, Manikanta Maddireddy wrote:
> Several paths access DBI registers after deasserting the controller core
> reset. If reset_control_deassert() fails, those DBI accesses can trigger a
> CBB timeout, or setup can return success with the core still in reset.
> 
> Check core reset deassertion in Root Port setup, the DLF retry path and the
> Endpoint PERST# deassert path. Unwind before DBI access when deassertion
> fails.

...

> +		ret = reset_control_deassert(pcie->core_rst);
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to deassert core reset: %d\n",
> +				ret);

We have pci_err().

> +			return ret;
> +		}

-- 
With Best Regards,
Andy Shevchenko



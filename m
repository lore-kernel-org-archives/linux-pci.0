Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E97083C;
	Mon, 28 Sep 2026 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584819; cv=none; b=s2Rezky6oC3GAOvLSDFWdnl1odc3+oZRgnEYCTK5E5KJLzfpLQVFaZLW9Q8ng2qdgn66HpLB/jaIphglRjbhaWpMCPXl+OtKKUmYYfCEIo1zfW71F7tD34+EtQqwR4bP0iaj4IFsA6/WSBZG4RhGS52H3c4n4uzI+RJ5aJGBmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584819; c=relaxed/simple;
	bh=P5mxHYVpnmelHKIgP6O6mmW+MIgYR2G0Dglhx0fDJWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgNb7Av0iqfhk9OpGcsLqWgiwhq0E6m8Ge4VzgshyEAxb3eD0HzB8XrM40x0IBuy+EPzUKbBt1uJXAvrs08ujCpyljGbQ99VOJDgKT+J1K1qhUwM0zJnfqosOeIzl54HjME1yG0Z1fD28gn2nMFTdwcCVwbvFa6ROoqy57uuqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrdFLLOH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrdFLLOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790584816; x=1822120816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P5mxHYVpnmelHKIgP6O6mmW+MIgYR2G0Dglhx0fDJWw=;
  b=QrdFLLOHZrspztxYbKxA4dNkSl3hFKdrT9o9uNMvnsNY4H7mHjRhjE/J
   yNItS8oQdfkAW5jGEHJcDTLtI4d8RFo/VfW6Lc9UbNF+KYa0ewcY/cCKa
   fNT8ZUTsGr/dDASb1Bg/CegDbtTLtoq8KzIrLTmWwyCVEbCc5Lhhyfh2U
   yVJc4jUcXfQ5ioB1CIVoe8/66ktORFbpsMUshnv1esFIRj5liM3xhct0K
   Q+oGnRAeA+GN/3viUZmrajO2BdgGhWBFgiWNpsC4F9lIb+nTgu/K9jpm5
   0tPx7EPqPBDiEQiu9fv826bqjsA9U3hpQm9hNdnvXDHMaHaLjHhGmN3Ht
   A==;
X-CSE-ConnectionGUID: Hi3dROPxQCyYhEWtEAIbFQ==
X-CSE-MsgGUID: sF1qA0/JRQaHT+Ku+t4sVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90181276"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90181276"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:40:15 -0700
X-CSE-ConnectionGUID: sG/cqplNQFa2g3W+eq5swA==
X-CSE-MsgGUID: 4EP6RJZRT52npEeblPF61g==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:40:11 -0700
Date: Mon, 28 Sep 2026 11:40:08 +0300
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
Message-ID: <aron6OqtGqvuUKE8@ashevche-desk.local>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-3-mmaddireddy@nvidia.com>
 <arWHPtdCfbmnMKxT@ashevche-desk.local>
 <474a85a8-501c-4b11-b53d-0a40fd74662f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474a85a8-501c-4b11-b53d-0a40fd74662f@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 28, 2026 at 11:15:07AM +0530, Manikanta Maddireddy wrote:
> On 25/09/26 1:55 am, Andy Shevchenko wrote:
> > On Wed, Sep 23, 2026 at 12:52:28PM +0530, Manikanta Maddireddy wrote:

...

> > > +		ret = reset_control_deassert(pcie->core_rst);
> > > +		if (ret) {
> > > +			dev_err(pci->dev, "Failed to deassert core reset: %d\n",
> > > +				ret);
> > 
> > We have pci_err().
> 
> Thank you for taking time to review.
> pci pointer is of type "struct dw_pcie" not "struct pci_dev".

I see, thanks, naming is hard, indeed...

> > > +			return ret;
> > > +		}

-- 
With Best Regards,
Andy Shevchenko



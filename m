Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26857C72B;
	Wed,  9 Sep 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964037; cv=none; b=jF05fKc5xgdbD+5VgCZXMm+qnW4WBPoh7QUy1e4wcxThgVuP3oMbeY+bd7MPOAXR5b37WtON9OYr6nREqoW15gi79y6iJWLqs4YlUJKYWysaXRFQrgX2d40AxU7XRsz2Ra44OOATZRvqKvGDodR0wrPCV5jXFU2rUtzG9TIiQ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964037; c=relaxed/simple;
	bh=Xzc9CDaEataSODX3+D8tIBpZnqAi1qMg/rSgS+n+z2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuWtKPqp9iSt+39JVvIudDc0Ao2wT7Ubna28TiKWEZdG/n3PHjWDw/oDsvMFmamzTXvK6wJw1njfU4JYasqVTgX7gVvTMJcSGRk9WXjuKGzIrpCS7kFM7l+QuqNi5hE404Z76SomA6g8+mABVEJP2ineyrmy5wAknSM/4D65V9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpCzk5Y0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpCzk5Y0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788964035; x=1820500035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xzc9CDaEataSODX3+D8tIBpZnqAi1qMg/rSgS+n+z2s=;
  b=hpCzk5Y0BdH966YP/VSV4n07VtcZ0ptkt5AfDCluym00s/AanVEh9+vd
   tZxCkPyngRBsJeSh2XlOEhrHcHKR1f4KA/4Pn1iF0IbXCSqH5DGOfG7NW
   Q98biVB9dlPR28ViOAhMiXCFLhig96P5p5ngDX30WYeLTEGy5Fgm5jxy6
   4Hu33uGcRr66U0R27CBh9xwL+2kolmVAv7YThszhbgnPvZvAQj7tTPvI2
   p8ZxIyiC3mQ9RJqFsSZM1ILlYy9EV1x7H1o0wU31HgcjqMKYyz+p71cMK
   ZG9EOcpjrDYZgePZmXF6roiAMoXIxK9EAabTPzuuqiEtjB1vOtvTVJ0tx
   Q==;
X-CSE-ConnectionGUID: clsaYYlVTeaHzS47XKArGQ==
X-CSE-MsgGUID: RkgOe0H8SxqWCSoa2ABjtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106908361"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106908361"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:27:14 -0700
X-CSE-ConnectionGUID: O1CZCFz7Qyap+OeL8wYAUA==
X-CSE-MsgGUID: 8DeSi4z3Shev8h1HQmYGKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301221372"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:27:06 -0700
Date: Wed, 9 Sep 2026 17:27:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Alex Elder <elder@riscstar.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: spacemit-k1: Add multiple PHY handles support
Message-ID: <aqFst9QH9YTFlY3X@ashevche-desk.local>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-3-inochiama@gmail.com>
 <ap_jh_NAqHnIlZeu@ashevche-desk.local>
 <aqEQnkrPSKB-3fam@inochi.infowork>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqEQnkrPSKB-3fam@inochi.infowork>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 04:00:15PM +0800, Inochi Amaoto wrote:
> On Tue, Sep 08, 2026 at 01:29:27PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 07, 2026 at 07:26:01PM +0800, Inochi Amaoto wrote:

...


> > > +	count = devm_of_phy_bulk_get_all(dev, node, &k1->phys);
> > > +	if (count < 0)
> > > +		return count;
> > > +	if (count == 0 || count > data->max_phy_count)
> > > +		return -EINVAL;
> > 
> > Elsewhere we distinguish count == 0 with -ENOENT.
> 
> Is there is an example? I think it is suitable for its internal check 
> to translate -ENOENT to count 0, because no phys property means no
> phy. For a get helper with optional semantics. I think it is fine
> to return 0.

This the brief list of what I roughly grepped with word "count" in the name.

gpiod_count()
of_hte_req_count()
i2c_acpi_resource_count()
ice_sriov_set_msix_vec_count()
reset_control_get_count()

-- 
With Best Regards,
Andy Shevchenko



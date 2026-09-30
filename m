Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D644C51D;
	Wed, 30 Sep 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755073; cv=none; b=fiht1dC0Apuhz6pQWI6g4Sr5B/vqEwiJ2YTttnh+w2oLELdHJbwVpF2fUnkRgqmjinNr6DRB2eUrz5Lo++RewnHZhXatoPQqJ70nfBzftt30ITwVx0UVZOf2WXBe1v55DAxuhR1zrXnawJngdcYpZKp/V5O+NaSWuXmTgjB9VeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755073; c=relaxed/simple;
	bh=cuwgXGs90Gk/ODGQsA6axEGFAM6CWZSsxbIz/u4KVd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJN4v7twSBBgggfP/d+qpgd/RLkvklhyTbdFBGlAYix8oDc3fNLKhVPzMtDr6Hom6Kmo1DqTCyDsgbmtJ4zpbL4+ACqem2+rIt3nTp4V/50YKf5S3XrsssDo5/a8AJ0RWKsMTgwmwx+5okS6INsvI09CKtqEiMfSqbpzQExExYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TupeDRrj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TupeDRrj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790755072; x=1822291072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cuwgXGs90Gk/ODGQsA6axEGFAM6CWZSsxbIz/u4KVd0=;
  b=TupeDRrjVXwIfiRAMAQEv8y7khJ/7hZJMDNeckWUrByQt91YyT3mhdXm
   6mvBLl3jyqCzJQdn5uXqi8CrC1JWgXx6jWszYfQQl/RGceFxeIYYW1gxq
   0S0IOYKDAtoe/u7G0pRZTILNuhFecatjImfIcbj4FU2qh58dbrKBuZFIP
   PtmH0xdOyx4lY2C/c/JOCyWp5WhrxCFou5eHXrozoRxahSNDYGrY1quYc
   7rPkcGrnutosHcrz3LgafMLrg52AiPHfQuDYYI9KiKAYiZkTH+Ha6KvVd
   B3E81f/AoVAYtQBv9B7aVdkvYp2IEMq+2mwI1IbKwcjOzB0nhYowVJFm1
   w==;
X-CSE-ConnectionGUID: ERoFYTnFTdaGyMSmSiu01Q==
X-CSE-MsgGUID: AXKmy37pRweM2n81x+YI6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="117015327"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="117015327"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:57:51 -0700
X-CSE-ConnectionGUID: DPdnac1mRyaoOETELn+/aQ==
X-CSE-MsgGUID: Paabs1L0TRi7PxRmTrUolw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="279419770"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:57:44 -0700
Date: Wed, 30 Sep 2026 10:57:41 +0300
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
	Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	Niklas Cassel <cassel@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Randolph Lin <randolph@andestech.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v7 2/6] PCI: spacemit-k1: Add multiple PHY handles support
Message-ID: <arzA9VgJvKr2G7bq@ashevche-desk.local>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929083755.458238-3-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 04:37:48PM +0800, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 may use multiple PHYs at the
> same time. The feature is not supported by the current driver.
> So extend the PHY definition to support multiple PHY handles.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



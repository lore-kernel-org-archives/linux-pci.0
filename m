Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18551120E;
	Tue,  8 Sep 2026 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863383; cv=none; b=PxkY0ZcUZb2y2oBnUoDeLt8+EffiQvgUkXlqfU9E9hgndb5jaxAiJ6oobxmy1GasNZjPoZvWNALbK0hxME3t7XUEqbPFc34ZPEwzUss75hw5nc9SCx0d6MNCSPC3IGTyf/YihbmtEt01sQd5mnEidCEltu6vYjO3Y34sWOt5/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863383; c=relaxed/simple;
	bh=jkB1zD6Jn9zXtXuHn8a/znVZ/dAQ8s/MQdg2UsJtUY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNTrY9Agk4SczQz1mzIWj36/64IMXD5y9j6Mf8+qxx352YoTz/IkdTQtzDtg3L41/vbCZifo4PnwzDV9QHvdjuTzpoDfU0v7lt3JTwB67iKB0NpJUzUHkeJLNXhrN6a+jkmLz0O+A/RV1SW9tcEdKNRumKl424aos3H3FrS2PSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDeS1buP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDeS1buP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788863382; x=1820399382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jkB1zD6Jn9zXtXuHn8a/znVZ/dAQ8s/MQdg2UsJtUY8=;
  b=lDeS1buP9YDkDYwG5IljSL5pCEY7DKeQTgboK0rqiMOybrU3fvxqOK64
   IN97RcPyjtElkfjFy55l3ol+260Ztv7k8hZTa7ArqVj/H2PYRWFbUTVcu
   Ghlpy1TWS9k5ZYYQLls0xNqFJjkF1FEzQ16OHRAh7vfXNk66RztxfSdUZ
   9Br5SftPCV467LZtoZfG5mpybwMkUqQ20SzCkmu4LQUV5OIq92Kw063F0
   5tUH1fzQiH2GxxdToIOJb4dmHkfeM1EDfWHpDLRHUWds8vJFy5rJvaBMY
   cQ2Xpk9ld4qgEB+B7lifl1++vQPcBD8lPJTh8Or1SFZm9KlbogYTxRkU1
   w==;
X-CSE-ConnectionGUID: 8XouAd3ERFiIxfnSF0hnUQ==
X-CSE-MsgGUID: AQduja7VSDGZRJyJtIoFoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89017912"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89017912"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:29:38 -0700
X-CSE-ConnectionGUID: pLoFB+6XSpih592zmri7pQ==
X-CSE-MsgGUID: eCKyAV6nTdKnJJfmYy0uaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="266610116"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:29:30 -0700
Date: Tue, 8 Sep 2026 13:29:27 +0300
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
Message-ID: <ap_jh_NAqHnIlZeu@ashevche-desk.local>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907112606.465778-3-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 07:26:01PM +0800, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 may use multiple PHYs at the
> same time. The feature is not supported by the current driver.
> So extend the PHY definition to support multiple PHY handles.

...

> +static int k1_pcie_get_phy_handle(struct k1_pcie *k1, struct device_node *node)
> +{
> +	const struct k1_pcie_device_data *data = k1->data;
> +	struct device *dev = k1->pci.dev;
> +	int count;
> +
> +	count = devm_of_phy_bulk_get_all(dev, node, &k1->phys);
> +	if (count < 0)
> +		return count;
> +	if (count == 0 || count > data->max_phy_count)
> +		return -EINVAL;

Elsewhere we distinguish count == 0 with -ENOENT.

> +	k1->phy_count = count;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



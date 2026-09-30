Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B1455186;
	Wed, 30 Sep 2026 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754919; cv=none; b=NxFFsGWYD6OvuDa47w4mWw5TtrbV54I+Wq1WP3zS8L8rdg7nNzA9oD77AC+vSXs+xc7CVCH4j9FI8pJT2WW0TyGcfti9n8boWE2q6cLbJ0001TY9cOj6iMaVhIH7B8qQ7HEMwBEn3k1MIzvHbFtdCksj08TzH36rIiJ7zZjq+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754919; c=relaxed/simple;
	bh=B61XW8XeEOvbO64OXAmt70gDgEVyAKlU4t+7RQokYBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjjbDDARU+B8HraLEzCeCmaSC7f3DpZJtatxtFV3X38T/HpSyIasZcbeEMvdRaA98eqyeNTpGk2S4p4ckKDQQDPPzb+MQAiNF45HqiVIDh0IDduQx+0+N8pcfzephVAzLKoZUWsLyJrrQ1ykcwfRlRNoUiNhzpw4Ed5Wq6En9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YExljP0c; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YExljP0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790754918; x=1822290918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B61XW8XeEOvbO64OXAmt70gDgEVyAKlU4t+7RQokYBA=;
  b=YExljP0cvdidZPHp/BaIl8isV2uEGe9sd8CGK9EGzxU2gwdXo6MEumKz
   LA3JhGNtnTMzujFbEp9C9KtFidIL0SE5ZPN/0W+vQA6s+pcjMpbuj+kVT
   xy8vzhOfx1zzako9i6vny4oQUElOCGDO7H3KoqzwKgU/vNHdUBFOQUHzd
   wNE7/XdbfkHzfl4H2WE2VVtQt0X5a17hc5FUJoTsGvKrTWkXo17xhqTQN
   08hgpDaRYIM8tmwWKKU2RYt/3XmrWaVhjT5TsqZPXmhS/p/YWYN0wcT0O
   hmfXYW9o3v6GAB3LRTBwP8xcrCmQZ1dmfkH156RGETiBzJNzOvccmfpZj
   w==;
X-CSE-ConnectionGUID: xZEzNB88S+i7bLM1S6qGGw==
X-CSE-MsgGUID: Q6MImnWvTxyxq9LCZaJn+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79052469"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="79052469"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:55:17 -0700
X-CSE-ConnectionGUID: qWb3F+3+QfK/XgRyBorc3g==
X-CSE-MsgGUID: gnqi5VzCTu6vqGUSdVV/SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="313558644"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:55:09 -0700
Date: Wed, 30 Sep 2026 10:55:07 +0300
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
Subject: Re: [PATCH v7 1/6] PCI: spacemit-k1: Add device data support
Message-ID: <arzAW7corpPippxP@ashevche-desk.local>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929083755.458238-2-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 04:37:47PM +0800, Inochi Amaoto wrote:
> To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> data to handle the K1 specific logic and make room for the incoming
> logic for K3.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



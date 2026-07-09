Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942153B38AF;
	Thu,  9 Jul 2026 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580957; cv=none; b=mq/A2Rd2rT/+dCApejFGP+SfrAp4JOUAF1pm4N80Zikfb300ZaMgsqy1s5xKM9ieq4lhz9kmnKDUQZUzc0b6N3KpQ0fU8rLD23Myralo9/ZE7PfW+9bLOvcF2r660Wo5x9ZOfsRc9kZmFwX8Hlth8Q5SjjmNjfV0xare7bRcMx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580957; c=relaxed/simple;
	bh=ndtxCX9CLv6e7CFilLh3Nw7lUewzP1cPg9mhsHLos6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHfqBYR2ANv3y9ANFh1DC5PQRnFr5Aq4cczPc7XN9VVSjgykFwtlpo4gI4pG/9Q1abf7QsqXGG1sYquqbEYGvbeQ0DPW8QK698l9KttdoSYpA5YkZ4MKWV7ZBMtavLqorBInl4aLe31Q+XLZYo4WJ2heIhK2QT6XBcgUX94a5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9C2oAwy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9C2oAwy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783580956; x=1815116956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ndtxCX9CLv6e7CFilLh3Nw7lUewzP1cPg9mhsHLos6s=;
  b=V9C2oAwyRLtJQ6hGJwpwF8fCK+fj3o6/xOoT9zTZFc3reJFS0xJVcZ/h
   3+WTygOCImNUzFptbVGEbbBTM3nTlMFBxEvKzm7lpS2P0mKKhcEVY2FHN
   +SkecF4esgffbL9kJAxcZnep6hLKnLqMlie4sW0VoR1PPqyN7hpPbHa/K
   nDUYrMKfJm+FwiZtY7NJSZaJpkIeVWwWhMb6AOAuhKpKA7Qb7sKCWkTty
   iD/btYoun1qHse7S1fbewXi3MJ3nEJ60FU5qSR2M7XxGYkeja7lAi/JCN
   4ebO1PMrlWm36shDQMfTEEQpHhlvk7Ioq2kVXB4sKu/J3YcG8c9tkF7Tg
   g==;
X-CSE-ConnectionGUID: RkTIeEfrTlyg52R15ACkKg==
X-CSE-MsgGUID: HO/Kw6YRSQmDC5+GRCIzPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84131745"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84131745"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 00:09:15 -0700
X-CSE-ConnectionGUID: thvvHjm9R9isY/ob8WDCYQ==
X-CSE-MsgGUID: mXFVt/hNS8acl/ww1Ey7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="277726261"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 00:09:08 -0700
Date: Thu, 9 Jul 2026 10:09:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Frank Li <Frank.Li@nxp.com>, Nam Cao <namcao@linutronix.de>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 1/6] PCI: spacemit-k1: Add device data support
Message-ID: <ak9JEs2Ep5FcAgEp@ashevche-desk.local>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709040027.958400-2-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 12:00:21PM +0800, Inochi Amaoto wrote:
> To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> data to handle the K1 specific logic and make room for the incoming
> logic for K3.

...

>  static const struct of_device_id k1_pcie_of_match_table[] = {
> -	{ .compatible = "spacemit,k1-pcie", },
> +	{ .compatible = "spacemit,k1-pcie", .data = &k1_pcie_device_data},

Missing space before }.

>  	{ }
>  };

-- 
With Best Regards,
Andy Shevchenko



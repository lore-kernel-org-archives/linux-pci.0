Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573947;
	b=vQWTT77sd0hMrn4sFkPfMKhM2RFKwqpgZ0Q3dPn5ZGO2FZlm86Tv0TudJUsdDmLA0uK0
	 h9fjn1Bf/LDF8CXOna5dRo3CJaH32FsyZQ2koNBEdUVOKgDLx3DnkSZj92Tu/5rTR4ekY
	 h3rAdoZYHXINOf6F/IIkJPGvV/iLnmGpCiXE6BR5KteBIEiPuBUE/NF2izW94ZmjGfo5s
	 N6U44Z/sF/ru8wiWBMA9yjOEfB2W15mPuiEqVYNcrFbPXHutmw/AttDKrVavtFfhsUFhW
	 X+992ofWFqAwRFC7s4VTMeZIjI2JbmJMZdgcHHEux63kVSNDKUUhxVup9Pcg0U+HpJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573947;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=q5o4c9Se3qqfB0CkHzs+jJJ9WgHiDHng2N6iX71Z4eM=;
	b=uaHXc/jUCuZoK38w/m3pcmkKF9hhAkyeZeGF6Oojr9KJUbbM9JxCkXGdSDQV8cKoO002
	 oJ8mf++8uRPZz1rXg7Pqs3ZIB2qQqGxc9en85jtIdWA4o8CHg5TvFq1VdIhnGn/3vxsl1
	 G88NMCGNYxDnDTGIgv3fdAf8pYVt69p0TbHHVympfezZYchU1eC15L7QfKaCOWGBB5UMu
	 OqNNjmXAhYgk1BtN+R8azsYQfKCxpxDYSHCC8gS00+eyAN0Hc9Or1wYcVoiMvLuikUp+i
	 KpKtR14tBdPB72PlFvfk2T28QllBGIdyDhwXazyCjaYafnSS4hRQcSx9ipuY3a58KLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZsUeF8C7;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43376606A319;
	Wed, 21 Oct 2026 09:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43376606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZsUeF8C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792573947; x=1824109947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=smbmGXOgf53sUhVEG5nOCbt/F7K1bGkWUk3QHVbfxqM=;
  b=ZsUeF8C7j17c55lCl8Kmi9Psgdg02yx3YrXxX1oDTne8InTbVSZw/ZN/
   nchTLGzdAOTYNyQnrt/JqBk5AEkBQDLTflgrdGilqpspxhVZlRgotNIcN
   OMprz7i5cbB5a7G5HNZGJ8FcLRRjBSAAniq8SZd6iGBKchhfOEbHbWjDg
   bKbJKUOuQ/rnfqv7ydbyh0QmYedTUlSwsXCa+x5CrxnGYhofkCEtrjRaA
   wqKdXeyNxRHgXVmkay/peTYs8TSf2ktDwKhAYLyz6kMw/KRMR1RedQHbc
   jWiL3XvpPIxK8jwwc7HQnsgI3cNYBPOPfB+rF1CWmbInnnWMhfFIn2CUy
   g==;
X-CSE-ConnectionGUID: TpFyxcXUTwm2H/49uhkJLQ==
X-CSE-MsgGUID: m6QN9GLaQKSXm7kglyQKLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1286661"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1286661"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:12:26 -0700
X-CSE-ConnectionGUID: zBKMWarpT7ayhJrrRQriow==
X-CSE-MsgGUID: 1W7CIl06TNCcqn7kFEwRNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3059375"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:12:18 -0700
Date: Wed, 21 Oct 2026 12:12:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
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
Message-ID: <atiB7-u5bxJbf-1q@ashevche-desk.local>
References: <20260929083755.458238-2-inochiama@gmail.com>
 <20261019164108.GA2177470@bhelgaas>
 <athuYJjPMkrecGm3@inochi.infowork>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <athuYJjPMkrecGm3@inochi.infowork>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 03:51:20PM +0800, Inochi Amaoto wrote:
> On Mon, Oct 19, 2026 at 11:41:08AM -0500, Bjorn Helgaas wrote:
> > On Tue, Sep 29, 2026 at 04:37:47PM +0800, Inochi Amaoto wrote:

...

> > > +struct k1_pcie_device_data {
> > > +	const struct dw_pcie_host_ops *host_ops;
> > > +	const struct dw_pcie_ops *ops;
> > > +	int (*parse_port)(struct k1_pcie *k1);
> > > +};
> > 
> > Does the "const" here add anything useful?  This patch suggests maybe
> > not:
> > 
> >   https://lore.kernel.org/all/20260911233541.1650895-2-james.quinlan@broadcom.com/
> 
> I am not sure whether the compiler can make use it.
> And I have not seen any explaination for why no reason
> for that. It is good to have a clarification.

These const make no sense. First of all, the third one is missing it.
And I have no idea what would be the proper syntax to add a such. But
adding a such make it clear that there no sense to have them. Either
you make the const the whole data type instance on the user level or
don't do it at all.

-- 
With Best Regards,
Andy Shevchenko



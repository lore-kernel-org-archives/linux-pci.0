Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281933;
	b=1Mb92YSvSiPGcsJvgq0W7sS+lbh811onYXV3S8h/WnTr4gxEmzWaGXwvJo7BUnifsGAO
	 N83/wa7AHDpGchz60h6dc9X4p2+OPPyxykEbsVMksdEDqjiQShO1VxQ1pfVGC0feEAjh6
	 D2HhHr+f3uzJde8d12GkoSW/7y9ILg9qmmir/PdbdSRCSVo2zOdPIe1/stehaeeZ8eUzo
	 zO1EYNjoHJlM7tsGvpboXDsqxIftEElgyg6wij0tLTEWcE69fc3dtkOF2Q9XKKY2sf87y
	 nzKScih+S9OqprE2FO2cDXefwBD5cWZVXuubfAbojBQ7SR+BYZL+D/ZpzD6Zkfr9fpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281933;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=fiYy2vTwpLDrlQVF2bfioYkNAY8mLKXanFZid5k6LXM=;
	b=RgNeDXO2CWzqOWBIDgehF2hzJSX/jHzqTv+Y+4EU9HbjvCsZ0n+bHhOWU6wEz4FHs8Uh
	 NhurXmd/OmKq6feGjOW1truMSJbSwI1MTYPYjPcViu9fgBvrKbfQndvonbG/3nMSnANPS
	 eVCJa0cE9rUAqA3DlN4SjldhkxJd6d+FCTVBGQF3TgeNH+Eu6Bix+tlguap+eYZz8VOZC
	 u2IcNTPQfg6QDKCL1HDYqQuoc7QfePIPTp7USkpA9wfdGE67hrH4fxnlKLHAox+P6i0FS
	 IgTg9YssmbAX/He9Uz1OEdn+ipJm0bjw3TPPiDllVreJw/+43uhjgDoVmBx/rhAVOOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="dsSHVz/n";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A7606A31E;
	Thu, 29 Oct 2026 13:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE0A7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dsSHVz/n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793281932; x=1824817932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U94VdwwjFB9jKBOkaYX9zN0PXeIX1J2yl40K0ESXQXc=;
  b=dsSHVz/nUIO49Cto3b+mdvCVSme4XJd+WtK8n0FPCdOtyNTXNRBhC0vU
   /p/LiYD6JJDIQTi1k0ODaJRS1PfXXoX6jR15dJuN03yOGKXQ8C8ArwyBW
   u/Fz4aMf4YpFQRMc71JLVpS7F2TYwzBRP7yfaczPAHUJYIjw3nNdYfDuF
   a9Z0gEO/Xd9FBiIcZOw8KPl+sH5yE8cjRrN+3DrxKcSNighrV1Xp0LGYN
   hCxVuBuIe7MbVFAneD0RjczmM/jMn0xV1zrwIWNUsm1BBG1/Ol4bt0XH9
   0LxzeuN2sK/GI/4OkfQjNaTiINY6QsofBUSrY6fP7AeQWZapji5+z7zC6
   Q==;
X-CSE-ConnectionGUID: mRVEWDs+RK6x2Ea8jvYs5w==
X-CSE-MsgGUID: 4iuenIDUQECD62aM3qgEQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2059148"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2059148"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:52:11 -0700
X-CSE-ConnectionGUID: qmwkKEejSbOwMDbQsEFCDw==
X-CSE-MsgGUID: rQIvHgtORdOxcclt9Xz7iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5286011"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:52:06 -0700
Date: Thu, 29 Oct 2026 15:52:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Alex Elder <elder@riscstar.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jingoo Han <jingoohan1@gmail.com>, Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Randolph Lin <randolph@andestech.com>,
	Rob Herring <robh@kernel.org>, Sherry Sun <sherry.sun@nxp.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: rcar-gen4: Replace pe_rst GPIO PERST with
 GPIO reset aux driver
Message-ID: <auNPg8kAs2_O2_9R@ashevche-desk.local>
References: <20261028172133.20903-1-marek.vasut+renesas@mailbox.org>
 <18b4e960-caa1-48b0-a5aa-f3585274787d@mailbox.org>
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
In-Reply-To: <18b4e960-caa1-48b0-a5aa-f3585274787d@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 06:27:36PM +0100, Marek Vasut wrote:
> On 10/28/26 6:21 PM, Marek Vasut wrote:

[...]

> Bartosz, alternatively, I wonder if there is any way to request the
> reset-gpios as reset controller reset here already. That might be even
> cleaner, but I don't think there is anything like
> devm_reset_control_bulk_get_optional_exclusive_and_also_request_the_gpio_reset()
> or devm_reset_control_get_optional_exclusive_gpio_reset() . Maybe something
> like that could be added to the reset subsystem instead ?

It's already there, if I'm not mistaken, one describes reset-gpios in DT,
and reset-gpio driver takes care of this.

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B4395266;
	Thu,  9 Jul 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581688; cv=none; b=ktNATJRsSRubtyf9kUxqY+03kDUk6kllBJvSwPngBlTxl+XGxN1gVQRLmhkIdvFr73hQYxfHH39iVpxmnOD6a0TGx1HRpXebMnOkOxJI2h9gzGGJyi5pTlJELd6nzQONPIZ+XV3d90UafOOogNPINsA6ciBOpAybNC3EI7evQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581688; c=relaxed/simple;
	bh=5H4IhXLZzOH5Ha9ASFgpDI9HdBv56YUDrwZoMEH/IOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAcceC6sVoAlaKAu4/ZIgTKWKLev7CaZ+yFYMKYhNegu+8jZJjDCH/JjpfYU43pstUeQrdLQK4Xk2MDeEkD6W1sZ3b1QVOwTua9RcUhpvXiLND3EXE5yqDe3McS6o2n5X32j/5+cmxpf7WYULCgfVyZWRkGyhu96SHIPOxZPeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0GL9i25; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0GL9i25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783581687; x=1815117687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5H4IhXLZzOH5Ha9ASFgpDI9HdBv56YUDrwZoMEH/IOo=;
  b=A0GL9i25BCWVRckwgiNOcmczs2lNpnn+CHo/7SnOLHpZN35wV3QFpk9U
   TqA5cPoQ6NJeyZXiGwkRiXfuLCzDt2v5ewb4vpLGx0ggRqJUJ5rdp9k6I
   iTAtFmSO4qN3HddoI07nAKBUbZou4K8CwF5NJmQPB0nnbkYUhw/59Wb74
   J8O0MtlcZ3Wxu26+5HfgZ+zMcn0QGpdPo6mqrn/UXrsFr7N/bPJhYhWeh
   byTh3S2EjthH3sHh9Tz0ZqatDrvOmqSacAHnr4PTj2Su6SFA/GrzzJD8m
   601JZOmPR3Ogt7vQYtGm6eKDbaaD/hgymj8RbenVK4x92kUr6HLh9OI/+
   g==;
X-CSE-ConnectionGUID: CiFzn1CCQ1uvOLaikcSHDQ==
X-CSE-MsgGUID: eoJeBEZ/S/2kErAvmk/weg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84367188"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84367188"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 00:21:26 -0700
X-CSE-ConnectionGUID: q4RcSDcZRd2GSX+oXmPy3g==
X-CSE-MsgGUID: w8q0zeu0RTKucseODByeZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259412572"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 00:21:20 -0700
Date: Thu, 9 Jul 2026 10:21:18 +0300
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
Subject: Re: [PATCH v4 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <ak9L7k-_aivk1_Uu@ashevche-desk.local>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-7-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709040027.958400-7-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 12:00:26PM +0800, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 is almost a standard Synopsys
> DesignWare PCIe IP with extra link and reset control. Unlike
> the PCIe controller on K1, this controller supports external MSI
> interrupt controller and can use multiple PHYs at the same time.
> 
> Add driver to support PCIe controller on Spacemit K3 PCIe.

...

> +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT);
> +	usleep_range(1000, 2000);

fsleep(1 * USEC_PER_MSEC)

> +	regmap_clear_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC, PCIE_PERSTN_OUT);
> +
> +	msleep(PCIE_T_PVPERL_MS);

If PCIE_T_PVPERL_MS is too small, msleep() maybe not a good choice,
perhaps

fsleep(PCIE_T_PVPERL_MS * USEC_PER_MSEC)

...

> +	val = u32_replace_bits(val, BIT(7),
> +			       GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);

It's perfectly a single line.

...

>  static const struct of_device_id k1_pcie_of_match_table[] = {
>  	{ .compatible = "spacemit,k1-pcie", .data = &k1_pcie_device_data},
> +	{ .compatible = "spacemit,k3-pcie", .data = &k3_pcie_device_data},

Missed space.

>  	{ }
>  };

I don't see (and haven't checked) the context, do you have
MODULE_DEVICE_TABLE() for this?

-- 
With Best Regards,
Andy Shevchenko



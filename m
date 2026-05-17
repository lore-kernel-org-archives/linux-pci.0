Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D63C241695;
	Sun, 17 May 2026 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779005271; cv=none; b=VGPcmd1T8lZJDKREkHFvUHpHIANCdhflUCVvC0A55/b2GwWU48R3aZVI0gZ8JhJWx8vU3p3oyhFkE4YWDS6JKThbr6H7n6hnvBEGoM1V1mYvuakDgIbEc9KoB4dQ+WAHqPqBG2AeSU3NTPj+dO0CeJ9jISmPKALE04oOxzety84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779005271; c=relaxed/simple;
	bh=q4n6M7y1hdiajGaA5S3Dv718bzU2NlS/k4sv46Jo9PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1C/6J9KKnZUW9bhasSz81bKDfHIWYsG5JKYARGSu/2YmsQnjP6qTEHYRcNkX7DQCdq9SDDh7Z8Pv+GI5SujlXP5zKOWpXo1s+582wX5BWwER37Z+8O87uT7DjBKO8s27Fcw3SN4/J2fPWm8YQWwIfcziKCRJ4G+Q+jFXcjhVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=juFrhcRZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="juFrhcRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779005270; x=1810541270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q4n6M7y1hdiajGaA5S3Dv718bzU2NlS/k4sv46Jo9PE=;
  b=juFrhcRZ2QFp07fyRbxAnjayL6J4g81wFcLpF1CuLbAd8NTVW4vtFVTg
   DmdHM41MiVblm3bxylGxMVkTJrnX7Zjp+lyDhteKzW7nb0SyJaTv6KFFZ
   FKKWml49ce8a5BDedL+GN1bFxU7JUwchCU8Uce4Q3HjxXciOKCU+eQe17
   pn91Qr5b5k81vzeG4ArkPP+sVN8+DmO9VgIvWjV4DPPVeel3v4VWwPC1R
   2VJ7hCvGMPY9N8efXCLMG/sQXPs9kH6tF7qeeOVW91ltY6nzdVJsP+F/Y
   CiRimfrOoBbbskvMYHhtalDMyegrF61MOungDUTaiI8Rb6MqcNBxp/w0M
   A==;
X-CSE-ConnectionGUID: G4EiOwl2QQKmHDfML/XewQ==
X-CSE-MsgGUID: EnDJgfURQU6k9WH+XXD4vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90996057"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="90996057"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:07:49 -0700
X-CSE-ConnectionGUID: M99lICK9TzyYIdfFvW7whw==
X-CSE-MsgGUID: jCiv8IbFQ96OYGlLHmFF1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="232735120"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:07:42 -0700
Date: Sun, 17 May 2026 11:07:40 +0300
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
	Vincent Guittot <vincent.guittot@linaro.org>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Alex Elder <elder@riscstar.com>, Nam Cao <namcao@linutronix.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Randolph Lin <randolph@andestech.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 2/5] PCI: spacemit-k1: Add multiple PHY handles support
Message-ID: <agl3TJrvJMtEpHyl@ashevche-desk.local>
References: <20260517014841.254085-1-inochiama@gmail.com>
 <20260517014841.254085-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517014841.254085-3-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 17, 2026 at 09:48:37AM +0800, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 may use multiple PHYs at the
> same time. The feature is not support by the current driver.
> So extend the PHY definition to support multiple PHY handles.

...

> +	k1->phy = devm_kmalloc_array(dev, 1, sizeof(*k1->phy), GFP_KERNEL);

Hmm... What's the point in having _array(1) ? devm_kmalloc() should suffice.

> +	if (!k1->phy)
> +		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



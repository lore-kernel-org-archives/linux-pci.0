Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72668361670;
	Sun,  5 Jul 2026 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783244240; cv=none; b=CRzvPjanQUiaP7LSsQrQfgHGvsGaidw5CC2jy2TLfBg7sBEZS5Uji88Mlu8oat5gwkfg9gBalFDf+jnAdBEgnug7utOqKTIWfeVsDhB9XcDzz8cxEaf93w6QySMiOw0mhP92ogt9EC7tlm937j8f3BMzR7m8R3HO3P7GcNiaTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783244240; c=relaxed/simple;
	bh=1RylhY6p6z6d4hpWcnWtvZcE7VKddLBvtLB7pxpDMvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsNxYHLNNuAK5TMScl3UkDHEganljYKQQ0Nx5FZuu6+z7Az/B4hChqCHQxNdW7wfzasIVMC0LsXlT7wcK8OiHnv47/NJf4toTcjOdmbolg0gT3rp1ry0R4EUEwD4UiJcriih+l4GAdGda8NYbxGPvb3dvOJb3706oRj6GrT4cCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmXltLFH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmXltLFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D819A1F000E9;
	Sun,  5 Jul 2026 09:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783244239;
	bh=OMATudwiezEO78XYuEQmPCbDsJhZp6+LpEDgDoEb6vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HmXltLFHrI/qpw4LNwl/aaSXFFQpk5KB3sfHpPGVQMn51Fkvtrf9WW0r2YxbP5z6c
	 chMtlhxCPbfoevKv54icziilQKdUhBBBY5sEaJxjmBRm+9cSGkRjqlZ0P+lrFSRu2d
	 erilJLv/Stfkdl3dYERyfACZtBmmJ0wp/DMge9cYI/UapBeD38QtZMgQ+mAxzfbMgB
	 JhzyeiRj8YtI72iHI3pP419nrAfLUcYgpqWA37+X2pTf0a34xq2kT0NEZqZqZFmGMo
	 Y06iF/j7kVYZll6fU7FUhpfTuRIdg64JYo2FFwGvXr1YHlezEkV0YIRTGaNKCZWJWr
	 0D4dVrtEEBSIA==
Date: Sun, 5 Jul 2026 11:37:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Bruel <christian.bruel@foss.st.com>, 
	Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Xincheng Zhang <zhangxincheng@ultrarisc.com>, Alex Elder <elder@riscstar.com>, 
	Randolph Lin <randolph@andestech.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit K3
 PCIe host controller
Message-ID: <20260705-versed-leech-of-glory-db5cfc@quoll>
References: <20260703020003.485436-1-inochiama@gmail.com>
 <20260703020003.485436-6-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703020003.485436-6-inochiama@gmail.com>

On Fri, Jul 03, 2026 at 10:00:01AM +0800, Inochi Amaoto wrote:
>  required:
>    - clocks
>    - clock-names
>    - resets
>    - reset-names
> -  - interrupts
> -  - interrupt-names

Why?

>    - spacemit,apmu
>  

Best regards,
Krzysztof


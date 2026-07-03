Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938E12B94;
	Fri,  3 Jul 2026 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098976; cv=none; b=rZIXBR8b2Su/Yea9Qe4OrsLo2GgCqgEhNuBXvNWqGWYc4TXCpKZb83sRkftU6v8nkfyavmhPkub4bdCoxJni23Ezlisol+3KiySf9bGNy3cUWM95IwMnTzt6B3c11v/8D8oAbaLUFWCgRzVl185oqimhOFZi+VVYOOJsDwVPDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098976; c=relaxed/simple;
	bh=Aisfcbh/44/KKLhN9ZwUoxlfYJncZf/ootV1BLAgoRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0iIdkgkDNGpLtrxvKEwZucP2D5+sEdaV6tkyCfZqgK+K84oaEZZfMuy71mCbh+ftZ2L77JVsEZJwF89x13dCQbgz7NMylk8eK1ZuMlfc3HlT1GkNLzRRwpz1L1mTbqw726LK8ELZhI+FabRDvxDoN3Dl8wDLjjmVSPmnx1HhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=K998PyfI; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="K998PyfI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=cLSKMctPdQKy5wsj9y1nB9/36ncfBFcUYoRxf9bQipI=; b=K998PyfIpWOrOmSAvJh3nisrSZ
	LxHTwDQ0gZVhL3JFE07mIK2DPtN7e1gzoGK3M35DUURvhZEDm1PPJMbpL68IzJmWL2wVicQ1BE7Ar
	jWiF8ojeEOFaxs9kW20TnXMQWUOF6TWOgaG/Arhmfi00SNMMr0yGjUhylqY9YsTQfWFQAK7Yp68LW
	W/3yejE9iSLMwoeUivBwC+Pwkl8eC9icN4DJgCxKI/RqG7ueItf/qxmHQq13lZaOJ37JRvAR1S7Jq
	2mYqTEX2h4mU7TbWBaeO6kPNfPOFF+nYynCutDVg4FZA3GiuNm7L+Z9Jx1brlrGEub+vURKEgTJja
	7yqwnJgA==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1wfhUb-000000008iE-0Ehv;
	Fri, 03 Jul 2026 19:15:57 +0200
Date: Fri, 3 Jul 2026 19:15:56 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
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
	Frank Li <Frank.Li@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 0/6] riscv: spacemit: Add PCIe RC controller support
 for K3
Message-ID: <akfuTKD7fp10K2C-@aurel32.net>
Mail-Followup-To: Inochi Amaoto <inochiama@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
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
	Frank Li <Frank.Li@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703020003.485436-1-inochiama@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2026-07-03 09:59, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 is almost a standard Synopsys
> Designware PCIe IP with extra control and external MSI controller
> (IMSIC).
> 
> Add binding and driver support for PCIe RC controller support on K3.
> 
> Changed from v2:
> - https://lore.kernel.org/linux-pci/20260517014841.254085-1-inochiama@gmail.com/
> patch 2:
> 1. Use unify PCIe phy get/enable/exit function for both K1 and K3.
> patch 3:
> 1. New patch for updating device id for both K1/K3
> patch 5:
> 1. Reuse binding for spacemit,k1-pcie-host
> patch 6:
> 1. Multiple cleanup for the logic already generalized in the previous
>    patches.
> 2. Use generic description for the Kconfig entry.
> 
> Changed from v1:
> patch 1:
> 1. Remove post_init callback.
> patch 2:
> 1. Fix devm_kmalloc_array arguments order and error check.
> patch 3:
> 1. Apply Rob's tag.
> 2. Change check from oneOf to anyOf.
> 3. Fix spelling mistakes in commit message.
> patch 4:
> 1. Add comment about PHY handle.
> 2. Remove interrupt "app".
> 3. Fix spelling mistakes in commit message.
> patch 5:
> 1. Remove all logic related to link up interrupt.
> 2. Clean up all unused macros.
> 3. Fix devm_kmalloc_array arguments order and error check.
> 4. Remove unnecessary start_link logic.
> 5. Make all magic number as a macro.
> 6. Fix spelling mistakes in code and commit message.
> 
> Inochi Amaoto (6):
>   PCI: spacemit-k1: Add device data support
>   PCI: spacemit-k1: Add multiple PHY handles support
>   PCI: spacemit-k1: Add device id update helper
>   dt-bindings: PCI: snps,dw-pcie: Add msi-parent for MSI handle check
>   dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller
>   PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support
> 
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   7 +-
>  .../bindings/pci/spacemit,k1-pcie-host.yaml   |  46 +++-
>  drivers/pci/controller/dwc/Kconfig            |   4 +-
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 237 ++++++++++++++++--
>  4 files changed, 267 insertions(+), 27 deletions(-)
> 

For patches 1, 2, 3 and 6:

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

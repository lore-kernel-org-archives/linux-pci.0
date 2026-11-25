Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.154.119.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630691;
	b=eeHG8xlsV2YPU1M0SmWBu6fPzWUQ6ETlDtgHl0QIBX3GrVMWmjytlZP1gNOpcfgl4AuO
	 hR2qwa0ltqFxzTEj/DTuJRXeKU+BR1fHh0Et224gjqewIizoWVpzi5TnDRgEEsJzi+qP2
	 kQ8GCAlpT3CGuFteFiiVO1Ym7TCD6l/ozGWG3GeBgFL5qhEgBDGl1/Y0UIOVnKC2Ygjwt
	 atnRUGaejw21mZPP+5hdpRemWwbzktkE6tVfKn3ArLt1JLboQRUTBTfQmVu4wYehWrYm2
	 gmgnsfvFUGAdFil/BCWbMVPpmdOP0s19yHq60m/Z159gIZBhtjPIjPkpdlkOwXBZjlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630691;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=e9zrcR4+b/kS9Qb1mwVlZGZVo3jDZ/rmDsPjIuq74Z8=;
	b=ddZrEbqEjxU0Ao5BEB13fUxahsPB0S68hIzZK6A/r3+Bs2xWNTsE4/UjMRddGJJeh9Pp
	 RfpVcIzuSZ3xyiEzeVU7R6gLHJFlpO/Ix2y56GXkUnwoCqlm2rQTQx6z1FvBHjRKjvYYC
	 4i6jRrXThNj0qEIWfxE04SdzIvuyM16wY3W35A0nuDhQrGLnQ2nHt+a2R7hiXQAUFepQe
	 h1ESwsCo7vv95+Kzm5XgITB9003UPENsul1rho3VDhLnWxgP1rrU7PuinpLo5IIQ8ncgC
	 tZvYISGBxSWji3iUX8wyvuhsmM0s39ARSJ1f9E9/CUv1xSoqszhk/KnBbE0+t6/cReA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aurel32.net;
	spf=pass smtp.mailfrom=aurel32.net;
	dkim=pass header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b="kG/VHBsd";
	arc=none smtp.remote-ip=195.154.119.183
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168B606A323;
	Wed, 25 Nov 2026 18:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F168B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=kG/VHBsd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=e9zrcR4+b/kS9Qb1mwVlZGZVo3jDZ/rmDsPjIuq74Z8=; b=kG/VHBsddVEJx97y/LwWQW7+aT
	SPi2PSd0iwDBudf5aAqJGC5uARR+wieLNmdzaVcmVtiHB91IwYHHeZMVwanKqbctsyFwES3MqDrj5
	c/GJedWJRnkyhG23qW54+Aap5eXLrDO3Rg3EFuaUGrite6fBoTvwq9FehSfrKRayCg9gsQJwzRZQS
	zbUZglKHVn1hheZvQoG+5Th5ngdZuWd6kMGA9X+fYlYOmYxckUvSFrzh9wjC+VOyVNmR5iKkOl24v
	NDDWoPTX3MVWun8wOdTYuwYIVIqK7V1FNrllVYH7vNuAUkrHfIXUu9k+ePEhbRh1aB+Z5K74GPLxq
	ebdxqljg==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xWHYm-0000000ADku-0F4E;
	Wed, 25 Nov 2026 19:17:36 +0100
Date: Wed, 25 Nov 2026 19:17:35 +0100
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
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	Niklas Cassel <cassel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Alex Elder <elder@riscstar.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v8 0/6] riscv: spacemit: Add PCIe RC controller support
 for K3
Message-ID: <awcmP-iHD-E8eZRT@aurel32.net>
Mail-Followup-To: Inochi Amaoto <inochiama@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	Niklas Cassel <cassel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Alex Elder <elder@riscstar.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20261125041523.242588-1-inochiama@gmail.com>
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
In-Reply-To: <20261125041523.242588-1-inochiama@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

Hi Inochi,

On 2026-11-25 12:15, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 is almost a standard Synopsys
> Designware PCIe IP with extra control and external MSI controller
> (IMSIC).
> 
> Add binding and driver support for PCIe RC controller support on K3.
> 
> Since v5, multiple vendor fix are included in this series, you can find
> in [1]. And this version required [2] for phy bulk data support.
> 
> [1] https://github.com/spacemit-com/linux-6.18/commits/k3-br-v1.0.y/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> [2] https://lore.kernel.org/linux-phy/20260923023304.78428-1-inochiama@gmail.com/
> 
> Changed from v7:
> - https://lore.kernel.org/linux-pci/20260929083755.458238-1-inochiama@gmail.com/
> 1. rebased to v7.4-rc1
> 2. Apply Andy, Rob, Aurelien's tags to related patches.
> patch 1:
> 1. The const declaration is reserved, as the it hold the pointer of the
>    static const data.
> patch 6:
> 1. Add comment to the PCIe topology description to the commit message.
> 2. Fix some 80 chars line problem.
> 
> Changed from v6:
> - https://lore.kernel.org/linux-pci/20260923015016.64069-1-inochiama@gmail.com/
> patch 6:
> 1. Keep PERST# when init failed like the deinit.
> 
> Changed from v5:
> - https://lore.kernel.org/linux-pci/20260907112606.465778-1-inochiama@gmail.com/
> patch 1:
> 1. Return ENODATA for no device data found.
> patch 2:
> 1. Add power_on/power_off suggested in [2].
> 2. Add zero phy check in the driver.
> patch 5:
> 1. Add K3 device description.
> patch 6:
> 1. Update comments.
> 
> Changed from v4:
> - https://lore.kernel.org/linux-pci/20260709040027.958400-1-inochiama@gmail.com/
> patch 1:
> 1. fix comments
> patch 2:
> 1. Use phy bulk data to simplify the code
> patch 3:
> 1. Rebased to latest master
> patch 6:
> 1. Apply several fix from the vendor code
> 2. Use separated init/deinit function for K3.
> 3. Add some error handle for K3 init function
> 
> Changed from v3:
> - https://lore.kernel.org/linux-pci/20260703020003.485436-1-inochiama@gmail.com/
> patch 5:
> 1. Add missing interrupt/interrupt-names check for K1
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
>  .../bindings/pci/spacemit,k1-pcie-host.yaml   |  55 +++-
>  drivers/pci/controller/dwc/Kconfig            |   4 +-
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 235 ++++++++++++++++--
>  4 files changed, 268 insertions(+), 33 deletions(-)
> 
> --
> 2.56.1

Thanks for this new version. I have tested it with the v5 of the "phy: 
core: Add phy bulk helpers support" patchset. It works all fine.

Therefore for patches 1, 2, 3 and 6:

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

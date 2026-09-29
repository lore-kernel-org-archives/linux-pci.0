Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC53468C13;
	Tue, 29 Sep 2026 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701305; cv=none; b=qlnpAV/AdKe0R+k/gLeHJYpwgkG80CrtYE2ynjSGkpXRpWO1MX5jbDL7cY5wr1HH8XZwUNhUfE8Zam7fb2p5cNMROREh4MirZdhQCQ8kIW7Jw57WAJWmu8D6x5DOdw4sTKptmBIxD6s4TLeuJjveXakMMd2quHcW8HGhzbOFYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701305; c=relaxed/simple;
	bh=AfBEMVmyTpRdR2g6jgEzF3TCI4T6leeIkDBrd28vK2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwpuryUZa4j3ohyIHK+Hk41Ib6rsCOQUFXhovYLAJRZM05anA1wf0e0I95M+qTbDtEd/U5goV2rFVxTXuajfsg2V4DfTS4mMZONo9kgUFp+8+2u19wN9pCn1REFazROzadJpr82m3k9ISaMVPULX87ngC+k3NHBHjRLIJ6Bh57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=0BpbijLy; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="0BpbijLy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=7xE0E0ndrr7YByn7ye5GJZRRPPDTwp49LLUupyjojAA=; b=0BpbijLyKgTmLntAjV2uQmlz8L
	a9bB0e4fcKHLtpWduH8mvw27UgdGm5QLZauBk566fYJE7b/VxtRcwcXdp2IgAtG5jqjGTuWY+SRat
	QCbKnRujVA/B4YmxmfIite19nSY/u7x6rrlFPgQpIrrYi93kH57IblEpRDHD17q2aMFtS5QC3Jds3
	SwxSTHqnEa8gXsLpX8LE2Pyruf/cUp8G5FsOwnVcYLLv5tiWW17BKgm1GH4HQcjkimWBMBJpFY9K/
	XTU1bMMAl16tOHcS5BNGgBWUdn0yXVQD1mUH3hNkEY/khxNosAlp8BV2Q+Fx8uFIYViOD1oggNaXA
	iclzn5nQ==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xBbCN-0000000GLbs-2LrY;
	Tue, 29 Sep 2026 19:00:59 +0200
Date: Tue, 29 Sep 2026 19:00:58 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczyyyski <kwilczynski@kernel.org>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	"Uwe Kleine-KKKnig (The Capable Hub)" <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v7 0/6] riscv: spacemit: Add PCIe RC controller support
 for K3
Message-ID: <arvuyt6eD0bwTb9c@aurel32.net>
Mail-Followup-To: Inochi Amaoto <inochiama@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczyyyski <kwilczynski@kernel.org>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	"Uwe Kleine-KKKnig (The Capable Hub)" <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929083755.458238-1-inochiama@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

Hi,

On 2026-09-29 16:37, Inochi Amaoto wrote:
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
> [2] https://lore.kernel.org/linux-phy/20260904083709.425893-1-inochiama@gmail.com/
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
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 237 ++++++++++++++++--
>  4 files changed, 270 insertions(+), 33 deletions(-)

Thanks for this new version. Patches 1, 2, 3, 6 are:

Tested-by: Aurelien Jarno <aurelien@aurel32.net

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

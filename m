Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632845;
	b=sdxoA12aCWp2G1oOGV42yAsJehawnBApmuXt4/yOcNOcDUnL8WefZ+4hiRgvsYhJIrNv
	 cTOrlWzfGfDxfDS0ZtlqElu/wBA+nq+8TBCt8A+oKo+JM2bzBdT+3YtcwW/ScIC7jVL3H
	 jIdP7JTuvRBSBO502J9YxPU46scAXJQXKQrbr+XS7HoMYTi0Hwu2673tCQ2FGiRkxySrH
	 um+GGNp5nvKnKPZX7Nx19jOw9phUV52r/cUstp4kLcCQhOwYog6KFlPB+9dUIMdG6B+0i
	 Yv7eQ/46iSLYoXMaX4ESMTig+4R2I9nER0LjWqDWdPbYmTS6OvovkgKAC5HpW/YdsMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632845;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/xOLEWd4CVZtheZ0aeUPwLLg+DYfGKXSOQaolIBDtBY=;
	b=RX04JwxjD/FTwnha99RwG07qp6mT9Zw9lkcpLtYuaRtjll9ybG/jiFwwNHvFR/2aa2TZ
	 +fGe7A7ydldRncOzPvMs5Ex49OCP4U0mMPJYx5bD8aM82gF8hN7h5t0SBg9Ky4Ny07oT2
	 1KYIPSugjsbZ4GCh8iNK5eHccmFHkPdMt3uvffZFNvl2wYDisDtZ4PxSmK31fN96SyKVH
	 m/zTHRy5ouoh9BUL4ohBgdiuK1nA6lk+w1Ho3BHBILXEmcLRmE6xzMeANlEIHSDjdO2Hv
	 04ameylHqwTaCPrGcp9+WUVv55Eg9PosPsHXJN6ywgGQqAd3V3L3mtJmEqZ/9Oh/a+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDhz1eGY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BC607F10B;
	Mon,  2 Nov 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDhz1eGY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8646F1F00A17;
	Mon,  2 Nov 2026 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632845;
	bh=/xOLEWd4CVZtheZ0aeUPwLLg+DYfGKXSOQaolIBDtBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HDhz1eGYAbkOSwXaqmB0Apa2Ta1tDfDIh1exfQ1WYiqbowaXTZdsECLK5nUiOjyGa
	 YmLYcXi8jdqvM+HldTm0DGSHvaMhfj7imNFbazByGaOZ1Vg4Wa9eBljdeROA010/ND
	 gNXU8EPwPWMAWSzLGBgDUMvAF/6p+9V2k7ELiml5KN0H4Ut80uvFJtVJFlJmChCUtA
	 SrEKPxRVUV4SKlMtgIX4erNRVc4fZ9nZheMm5IGBliLdDygM+KQjhntZlP9koTxgvi
	 zYxbbMrboW4LqKtoh+KMylSI28HXjbDXXxEKQktGRc/NS+AVZ62ZI2Ooialjb5zbS/
	 nbrxO79Rk9aKw==
Date: Mon, 2 Nov 2026 16:20:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, vidyas@nvidia.com,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 4/4] PCI: tegra194: Add PCI_ENDPOINT dependency
Message-ID: <auiqSIKbGilCYxDT@ryzen>
References: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
 <20261102111450.4010818-5-mmaddireddy@nvidia.com>
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
In-Reply-To: <20261102111450.4010818-5-mmaddireddy@nvidia.com>

Hello Manikanta,

On Mon, Nov 02, 2026 at 04:44:50PM +0530, Manikanta Maddireddy wrote:
> The PERST# assertion handler now calls pci_epc_linkdown() to notify
> Endpoint functions before powering down the controller. This function
> is only declared when CONFIG_PCI_ENDPOINT is enabled and has no stub
> when endpoint support is disabled.
> 
> Add a PCI_ENDPOINT dependency to ensure that the endpoint framework is
> available whenever the Tegra194 PCIe driver is built.
> 
> Fixes: bf644226574e ("PCI: tegra194: Notify Endpoint functions on PERST# assert")

Where is this SHA1? I can't seem to find it in the PCI tree.


> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610230923.2lf3BsLs-lkp@intel.com/
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V2 -> V3:
> - New patch in v3: require PCI_ENDPOINT for pci_epc_linkdown(), added to
>   the PERST# assertion handler, to be declared when the driver is built.
> 
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 0a0d56fcf0ac..704134684900 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -245,6 +245,7 @@ config PCIE_TEGRA194_HOST
>  	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
>  	depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST
>  	depends on PCI_MSI
> +	depends on PCI_ENDPOINT

This looks wrong to me.

If you look at:
include/linux/pci-epc.h

you can see that there are stubs already for e.g.:
pci_epc_init_notify() and pci_epc_deinit_notify().

$ git grep pci_epc_init_notify
drivers/pci/controller/cadence/pcie-cadence-ep.c:       pci_epc_init_notify(epc);
drivers/pci/controller/dwc/pci-dra7xx.c:        pci_epc_init_notify(ep->epc);
drivers/pci/controller/dwc/pci-imx6.c:  pci_epc_init_notify(ep->epc);
drivers/pci/controller/dwc/pci-keystone.c:              pci_epc_init_notify(pci->ep.epc);
drivers/pci/controller/dwc/pci-layerscape-ep.c: pci_epc_init_notify(pci->ep.epc);
drivers/pci/controller/dwc/pcie-artpec6.c:              pci_epc_init_notify(pci->ep.epc);
drivers/pci/controller/dwc/pcie-designware-plat.c:              pci_epc_init_notify(pci->ep.epc);
drivers/pci/controller/dwc/pcie-dw-rockchip.c:  pci_epc_init_notify(rockchip->pci.ep.epc);
drivers/pci/controller/dwc/pcie-keembay.c:              pci_epc_init_notify(pci->ep.epc);
drivers/pci/controller/dwc/pcie-qcom-ep.c:      pci_epc_init_notify(pcie_ep->pci.ep.epc);
drivers/pci/controller/dwc/pcie-rcar-gen4.c:    pci_epc_init_notify(ep->epc);
drivers/pci/controller/dwc/pcie-stm32-ep.c:     pci_epc_init_notify(ep->epc);
drivers/pci/controller/dwc/pcie-tegra194.c:     pci_epc_init_notify(ep->epc);
drivers/pci/controller/dwc/pcie-uniphier-ep.c:  pci_epc_init_notify(priv->pci.ep.epc);
drivers/pci/controller/pcie-rcar-ep.c:  pci_epc_init_notify(epc);
drivers/pci/controller/pcie-rockchip-ep.c:      pci_epc_init_notify(epc);
drivers/pci/endpoint/pci-epc-core.c: * pci_epc_init_notify() - Notify the EPF device that EPC device initialization
drivers/pci/endpoint/pci-epc-core.c:void pci_epc_init_notify(struct pci_epc *epc)
drivers/pci/endpoint/pci-epc-core.c:EXPORT_SYMBOL_GPL(pci_epc_init_notify);
include/linux/pci-epc.h:void pci_epc_init_notify(struct pci_epc *epc);
include/linux/pci-epc.h:static inline void pci_epc_init_notify(struct pci_epc *epc)

I suggest that you just add a stub for pci_epc_linkdown().


Kind regards,
Niklas

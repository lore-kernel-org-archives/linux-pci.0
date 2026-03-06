Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C9481648;
	Fri,  6 Mar 2026 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830794; cv=none; b=tnT9JAq/wUB8fJDQ6O1smN/rl40/kN7gb/9j8sJ4cEg+JGI5lzwMqlpcxjmLvzCPM/M3+XnWY/egadC+D5pcJkfqIh33pEMfkHgY5jT8+iI4MnOmgcXEqjEVLA6O2iFw/Wje33eLaOPE00C9czD8yE5qh4VD+Lc2wHs/53E2QHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830794; c=relaxed/simple;
	bh=Bq4X/Z3TJrxt2G2mbMX3VK6tRvEa3RXXyY5lvh+/N/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bcqszDSAIcMJXqwNMtCJeUFzQ1EPhCipZ8W2shLiNpzYt2ODOJQdsmjh/gmLmD3XBO16VyxOq6ryJCRsRtLS/EYe15a2zzPqzfp3367vbp1dL7XOFpuovJZLfwbNNAXUY/GbvxJ88sRfB2xBijmwLzpjERkOz0vOmW2Pwb4cQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCBohL7e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCBohL7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2586C19425;
	Fri,  6 Mar 2026 20:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772830794;
	bh=Bq4X/Z3TJrxt2G2mbMX3VK6tRvEa3RXXyY5lvh+/N/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BCBohL7eEeq4G4ELgsOBv2CSecc8hIpcIylQhqjCOVxb9FpsLjcKumtRd3kXmmfy/
	 QROayIowYG8tRF3Tl1n21txawVDXaq7QzWktmd6rs659djTSBqbOPn2q5JiwvDwL+q
	 Myl4qSkyVwOM9gXNht8AcZ8Aj1n2ShYlLZG1vSNp0vUeTsQgGDZWBz9YAD2mfRaRa/
	 Fw52rRsxzR43nFyrptTVIi8nuFaPgvUVxRrVi8wLLmdhREgof1vdkyJwQl6v4AccOk
	 7L9zIxStjrajuec/AGe+Vs4k+hQu1Qcq16qMrSC0OulMJIOxsIlftKPQG2tIiY1/C8
	 GRgmFyqLWvXYw==
Date: Fri, 6 Mar 2026 14:59:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Message-ID: <20260306205952.GA180227@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302053109.1117091-6-wenst@chromium.org>

On Mon, Mar 02, 2026 at 01:31:05PM +0800, Chen-Yu Tsai wrote:
> With the new PCI pwrctrl API and PCI slot binding and power drivers, we
> now have a way to describe and power up WiFi/BT adapters connected
> through a PCIe or M.2 slot, or exploded onto the mainboard itself.
> 
> Integrate the PCI pwrctrl API into the PCIe driver, so that power is
> properly enabled before PCIe link training is done, allowing the
> card to successfully be detected.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2
> - Added "select PCI_PWRCTRL_SLOT" to Kconfig to fix kernel test robot
>   compilation error
> 
> I'm wondering why the two existing uses select PCI_PWRCTRL_SLOT and not
> PCI_PWRCTRL though.
> ---
>  drivers/pci/controller/Kconfig              |  1 +
>  drivers/pci/controller/pcie-mediatek-gen3.c | 38 ++++++++++++++++-----
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 5aaed8ac6e44..e72ac6934379 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -222,6 +222,7 @@ config PCIE_MEDIATEK_GEN3
>  	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
>  	depends on PCI_MSI
>  	select IRQ_MSI_LIB
> +	select PCI_PWRCTRL_SLOT
>  	help
>  	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
>  	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 7459e1c1899d..93e591f788f7 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
> +#include <linux/pci-pwrctrl.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -421,15 +422,23 @@ static int mtk_pcie_device_power_up(struct mtk_gen3_pcie *pcie)
>  		val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
>  		       PCIE_PE_RSTB;
>  		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +	}
> +
> +	err = pci_pwrctrl_power_on_devices(pcie->dev);
> +	if (err) {
> +		dev_err(pcie->dev, "Failed to power on devices: %pe\n", ERR_PTR(err));
> +		return err;
> +	}
>  
> -		/*
> -		 * Described in PCIe CEM specification revision 6.0.
> -		 *
> -		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> -		 * for the power and clock to become stable.
> -		 */
> -		msleep(PCIE_T_PVPERL_MS);
> +	/*
> +	 * Described in PCIe CEM specification revision 6.0.
> +	 *
> +	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> +	 * for the power and clock to become stable.
> +	 */
> +	msleep(PCIE_T_PVPERL_MS);
>  
> +	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
>  		/* De-assert reset signals */
>  		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
>  			 PCIE_PE_RSTB);
> @@ -449,6 +458,8 @@ static void mtk_pcie_device_power_down(struct mtk_gen3_pcie *pcie)
>  		val |= PCIE_PE_RSTB;
>  		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>  	}
> +
> +	pci_pwrctrl_power_off_devices(pcie->dev);
>  }
>  
>  static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
> @@ -1211,9 +1222,13 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	pcie->soc = device_get_match_data(dev);
>  	platform_set_drvdata(pdev, pcie);
>  
> +	err = pci_pwrctrl_create_devices(pcie->dev);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to create pwrctrl devices\n");
> +
>  	err = mtk_pcie_setup(pcie);
>  	if (err)
> -		return err;
> +		goto err_destroy_pwrctrl;
>  
>  	host->ops = &mtk_pcie_ops;
>  	host->sysdata = pcie;
> @@ -1226,7 +1241,12 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  
>  err_teardown_irq_and_power_down:
>  	mtk_pcie_irq_teardown(pcie);
> +	mtk_pcie_device_power_down(pcie);

So now we have:

  mtk_pcie_probe
    mtk_pcie_setup
      mtk_pcie_startup_port
        mtk_pcie_device_power_up      <-- power up
        mtk_pcie_device_power_down    # error path
      mtk_pcie_setup_irq              # set up controller IRQ
      mtk_pcie_device_power_down      # if mtk_pcie_setup_irq() failed
    pci_host_probe                    # enumerate downstream devices
    mtk_pcie_device_power_down        # if pci_host_probe() failed

I think this is kind of a mess because mtk_pcie_device_power_down() is
called from so many places, and some of them aren't connected to the
mtk_pcie_device_power_up().

In mtk_pcie_setup(), mtk_pcie_setup_irq() only deals with the
*controller* IRQ and has nothing to do with the downstream devices.  I
think mtk_pcie_setup_irq() should be done before
mtk_pcie_startup_port() so we can abort before even powering up those
devices.

In mtk_pcie_startup_port(), mtk_pcie_enable_msi() and the PCIe
translation window setup also don't have anything to do with the
downstream devices, so I think they should be done before 
calling mtk_pcie_device_power_up().  The only thing there that needs
the downstream devices powered up is waiting for the link to come up.

>  	mtk_pcie_power_down(pcie);
> +err_destroy_pwrctrl:
> +	if (err != -EPROBE_DEFER)
> +		pci_pwrctrl_destroy_devices(pcie->dev);
> +
>  	return err;
>  }
>  
> @@ -1241,7 +1261,9 @@ static void mtk_pcie_remove(struct platform_device *pdev)
>  	pci_unlock_rescan_remove();
>  
>  	mtk_pcie_irq_teardown(pcie);
> +	pci_pwrctrl_power_off_devices(pcie->dev);
>  	mtk_pcie_power_down(pcie);
> +	pci_pwrctrl_destroy_devices(pcie->dev);
>  }
>  
>  static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 

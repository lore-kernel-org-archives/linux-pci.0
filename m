Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB89238C3A;
	Wed, 21 Jan 2026 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983808; cv=none; b=ubP5RyLFUg5HW3JJiTc8Umjxpe5AqbE1nmh6xpWsOrnSW2y18E8MlEKv/HxCzjSc7d0zTYlUayTXwO5aGLkuSXEBepilu12aIhKfgj1+8YRnq4k/sxOUbVm61lQSamiyDRrKOlJwLr5SQ7OHGFc3UhgZWjrjy80636aRjwkRrWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983808; c=relaxed/simple;
	bh=Jv4FsrbzjkPMZIDjBffWzvmurLhhD6K/jPvWIsN/jBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdLHCrdcoxHGJRtTi1FDnrRx6CJELn/v23c4jyJDLk1kowS2SqXBWYHt5tlsR/pXM7BUZSHrkBMSswIck9zlvmUWoK7ykSNJxJ0eO3QMguJaXkFFWtStffM2HaGVmM45Q2vPO6Vja/klHQkf8Zf5V4RlvAaMZ9fTxFR6qJ00np0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO9AvBiQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO9AvBiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5448EC116D0;
	Wed, 21 Jan 2026 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768983808;
	bh=Jv4FsrbzjkPMZIDjBffWzvmurLhhD6K/jPvWIsN/jBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iO9AvBiQdkhOfIL0UHEJM7XlEENllixkioH9bnOHDEXJSW30hB/43+pCeoLD0rQAP
	 Can3Tqzgvyf9itTPepRk2kQX18q8AhWMiDCbRpqY5rBvG3MNgU02H5NPh91VTu4yAH
	 4FhIPJa0p2aWMv5U2yR+cZ91A/9QB0n42f/Lw1/+1AGzMdHYAhIDNPFkuuUn6YSTs9
	 1tnAc1FN0ad4j+x2xfMbRB2s1uTWj9fvs2XArKHNhvHk8CDP8U/AsNMf4tuOi2Yk/4
	 1KraTNH6gZaF8fbGMGPSphhXCPncpvx2b2B1GwZtzqJPXw3QrRVZ15LHOvbCiWoqKv
	 Uuu6SNL1cf2TA==
Date: Wed, 21 Jan 2026 09:23:22 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 2/5] PCI: dwc: Return -EIO from
 dw_pcie_wait_for_link() if device is not active
Message-ID: <aXCM-ky9PFTKZTcZ@ryzen>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
 <20260120-pci-dwc-suspend-rework-v4-2-2f32d5082549@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-pci-dwc-suspend-rework-v4-2-2f32d5082549@oss.qualcomm.com>

On Tue, Jan 20, 2026 at 11:17:41PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> There are cases where the PCIe device would be physically connected to the
> bus, but the device firmware might not be active. So the LTSSM will
> get stuck in POLL.{Active/Compliance} states.
> 
> This behavior is common with endpoint devices controlled by the PCI
> Endpoint framework, where the device will wait for the user to start its
> operation through configfs.
> 
> For those cases, print the relevant log and return -EIO to indicate that
> the device is present, but not active. This will allow the callers to skip
> the failure as the device might become active in the future.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 55c1c60f7f8f..aca5bbeade03 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -696,8 +696,9 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>   * dw_pcie_wait_for_link - Wait for the PCIe link to be up
>   * @pci: DWC instance
>   *
> - * Returns: 0 if link is up, -ENODEV if device is not found, -ETIMEDOUT if the
> - * link fails to come up for other reasons.
> + * Returns: 0 if link is up, -ENODEV if device is not found, -EIO if the device
> + * is found but not active and -ETIMEDOUT if the link fails to come up for other
> + * reasons.
>   */
>  int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  {
> @@ -722,6 +723,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		    ltssm == DW_PCIE_LTSSM_DETECT_ACT) {
>  			dev_info(pci->dev, "Device not found\n");
>  			return -ENODEV;
> +
> +		/*
> +		 * If the link is in POLL.{Active/Compliance} state, then the
> +		 * device is found to be connected to the bus, but it is not
> +		 * active i.e., the device firmware might not yet initialized.
> +		 */
> +		} else if (ltssm == DW_PCIE_LTSSM_POLL_ACTIVE ||
> +			   ltssm == DW_PCIE_LTSSM_POLL_COMPLIANCE) {
> +			dev_info(pci->dev, "Device found, but not active\n");
> +			return -EIO;
>  		}
>  
>  		dev_info(pci->dev, "Phy link never came up\n");

This should probably be squashed with the previous patch.

Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

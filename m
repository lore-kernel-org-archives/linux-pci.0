Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC437CD52;
	Thu,  5 Mar 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705896; cv=none; b=ObOA+W7t7+gp2BCio5wbXXiGVW977Jx2bHpZzYZn8sqqnZVuFavyiYfR07OIhRV+jsAA2X51PYjpg3YOaR79vsVK9gIed0d+L2gzq4bYzkUK5U7zgF1/FqlSx0u9ZIPsO3/KHHnA1Lusfzx/ycavEzfPmD0TPoxTRas8s8Tppbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705896; c=relaxed/simple;
	bh=c1FAi14nQ1GNRGY0M905cz7eIhZ2MT8LL6nU2RGR+PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUJasvoavi22S/nJoUVsbNl1Oa0UXtQiCniPE+J3l/gRN+CeDbdK3DYwcCe+vSpt+Tf0lu30cM0NGivuUUBy+2LBbyPevQlVglKGYSq3jbquQO2yefnK7xDm008PbZVwliBeyrkAXgh5vV17bBbddkIbOr5KIUK6C5Y2AYO9xMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBfU900B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBfU900B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F56AC116C6;
	Thu,  5 Mar 2026 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772705896;
	bh=c1FAi14nQ1GNRGY0M905cz7eIhZ2MT8LL6nU2RGR+PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBfU900BAw9GwAbY5xH63mq8ZANcF4CqlDu+Qj80LEqqmn1Rw4A5NdDh4XBVu+UgY
	 QY2XiYpFtRLwgIT15s+Epcgnd1LtS6ygxAbrRZK+cfcvdn6oHmBv9mWNbCrffrEK2/
	 S0MnJWV8wmE2c59HeCp6SQorEuEaJLDlw4Lbzzb4BTAYjaKm1UxPxMg6d6QJBguT5J
	 beaE4PQjB5+8KWzmPQTQEP83cIludLfvZTfkNiFXe9kFICGONoXOFKRoe080S3GF0I
	 DJjhvOAiw5yiXIzHsPQn3ddsgNV7m/Rta9iKOHBVJaHPFmTpDrlNB/g3fsGAxA9V3K
	 6v1P6Ev4tjKUg==
Date: Thu, 5 Mar 2026 15:48:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/13] PCI: tegra194: Set LTR message request before
 PCIe link up
Message-ID: <x5m2omsus72plxulgt66hov5giw2t5madb6zfzyr2e2o5ojm4b@uhyuycoa6gpw>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-8-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065448.2361488-8-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:24:42PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> LTR message should be sent as soon as the Root Port enables LTR in the
> Endpoint. Set snoop & no snoop LTR timing and LTR message request before
> PCIe links up. This ensures that LTR message is sent upstream as soon as
> LTR is enabled.
> 



> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V6 -> V7: Retain FIELD_PREP() usage
> Changes V1 -> V6: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 2da3478f0b5f..b50229df890e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -485,15 +485,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  	if (val & PCI_COMMAND_MASTER) {
>  		ktime_t timeout;
>  
> -		/* 110us for both snoop and no-snoop */
> -		val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
> -		      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
> -		      LTR_MSG_REQ |
> -		      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
> -		      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
> -		      LTR_NOSNOOP_MSG_REQ;
> -		appl_writel(pcie, val, APPL_LTR_MSG_1);
> -
>  		/* Send LTR upstream */
>  		val = appl_readl(pcie, APPL_LTR_MSG_2);
>  		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
> @@ -1803,6 +1794,15 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
>  	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
>  
> +	/* 110us for both snoop and no-snoop */
> +	val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
> +	      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
> +	      LTR_MSG_REQ |
> +	      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
> +	      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
> +	      LTR_NOSNOOP_MSG_REQ;

As per the spec, the device is not permitted to request Snoop/No-Snoop latencies
greater that the Max Snoop/No-Snoop latencies set by the host depending on the
platform requirement.

But here the driver is just using a hardcoded value without reading Max values.
It may be assuming that the host is always going to be another NVidia platform,
so it sends out fixed LTR latencies, but that's not going to be true always.

Also, the host can update the Max latencies at any point of time during runtime.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

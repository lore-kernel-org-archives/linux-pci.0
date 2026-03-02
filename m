Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DF30B514;
	Mon,  2 Mar 2026 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494069; cv=none; b=oQ/ZFDpEPmrSdx1uWHx0RU9y6/jQTxPzqfhVQEmJaBHGSz0COgx94uaeIvColGDtYLjhwAte+n6NtKTYfrqWfskWXbzDw5Mb7103WE4Y5A7PG38qUOlTREs8BsaWehO2n5cg45Ji1YRsANERXuotYXLc9UTj+JSHlzT2Sg5hpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494069; c=relaxed/simple;
	bh=FbLJLoTeexqAxbPCXk2C8PhK/Q71B0QO1sSue245RwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tcj253s+O57qBEX1ki/c21+NuOeLSWkPQhLfdtfysSfzfkXONBHdNm7IU85W7ZgCbiOXNIyhOOZO98QbQ6mzQLm4QSa843pGiyQtbXCORsBSBV+di8E5WCng0R4rRnyqAfGvJ3VP/seT973qT0fAPvOiHm0U9DoSfdqYWJsaH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPEhBkUG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPEhBkUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACCAC19423;
	Mon,  2 Mar 2026 23:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772494069;
	bh=FbLJLoTeexqAxbPCXk2C8PhK/Q71B0QO1sSue245RwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OPEhBkUGSvwg7vLPavs/+5I2q3DwohIHJ6FXcsB7RmZmSHUcaDxkm4WwVsElAM8+Z
	 H9x4RZyhhXz5uL3MCMbsFTqWuVFdKh4n96DE0rVWPlcRxyIruI4StDPenrRwN8OqaV
	 KWS2h4SNLCEtFz1LEW2aO487Hnw/5iaBY38+LhuACTtgC061krjtmBG0ynXAHZxjIp
	 +omX6Or4KJBDHSK/busfdQ87BAnIC3QUNZiml/eyh06mGTBYT14L2SsZjDdarMjMst
	 i/0Wf6vUdrqwvn1tnM6kacGSv2k1pvVujHIRpwlmv8dHbhqENr55ocWOa8Y4/Rhkkv
	 gISQdzCR52aXA==
Date: Mon, 2 Mar 2026 17:27:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com,
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org,
	18255117159@163.com, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/13] PCI: tegra194: Set LTR message request before
 PCIe link up
Message-ID: <20260302232748.GA4036213@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223184151.3083221-8-mmaddireddy@nvidia.com>

On Tue, Feb 24, 2026 at 12:11:45AM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> LTR message should be sent as soon as the root port enables LTR in the
> endpoint. Set snoop & no snoop LTR timing and LTR message request before
> PCIe links up. This ensures that LTR message is sent upstream as soon as
> LTR is enabled.
> 
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V1 -> V6: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index a6868b77e3b7..ad1056d68d6d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -124,6 +124,7 @@
>  
>  #define APPL_LTR_MSG_1				0xC4
>  #define LTR_MSG_REQ				BIT(15)
> +#define LTR_MST_NO_SNOOP_SHIFT			16

Would prefer to avoid adding more _SHIFT #defines, see below.

>  #define LTR_NOSNOOP_MSG_REQ			BIT(31)
>  
>  #define APPL_LTR_MSG_2				0xC8
> @@ -488,15 +489,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
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
> @@ -1805,6 +1797,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
>  	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
>  
> +	/* 110us for both snoop and no-snoop */
> +	val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;

I get that we're moving this LTR setup from tegra_pcie_ep_irq_thread()
to pex_ep_event_pex_rst_deassert(), but I don't understand why we lost
the FIELD_PREP() usage.  It's nice to be able to grep for
PCI_LTR_VALUE_MASK, etc and find all the uses.

> +	val |= (val << LTR_MST_NO_SNOOP_SHIFT);

> +	appl_writel(pcie, val, APPL_LTR_MSG_1);
> +
>  	reset_control_deassert(pcie->core_rst);
>  
>  	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -- 
> 2.34.1
> 

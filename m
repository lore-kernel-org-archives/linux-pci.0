Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E83368BE;
	Thu,  5 Mar 2026 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708314; cv=none; b=bk4QhAzafftzsfm47Sw2aBgJ6om5qyWie3yx3/GHiX273s81xlZW+cCyC8q7lVw/StZj8jsYwROlHrSYgt+ydyil4cjglKSBLU94ViRQS+9ok/T8PZlIP/wf1RhtrAb06SRSTNnvHNQqoxxSF5xVCjDxpXKvdeYMAgvYHCrTpqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708314; c=relaxed/simple;
	bh=CmgiB2Dpx1oIjKicmienLZQ1Qcz5elUeMvN+qJoBfxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0dWSHK1sdaKWy814v8YSaQHqJpC1m3eyJM1Kksm/wORkKA+I16YTYISjKY3j9Pxr40RF1ZYrFBX2z1m1wXDpb5VWBaAj/NTBkBJowu6fd0Xe4DigZ9Y3OmRPt9xbd6NzdQ++ptVP3Mlu8RareniHaRLRwWgiVHFzHnwBRaLcqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM+e71ym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM+e71ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C39C116C6;
	Thu,  5 Mar 2026 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772708314;
	bh=CmgiB2Dpx1oIjKicmienLZQ1Qcz5elUeMvN+qJoBfxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XM+e71ymkCudqVnaKwY/m9PmO9WKLAoq9zNhokCmI0cNllMmG6doDww5ltWGkOama
	 AX335a2jCK4mFODtI1+qvq74k42fdfn/WSKaieGXCQPVEDLP05u8GKSqWJmpbWRD1c
	 Yo9bSaSwmDkKe2I4iVW7XcWKHajb+Id96+sOpVDSiWz/wO2kxW4XuOq+CkjDX6LPs6
	 iQUckLWr35+OKH+WUgpK9ZiB9vxZnOQF6IcyJ306rX2Oa3+kE9oXTfaxUnXR2NNXAl
	 xlF9lKhPkGzA+i5MASMYvWxIfCrW+39+mGROfGILgRxLOfKgOQfXIMQ8/gP+1Q8qea
	 haLQ8s23hegdg==
Date: Thu, 5 Mar 2026 16:28:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/9] PCI: tegra194: Drive CLKREQ# signal low explicitly
Message-ID: <vtylufhul43vacnq6gxvoyshtiesl2is5rmfgxw2ijlzntyvch@sbt7dhufem6q>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
 <20260303065758.2364340-2-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065758.2364340-2-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:27:50PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Currently, the default setting is that CLKREQ# signal of a Root Port
> is internally overridden to '0' to enable REFCLK to flow out to the slot.
> It is observed that one of the PCIe switches (case in point Broadcom PCIe
> Gen4 switch) is propagating the CLKREQ# signal of the Root Port to the
> downstream side of the switch and expecting the Endpoint devices to pull
> it low so that it (PCIe switch) can give out the REFCLK although the Switch
> as such doesn't support CLK-PM or ASPM-L1SS. So, as a workaround, this
> patch drives the CLKREQ# of the Root Port itself low to avoid link up
> issues between PCIe switch downstream port and Endpoint devices. This is

Is the CLKREQ# signal shared with the switch and the endpoint devices
connected to its downstream port also?

> not a wrong thing to do after all the CLKREQ# is anyway being overridden
> to '0' internally and now it is just that the same is being propagated
> outside also.
> 

What do you mean by 'propagating outside'?

And what is the difference between APPL_PINMUX_CLKREQ_OVERRIDE and
APPL_PINMUX_CLKREQ_DEFAULT_VALUE?

- Mani

> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V6 -> V7: Fix commit message
> Changes V1 -> V6: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index b1ae46761915..2f1f882fc737 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -44,6 +44,7 @@
>  #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
>  #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
>  #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
> +#define APPL_PINMUX_CLKREQ_DEFAULT_VALUE	BIT(13)
>  
>  #define APPL_CTRL				0x4
>  #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
> @@ -1411,6 +1412,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>  		val = appl_readl(pcie, APPL_PINMUX);
>  		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
>  		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
> +		val &= ~APPL_PINMUX_CLKREQ_DEFAULT_VALUE;
>  		appl_writel(pcie, val, APPL_PINMUX);
>  	}
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

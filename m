Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FF2E1722;
	Mon,  2 Mar 2026 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772493469; cv=none; b=V+k9LhoaS1CnTMGnc1YQ8V5qv7/h4fKw7yH2VGaQtlEMLjc7qDgtLcr4EDlxIl33kEEQ8XkXYLNCmUaogcxnk68eAXicqQX3rmgyK37IStabrxEWS01T2RJpiWFo3Mn4Rt6/Pt2njfGpgJfVNzy8jWiertH/G5NyZOOeNMymack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772493469; c=relaxed/simple;
	bh=V9ixDt1v0uvLxDuDM0c1Km3Dx5Kce/pR5Etg4b08qwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=REtDtehIMgSF5ufPUO8seo0kKQnCqDOdNGQAWay2TIDUupX2sqTMSVqyLfnwE9n4klHB1OhD4ockOc8LirpKm3pYEvitfvfMnLwBf/U0+5Z7t0JfgA+kMfu5Tx9/krHw6YrAV7/cYfesCJ55kprRml5zaaiJzMZjhWqv3Z/HSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hC3+ULNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC3+ULNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF9EC19423;
	Mon,  2 Mar 2026 23:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772493468;
	bh=V9ixDt1v0uvLxDuDM0c1Km3Dx5Kce/pR5Etg4b08qwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hC3+ULNXzsaOrgSe/qscOUnQnmts77FDuYlA6isxmUg9K5y2mx2HVvobLMr3OMLTM
	 5NBLz4maCmlKtpoHJSeq8zYWQ/zgsv/rROgFO3J+kHGzQYOT5ygblj/jU2FOXHGxJb
	 RYKhkrH7NxUMPYA7lSjp/5t9O4WpgNMXOtFPlCaNtw0+G+r5fY53ycvgirySIi3u+a
	 tfEWHHazlFdwHqXDQwhSLrrk12Lfaj6JIZK+of5YiuJmPOR4roSPj6/OKp0kx19D60
	 HEzckPaAQtFFSoGIgzkLTUfv+jPOZx2+CluWNmMZA6FIgA92bOdk+S89GABAUgC1gn
	 1RgjqlywOxBKg==
Date: Mon, 2 Mar 2026 17:17:47 -0600
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
Subject: Re: [PATCH v6 01/13] PCI: tegra194: Fix polling delay for L2 state
Message-ID: <20260302231747.GA4036075@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223184151.3083221-2-mmaddireddy@nvidia.com>

On Tue, Feb 24, 2026 at 12:11:39AM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> As per PCIe spec r6.0, sec 5.3.3.2.1, after sending PME_Turn_Off message,
> Root port should wait for 1~10 msec for PME_TO_Ack message. Currently,
> driver is polling for 10 msec with 1 usec delay which is aggressive.
> Change it to 10 msec polling with 100 usec delay. Since this function
> is used in non-atomic context only, use non-atomic poll function.
> 
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V1 -> V6: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 0ddeef70726d..96d38571a7e7 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -198,7 +198,8 @@
>  #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
>  #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
>  
> -#define PME_ACK_TIMEOUT 10000
> +#define PME_ACK_DELAY		100   /* 100 us */
> +#define PME_ACK_TIMEOUT		10000 /* 10 ms */

Can you add "_US" and "_MS" suffixes to these to indicate the units?

Unless they are something specific to tegra194, the #defines should
probably go in drivers/pci/pci.h so they can be shared.

It'd be nice to update the PCIe spec citation to r7.0.

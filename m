Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092D4F393F;
	Mon, 28 Sep 2026 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632212; cv=none; b=AIAnEr0m3gdio/9U9+I7mGV/qxohUBCYlQRQkCUQajp9iH3g4EmGZ6l5SWI6lGwkuiz7jUGAsBzq0kgYgQRJo+CRXNWgV+vt4HB2VCZ2KSqSOd7Kvep8TuKvYMU2gYbP4GriUd4bl5gW/gAf1vrb6jBjMICZph6VHyG8jcVJsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632212; c=relaxed/simple;
	bh=A7ruDvHZmF/FtNoQKVpWDvLJ+ZWFhZei8MTpe+4Kk4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RvE4Nps3zKZO/wFt5E6tvh/hbreMqEMVtKvJKH6LVZmNrZuCwCNtfPtpORVfVkq03pcFtWXerp9Lg83tpgeYsKqjNcVrxoPXiXO+8jpVsLNPNw1mZAPHMz0Vygo3A4tDYgB06rIaFehQHrWpvRnlWGzSClkq5copAn2J5hNMW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD/tJ8gl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD/tJ8gl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87CE1F000FF;
	Mon, 28 Sep 2026 21:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790632209;
	bh=7MxyfVUmcact8Av7EhfeX6cj39M4hc4P2lmgVVGpq/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=YD/tJ8glnvDxae6cHN7UN4ZZm7fAUj8v1wCP3ZSjJ5TpZQrDekpIQOt1FMVwHHYmI
	 v4rcz3NQjeQha4y6Q9gH0lxajjFHHoZA4wyljDt/2urG1stOXUCjLyFvbU9B0Rspri
	 kFDIldH8LIChWzLQ1FBK47bZMdIW4ITAbUQRkgy07rqAEESNlc7p6tDyx8WcHJejHU
	 RSj3EYAfbBsUSAXTTv2fBuZjnha3MrsLM3WD5X1A3qbFr0sGQoopmwmUi4RQVCQFjJ
	 ZI03syYiOh8vd/ZgdW87gryjOTm7kFYP5yCGeVBR58ePFV3/lw6+saUrcSoepDA9Hu
	 DOQWgFnblUkcQ==
Date: Mon, 28 Sep 2026 16:50:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, cassel@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Feizhou Yu <yufeizhou201@163.com>
Subject: Re: [PATCH 1/2] PCI: dwc: Align register macros with Synopsys
 documentation
Message-ID: <20260928215007.GA2264960@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911162537.469018-2-18255117159@163.com>

On Sat, Sep 12, 2026 at 12:25:36AM +0800, Hans Zhang wrote:
> The DWC PCIe register and field macros are inconsistently named and
> often do not match the Synopsys DesignWare PCIe Controller Reference
> Manual.  This makes it harder to cross-reference the code with the
> documentation when debugging or maintaining the driver.

> +#define  PORT_AFAC_L0S_ELS		24		/* L0s Entrance Latency shift */
> +#define  PORT_AFAC_L0S_ELM		GENMASK(26, 24)	/* L0s Entrance Latency mask */
> +#define  PORT_AFAC_L1_ELS		27		/* L1 Entrance Latency shift */
> +#define  PORT_AFAC_L1_ELM		GENMASK(29, 27)	/* L1 Entrance Latency mask */

Surely we don't need both the shift and the mask?  Maybe a separate
patch convert to FIELD_PREP()?

> +#define  GEN3_CTRL_RATE_SHADOW_SEL_SHIFT 24		/* Rate Shadow Select shift */
> +#define  GEN3_CTRL_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)	/* Rate Shadow Select mask */

Ditto.

> +#define MSIX_DOORBELL			0x948
> +#define  MSIX_DOORBELL_PF_SHIFT		24

Probably would be better to define a mask so we have the position
*and* the width.

> @@ -621,15 +621,15 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
>  	u32 val;
>  
>  	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
> -				PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
> +				RAS_DES_EVENT_COUNTER_CONTROL);
>  	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
>  	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
>  	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
>  	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;

Probably a good chance to convert these to FIELD_PREP() etc. as well,
maybe in a separate patch.

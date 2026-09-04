Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147533DE430;
	Fri,  4 Sep 2026 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538373; cv=none; b=CJX3TGlEud1sxTcmDUgEA8k1aNkUSuCqLrN12Vtt5l5FsNvj0SW5Y1W2Kl62VZukyhG4zmjceIoCwm66hrnyiaYm++pLS55t0ZZdUVrHiSvFaFBadEl/10GswLVbK0vqDcw+uQg6rYJ7mUxfPFlkb5iTTLvmG8SjK0yIJYWwXVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538373; c=relaxed/simple;
	bh=nhKOaAX8ofrKCcrsBtKp+l6c1CqrCL5oUUu7sPOKpp8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IXon6MO07hvrq1RSjt6/MTnHGAkeKLQYYQojUiS7FGHzINJrjTHO4fSJqtiAGLszvbC4KgFay5yasfxA603y06CfwhUfi1otfW1MjX4PK0YJUJVDwTS8Qjvg41pvRqdqaXgFD5VGtg6njttlft4d6dRr0oJUIB+RlRnX47LiJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeIX/vtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeIX/vtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7403B1F00A3D;
	Fri,  4 Sep 2026 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788538371;
	bh=HTxUJWFn7YAoxykhvOWdjJvl+/JEfg+X+73sfBBuFyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=eeIX/vtnG4lM9k8aWeQFo3yL1AgSRCDDZtzMaL/67wt7Va/AERWReTZY0SABWrKVS
	 m5PKByHvCDlqSe5goxfeUSuveRElDkDw7ijYgRfGxEriZH/jexVjiOlGJ8AZnzeWXY
	 yBvUR/NQZT4qjFkbQBqqxN9rsnXSwL3lELlJta2PGcMxwQBzHqU10b7FpR6IBjKxaN
	 uWoBkfbJq0XVnYTx1RmrWj8wObxmilEFhtQmv8jX+XBgog5lf7bqNCOZ+FDNm+YzWX
	 WTx71n7e3N3mHOFX6tg78v3l1PWdeiO3vmnzCs9keQdlcdmae/5KEGiWEBZ4ikZoyJ
	 MNpaA5ZjgvksA==
Date: Fri, 4 Sep 2026 11:12:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	a-garg7@ti.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Feizhou Yu <yufeizhou201@163.com>
Subject: Re: [PATCH] pci: dwc: Rename PCIE_PORT_LINK_CONTROL to
 PORT_LINK_CTRL_OFF
Message-ID: <20260904161250.GA2318713@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904061823.592216-1-18255117159@163.com>

On Fri, Sep 04, 2026 at 02:18:23PM +0800, Hans Zhang wrote:
> The register at offset 0x710 is documented in the Synopsys DesignWare
> PCIe Controller Reference Manual as "PORT_LINK_CTRL_OFF" (Port Link
> Control Register). The current macro name PCIE_PORT_LINK_CONTROL does
> not match the documentation, making it difficult to cross-reference
> with the spec when debugging or maintaining the code.

I'm a little skeptical about this change.  I agree it's good to match
the spec, and the leading "PCIE_" seems superfluous.  But I think it's
pointless to add "_OFF" to every register offset.  "PORT_LINK_CTRL"
seems like enough, and it's pretty close to the spec's name.

Adding "_OFF" also invites confusion: does it mean "offset" or "off"
(the opposite of "on")?

It's also nice if names of fields within a register include the
register name, e.g., PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC, etc.
For long register names like PCIE_PORT_MULTI_LANE_CTRL, with a
PORT_MLTI_UPCFG_SUPPORT field, you have squint pretty hard to see the
connection between the register and the field, but a name like
"PCIE_PORT_MULTI_LANE_CTRL_UPCFG_SUPPORT" would be just ridiculous.

> Rename the macro to PORT_LINK_CTRL_OFF to align with the Synopsys
> documentation, and update all usage sites accordingly. No functional
> change is intended.
> 
> This improves code maintainability and eases future reference to the
> controller manual.
> 
> Co-developed-by: Feizhou Yu <yufeizhou201@163.com>
> Signed-off-by: Feizhou Yu <yufeizhou201@163.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 593388f29bdd..9a0d8f0be792 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -894,7 +894,7 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  		return;
>  
>  	/* Set the number of lanes */
> -	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> +	plc = dw_pcie_readl_dbi(pci, PORT_LINK_CTRL_OFF);
>  	plc &= ~PORT_LINK_FAST_LINK_MODE;
>  	plc &= ~PORT_LINK_MODE_MASK;
>  
> @@ -922,7 +922,7 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
>  		return;
>  	}
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> +	dw_pcie_writel_dbi(pci, PORT_LINK_CTRL_OFF, plc);
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
>  
>  	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -1295,10 +1295,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
>  
> -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> +	val = dw_pcie_readl_dbi(pci, PORT_LINK_CTRL_OFF);
>  	val &= ~PORT_LINK_FAST_LINK_MODE;
>  	val |= PORT_LINK_DLL_LINK_EN;
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> +	dw_pcie_writel_dbi(pci, PORT_LINK_CTRL_OFF, val);
>  
>  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0735ae940924..77420230433b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -87,7 +87,7 @@
>  #define PORT_AFR_L1_ENTRANCE_LAT_SHIFT	27
>  #define PORT_AFR_L1_ENTRANCE_LAT_MASK	GENMASK(29, 27)
>  
> -#define PCIE_PORT_LINK_CONTROL		0x710
> +#define PORT_LINK_CTRL_OFF		0x710
>  #define PORT_LINK_DLL_LINK_EN		BIT(5)
>  #define PORT_LINK_FAST_LINK_MODE	BIT(7)
>  #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
> -- 
> 2.43.0
> 

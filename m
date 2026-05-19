Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547D3264EB
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201147; cv=none; b=JErGgf0mZ0JYykOmuqIxlHY+tZcyJ/8hO5FkrOlTiCG6koplJi3Hof3m5kR4n0BfsveivWNk4E7lCb7BXIESdfHUenoUSFOWXQkpCjpIOPWooDVZ/RFMERlUihUMtnmAQwZ9aRhAEYzgj36fKW5Ld6K4GSPwPqAq9T6fqjIG6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201147; c=relaxed/simple;
	bh=8MaiKzB7ejT58TTDBwmulGBulvRlbgT1KBiBFtX3pno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HapklGo5VusIaRVjK92rF0LP2rA5svgNX8G/HgN7d6hqXbnyA2/8T+Prkh5a32mnfVjT0o9xso8W2BV7/elc5md454gU+/SrFt8+6zxm+pshNrmyhUODawpFAfcEqvwrudH4Gs61A0ermVb5C/6ZVK5c+vo5HxlAlWAF8q658Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwYWQP90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwYWQP90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E929C2BCB8;
	Tue, 19 May 2026 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779201146;
	bh=8MaiKzB7ejT58TTDBwmulGBulvRlbgT1KBiBFtX3pno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwYWQP90t6/xIUEd36RTxtJEeEJTHds7ltESGxyH5dCk2BWcEJNO/NLwnTT2NMpX8
	 rAjgYth0JWcFOVhentLVTCIqMX4sdpT29q68jOin273MhE/z695VVKdM/BIRWP5E3Z
	 VYYC5jTigCsZsgMOzjQyk6T3CGNuzG3ogLaCgyRUCo/iOGOPmyQLXZKgWsGHvwdte8
	 Kb5yNNlFgP9Fmc44o4r0zADUMFcLszW2b85b1NzOykYJpDUG7LCfMm/GpYyHq1zuid
	 9A6+wsBwkAd/O7BoTIqFeVrXf6moRyhvT7LsY1dJ/VPdkEmDp6hrXzltFcYSNG/nm1
	 /s/dpQVBjrAQw==
Date: Tue, 19 May 2026 20:02:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use fixed-width interrupt masks
Message-ID: <5czyljgtqc22b7zr3a4ozr6cgs77jtfnftasglkfnuy3knt7in@m4bnglg2vge6>
References: <20260512204407.39753-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512204407.39753-1-rosenp@gmail.com>

On Tue, May 12, 2026 at 01:44:07PM -0700, Rosen Penev wrote:
> Use u32-typed BIT and GENMASK helpers for PCIe interrupt register
> masks.  This keeps inverted masks in the same width as the registers
> and avoids truncation warnings on 64-bit compile-test builds.
> 

Can you share those warnings?

> Drop the unused sys_to_pcie() helper while touching the same area; it
> references stale ARM pci_sys_data glue and has no callers.
> 

This change has no relation to this patch. You should move it to a separate
patch.

- Mani

> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index e568528bad85..da43661792e8 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -57,9 +57,9 @@
>  #define PCIE_CONF_DATA_OFF	0x18fc
>  #define PCIE_INT_CAUSE_OFF	0x1900
>  #define PCIE_INT_UNMASK_OFF	0x1910
> -#define  PCIE_INT_INTX(i)		BIT(24+i)
> -#define  PCIE_INT_PM_PME		BIT(28)
> -#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
> +#define  PCIE_INT_INTX(i)		BIT_U32(24 + (i))
> +#define  PCIE_INT_PM_PME		BIT_U32(28)
> +#define  PCIE_INT_ALL_MASK		GENMASK_U32(31, 0)
>  #define PCIE_CTRL_OFF		0x1a00
>  #define  PCIE_CTRL_X1_MODE		0x0001
>  #define  PCIE_CTRL_RC_MODE		BIT(1)
> @@ -950,11 +950,6 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
>  	return pci_bridge_emul_init(bridge, bridge_flags);
>  }
>  
> -static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
> -{
> -	return sys->private_data;
> -}
> -
>  static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
>  						    struct pci_bus *bus,
>  						    int devfn)
> -- 
> 2.54.0
> 

-- 
மணிவண்ணன் சதாசிவம்

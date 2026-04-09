Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9B29B78D;
	Thu,  9 Apr 2026 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753636; cv=none; b=KUmjDfykyLYNIwVXOwxgquKQosQVtbSVAOYiqNNopzox5Dm2IPGoeFqm3hyuYWDv/Dg2quHzGp9y3BA2599aBCSDjml1fL5Jyh1GnIgQtM5T/OE8PnNctTG6x2Uln9leSDUcu9UrZpLmVBlFLDzNhqNv3WiRtSC6esWp8m4NjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753636; c=relaxed/simple;
	bh=0KZ30YzaiucJMS+OGrhTeqDb6HerageSBpXY41WlaYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ8NVqeUvl7nVE6zLROkhH15xkUHt+2mLVb/pex7Y4Uc2LaQd6k7rPzsEZe/6H/qWJo1p2pT4CmYRhQXI4E8QVTPOiMvpDEwgr4ccS44ppimb7FtOCupQKoZibL5CITgK4y23DjCmGtH0YWkT/7JmO+WufICBExWteueKhsTwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFrhoQK2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFrhoQK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BA4C4CEF7;
	Thu,  9 Apr 2026 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775753635;
	bh=0KZ30YzaiucJMS+OGrhTeqDb6HerageSBpXY41WlaYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFrhoQK2EdezdnbCa+QLwP+Is2C7pa4Qc43Ecd80EC0h+iEXoaniKAmiNTohiAQLG
	 1c8DVvHg6e42cFrHcC5lFKcFBkWc24QiE4TJ1+ANkHiiTcSBvilA0EbJRhhr6X0HLP
	 CPrS76NozBEKNPVMXu2+dCGXrq6y6ensO3DZ+dOBL4pQEHzvtaYIoQBTRX2WCTedj1
	 hsxhTUsDXGDlE6KeLvUsm2xUC3MK7itgHczCVMXAAQvFTPhCfCKpcOFbyda8Naf32a
	 lLVI5oHYVaeOaGTnxhq2NqVbUA1lY5sR6ftFpG/H23puEVydBDapl6htnw5C14ElW3
	 uq16c3VpnwHPw==
Date: Thu, 9 Apr 2026 22:23:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: David Laight <david.laight.linux@gmail.com>, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, 
	kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com, 
	den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com, vidyas@nvidia.com, 
	cassel@kernel.org, 18255117159@163.com, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] PCI: tegra194: fix min() signedness when capping
 ASPM L1 entrance latency
Message-ID: <z4mgcazzskxp354izuphajkry4klfkrupofkrrbyvta5kjfjrv@t3po7fsxfom7>
References: <20260407145749.130753-1-mmaddireddy@nvidia.com>
 <20260408125827.7063fd83@pumpkin>
 <d6c62d55-d58a-48de-819c-c07233717500@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6c62d55-d58a-48de-819c-c07233717500@nvidia.com>

On Thu, Apr 09, 2026 at 12:35:04PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 08/04/26 5:28 pm, David Laight wrote:
> > On Tue, 7 Apr 2026 20:27:49 +0530
> > Manikanta Maddireddy <mmaddireddy@nvidia.com> wrote:
> > 
> > > The DT property "aspm-l1-entry-delay-ns" is converted to microseconds,
> > > then encoded for the L1 entrance latency register field as ilog2(us) + 1,
> > > clamped to the hardware maximum of 7.
> > > 
> > > ilog2() returns int type, while the upper bound is 7U (unsigned int).
> > > The min() macro is implemented with __careful_cmp(), which rejects mixed
> > > signed and unsigned operands at compile time via BUILD_BUG_ON_MSG in
> > > minmax.h; that check trips on this pair, notably when building with W=1.
> > > 
> > > This combination fails to build (e.g. parisc allyesconfig, GCC 15, as
> > > reported by the 0-day bot).
> > > 
> > > Use min_t(u32, ilog2(us) + 1U, 7U) so both sides of the comparison are
> > > unsigned and consistent with aspm_l1_enter_lat.
> > 
> > Adding 1U (rather than 1) is enough to make everything signed.
> > Alternatively change the 7U to 7 and it will all be fine regardless of
> > whether ilog2() returns a signed or unsigned result.
> > 
> > Remember min_t(u32, x, y) is min((u32)x, (u32)y) and you wouldn't put in
> > casts like that for any other arithmetic operation.
> > 
> > Note that for the compile to fail there has to be a code path where
> > ilog2(us) isn't known to generate a non-negative value.
> > ilog2(us) (probably) ends up as 'fls(us) - 1'. If that is implemented using a
> > compiler builtin (because there is a single instruction) then gcc knows that
> > the input can't be zero (from the max()), so knows that fls() can't return 0
> > (which it does for 0), so knows it is never negative and the checks in min()
> > pass.
> > 
> > parisc may be one of the architectures that ends up with a real function
> > for fls() so the compiler doesn't know the result of ilog2() is
> > non-negative.
> > 
> > Just delete the U.
> > 
> > 	David
> 
> Thank you David for the review.
> 
> Hi Bjorn, Mani,
> 
> Let me know if you are OK with David's suggestion, I will send new patch as
> shown below
> 
> -	pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
> +	pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7);
> 

Sure, go ahead.

- Mani

> > 
> > > 
> > > Fixes: 4a44cd65c9dd ("PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency")
> > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com/
> > > ---
> > >   drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index 393f75ce3df3..93d3452ac117 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -1147,7 +1147,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
> > >   	if (!ret) {
> > >   		u32 us = max(val / 1000, 1U);
> > > -		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
> > > +		pcie->aspm_l1_enter_lat = min_t(u32, ilog2(us) + 1U, 7U);
> > >   	}
> > >   	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
> > 
> 
> -- 
> nvpublic
> 

-- 
மணிவண்ணன் சதாசிவம்

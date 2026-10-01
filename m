Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47382470134;
	Thu,  1 Oct 2026 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873017; cv=none; b=jXPYMIlmEIBY52C1pNL1f/kV8opaA+DXyPm5eiJC3J0/HVq5QYjn/6YFcjhCmaQfPBGQhXjIdaUyaAq8SqQ0S/FVzKNLwxaLQQhNcWZIAH6num/9sv4MIY9UFV7slSOBHe1cR9Q8UUDkj5iG/XKmbSY3LiO4van99o3iS+bxUrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873017; c=relaxed/simple;
	bh=h9fNAct86piAsWheuwLXjPBjYsk5Wu76MIDCKfzqN/M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r6Z4c5NHG+J9D0nt7Ry2hhvP/7Jj80FJqeICEo8lgfJTzF63Qj8xq12HkfU8Y+2cb8d5q/5vXONz4MflKuseBRUPxDemoAxoBPHCk6LCposYC04zEAE9liiH/M928/784CKPELnJGPhmWKc4RIlElmEanSwaU0dfbAsmK5lVnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXYXeeND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXYXeeND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883E11F000FF;
	Thu,  1 Oct 2026 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873015;
	bh=IrTV6AI4fTKtbMpvyOx2Jh/xkKLWMyAHLVJdUe3MI10=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BXYXeeNDtxUM8AzpR+t/s9/nRAN/qu7K2lcAbGHxTbvoazm/zsmqi8kAneu6g+QEW
	 lFxpP6Ww9IJHN/8nSpwwaJujZjvkKIUbDnnToaKTHkvnO3PM1ea5/3S4IYRy70HXlL
	 53+2T66QWcJspSztbJafVgaqtrctt2t7oWCG/iQ03YWD9ms+IGJwvOZMbe+DsVg3+g
	 TBcHyZXKekkudYC5dSfZyVKLnvXw8mtnidWNwsn1Aw6ztkgEIjJYbtj/5NMzzpGGTT
	 +o7AEPcXpn3dJJo26SvodEeCbgU3Gn/rM29F58ux4Zt4DkBo7z2J5I7boUVnbI2FxO
	 WNGLp30nXtX2w==
Date: Thu, 1 Oct 2026 11:43:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: tegra264: Fix Link Capabilities register offset
Message-ID: <20261001164334.GA2695061@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar4Nhd_mJ-NmUavQ@orome>

On Thu, Oct 01, 2026 at 09:40:11AM +0200, Thierry Reding wrote:
> On Wed, Sep 23, 2026 at 02:57:20PM -0500, Bjorn Helgaas wrote:
> > The PCI Express Capability begins at 0x48.  Link Capabilities is a 32-bit
> > register at offset 0xc, and Link Status is a 16-bit register at offset
> > 0x12:
> > 
> >   Link Capabilities is at 0x48 + 0xc  = 0x54
> >   Link Status       is at 0x48 + 0x12 = 0x5a
> > 
> > Previously the driver read Link Capabilities with a 16-bit read from
> > XTL_RC_PCIE_CFG_LINK_CAPS (0x56), which incorrectly read just the upper
> > half of the register.  When a hotplug-capable port has no link during
> > probe, tegra264_pcie_icc_set() consequently derives the maximum speed and
> > width from unrelated bits and requests the wrong interconnect bandwidth.
> > 
> > Correct the Link Capabilities usage by adding a XTL_RC_PCIE_CAP definition
> > for the base of the PCIe Capability, using the existing PCI_EXP_LNKCAP
> > (0xc) and PCI_EXP_LNKSTA (0x12) offsets so they're easily searchable, and
> > reading the entire 32 bits of Link Capabilities.
> > 
> > Fixes: 01c3c27a0ef6 ("PCI: tegra264: Add Tegra264 support")
> > Based-on-patch-by: Linmao Li <lilinmao@kylinos.cn>
> > Link: https://lore.kernel.org/20260827093919.2825467-1-lilinmao@kylinos.cn
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> > 
> > This fixes a real bug, so I'd like to get this in pci/next for v7.4.  I
> > can't test this though, so need a review and test from somebody with the
> > hardware.
> > 
> >  drivers/pci/controller/pcie-tegra264.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> Sorry for the late reply, I had missed the patch you sent out. I've run
> this on the Jetson AGX Thor DevKit and it still boots fine, all the PCI
> devices show up:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>
> 
> Also, the offsets do match what the register documentation says, so:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Thanks, I added these to the commit.


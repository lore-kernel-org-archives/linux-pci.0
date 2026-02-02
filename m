Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA81AF0BB;
	Mon,  2 Feb 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038921; cv=none; b=u/t62byB37qApoo2K8z4u2H+rRWCsliLJOoJvRCuEr4JapSZK3pHJj22wJCvQBdjysUFDpcLl2UjLsOVG5HkAL1rX1IfBzNAhuXR+i26Kss6EXiu7mTBMnsgRQ9WOx8eVAfRybz2Z2H02cPDZYp4zRe7PqhaAypHKpv00Lrtgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038921; c=relaxed/simple;
	bh=GFzapZuD8RxuDYlO/l+ZDFdmFKCa++Q9O74XNv41dA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHdL0aNdnAra1HQEI8wr3d9il1S9eVSR0dwA/ZNnDw96Mvda6EOg/PIc7MhH6tQPjMsVdpJsf9wYg3byEXau1SI5p3GU2BO+E9OgWsdjwxy40Yz7qN5Xsb2nOSqQIJJmDRd04MbjM9SIpB49cylimUrjWxGHpYMe9PwVbi+ngus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaJqD/6k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaJqD/6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771F6C116C6;
	Mon,  2 Feb 2026 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770038920;
	bh=GFzapZuD8RxuDYlO/l+ZDFdmFKCa++Q9O74XNv41dA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaJqD/6kCwBLydXPU+4kV7xo4ubfjt3ivLCx1UQD1M0mSIYvGI50YD93ZyfLSrODF
	 J7NdvroqfRuWIkguAdzB1xHvWSKCcQS1bTHorA14v9dcynb6Jq97fkuu3+1F23XdJa
	 EEYA4GbdsHcYdsW4BV6D2wkSVT7LrWbwuONnLVxXeM8mrj5Kx//lrRivjm9cKEaX2I
	 oviw752uTuxf4iahnzOLNVEqLVh+Y+nfEKjNwUi5c9QmHLM4RhT1dzHqGdBZ72rCaH
	 OvGfDQr9wtJyz+eF9aWin7yGfpV9gr/FDTusNxlGJs5cclG26yaiD0gbGuXs8hGsnO
	 MGHs2Ek/4XMEA==
Date: Mon, 2 Feb 2026 18:58:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: ciprianmarian.costea@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: s32g: Fix ports parsing
Message-ID: <howlzhze3axqiguqvxslssc2tr7ocaa7l2obr4623n3piw5xee@ujnyo5bieril>
References: <20260202130756.1421488-1-vincent.guittot@linaro.org>
 <scnf5gh3h5pwvnbe4bwtztdlgcpvvtse4fg64bto2jgyotfpwl@sle4k4ky3gtu>
 <CAKfTPtBZCLiq0E-a2QA5X_Bix2PxXiCyuCira1V_wBWZORUS6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtBZCLiq0E-a2QA5X_Bix2PxXiCyuCira1V_wBWZORUS6A@mail.gmail.com>

On Mon, Feb 02, 2026 at 02:23:52PM +0100, Vincent Guittot wrote:
> On Mon, 2 Feb 2026 at 14:18, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Mon, Feb 02, 2026 at 02:07:56PM +0100, Vincent Guittot wrote:
> > > No error return is missing after the loop resulting in removing the
> > > ports from the list.
> > >
> > > Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (RC)")
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-nxp-s32g.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > index 47745749f75c..767f5a622441 100644
> > > --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > @@ -285,6 +285,8 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
> > >                       goto err_port;
> > >       }
> > >
> > > +     return 0;
> > > +
> >
> > Hmm. So the initial 'ret = -ENOENT' will become redundant and you'll return
> > success even if there are no Root Ports in DT.
> 
> good point.
> 
> >
> > You should do:
> >
> >         if (!of_get_available_child_count(dev->of_node))
> >                 return -ENOENT;
> 
> or maybe
> 
> +       if (!ret)
> +               return 0;
> 

That'll work too. For some reason, I initially thought it would be ugly, but it
doesn't :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

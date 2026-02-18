Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D318298CB2;
	Wed, 18 Feb 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423320; cv=none; b=p4SUUjtv2Dqc2hdiC8F4pcCl31X6hwOMCDs8OAzKknX/DVcVz72/Etf+PLdzR0rrPIi4U62yyoXybcj3/X4iN25e9iGn4LK0qtRB2EvV5AtDiMM9H7tK+rEn1o9IV4jJdzbY3EBVQH7l8xpxL1e8p2q5vyanCYZI2QmpgP2r8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423320; c=relaxed/simple;
	bh=fx9bawJGF/7v1S6sZ6uh1omgQZynGMw8ter1Kf4868o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4ToO+I+TO8aepVUiszLpFrmbuPJBn3Vtgs+e2I5qPo5UiIG1z9HiDbttvgTVE5q24HbjicI4rBzBWqkKxZz6E1F4Zx2flsigTSkOSG3zOl73TxoOskwHKW7mGBZ48cwx7eNDNSnvNFgtWEcNmyOV5DASUnDmim4KWOGIZVrJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it7tCvzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it7tCvzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A175BC19421;
	Wed, 18 Feb 2026 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771423319;
	bh=fx9bawJGF/7v1S6sZ6uh1omgQZynGMw8ter1Kf4868o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=it7tCvzAx7S2eAO0gECVpe4IfbG/6lhe1Xfy5LeCXMlURQKVf8UBb/+pYzxQwwkuF
	 hZbV1JfkBlbT5r37JXeJkWiQKtZJ85bcun1tv6uvcNyQuLDk1jPDSvbebe6HjhZLZI
	 deEl0Q7nc+i7C6gGrDckgRAGRTBcda0FXUousHdijgStmBltOeY/ctnb6w7MBY8Hrt
	 tHU/8klcnlBGzWqPNYxL3Y/Fj41PWbkUBT98EoSvWruWusmxC2YU99hhIJK0DOlASO
	 nsDFpvlNzgyHZJF8uwGjIUN0YEBMnroKUCOzxkQ6XZemWJvZOlqcKfxRkalZPAiC34
	 5RmZ8T+TKyOmQ==
Date: Wed, 18 Feb 2026 19:31:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on
 mws_size[] access
Message-ID: <5k5u7q52fjizewleteru2tz7g7yqyq4ycik66aenw3xrdpo6ea@jm5mfjb44bre>
References: <20260105075606.1253697-1-den@valinux.co.jp>
 <n7griejk7mlutc5mdi6b3ysedn2dgcius43urhxnfohjeo32fc@d5gymxxhrutw>
 <zyaurygtzi4qapq3n4lfcae7uahqumvdni5ojwcexpx2rbmbde@rzol5arwg7l2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zyaurygtzi4qapq3n4lfcae7uahqumvdni5ojwcexpx2rbmbde@rzol5arwg7l2>

On Wed, Feb 18, 2026 at 01:47:33PM +0900, Koichiro Den wrote:
> On Tue, Feb 17, 2026 at 07:20:23PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 05, 2026 at 04:56:06PM +0900, Koichiro Den wrote:
> > > Follow common kernel idioms for indices derived from configfs attributes
> > > and suppress Smatch warnings:
> > > 
> > >   epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
> > >   epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]
> > > 
> > > Also fix the error message for out-of-range MW indices and %lld format
> > > for unsigned values.
> > > 
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > > Base: https://github.com/jonmason/ntb/commit/68113d260674 (ntb-next)
> > > This is a spin-off patch from the following series:
> > > https://lore.kernel.org/all/20251217151609.3162665-2-den@valinux.co.jp/
> > > 
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 +++++++++++--------
> > >  1 file changed, 14 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 83e9ab10f9c4..192dd4f4de8d 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -876,17 +876,19 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
> > >  	struct config_group *group = to_config_group(item);		\
> > >  	struct epf_ntb *ntb = to_epf_ntb(group);			\
> > >  	struct device *dev = &ntb->epf->dev;				\
> > > -	int win_no;							\
> > > +	int win_no, idx;						\
> > >  									\
> > >  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
> > >  		return -EINVAL;						\
> > >  									\
> > > -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> > > -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > > +	idx = win_no - 1;						\
> > > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > > +			win_no, ntb->num_mws);				\
> > >  		return -EINVAL;						\
> > 
> > This should be -ERANGE, but in a separate patch.
> > 
> > >  	}								\
> > > -									\
> > > -	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
> > > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > > +	return sprintf(page, "%llu\n", ntb->mws_size[idx]);		\
> > >  }
> > >  
> > >  #define EPF_NTB_MW_W(_name)						\
> > > @@ -896,7 +898,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> > >  	struct config_group *group = to_config_group(item);		\
> > >  	struct epf_ntb *ntb = to_epf_ntb(group);			\
> > >  	struct device *dev = &ntb->epf->dev;				\
> > > -	int win_no;							\
> > > +	int win_no, idx;						\
> > >  	u64 val;							\
> > >  	int ret;							\
> > >  									\
> > > @@ -907,12 +909,14 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> > >  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
> > >  		return -EINVAL;						\
> > >  									\
> > > -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> > > -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > > +	idx = win_no - 1;						\
> > > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > > +			win_no, ntb->num_mws);				\
> > >  		return -EINVAL;						\
> > 
> > Same here.
> > 
> > - Mani
> 
> Thanks for the comment. I will send a separate patch for that.
> 
> Before doing so, I have a quick question regarding the routing of pci-epf-vntb
> patches.
> 
> Commit e4fe2a2fc423 ("MAINTAINERS: add PCI Endpoint NTB drivers to NTB files")
> places pci-epf-vntb under the NTB subsystem. However, I'm not entirely sure
> which tree (NTB or PCI EP) is expected to take changes to pci-epf-vntb.
> 
> Should updates be based on the NTB tree or the PCI EP tree?

There is no specific entry for the VNTB driver and we usually pick this driver
patches through the PCI tree. Initially this driver patches went through NTB
tree, but that got changed long back.

> Sorry if this has already been clarified and I just overlooked it.
> 

No worries.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

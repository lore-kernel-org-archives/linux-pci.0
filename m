Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BAF318B92;
	Mon,  9 Feb 2026 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636938; cv=none; b=fNMvpLU90yY9Cf7/X61/OyizBnAPc6Vz4SDxZp9+QUkFJ2KAnel+VGuSF5hFRo0eubJtawRp8hcLTZ2zMyGUiEkTP9sDdmSQ1jbsiGWKY7D+lygpDP5MTYXFxyePHTbOiYgh0Mi6GcSok8vv61Ukp+HcWBqADOB3sA4TZCo7gcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636938; c=relaxed/simple;
	bh=bwgsJsBgS327LLJQnYRB/5b25RtRD7UBzxz5b/BD1c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXaVUFSVPGG2DkMYtkRvmHWLDhtBosgSKaSi531DBS7RJPYLtQufgROKIHUMbRYuT4v6n9NbTp9p0XI8nxVL3SPEcSqj2EkwFI2gCTipIG7RlrdVQNeMJoz6YS7XpTzuoPpa0NS3zDnu65qYlVwxNV6TL90TVnoGgNyEa215GBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5R4WzHy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5R4WzHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAEBC116C6;
	Mon,  9 Feb 2026 11:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770636938;
	bh=bwgsJsBgS327LLJQnYRB/5b25RtRD7UBzxz5b/BD1c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5R4WzHyld5bm0v+Kep4muSPKwKjGly94mUl9A8Fuhd6dFoOCXej2xB9z0hzuJZR+
	 DYl98LN1QtT88okD0+Iluk0tglK5/4j+vkQuvCsy6sMcEVGLuh0gjdsGHra1lYbbSZ
	 7mWbiRAmR+y3d1NQKR82l3bn9Uywv3unIZoXFulYjXg04pIc6IlLWARGD9+GryFb63
	 KVQleVgoqFtFS/uselWRJmNOYvm8A4MpkW1ryjqH0E5MK866AyzpOZzjNDnwrqSmTl
	 f0TWzsJtTUy4B5IroFXwgoVPfvplwEJ5ABJ1TOhA0FvbaQrcDaIK/8E0WsZ42350+P
	 L+JEMJL8GOUag==
Date: Mon, 9 Feb 2026 17:05:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: cassel@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	robh@kernel.org, Frank.Li@nxp.com, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: dwc: ep: Fix BAR update handling with
 in-place epf_bar reuse
Message-ID: <jovr3iwtwtcbalzm2zklhe7gmvk2edao57a67oh3shf5lsdnfs@5qohmaxx5zlj>
References: <20260202145407.503348-1-den@valinux.co.jp>
 <vgqd74pmc6av25d2zy6alfm26sjir5nyhxjisisebuawpeqcor@gjxevxzjnbbe>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vgqd74pmc6av25d2zy6alfm26sjir5nyhxjisisebuawpeqcor@gjxevxzjnbbe>

On Mon, Feb 09, 2026 at 02:40:13PM +0900, Koichiro Den wrote:
> On Mon, Feb 02, 2026 at 11:54:05PM +0900, Koichiro Den wrote:
> > Hi,
> > 
> > This patch series is a follow-up to a side discussion that started from
> > Niklas' comment at:
> > https://lore.kernel.org/all/aXtrW7viGZfMNZur@ryzen/
> > 
> > This series:
> >   1) Makes BAR Match vs Address Match teardown in DesignWare EP explicit
> >      by returning right after clearing a BAR-match inbound mapping.
> >   2) Fixes the dw_pcie_ep_set_bar() mapping-update path to run
> >      dw_pcie_ep_clear_ib_maps() unconditionally, since the driver cannot
> >      reliably distinguish BAR Match -> BAR Match from Address Match ->
> >      BAR Match transitions when the same epf_bar instance is updated in
> >      place and passed in again.
> > 
> > Base: controller/dwc branch, latest:
> > commit a24149881558 ("PCI: dwc: ep: Add comment explaining controller level
> >                       PTM access in multi PF setup")
> > 
> > Changes since v1:
> >   - Switched from the v1 approach (Y) to the alternative approach (X)
> >     that was proposed earlier in the discussion.
> >     Details of the v1 (Y) vs v2 (X) are described at:
> >     https://lore.kernel.org/all/sextbnbmsur2xjfoun2l4lr5vekmpzae7sx6or2ird44t6ud6d@yprcz43tpq4p/
> >   - Changed the subject.
> > 
> > v1: https://lore.kernel.org/all/20260131133655.218018-1-den@valinux.co.jp/
> > 
> > Thanks,
> 
> Hi Mani,
> 
> Just following up on this series.
> If this looks fine to you, would you mind picking it up when you have a
> chance?
> (Niklas has also commented here: https://lore.kernel.org/all/aYSZxCtACmQyC0XT@ryzen/)
> 

Sorry, I cannot get this series for 7.0 as it is too late. I'll try to get it
early once 7.0-rc1 is released.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

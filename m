Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECD2E9730;
	Thu, 19 Feb 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530238; cv=none; b=gDkYltjRVuapyrNedUSmLzjT4JTbWX1u5HDgKzMQS8I+vHw7nryOgXtG3kq7kwM99/fn+7DZnKhuy5gHlXmajazoCSZF+UqztutPs25IDOYBaPQ4sjRYkC78A+x7y5WSHGv/YTp/3I3z6sFi61V+gl/i1qqWBRYy80RaykrkpvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530238; c=relaxed/simple;
	bh=6Zi+b+S1zCO87ezncKW+PPN/mC8x9HdKkxAmqP77XqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nbeweeg67lxeIDPR9vhPac04qvOMkHB73nduWVMuxhp1JeHwAPHWlAVJX8cK+aJNRqmLPYw4xjUQrF+49Crx+yJoKcXFJIOQiUDoGhUeHGqdBDdCZ/uJ3R+LgRUAg++rUJKwYqGM+xUuP11nAbzWyyPoLbKe2IDmO0uwvDPU6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVV039/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVV039/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CBBC19423;
	Thu, 19 Feb 2026 19:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771530238;
	bh=6Zi+b+S1zCO87ezncKW+PPN/mC8x9HdKkxAmqP77XqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hVV039/rbErdHfciVDT2Bh9sicrhdSiVTYZTMpCI6/zLUv0Njabh2lSTX9pR/VhAN
	 UWQf+BQaqfzgp7HpwBvuT3+a+fo51dw7LWpvnEbmqLWke05As1/ACBNWwkA2sYobqG
	 MzUnjB9DRUFY/inlqbcFsQPE0euHgDOxtTQsU7ri+sxpEttzgA4minQ1aF8nVAnHRR
	 CmRZL9U7zFSQ+3cnaq8B9LgQgGIjyDHkgsRafAOopMeVgtbAtkuc7b3IqkJRrN289B
	 gPh4ZQ/gnReIg+huEBWsuGVML9rLJiEfI5Zw6Z8JGtAG1NTMY7TJiLMKrCFtigBMLH
	 Nefisx08CofZA==
Date: Thu, 19 Feb 2026 13:43:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, cassel@kernel.org, kwilczynski@kernel.org,
	kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: dwc: ep: Fix BAR update handling with
 in-place epf_bar reuse
Message-ID: <20260219194356.GA3493507@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202145407.503348-1-den@valinux.co.jp>

On Mon, Feb 02, 2026 at 11:54:05PM +0900, Koichiro Den wrote:
> Hi,
> 
> This patch series is a follow-up to a side discussion that started from
> Niklas' comment at:
> https://lore.kernel.org/all/aXtrW7viGZfMNZur@ryzen/
> 
> This series:
>   1) Makes BAR Match vs Address Match teardown in DesignWare EP explicit
>      by returning right after clearing a BAR-match inbound mapping.
>   2) Fixes the dw_pcie_ep_set_bar() mapping-update path to run
>      dw_pcie_ep_clear_ib_maps() unconditionally, since the driver cannot
>      reliably distinguish BAR Match -> BAR Match from Address Match ->
>      BAR Match transitions when the same epf_bar instance is updated in
>      place and passed in again.
> 
> Base: controller/dwc branch, latest:
> commit a24149881558 ("PCI: dwc: ep: Add comment explaining controller level
>                       PTM access in multi PF setup")
> 
> Changes since v1:
>   - Switched from the v1 approach (Y) to the alternative approach (X)
>     that was proposed earlier in the discussion.
>     Details of the v1 (Y) vs v2 (X) are described at:
>     https://lore.kernel.org/all/sextbnbmsur2xjfoun2l4lr5vekmpzae7sx6or2ird44t6ud6d@yprcz43tpq4p/
>   - Changed the subject.
> 
> v1: https://lore.kernel.org/all/20260131133655.218018-1-den@valinux.co.jp/
> 
> Thanks,
> 
> 
> Koichiro Den (2):
>   PCI: dwc: ep: Return after clearing BAR-match inbound mapping
>   PCI: dwc: ep: Always clear IB maps on BAR update
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Since this fixes an issue with the new inbound submapping feature
we merged for v7.0, I put both of these on pci/for-linus for v7.0.

Thanks!

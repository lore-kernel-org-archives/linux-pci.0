Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA01EEB3;
	Fri, 20 Feb 2026 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603364; cv=none; b=beqyWgkgrE7P2tFy0S1Z1zI1DQSSZvs1M/pZEFgLk1WMgqk0mYALqMFdR4OobL5kXb7Q6O9mt1NKjSO3oC36o57hej+b6msohnJ1YGZ0ES9EpiG+K5zEtSWgc2/K/N0xcM7i8F8Ef/c3HHfYFoPlEJeR12X55IB2YhvmUXd0+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603364; c=relaxed/simple;
	bh=z4D+rjzLJrvwt0j/2rwSKMKLetwvyNgn3D4AF3jSF3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMgH3IT7LlCDdw+M7YBfA52YdwpE6r8VOk+kGmKeXmBdEW8mTMTrqt0NMsUohKaS15W8p8wNUiF96hBEJGb7F4S312qsB4pnJNbaqeAg8+dK4VQsWrgCKKDK+BSGIC0G/bwALFCTL+B7de+u1ECfByDXFBeJq1OKl9Kv9CO+5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FylfdZxd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FylfdZxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F00C116C6;
	Fri, 20 Feb 2026 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771603363;
	bh=z4D+rjzLJrvwt0j/2rwSKMKLetwvyNgn3D4AF3jSF3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FylfdZxdLXBY7qyGKhqDRXMw54lgOgtn6y21jEneuqC+xt06MRS2lPSL8lpj5MW5M
	 9j48zIHlBLIQPTrQmtEanumn3wzAXyNITXQn93TSx8EvX95TIzCGkZC8AyxXCtWJXI
	 Tr/VuDd5ZqcEcrEq1hZhJjJYmUfxoNSiFaAhIgLwj8HTGHIFlQF86tGfkWzr0lC+ZT
	 E/QIlFvQ2otdenJnyqJF4W+frOt+MI95KOHDv6VYd1BwSx35XO3PNhKFlb77v3ZEjc
	 yFNOwckQQsWuhVNfm2PKK5vtnemz5LCEZObpE8jjy+ttlQY4xH7IgzIdLxMB96RP6H
	 1+YDYxp8pIpGQ==
Date: Fri, 20 Feb 2026 17:02:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	corbet@lwn.net, jingoohan1@gmail.com, lpieralisi@kernel.org,
	robh@kernel.org, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: dwc: ep: Fix BAR update handling with
 in-place epf_bar reuse
Message-ID: <aZiFe6Pl-LI0fIVg@ryzen>
References: <20260202145407.503348-1-den@valinux.co.jp>
 <20260219194356.GA3493507@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219194356.GA3493507@bhelgaas>

On Thu, Feb 19, 2026 at 01:43:56PM -0600, Bjorn Helgaas wrote:
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
> > 
> > 
> > Koichiro Den (2):
> >   PCI: dwc: ep: Return after clearing BAR-match inbound mapping
> >   PCI: dwc: ep: Always clear IB maps on BAR update
> > 
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> Since this fixes an issue with the new inbound submapping feature
> we merged for v7.0, I put both of these on pci/for-linus for v7.0.

Thank you Bjorn!

If possible, I please consider sending these to Linus as well:
https://patchwork.kernel.org/project/linux-pci/patch/20260210181225.3926165-2-cassel@kernel.org/

The Fixes tag:
Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
references a commit that was included in v7.0 merge window, so it would be
nice to have the above fix patch in v7.0.



This is fixing the same problem as 8719c64e76bf ("PCI: dwc: ep: Cache MSI
outbound iATU mapping") fixed for dw_pcie_ep_raise_msi_irq():
https://patchwork.kernel.org/project/linux-pci/patch/20260211175540.105677-2-cassel@kernel.org/

Mani has marked this commit as "Awaiting Upstream", I'm guessing he plans
to queue it for v7.1 ?
If not to much trouble, I think it would be nice to have in v7.0 as well,
so we have both functional dw_pcie_ep_raise_msi_irq() and
dw_pcie_ep_raise_msix_irq() in v7.0.


Kind regards,
Niklas

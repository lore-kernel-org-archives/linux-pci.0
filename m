Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7563769EB;
	Fri, 17 Jul 2026 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268643; cv=none; b=P0My4dmY44pJQqmfgC5jIWbb2gPI+4AQXNhrwSzeY7ImMuequKPkn6qN6I2loRxw44YT6wKCYsz2ArB2CymAUkKCW53BU3ZiHIKuyMkMvq1sbLOJN+3KrbIvur3e7yvOYKPuHE9lNNuWJiPDsX4NHvokoxsHCRXqUM5vwhCRYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268643; c=relaxed/simple;
	bh=NOjBH6TiLZaAd8Bpm0CQcX2SOsabmYVo0xuvJq923CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYzqhs2FRWQeygeLVIZVnVj6aYhhJ5ujHkp55TSL8O202e5J2S09SQhrON+8RIwb7qddXeXizavxOvjBQot3iP88IlgCVCOlOCKWUy5dacbLYQlhjnhh8MvJkJQW+sRl8pCQZbFzceKxaUBNErnwiLdu+jkxnXBLybxqKxoecyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=hk4lwR1C; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="hk4lwR1C"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 5A7A71FB8A;
	Fri, 17 Jul 2026 08:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784268631;
	bh=MYfIiTljvUdNCRakllw3Wd86kd4UG5DQ4bHXp1kZS0o=; h=From:To:Subject;
	b=hk4lwR1CZ6JKHAz0z8HOasZPFaSinvtuTwX7pFtN44+cOF4LecRE00r1TcxgaUWLZ
	 MgfS8djpkpTGqBMMr/HLRBFlNiVoA4VcM76YAEMs66Y9G1OhpsNHCjbmbI2X16sdD9
	 KqqX0NUZIqEkE+DQzbGorLWzXhPz5ufx/L+EuvNlhN6dAkPHRdGmRZvzsm1qDNo1dy
	 f1z/Nww6QxgEsaudJoFkzuJRDbZpYEvrEG6jrPhr+7dlZkALaKgMNGIWKiKC0vrF4k
	 F57rZ+MP5O47KU/cuELfIBDeSUAl/fdDmxZoCDJGbpX76XTeJrVE/HqpqRqxcyLMIS
	 UbzhjI4QsNslA==
Date: Fri, 17 Jul 2026 08:10:24 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Leonardo Costa <leoreis.costa@gmail.com>, bhelgaas@google.com
Cc: hongxing.zhu@oss.nxp.com, frank.li@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
	leonardo.costa@toradex.com
Subject: Re: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Message-ID: <20260717061024.GA362793@francesco-nb>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>
 <blkjlbskmfiyprh6wlbfilwlgjw3zkbslh6fpogcc5vcfu5dvn@hcrojgleuxob>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <blkjlbskmfiyprh6wlbfilwlgjw3zkbslh6fpogcc5vcfu5dvn@hcrojgleuxob>



On Thu, Jul 16, 2026 at 11:43:31AM -0300, Leonardo Costa wrote:
> On Wed, Jul 08, 2026 at 11:59:27AM +0800, hongxing.zhu@oss.nxp.com wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> > introduced a boot hang on i.MX6Q/DL variants by changing the initialization
> > sequence.
> > 
> > The issue stems from coupling PHY power (TEST_PD) and reference clock
> > (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
> > managed together, the timing between PHY power-up and reference clock
> > enablement cannot be properly controlled, leading to initialization
> > failures.
> > 
> > Fix this by separating the two concerns:
> > 
> > - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
> >   logically belongs with reset operations. This ensures PHY power state
> >   is managed as part of the core reset sequence.
> > 
> > - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
> >   shared PHY power management, avoiding code duplication.
> > 
> > - Make imx6q_pcie_enable_ref_clk() responsible only for reference clock
> >   (REF_CLK_EN) control, simplifying its purpose.
> > 
> > - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() as
> >   proper sequencing is now handled by the core_reset functions.
> > 
> > This refactoring ensures PHY power is controlled during reset
> > operations, fixing the boot hang while improving code maintainability.
> > 
> > Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> 
> Tested-by: Leonardo Costa <leonardo.costa@toradex.com>

Reported-by: Leonardo Costa <leoreis.costa@gmail.com>
Closes: https://lore.kernel.org/lkml/20260629143439.361560-1-leoreis.costa@gmail.com/

Bjorn: this should solve the concerns your questions from https://lore.kernel.org/lkml/20260716172858.GA111215@bhelgaas/

Francesco


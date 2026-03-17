Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978EC35F163;
	Tue, 17 Mar 2026 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744370; cv=none; b=l4tfWq3ts/LPtB/93qdqx/Y8nGu5AEKZ2U7wjYdixiIFLERPHOsOPwGOvPPdPanR3CBdQ73cEes8JAoKfLZrcAuQu1U6s9qkTtYm5G5va3iXqHbgQXrYObAQuSab2wd62JJRX0JRCPRpyWBuZM8oASD7y06VGTTqMtsPFfxscbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744370; c=relaxed/simple;
	bh=JD63vAdCzBYCpM+ipHsYPD9g60OGvA/tqi7QH0SjU0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK/bABug3JrsIZI7SY8qSvYX78Z999exowTaCfVl8u11J3czkCRx5Jemqle91jzM1moIV+XXR/yJguuPOkxvXwGc7Ptp3Qr2IIfitSleIufLnLXdTMxzZhfUUmHCggYDmDnLdvThTme/nAeJSTwIjgcrglVV2FothKde+sliJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtKPgkta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtKPgkta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28F2C4CEF7;
	Tue, 17 Mar 2026 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773744370;
	bh=JD63vAdCzBYCpM+ipHsYPD9g60OGvA/tqi7QH0SjU0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtKPgktaU6BMub4OPZ6P1oHYA4QTfJ1g2rXKSTKVq6pacqgf+N5R5M49rGeGex/Uk
	 sulCv5Cc8PxGoPFBb8aR04RDs11furevKhvNd8kgnL6VE2Ov28B6jvkGCkOJuCICKH
	 Y2EKaRXRY5S6phfs69b8tic+i/3PLYkwLLgT8/Ya4D+QAS5MBjB1LyO2N/1MnTZGlv
	 KueED67xQZz48rYJ/+BsnRbZ1xQb3t05sS6U5h9sNusI9a63Pv1h6Uxlm7iQE1adgg
	 g48T0m1xpjIrcv4eT3yKyjnVTyzo1IsSu51I+oaIipfPL6JTLOT/i5xLHl1w4HnZMZ
	 oE2x+M8AORumA==
Date: Tue, 17 Mar 2026 11:46:03 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Koichiro Den <den@valinux.co.jp>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <abkw5dltSWVThJYA@ryzen>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
 <abkdu_7n_lePaTIY@ryzen>
 <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
 <c9278648-1ec1-419e-89ee-0868a4c7c86d@foss.st.com>
 <abkpFpD3cM_cI_nB@ryzen>
 <ee9b1b8e-4bc8-4fd3-932e-9b944516e114@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9b1b8e-4bc8-4fd3-932e-9b944516e114@foss.st.com>

On Tue, Mar 17, 2026 at 11:29:41AM +0100, Christian Bruel wrote:
> 
> 
> On 3/17/26 11:12, Niklas Cassel wrote:
> > On Tue, Mar 17, 2026 at 11:01:28AM +0100, Christian Bruel wrote:
> > > 
> > > 
> > > > 
> > > > So we will need to add a SKIP ENOSPC case in TEST_F(pci_ep_bar,
> > > > BAR_SUBRANGE_TEST)
> > > > 
> > > Re-checking this, no need for ENOSPC test. The real condition would be
> > > EBUSY. Which can be handled nicely in a stm32 ep_map_addr helper.
> > 
> > Are you sure that it returns EBUSY and not ENOSPC?
> > 
> > I would have expected the error to be ENOSPC when there are no free inbound
> > window:
> > https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/pci/controller/dwc/pcie-designware-ep.c#L307-L312
> 
> dw_pcie_ep_ib_atu_addr() returns ENOSPC. I was thinking to overload .set_bar
> with a stm32 helper to return EBUSY if the subrange bar is already reserved.
> 
> So whatever is best
>  - modify TEST_F to SKIP if ENOSPC
> or
>  - Add a specific platform .set_bar helper to return EBUSY, already handled
> in the test.

I think "modify TEST_F to SKIP if ENOSPC",
since it will solve the problem for all platforms that have few inbound iATUs.


Kind regards,
Niklas

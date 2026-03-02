Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4C3FB066;
	Mon,  2 Mar 2026 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460475; cv=none; b=TFPdmPvRi+/r6uMDNfFStI9/afUG3cpXSx6H8dE2ZEE0CGBwzC+ib5OXWhvwA2YejN/7DXH0xbO9RPdEzM9ooYhuCN5wsudKXQG3TPyX3fbvmP7UwnAqFac73i6A4VSP0K4X87EbK7/hbJ1LMgNiepqeBb4ris5RzBF4cjI/Vzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460475; c=relaxed/simple;
	bh=vD8+bQGn++3k8j5RstxGmZUJbjlWA/5OwYaBluChDRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krH9M7CSj9dAMcKiviYUjdFsyalip4amSvT+dSYfKw1aBemH+a3+h0zQvDrYTcB62VMoJsHr+VNPw03tp/dpfbL7g2F8fMmWIu4as8eGAA5bZRLuWWucoQ1bt2G6XgI4Z1tpmxmO8y1FjB/37WdzrnEUAA8YPMSIND3VBGDxLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewKpEkkv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewKpEkkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C80C19423;
	Mon,  2 Mar 2026 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460475;
	bh=vD8+bQGn++3k8j5RstxGmZUJbjlWA/5OwYaBluChDRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewKpEkkvlq8SW+YOc12UTykJPz3NerkW3D1I2XXvqlNt6eP7+3j9tdu9Q/c9S1lxi
	 IRKQskX/2fsF6rIrrR4qGIEPwqg+ZAl30mSGtMEn2aSCcG61WEMh6dwzzpPfLMTsGL
	 U0jlz2vJOCZtzutygQMikAz3bKuobBcl7mjCIGoOp6R4rcNJJDT4haUvnxAFn1ynyM
	 AfPXRXPAnzUOzIWx7sL1+xiB1/BjXym0C+HzZyqycHMALZhRiRtz2eTVLwwwqQlm/M
	 0SU3Wrix1OSgN+qALOhMPIvCfa5jUJAddKuiaiVCrHFVph+psEZ94IiKukhvi6idmd
	 JVyD3+5TNOJ2g==
Date: Mon, 2 Mar 2026 19:37:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/1] PCI: dwc: Remove not-going-to-be-supported code
 for Baikal SoC
Message-ID: <arw5dclubv4overootx6oouf6sdk5xgezm6ogegef2obab3ial@3ci7cwkmkk4x>
References: <20260220142600.2397070-1-andriy.shevchenko@linux.intel.com>
 <ndzk3mcrkymcf3ru7my6om6llkbc6w4paxmgyqab4b46txxjr7@2upwgzrnlu7s>
 <aaWXWka5GpHEBjD3@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaWXWka5GpHEBjD3@ashevche-desk.local>

On Mon, Mar 02, 2026 at 03:57:46PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 02, 2026 at 07:21:22PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Feb 20, 2026 at 03:21:12PM +0100, Andy Shevchenko wrote:
> > > As noticed in the discussion [1] the Baikal SoC and platforms
> > > are not going to be finalized, hence remove stale code.
> > > 
> > > Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > I see Arnd's comment in the above thread:
> > 
> > "I don't think we'll merge the rest of Baikal, we should probably
> > remove the entire platform."
> > 
> > But is there more to the story?
> 
> The Baikal enterprise is Russian entity under OFAC sanctions.
> 

Yeah, I knew that part, but didn't know that we decided to remove the platform
altogether. But I can see patches floating around for other subsystems and
getting applied, so I will do that same for these PCI host controller patches.
Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

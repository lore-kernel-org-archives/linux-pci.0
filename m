Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730852;
	b=dsiPuWqsISp8Ui1+phdOJf0nIkrGW5X2hiSzLO8aR+PBS//bDKU6IBsn8s8QIJ1gzi4H
	 yorZJIN+uvzXuqJkXwC8FpdbT3NO3/QN68/Y25jT6Des41bUF6AOpIi6U2jhkAfO+naYR
	 MHOrCuKwRbRvMRZhaUgIxY6kAmukxVRPyfw+J2Qq5w8/bKirw2RvYWQ+D1ThnhuBwM8vM
	 J7RmEUsjnIMvq5STEvA9lBIggJRE2FJOzoFY7my8PKmRpe0X2YjIHfBmigWJnmZecILqi
	 0zy2BolNWcvBPMSzocQOEVTUAMC3J0Cl1eNXj3mOLuMrrguKyKuK0S+Nq//OxQv7Twg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730852;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SwOp5tKUgP3iAuwIT0Y0Mo0z66LqzYDoz79jPciORRU=;
	b=AXoTEremC3fLW0+PEovCYwD8+WAVEnCCsRo6CppCpFqX4hfbKx4+l+qEFN8PjEl5709V
	 y5LEjudqeboZmWsmg3tPeWp0qgk3Jl40LvwlUlhnip+ZAgGCQT7M5rKQHpX02wVsm5uB9
	 C7B4YwAo1HiCKlIsWdsWcPhuV5gxWMyy4CDXHqz5QgzoGhU82X7cjBB21uaXXTFYMWDkK
	 DpUgUuiuIDda7TwZYsbaNjh3D7mPcml4fkHKytXovUWTdRiqVabetAdLPgk0Aew95wWum
	 jTZIYcbvMli4u5e7HvD/a2QA6M/iDZJgkdsTpeXEaaGYzPaWFWsLe7dg3V24PLiJtKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDN6mTbo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2F606A31B;
	Tue,  3 Nov 2026 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDN6mTbo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969DA1F000C1;
	Tue,  3 Nov 2026 18:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730851;
	bh=SwOp5tKUgP3iAuwIT0Y0Mo0z66LqzYDoz79jPciORRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=TDN6mTboBE2J9brUHlxu9/Nmy1RD9PIGd/dBjb3Bm+3g6FE7fh02izuAimlGyg8zF
	 O6KcgO3w2W3DcMVIojxf6s4gry94wnlGwQpcIuqgataU3oQWggz9dmkSfKUYrLTuol
	 qZiACnWVzgjA/UYeyVLFXU2SqiqKxzaDUN7Ytfv2UjNKz8beW5xgFdBnSg1KVSJqYx
	 LBRk4CIQWEc6cGsUfzbGlFY83tfv9AArm/feJdT+drktQx/eQl5Aw8uHENHkl7wvxI
	 VoeNN73RhjIbMnsRD7v0zPMt4URri38ThqxXGgDdqVXquHrFKyLi9deAKOBgHMb3WJ
	 RacXEHxanlfOw==
Date: Tue, 3 Nov 2026 12:34:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>
Subject: Re: [PATCH 0/2] More switchtec device IDs
Message-ID: <20261103183410.GA1124818@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103175208.481170-1-logang@deltatee.com>

On Tue, Nov 03, 2026 at 11:52:06AM -0600, Logan Gunthorpe wrote:
> These patches add some missing device IDs to the PCI quirk and the
> dmaengine driver. The same device ID was added to the main PCI driver
> back in commit 5e6c21c56998 ("PCI: switchtec: Add Gen6 Device IDs").
> 
> As, like last time, these patches touch both the PCI and
> the dmaengine tree so I'll humbly suggest that they
> go through the PCI tree again.
> 
> This is a quick resend after Sashiko found a bunch more missing IDs
> that I've added to the quirks patch.
> 
> Thanks,
> 
> Logan
> 
> Changes since v1:
>   * Add the rest of the Gen6 device IDs to the quirk so it
>     matches the switchtec driver's ID table (per Sashiko)
> 
> Logan Gunthorpe (2):
>   dmaengine: switchtec-dma: Add Gen6 secure device IDs
>   PCI: switchtec: Add Gen6 switches to NTB DMA alias quirk
> 
>  drivers/dma/switchtec_dma.c |  4 ++++
>  drivers/pci/quirks.c        | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)

Replaced v1 with these patches, thanks!

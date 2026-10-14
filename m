Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA78558210;
	Wed, 14 Oct 2026 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998083; cv=none; b=FzsQuUgz5ferg5TKrxusmzGfXzIH0yIE7L9N/24+sgZXrfDCaWNh/1xA0vjSlQK+1iKO4N0Ud5EJaRgKdO2nvOKwsYEgByyH1kHndShrnPk18tVzM4M1fiE09AKIxsAsLL9EA30PDtIHXGiB2meqx3IIWXQm0fmqEXQoRN/718k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998083; c=relaxed/simple;
	bh=GBCkDQ8AL+02BcVG2P+qW6AdE9bXqfUUzCHasNvZcG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsqktzhaLox5pyC40gDQD/jQ7qZYjgRwzpnjpbZw4TJIUT8Z+NqChjZZ7Rk18gS1VnzY5x69tVCowr3ZH5sqZyQQE9flsHBfGcBhiKUPCUhrR1JCtsR/3lbik8aVClpfxwtm3XpjqwqTuRGHgJdmTrxt6kFZqGpMbDvQn7k9Yd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFXwJ7/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFXwJ7/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C69C1F000C4;
	Wed, 14 Oct 2026 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998081;
	bh=UosP9kkTOML1KxzD7EFqS7558a32ne/l8IFRfCNRGiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KFXwJ7/ehAnJv2ToopZ+B2JhcwuPBVgwHg5Dyk/uBfrcUGwdKvwkcf/6cYQD8uGFq
	 Svifn6lX8osqJc1EIsr+B8HROp85/HpYh9wvwpVfBJmv2/upLNGzta4iWJzlYjUtun
	 GXjxcrMi0p89AHznPmXBAXOro2wsXG04asxdomZeUS4mZ4pjBeY8gmxMUI1RpU/DcJ
	 rg0c5YKSl5/SmcDsLYaGG1lMBqN1ZiKiR5kA9kZNFNrnE3Q3/0Vtbn/WhNdaQG0f3I
	 9dBXbHJZHi0nAr7oh11Di3B3eEiwO6Wa9DENGIfD9gFxVIKFQHYuM3ePcbqMCnzw+g
	 lzrDCJRTd65gg==
Date: Wed, 14 Oct 2026 22:44:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 00/13] PCI: brcmstb: Stop using chip numbers for
 conditions
Message-ID: <as-4akoLT9L2c086@debian>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <179197952602.38040.4438252459530233972.b4-ty@b4>
 <CA+-6iNwE935j4wn4BWxs+t1qh3iRtWb0xNjZ-hRS0j-tkLx8=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwE935j4wn4BWxs+t1qh3iRtWb0xNjZ-hRS0j-tkLx8=w@mail.gmail.com>

On Wed, Oct 14, 2026 at 10:45:32AM -0400, Jim Quinlan wrote:
> On Wed, Oct 14, 2026 at 8:05 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> >
> > On Fri, 11 Sep 2026 19:35:25 -0400, Jim Quinlan wrote:
> > > PCI: brcmstb: Stop using chip numbers for conditions
> > >
> > > Much of the brcmstb PCIe driver code does (essentially) this:
> > >
> > >         if (pcie->chip == 0x1234 || pcie->chip == 0x5678) {
> > >                 /* ... */
> > >         }
> > >
> > > [...]
> >
> > Applied, thanks!
> 
> Hi Manivannan,
> 
> I apologize for not submitting a V2 promptly -- I thought that only
> Sashiko was waiting for me :-).
> I have a V2 series, where 10 V1 commits are unchanged, 3 are modified,
> and 5 are new.
> Shall I submit the changed/new commits in a new series since you have
> applied V1?
> 

Yeah, please do!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7D490BE1
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161853; cv=none; b=e5c5OEpMOCsaZdzA1rqO5DPXAN+N+rTxSjrheAjH/hkpUzCM58k5U808ofV3o//fgM/OTdkQkbQtlYB1jZe9tsAXUL8tsNtoUqnnRj4TzguTUJsjO0xJbKgFSWYUStQRqxzc4VKKMi6kfm461IUtOxX6NTQnovEnkM+n1p3anMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161853; c=relaxed/simple;
	bh=3qk5+53u5Rqh4bjWWHOUzKNhKYqimYsD3kKP9t91H+0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QkGnMmV0N9qCda2AciNNsJzRqcJ1uPu8ZZrKEPKgMLWsGZWPow7xZYJiy1QNkuphbANG/97HyqfNKb5E5H26jipoZHc49C12iqbkLXv7tY3CXV4sTVs0lGBE0sLl0BFwSAw4m4wvSpXcVaEtZT/lHa9d1JJJzdTGBagXl081zs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHn10mLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHn10mLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EA31F000E9;
	Wed, 19 Aug 2026 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787161848;
	bh=WwIcHAM4oB99mDCmGj/aGFjb0K+AMmxxpadgk9A6Gv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DHn10mLiDsrolpqyANM0XCH0KHMKIP+kglya8LkDziJXkGX3x3QwHi+S0okf7jZ+J
	 bekWGIB+HpI1UpYaKiUbcIA0Fq10aC0npSnDWvhh89D49mtpPbJj+3jxSX2LhbZrTI
	 XJhei8geLoamLL5zYj+Q4hyQRUE9nsfO9cgNlOzyw9HNCYEh8x8w4RpMS+xAvDPzZ0
	 DHnqJ9P+IXsUj2cOvuebO7rXqgUDP5pLa3SNtygE1Gq56kAdj4Thr1GLi+JsBgd98B
	 F32clOD9TuqYQcM7p3q3KUb8h6t1FyEE8OdJYTA4di1i2yXGG5iYLc2AVwyIyiycmN
	 bK+GltcFwL67A==
Date: Wed, 19 Aug 2026 12:50:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] Rely on regmap APIs in tc9563 PCI/pwrctrl driver
Message-ID: <20260819175046.GA817169@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoEdDEz8_VPCczW4@lore-qca>

On Sun, Aug 16, 2026 at 04:14:37AM +0200, Lorenzo Bianconi wrote:
> > On Wed, 29 Jul 2026 15:34:24 +0200, Lorenzo Bianconi
> > <lorenzo.bianconi@oss.qualcomm.com> said:
> > >
> > > ---
> > > Lorenzo Bianconi (2):
> > >       PCI/pwrctrl: tc9563: rely on regmap APIs
> > >       PCI/pwrctrl: tc9563: use devm-managed I2C dummy device allocation
> > >
> > >  drivers/pci/pwrctrl/Kconfig              |   1 +
> > >  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 164 +++++++++----------------------
> > >  2 files changed, 48 insertions(+), 117 deletions(-)
> > > ---
> > > base-commit: b9851611bad7cb227c93c1401dca48995a815d94
> > > change-id: 20260729-pci-pwrctrl-tc956x-regmap-91a0b5ae71f7
> > >
> > > Best regards,
> > > --
> > > Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > >
> > >
> > 
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> Hi all,
> 
> Do you have any update about this series? Am I suppose to resend it?
> Thanks in advance.

No need to resend it.  It looks like these are basically cleanup,
not fixes or new functionality, so since we're in the merge window, I
think we'll defer this to v7.4.  I put them on pci/pending/pwrctrl so
we don't forget about them.

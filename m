Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B13F20FA;
	Wed, 20 May 2026 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299281; cv=none; b=VlqmAKzZZ4sT5QWuCz1aPda+InCejuqCqi+J/K2iKyam9JtyPx80bEI5DNwOft9LjGiCpH58ivRrAkH+vH4uBaRr3P1+cDdO/60nHERKBGXMFwrCybnT6u8Gpy8aUPDS5Xbo51vv5ZLJA419yoWddoUAMksJ3itn4ANl+4Tf788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299281; c=relaxed/simple;
	bh=Ou04mB7JYTog298zI/Z60+tMDz89U5qS5BPKX5kr/+k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EiQsVBSTWZQU3d9CHWiAc0AcPhigzjQDmcJKWtibqsFAZmTH8vCO2zVj6DtFi7Gv5MK51Oqo9e53+CVnL2Z27mnxXkoQWxHuCpYOiZuOdq0fvnFGLO3hIE+q51GhRBa7LJ6KEbul1elJmTG7FXZMiapMXhhfnh8sn5x/qIJo8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X59zp2JT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X59zp2JT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E55DC1F000E9;
	Wed, 20 May 2026 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779299280;
	bh=QokDhHnAKqLWHjogTXLoR4DHLEoCdHeJVwDfmUpDWFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=X59zp2JT2ThlWcF8Vwx5hipnuU3pVcb+NfDjk2Z2sHtYDjkv+g3dJ0zZr2SGgl213
	 1C0hCo1gnbyqdhUCR+J6gzpc8QSsRa50+ECq21EUTPKSlop5c2ppovIB2kN3lPYiDQ
	 GR1Ypw4utLINVSrZVNL5Ysm4lJlrsSdcXXrYlEYy81+++le0P7+ckaH3kTfZIPhd/h
	 G5L5/+OpcbEO3IC+73xXcXcYHpivSRqU3jGXcMYQKbRNtlDpVoDXwc8ETE1DGBGa/B
	 FzvalrcDibzcUjSlRfzL+b/TJhLoq8ZU6IGme8BJScJjxXYhD+VHvlU8uda6mLonKz
	 zFY9Io0VLlY6A==
Date: Wed, 20 May 2026 12:47:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, joro@8bytes.org, praan@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260520174758.GA66039@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3vb4SWIfuw++vp@Asurada-Nvidia>

On Wed, May 20, 2026 at 10:29:19AM -0700, Nicolin Chen wrote:
> On Wed, May 20, 2026 at 11:20:43AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 19, 2026 at 06:04:18PM -0700, Nicolin Chen wrote:
> > 
> > > > Yeah, that's fair, so let's rename it to 
> > > > 
> > > > pci_translated_required()
> > > > 
> > > > ie the device requires translated requests to function. This is what
> > > > CXL.cache implies (IIRC I was told the spec specifically says this)
> > > > 
> > > > Requiring translated requests implies you have to enable ATS in the
> > > > system.
> > > 
> > > Perhaps we could let IOMMU drivers check:
> > >   pci_cxl_is_cache_capable() || pci_dev_specific_is_pre_cxl()
> > > directly?
> > 
> > I'd rather have a single function.
> 
> OK. Can we use pci_ats_required()?
> 
> CXL spec explicitly used "ATS" when stating the requirement of
> CXL.cache). And it'd fit into the existing pci_ats_ functions.

OK by me.

You already have a comment in the code about the CXL.cache
requirement; thanks for that.

I don't know enough about CXL to know what's behind the ATS
requirement.  It sounds like it's more than a simple performance
optimization.  If you happen to know the reason, it might be worth
a short comment about that too.

Please add a one-line comment in the code about why we check
Cache_Capable instead of Cache_Enable, i.e., even if CXL.cache is not
enabled now, it may be enabled later.

Bjorn

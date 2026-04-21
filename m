Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C03178372;
	Tue, 21 Apr 2026 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801000; cv=none; b=bY8Jla9+D3jI87BjXyjDfgi2nzOj8Rr8V/B6DHS+ZvRoC0JtCZLu6Mye7NsngAzUV5X4TaOJMWpyRO6Fh7gjsAWKrbdBHYzTPF3NxciZaP86Z1Y3iDAxi4B8xs1CTek/rbjwxti5c6l92KU6m1uaNH1XLMt1lxqfTnkDsQpAgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801000; c=relaxed/simple;
	bh=97V/EKLbZ3KWqU80pF5kvk00TJ3g7If0s+0qeYX7tFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEXbn4S5ifACcpQfhxKQj/Dx5Uj3M+vFNuBDcguzAv/U8tJEJm5Lms3htM58Te86kWor5H6W1ruTD3wyWIdEWJBmp72jELehLuOD2uHLVAiRkiuvaW1X4VEJLP9YSvBPfjutm9p8seK7sjgl2qEohoLYClA+oD5OdWqCkR6Bfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS8qELIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS8qELIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A31EC2BCB0;
	Tue, 21 Apr 2026 19:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776800999;
	bh=97V/EKLbZ3KWqU80pF5kvk00TJ3g7If0s+0qeYX7tFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JS8qELIw/RF+EjHgO3UvXikNVe5AiH217evZVd5UbB01Zjtt6JpoAXZS2QLeQbigx
	 1nUJ+g84HokGnIJeqSHEGLWOffJU+O+DDLYzSgDFx602FQmDCGTzqFY/JW/AiiDarH
	 /f7LFZHLxPMisb9zZZrRAnrB2LnXBCy+57AIRC+T0Z8kN1ITxS7u6FhsP+CEGX386r
	 pqt53OsP8vVj5AyTO2VngRAlxSDq+yCKBNnynIvrFck/FN9u2qcKbLo1afEDiTnOGC
	 cK9DLZh3FYh5ouNm9lUOu0Qa0Vs8tgDx+60M5DoDEIUBN7oQhsIpIUab3oxt45AzP2
	 CWwU6evxEDzmw==
Date: Tue, 21 Apr 2026 22:49:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <mattev@meta.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Avoid returning a provider for
 non_mappable_bars
Message-ID: <20260421194954.GA28413@unreal>
References: <20260421174351.3897842-1-mattev@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421174351.3897842-1-mattev@meta.com>

On Tue, Apr 21, 2026 at 10:43:51AM -0700, Matt Evans wrote:
> Extend pcim_p2pdma_provider()'s checks to exclude functions that have
> pdev->non_mappable_bars set.
> 
> Consumers such as VFIO were previously able to map these for access by
> the CPU or P2P.  Update the comment on non_mappable_bars to show it
> refers to any access, not just userspace CPU access.
> 
> Fixes: 372d6d1b8ae3c ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")

I don't object to the patch, but this Fixes line doesn't look correct.
non_mappable_bars applies only to s390, which doesn't support p2p. That
wasn't prevented before 372d6d1b8ae3c refactoring too.

Thanks

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00D3B27D1;
	Wed, 23 Sep 2026 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182366; cv=none; b=iGAyD5yJyuStJC5Ix+8YidJJHaWrHfVnfvo/wBwkmCXwFOgmj1dq0IWEC1evWbXzlQiDl9x5B226DHfm8P2kLf7MR68byvUkHdFEhllcapc56QqhIeXbiFcKPjjTuQyFYq9Eddg0Nj/kHK3g/H20aF7Vb577VInPYbmxUJottl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182366; c=relaxed/simple;
	bh=ypoBeeoHknpm16pdbErlf/hfIz5VWN7HTjZlJ/2D1CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTU8fBQ6ouv2O+5y32zmm+KyXjwzVvjDyPgloDr2i2yFuT3xAaf5ldDtUaA8BmVIuLZbVOWzr5xOKKEg8tEhexcDH2oWl6dhaot44HRREfCTZSY9aE0nHbE7nXxSqWlCRIiVlaV5JG7yX84IobTaesbzsrD+j6QRy3RESw+L9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVbDUx6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVbDUx6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986881F000FF;
	Wed, 23 Sep 2026 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182365;
	bh=Lhdy29oop/cw6c885Y7VJUb6i9ruLlFI44cMGP64UTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SVbDUx6c81ndO6gXE/xhJeR6ja16/7cbyfPo4arV94b0qGQols+M5Q2iRSZIW0Acx
	 6srUH5qtu9mhQa7OCqzHrqkZOR01iU4a8XSeRd/dNwoD1vMgktP/qA9GgJ1FSS9JV7
	 8n5XXqzShIaA8e/BMbBq3kRfj8eg8y6aLja/aa604G8TFri5wNLyg9aQu+I3/AXW7K
	 5L2fiq+Qqtp44l5FP7ZcAaDd5O4B30yWuKkj9jbili5TGVGwaVw7Kx3xFml8dKGy5Q
	 eC+mfyFZ9j5EsoeDoJJmWfQm5Dr8VXNiVNRO6MF8KPIszLwvSWv+fFYhaDAEXzljvw
	 1zAkWnPgGc1Fw==
Date: Wed, 23 Sep 2026 19:52:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260923165240.GS563127@unreal>
References: <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com>
 <20260922124637.GG563127@unreal>
 <20260922125421.GE1507824@nvidia.com>
 <arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com>
 <20260922225747.GB2545495@nvidia.com>
 <e33f1d3a-1900-4bf3-9785-3af5447e7e54@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33f1d3a-1900-4bf3-9785-3af5447e7e54@ozlabs.org>

On Wed, Sep 23, 2026 at 04:40:03PM +0100, Matt Evans wrote:
> Hi Jason, Alex,
> 
> On 22/09/2026 23:57, Jason Gunthorpe wrote:
> > On Tue, Sep 22, 2026 at 03:31:07PM -0700, Alex Mastro wrote:
> > 
> >> So I empathize with Matt's contention that the _existing_ behavior that the
> >> priv->revoked flag represents is actually "temporarily revoked": the importer
> >> can use the same dma-buf again, later, without having to re-import
> >> it!
> > 
> > mlx5 isn't a revoking importer, it is move capable. So the above
> > sequence isn't a revoke, it is a move with an unmapped placement for a
> > while.
> > 
> > This is why "temporarily revoked" is a confusing phrase.
> > 
> > The API is such that move and revoke importers can co-exist like this
> > but they experiance a different version of things..
> 
> Ahhhhh.  That was very helpful (esp. to contrast with the previous
> iommufd statement about invalidate_mappings being permanent), thank you!
> 
> So the worry was that the VFIO DMABUF's temp/perm state could be
> misconstrued as an implication/guarantee about the future availability
> of that DMABUF to importers, OK.  And we want the existing move(false)
> behaviour still, for dynamic importers that treat it as a move.

This is not a bug; the behavior is intentional. During review of the initial
versions of the revoke mechanism, it was pointed out that
`move_notify == invalidate_mappings == revoke`. The initial versions
introduced a separate function call for revocation, which we abandon in
favour of move semantics.

Thanks

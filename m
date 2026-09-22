Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68896544891;
	Tue, 22 Sep 2026 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081203; cv=none; b=q21ME/FvEGK0HGLbcHNBcd1F5fxXeFXIhOzo5z/ytQwDviIqBKcCfvP5AW9v3L6L9jy6ao8JJ4cI1Jnr1PDflhgLJeuj4ho6/1irMzjV4uvmBrnAyOoaD43exdOZZG00ipNzW3aZsZkT8oWYxTTcB4ZYNx4Dp1L6YNpWN4d5H+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081203; c=relaxed/simple;
	bh=/Wio73kZP77hZbjWZ2emvJIQ68ihHNxKWSxrniLafwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgdoTf1ftaXZIQi49ive8hEVD1/8XgrABXfn35lhrTGhYS5ewwtq43SzQ7C0NHjCJFybEOB6xGckdtC/jzQywmK1iym2wm1FBVtMkY7J332eXRYVD6c0bo+tB6QrO8HzGZelxOWG9ebEyQJc6M3Nq5ZBFYLDx/PR0uxzpYbzqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBQqvV5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBQqvV5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C44D1F000FF;
	Tue, 22 Sep 2026 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081202;
	bh=vlNJMjJNJtuYUwJ6hjN6VVFtsO/8YcI81Stq8tii+WQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hBQqvV5ICsYllg261MfYuphG3h6WkPbZKDyufD9/q9DTxX8jpr+ElXNmwioPCz5yM
	 1witd8EDmwQ8iTS4hOmWc8mah/fzkNgIeCTKxQ7NlUdVuOUUDSo1qyFe2uUVtyooF3
	 /WNLE98K/4kF8tlsdfxvmMfoBgWMLrWXp/Gdc1ontFZJZbFt+kYfskbspQYRtynxVT
	 L+kIsDU1TsBGTd4vwaba3vCmq/1mIdZrNZTHvxCjoVwuRMBfqDh6kx9b+hPkL86KJ9
	 /B1b22H547VJCMI3l72LQcJLZGddxE4FyF4mJDy/WZc/KgZOojmGB8CrHbaJWy2eZ2
	 h+ZAnIioIleIQ==
Date: Tue, 22 Sep 2026 15:46:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
	Alex Mastro <amastro@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20260922124637.GG563127@unreal>
References: <20260915072002.GD13683@unreal>
 <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922124137.GD1507824@nvidia.com>

On Tue, Sep 22, 2026 at 09:41:37AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 21, 2026 at 04:09:18PM +0200, Christian König wrote:
> > >> I would avoid that and just re-create the DMA-buf fd from
> > >> scratch. The extra overhead is negligible and one way state
> > >> transmissions are usually much easier to handle.
> > > 
> > > Yeah, maybe we should have done that. Might be too late now.
> > 
> > It's already uAPI? 
> 
> Yeah, but Matt is making some changes here so maybe new stuff can
> avoid this. I'm not sure.

Jason, the proposed semantics is not UAPI yet.

Matt only added the new struct in this patch.
https://lore.kernel.org/all/20260911214200.33793-10-matt@ozlabs.org/#Z31include:uapi:linux:vfio.h

Thanks

> 
> Jason

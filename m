Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD70C43F8CB;
	Tue, 15 Sep 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456808; cv=none; b=qYbKXaeGOxcnElQXfBhX1CBY5/gUMElq1btmKuiQEsIZd1n9CYMSZSe10pU2Dp7355GSI71tD3n0h/S43K4E/ho9SQzfEZF8AChMN6hNPEmdvYh3Ta4dd+Gsrs1Gq2jP0p2Fy0rNI8XnI+T3vcNM3hQFmzISOx5jiZwjAtxrI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456808; c=relaxed/simple;
	bh=6dLLS/48TQzNkBsXhLwY0+7SCrAogCpk6ieRqvn1zyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj4Eh1iOqsLBF468LZKYrsl/jfIq7+BQPEg1aRRbF7/u7fuNlqU2/NqhlUiLSiRozYKYNVe/7+KiGVlzLDZQskrmxK2QsG3mfUN+g2F4KQXw6ERdmPBTb6Ly3O33PFL9cIUMjqRZ8OPAyliSqrkHMb0TWa2VBZpl0HXxeYX4jG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJiy3DqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJiy3DqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007891F00893;
	Tue, 15 Sep 2026 07:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789456806;
	bh=FyM/uDm+tnR187tEWbfUP/Wv8cyeaRWJrXszC+FigbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nJiy3DqLOR9LIWKPRLB9D9eWUn97WaZOJ8op7wFd99Yjcl4KFfO8U5JOCrXrXYAL1
	 aWChcdtMGUmMM9FrbK4CHXb+jZe9+G0ao4v5+j7o3ov8uimqC8EycWedLkLC+pAEmK
	 vQMAj18D9bZI1Uqld3M+rnJEx386vPjzNyPMyxSTTkRI9BTOncHKEaLQ/KKdhFKdy4
	 ieLssqmLe7eKnp9YcAU6xWR/RsIiMgRLEhHsorUmNOmRoATOW7KnYBLHxZtUGGkk0F
	 8tjXhSk03syKMpeTz1SohHhI9gy+gC03RtGmc05DpZ6y6LPecYCab15k2u7h5kKcMx
	 Rdfe7jZW0zBVw==
Date: Tue, 15 Sep 2026 10:20:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Message-ID: <20260915072002.GD13683@unreal>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>

On Mon, Sep 14, 2026 at 01:13:36PM +0100, Matt Evans wrote:
> Hi Leon,
> 
> On 14/09/2026 12:54, Leon Romanovsky wrote:
> > On Mon, Sep 14, 2026 at 08:36:47AM -0300, Jason Gunthorpe wrote:
> > > On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
> > > > On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
> > > > > Expand the VFIO DMABUF revocation state to three states:
> > > > > Not revoked, temporarily revoked, and permanently revoked.
> > > > 
> > > > The thing is that "temporarily revoked" is actually the standard
> > > > invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
> > > > for VFIO.
> > > 
> > > I think temporarily revokes here means it is revoked from a dmabuf
> > > perspective
> > 
> > My guess is that this is more of a "change owner" operation than a
> > revoke operation.
> > 
> > The main issue here is that we have to guess the semantics instead of
> > having a properly named and documented operation.
> 
> Apologies if the cover letter for the series and patch commit message (which
> cover this) are unclear about the motivations and semantics.  On the commit
> message, can you suggest clarifications:
> 
> "This is useful for lifecycle management, to reclaim VFIO PCI BAR
> ranges previously delegated to a subordinate client process: by
> revoking, the driver process can ensure that the loaned resources are
> made inaccessible when the client is deemed "done".  The original
> DMABUF is defunct, and BAR resources can then be safely re-exported
> for use by new clients."
> 
> Given what I'll explain below, do give suggestions please.  There is more
> context in the cover letter (the volume of which I didn't think appropriate
> for the commit message).

1. Do not mix "driver" and "client" in the same description. For a
non-native English speaker, "driver" has a very specific meaning in the
context of the Linux kernel.

2. Explain the lifecycle in the commit message, and why "revoke", which
is effectively what the importer does, is not sufficient.

3. The more you put in the cover letter, the less likely people are to
read it.

4. Commit messages should describe the patches themselves, since they
are what remains visible in the git log, unlike the cover letter.

5. I would call what you describe as "temporarily revoke" is actually "reclaim".

Thanks

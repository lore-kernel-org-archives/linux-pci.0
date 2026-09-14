Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCC44A3F3;
	Mon, 14 Sep 2026 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387584; cv=none; b=cNqvc6aAEhCNBZiCF0wiS5c9mxfCL6oo6v/wMBBWHr6+Y+MypC3TN439UEfR9uWOloDjx7kvsLsL94o8tKjbvWagxvIGG0myjcrSVPC2nUQGo7Oxjh48CDkK2+itHZbB5XJ0F+tgWstzFoFxmVOQYAQ5nHCdUnVnfA+iD9TRg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387584; c=relaxed/simple;
	bh=L4ZI3c09USdCsAmeyoJD7VTofLReJVF1T24rxGVCMDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw++ioR6+v9NckFrmvpW2V2Yh9Et8ODSeu/oTzb1QUbwv+ESh3bFFUYJQgcLt3+5QetWjKrfFav1V0tnZoBC+GD5YfAMz2odvt7+JhQ/I2fdn9J/PJQuFJc/nQtnkuWy0C/fq1Zn1T+w2VQL++0nY/StviOOya5WE2m0VbkSb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsPzQKc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsPzQKc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04121F00899;
	Mon, 14 Sep 2026 12:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789387581;
	bh=JJ32IByX+rTBKcwgaZZYDc1UEnnlzh2V0wTKpkwgrnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MsPzQKc5dXfufDzuzryyW0/mnHC943MRxkWQ64H6J4fMnzDfqD3Sfv5/evutWeEeA
	 yvNPqKMfOsxIXrEAL7Iwu40iNRA5Yv+Crz5cw85xFPL8WdsqgploBRJzdaUPq/2FuA
	 nG8+YRbe97dV09LFkxELln+xhQnz5zh+iS3Op4//nRfR4CI6xkOFMeSe5FbLnFEtrV
	 88ouWGz2BodlJdkCQYAMzojuzg++6HzLMlgaMvAVRnMQpd4GfFzO3QVMN3BL1BmAzp
	 drmNCyfCX19Ukd+Evj2l8BFz7ZB3akEsy1dWoxJ3LrxJKdTBtU9XU5/Nrhsj0X1PV/
	 mFLCqdiosBFdw==
Date: Mon, 14 Sep 2026 15:06:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
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
Message-ID: <20260914120618.GA13683@unreal>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <20260914115826.GM3968357@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914115826.GM3968357@nvidia.com>

On Mon, Sep 14, 2026 at 08:58:26AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 14, 2026 at 02:54:56PM +0300, Leon Romanovsky wrote:
> 
> > So I still think that "temporarily revoked" is closer to
> > invalidate_mappings, with some additional dma-buf documentation to lose
> > the expectation that the buffer will become available again.
> 
> It really isn't, there is no expectation her that the importer has to
> put things back like with move.

As we discussed with Christian, "move" doesn't have such expectation.
https://lore.kernel.org/all/afb19db0-4154-443c-9d39-f905e7d17806@amd.com/

Thanks

> 
> From a DMABUF API this is very much just plain revoke.
> 
> Jason

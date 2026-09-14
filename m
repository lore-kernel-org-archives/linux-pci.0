Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C917440A16;
	Mon, 14 Sep 2026 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386900; cv=none; b=hc8f+kJ+5IOsRIJRxF2z98L8kIVu5WRg9qVu86gBLIAozZ87WQfjKPJravIwrCik54lrKMH/MNsR3bo0RmisxS6ZaZeZ81n2s/kvRZeix3r5m0lrfVxEy+4HGOezUwkRl4iTHKXamixePG82au2QlT27AvLerUhjvMXrMQWEUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386900; c=relaxed/simple;
	bh=frX//QIduH8kMIeCT3Ozdj2L7RcSLwxZOIDPR2NunME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGP/DkZ2SOxGmfd+ZALPWxXlIkTRKNP/ayZTPppikBl57xroLWPriyt9UrSkv21ZdOJ0u39vXMDJDLVN18WOB1MMXF7wArUpPOTvkyu1GD/pJtU9fuzPKNqqY5ZvH9EOC2HdnNj01LOOuxFEw7bcGxxAMiM86IgIhuTXshGOKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7wNU7Iw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7wNU7Iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773C61F00898;
	Mon, 14 Sep 2026 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386899;
	bh=mzslbS9s57kHQk5KhGmaTOWstnEBnslT4LYp80HR5nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M7wNU7Iw1O/OBF9URQRc/i9iZNutJqNfPaElMBTKqIKZPckpJAmhf7f0gLTCu1HMt
	 tMF7nnZqUHw7m4Q6qqhICroNBaY486sD0k/9xXK+kQZKWIf03oC5NPZb6udvbFfXAx
	 uH9dQsLagA9St5ZWmgflKNogNNb7bUoyJMV2Na1k3ecddBe1ghAx8IqK9DNNEyT59z
	 vBhTwYPX12IMLAPO4zDprisBauaJ/Yl8+H2rZ+89XAnU99qBmV8unZn7HZ+ufwajJQ
	 YvybuH36cRfFJdBuDgjwQMkMRrTa3ZlgAOlnxPSTxnWtid0iAU8HJx9IoK7U2P4fUQ
	 S3w2vJ3Nt0ulA==
Date: Mon, 14 Sep 2026 14:54:56 +0300
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
Message-ID: <20260914115456.GY13683@unreal>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914113647.GL3968357@nvidia.com>

On Mon, Sep 14, 2026 at 08:36:47AM -0300, Jason Gunthorpe wrote:
> On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
> > On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
> > > Expand the VFIO DMABUF revocation state to three states:
> > > Not revoked, temporarily revoked, and permanently revoked.
> > 
> > The thing is that "temporarily revoked" is actually the standard
> > invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
> > for VFIO.
> 
> I think temporarily revokes here means it is revoked from a dmabuf
> perspective

My guess is that this is more of a "change owner" operation than a
revoke operation.

The main issue here is that we have to guess the semantics instead of
having a properly named and documented operation. As Christian pointed
out, the patches describe what they are doing well, but they do not
explain why they are doing it.

> 
> Just that VFIO can make it's internal dmabuf work again, there won't
> be a notification to any importer or an expectation that something
> like iommufd will re-establish mapping automatically.
> 
> This is principally a kernel self protection mechanism where the
> userspace was expected to have removed the dmabuf before issuing a
> reset/etc. If they didn't then the kernel plonks it and userspace gets
> a mess to clean up.

Revoke/invalidate means that the importer should stop accessing the
buffer provided by the exporter. It does not specify what the exporter
should do afterwards.

So I still think that "temporarily revoked" is closer to
invalidate_mappings, with some additional dma-buf documentation to lose
the expectation that the buffer will become available again.

Thanks

> 
> Jason

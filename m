Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063135AC3B;
	Sun, 13 Sep 2026 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789318371; cv=none; b=LBquGfNNrgzh8stHvTrhpkQExe66WNWsgUtR/vIhAxTMnKlvT2SXyvV9fw8blhoT/5fDfzbkbfkmB53vdPN1KPJY+7QtXM8S/WCMxvaqK10IpTSykGI9dXvx6EQEM6ByzLpYJe7CGVMrfWvGpGI/9iviP8LkvSH2BNGnHghtqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789318371; c=relaxed/simple;
	bh=f6CYGdIlF0QxqMV9+Ks32EJAP5ALSrNcUznu+l4RCoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFVpqM5XVVOzShFdt/zbh7DQqyyCFjBu9I1gKgsrIWT6uBtmb01FbNM+lSNHgnDeBxVMq5QMimaivNgkXRRxpaD2wnztZaqUAaL17BJy3opcKoB694m3zROqPzGaCSbV6nr98D0bSXo+QduAaklbrZvGPKI9eaucL0TabRWXVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0Q8Q2ia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0Q8Q2ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5944D1F000FF;
	Sun, 13 Sep 2026 16:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789318370;
	bh=f6CYGdIlF0QxqMV9+Ks32EJAP5ALSrNcUznu+l4RCoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T0Q8Q2iaZRByFBBAaQofkmS3ZRxRnM8aS8pjTHTLJNR1qS4JCZWQ2M7fM2WOiJI3d
	 pBx74618ooRQ2LNyLJCS0aZjVImxm7qtmqXPqx6hU48cDXGDPqDwzRYqOETgXODX6o
	 uLfBibfDp+1GQkchNAFRNTyS/YOe6VLO6N9+A5gCPiYldD0WhuhzCRSyzKzh9wsmnY
	 o47QSIfI6Qg2Xn9YuhPc7I3MZOoQLP1hdAB2C2gi3toE3mp5dg14LMyMdSfJEhhkn7
	 v2HAcQeGwtTezQk23wEMk9DxMdOAjZ+2Tz7WX4JVQiVXYEEw5G6V4ycdfCDXGhSLYU
	 bA66Q0IXfEl6A==
Date: Sun, 13 Sep 2026 19:52:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20260913165244.GW13683@unreal>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911214200.33793-10-matt@ozlabs.org>

On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
> Expand the VFIO DMABUF revocation state to three states:
> Not revoked, temporarily revoked, and permanently revoked.

The thing is that "temporarily revoked" is actually the standard
invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
for VFIO.

Thanks

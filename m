Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B421ADC7;
	Thu, 24 Sep 2026 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213764; cv=none; b=W/uoxaYOg9gCzWtUk50/KTWc86/iBCTlbvl82Ec9ZSQPfxM6npQGfiuFi/NdDWvjCf1QR0i3DZyXWX1dFjuydpTkmda343xbtcMGrtKC37uEfbArkUk6kMH4Gtl8wnL5qpysvp2tOrDm4K4Rmdih/OUmah4Gx8G2UGBDIdPcCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213764; c=relaxed/simple;
	bh=5Ch/RogXHFPbBPAVDfOqo8TP+UFJ7AL0ScioD70eTdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWsIn8+nTksKYuAny7Lx/TYhjs9f+TYq2PXN0V+1+5mGFzpQLh47CP5JTlrS3r9JgCDI6/u+wE6IGNDTN37LhQzqbfNs9T4k4fhKlPrtxsrWD3CDwN1U/Gnm7tyJoKdyPEpIJV9LWWncitvA9FYZLAqw4Kk8HeqjNLNR0J+y0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxxh18ar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxxh18ar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A386C1F000FF;
	Thu, 24 Sep 2026 01:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790213762;
	bh=T+uFTgL0RVvb8Lw6QjW/uDBA+PJuT/oCTZg9+s15N0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oxxh18arZ8pXXPDPyWceU63ytb/VaPCfPA0s4vSd3QjJBdttVAmcLCe3HUdxREekJ
	 UndO+2gZ0YQfETWEeCvsoirFK4W7mC4iR1SGEM0TyS2uRUauOX9InuOIIWagDJYRMf
	 mSPLq/Z/jn4Eh/E3oq2hxwUklRLwD3AsSlCHLFCw5IETeTDASI72R/ToXFyVRZQbVH
	 /9NrRWQBWkFGAuwuMPgQkCmZkAbaatOiFndLozBgkdWLmELWa/9SXmEdzdXWllKan6
	 MbS4gSegfj+PWENmEByTrH+0lMzVD/NvZSXPy+BF3mAqmF4AWsdxigMdgJ56Ddwl01
	 M/3ep2W3BR7eg==
Date: Thu, 24 Sep 2026 02:35:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Srirangan Madhavan <smadhavan@nvidia.com>, Alison Schofield
 <alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave
 Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira
 Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alex Williamson
 <alex.williamson@redhat.com>, <vsethi@nvidia.com>,
 <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
 <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
 <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
 <icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v13 05/15] cxl: Introduce reusable HDM decoder settings
Message-ID: <20260924023557.5e34e0ad@jic23-hlaptop>
In-Reply-To: <389514f1-6e6c-42d7-a4a8-7bbb9032473f@amd.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-6-smadhavan@nvidia.com>
	<389514f1-6e6c-42d7-a4a8-7bbb9032473f@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



> > @@ -48,7 +48,7 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
> >   * clock skew and other marginal behavior
> >   */
> >  #define COMMIT_TIMEOUT_MS 20
> > -int cxld_await_commit(void __iomem *hdm, int id)
> > +static int cxld_await_commit(void __iomem *hdm, int id)
> >  {
> >  	u32 ctrl;
> >  	int i;
> > @@ -68,43 +68,40 @@ int cxld_await_commit(void __iomem *hdm, int id)
> >  	return -ETIMEDOUT;
> >  }


> > +int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)  
> 
> No reason to rename this. Either just use cxld_await_commit() directly, or just
> change the signature of cxld_await_commit().
> 
> > +{
> > +	return cxld_await_commit(hdm, settings->config.id);
> >  }

Please crop replies!  Saves time if hopefully a number of people
are looking at them + ensures that the stuff that actually needs discussing
doesn't get missed.

Comment looks good though once I found it!

Thanks,

Jonathan

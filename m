Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3573491D5;
	Tue, 27 Jan 2026 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521860; cv=none; b=NmkLgT9ZsymmeYRtuCNyNkpXO1xxGp+vRIs1LIP45O5OZBqDWqlZ08Uq+/Xtu0p/J+XnHvPhz/ZhCl64bu/jKXvj3AS4mv40+iYNRRoddBUG3PdVgP9J6ifhvUZuVPLTGBLZwMczN8qTjnJa67ZzMnFagT9v0WoPejzXAidAKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521860; c=relaxed/simple;
	bh=4xeMw3s+FAHTnao/LEHtNrxOifo5Sbu94YXUMTENOZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG+2ldviFwAHmzqrqihKcYEAPGYCkDbZthD7VCP3pT8xcql8BAo1+BPCdT2s864OuFLpquPo5CCLIm+iH1m0+PcrfhanPSg41x/DcVfIDiK171IS0wkb13yM3/ejZX/JE90elkSMyBFX0CUJZblOYs96D6x8XKiUAejltRHQ/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aroGooUa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aroGooUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1E6C116C6;
	Tue, 27 Jan 2026 13:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769521860;
	bh=4xeMw3s+FAHTnao/LEHtNrxOifo5Sbu94YXUMTENOZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aroGooUaY+mOkwVNVfX7UarBOlPO4sSop88Kjyz4a0n3cyKJsbmX+rvzrEyn4QXju
	 GmkciJZ0+OtM0gl6aasRfglFdedw26hWKvYJLzwA143WnD0oicD3nKnPENTWhL0ONP
	 PRl4qF916KvUzFdbH24/nE+RJSb1YOUJSScbqbJI6jVOnL5H8ikntYch8YnRfAXOu0
	 WVh8UHvli4khLSPX9UWNJ0+s/Fc1dJZYyuBZoCQJHinPP/RbC0uBh44DKKkDcuSsMA
	 SNiBlP/eAKxUH5o8MJ/r69k6rN9M7o6/cGtygPf2qafVtX9QqsHirxHojeLk4RzVUw
	 uzUd3JcGd2RSA==
Date: Tue, 27 Jan 2026 13:50:54 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	bhelgaas@google.com, joro@8bytes.org, praan@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFCv1 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <aXjCvuBFCDBi7jUD@willie-the-truck>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
 <aXdgljWHHPVMTmya@willie-the-truck>
 <20260126172020.GP1134360@nvidia.com>
 <0a60797a-fbb9-4a83-adc6-ad62baf5915b@arm.com>
 <20260126190935.GV1134360@nvidia.com>
 <aXi5W-7b2odQQtqy@willie-the-truck>
 <f08595ff-f36e-45cc-8ea2-dc678f59c7d9@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08595ff-f36e-45cc-8ea2-dc678f59c7d9@arm.com>

On Tue, Jan 27, 2026 at 01:26:02PM +0000, Robin Murphy wrote:
> On 2026-01-27 1:10 pm, Will Deacon wrote:
> > On Mon, Jan 26, 2026 at 03:09:35PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Jan 26, 2026 at 06:49:07PM +0000, Robin Murphy wrote:
> > > > (assuming SSIDSIZE > 0 and it does anything at all - note that strictly we
> > > > cannot assume this bypass trick is *always* possible, since an SMMU is
> > > > permitted to support ATS without supporting SubStreams).
> > > 
> > > Yes, I think Nicolin has captured those conditions in computing
> > > it... We don't have a logic to disable bypass in that case though.
> > > 
> > > > > So, I think a CD table pointer to a fully invalid L1 table of at least
> > > > > size 1 should be OK?
> > > > > 
> > > > > Or stated another way, why would ie be OK to have a 1 level table with
> > > > > an non-valid CD table entry for SSID0 but not OK to have a 2 level
> > > > > table that returns non-valid at the first walk?
> > > > 
> > > > S1ContextPtr itself is reachable since S1 is enabled, so it cannot point to
> > > > nonsense. But the S1DSS==Bypass behaviour does state:
> > > 
> > > > "Note: Such a transaction does not fetch a CD, and therefore does not report
> > > > F_CD_FETCH, C_BAD_CD or a stage 2 Translation-related fault with CLASS ==
> > > > CD."
> > > 
> > > Yes
> > > 
> > > However, taken together:
> > >   * S1CDMax is set to substream 0 only
> > >   * S1DSS is set such that "does not fetch a CD" for SSID = 0
> > >   * SSID >0 doesn't fetch CDs because of S1CDMax
> > > 
> > > Then it seems to be saying that it will never use S1ContextPtr? ie it
> > > is IGNORED?
> > 
> > Right, I think the critical question is whether that setting of S1DSS
> > (0b01) means that STE.S1ContextPtr is considered "invalid". The spec
> > doesn't call this out explicitly but the "translation procedure charts"
> > seem to indicate that it doesn't use the CD for anything...
> > 
> > It would be good to get some clarification from Arm about this
> > particular case.
> 
> No, STE.S1ContextPtr itself is "valid" since S1 is enabled. No CD fetch will
> occur for no-SubStreamID transactions that are bypassed by S1DSS, but the
> SMMU is permitted to attempt to speculatively fetch CDs for the enabled
> SubStreamID(s). Those fetches do not have to reach a valid CD if the
> SubStream is not actually in use, much like we don't have to fully populate
> a 2-level Stream table for StreamID ranges we don't care about either.
> 
> Don't confuse S1DSS==1 (bypass) with the S1DSS==2 behaviour we use in other
> cases - the latter is "Use CD 0 for no-SubstreamID traffic" which makes
> SubStreamID 0 invalid to use. However in the bypass case (and also S1DSS==0
> where no-SubstreamID traffic is blocked entirely), SubStreamID 0 remains
> perfectly valid and usable (we just still won't ever use it in Linux due to
> the middle case).

Argh, I had conflated a transaction using SSID 0 vs a transaction
without a substream at all. So I think this makes sense now...

Thanks,

Will

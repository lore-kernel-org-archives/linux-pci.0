Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F534C9AC;
	Tue, 27 Jan 2026 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519457; cv=none; b=mYgAi6FqsXVc4rsIt7angMr2FKBuQVnv5iiMdk3TM4jjrznNIdh04idsqxGYbTSGVjbxZHzsC41oqIRxIHt4WzBQ6h6IRCZoCYco0PSOp9CGoLP4y9guLimvubRfrUuwXad1cVPP04SAzPypiYC9kg5nUPE5vErJzLncaCFGFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519457; c=relaxed/simple;
	bh=FoR/91tcqgCb9bTR8L2/y9tPEOUImDArbq74MY9GZJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edce8NI2Rn5mta5I0FvC99gilwhtTJdsaUqDSaoggAfiwtgv39hgfa+SF0u4r3zIEOz9VU7zDUEQAHsg5KeXo8hmxqAYJKy2u6TL2IgngDcGJR0JWMCYTmw5G1Ze+tu3SK1G0Od856N4MeKC50grEerR0NJwVfHxrhjjuDJRy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdQ1q9QI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdQ1q9QI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82885C116C6;
	Tue, 27 Jan 2026 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769519457;
	bh=FoR/91tcqgCb9bTR8L2/y9tPEOUImDArbq74MY9GZJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdQ1q9QI17PW5NfnHxAzQjLhh2LExwOy9wC8v76Gio946pTDCJGZw6O6ena8Z4Vrv
	 6f66Lrwt+Mg4kSVYPERTLDCAgheP2gyrLLLscUdmb8mIBPSZREnqMdx47x7ttlMSD5
	 cf3WeQC/ygUsSJv9wNsO0wA2DESJGH3c5BCr/X2ArvuVqx8VBGaoubchiESdkpnIF3
	 9GmjcShtAejjI9iHc6BGiVIhJ6Ij6q6xm4KoKUaiHLzLtzcROjd1hbgMFQXApwZLNL
	 I2DnPaScgVCVfwYW2O7qO2ctL/0uilMDBxYwd8mKMEJOfXTXpuivqxxQIK+FBkq1dx
	 2dHlmuo8pLNrw==
Date: Tue, 27 Jan 2026 13:10:51 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	bhelgaas@google.com, joro@8bytes.org, praan@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFCv1 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <aXi5W-7b2odQQtqy@willie-the-truck>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
 <aXdgljWHHPVMTmya@willie-the-truck>
 <20260126172020.GP1134360@nvidia.com>
 <0a60797a-fbb9-4a83-adc6-ad62baf5915b@arm.com>
 <20260126190935.GV1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126190935.GV1134360@nvidia.com>

On Mon, Jan 26, 2026 at 03:09:35PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 26, 2026 at 06:49:07PM +0000, Robin Murphy wrote:
> > (assuming SSIDSIZE > 0 and it does anything at all - note that strictly we
> > cannot assume this bypass trick is *always* possible, since an SMMU is
> > permitted to support ATS without supporting SubStreams).
> 
> Yes, I think Nicolin has captured those conditions in computing
> it... We don't have a logic to disable bypass in that case though.
> 
> > > So, I think a CD table pointer to a fully invalid L1 table of at least
> > > size 1 should be OK?
> > > 
> > > Or stated another way, why would ie be OK to have a 1 level table with
> > > an non-valid CD table entry for SSID0 but not OK to have a 2 level
> > > table that returns non-valid at the first walk?
> > 
> > S1ContextPtr itself is reachable since S1 is enabled, so it cannot point to
> > nonsense. But the S1DSS==Bypass behaviour does state:
> 
> > "Note: Such a transaction does not fetch a CD, and therefore does not report
> > F_CD_FETCH, C_BAD_CD or a stage 2 Translation-related fault with CLASS ==
> > CD."
> 
> Yes
> 
> However, taken together:
>  * S1CDMax is set to substream 0 only
>  * S1DSS is set such that "does not fetch a CD" for SSID = 0
>  * SSID >0 doesn't fetch CDs because of S1CDMax
> 
> Then it seems to be saying that it will never use S1ContextPtr? ie it
> is IGNORED?

Right, I think the critical question is whether that setting of S1DSS
(0b01) means that STE.S1ContextPtr is considered "invalid". The spec
doesn't call this out explicitly but the "translation procedure charts"
seem to indicate that it doesn't use the CD for anything...

It would be good to get some clarification from Arm about this
particular case.

Will

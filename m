Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB03C465;
	Wed,  9 Sep 2026 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914182; cv=none; b=h81y4TzLV25PhnIjrOqFggsI/vmwDWfAX6knU8inVm3wyy08qgtj9rbwifGXZFCvxRMYyGpUUTM7DqRYVmSu/R8/iBun8Drdm2REpmh1n9thqN03Ypvc62wLsQ8Zxyo1MuwO4b8cQEuJB8HjKch50sQbvYKwu8o3RKG0i3khB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914182; c=relaxed/simple;
	bh=7wkmoXyRy7w+oxwuVE1sWBi73BwaC7QBYD868rpUAGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+z7pr/YODtthlnvbRBINK/8ecTYnMzFz2NcyJS/tfLLQHQJN8VxHZVSRPDSlparjiyZw/p565ixZUDosKkn5qz5OBo+6loIWRr+bsXBiqLKg0TE0KMOzMwZPIIVOGOnhV1+iWz7ufGexAac/9LhhLZ/aYAMOYV3cFwiLY9bSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQp3hthE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQp3hthE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675761F00A3A;
	Wed,  9 Sep 2026 00:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914180;
	bh=kHxVevvDuQ0pQtzGFb8Vsde6OZxErbsVBfZEdqemaes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eQp3hthEZC/C9zUUTfRS9L9VQN7296QlufrHkMzkv2FK6jQg+2atlo+wTmCLZt2iK
	 LT/dLQjvp+y0LNUE+pYDvK4yjrMBAPF8uao6w9OOiGXcB7RqNcsqEmiA1Zu0rZCYBl
	 GZBb2tGZ3zKiUSKXTU5/N0oC4G7obfsEEeyJRGDQPT5FOpJTEzMlysbcNxyiDYbrfw
	 eL1zwwL7btYb8xoCv6E/vbZjln9WCfa6YrGubWfvX4OqlTwHFPWcVxFunuAF/vEhra
	 hOjixsJbMq3Nl5Ad29Th2mVZv4NABBRjaXGSgYHJ9W2d6PRSMZVshzJsBeFaZQAIH6
	 DFF1vu6rA4cOg==
Date: Wed, 9 Sep 2026 01:36:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, alistair23@gmail.com,
 linux-pci@vger.kernel.org, ojeda@kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 17/21] lib: rspdm: Support SPDM get_digests
Message-ID: <20260909013616.13993627@jic23-huawei>
In-Reply-To: <20260901012040.554EE1F000E9@smtp.kernel.org>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-18-alistair.francis@wdc.com>
	<20260901012040.554EE1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Sep 2026 01:20:39 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Buffer under-allocation for SPDM 1.3+ GET_DIGESTS responses leading to transport failure, transcript truncation, and EIO crashes.
> - [Medium] The GET_DIGESTS implementation validates the payload length but completely discards the returned certificate digests.
> - [Low] An undersized/truncated GET_DIGESTS response incorrectly logs an 'Overflow' error.
> --
> 
> commit 7b16689f564246befd0f0c43fa0d4515876746e6
> Author: Alistair Francis <alistair@alistair23.me>
> 
> lib: rspdm: Support SPDM get_digests
> 
> This commit adds support for the GET_DIGESTS SPDM command.
> 
> > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > index b78086c753702..131c22319b262 100644
> > --- a/lib/rspdm/state.rs
> > +++ b/lib/rspdm/state.rs  
> [ ... ]
> > @@ -612,4 +630,64 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
> >  
> >          Ok(())
> >      }
> > +
> > +    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
> > +        let mut request = GetDigestsReq::default();
> > +        request.version = self.version;
> > +
> > +        let req_sz = core::mem::size_of::<GetDigestsReq>();
> > +        let rsp_sz = core::mem::size_of::<GetDigestsRsp>() + SPDM_SLOTS * self.hash_len;  
> 
> [Severity: High]
> Does this calculation fail to account for SPDM 1.3+ fields like KeyPairID,
> CertificateInfo, and KeyUsageMask?
> 
> For SPDM 1.3+ compliant responders, up to 32 bytes of additional fields
> can be returned. Because param2 is a bitmask of provisioned slots rather
> than a count, any device using slots >= 4 will produce a response size far
> larger than the allocated buffer, which could trigger an EIO crash.
> 
> Even for lower slots, this calculation omits the 1.3 fields from the
> transcript, which could cause a permanent signature verification failure
> in challenge authentication due to transcript desynchronization.

Nope. Feature turned off by requester not asking for it (yet!)

> 
> > +
> > +        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
> > +        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
> > +
> > +        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
> > +
> > +        let len = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
> > +
> > +        // The transport must report a length within the buffer we provided.
> > +        if len > response_vec.len() {
> > +            pr_err!("Overflowed digests response\n");
> > +            return Err(EIO);
> > +        }
> > +        response_vec.truncate(len);
> > +
> > +        let response: &GetDigestsRsp = Untrusted::new(response_vec.as_slice()).validate()?;  
> 
> [Severity: Medium]
> Does this completely discard the returned certificate digests?
> 
> The SPDM specification mandates that requesters compare the hash of the
> certificate chain with the digest returned in get_digests. There doesn't
> seem to be any storage for these digests in SpdmState, meaning this
> cryptographic binding between the get_digests response and the certificate
> chain downloaded in get_certificate might never be verified.

This one is curious. I can't find a reference to the spec requiring that.
Digests are a short cut, I think you can always ignore them and just use the certs
themselves.  I couldn't find any text requiring the certs if we ignore the digests
but maybe it is hiding in there somewhere.


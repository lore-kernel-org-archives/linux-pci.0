Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653D451071
	for <linux-pci@vger.kernel.org>; Fri,  6 Mar 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828535; cv=none; b=nS26xabNUB2o/FPABM2VGO34kHonm5KFUMUkbj3z1baQNcenJM2yKrhM24YJfGEKuuGF//4DopOfyxG7TJLNteUlM1j4Jyk3x5bgS92ipkoHZtKh6vbZ5fLWCCZaRIaE5NUGCdBqpb4DaXXmTw0ZgYCT4M8zOaszyZgadGCEIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828535; c=relaxed/simple;
	bh=N/ru0EOFkc3AcpS21XeyDwquZX7JMKMkovV4eRQ1jis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7VrOaG1EKIkD3/yxG7QhdxGTClZFxSmhr+pG5FpNZoRM2l9Yo3SiVmn+HlaBh1sX+ZcZtEvc4EsWhuSGDv241hlWtlbg5E+hZrIfZYet6xztAVgQ8CO5InNzIs5AyNHfM/yepEkuN+stssPFeJBCiyMXYqnnnBNCUjgMKhSo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZ+jzdoo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZ+jzdoo"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae4b40999bso595ad.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2026 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772828534; x=1773433334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/ru0EOFkc3AcpS21XeyDwquZX7JMKMkovV4eRQ1jis=;
        b=wZ+jzdooGqLXnitC+wxhTDC4MFrN98P50c/FrExACAGfbJnZpARrSo6duRLvHIjt23
         dgjEcoHZ+xnwF3P5RrEeO5An4iGzdqpXhNt2Mtz9MT2mq4hmgwE9IxZhr///iTTsxdIG
         AZrtIJKtS6BsKQsRrohiB6V930qh5ElQW/AfFpqhrleLWLOXFY74T57PlNCOSxesTHlI
         C4ZFh/rRsfaqRSxZMmARCISr8JI2dtG5qPv4SpQV8J6L7Y68UpWuE0/hlOhJ99cUuJO2
         oZ4DCPq2/lwXUfpyHB0fAIv38Tn9fWS1D/6X2+VtTEY30CNZ7VgRfciQoskm65svPSCZ
         tkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772828534; x=1773433334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/ru0EOFkc3AcpS21XeyDwquZX7JMKMkovV4eRQ1jis=;
        b=dWVmiE8evgLV3eTmJU+SyAbNf9Gtom6U8hxnI2wAUr1pUW4rq4r5BQSWXaCmHARnUW
         TP5nR6GRwrt79d3iTL1bQwnj/W6rqTUt2UpvOu4RiG6hgEpQuu3mBnjgAXJYCgow3+fA
         nqpfpVnG2aD0ouLoFgvzZZLeyNDa1vQ5l2UZkTvkyIk4FBXDlg4qGuNQasreL4KXLsBb
         J/vggVgVdXcSBWokQXYPwQl1D8gkcgAw8k5dfTA7vecTux+OHllMAWHOiEz9+txinn8Q
         opC/GWUFAGFdpDEzprSTrUEqHbAH9oPXQ+pm4Wl1dKMATPYvwvCXPigg6DbysXL9m6yb
         1/oA==
X-Forwarded-Encrypted: i=1; AJvYcCXoCQjonGqHXdZaBIKbWRJPtcK9/kgG1SerT8rx4pbvQXF7faZ5jCF1HmPlVRo8tJeChnMS0HKTy2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3gDnWc1Kq5//dCXWETKMiHFH5A3DqUdt2mA1zUrcU0mDU3NV
	n0olXgi6oFvaRBvhDR1U04VuxS2CWG30DU3I3HFbDcF8eXBpyK8cNb3n0JF58ZDPEA==
X-Gm-Gg: ATEYQzwAoc+SUY8gKqzrETKRiLW8JwXERJeGb8Z01sAGV6cr/pGhJnMoxTjVNIHKUpr
	+lozIDseBXt5WDoaurChqe7gq8+9W3ERSWXz3Phgi5bhH2L/nfJtG0ybYN52z5gMvs8oH26clk5
	123KvnPUGSjLtBnjabNAz5ZCeZcrB+5b+3TNqIPMfx3iwd8B7X/RaKhe2AzL2eTbdMYYNwrpbGM
	emwIUbi6lLoEa9VcSBnEKCgSTr1fPpPXwEFbLs67pVn9Jtuc8+Y+4/6qxiozbF1OEjcuxFo/ilo
	TSZuw2sFA4VBAvIRRfUK+3bOvpv6lvsNdHUQrst2pfYuZVRCWF9ubckyBSDSYbTSJkef0pcZ7O2
	yLll3G02fZlVswW/2uoGyF4/LPLJFshyeDI5qbJUgSjBS4NmW+sTYSuO0xaH9MU+IVhfklIM1Sh
	fAsrHtwkBPf/kRnKlYUCpNqx4gcRk6EsDcKreex4Ton36kai+SVRxhEbcJDZFFlg==
X-Received: by 2002:a17:902:e84b:b0:2aa:d604:62f3 with SMTP id d9443c01a7336-2ae8ad1ceb3mr443415ad.10.1772828533274;
        Fri, 06 Mar 2026 12:22:13 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f7837bsm28280845ad.48.2026.03.06.12.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:22:12 -0800 (PST)
Date: Fri, 6 Mar 2026 20:22:08 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, praan@google.com, 
	kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com, 
	kevin.tian@intel.com, miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aas0dLwKmZyL_iOL@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
 <aasv1HYOKuuJyi1k@google.com>
 <20260306200321.GN1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306200321.GN1651202@nvidia.com>

On Fri, Mar 06, 2026 at 04:03:21PM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 07:59:33PM +0000, Samiullah Khawaja wrote:
>> On Fri, Mar 06, 2026 at 03:43:12PM -0400, Jason Gunthorpe wrote:
>> > On Fri, Mar 06, 2026 at 07:35:19PM +0000, Samiullah Khawaja wrote:
>> > > On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
>> > > > On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
>> > > > > I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
>> > > > > invalidation timeout is a generic challenge across all IOMMU
>> > > > > architectures that support PCI ATS. Would it be feasible to implement a
>> > > > > common 'fencing and recovery' mechanism in the IOMMU core so that all
>> > > > > IOMMU drivers could benefit?
>> > > >
>> > > > I think yes, for parts, but the driver itself has to do something deep
>> > > > inside it's invalidation to allow the flush to complete without
>> > > > exposing the system to memory corruption - meaning it has to block
>> > > > translated requests before completing the flush
>> > >
>> > > Yes and currently the underlying drivers have software timeouts
>> > > (AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
>> > > before the actual ATC invalidation timeout occurs. Do you think maybe
>> > > the timeout needs to be propagated to the caller (flush callback) so the
>> > > memory/IOVA is not allocated to something else?
>> >
>> > No, definitely not, that's basically impossible, so many callers just
>> > can't handle such an idea, and you can't ever fully recover from such
>> > a thing.
>> >
>>
>> Agreed.
>> > > Or blocking translated requests for such devices should be enough?
>> >
>> > Yes, we have to fence the hardware and then allow the existing SW
>> > stack to continue without any fear of UAF from the broken HW.
>>
>> And this applies to software timeout also I think, since both have same
>> end result.
>
>Any situation where the ATC flush doesn't get a positive response from
>the HW must fence the HW before continuing to avoid UAF bugs.
>
>Obviously today we just succeed the flush anyhow and hope for the
>best, and I think that is a good starting point for VT-d. We need at
>least that to build anything more complex on to.
>
>Fencing the device also has to come with a full RAS flow to eventually
>unfence it, so I wouldn't do it in isolation.

But do you think doing the timeout logic without fencing would be good
enough? Currently VT-d blocks itself, until it gets an Invalidation
Timeout from HW, and system ends up in a hardlockup since interrupts are
disabled.

Are you concerned that if fencing is done without an RAS flow, the
device might not be able to detect the failure (if it really needs ATS
to work)?

I am thinking, we can do translated fence and timeout change for VT-d.
And the device can use existing RAS mechanism to recover itself. This
way we atleast make sure that caller of flush can reuse the memory/IOVAs
without UAFs.
>
>I would like the unfence to be done with a fresh domain attach (or
>re-attach I guess) that just rewrites the context entry with the
>correct one.

Agreed.
>
>For VT-d that probably also means it will need all the domain attach
>fixing we've talked about as a precondition too.
>
>Jason

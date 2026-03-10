Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3A3E317B
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172857; cv=none; b=mK/VIAlKwmYaQm/i8tgi0HIpqOsk5AFfvAwnJ3RuxUaYyg3dvuC98OX+kVcrfPTkI/ptJg5TQmCotlNeCUPLsF17BnuSX/i3n5Zoc+1pn2An7YznKtjf/606WMYkBRvLYvuL9k0aJ44ZHqWN2RYF5tsgrNXlGjr19kb0sFl+yFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172857; c=relaxed/simple;
	bh=km+lTVfCRl2ntV8aEXaF3ep+A713m1xBMbzdYvJNBFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHYmo1RdAlRwfOri25AfFCBh69Ls/0P29LRqdYsoBJweNuQjRScEQ9AjLtvQ8YuR2S+ne7qaiQ5HQyTqpTvozMRiaJ3YTeSXG3CDCbEt4XZNMDeZU6eeci82QKNoKryQbT3dyWvr4oJa+ENp2w6WQWaJUhAqvC4/qQWW+06c9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=szOw2zgC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="szOw2zgC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae3f822163so31295ad.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773172855; x=1773777655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9uoDZoX5wcYSBPe17Yxmax+57dy5y/EA9jB+yCG4Lo=;
        b=szOw2zgC3xlYGdyp95RvSh8TPd/J5uEMVHw/CRQdvS2OB9zUwTRraJQoXMlJho5nmK
         +D7fP8q20JlBj8MCdcT/5e0JGzICn2aZy+0HiJV/7rpngxOW9A8prGQj2E5ar6z9LNIV
         q3P5VDdwwBUe21C8JbiVY5j6NVK7wi9q/Gc9XGGQbI9RbhcjzWgOop0DStjMCoh+8IhQ
         eXW/qKOXhX34b8gGM7qY8kH1k5+IY0LfuDr1cd032r97yVeACdGzwt1+SC+Z4YcdKM5M
         Bt1UvoXhvjXXX7q33xxz7tFJJ6rA36g1RfdqZ9hi9+eDkOikkFnFgWcFrR+O+/IdDrMB
         WxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773172855; x=1773777655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9uoDZoX5wcYSBPe17Yxmax+57dy5y/EA9jB+yCG4Lo=;
        b=O2y9c2gBoE735ySkeRFGfQA1Yk8Qe9l4DuHyKpCjqtwxN33ydF27sALCCgNH1gX0sn
         CIWvyHomsjE/hXboIIZM4UVowqyV4o/k7LvVBPJrKSrxZENsGnG5ifRK8dD6Tfz0B7+C
         /uclMvhwNs0Q9eFJBnitmgpC4wFZnFldXYI1nq5Bc+tdRwXSZFBf9j5uNeaz5836biKj
         vieVZ00kFH8mCtKEQHegkhgD+AWaWF4SDNKDWmaoKvULcDs6CV2iJyf/zTs9SEs4VLah
         oUdd6QxcawgyRabhvzaS0uwOpMQGpYowSWu4x9aKmX3j2LLm57DFbMTDY/ZGHZ8rZb44
         jFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Pt8dXpSHLdAeEp2XwWFNOYHatVNU0cRVA2e2vT/0q9iDpDi5yWJqO6Z5QH5RM0y5ue5qi6AT7PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZd+YP+T9wmWNW+hqC3Z9MJr5oUFsvcD2UmFSwtaG10nOLhTDv
	QfJB2+JljpsfS20SW9tlQnOtnXf+Tu4kN/dRSGs4/v65xvyojOoE83jI30h9zbTLyg==
X-Gm-Gg: ATEYQzysnf9mUxGS/kvVIqM1vH4lmBzw0MjHdzRmH48f1uR9k+OETdMKIRPTlWM2ZmW
	zvJx4etLQne10t/VWM/CgujwFK8A5Dx5JulZ3Yd2zSSyqTWpHNi9ibnqcBsLdbZXK3aQdUQbq4p
	r0WXX5LLL3sl7gXmQNS9iYIgm4Dd1kTfoBVRIXVtOixjdKh2La5P8bl/T7s62xE1fW7Gdh+jozv
	7b2Dg1idC7eKoQOv9LDgV03Sj6HgHS1pbHfdvTCy3Q9xXfa59My5pKKJ7ro6hy6Px/gmXE6xT9m
	/zJ/TJ6svsTQ/jH/CQ+hMPKk3OFlP8jx+JZd6b8jU9QxRDk8DAAZyDITd6McM8azqXoIU5k6KNB
	REIdKPLSZ/X2xESKSnw4GZ+fxh+/ZbcaSdgFHWq4HEZtez0DlAQswaZt4HmL5RYyqHhT1qHJdAk
	e0ARbfL0OgxYzVTf7+uT0usclkhyvfJA3JPjS/78WnjDgrdDz7H9YXK57LIw==
X-Received: by 2002:a17:903:2ca:b0:2ae:5d57:c94f with SMTP id d9443c01a7336-2aead3e31a0mr779595ad.16.1773172854782;
        Tue, 10 Mar 2026 13:00:54 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6eebe95sm83922b3a.36.2026.03.10.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:00:54 -0700 (PDT)
Date: Tue, 10 Mar 2026 20:00:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	bhelgaas@google.com, jgg@nvidia.com, rafael@kernel.org,
	lenb@kernel.org, kees@kernel.org, baolu.lu@linux.intel.com,
	smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abB4cAjZjIvIzhkp@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <abBt8qj8QpkG-Fwh@google.com>
 <abB2V8VGfoh5yO45@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abB2V8VGfoh5yO45@Asurada-Nvidia>

On Tue, Mar 10, 2026 at 12:51:51PM -0700, Nicolin Chen wrote:
> On Tue, Mar 10, 2026 at 07:16:02PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Mar 04, 2026 at 09:21:42PM -0800, Nicolin Chen wrote:
> > > +	/*
> > > +	 * ATC timeout indicates the device has stopped responding to coherence
> > > +	 * protocol requests. The only safe recovery is a reset to flush stale
> > > +	 * cached translations. Note that pci_reset_function() internally calls
> > > +	 * pci_dev_reset_iommu_prepare/done() as well and ensures to block ATS
> > > +	 * if PCI-level reset fails.
> > > +	 */
> > > +	if (!pci_reset_function(pdev)) {
> > 
> > I'm a little uncomfortable with this, why is an IOMMU driver poking into
> > the PCI mechanics? I agree that a reset might be the right thing to do
> > here but we wouldn't want the IOMMU driver to trigger it.. Ideally, we'd
> > need a mechanism that bubbles up fatal IOMMU faults to the PCI core and
> > let it decide/perform the reset. Maybe this could mean adding another op
> > to struct pci_error_handlers or something like that?
> 
> Robin/Jason already had similar remarks (to most of your other
> comments as well). I have acked their comments, and am already
> reworking on these.
> 

Yea just saw those discussions as well, replied before seeing those.

> > > +		/*
> > > +		 * If reset succeeds, set BME back. Otherwise, fence the system
> > > +		 * from a faulty device, in which case user will have to replug
> > > +		 * the device to invoke pci_set_master().
> > > +		 */
> > > +		pci_dev_lock(pdev);
> > 
> > Why are we using spinlock_irqsave across the worker? Also, why does
> > atc_recovery.lock have to be a spinlock? The workers run in process
> > context, and I also don't see anyone else take the atc_recovery.lock?
> 
> I guess mutex would be okay here, since there is no other place
> access the linked list. Pairing a linked list with a spinlock is
> just a common practice..
> 

Ack agreed. No problem with the type of the lock, just questioning the
choice to use spinlock_irqsave et al since I don't believe this could be
in interrupt context.

> > Why does it need to be irq-safe? If this can somehow run in irq context,
> > we also seem to be using pci_dev_lock and streams_mutex across the
> > worker?
> 
> pci_dev_lock was to fence race on the PCI level. Yet, the entire
> BME call is probably not a good idea. So, dropping that means we
> won't need pci_dev_lock.
> 

Ack.

> > Mixing mutexes with spinlocks is brittle and invites 
> > "sleep-while-atomic" bugs in future refactors..
> 
> Either streams_mutex or atc_recovery.lock was scoped for only a
> few lines each section. Each was released before the other one
> was taken. Where is the "mixing" or "sleep-while-atomic" case?

The case doesn't exist yet, I meant it as a warning against future
re-factors, since I didn't see the need to use a spinlock here, I didn't
understand why couldn't all 3 be mutexes when the existing 2 already
were.

Praan

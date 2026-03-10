Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0F3559C0
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173063; cv=none; b=A9rVxflrCZH/57wROeAsTFUQ5QOv8zubk+RdHzl+KyS2rE9DutsRsUsOltu6vYzwWB2fuVmgVHrsYNtffAQ2ZrH30sIfibc672DBFlAzbHbiYTWKt2216zYobb94+0wRcsWbuMz1Zl/LN6vbjtT0G313YdTgVf60oUQZeGASqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173063; c=relaxed/simple;
	bh=GCUo1Xk02JN/TcsFOEXfGC7rEnRqBWxkbpmyl49gUY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXg6lq7L36SMsxYyliFRpimS48TTlWxKJc2/7Mf5NaP7ANV1VVGbeSS6wT8bIg9W4D25ePctekVP5AdEiQw/WyYfckT5iMrBl9w4NHFWWiJ8QI4gP34MWMwDQmGm8xLymxrDeaOaQBZEPusLJcsnvIgQ2bJ6FMW4n/U2X2gbpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGgwgf6g; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGgwgf6g"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aea4ebb048so6705ad.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773173061; x=1773777861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pouRMyraIJfJRyRFv87tQoZjJ+P4d5SAB0a9EGBIRqk=;
        b=BGgwgf6g9Ch2jh8xXwiD4EWfisLK87du4z7v94LHrFDyQoPsEUUU95b3fcdPq/H8v+
         I3YTvAnxFMX8V/3Hzq5uO8r775yaWA95P3tEbxBT3foq1DS1R1rN+RNqchcDmY6LgJRs
         EHZ29oaKiD5SwG9fiaFQstNVOjZQOGklQy5zrvgFUx2VBcygpDEZoK0tYH2fUmnP/bHu
         XA/oJxgPxLQO8B0ZMJVT06fI+UNTCYptZ6z/LSYLtw9SPelrSDpxwT93jFUYswhOP0iR
         jnOHeQqIK2ouj9sr6wHQVJK9L1VbgaRD0UVFJKR1WHkquBlFOr6CzA8zaDUDwrqR/cfL
         eYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173061; x=1773777861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pouRMyraIJfJRyRFv87tQoZjJ+P4d5SAB0a9EGBIRqk=;
        b=kQkU6B9ehGeFEFvWz2wIwBghpyMec0rOVHrwZcb41QDe1fOPZrPYmOc3toHZFp1zMO
         En58/xft3ahNYG7jiPNUqnLyjXJ0y/hLsEleAiMfaUWrspLRkshYuK7qeqS0tN6nwrgu
         0ubt00uoyuDxTHl/k9BNx0CPMelUDU2laB43c+ub7kbb+XGoKiBeVMRaWAfw8hTCvj0n
         n0NvzlhIeAAbekFGMsuMDgZAXrL6h2je9x6qSo1t4q8tl+Asl07RZdUCm7UUW7Ev9EAe
         Hey04jPL8GfFHAb7tipGc9vXOiTqo71kBykfTMCiurrcSCRBGnx4Hkj7uGi/Wt9ssIZ+
         Dp3w==
X-Forwarded-Encrypted: i=1; AJvYcCVLIXKs1HXWpb5UfKGhj+QvSkP/PhSdVdttUCExHOt1WgDvWv9rooeJsR48rbc/09lSd7JuDjvKds8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhI552gkjsU8jzxXA5GZolvLYBIBxYK+WDl0a9A7Ymlc6nPGx8
	9ocR7/0IAXTtOqTO27hPoTKSYqXrXU4HbkbdYs2q0fZTO+36B5avPqanrwPV6ea7yTZ0Q/+T5ym
	m2n3zD4hU
X-Gm-Gg: ATEYQzzLgB9reB9UDu5H144Yyd19fYIreSu+sfnJK4Lyzi4zxfpmSuCe+byxXN1DCla
	kyCcbbIs9Mn8FtnX9mDTPnWVGgJs6jm31Tufg2xxA6yYG/6urwCtTTdGOsD/INchXVcrDezUo/P
	qjciWmzhKCxOaI58JoOIyQ1d2N4Xz3pvLE6VBaxNtWXEn9shxX3rMCEFg8H4GJBcXoapX6uZOnG
	yB7zbXSXF8Tk32vpEK92EX2FZ/bXkl18IMhe46KwYt/4eXijO7WERxauz0byJCYCPr5ZtXaovhl
	BQfzK1EVkaa444mPsgRrjRof8gpHhKv9tO4Dxbyxx4dC0Ex4JAEHjaj1w8lFZ9e/rdvQKZTzA/G
	Zhn6dUaNYn/ALMXV3bNXYVERAlskxXJ01r2p1HU2MvgJkwq2zRHAC+fUeUgABF/WJnhJGaUUs58
	K9yDZI7+zPH16GD4dFntoCbETk21vuhboCSa1YIUEkfrrj1jOld8EzG8FiTw==
X-Received: by 2002:a17:902:cf12:b0:2a7:4151:2c74 with SMTP id d9443c01a7336-2aead3dfdfemr722415ad.16.1773173060930;
        Tue, 10 Mar 2026 13:04:20 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359ffdae223sm100059a91.0.2026.03.10.13.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:04:19 -0700 (PDT)
Date: Tue, 10 Mar 2026 20:04:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, bhelgaas@google.com, rafael@kernel.org,
	lenb@kernel.org, kees@kernel.org, baolu.lu@linux.intel.com,
	smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abB5PsFiBvCOjmnW@google.com>
References: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
 <aapgyXadT1TEz29u@Asurada-Nvidia>
 <20260306130202.GG1651202@nvidia.com>
 <abBzyKNZRzRykRV5@google.com>
 <abB3qt3QTroym7D+@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abB3qt3QTroym7D+@Asurada-Nvidia>

On Tue, Mar 10, 2026 at 12:57:30PM -0700, Nicolin Chen wrote:
> On Tue, Mar 10, 2026 at 07:40:56PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Mar 06, 2026 at 09:02:02AM -0400, Jason Gunthorpe wrote:
> > > On Thu, Mar 05, 2026 at 09:06:17PM -0800, Nicolin Chen wrote:
> > > > On Thu, Mar 05, 2026 at 09:33:47PM -0400, Jason Gunthorpe wrote:
> > > > > On Thu, Mar 05, 2026 at 05:29:22PM -0800, Nicolin Chen wrote:
> > > > > 
> > > > > > But arm_smmu_cmdq_issue_cmdlist() doesn't know when to push another
> > > > > > CMD. In my case where ATC_INV irq occurs, the return value from the
> > > > > > arm_smmu_cmdq_poll_until_sync() in the Step 5 is 0, and prods/cons
> > > > > > are also matched. Actually, at this point that NOP ISR has already
> > > > > > finished.
> > > > > 
> > > > > Yes, you'd need a sneaky way to convay the error from the ISR to the
> > > > > cmdlist code that didn't harm performance. Maybe we could come up with
> > > > > something, but if it works replacing the NOP with flush sounds fairly
> > > > > appealing - though can you do a single WORD edit to the STE that will
> > > > > block translated requests? Zero EATS?
> > > > 
> > > > Yea. I can give that a try.
> > > 
> > > This also really needs to go after the invalidation changes because it
> > > is feasible to also edit the lockless RCU invalidation list from the
> > > ISR and disable the ATC for the failed device too.
> > > 
> > > > > Also, will the SMMU start spamming with blocked translation events or
> > > > > something that will need suppression too?
> > > > 
> > > > CD.R=0 can suppress fault records, but we would need to override
> > > > that in every CD of the device.
> > > 
> > > That's too much to do from ISR, but maybe we can do it from a WQ..
> > > 
> > 
> > (Skimming through these, apologies if I'm losing context), shouldn't we
> > do all that (marking it as an inv STE / abort STE, suppressing the
> > faults) in the worker instead of trying to reset/recover the device?
> 
> EATS should be unset asap to avoid memory corruption. It's best
> to do in the unmap() context where the page isn't reclaimed yet
> by the kernel.
> 

Makes sense.

> Worker thread will be a bit late, but it is good enough for any
> further step.
>

Ack.
Praan

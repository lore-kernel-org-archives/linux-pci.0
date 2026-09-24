Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D82AD2E;
	Thu, 24 Sep 2026 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210736; cv=none; b=TAWQomhooH8hINgIl5ZZF04nGraCyptXjF0SRf594P+GJoSO+OLYaVH4hgLGRQLc3UWwGnrziaZKT6fYlmKqSrwqLTvbt4319JlOOUiyGByiQKidwrNBbppXQo6fKyOmhcSxBzMDPVDgF5PB3akveV+s86jrd3DrQLkRB7G3/NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210736; c=relaxed/simple;
	bh=79t5RkkZYdvzTFcS+J5j0DdwmcG5fi1lB3lXZq0WH94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C23lvvyYiSRK8G/E/g0EiLXTzn84d4eMQ8lVHQD3//vfs6FldYy180sFjVmi5BJa31wsA0W0VKUrOHLDK6WiemwUwzAbXeodkt3/ogrIVCigGvkEShn0l2xOAPqnQPTSkPondoBu7sUX5nuF2u2ezXFLDeFp8c3OiGK/vPqTBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSaPi0ke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSaPi0ke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CCF1F000FF;
	Thu, 24 Sep 2026 00:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790210735;
	bh=FTtLb8VyXEHloDep2vMebstVqQAsMPCB5frjs2I3Bw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RSaPi0keu4vF4ieaV8Vt8S3ry3mL0K450EOKK2AfwN47MP1fnblhj3WuOd37XnsFb
	 otwMPDIC2mfTNB8Xkh+wE5U4DcIlRQcc6oCeAUcrQOn2UIA9Fi0HLY2zMloow5bL8I
	 O027V8TX2aDWcdK5RRGeL/ux/+LhSnZpF6zgj6cJNb90CSs4SFiKR9+1gXxXUY++h8
	 b0Xl+I7uSCbbvsL5oQ0iC4ELZxOTbk9rFEQeVCdtvcMfBn/gbASWubR9MfcvQbOhlE
	 naTz0uS/V3XN0UkymcpuTVkDYkJ2TAYlbiH1MaPfdW3Sg6sCmugctIiONY77qgk70I
	 VLxwdCuXLP4gw==
Date: Thu, 24 Sep 2026 01:45:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
 <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v12 06/12] cxl: Add CXL Device Reset helper
Message-ID: <20260924014526.3cd5a375@jic23-hlaptop>
In-Reply-To: <9ea4b1cd-d801-486b-959a-47e6d1914005@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
	<20260910070808.1444264-7-smadhavan@nvidia.com>
	<20260912022617.47860862@jic23-hlaptop>
	<9ea4b1cd-d801-486b-959a-47e6d1914005@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:20:06 -0700
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> On 9/11/26 6:26 PM, Jonathan Cameron wrote:
> >> +     if (dvsec < 0)
> >> +             return dvsec;
> >> +
> >> +     if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> >> +         !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))  
> > Why do we need them both? Sure that's type 2, but a non
> > class code matching type3 would I think need the same infrastructure
> > you are building here. That would have cxl.mem but not cxl.cache
> > - I think some of the CXL SSD prototypes fit in this category.  
> 
> I did not yet address this in v13 because I did not want to expand the 
> series beyond its original Type 2 scope without settling the expected 
> eligibility policy first.
> 
> The current check requires both CXL.cache and CXL.mem capability and 
> both protocols to be enabled. The reset sequence currently assumes that 
> CXL.cache is active and performs cache disable, optional writeback, and 
> subsequent cache-policy restoration. This might need change.

Yes, we'd need to sanity check if CXL.cache is active.  Probably need to
do that anyway because we might have a situation where the driver code
isn't done for CXL.cache yet but CXL.mem is in use. I think that's
the case for Alejandro's device?

> 
> Is the current policies (HDM snapshot, range synchronization, and 
> restoration infrastrcture) adapted by these patches for cxl_reset also 
> apply directly for type 3? If so, I can generalize this. 

Yes. That should all apply as a type3+ is a just a type 2 that doesn't
support CXL.cache.

> But if Type 3 
> requires additional ownership or lifecycle handling, can we please 
> address that separately?
Agreed for anything new that is needed but I'm not sure what that would
be.

Jonathan

> 


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156529B79B;
	Thu, 24 Sep 2026 01:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212594; cv=none; b=WyJn+1JAd4oBoPkJPja2xlt6tfqRcNqH3KP5zVqREJ7LufWtW18nzcIlLUkJX/kR6tAQb57a+RfabX088FZp+7tUnku34OiMfZa/Q84fIsKivXatfFhCjqgmKipE6uGt9pPMhAd3uxOaXlt8J6EQBhH1h/sLZ0hIpEIqxBHrZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212594; c=relaxed/simple;
	bh=WNXO3Qvj0/OykGmRc8Bg5OyTAni44/frQa21v7j8pqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0dioTQ3XrvvbyxuUtYS7vfxmLz0ptxoXNY8vxF8ywilMdH8PhpkccNDsPMlbCMBmt2d49T0I86eA0N2nSbZtFkDhKI/JouGv3qfk5yeoSYiUFZpRyjRurmqeCsMjzk4n4xorboEOfHk5SZ8Ae7aCktpwrS5Vd14EWZIHE3W9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4PHbWJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4PHbWJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5D31F000FF;
	Thu, 24 Sep 2026 01:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212592;
	bh=0ycVhVuDyPqmjCBPLCgtCw6FqbKx/9+PpBpqOouT7t4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y4PHbWJ1/6E44/vSs+NJg6QRsH1fGiUZBSuYe0bhbAyGQVHcoctpftPF7JEJAhHu7
	 6B5BTluhltinWqTUdcUGREjOGmi6rARpo9i0Cc7HqmtN5CdceEsWfneqtW1m5itcRs
	 v6SWLSj/tpNmF/+qpx63SrqmBx/UmZ0sK4Vq1T3MWRCmeoS0UGhP8Xs5PT2mVSmXOP
	 BHrNwbekVhIb1qj1QuCiBtMUm9NCQAhy0KRrgmCDWmOi1b9c8Suk0YHpJFMPv87O7u
	 CdXFMeDKeg2D373YXC0OrVW7B8u5f3E2hv1/+gw/mziJlAvzMx39gLKpoRMQMyo+zR
	 0sirXMj86EB8Q==
Date: Thu, 24 Sep 2026 02:16:25 +0100
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
Subject: Re: [PATCH v13 01/15] cxl: Drop stale decoder interleave limit
 comment
Message-ID: <20260924021625.45c2d199@jic23-hlaptop>
In-Reply-To: <20260922083924.2451158-2-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-2-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 08:39:10 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> CXL 2.0 added 16-way memory interleaving, making the comment that the
> specification supports only 8-way interleaving stale. Remove the comment
> without changing CXL_DECODER_MAX_INTERLEAVE.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hlaptop/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04F335098
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702380; cv=none; b=mPNEcfa8dkIvdc1NWtUlf8kEFCR99+CGLR9QdttV5mcuPVsaXz2iFyXK+PAekqTnNcAhLzC33Dz1IUtbR8DzdoUXjCTSAxvqbd3W95vaJVIdUsrTtwiMVbTcisBLZ++uW2L1bjxaclt9W7dzPOyu2YH9e3Z18hs7+XfdLduCy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702380; c=relaxed/simple;
	bh=13C5Zk+FhoB0t1H0UpAuCva814AAeXat2a6Peo0FsAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIfFqaKnNyK95Kysyx9N78vtNjCu3umfh29k2XnaHOifdpo8WZCli6YCmpVDSLFL7DS96iRbYMIVlSPOHUB6HNFBbHfp24M6uR0tePsxkzLz/UDP9LhLQtYrVKpRHBSiLL6Udds0GVuGZKyNesheA0unbIndXIVtRvX0CCEYT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivky7Iay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivky7Iay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A034C19422;
	Thu, 29 Jan 2026 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769702380;
	bh=13C5Zk+FhoB0t1H0UpAuCva814AAeXat2a6Peo0FsAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ivky7IaypOEyEvKQ5QRhpEnDzjmFh/Z1bnc95qMKMc9kgeeQs6dPSk1OXllGHsAex
	 mcYA1pVUEBFNfoN2i9vzCORs3adSceoNVoRAFpndUu+708UvTfim+MHF3Z04JYrhO/
	 Z7Ons5GgnjrFtJLlMANIuVV6BvibAXoqJdQQ9m1SQ6moP0oYXeP6MH3X/O2vW+FGhD
	 MyRmCTjg49muOJr9DBxTys0Rzrxt34N/rL4UYj0jdIO8zzotWJVtXzv3qeiCGCQG6J
	 c8grT7OdcIt3GScUFm3ugjOhwK2eEVpki0jVvq094/Ly6LqmcZyrPVwLAuBCABknE6
	 Uma1fVvFX17fw==
Date: Thu, 29 Jan 2026 08:59:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex@shazbot.org, lukas@wunner.de,
	Dan Williams <dan.j.williams@intel.com>,
	Jinhui Guo <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH 2/2] pci: fix slot reset device locking
Message-ID: <aXuD6uYNIeYVJVL5@kbusch-mbp>
References: <aXpf0OkCsiw6kePd@kbusch-mbp>
 <20260128225359.GA437372@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128225359.GA437372@bhelgaas>

On Wed, Jan 28, 2026 at 04:53:59PM -0600, Bjorn Helgaas wrote:
> 
> I have no idea why the pci_slot_lock() hunk got applied in
> pci_slot_restore_locked().  I do notice that the line offsets in your
> patch are much different than mine, so you must have other changes in
> pci.c; maybe that accounts for the confusion.

Oh weird. I'd hope that patch just wouldn't have applied in that case
instead of appearing successful.

I was using a newer branch that also included some other fixes I'm
working on, so not surprised the line numbers didn't match up. I'll
rebase future patches to v6.19-rc1.
 
> Can you regenerate this patch based on v6.19-rc1?  And maybe
> incorporate Dan's "bridge = slot->bus->self" idea at the same time?

I've got a new proposal about ready that just drops the slot specific
lock/unlock and save/restore instead. We kind of need to do that since
slot reset breaks devices with more than 8 functions. I'll send the
patch with the details in a few minutes.

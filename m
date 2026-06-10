Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B4230BDB;
	Wed, 10 Jun 2026 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116368; cv=none; b=YlU8tofLy02yl9Cb2XFYVOytmNotjlFYBYNNZz931CfWZi40tCE0KOUhkF96uz9KVlqunVzA2mv7MMx5rp480Yklz9JxM5WpIukSntOUFD298uR2HrO9jQVJJ6Skpu3K0uVebfhHQWJQsbotWd4zDbHuZljxflqSj10Ma2XWfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116368; c=relaxed/simple;
	bh=TKOvpkWSiAS7b5th0YvBHsk/Cekxk5bwdMk6Ie758iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnlPO7DGmT+syUozDIND0Vap0UbKBeZwvN9ljE75h9sopuu34/p4H8yYkgvKsXyFgP1Ztz+sc39J3dcAYbeChWxdRVjwFGu3v2jbn6ME+P3rdN21ILu/joZUcE64JuJVOZzSQxkwUuc43iEpXx+c+I1PzjhD6ZBTxZlmUkn2e/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj9Pbd5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj9Pbd5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627C91F00893;
	Wed, 10 Jun 2026 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116367;
	bh=LlVd1CICzndplx6M5IsozYPz6Db/jaEab02kRkx/bZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bj9Pbd5bRiBasPgI5ZjHY9FIRwM7WWrFpwIO0inFTbHKirrP2xTA2XdCHAB7lXgvW
	 2NlD+920ghF8SlnXTeZyyYPxYdHL/4NVFSHivYJZKhR/mmkY9g7ZrT09GNLlO83RxA
	 goPnrj/xLah5pPJZIMXgMSCjltxBElImVblOs6XEk4eRpiEDrriRpgPuR3rQ//2utN
	 rn9Wjm99pJFPEhuv+VWONfauAPtu55v4EBteta4pxtZLkgcpmNLdIiyKsVLYVjahYD
	 +BIcowBsVvH8E2OGIZOfrosmORDK0zJUoEFX7fBrYBQIVdNdsfQXHcyYBn8mth7Gf9
	 Jz4r8sM83ZHhg==
Date: Wed, 10 Jun 2026 21:32:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Shivaji Kant <shivajikant@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [RFC PATCH 0/5] vfio/pci: Support ZONE_DEVICE-backed P2P
 Registration
Message-ID: <20260610183240.GJ327369@unreal>
References: <20260610151853.3608948-1-praan@google.com>
 <20260610162848.GO2764304@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610162848.GO2764304@ziepe.ca>

On Wed, Jun 10, 2026 at 01:28:48PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:
> 
> > Users utilize the standard sysfs p2pmem/allocate interface for managing
> > memory slices once a BAR is registered.
> 
> I'm shocked someone wants to use API, what are you expecting to do
> with it??

I was under impression what we all want to move from that API.

Thanks

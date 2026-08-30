Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD9202F70;
	Sun, 30 Aug 2026 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788081638; cv=none; b=EeFG/wK46Gkisj3iqK2z+y4C1gfVVO/qzSTb9IqNehK03daIr55d+ImVyM5REooZvSSQ9ckbmyr+VHiYDNRqGyQxX64sVIH4nEgH/mv723Yp916KZw04D72J3hOcNh9puoM0ie5in/e2YakQKJzAICnafJB/M03UtY+EkEhNLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788081638; c=relaxed/simple;
	bh=QncR1qUGWy+W3Pof34ojKH3irxh4p5y/PlIPK7O08j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHrOKnTjnKwobJmGJ85vHM1Q3nwSp3k1QV3uTIjpsLD20zIs8o021Nd7LaLhlWkWyaOl1rW3NLQPFfFH0DGAlTvCrHjHNtHLf0WmnvIceaSIbg8dxjRJz0hULkbZ94VypNEBF4DhW9EZV7b2sSlNiSt7kz6qldhnFcEk2OwjzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqUd2bEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqUd2bEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443131F000E9;
	Sun, 30 Aug 2026 09:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788081636;
	bh=2r5ATwh6+YU45/CW5aqnh5QdexD448pFy1trWFGs/4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YqUd2bEX4pBT0B78Scu66Uf1Ul20NzXAa6UUO7GTm2+NFPX8nTivh7uB+CYXIbrcq
	 NQRHi4GNBXk4/NXIyfjth1AC0okm6YHtqMYYnz/obpZ5lDZKQ9JEEXHNkz9BFBIWng
	 hu6MNhR1xW056ea73NSYrnfXC+5uFdWmVRyZGmbTivn1aLz3s+cyWpLk6S38V7v8PW
	 MNQkeVHZR0QoXqnLa2ftVUSmtdr55qVbyTLNDo95R7URlD7+D+KO8tqxYwXvNpwcF4
	 zqgS8LVIY6nfJGmEGHAlp4z74dCIj3sWn1SHc3nNphMnhR8clxnKROHEnNnrYocsbi
	 8IXp1kVh8ZtuA==
Date: Sun, 30 Aug 2026 12:20:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>
Subject: Re: [PATCH v4 10/18] PCI: Account for ACS egress control in
 isolation checks
Message-ID: <20260830092033.GE24140@unreal>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-10-94426b96de73@nvidia.com>
 <178761377056.3197084.2573998749847027711.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178761377056.3197084.2573998749847027711.b4-review@b4>

On Mon, Aug 24, 2026 at 08:22:50PM -0300, Jason Gunthorpe wrote:
> > pci_acs_enabled() treats P2P Request Redirect as effective whenever its
> > control bit is set. PCIe r7.0, sec 6.12.3, table 6-11 lets an enabled
> > Egress Control Vector override it: a clear vector bit routes the request
> > directly.
> 
> This may well all be correct, but I'd prefer not to touch grouping in
> this series working on p2pdma.. The grouping logic is already not
> doing a good job with the spec and we can't change it because it
> creates regression.

The longer we wait, the harder it will be to address this deviation
from the PCI specification.

Thanks

> 
> -- 
> Jason

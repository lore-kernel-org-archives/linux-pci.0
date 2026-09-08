Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4C377ABC;
	Tue,  8 Sep 2026 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846893; cv=none; b=nbs6MpBCZoE+Azh4ge10C472UR7F2Rf/WJbGaZZi9xbKCbUsIwmsPGAWaH8RY6VzwToQCmd2Tp9PiFrmbsI0vi22uF/+AeULmCNuzRA6GTL2+MYYmeSWfvab/CimvCq7xShlGTCW1e0T766fypvCefSjrvh7dvPU/cXz5n531cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846893; c=relaxed/simple;
	bh=MBJmQVJqxX6aK+6awq3pzu3jw/DZsBZS5EJ2UFfvQC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/yrKWxtLLQ5bC4as2mJfKr8eHudxNluTUIDdQTDoU7NyH895Ceo+WwDpR/O2TtIs8hMT78cjMo22BRU/T3Kj3FlurjfiDoLluIoFrJTtqo21L7cV8TdDXre03AixaCfFUWQQLgfqtNZ5W9p6DlVLmjBYrPQDpYQgCfheB6rARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEqZWkb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEqZWkb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA8F1F00A3A;
	Tue,  8 Sep 2026 05:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788846892;
	bh=nIm+Lg2Va+wlfCa6cfjaT6f0i6z4rymQBFcymRA2WLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TEqZWkb4t65cDfAWVoNA18xWZYGDq5gypt2W6UCxOcPR7r/oV5zNlIz2Ww2/EU7yL
	 YJIl2qPGRxD85gpnR20IwrZA8gAzB8DE6qHLbNoZU4DxcPWusJ/4AxomyosHHXc3Vf
	 7NsiVITRSW6fJRJTZnvQqk3JXrAi5aNfRsJCQlqHADiNvuyRV6wrolBJ5cHp99QxOh
	 INnaSTRQQ7u8EEP624WnL6kq+8dCq2ln8Pv8QYz5EiIcffoYjBDFEq4LvJw+QD4sit
	 RI69a02iIf1o4Ojv3tLS8laCN29Qamk9YIoGj3qI4hkhZ9CvA2VDOVh+ehYLP4pN4N
	 F2BU+dmtOIh6w==
Date: Tue, 8 Sep 2026 08:54:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tushar Dave <tdave@nvidia.com>,
	Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH 0/5] Batch of PCI peer-to-peer fixes
Message-ID: <20260908055447.GL13683@unreal>
References: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>

On Sun, Aug 30, 2026 at 02:16:18PM +0300, Leon Romanovsky wrote:
> Hi Bjorn,
> 
> These fixes come from my larger series that aligns the code with the PCI
> specification regarding the handling of ACS bits [1].
> 
> This series has already been reviewed by Logan and Jason.
> 
> Thanks,
> 
> [1] https://lore.kernel.org/all/20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com/
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Leon Romanovsky (5):
>       PCI/P2PDMA: Do not tear down the allocate attribute on registration failure
>       PCI/P2PDMA: Wait for RCU readers before freeing state
>       PCI/P2PDMA: Restrict the p2pmem search to pool backed providers
>       PCI/P2PDMA: Safely terminate ACS redirect lists
>       PCI/P2PDMA: Gate the host bridge whitelist warning on verbose
> 
>  drivers/pci/p2pdma.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> ---
> base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
> change-id: 20260830-batch-p2p-fixes-b73c10cdeff8

Bjorn,

Can we please make progress on this series? I need it to be applied so
that I can send my "Fix ACS ..." series with an upstream base commit.
This will allow Sashiko to apply and review it.

Thanks


> 
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
> 
> 

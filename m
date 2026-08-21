Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208B434E50;
	Fri, 21 Aug 2026 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354059; cv=none; b=Z8G8htzZs8T+S2gciIKDxM9IJ4WI1+LUlvO1j96zQiQfyzJeFnJtYy+n+W9H25Xklkx3VFNbyvd2TWO5pq/zNThxl8mqVveGxtuqAMewrXNtSm9ng42mx5Z7DW8qMLaRE1XhtTCoPfPzdnlTpW2X/wAO9Q0pNGqwoCeJN6/Zs3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354059; c=relaxed/simple;
	bh=5dJhUwIQ0ShxggTHeHuXAOM5Fk5puP0njq9eYk3Bq4Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=hMh4NPNbOA6C8EHCQwi8cnP0p2PHICbVt7V0n0gfh0yz45R8DWmkAL3U6OgQEykWvzIORmGWuYIZ+/5Mk9nToyCjWvJh0qHVlc3RX9qmx51k7Gx3VnBdaxpwRCqtJ7pWL7ySEzUQhLUZXRP9oSlI2UkRbXjYqCaRGwSM+aPfgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=DIMYo7Uk; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="DIMYo7Uk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=86/Qf1vqj0AKwvDRt7hJ1mzctyvDYacZ5+69BJIVUI0=; b=DIMYo7UkF+oJ3MWUQS/MmSY1KF
	coW0+F5/7xJrgBP2AFKmCfDwOlZp7agMzl6SshHk3XQAk+OlBIh6NKz0FQ1HL93W/8JEcmfPEkvf4
	mUwDaBnVuI2SJoMxWrPT8mIVwYuC53VywuI6km+CZau315hNSU7GzWAYtxVSlJaNw6Vb4uZmwgMA6
	dGHmYb5qIK0Ncob4aJRcIXK49Jjtdj2e+xE6VmG8PPW/q07ubjQrWh3/NjzbyHosVYQ2F8ZEUN4NQ
	/xv6cHck1vXUQ5oiRzb3hzSooqqf0iGa0Fyjk9cf63OJxEmbsaX9hkNPVK6a/2+NIAF78X7rU9aif
	FvsmbGhg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wxYRA-00000003EUV-34Z8;
	Fri, 21 Aug 2026 17:14:13 -0600
Message-ID: <cb89a5c9-d239-4314-b3e4-74098571bd96@deltatee.com>
Date: Fri, 21 Aug 2026 17:14:09 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-3-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-3-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 03/18] PCI/P2PDMA: Restrict the p2pmem search to pool
 backed providers
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> pci_p2pmem_find_many() exists to pick a provider that the caller will
> then allocate from with pci_alloc_p2pmem(), which goes straight to the
> gen_pool:
> 
> 	ret = (void *)gen_pool_alloc_owner(p2pdma->pool, size, (void **) &ref);
> 
> pci_has_p2pmem() does not ask for that pool, only for the published flag.
> The two used to be equivalent, because a provider could only exist by way
> of pci_p2pdma_add_resource(), which always creates the pool.
> 
> pcim_p2pdma_init() broke that. It registers a provider for the DMABUF
> path and never creates a pool, so pdev->p2pdma is set while
> p2pdma->pool stays NULL. Nothing publishes such a provider today, so the
> search cannot return one yet, but the flag alone no longer says what the
> caller needs.
> 
> Ask for the pool as well, so the search covers the providers its result
> is used for. A later patch documents the pdev->p2pdma lifetime and RCU
> rules.
> 
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Makes sense to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
